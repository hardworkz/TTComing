//
//  ZGoodsDetailController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/19.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZGoodsDetailController.h"

@interface ZGoodsDetailController ()

@property (nonatomic, strong) ZView *tooBarView;

@end

@implementation ZGoodsDetailController
#pragma mark - system
- (void)updateViewConstraints {
    
    WS(weakSelf)
    [super updateViewConstraints];
}

#pragma mark - private
- (void)z_addSubviews {
    [self.view addSubview:self.tooBarView];
}

- (void)z_bindViewModel {
    
}
- (void)z_layoutNavigation {
    [self hideNavigationBar:YES animated:NO];
    [self customNavigationBarWithTitle:@"拦精灵" bgColor:white_color backBtn:@"icon_back_black" sel:nil rightBtn:nil sel:nil];
}
#pragma mark - layzLoad
- (ZView *)tooBarView
{
    if (!_tooBarView) {
        _tooBarView = [[ZView alloc] initWithFrame:CGRectMake(0,SCREEN_HEIGHT - kTabBarHeight, SCREEN_WIDTH, kTabBarHeight)];
        
        MCButton *serviceButton = [[MCButton alloc] initWithFrame:CGRectMake(0, 0, 49, 49)];
        serviceButton.buttonStyle = imageTop;
        serviceButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [serviceButton setBackgroundColor:[UIColor lightGrayColor]];
        [serviceButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [serviceButton setTitle:@"客服" forState:UIControlStateNormal];
        [serviceButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_tooBarView addSubview:serviceButton];
        
        MCButton *collectionButton = [[MCButton alloc] initWithFrame:CGRectMake(49, 0, 49, 49)];
        collectionButton.buttonStyle = imageTop;
        collectionButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [collectionButton setBackgroundColor:[UIColor lightGrayColor]];
        [collectionButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [collectionButton setTitle:@"收藏" forState:UIControlStateNormal];
        [collectionButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_tooBarView addSubview:collectionButton];
        
        CGFloat buttonH = 36;
        
        UIButton *buyNowButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - (SCREEN_WIDTH * 2 / 3)*0.5, 7, (SCREEN_WIDTH * 2 / 3)*0.5, buttonH)];
        buyNowButton.titleLabel.font = BOLD_SYSTEM_FONT(15.0);
        [buyNowButton setBackgroundColor:MAIN_COLOR];
        [buyNowButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [buyNowButton setTitle:@"立即购买" forState:UIControlStateNormal];
        [buyNowButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        buyNowButton.layer.cornerRadius = 39 * 0.5;
        [_tooBarView addSubview:buyNowButton];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:buyNowButton.bounds      byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight    cornerRadii:CGSizeMake(buttonH * 0.5, buttonH * 0.5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = buyNowButton.bounds;
        maskLayer.path = maskPath.CGPath;
        buyNowButton.layer.mask = maskLayer;
        
        UIButton *addShoppingCartButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 20 - (SCREEN_WIDTH * 2 / 3), 7, (SCREEN_WIDTH * 2 / 3)*0.5, buttonH)];
        addShoppingCartButton.titleLabel.font = BOLD_SYSTEM_FONT(15.0);
        [addShoppingCartButton setBackgroundColor:MAIN_TEXT_COLOR];
        [addShoppingCartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [addShoppingCartButton setTitle:@"加入购物车" forState:UIControlStateNormal];
        [addShoppingCartButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
//        addShoppingCartButton.layer.cornerRadius = 39 * 0.5;
        [_tooBarView addSubview:addShoppingCartButton];
        
        UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:addShoppingCartButton.bounds      byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft    cornerRadii:CGSizeMake(buttonH * 0.5, buttonH * 0.5)];
        CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
        maskLayer2.frame = buyNowButton.bounds;
        maskLayer2.path = maskPath2.CGPath;
        addShoppingCartButton.layer.mask = maskLayer2;
    }
    return _tooBarView;
}
@end
