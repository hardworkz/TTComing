//
//  ZOrderPayView.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/22.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZOrderPayView.h"
#import "ZOrderPayViewModel.h"

@interface ZOrderPayView ()

@property (nonatomic, strong) ZView *contentView;

@property (nonatomic, strong) ZView *payView;

@property (nonatomic, strong) ZView *payBtnView;

@property (nonatomic, strong) ZOrderPayViewModel *viewModel;

@end
@implementation ZOrderPayView
#pragma mark - system

- (instancetype)initWithViewModel:(id<ZViewModelProtocol>)viewModel {
    
    self.viewModel = (ZOrderPayViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)updateConstraints {
    
    WS(weakSelf)
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(0, 0, kTabBarHeight, 0));
    }];
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.leading.equalTo(10);
        make.trailing.equalTo(-10);
        make.size.equalTo(CGSizeMake(SCREEN_WIDTH - 20, 15 + 20 + 30 + 75 + MARGIN_15));
    }];
    [self.payBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(kTabBarHeight);
        make.bottom.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark - private
- (void)z_setupViews {
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.payView];
    [self addSubview:self.payBtnView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)z_bindViewModel
{
    [self.viewModel.refreshDataCommand execute:nil];
    //
    @weakify(self);
    //
    [self.viewModel.refreshUI subscribeNext:^(id x) {
        
        @strongify(self);
    }];
}
#pragma mark - action
- (void)selectedPayType:(UIGestureRecognizer *)gesture
{
    
}
#pragma mark - lazyLoad
- (ZView *)contentView
{
    if (!_contentView) {
        _contentView = [[ZView alloc] init];
        
        UIImageView *logoIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"小形象图")];
        logoIcon.contentMode = UIViewContentModeCenter;
        [_contentView addSubview:logoIcon];
        
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.text = @"该订单时间";
        timeLabel.textColor = MAIN_TEXT_COLOR;
        timeLabel.textAlignment = NSTextAlignmentCenter;
        timeLabel.font = FONT(15);
        [_contentView addSubview:timeLabel];
        
        UILabel *time = [[UILabel alloc] init];
        time.text = @"29 : 59";
        time.textColor = MAIN_TEXT_COLOR;
        time.textAlignment = NSTextAlignmentCenter;
        time.font = FONT(15);
        [_contentView addSubview:time];
        
        UILabel *payLabel = [[UILabel alloc] init];
        payLabel.text = @"应付金额";
        payLabel.textColor = MAIN_TEXT_COLOR;
        payLabel.textAlignment = NSTextAlignmentLeft;
        payLabel.font = FONT(15);
        [_contentView addSubview:payLabel];
        
        UILabel *payPrice = [[UILabel alloc] init];
        payPrice.text = @"¥128";
        payPrice.textColor = MAIN_COLOR;
        payPrice.textAlignment = NSTextAlignmentRight;
        payPrice.font = FONT(17);
        [_contentView addSubview:payPrice];
        
        WS(weakSelf)
        [logoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.contentView);
            make.size.equalTo(CGSizeMake(50, 50));
            make.top.equalTo(weakSelf.contentView).offset(30);
        }];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(logoIcon).offset(50 + 10);
            make.leading.trailing.equalTo(0);
        }];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(timeLabel).offset(20);
            make.leading.trailing.equalTo(0);
        }];
        [payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(time).offset(20 + 30);
            make.leading.equalTo(30);
        }];
        [payPrice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(time).offset(20 + 30);
            make.trailing.equalTo(-30);
            make.width.equalTo(payLabel.mas_width);
        }];
    }
    return _contentView;
}
- (ZView *)payView
{
    if (!_payView) {
        _payView = [[ZView alloc] init];
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage resizableImage:@"支付方式背景外发光"]];
        [_payView addSubview:bgImageView];
        
        UILabel *payLabel = [[UILabel alloc] init];
        payLabel.text = @"支付方式";
        payLabel.textColor = MAIN_TEXT_COLOR;
        payLabel.textAlignment = NSTextAlignmentCenter;
        payLabel.font = FONT(15);
        [_payView addSubview:payLabel];
        
        UIImageView *wechatPayIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"微信")];
        wechatPayIcon.contentMode = UIViewContentModeCenter;
        [_payView addSubview:wechatPayIcon];
        
        UILabel *wechatPayLabel = [[UILabel alloc] init];
        wechatPayLabel.text = @"微信支付";
        wechatPayLabel.textColor = MAIN_TEXT_COLOR;
        wechatPayLabel.textAlignment = NSTextAlignmentLeft;
        wechatPayLabel.font = FONT(15);
        wechatPayLabel.tag = 10000;
        wechatPayLabel.userInteractionEnabled = YES;
        [[wechatPayLabel rac_signalForSelector:@selector(selectedPayType:)] subscribeNext:^(RACTuple * _Nullable x) {
            
        }];
        [_payView addSubview:wechatPayLabel];
        
        UIImageView *wechatPaySelectedIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"支付方式-未选中")];
        wechatPaySelectedIcon.contentMode = UIViewContentModeCenter;
        [_payView addSubview:wechatPaySelectedIcon];
        
        UIView *devider = [[UIView alloc] init];
        devider.backgroundColor = MAIN_LINE_COLOR;
        [_payView addSubview:devider];
        
        UIImageView *alipayIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"支付宝")];
        alipayIcon.contentMode = UIViewContentModeCenter;
        [_payView addSubview:alipayIcon];
        
        UILabel *alipayLabel = [[UILabel alloc] init];
        alipayLabel.text = @"支付宝支付";
        alipayLabel.textColor = MAIN_TEXT_COLOR;
        alipayLabel.textAlignment = NSTextAlignmentLeft;
        alipayLabel.font = FONT(15);
        alipayLabel.userInteractionEnabled = YES;
        alipayLabel.tag = 10001;
        [[alipayLabel rac_signalForSelector:@selector(selectedPayType:)] subscribeNext:^(RACTuple * _Nullable x) {
            
        }];
        [_payView addSubview:alipayLabel];
        
        UIImageView *alipaySelectedIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"支付方式-选中")];
        alipaySelectedIcon.contentMode = UIViewContentModeCenter;
        [_payView addSubview:alipaySelectedIcon];
        
        WS(weakSelf)
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.payView);
        }];
        [payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(bgImageView).offset(15);
            make.leading.trailing.equalTo(0);
        }];
        [wechatPayIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(MARGIN_20);
            make.top.equalTo(payLabel).offset(20 + 20);
            make.size.equalTo(CGSizeMake(20, 20));
        }];
        [wechatPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wechatPayIcon);
            make.leading.equalTo(wechatPayIcon.mas_trailing).offset(MARGIN_5);
            make.trailing.equalTo(- 30);
        }];
        [wechatPaySelectedIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(wechatPayIcon);
            make.trailing.equalTo(-MARGIN_20);
            make.size.equalTo(CGSizeMake(20, 20));
        }];
        [devider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(wechatPayIcon).offset(15 + 20);
            make.leading.equalTo(wechatPayIcon.mas_trailing);
            make.trailing.equalTo(-20);
            make.height.equalTo(1);
        }];
        [alipayIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(MARGIN_20);
            make.top.equalTo(devider).offset(MARGIN_20);
            make.size.equalTo(CGSizeMake(20, 20));
        }];
        [alipayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(alipayIcon);
            make.leading.equalTo(wechatPayIcon.mas_trailing).offset(MARGIN_5);
            make.trailing.equalTo(- 30);
        }];
        [alipaySelectedIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(alipayIcon);
            make.trailing.equalTo(-MARGIN_20);
            make.size.equalTo(CGSizeMake(20, 20));
        }];
        
    }
    return _payView;
}
- (ZView *)payBtnView
{
    if (!_payBtnView) {
        _payBtnView = [[ZView alloc] init];
        _payBtnView.backgroundColor = MAIN_BG_COLOR;
        
        UIButton *pay = [[UIButton alloc] init];
        [pay setTitle:@"去支付" forState:UIControlStateNormal];
        pay.titleLabel.font = FONT(15.0);
        pay.backgroundColor = MAIN_COLOR;
        pay.layer.cornerRadius = 17.5;
        WS(weakSelf)
        [[pay rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            //支付代码
        }];
        [_payBtnView addSubview:pay];
        
        [pay mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.payBtnView);
            make.leading.equalTo(60);
            make.trailing.equalTo(-60);
            make.height.equalTo(35);
        }];
    }
    return _payBtnView;
}
@end
