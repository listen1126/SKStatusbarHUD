//
//  SKStatusbarHUD.m
//  状态栏指示器
//
//  Created by Mr.listen on 16/5/13.
//  Copyright © 2016年 Mr.listen. All rights reserved.
//



#import "SKStatusbarHUD.h"

#define SKFont [UIFont systemFontOfSize:12]

@implementation SKStatusbarHUD
/*消息停留时间*/
static CGFloat const SKMessageDuration = 2.0;
/*消息显示/隐藏的动画时间*/
static CGFloat const SKAnimaitonDuration = 0.25;

/*全局窗口*/
static UIWindow * window_;

/*定时器*/
static NSTimer * timer_;

+(void)setWindow{
    //frame 数据
    CGFloat windowH = 20;
    CGRect frame = CGRectMake(0, -windowH, [UIScreen mainScreen].bounds.size.width, 20);
    
    //显示窗口
    window_.hidden = YES;//先让窗口隐藏起来，这样就不会出现窗口重影的问题了
    window_ = [[UIWindow alloc]init];
    window_.backgroundColor = [UIColor blackColor];
    window_.frame = frame;
    window_.hidden = NO;
    //窗口等级   当前最高等级
    window_.windowLevel = UIWindowLevelAlert;
    
    //添加动画
    frame.origin.y = 0 ;
    [UIView animateWithDuration:SKAnimaitonDuration animations:^{
        window_.frame = frame;
    }];
}

/*显示成功信息*/
+(void)showSuccess:(NSString * )msg{
    [self showMessage:msg image:[UIImage imageNamed:@"SKStatusbarHUD.bundle/check_24px_1181749_easyicon.net"]];
}
/*显示失败信息*/
+(void)showError:(NSString * )msg{
    [self showMessage:msg image:[UIImage imageNamed:@"SKStatusbarHUD.bundle/ Error_24px_1144918_easyicon.net"]];
}
/*显示loding信息*/
+(void)showLoding:(NSString * )msg{
    [timer_ invalidate];
    timer_ = nil;
    
    
    //显示窗口
    [self setWindow];
    //添加文字
    UILabel * lable = [[UILabel alloc]init];
    lable.font = SKFont;
    lable.frame = window_.bounds;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = msg;
    lable.textColor = [UIColor whiteColor];
    [window_ addSubview:lable];
    
    //添加加载小菊花
    
    UIActivityIndicatorView * loadView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadView startAnimating];
    
    //计算文字宽度
    CGFloat msgW = [msg sizeWithAttributes:@{NSFontAttributeName:SKFont}].width;//根据文字的内容计算出文字的高度
    CGFloat centerX = (window_.frame.size.width - msgW) * 0.5 - 20;
    CGFloat centerY = window_.frame.size.height * 0.5;
    loadView.center = CGPointMake(centerX, centerY);
    [window_ addSubview:loadView];
    
    
}
/*隐藏*/
+(void)dismiss{
[UIView animateWithDuration:SKAnimaitonDuration animations:^{
    CGRect frame = window_.frame;
    frame.origin.y = - window_.frame.size.height;
    window_.frame = frame;
} completion:^(BOOL finished) {
    window_ = nil;
    timer_ = nil;

}];
    
}

/*显示文字信息*/
+(void)showMessage:(NSString * )msg{
    [self showMessage:msg image:nil];
}

/*传图片和文字*/
+(void)showMessage:(NSString * )msg image:(UIImage *)image{
    //停止上一个定时器
    [timer_ invalidate];
    timer_ = nil;
    
    [self setWindow];
      //添加按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = window_.bounds;
    button.titleLabel.font = SKFont;
    [button setTitle:msg forState:UIControlStateNormal];
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
         //间距
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

    }
    [window_ addSubview:button];
    
    //定时消失
    
    timer_ =[NSTimer scheduledTimerWithTimeInterval:SKMessageDuration target:self selector:@selector(dismiss) userInfo:nil repeats:NO];
    
}

@end
