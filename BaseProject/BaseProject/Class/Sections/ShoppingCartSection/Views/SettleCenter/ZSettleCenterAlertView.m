//
//  ZSettleCenterAlertView.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/22.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZSettleCenterAlertView.h"
#import "ZSettleCenterAlertViewModel.h"
#import "ZSettleCenterTipTableViewCell.h"
#import "ZSettleCenterTipTableViewCellViewModel.h"

@interface ZSettleCenterAlertView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, strong) ZSettleCenterTipTableViewCell *tempCell;

@property (nonatomic, strong) ZSettleCenterAlertViewModel *viewModel;

@end
@implementation ZSettleCenterAlertView
#pragma mark - system

- (instancetype)initWithViewModel:(id<ZViewModelProtocol>)viewModel {
    
    self.viewModel = (ZSettleCenterAlertViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)updateConstraints {
    
    WS(weakSelf)
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(40, 0, 0, 0));
    }];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).offset(-10);
        make.top.equalTo(weakSelf).offset(10);
        make.size.equalTo(CGSizeMake(30, 30));
    }];
    [super updateConstraints];
}

#pragma mark - private
- (void)z_setupViews {
    
    [self addSubview:self.mainTableView];
    [self addSubview:self.closeBtn];
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
        [self.mainTableView reloadData];
    }];
}
#pragma mark - lazyLoad
- (ZSettleCenterAlertViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZSettleCenterAlertViewModel alloc] init];
    }
    
    return _viewModel;
}
- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] init];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.estimatedRowHeight = 200; //预估行高 可以提高性能
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.tableFooterView = [[UIView alloc] init];
        [_mainTableView registerClass:[ZSettleCenterTipTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZSettleCenterTipTableViewCell class])]];
        
        // 创建计算cell高度的临时cell
        self.tempCell = [[ZSettleCenterTipTableViewCell alloc] initWithStyle:0 reuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZSettleCenterTipTableViewCell class])]];
    }
    return _mainTableView;
}
- (UIButton *)closeBtn
{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setImage:ImageNamed(@"") forState:UIControlStateNormal];
        _closeBtn.imageView.contentMode = UIViewContentModeCenter;
        _closeBtn.backgroundColor = red_color;
        [[_closeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            
        }];
    }
    return _closeBtn;
}
#pragma mark - table datasource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ZSettleCenterTipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZSettleCenterTipTableViewCell class])] forIndexPath:indexPath];
    
    if (self.viewModel.dataArray.count > indexPath.row) {
        
        cell.viewModel = self.viewModel.dataArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZSettleCenterTipTableViewCellViewModel *viewModel = self.viewModel.dataArray[indexPath.row];
    if (viewModel.cellHeight == 0) {
        CGFloat cellHeight = [self.tempCell cellHeightForViewModel:self.viewModel.dataArray[indexPath.row]];
        
        // 缓存给model
        viewModel.cellHeight = cellHeight;
        ZLog(@"%f",cellHeight);
        return cellHeight;
    } else {
        return viewModel.cellHeight;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
