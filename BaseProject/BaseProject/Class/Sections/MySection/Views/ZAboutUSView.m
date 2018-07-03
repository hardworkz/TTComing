//
//  ZAboutUSView.m
//  BaseProject
//
//  Created by 泡果 on 2018/7/3.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZAboutUSView.h"
#import "ZAboutUSCell.h"
#import "ZAboutUSViewModel.h"

@interface ZAboutUSView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) ZView *headerView;

@property (nonatomic, strong) ZAboutUSViewModel *viewModel;

@end
@implementation ZAboutUSView
#pragma mark - system

- (instancetype)initWithViewModel:(id<ZViewModelProtocol>)viewModel {
    
    self.viewModel = (ZAboutUSViewModel *)viewModel;
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

#pragma mark - lazyLoad
- (ZAboutUSViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZAboutUSViewModel alloc] init];
    }
    
    return _viewModel;
}

- (UITableView *)mainTableView {
    
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = white_color;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //tableView页面无导航栏时，顶部出现44高度的空白解决方法
        if (@available(iOS 11.0, *)) {
            _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_mainTableView registerClass:[ZAboutUSCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZAboutUSCell class])]];
    }
    
    return _mainTableView;
}
- (ZView *)headerView
{
    if (!_headerView) {
        _headerView = [[ZView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.3)];
        
        UIImageView *logo = [[UIImageView alloc] initWithImage:ImageNamed(@"小形象图")];
        logo.contentMode = UIViewContentModeCenter;
        [_headerView addSubview:logo];
        
        UILabel *name = [[UILabel alloc] init];
        name.textColor = MAIN_TEXT_COLOR;
        name.font = SYSTEM_FONT(20);
        name.text = @"麦套";
        name.textAlignment = NSTextAlignmentCenter;
        [_headerView addSubview:name];
        
        WS(weakSelf)
        [logo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf.headerView);
            make.size.equalTo(CGSizeMake(100, 100));
        }];
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(weakSelf.headerView);
            make.top.equalTo(logo.mas_bottom);
        }];
    }
    return _headerView;
}
#pragma mark - table datasource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ZAboutUSCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZAboutUSCell class])] forIndexPath:indexPath];
    
    if (self.viewModel.dataArray.count > indexPath.row) {
        
        cell.viewModel = self.viewModel.dataArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.viewModel.cellClickSubject sendNext:[NSNumber numberWithInteger:indexPath.row]];
}

@end
