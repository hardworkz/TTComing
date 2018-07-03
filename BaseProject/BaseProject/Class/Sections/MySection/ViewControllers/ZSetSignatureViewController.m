//
//  ZSetSignatureViewController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/28.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZSetSignatureViewController.h"

@interface ZSetSignatureViewController ()

@property (nonatomic, strong) IWTextView *signature;

@property (nonatomic, strong) UIImageView *signatureBgView;

@property (nonatomic, strong) UIButton *saveBtn;
@end

@implementation ZSetSignatureViewController
#pragma mark - system
- (void)updateViewConstraints {
    WS(weakSelf)
    [self.signatureBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
        make.height.equalTo(200);
    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.signatureBgView.mas_bottom).offset(100);
        make.leading.equalTo(SCREEN_WIDTH * 0.2);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH * 0.6, 50));
    }];
    [super updateViewConstraints];
}
#pragma mark - private
- (void)z_addSubviews
{
    [self.view addSubview:self.signatureBgView];
    [self.view addSubview:self.saveBtn];
}
- (void)z_layoutNavigation
{
    [self hideNavigationBar:YES animated:NO];
    [self customNavigationBarWithTitle:@"简介" bgColor:white_color backBtn:@"icon_back_black" sel:nil rightBtn:nil sel:nil devider:NO];
}
- (UIImageView *)signatureBgView
{
    if (!_signatureBgView) {
        _signatureBgView = [[UIImageView alloc] initWithImage:[UIImage resizableImage:@"背景外发光"]];
        
        _signature = [[IWTextView alloc] init];
        _signature.placeholder = @"请输入您的简介";
        _signature.placeholderColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _signature.font = SYSTEM_FONT(15.0);
        [_signatureBgView addSubview:_signature];
        
        WS(weakSelf)
        [_signature mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.signatureBgView);
        }];
    }
    return _signatureBgView;
}
- (UIButton *)saveBtn
{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
        _saveBtn.layer.cornerRadius = 25;
        _saveBtn.titleLabel.font = SYSTEM_FONT(15.0);
        
        WS(weakSelf)
        [[_saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
        }];
    }
    return _saveBtn;
}
@end
