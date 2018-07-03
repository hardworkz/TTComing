//
//  ZMyView.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/5.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZMyView.h"
#import "ZMyViewModel.h"
#import "ZMyTableViewCell.h"

@interface ZMyView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) ZView *headerView;

@property (nonatomic, strong) ZMyViewModel *viewModel;

@property (nonatomic, strong) UIImageView *bgImageView
;
@property (nonatomic, strong) UIImageView *contentView;

@end
@implementation ZMyView
#pragma mark - system

- (instancetype)initWithViewModel:(id<ZViewModelProtocol>)viewModel {
    
    self.viewModel = (ZMyViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)updateConstraints {
    
    WS(weakSelf)
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark - private
- (void)z_setupViews {
    
    [self addSubview:self.mainTableView];
    [self addSubview:self.bgImageView];
    [self addSubview:self.contentView];
    self.mainTableView.tableHeaderView = self.headerView;

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)z_bindViewModel
{
    @weakify(self);
    [self.viewModel.refreshUI subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.mainTableView reloadData];
    }];
}
#pragma mark - action
- (void)headerTap:(UIGestureRecognizer *)gesture
{
    [self.viewModel.userIconClickSubject sendNext:nil];
}
#pragma mark - lazyLoad
- (ZMyViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZMyViewModel alloc] init];
    }
    
    return _viewModel;
}

- (UITableView *)mainTableView {
    
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = white_color;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //tableView页面无导航栏时，顶部出现44高度的空白解决方法
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_mainTableView registerClass:[ZMyTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZMyTableViewCell class])]];
    }
    
    return _mainTableView;
}
- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.2)];
        _bgImageView.image = ImageNamed(@"个人主页背景");
        _bgImageView.clipsToBounds = YES;
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    return _bgImageView;
}
- (UIImageView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIImageView alloc] initWithFrame:CGRectMake(5, SCREEN_HEIGHT * 0.2 - 55, SCREEN_WIDTH - 10, SCREEN_HEIGHT * 0.2 + 50)];
        _contentView.image = [UIImage resizableImage:@"头像信息背景外发光"];
        _contentView.userInteractionEnabled = YES;
        
        CGFloat userIconH = 100;
        
        UIImageView *userIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"小形象图")];
        userIcon.frame = CGRectMake((_contentView.width - userIconH) * 0.5, -userIconH * 0.5, userIconH, userIconH);
        userIcon.layer.cornerRadius = userIconH * 0.5;
        userIcon.clipsToBounds = YES;
        userIcon.backgroundColor = white_color;
        userIcon.contentMode = UIViewContentModeScaleAspectFill;
        [_contentView addSubview:userIcon];
        
        UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(userIcon.frame) + 5, _contentView.width, 25)];
        name.text = @"黄三岁";
        name.font = FONT(17.0);
        name.textAlignment = NSTextAlignmentCenter;
        name.textColor = MAIN_TEXT_COLOR;
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
            button.imageView.contentMode = UIViewContentModeCenter;
            [button setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
            [_contentView addSubview:button];
            WS(weakSelf)
            switch (i) {
                case 0:{
                    [button setTitle:@"待付款" forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@"待付款"] forState:UIControlStateNormal];
                    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                        [weakSelf.viewModel.orderClickSubject sendNext:@"waitPay"];
                    }];}
                    break;
                    
                case 1:{
                    [button setTitle:@"待收货" forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@"待收货"] forState:UIControlStateNormal];
                    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                        [weakSelf.viewModel.orderClickSubject sendNext:@"waitReceive"];
                    }];}
                    break;
                    
                case 2:{
                    [button setTitle:@"待留言" forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@"待留言"] forState:UIControlStateNormal];
                    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                        [weakSelf.viewModel.orderClickSubject sendNext:@"waitComment"];
                    }];}
                    break;
                    
                default:
                    break;
            }
        }
    }
    return _contentView;
}
- (ZView *)headerView
{
    if (!_headerView) {
        _headerView = [[ZView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.4)];
        [_headerView addSubview:self.bgImageView];
        [_headerView addSubview:self.contentView];
    }
    return _headerView;
}
#pragma mark - table datasource
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ZMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZMyTableViewCell class])] forIndexPath:indexPath];
    
    if (self.viewModel.dataArray.count > indexPath.row) {

        cell.viewModel = self.viewModel.dataArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.viewModel.cellClickSubject sendNext:[NSNumber numberWithInteger:indexPath.row]];
}
@end
