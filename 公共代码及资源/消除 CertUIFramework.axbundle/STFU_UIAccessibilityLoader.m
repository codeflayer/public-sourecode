// When the `accessibility inspector' is enabled on the iOS Simulator the private `UIAccessibility'
// framework is loaded. In turn it will try to load a list of bundles amongst which is one that has
// only resources, no executable. This leads to `CFBundleLoadExecutableAndReturnError' logging this
// offending error message.
//
// This code omits the `SDK_ROOT/System/Library/AccessibilityBundles/CertUIFramework.axbundle'
// bundle from ever being attempted to load.
//
// This code is available under the MIT license: http://opensource.org/licenses/MIT
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <dlfcn.h>

#define ACCESSIBILITY_PATH @"/System/Library/PrivateFrameworks/UIAccessibility.framework"
#define APP_SUPPORT_PATH   @"/System/Library/PrivateFrameworks/AppSupport.framework/AppSupport"
#define COPY_PREFS_NAME    "CPCopySharedResourcesPreferencesDomainForDomain"

typedef CFStringRef (*CopyAppSupportPrefs)(CFStringRef);

@interface UIAccessibilityLoader : NSObject
// STFU compiler.
- (void)loadActualAccessibilityBundle:(NSBundle *)bundle
                              didLoad:(BOOL *)didLoad
                       loadSubbundles:(BOOL)loadSubbundles;
@end

@interface STFU_UIAccessibilityLoader : NSObject
@end

@implementation STFU_UIAccessibilityLoader

static Boolean
IsAccessibilityEnabled(NSString *sdkRoot)
{
  NSString *frameworkPath = [sdkRoot stringByAppendingPathComponent:APP_SUPPORT_PATH];
  void *appSupport = dlopen([frameworkPath fileSystemRepresentation], RTLD_LAZY);
  CopyAppSupportPrefs CopyPrefs = (CopyAppSupportPrefs)dlsym(appSupport, COPY_PREFS_NAME);
  
  if (CopyPrefs != NULL) {
    CFStringRef accessibilityDomain = CopyPrefs(CFSTR("com.apple.Accessibility"));
    if (accessibilityDomain != NULL) {
      Boolean enabled = CFPreferencesGetAppBooleanValue(CFSTR("ApplicationAccessibilityEnabled"),
                                                        accessibilityDomain, NULL);
      CFRelease(accessibilityDomain);
      return enabled;
    }
  }
  
  return false;
}

static BOOL
LoadAccessibilityFramework(NSString *sdkRoot)
{
  NSString *frameworkPath = [sdkRoot stringByAppendingPathComponent:ACCESSIBILITY_PATH];
  NSBundle *bundle = [NSBundle bundleWithPath:frameworkPath];
  return [bundle load];
}

- (void)STFU_loadActualAccessibilityBundle:(NSBundle *)bundle
                                   didLoad:(BOOL *)didLoad
                            loadSubbundles:(BOOL)loadSubbundles;
{
  if (bundle.executablePath == nil) {
    // No need to actually load this bundle which only contains localized resources.
    *didLoad = YES;
  } else {
    [self STFU_loadActualAccessibilityBundle:bundle
                                     didLoad:didLoad
                              loadSubbundles:loadSubbundles];
  }
}

+ (void)load;
{
  char *sdkPath = getenv("IPHONE_SIMULATOR_ROOT");
  if (sdkPath != NULL) {
    @autoreleasepool {
      NSString *sdkRoot = [NSString stringWithUTF8String:sdkPath];
      if (IsAccessibilityEnabled(sdkRoot) && LoadAccessibilityFramework(sdkRoot)) {
        Class loader = object_getClass(objc_getClass("UIAccessibilityLoader"));
        
        SEL originalSel = @selector(loadActualAccessibilityBundle:didLoad:loadSubbundles:);
        SEL swizzledSel = @selector(STFU_loadActualAccessibilityBundle:didLoad:loadSubbundles:);
        
        Method originalMethod = class_getInstanceMethod(loader, originalSel);
        Method swizzledMethod = class_getInstanceMethod(self, swizzledSel);
        
        if (originalMethod != NULL && swizzledMethod != NULL) {
          if (class_addMethod(loader,
                              swizzledSel,
                              method_getImplementation(swizzledMethod),
                              method_getTypeEncoding(swizzledMethod))) {
            method_exchangeImplementations(originalMethod, swizzledMethod);
          }
        }
      }
    }
  }
}

@end
