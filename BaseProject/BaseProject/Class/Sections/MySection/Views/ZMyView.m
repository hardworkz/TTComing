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
#import "ZMyHeadView.h"
#import "ZMyHeadViewModel.h"

@interface ZMyView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) ZMyViewModel *viewModel;

@property (nonatomic, strong) ZMyHeadView *headerView;

@property (nonatomic, strong) ZMyHeadViewModel *headViewModel;

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
- (ZMyHeadView *)headerView
{
    if (!_headerView) {
        _headerView = [[ZMyHeadView alloc] initWithViewModel:self.headViewModel];
        _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.4);
    }
    return _headerView;
}
- (ZMyHeadViewModel *)headViewModel
{
    if (!_headViewModel) {
        _headViewModel = [[ZMyHeadViewModel alloc] init];
    }
    return _headViewModel;
}
- (UITableView *)mainTableView {
    
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = MAIN_LIGHT_LINE_COLOR;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //tableView页面无导航栏时，顶部出现44高度的空白解决方法
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_mainTableView registerClass:[ZMyTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZMyTableViewCell class])]];
    }
    
    return _mainTableView;
}

#pragma mark - table datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.viewModel.sectionDataArray.count;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableArray *array = self.viewModel.sectionDataArray[section];
    return array.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ZMyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZMyTableViewCell class])] forIndexPath:indexPath];
    NSMutableArray *array = self.viewModel.sectionDataArray[indexPath.section];
    if (array.count > indexPath.row) {

        cell.viewModel = array[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.viewModel.cellClickSubject sendNext:nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
}
@end
