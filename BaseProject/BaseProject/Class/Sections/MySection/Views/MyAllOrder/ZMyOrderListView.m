//
//  ZMyOrderListView.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/25.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZMyOrderListView.h"
#import "ZMyOrderListViewModel.h"

@interface ZMyOrderListView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) ZMyOrderListViewModel *viewModel;

@property (nonatomic, strong) ZMyOrderTableViewCell *tempCell;

@end
@implementation ZMyOrderListView
#pragma mark - system

- (instancetype)initWithViewModel:(id<ZViewModelProtocol>)viewModel {
    
    self.viewModel = (ZMyOrderListViewModel *)viewModel;
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
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)z_bindViewModel
{
    
    [self.viewModel.refreshDataCommand execute:nil];
    
    @weakify(self);
    
    [self.viewModel.refreshUI subscribeNext:^(id x) {
        
        @strongify(self);
        [self.mainTableView reloadData];
    }];
    
    [self.viewModel.refreshEndSubject subscribeNext:^(id x) {
        @strongify(self);
        
        [self.mainTableView reloadData];
        
        switch ([x integerValue]) {
            case LSHeaderRefresh_HasMoreData: {
                
                [self.mainTableView.mj_header endRefreshing];
                
                if (self.mainTableView.mj_footer == nil) {
                    self.mainTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
                        @strongify(self);
                        [self.viewModel.nextPageCommand execute:nil];
                    }];
                }
            }
                break;
            case LSHeaderRefresh_HasNoMoreData: {
                
                [self.mainTableView.mj_header endRefreshing];
                self.mainTableView.mj_footer = nil;
            }
                break;
            case LSFooterRefresh_HasMoreData: {
                
                [self.mainTableView.mj_header endRefreshing];
                [self.mainTableView.mj_footer resetNoMoreData];
                [self.mainTableView.mj_footer endRefreshing];
            }
                break;
            case LSFooterRefresh_HasNoMoreData: {
                [self.mainTableView.mj_header endRefreshing];
                [self.mainTableView.mj_footer endRefreshingWithNoMoreData];
            }
                break;
            case LSRefreshError: {
                
                [self.mainTableView.mj_footer endRefreshing];
                [self.mainTableView.mj_header endRefreshing];
            }
                break;
                
            default:
                break;
        }
    }];
}
#pragma mark - lazyLoad
- (ZMyOrderListViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZMyOrderListViewModel alloc] init];
    }
    
    return _viewModel;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] init];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.estimatedRowHeight = 200; //预估行高 可以提高性能
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.tableFooterView = [[UIView alloc] init];
        [_mainTableView registerClass:[ZMyOrderTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZMyOrderTableViewCell class])]];
        WS(weakSelf)
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [weakSelf.viewModel.refreshDataCommand execute:nil];
        }];
        _mainTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            
            [weakSelf.viewModel.nextPageCommand execute:nil];
        }];
        
        // 创建计算cell高度的临时cell
        self.tempCell = [[ZMyOrderTableViewCell alloc] initWithStyle:0 reuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZMyOrderTableViewCell class])]];
    }
    return _mainTableView;
}

#pragma mark - table datasource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ZMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZMyOrderTableViewCell class])] forIndexPath:indexPath];
    
    if (self.viewModel.dataArray.count > indexPath.row) {
        
        cell.viewModel = self.viewModel.dataArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZMyOrderTableViewCellViewModel *viewModel = self.viewModel.dataArray[indexPath.row];
    if (viewModel.cellHeight == 0) {
        CGFloat cellHeight = [self.tempCell cellHeightForViewModel:self.viewModel.dataArray[indexPath.row]];
        
        // 缓存给model
        viewModel.cellHeight = cellHeight;
        
        return cellHeight;
    } else {
        return viewModel.cellHeight;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}

#pragma mark - TableView 占位图

- (UIImage *)xy_noDataViewImage {
    return [UIImage imageNamed:@"note_list_no_data"];
}

- (NSString *)xy_noDataViewMessage {
    return @"无相关订单喔！";
}
- (NSInteger)xy_noDataViewMessageLineNum {
    return 1;
}
- (UIColor *)xy_noDataViewMessageColor {
    return MAIN_LIGHT_GRAY_TEXT_COLOR;
}

@end
