//
//  ZMyHeadView.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/20.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZMyHeadView.h"
#import "ZMyHeadViewModel.h"

@interface ZMyHeadView ()

@property (nonatomic, strong) UIImageView *bgImageView
;
@property (nonatomic, strong) ZView *contentView;

@property (nonatomic, strong) ZMyHeadViewModel *viewModel;

@end
@implementation ZMyHeadView

#pragma mark - system

- (instancetype)initWithViewModel:(id<ZViewModelProtocol>)viewModel {
    
    self.viewModel = (ZMyHeadViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

#pragma mark - private
- (void)z_setupViews {
    
    [self addSubview:self.bgImageView];
    [self addSubview:self.contentView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)z_bindViewModel
{
//    @weakify(self);
//    [self.viewModel.refreshUI subscribeNext:^(id  _Nullable x) {
//        @strongify(self);
//        [self.mainTableView reloadData];
//    }];
}
#pragma mark - action
- (void)headerTap:(UIGestureRecognizer *)gesture
{
    [self.viewModel.userIconClickSubject sendNext:nil];
}
#pragma mark - lazyLoad
- (ZMyHeadViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZMyHeadViewModel alloc] init];
    }
    
    return _viewModel;
}
- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.2)];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.backgroundColor = purple_color;
        
        
        UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        settingBtn.frame = CGRectMake(SCREEN_WIDTH - kTopBarHeight, kStatusBarHeight, kTopBarHeight, kTopBarHeight);
        settingBtn.imageView.contentMode = UIViewContentModeCenter;
        [settingBtn setImage:[UIImage imageNamed:@"icon_setting"] forState:UIControlStateNormal];
        WS(weakSelf)
        [[settingBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [weakSelf.viewModel.settingClickSubject sendNext:nil];
        }];
        [_bgImageView addSubview:settingBtn];
    }
    return _bgImageView;
}
- (ZView *)contentView
{
    if (!_contentView) {
        _contentView = [[ZView alloc] initWithFrame:CGRectMake(10, SCREEN_HEIGHT * 0.2 - 55, SCREEN_WIDTH - 20, SCREEN_HEIGHT * 0.2 + 50)];
        _contentView.backgroundColor = white_color;
        _contentView.layer.cornerRadius = 10;
        
        CGFloat userIconH = 100;
        
        UIImageView *userIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"")];
        userIcon.frame = CGRectMake((_contentView.width - userIconH) * 0.5, -userIconH * 0.5, userIconH, userIconH);
        userIcon.layer.cornerRadius = userIconH * 0.5;
        userIcon.clipsToBounds = YES;
        userIcon.contentMode = UIViewContentModeScaleAspectFill;
        userIcon.backgroundColor = green_color;
        [_contentView addSubview:userIcon];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(userIcon.frame) + 5, _contentView.width, 25)];
        name.text = @"黄三岁";
        name.font = FONT(17.0);
        name.textAlignment = NSTextAlignmentCenter;
        name.textColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        [_contentView addSubview:name];
        
        UILabel *sign = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(name.frame), _contentView.width, 20)];
        sign.text = @"哈哈哈哈哈哈哈哈哈哈哈";
        sign.font = FONT(14.0);
        sign.textAlignment = NSTextAlignmentCenter;
        sign.textColor = MAIN_TEXT_COLOR;
        [_contentView addSubview:sign];
        
        for (int i = 0; i<3; i++) {
            MCButton *button = [[MCButton alloc] initWithFrame:CGRectMake(_contentView.width / 3 * i, CGRectGetMaxY(sign.frame), _contentView.width / 3, _contentView.height - CGRectGetMaxY(sign.frame))];
            button.buttonStyle = imageTop;
            button.layer.cornerRadius = _contentView.layer.cornerRadius;
            button.titleLabel.font = [UIFont systemFontOfSize:15.0];
            [button setBackgroundColor:[UIColor lightGrayColor]];
            [button setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
            [_contentView addSubview:button];
            WS(weakSelf)
            switch (i) {
                case 0:{
                    [button setTitle:@"待付款" forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                        [weakSelf.viewModel.waitPayClickSubject sendNext:nil];
                    }];}
                    break;
                    
                case 1:{
                    [button setTitle:@"待收货" forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                        [weakSelf.viewModel.waitReceiveClickSubject sendNext:nil];
                    }];}
                    break;
                    
                case 2:{
                    [button setTitle:@"待留言" forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
                    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                        [weakSelf.viewModel.waitCommentClickSubject sendNext:nil];
                    }];}
                    break;
                    
                default:
                    break;
            }
        }
    }
    return _contentView;
}
@end
