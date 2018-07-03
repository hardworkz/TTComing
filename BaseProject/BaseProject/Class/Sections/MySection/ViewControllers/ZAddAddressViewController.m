//
//  ZAddAddressViewController.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/28.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZAddAddressViewController.h"
#import "ChooseLocationView.h"
#import "CitiesDataTool.h"

@interface ZAddAddressViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) ZView *contentView;

@property (nonatomic, strong) UITextField *received;

@property (nonatomic, strong) UITextField *phone;

@property (nonatomic, strong) UILabel *areaLabel;

@property (nonatomic, strong) IWTextView *addressDetail;

@property (nonatomic, strong) UIButton *saveBtn;

@property (nonatomic,strong) ChooseLocationView *chooseLocationView;

@property (nonatomic, strong) CustomBottomAlertContentView *alert;

@end

@implementation ZAddAddressViewController
#pragma mark - system
- (void)updateViewConstraints {
    WS(weakSelf)
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(kNavHeight);
        make.leading.trailing.equalTo(0);
        make.height.equalTo(240);
    }];
    [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView.mas_bottom).offset(50);
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[CitiesDataTool sharedManager] requestGetData];
}
- (void)z_layoutNavigation
{
    [self hideNavigationBar:YES animated:NO];
    [self customNavigationBarWithTitle:@"添加地址" bgColor:white_color backBtn:@"icon_back_black" sel:nil rightBtn:nil sel:nil devider:NO];
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
        
        for (int i = 0; i<4; i++) {
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = white_color;
            [bgView addSubview:view];
            if (i == 2) {
                [view addTapGestureWithTarget:self action:@selector(addressSelectTap)];
            }else{
            }
            
            UILabel *title = [[UILabel alloc] init];
            title.font = SYSTEM_FONT(15);
            title.textColor = MAIN_TEXT_COLOR;
            [view addSubview:title];
            
            UIView *text;
            if (i == 3) {
                text = [[IWTextView alloc] init];
                IWTextView *textView = (IWTextView *)text;
                textView.placeholder = @"街道，小区，楼牌号等";
                textView.placeholderColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
                textView.font = SYSTEM_FONT(15.0);
                textView.tintColor = MAIN_TEXT_COLOR;
                textView.textColor = MAIN_TEXT_COLOR;
                [view addSubview:textView];
            }else{
                if (i != 2) {
                    text = [[UITextField alloc] init];
                    UITextField *textField = (UITextField *)text;
                    textField.font = SYSTEM_FONT(15);
                    textField.textColor = MAIN_TEXT_COLOR;
                    textField.tintColor = MAIN_TEXT_COLOR;
                    [view addSubview:textField];
                }else{
                    text = [[UILabel alloc] init];
                    UILabel *label = (UILabel *)text;
                    label.font = SYSTEM_FONT(15);
                    label.textColor = MAIN_TEXT_COLOR;
                    [view addSubview:label];
                }
            }
            
            UIView *devider = [[UIView alloc] init];
            devider.backgroundColor = MAIN_LINE_COLOR;
            [view addSubview:devider];
            
            CGFloat height = 0;
            
            if (i == 3) {
                height = 60;
                devider.backgroundColor = clear_color;
            }else{
                height = 50;
                devider.backgroundColor = MAIN_LINE_COLOR;
            }
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.trailing.equalTo(0);
                make.top.equalTo(10 + i * 50);
                make.height.equalTo(height);
            }];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.equalTo(MARGIN_15);
                make.height.equalTo(50);
                make.width.equalTo(100);
                make.top.equalTo(0);
            }];
            [text mas_makeConstraints:^(MASConstraintMaker *make) {
                make.trailing.equalTo(-MARGIN_15);
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
                    title.text = @"收货人";
                    _received = (UITextField *)text;
                    break;
                case 1:
                    title.text = @"手机号码";
                    _phone = (UITextField *)text;
                    break;
                case 2:
                    title.text = @"地区";
                    _areaLabel = (UILabel *)text;
                    break;
                case 3:
                    title.text = @"详细地址";
                    _addressDetail = (IWTextView *)text;
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

#pragma mark - action
- (void)addressSelectTap {
    
    self.alert = [[CustomBottomAlertContentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.6)];
    self.alert.backgroundColor = [UIColor whiteColor];
    self.alert.alertHeight = SCREEN_HEIGHT * 0.6;
    self.alert.customView = self.chooseLocationView;
    [self.alert show];
    WS(weakSelf)
    self.alert.coverClickBlock = ^(NSInteger status) {
        [UIView animateWithDuration:0.25 animations:^{
            weakSelf.view.transform = CGAffineTransformIdentity;
        }];
    };
    
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformMakeScale(0.95, 0.95);
    }];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    CGPoint point = [gestureRecognizer locationInView:gestureRecognizer.view];
    if (CGRectContainsPoint(_chooseLocationView.frame, point)){
        return NO;
    }
    return YES;
}


- (void)tapCover:(UITapGestureRecognizer *)tap{
    
    if (_chooseLocationView.chooseFinish) {
        _chooseLocationView.chooseFinish();
    }
}

- (ChooseLocationView *)chooseLocationView{
    
    if (!_chooseLocationView) {
        _chooseLocationView = [[ChooseLocationView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 0.4, SCREEN_WIDTH, SCREEN_HEIGHT * 0.6)];
        
        WS(weakSelf)
        self.chooseLocationView.chooseFinish = ^{
            [UIView animateWithDuration:0.25 animations:^{
                weakSelf.areaLabel.text = weakSelf.chooseLocationView.address;
                weakSelf.view.transform = CGAffineTransformIdentity;
                [weakSelf.alert coverClick];
            }];
        };
    }
    return _chooseLocationView;
}
@end
