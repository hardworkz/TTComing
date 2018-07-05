//
//  ZSetPasswordViewController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/28.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZSetPasswordViewController.h"
#import "Xzb_CountDownButton.h"

@interface ZSetPasswordViewController ()

@property (nonatomic, strong) ZView *contentView;

@property (nonatomic, strong) UITextField *phone;

@property (nonatomic, strong) UITextField *code;

@property (nonatomic, strong) UITextField *password;

@property (nonatomic, strong) UIButton *saveBtn;

@end

@implementation ZSetPasswordViewController
#pragma mark - system
- (void)updateViewConstraints {
    WS(weakSelf)
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kNavHeight);
        make.leading.trailing.equalTo(0);
        make.height.equalTo(160);
    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_bottom).offset(100);
        make.leading.equalTo(SCREEN_WIDTH * 0.1);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH * 0.8, 40));
    }];
    [super updateViewConstraints];
}
#pragma mark - private
- (void)z_addSubviews
{
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.saveBtn];
}
- (void)z_layoutNavigation
{
    [self hideNavigationBar:YES animated:NO];
    [self customNavigationBarWithTitle:@"修改密码" bgColor:white_color backBtn:@"icon_back_black" sel:nil rightBtn:nil sel:nil devider:NO];
}
- (ZView *)contentView
{
    if (!_contentView) {
        _contentView = [[ZView alloc] init];
        _contentView.backgroundColor = white_color;
        
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage resizableImage:@"背景外发光"]];
        bgView.userInteractionEnabled = YES;
        [_contentView addSubview:bgView];
        
        WS(weakSelf)
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.contentView);
        }];
        
        for (int i = 0; i<3; i++) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = clear_color;
            [bgView addSubview:view];
            
            UILabel *title = [[UILabel alloc] init];
            title.font = SYSTEM_FONT(15);
            title.textColor = MAIN_TEXT_COLOR;
            [view addSubview:title];
            
            UITextField *textField = [[UITextField alloc] init];
            textField.font = SYSTEM_FONT(15);
            textField.textColor = MAIN_TEXT_COLOR;
            textField.tintColor = MAIN_TEXT_COLOR;
            [view addSubview:textField];
            
            UIView *devider = [[UIView alloc] init];
            devider.backgroundColor = MAIN_LINE_COLOR;
            [view addSubview:devider];
            
            if (i == 2) {
                devider.backgroundColor = clear_color;
            }else{
                devider.backgroundColor = MAIN_LINE_COLOR;
            }
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.trailing.equalTo(0);
                make.top.equalTo(5 + i * 50);
                make.height.equalTo(50);
            }];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(MARGIN_15);
                make.height.equalTo(50);
                make.width.equalTo(100);
                make.top.equalTo(0);
            }];
            UIView *Vdevider;
            if (i == 0) {
                Vdevider = [[UIView alloc] init];
                Vdevider.backgroundColor = MAIN_COLOR;
                [view addSubview:Vdevider];
                
                Xzb_CountDownButton *codeTimeBtn = [[Xzb_CountDownButton alloc] init];
                [codeTimeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [codeTimeBtn setTitleColor:MAIN_COLOR forState:UIControlStateNormal];
                codeTimeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
                [codeTimeBtn addTarget:self action:@selector(getCodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
                codeTimeBtn.index = 60;
                [view addSubview:codeTimeBtn];
                
                [codeTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.trailing.equalTo(-MARGIN_10);
                    make.top.equalTo(0);
                    make.bottom.equalTo(0);
                    make.width.equalTo(100);
                }];
                [Vdevider mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.trailing.equalTo(codeTimeBtn.mas_leading);
                    make.bottom.equalTo(-15);
                    make.width.equalTo(2);
                    make.top.equalTo(15);
                }];
            }
            
            [textField mas_makeConstraints:^(MASConstraintMaker *make) {
                if (i == 0) {
                    make.trailing.equalTo(Vdevider.mas_leading).offset(-MARGIN_15);
                }else
                {
                    make.trailing.equalTo(-MARGIN_15);
                }
                make.leading.equalTo(80);
                make.bottom.equalTo(-9);
                make.top.equalTo(9);
            }];
            [devider mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(view.mas_bottom).offset(-1);
                make.height.equalTo(1);
                make.leading.trailing.equalTo(0);
            }];
            
            switch (i) {
                case 0:
                    title.text = @"输入手机号";
                    _phone = textField;
                    break;
                case 1:
                    title.text = @"输入验证码";
                    _code = textField;
                    break;
                case 2:
                    title.text = @"输入新密码";
                    _password = textField;
                    break;
                    
                default:
                    break;
            }
        }
    }
    return _contentView;
}
- (UIButton *)saveBtn
{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
        _saveBtn.layer.cornerRadius = 20;
        _saveBtn.backgroundColor = MAIN_COLOR;
        _saveBtn.titleLabel.font = SYSTEM_FONT(15.0);
        
        WS(weakSelf)
        [[_saveBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
        }];
    }
    return _saveBtn;
}
- (void)getCodeBtnClicked:(Xzb_CountDownButton *)button {
    [button starWithGCD];
}
@end
