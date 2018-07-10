//
//  ZShoppingCartView.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/20.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZShoppingCartView.h"
#import "ZShoppingCartTableViewCell.h"
#import "ZShoppingCartViewModel.h"

@interface ZShoppingCartView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;

@property (strong, nonatomic) UIView *editingView;
/**
 购物车全选按钮
 */
@property (nonatomic, strong) UIButton *selectAll;
/**
 结算按钮
 */
@property (nonatomic, strong) UIButton *settlel;
/**
 订单总价格
 */
@property (nonatomic, strong) UILabel *price;

@property (nonatomic, strong) ZView *headView;

@property (nonatomic, strong) ZShoppingCartViewModel *viewModel;

@property (nonatomic, strong) NSMutableArray *selectDataArray;

@end
@implementation ZShoppingCartView
#pragma mark - system

- (instancetype)initWithViewModel:(id<ZViewModelProtocol>)viewModel {
    
    self.viewModel = (ZShoppingCartViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)updateConstraints {
    
    WS(weakSelf)
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(kNavHeight, 0, 50, 0));
    }];
    
    [self.editingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(50);
        make.bottom.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark - private
- (void)z_setupViews {
    
    [self addSubview:self.mainTableView];
    self.mainTableView.tableHeaderView = self.headView;
    [self addSubview:self.editingView];
    
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
    [self.viewModel.deleteClickSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x isEqualToString:@"删除"]) {//进入删除状态
            [self.settlel setTitle:@"删除" forState:UIControlStateNormal];
            [self.settlel setTitleColor:white_color forState:UIControlStateNormal];
            self.settlel.backgroundColor = red_color;
            self.price.hidden = YES;
        }else{//结束删除状态
            [self.settlel setTitle:@"结算(0)" forState:UIControlStateNormal];
            [self.settlel setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
            self.settlel.backgroundColor = MAIN_COLOR;
            self.price.hidden = NO;
        }
    }];
}
#pragma mark - lazyLoad
- (NSMutableArray *)selectDataArray
{
    if (!_selectDataArray) {
        _selectDataArray = [NSMutableArray array];
    }
    return _selectDataArray;
}
- (ZShoppingCartViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZShoppingCartViewModel alloc] init];
    }
    
    return _viewModel;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] init];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        _mainTableView.editing = true;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.tableFooterView = [[UIView alloc] init];
        [_mainTableView registerClass:[ZShoppingCartTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZShoppingCartTableViewCell class])]];
    }
    return _mainTableView;
}
- (ZView *)headView
{
    if (!_headView) {
        _headView = [[ZView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _headView.backgroundColor = white_color;
        
        UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage resizableImage:@"背景外发光"]];
        [_headView addSubview:bgImage];
        
        UIImageView *logoIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"小形象图")];
        logoIcon.contentMode = UIViewContentModeCenter;
        [_headView addSubview:logoIcon];
        
        UILabel *title = [[UILabel alloc] init];
        title.text = @"悄悄告诉你！再满20可包邮哦~~~";
        title.textColor = lightGray_color;
        title.font = SYSTEM_FONT(15);
        [_headView addSubview:title];
        
        UIImageView *arrow = [[UIImageView alloc] initWithImage:ImageNamed(@"三角箭头")];
        arrow.contentMode = UIViewContentModeCenter;
        [_headView addSubview:arrow];
        
        WS(weakSelf)
        [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.headView);
        }];
        [logoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(MARGIN_10);
            make.size.equalTo(CGSizeMake(50, 50));
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.headView);
            make.leading.equalTo(logoIcon.mas_trailing).offset(MARGIN_10);
        }];
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(weakSelf.headView);
            make.size.equalTo(CGSizeMake(20, 20));
            make.trailing.equalTo(-MARGIN_5);
            make.leading.equalTo(title.mas_trailing).offset(MARGIN_10);
        }];
    }
    return _headView;
}
- (UIView *)editingView{
    if (!_editingView) {
        _editingView = [[UIView alloc] init];
        
        UIView *devider = [[UIView alloc] init];
        devider.backgroundColor = MAIN_LINE_COLOR;
        [_editingView addSubview:devider];
        [devider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(0);
            make.top.equalTo(0);
            make.height.equalTo(1);
        }];
        
        _settlel = [UIButton buttonWithType:UIButtonTypeCustom];
        _settlel.backgroundColor = MAIN_COLOR;
        [_settlel setTitle:@"结算(0)" forState:UIControlStateNormal];
        _settlel.titleLabel.font = SYSTEM_FONT(15.0);
        [_settlel setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
        [_settlel addTarget:self action:@selector(p__buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _settlel.layer.cornerRadius = 17.5;
        [_editingView addSubview:_settlel];
        WS(weakSelf)
        [_settlel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(-MARGIN_15);
            make.centerY.equalTo(weakSelf.editingView);
            make.height.equalTo(35);
            make.width.equalTo(100);
        }];
        
        
        _selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectAll setTitle:@"全选" forState:UIControlStateNormal];
        _selectAll.titleLabel.font = SYSTEM_FONT(14.0);
        _selectAll.titleEdgeInsets = UIEdgeInsetsMake(0, MARGIN_10, 0, 0);
        [_selectAll setImage:ImageNamed(@"未选中") forState:UIControlStateNormal];
        [_selectAll setImage:ImageNamed(@"选中") forState:UIControlStateSelected];
        [_selectAll setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
        [_selectAll addTarget:self action:@selector(p__buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_editingView addSubview:_selectAll];
        [_selectAll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(0);
            make.centerY.equalTo(weakSelf.editingView);
            make.height.equalTo(50);
            make.width.equalTo(100);
        }];
        
        _price = [[UILabel alloc] init];
        _price.text = @"¥128";
        _price.textColor = MAIN_TEXT_COLOR;
        _price.font = SYSTEM_FONT(15.0);
        _price.textAlignment = NSTextAlignmentRight;
        [_editingView addSubview:_price];
        [_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(weakSelf.settlel.mas_leading).offset(-MARGIN_15);
            make.leading.equalTo(weakSelf.selectAll.mas_trailing).offset(MARGIN_15);
            make.centerY.equalTo(weakSelf.editingView);
        }];
                                 
    }
    return _editingView;
}

#pragma mark - table datasource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    ZShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ZShoppingCartTableViewCell class])] forIndexPath:indexPath];
    //去除多选的时候cell的整体选中状态
    cell.multipleSelectionBackgroundView = [UIView new];
    
    if (self.viewModel.dataArray.count > indexPath.row) {
        
        cell.viewModel = self.viewModel.dataArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //添加选中的购物车商品数据
    [self.selectDataArray addObject:self.viewModel.dataArray[indexPath.row]];
    
    if (self.selectDataArray.count == self.viewModel.dataArray.count) {
        self.selectAll.selected = YES;
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //删除选中的购物车商品数据
    [self.selectDataArray removeObject:self.viewModel.dataArray[indexPath.row]];
    
    if (self.selectDataArray.count <= self.viewModel.dataArray.count) {
        self.selectAll.selected = NO;
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

#pragma mark - TableView 占位图

- (UIImage *)xy_noDataViewImage {
    return [UIImage imageNamed:@"购物车提示"];
}

- (NSString *)xy_noDataViewMessage {
    return @"";
}
//- (NSInteger)xy_noDataViewMessageLineNum {
//    return 2;
//}
//- (UIColor *)xy_noDataViewMessageColor {
//    return MAIN_LIGHT_GRAY_TEXT_COLOR;
//}

#pragma mark -- event response

- (void)p__buttonClick:(UIButton *)sender{
    if ([[sender titleForState:UIControlStateNormal] isEqualToString:@"删除"]) {
        NSMutableIndexSet *insets = [[NSMutableIndexSet alloc] init];
        [[self.mainTableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [insets addIndex:obj.row];
        }];
        [self.viewModel.dataArray removeObjectsAtIndexes:insets];
        [self.mainTableView deleteRowsAtIndexPaths:[self.mainTableView indexPathsForSelectedRows] withRowAnimation:UITableViewRowAnimationFade];
        
        /** 数据清空情况下取消编辑状态*/
        if (self.viewModel.dataArray.count == 0) {
            //            self.navigationItem.rightBarButtonItem.title = @"编辑";
            [self.mainTableView setEditing:NO animated:YES];
            [self showEitingView:NO];
            /** 带MJ刷新控件重置状态
             [self.tableView.footer resetNoMoreData];
             [self.tableView reloadData];
             */
            [self.mainTableView reloadData];
        }
        
    }else if (sender.selected == NO) {
        [self.viewModel.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.mainTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }];
        
        sender.selected = YES;
    }else if (sender.selected == YES){
        [self.mainTableView reloadData];
        /** 遍历反选
         [[self.tableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         [self.tableView deselectRowAtIndexPath:obj animated:NO];
         }];
         */
        
        sender.selected = NO;
    }
}

/**
 计算选中的订单总价格

 @param array 选中商品
 */
- (NSString *)calculateTotalPriceWithSelectedOrder:(NSArray *)array {
    return @"";
}
- (void)showEitingView:(BOOL)isShow{
    [self.editingView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(isShow?0:45);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}
@end
