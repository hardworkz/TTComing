//
//  ZLoginViewController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/14.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZLoginViewController.h"

@interface ZLoginViewController ()<UIScrollViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) HMSegmentedControl *hmSegmentedControl;

@property (nonatomic, strong) ZView *loginView;

@property (nonatomic, strong) ZView *registerView;

@property (nonatomic, strong) UIImageView *bgView;


@property (nonatomic, strong) ACFloatingTextField *account;

@property (nonatomic, strong) ACFloatingTextField *password;

@property (nonatomic, strong) ACFloatingTextField *registerAccount;

@property (nonatomic, strong) ACFloatingTextField *registerPassword;

@property (nonatomic, strong) ACFloatingTextField *repeatPassword;

@property (nonatomic, strong) SubmitView *loginBtn;

@property (nonatomic, strong) SubmitView *registerBtn;

@end

@implementation ZLoginViewController
#pragma mark - system
- (void)updateViewConstraints
{
    WS(weakSelf)
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [super updateViewConstraints];
}
#pragma mark - private
- (void)z_addSubviews
{
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.contentScrollView];
    [self.view addSubview:self.hmSegmentedControl];
//    [self.view addSubview:self.segmentedControlLine];
    [self.contentScrollView insertSubview:self.loginView aboveSubview:self.bgView];
    [self.contentScrollView insertSubview:self.registerView aboveSubview:self.bgView];
    
    
    RegisterNotify(UITextFieldTextDidChangeNotification, @selector(textFieldDidChange:))
}
- (void)z_layoutNavigation
{
    [self hideNavigationBar:YES animated:NO];
}
#pragma mark - layzLoad
- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        _contentScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _contentScrollView.backgroundColor = clear_color;
        _contentScrollView.delegate = self;
        _contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * 2, SCREEN_HEIGHT);
        _contentScrollView.showsHorizontalScrollIndicator = NO;
        _contentScrollView.bounces = NO;
        _contentScrollView.pagingEnabled = YES;
        //指定控件是否只能在一个方向上滚动(默认NO)
        _contentScrollView.directionalLockEnabled = YES;
    }
    return _contentScrollView;
}
- (HMSegmentedControl *)hmSegmentedControl
{
    if (!_hmSegmentedControl) {
        _hmSegmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"登录",@"注册"]];
        _hmSegmentedControl.backgroundColor = clear_color;
        _hmSegmentedControl.frame = CGRectMake(0,  kY(122), SCREEN_WIDTH * 0.5, 40);
        _hmSegmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
        _hmSegmentedControl.selectionIndicatorColor = white_color;
        _hmSegmentedControl.selectionIndicatorHeight = 6;
        [_hmSegmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
        [_hmSegmentedControl setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
            NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName : white_color,NSFontAttributeName:BOLD_SYSTEM_FONT(18)}];
            return attString;
        }];
    }
    return _hmSegmentedControl;
}
- (ZView *)loginView
{
    if (!_loginView) {
        _loginView = [[ZView alloc] initWithFrame:CGRectMake(21, CGRectGetMaxY(self.hmSegmentedControl.frame) + 30, SCREEN_WIDTH - 2 * 21, (60 + 30 + 20)*2 + 60 + 46 + 60 + 30)];
        _loginView.backgroundColor = white_color;
        _loginView.layer.cornerRadius = 20;
        
        UIImageView *accountIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"请输入手机号")];
        accountIcon.contentMode = UIViewContentModeCenter;
        [_loginView addSubview:accountIcon];
        
        _account = [[ACFloatingTextField alloc] init];
        _account.delegate = self;
        _account.lineColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _account.selectedLineColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _account.placeHolderColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _account.selectedPlaceHolderColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _account.errorTextColor = red_color;
        _account.errorLineColor = red_color;
        _account.textColor = MAIN_TEXT_COLOR;
        _account.placeholder = @"请输入手机号码";
        _account.disableFloatingLabel = YES;
        [_loginView addSubview:_account];
        
        UIImageView *passwordIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"请输入密码")];
        passwordIcon.contentMode = UIViewContentModeCenter;
        [_loginView addSubview:passwordIcon];
        
        _password = [[ACFloatingTextField alloc] init];
        _password.delegate = self;
        _password.secureTextEntry = YES;
        _password.lineColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _password.selectedLineColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _password.placeHolderColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _password.selectedPlaceHolderColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _password.errorTextColor = red_color;
        _password.errorLineColor = red_color;
        _password.textColor = MAIN_TEXT_COLOR;
        _password.placeholder = @"请输入密码";
        _password.disableFloatingLabel = YES;
        [_loginView addSubview:_password];
        
        UIButton *rememberPwdBtn = [[UIButton alloc] init];
        [rememberPwdBtn setTitle:@"记住密码" forState:UIControlStateNormal];
        [rememberPwdBtn setTitleColor:MAIN_LIGHT_GRAY_TEXT_COLOR forState:UIControlStateNormal];
        [rememberPwdBtn setImage:ImageNamed(@"记住密码-未选择") forState:UIControlStateNormal];
        [rememberPwdBtn setImage:ImageNamed(@"记住密码") forState:UIControlStateSelected];
        rememberPwdBtn.titleLabel.font = FONT_NORMAL_14;
        [_loginView addSubview:rememberPwdBtn];
        
        UIButton *forgetPwdBtn = [[UIButton alloc] init];
        [forgetPwdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [forgetPwdBtn setTitleColor:MAIN_LIGHT_GRAY_TEXT_COLOR forState:UIControlStateNormal];
        forgetPwdBtn.titleLabel.font = FONT_NORMAL_14;
        [_loginView addSubview:forgetPwdBtn];
        
        _loginBtn = [[SubmitView alloc] initWithFrame:CGRectMake(100/3, _loginView.height - 46 - 30, _loginView.width - 100/3 * 2, 46)];
        _loginBtn.title = @"登录";
        WS(weakSelf)
        _loginBtn.clickedSubmitBlock = ^(SubmitButton *button) {
            //接口请求成功调用
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.loginBtn loadCompleteSuccess:^(id responseObject) {
                    [APPDELEGATE setTabbarController];
                }];
            });
        };
        [_loginView addSubview:_loginBtn];
        
        CGFloat padding = 10;
        [accountIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.loginView).offset(100/3);
            make.top.equalTo(weakSelf.loginView).offset(181/3 - 20);
            make.size.equalTo(CGSizeMake(30, 30));
        }];
        [_account mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(accountIcon);
            make.top.equalTo(accountIcon).offset(2 * padding);
            make.right.equalTo(weakSelf.loginView).offset(- 100/3);
            make.height.equalTo(60);
        }];
        [passwordIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(accountIcon);
            make.top.equalTo(accountIcon).offset(60 + 3 *padding);
            make.size.equalTo(CGSizeMake(30, 30));
        }];
        [_password mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(passwordIcon);
            make.top.equalTo(passwordIcon).offset(2 * padding);
            make.right.equalTo(weakSelf.loginView).offset(- 100/3);
            make.height.equalTo(60);
        }];
        [rememberPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(passwordIcon);
            make.top.equalTo(passwordIcon).offset(60 + 3 *padding);
            make.size.equalTo(CGSizeMake(120, 30));
        }];
        [forgetPwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(weakSelf.password);
            make.top.equalTo(passwordIcon).offset(60 + 3 *padding);
            make.size.equalTo(CGSizeMake(100, 30));
        }];
    }
    return _loginView;
}
//- (SubmitView *)loginBtn
//{
//    if (!_loginBtn) {
//        _loginBtn = [[SubmitView alloc] initWithFrame:CGRectMake(50, self.view.height * 0.5 - 50, SCREEN_WIDTH - 100, 50)];
//        WS(weakSelf)
//        _loginBtn.clickedSubmitBlock = ^(SubmitButton *button) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [weakSelf.subView loadCompletefailure];
//            });
//        };
//    }
//    return _loginBtn;
//}
- (ZView *)registerView
{
    if (!_registerView) {
        _registerView = [[ZView alloc] initWithFrame:CGRectMake(21 + SCREEN_WIDTH, self.loginView.y, SCREEN_WIDTH - 2 * 21, self.loginView.height)];
        _registerView.backgroundColor = white_color;
        _registerView.layer.cornerRadius = 20;
        
        UIImageView *accountIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"请输入手机号")];
        accountIcon.contentMode = UIViewContentModeCenter;
        [_registerView addSubview:accountIcon];
        
        _registerAccount = [[ACFloatingTextField alloc] init];
        _registerAccount.delegate = self;
        _registerAccount.lineColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _registerAccount.selectedLineColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _registerAccount.placeHolderColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _registerAccount.selectedPlaceHolderColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _registerAccount.errorTextColor = red_color;
        _registerAccount.errorLineColor = red_color;
        _registerAccount.textColor = MAIN_TEXT_COLOR;
        _registerAccount.placeholder = @"请输入手机号码";
        _registerAccount.disableFloatingLabel = YES;
        [_registerView addSubview:_registerAccount];
        
        UIImageView *passwordIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"请输入密码")];
        passwordIcon.contentMode = UIViewContentModeCenter;
        [_registerView addSubview:passwordIcon];
        
        _registerPassword = [[ACFloatingTextField alloc] init];
        _registerPassword.delegate = self;
        _registerPassword.secureTextEntry = YES;
        _registerPassword.lineColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _registerPassword.selectedLineColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _registerPassword.placeHolderColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _registerPassword.selectedPlaceHolderColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _registerPassword.errorTextColor = red_color;
        _registerPassword.errorLineColor = red_color;
        _registerPassword.textColor = MAIN_TEXT_COLOR;
        _registerPassword.placeholder = @"请输入密码";
        _registerPassword.disableFloatingLabel = YES;
        [_registerView addSubview:_registerPassword];
        
        UIImageView *repeatPasswordIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"请输入密码")];
        repeatPasswordIcon.contentMode = UIViewContentModeCenter;
        [_registerView addSubview:repeatPasswordIcon];
        
        _repeatPassword = [[ACFloatingTextField alloc] init];
        _repeatPassword.delegate = self;
        _repeatPassword.secureTextEntry = YES;
        _repeatPassword.lineColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _repeatPassword.selectedLineColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _repeatPassword.placeHolderColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _repeatPassword.selectedPlaceHolderColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        _repeatPassword.errorTextColor = red_color;
        _repeatPassword.errorLineColor = red_color;
        _repeatPassword.textColor = MAIN_TEXT_COLOR;
        _repeatPassword.placeholder = @"请再次输入密码";
        _repeatPassword.disableFloatingLabel = YES;
        [_registerView addSubview:_repeatPassword];
        
        _registerBtn = [[SubmitView alloc] initWithFrame:CGRectMake(100/3, _registerView.height - 46 - 30, _registerView.width - 100/3 * 2, 46)];
        _registerBtn.title = @"注册";
        WS(weakSelf)
        _registerBtn.clickedSubmitBlock = ^(SubmitButton *button) {
            //接口请求成功调用
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.registerBtn loadCompleteSuccess:^(id responseObject) {
                    [APPDELEGATE setTabbarController];
                }];
            });
        };
        [_registerView addSubview:_registerBtn];
        
        CGFloat padding = 10;
        [accountIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.registerView).offset(100/3);
            make.top.equalTo(weakSelf.registerView).offset(181/3 - 20);
            make.size.equalTo(CGSizeMake(30, 30));
        }];
        [_registerAccount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(accountIcon);
            make.top.equalTo(accountIcon).offset(2 * padding);
            make.right.equalTo(weakSelf.registerView).offset(- 100/3);
            make.height.equalTo(60);
        }];
        [passwordIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(accountIcon);
            make.top.equalTo(accountIcon).offset(60 + 3 *padding);
            make.size.equalTo(CGSizeMake(30, 30));
        }];
        [_registerPassword mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(passwordIcon);
            make.top.equalTo(passwordIcon).offset(2 * padding);
            make.right.equalTo(weakSelf.registerView).offset(- 100/3);
            make.height.equalTo(60);
        }];
        [repeatPasswordIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(passwordIcon);
            make.top.equalTo(passwordIcon).offset(60 + 3 *padding);
            make.size.equalTo(CGSizeMake(30, 30));
        }];
        [_repeatPassword mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(repeatPasswordIcon);
            make.top.equalTo(repeatPasswordIcon).offset(2 * padding);
            make.right.equalTo(weakSelf.registerView).offset(- 100/3);
            make.height.equalTo(60);
        }];
    }
    return _registerView;
}
- (UIImageView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] initWithImage:ImageNamed(@"登录背景")];
        _bgView.frame = self.view.bounds;
        _bgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgView;
}
#pragma mark - action
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    
    // segment滚到了这一页
    [self.contentScrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH * segmentedControl.selectedSegmentIndex, 0, SCREEN_WIDTH, SCREEN_HEIGHT) animated:YES];
}
- (void)textFieldDidChange:(NSNotification *)note {
    
    ACFloatingTextField *textField = note.object;
    if ([textField isEqual:self.account]) {
        if (textField.text.length > 11) {
            [textField showErrorWithText:@"输入的号码有误"];
        }
    }else{
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x/SCREEN_WIDTH == 0 ||scrollView.contentOffset.x/SCREEN_WIDTH == 1) {
        
        [self.hmSegmentedControl setSelectedSegmentIndex:(int)scrollView.contentOffset.x/SCREEN_WIDTH animated:YES];
    }
}
@end
