//
//  SKStatusbarHUD.h
//  状态栏指示器
//
//  Created by Mr.listen on 16/5/13.
//  Copyright © 2016年 Mr.listen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKStatusbarHUD : NSObject
/*显示文字信息
 msg : 文字信息
 image : 图片信息
 */
+(void)showMessage:(NSString * )msg image:(UIImage *)image;
/*显示文字信息*/
+(void)showMessage:(NSString * )msg;
/*显示成功信息*/
+(void)showSuccess:(NSString * )msg;
/*显示失败信息*/
+(void)showError:(NSString * )msg;
/*显示loding信息*/
+(void)showLoding:(NSString * )msg;
/*隐藏*/
+(void)dismiss;
@end
