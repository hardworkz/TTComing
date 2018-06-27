//
//  ZSettleCenterView.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/21.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZSettleCenterView.h"
#import "ZSettleCenterViewModel.h"
#import "ZSettleCenterContentCellViewModel.h"
#import "ZSettleCenterAddressTableViewCell.h"
#import "ZSettleCenterGoodsTableViewCell.h"
#import "ZSettleCenterDistributionTableViewCell.h"
#import "ZSettleCenterLeaveWordTableViewCell.h"

@interface ZSettleCenterView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) ZView *toolBarView;

@property (nonatomic, strong) ZView *numAndPriceFooterView;

@property (nonatomic, strong) ZSettleCenterViewModel *viewModel;

@end
@implementation ZSettleCenterView
#pragma mark - system

- (instancetype)initWithViewModel:(id<ZViewModelProtocol>)viewModel {
    
    self.viewModel = (ZSettleCenterViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)updateConstraints {
    
    WS(weakSelf)
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(0, 0, kTabBarHeight, 0));
    }];
    
    [self.toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@45);
        make.bottom.equalTo(weakSelf).offset(45 - kTabBarHeight);
    }];
    [super updateConstraints];
}

#pragma mark - private
- (void)z_setupViews {
    
    [self addSubview:self.mainTableView];
    self.mainTableView.tableFooterView = self.numAndPriceFooterView;
    [self addSubview:self.toolBarView];
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
- (ZSettleCenterViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZSettleCenterViewModel alloc] init];
    }
    
    return _viewModel;
}
- (ZView *)numAndPriceFooterView
{
    if (!_numAndPriceFooterView) {
        _numAndPriceFooterView = [[ZView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        
        UILabel *numAndPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        numAndPrice.text = @"¥128/2件";
        numAndPrice.textAlignment = NSTextAlignmentRight;
        numAndPrice.font = FONT(17);
        [_numAndPriceFooterView addSubview:numAndPrice];
    }
    return _numAndPriceFooterView;
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
        [_mainTableView registerClass:[ZSettleCenterAddressTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZSettleCenterAddressTableViewCell class])]];
        [_mainTableView registerClass:[ZSettleCenterGoodsTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZSettleCenterGoodsTableViewCell class])]];
        [_mainTableView registerClass:[ZSettleCenterDistributionTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZSettleCenterDistributionTableViewCell class])]];
        [_mainTableView registerClass:[ZSettleCenterLeaveWordTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZSettleCenterLeaveWordTableViewCell class])]];
    }
    return _mainTableView;
}
#pragma mark - table datasource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        ZSettleCenterAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZSettleCenterAddressTableViewCell class])] forIndexPath:indexPath];
        cell.hasAddress = YES;
        if (self.viewModel.dataArray.count > indexPath.row) {
            
            cell.viewModel = self.viewModel.dataArray[indexPath.row];
        }
        
        return cell;
    }else if (indexPath.row == 1) {
        ZSettleCenterGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZSettleCenterGoodsTableViewCell class])] forIndexPath:indexPath];
        
        if (self.viewModel.dataArray.count > indexPath.row) {
            
            cell.viewModel = self.viewModel.dataArray[indexPath.row];
        }
        
        return cell;
    }else if (indexPath.row == 2) {
        ZSettleCenterDistributionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZSettleCenterDistributionTableViewCell class])] forIndexPath:indexPath];
        
        if (self.viewModel.dataArray.count > indexPath.row) {
            
            cell.viewModel = self.viewModel.dataArray[indexPath.row];
        }
        
        return cell;
    }else {
        ZSettleCenterLeaveWordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZSettleCenterLeaveWordTableViewCell class])] forIndexPath:indexPath];
        
        if (self.viewModel.dataArray.count > indexPath.row) {
            
            cell.viewModel = self.viewModel.dataArray[indexPath.row];
        }
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 100;
    }else if (indexPath.row == 1) {
        return 150;
    }else if (indexPath.row == 2) {
        return 40;
    }else {
        return 40;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 2) {
        [self.viewModel.cellClickSubject sendNext:@"alert"];
    }else{
        [self.viewModel.cellClickSubject sendNext:nil];
    }
}

@end
