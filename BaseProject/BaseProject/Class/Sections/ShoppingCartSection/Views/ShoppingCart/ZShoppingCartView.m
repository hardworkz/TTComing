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

@property (nonatomic, strong) ZView *headView;

@property (nonatomic, strong) ZShoppingCartViewModel *viewModel;

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
        
        make.edges.equalTo(weakSelf).insets(UIEdgeInsetsMake(0, 0, 50, 0));
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
}
#pragma mark - lazyLoad
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
        
        UIButton *settlel = [UIButton buttonWithType:UIButtonTypeCustom];
        settlel.backgroundColor = MAIN_COLOR;
        [settlel setTitle:@"结算(0)" forState:UIControlStateNormal];
        settlel.titleLabel.font = SYSTEM_FONT(15.0);
        [settlel setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
        [settlel addTarget:self action:@selector(p__buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        settlel.layer.cornerRadius = 17.5;
        [_editingView addSubview:settlel];
        WS(weakSelf)
        [settlel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(-MARGIN_15);
            make.centerY.equalTo(weakSelf.editingView);
            make.height.equalTo(35);
            make.width.equalTo(100);
        }];
        
        
        UIButton *selectAll = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectAll setTitle:@"全选" forState:UIControlStateNormal];
        selectAll.titleLabel.font = SYSTEM_FONT(14.0);
        selectAll.titleEdgeInsets = UIEdgeInsetsMake(0, MARGIN_10, 0, 0);
        [selectAll setImage:ImageNamed(@"未选中") forState:UIControlStateNormal];
        [selectAll setImage:ImageNamed(@"选中") forState:UIControlStateSelected];
        [selectAll setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
        [selectAll addTarget:self action:@selector(p__buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_editingView addSubview:selectAll];
        [selectAll mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(0);
            make.centerY.equalTo(weakSelf.editingView);
            make.height.equalTo(50);
            make.width.equalTo(100);
        }];
        
        UILabel *price = [[UILabel alloc] init];
        price.text = @"¥128";
        price.textColor = MAIN_TEXT_COLOR;
        price.font = SYSTEM_FONT(15.0);
        price.textAlignment = NSTextAlignmentRight;
        [_editingView addSubview:price];
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(settlel.mas_leading).offset(-MARGIN_15);
            make.leading.equalTo(selectAll.mas_trailing).offset(MARGIN_15);
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
    [self.viewModel.cellClickSubject sendNext:nil];
    if (tableView.isEditing) {
        return;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}
// 设置 cell 是否允许移动
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    return true;
//}
// 移动 cell 时触发
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    // 移动cell之后更换数据数组里的循序
//    [self.viewModel.dataArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
//}
#pragma mark - TableView 占位图

- (UIImage *)xy_noDataViewImage {
    return [UIImage imageNamed:@"购物车提示"];
}

//- (NSString *)xy_noDataViewMessage {
//    return @"啊哦，你的购物车空空如也\n~~~";
//}
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
- (void)showEitingView:(BOOL)isShow{
    [self.editingView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(isShow?0:45);
    }];
    [UIView animateWithDuration:0.3 animations:^{
        [self layoutIfNeeded];
    }];
}
@end
