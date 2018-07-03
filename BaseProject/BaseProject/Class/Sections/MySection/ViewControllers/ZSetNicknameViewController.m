//
//  ZSetNicknameViewController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/28.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZSetNicknameViewController.h"

@interface ZSetNicknameViewController ()

@property (nonatomic, strong) UITextField *nickname;

@property (nonatomic, strong) ZView *nicknameView;

@property (nonatomic, strong) UIButton *saveBtn;
@end

@implementation ZSetNicknameViewController
#pragma mark - system
- (void)updateViewConstraints {
    WS(weakSelf)
    [self.nicknameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
        make.height.equalTo(100);
    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.nicknameView.mas_bottom).offset(100);
        make.leading.equalTo(SCREEN_WIDTH * 0.2);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH * 0.6, 50));
    }];
    [super updateViewConstraints];
}
#pragma mark - private
- (void)z_addSubviews
{
    [self.view addSubview:self.nicknameView];
    [self.view addSubview:self.saveBtn];
}
- (void)z_layoutNavigation
{
    [self hideNavigationBar:YES animated:NO];
    [self customNavigationBarWithTitle:@"我的昵称" bgColor:white_color backBtn:@"icon_back_black" sel:nil rightBtn:nil sel:nil devider:NO];
}
- (ZView *)nicknameView
{
    if (!_nicknameView) {
        _nicknameView = [[ZView alloc] init];
        
        UILabel *title = [[UILabel alloc] init];
        title.text = @"昵称是您在麦套里的唯一标识，请设置您独一无二的昵称";
        title.numberOfLines = 0;
        title.textColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        title.font = SYSTEM_FONT(15);
        [_nicknameView addSubview:title];
        
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage resizableImage:@"背景外发光"]];
        [_nicknameView addSubview:bgView];
        
        _nickname = [[UITextField alloc] init];
        _nickname.placeholder = @"昵称是由10个数字，字母或文字组成哟~";
        [_nickname setValue:MAIN_LIGHT_GRAY_TEXT_COLOR forKeyPath:@"_placeholderLabel.textColor"];
        _nickname.textColor = MAIN_TEXT_COLOR;
        [bgView addSubview:_nickname];
        
        WS(weakSelf)
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(MARGIN_15);
            make.trailing.equalTo(-MARGIN_15);
            make.top.equalTo(weakSelf.nicknameView);
            make.height.equalTo(50);
        }];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(0);
            make.top.equalTo(title.mas_bottom);
            make.height.equalTo(50);
        }];
        [_nickname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(MARGIN_15);
            make.trailing.equalTo(-MARGIN_15);
            make.top.equalTo(bgView);
            make.height.equalTo(50);
        }];
    }
    return _nicknameView;
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
