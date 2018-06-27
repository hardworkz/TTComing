//
//  ZOrderDetailView.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/25.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZOrderDetailView.h"
#import "ZOrderDetailViewModel.h"
#import "ZOrderDetailOrderStateTableViewCell.h"
#import "ZOrderDetailGoodsTableViewCell.h"
#import "ZOrderDetailDistributionTableViewCell.h"
#import "ZOrderDetailLeaveWordTableViewCell.h"
#import "ZOrderDetailAddressTableViewCell.h"

@interface ZOrderDetailView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) ZView *footerView;

@property (nonatomic, strong) ZOrderDetailViewModel *viewModel;

@end
@implementation ZOrderDetailView
#pragma mark - system

- (instancetype)initWithViewModel:(id<ZViewModelProtocol>)viewModel {
    
    self.viewModel = (ZOrderDetailViewModel *)viewModel;
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
    self.mainTableView.tableFooterView = self.footerView;
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
- (ZOrderDetailViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZOrderDetailViewModel alloc] init];
    }
    
    return _viewModel;
}
- (ZView *)footerView
{
    if (!_footerView) {
        _footerView = [[ZView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 140)];
        
        UILabel *numAndPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - MARGIN_10, 50)];
        numAndPrice.text = @"¥128/2件";
        numAndPrice.textAlignment = NSTextAlignmentRight;
        numAndPrice.font = FONT(17);
        [_footerView addSubview:numAndPrice];
        
        UILabel *orderNum = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_10, CGRectGetMaxY(numAndPrice.frame) + 50, SCREEN_WIDTH, 20)];
        orderNum.text = @"订单编号：88888888888";
        orderNum.font = FONT(13);
        orderNum.textAlignment = NSTextAlignmentLeft;
        [_footerView addSubview:orderNum];
        
        UILabel *createTime = [[UILabel alloc] initWithFrame:CGRectMake(MARGIN_10, CGRectGetMaxY(orderNum.frame), SCREEN_WIDTH, 20)];
        createTime.text = @"下单时间：2018.06.21 14:46:33";
        createTime.textAlignment = NSTextAlignmentLeft;
        createTime.font = FONT(13);
        [_footerView addSubview:createTime];
    }
    return _footerView;
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
        [_mainTableView registerClass:[ZOrderDetailOrderStateTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZOrderDetailOrderStateTableViewCell class])]];
        [_mainTableView registerClass:[ZOrderDetailGoodsTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZOrderDetailGoodsTableViewCell class])]];
        [_mainTableView registerClass:[ZOrderDetailDistributionTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZOrderDetailDistributionTableViewCell class])]];
        [_mainTableView registerClass:[ZOrderDetailLeaveWordTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZOrderDetailLeaveWordTableViewCell class])]];
        [_mainTableView registerClass:[ZOrderDetailAddressTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZOrderDetailAddressTableViewCell class])]];
    }
    return _mainTableView;
}
#pragma mark - table datasource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        ZOrderDetailOrderStateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZOrderDetailOrderStateTableViewCell class])] forIndexPath:indexPath];
        cell.hasTimeout = NO;
        if (self.viewModel.dataArray.count > indexPath.row) {
            
            cell.viewModel = self.viewModel.dataArray[indexPath.row];
        }
        
        return cell;
    }else if (indexPath.row == 1) {
        ZOrderDetailGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZOrderDetailGoodsTableViewCell class])] forIndexPath:indexPath];
        
        if (self.viewModel.dataArray.count > indexPath.row) {
            
            cell.viewModel = self.viewModel.dataArray[indexPath.row];
        }
        
        return cell;
    }else if (indexPath.row == 2) {
        ZOrderDetailDistributionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZOrderDetailDistributionTableViewCell class])] forIndexPath:indexPath];
        
        if (self.viewModel.dataArray.count > indexPath.row) {
            
            cell.viewModel = self.viewModel.dataArray[indexPath.row];
        }
        
        return cell;
    }else if (indexPath.row == 3) {
        ZOrderDetailLeaveWordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZOrderDetailLeaveWordTableViewCell class])] forIndexPath:indexPath];
        
        if (self.viewModel.dataArray.count > indexPath.row) {
            
            cell.viewModel = self.viewModel.dataArray[indexPath.row];
        }
        
        return cell;
    }else {
        ZOrderDetailAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZOrderDetailAddressTableViewCell class])] forIndexPath:indexPath];
        
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
    }else if (indexPath.row == 3){
        return 40;
    }else {
        return 100;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
