


//判断ios版本号
[[[UIDevice currentDevice] systemVersion] floatValue];
//判断是ipad还是iphone
[[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

//判断屏幕尺寸大小
[UIScreen mainScreen].bounds.size.height <= 480.0f)

if ([UIScreen mainScreen].bounds.size.height > 480.0f && [UIScreen mainScreen].bounds.size.height < 1024.0f) {
}
else if([UIScreen mainScreen].bounds.size.height <= 480.0f){
}
else if ([UIScreen mainScreen].bounds.size.height >= 1024.0f){
}