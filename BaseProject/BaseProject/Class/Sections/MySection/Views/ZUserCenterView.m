//
//  ZUserCenterView.m
//  BaseProject
//
//  Created by 泡果 on 2018/7/3.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZUserCenterView.h"
#import "ZUserCenterViewModel.h"
#import "ZUserCenterCell.h"

@interface ZUserCenterView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) ZUserCenterViewModel *viewModel;

@end
@implementation ZUserCenterView
#pragma mark - system

- (instancetype)initWithViewModel:(id<ZViewModelProtocol>)viewModel {
    
    self.viewModel = (ZUserCenterViewModel *)viewModel;
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
    @weakify(self);
    [self.viewModel.refreshUI subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.mainTableView reloadData];
    }];
}
#pragma mark - action

#pragma mark - lazyLoad
- (ZUserCenterViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZUserCenterViewModel alloc] init];
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
        [_mainTableView registerClass:[ZUserCenterCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZUserCenterCell class])]];
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
    
    ZUserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZUserCenterCell class])] forIndexPath:indexPath];
    
    NSMutableArray *array = self.viewModel.sectionDataArray[indexPath.section];
    if (array.count > indexPath.row) {
        
        cell.viewModel = array[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 70;
        }else{
            return 50;
        }
    }else{
        return 50;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.viewModel.cellClickSubject sendNext:[NSNumber numberWithInteger:indexPath.row]];
}
@end
