//
//  ZCommentListView.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/27.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZCommentListView.h"
#import "ZCommentListViewModel.h"
#import "ZCommentTableViewCellViewModel.h"
#import "ZCommentTableViewCell.h"

@interface ZCommentListView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) ZCommentListViewModel *viewModel;

@property (nonatomic, strong) ZCommentTableViewCell *tempCell;

@property (nonatomic, strong) ZView *headView;

@property (nonatomic, strong) UILabel *title;

@end
@implementation ZCommentListView
#pragma mark - system

- (instancetype)initWithViewModel:(id<ZViewModelProtocol>)viewModel {
    
    self.viewModel = (ZCommentListViewModel *)viewModel;
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
    self.mainTableView.tableHeaderView = self.headView;
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
- (ZView *)headView
{
    if (!_headView) {
        _headView = [[ZView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        
        _title = [[UILabel alloc] init];
        _title.textColor = MAIN_TEXT_COLOR;
        _title.font = BOLD_SYSTEM_FONT(17);
        _title.text = @"用户留言(588)";
        [_headView addSubview:_title];
        
        WS(weakSelf)
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.headView).insets(UIEdgeInsetsMake(0, MARGIN_15, 0, 0));
        }];
    }
    return _headView;
}
#pragma mark - action

#pragma mark - lazyLoad
- (ZCommentListViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZCommentListViewModel alloc] init];
    }
    
    return _viewModel;
}

- (UITableView *)mainTableView {
    
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] init];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = white_color;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //tableView页面无导航栏时，顶部出现44高度的空白解决方法
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_mainTableView registerClass:[ZCommentTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZCommentTableViewCell class])]];
        
        WS(weakSelf)
        _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [weakSelf.viewModel.refreshDataCommand execute:nil];
        }];
        _mainTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            
            [weakSelf.viewModel.nextPageCommand execute:nil];
        }];
        
        self.tempCell = [[ZCommentTableViewCell alloc] initWithStyle:0 reuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZCommentTableViewCell class])]];
    }
    
    return _mainTableView;
}
#pragma mark - table datasource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ZCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZCommentTableViewCell class])] forIndexPath:indexPath];
    
    if (self.viewModel.dataArray.count > indexPath.row) {
        
        cell.viewModel = self.viewModel.dataArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCommentTableViewCellViewModel *viewModel = self.viewModel.dataArray[indexPath.row];
    if (viewModel.cellHeight == 0) {
        CGFloat cellHeight = [self.tempCell cellHeightForViewModel:viewModel];
        
        // 缓存给model
        viewModel.cellHeight = cellHeight;
        
        return cellHeight;
    } else {
        return viewModel.cellHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.viewModel.cellClickSubject sendNext:[NSNumber numberWithInteger:indexPath.row]];
}
@end
