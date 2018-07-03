//
//  CustomBottomAlertContentView.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/22.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "CustomBottomAlertContentView.h"

@implementation CustomBottomAlertContentView
- (void)setCustomView:(UIView *)customView
{
    customView.frame = self.bounds;
    [self addSubview:customView];
}
-(UIView *)topView
{
    return [[[UIApplication sharedApplication] delegate] window];
}
- (void)show
{
    self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.alertHeight);
    [[self topView] addSubview:self];
    //添加遮盖
    UIButton *cover = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0;
    [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
    self.cover = cover;
    
    [[self topView] insertSubview:cover belowSubview:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        cover.alpha = 0.3;
        self.frame = CGRectMake(0, SCREEN_HEIGHT - self.alertHeight, SCREEN_WIDTH, self.alertHeight);
    }];
}
- (void)coverClick
{
    if (self.coverClickBlock) {
        self.coverClickBlock(0);
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.alertHeight);
        self.cover.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.cover removeFromSuperview];
        
    }];
}
@end
