//
//  ZGoodsDetailView.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/26.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZGoodsDetailView.h"
#import "ZGoodsDetailViewModel.h"
#import "ZGoodsDetailCommentCell.h"
#import "ZGoodsDetailCommentCellViewModel.h"
#import "ZHomeListCollectionViewCell.h"
#import "ZHomeListCollectionViewCellViewModel.h"
#import "ZGoodsDetailImageCell.h"
#import "ZGoodsDetailImageCellViewModel.h"

@interface ZGoodsDetailView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (strong, nonatomic) UICollectionView *mainCollectionView;

@property (strong, nonatomic) UICollectionView *imageCollectionView;

@property (strong, nonatomic) UICollectionView *commentCollectionView;

@property (strong, nonatomic) ZGoodsDetailViewModel *viewModel;

@property (strong, nonatomic) ZView *headContentView;

@property (nonatomic, strong) ZView *imagePickerView;

@property (nonatomic, strong) ZView *goodsDetailView;

@property (nonatomic, strong) ZView *benefitsView;

@property (nonatomic, strong) ZView *commentHeadView;

@property (nonatomic, strong) ZView *instructionsView;

@end
@implementation ZGoodsDetailView

#pragma mark - system

- (instancetype)initWithViewModel:(id<ZViewModelProtocol>)viewModel {
    
    self.viewModel = (ZGoodsDetailViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)updateConstraints {
    
    WS(weakSelf)
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
    }];
    [super updateConstraints];
}

#pragma mark - private
- (void)z_setupViews {
    
    [self addSubview:self.mainCollectionView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
- (void)z_bindViewModel
{
    [self.viewModel.refreshDataCommand execute:nil];
    
    @weakify(self);
    
    [self.viewModel.refreshUI subscribeNext:^(id x) {
        
        @strongify(self);
        [self.mainCollectionView reloadData];
        [self.imageCollectionView reloadData];
        [self.commentCollectionView reloadData];
    }];
    
    [self.viewModel.refreshEndSubject subscribeNext:^(id x) {
        @strongify(self);
        
        [self.mainCollectionView reloadData];
        [self.imageCollectionView reloadData];
        [self.commentCollectionView reloadData];
        
        switch ([x integerValue]) {
            case LSHeaderRefresh_HasMoreData: {
                
                [self.mainCollectionView.mj_header endRefreshing];
                
                if (self.mainCollectionView.mj_footer == nil) {
                    self.mainCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                        @strongify(self);
                        [self.viewModel.nextPageCommand execute:nil];
                    }];
                }
            }
                break;
            case LSHeaderRefresh_HasNoMoreData: {
                
                [self.mainCollectionView.mj_header endRefreshing];
                self.mainCollectionView.mj_footer = nil;
            }
                break;
            case LSFooterRefresh_HasMoreData: {
                
                [self.mainCollectionView.mj_header endRefreshing];
                [self.mainCollectionView.mj_footer resetNoMoreData];
                [self.mainCollectionView.mj_footer endRefreshing];
            }
                break;
            case LSFooterRefresh_HasNoMoreData: {
                [self.mainCollectionView.mj_header endRefreshing];
                [self.mainCollectionView.mj_footer endRefreshingWithNoMoreData];
            }
                break;
            case LSRefreshError: {
                
                [self.mainCollectionView.mj_footer endRefreshing];
                [self.mainCollectionView.mj_header endRefreshing];
            }
                break;
                
            default:
                break;
        }
    }];
}
#pragma mark - lazyLoad
- (ZGoodsDetailViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZGoodsDetailViewModel alloc] init];
    }
    
    return _viewModel;
}
- (UICollectionView *)mainCollectionView
{
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //设置每个item的大小
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH * 0.5 - 5,242);
        //设置headerView的尺寸大小
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 770);
        //设置CollectionView的属性
        _mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
        _mainCollectionView.backgroundColor = white_color;
        _mainCollectionView.delegate = self;
        _mainCollectionView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _mainCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        //注册Cell
        [_mainCollectionView registerClass:[ZHomeListCollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZHomeListCollectionViewCell class])]];
        //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
        [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableGoodsDetailView"];
        
        WS(weakSelf)
        _mainCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [weakSelf.viewModel.refreshDataCommand execute:nil];
        }];
        _mainCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf.viewModel.nextPageCommand execute:nil];
        }];
    }
    return _mainCollectionView;
}
- (UICollectionView *)imageCollectionView
{
    if (!_imageCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //设置每个item的大小
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH,300);
        //设置CollectionView的属性
        _imageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300) collectionViewLayout:flowLayout];
        _imageCollectionView.backgroundColor = white_color;
        _imageCollectionView.delegate = self;
        _imageCollectionView.dataSource = self;
        _imageCollectionView.pagingEnabled = YES;
        if (@available(iOS 11.0, *)) {
            _imageCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        //注册Cell
        [_imageCollectionView registerClass:[ZGoodsDetailImageCell class] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZGoodsDetailImageCell class])]];
    }
    return _imageCollectionView;
}
- (UICollectionView *)commentCollectionView
{
    if (!_commentCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        //设置每个item的大小
        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH * 0.7,90);
        //设置CollectionView的属性
        _commentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100) collectionViewLayout:flowLayout];
        _commentCollectionView.backgroundColor = white_color;
        _commentCollectionView.delegate = self;
        _commentCollectionView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _commentCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        //注册Cell
        [_commentCollectionView registerClass:[ZGoodsDetailCommentCell class] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZGoodsDetailCommentCell class])]];
    }
    return _commentCollectionView;
}
- (ZView *)headContentView
{
    if (!_headContentView) {
        _headContentView = [[ZView alloc] init];
        _headContentView.backgroundColor = white_color;
        
        [_headContentView addSubview:self.imagePickerView];
        [_headContentView addSubview:self.goodsDetailView];
        [_headContentView addSubview:self.benefitsView];
        [_headContentView addSubview:self.commentHeadView];
        [_headContentView addSubview:self.commentCollectionView];
        [_headContentView addSubview:self.instructionsView];
        
        
        UILabel *title = [[UILabel alloc] init];
        title.text = @"您可能喜欢";
        title.textColor = MAIN_TEXT_COLOR;
        title.font = FONT(17);
        [_headContentView addSubview:title];
        
        WS(weakSelf)
        [self.imagePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(0);
            make.top.equalTo(weakSelf.headContentView);
            make.size.equalTo(CGSizeMake(SCREEN_WIDTH, 300));
        }];
        [self.goodsDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(0);
            make.top.equalTo(weakSelf.imagePickerView.mas_bottom).offset(MARGIN_20);
            make.height.equalTo(70);
        }];
        [self.benefitsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(0);
            make.top.equalTo(weakSelf.goodsDetailView.mas_bottom).offset(MARGIN_20);
            make.height.equalTo(80);
        }];
        [self.commentHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.leading.trailing.equalTo(0);
            make.top.equalTo(weakSelf.benefitsView.mas_bottom).offset(MARGIN_20);
            make.height.equalTo(30);
        }];
        [self.commentCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(0);
            make.top.equalTo(weakSelf.commentHeadView.mas_bottom);
            make.height.equalTo(90);
        }];
        [self.commentHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.leading.trailing.equalTo(0);
            make.top.equalTo(weakSelf.benefitsView.mas_bottom).offset(MARGIN_20);
            make.height.equalTo(80);
        }];
        [self.instructionsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(MARGIN_15);
            make.trailing.equalTo(-MARGIN_15);
            make.top.equalTo(weakSelf.commentCollectionView.mas_bottom).offset(MARGIN_20);
            make.height.equalTo(60);
        }];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(MARGIN_15);
            make.top.equalTo(weakSelf.instructionsView.mas_bottom).offset(MARGIN_20);
        }];
        
    }
    return _headContentView;
}
- (ZView *)imagePickerView
{
    if (!_imagePickerView) {
        _imagePickerView = [[ZView alloc] init];
        _imagePickerView.backgroundColor = white_color;
        //图片轮播控件
        [_imagePickerView addSubview:self.imageCollectionView];
        
        UILabel *indexImage = [[UILabel alloc] init];
        indexImage.text = @"1/3";
        indexImage.font = FONT(10);
        indexImage.textAlignment = NSTextAlignmentCenter;
        indexImage.textColor = white_color;
        indexImage.layer.cornerRadius = 10;
        indexImage.layer.masksToBounds = YES;
        indexImage.backgroundColor = COLOR(33, 33, 33, 0.5);
        [_imagePickerView addSubview:indexImage];
        
        WS(weakSelf)
        [self.imageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.imagePickerView);
        }];
        [indexImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(-MARGIN_10);
            make.bottom.equalTo(weakSelf.imagePickerView).offset(-MARGIN_10);
            make.size.equalTo(CGSizeMake(40, 20));
        }];
    }
    return _imagePickerView;
}
- (ZView *)goodsDetailView
{
    if (!_goodsDetailView) {
        _goodsDetailView = [[ZView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imagePickerView.frame) + MARGIN_20, SCREEN_WIDTH, 70)];
        
        UILabel *name = [[UILabel alloc] init];
        name.text = @"拦精灵";
        name.font = FONT(15);
        [_goodsDetailView addSubview:name];
        
        UILabel *description = [[UILabel alloc] init];
        description.text = @"整装 6 盒 特别推荐...";
        description.font = FONT(13);
        [_goodsDetailView addSubview:description];
        
        UILabel *price = [[UILabel alloc] init];
        price.text = @"¥128";
        price.font = FONT(17);
        [_goodsDetailView addSubview:price];
        
        WS(weakSelf)
        [name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(MARGIN_20);
            make.top.equalTo(weakSelf.goodsDetailView).offset(MARGIN_10);
            make.trailing.equalTo(MARGIN_20);
        }];
        [description mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(MARGIN_20);
            make.top.equalTo(name.mas_bottom);
            make.trailing.equalTo(MARGIN_20);
        }];
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(MARGIN_20);
            make.top.equalTo(description.mas_bottom).offset(MARGIN_5);
            make.trailing.equalTo(MARGIN_20);
        }];
    }
    return _goodsDetailView;
}
- (ZView *)benefitsView
{
    if (!_benefitsView) {
        _benefitsView = [[ZView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.goodsDetailView.frame) + MARGIN_20, SCREEN_WIDTH, 80)];
        _benefitsView.userInteractionEnabled = YES;
        
        UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage resizableImage:@"背景外发光"]];
        [_benefitsView addSubview:bgView];
        
        for (int i = 0; i<4; i++) {
            MCButton *button = [[MCButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 20)*0.25 * i, 20, (SCREEN_WIDTH - 20)*0.25, 50)];
            button.buttonStyle = imageTop;
            button.titleLabel.textColor = MAIN_TEXT_COLOR;
            button.imageView.contentMode = UIViewContentModeCenter;
            button.titleLabel.font = [UIFont systemFontOfSize:13.0];
            [button setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
            WS(weakSelf)
            [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                [weakSelf.viewModel.alertClickSubject sendNext:nil];
            }];
            [_benefitsView addSubview:button];
            switch (i) {
                case 0:
                    [button setTitle:@"正品保证" forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@"正品保证"] forState:UIControlStateNormal];
                    break;
                    
                case 1:
                    [button setTitle:@"隐私保证" forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@"隐私保证"] forState:UIControlStateNormal];
                    break;
                    
                case 2:
                    [button setTitle:@"无七天包退" forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@"无七天包退"] forState:UIControlStateNormal];
                    break;
                    
                case 3:
                    [button setTitle:@"货到付款" forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@"货到付款"] forState:UIControlStateNormal];
                    break;
                    
                default:
                    break;
            }
        }
        UIImageView *rightArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"三角箭头")];
        rightArrow.frame = CGRectMake(SCREEN_WIDTH - 20, 40, 20, 20);
        rightArrow.contentMode = UIViewContentModeCenter;
        [_benefitsView addSubview:rightArrow];
    
    }
    return _benefitsView;
}
- (ZView *)commentHeadView
{
    if (!_commentHeadView) {
        _commentHeadView = [[ZView alloc] init];
        
        UILabel *commentNum = [[UILabel alloc] init];
        commentNum.text = @"用户留言(688)";
        commentNum.font = FONT(17);
        [_commentHeadView addSubview:commentNum];
        
        UILabel *more = [[UILabel alloc] init];
        more.text = @"More";
        more.font = FONT(13);
        more.textAlignment = NSTextAlignmentRight;
        more.userInteractionEnabled = YES;
        [more addTapGestureWithTarget:self action:@selector(more)];
        [_commentHeadView addSubview:more];
        
        UIImageView *rightArrow = [[UIImageView alloc] initWithImage:ImageNamed(@"三角箭头")];
        rightArrow.frame = CGRectMake(SCREEN_WIDTH - 20, 40, 20, 20);
        rightArrow.contentMode = UIViewContentModeCenter;
        [_commentHeadView addSubview:rightArrow];
        
        WS(weakSelf)
        [commentNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(MARGIN_15);
            make.centerY.equalTo(weakSelf.commentHeadView);
        }];
        [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(0);
            make.centerY.equalTo(weakSelf.commentHeadView);
            make.size.equalTo(CGSizeMake(20, 20));
        }];
        [more mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(rightArrow.mas_leading);
            make.centerY.equalTo(weakSelf.commentHeadView);
        }];
    }
    return _commentHeadView;
}
- (ZView *)instructionsView
{
    if (!_instructionsView) {
        _instructionsView = [[ZView alloc] init];
        _instructionsView.layer.borderColor = MAIN_LIGHT_GRAY_TEXT_COLOR.CGColor;
        _instructionsView.layer.borderWidth = 1;
        
        
        UILabel *instructions = [[UILabel alloc] init];
        instructions.text = @"本品为一次性用品，如中途不慎滑落，应更换新的避孕套，使用本品时应小心，避免被尖锐物弄破";
        instructions.textColor = MAIN_LIGHT_GRAY_TEXT_COLOR;
        instructions.font = FONT(13);
        instructions.numberOfLines = 0;
        [_instructionsView addSubview:instructions];
        
        WS(weakSelf)
        [instructions mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf.instructionsView).insets(UIEdgeInsetsMake(MARGIN_10, MARGIN_10, MARGIN_10, MARGIN_10));
        }];
    }
    return _instructionsView;
}
#pragma mark - action
- (void)more {
    [self.viewModel.moreClickSubject sendNext:nil];
}

#pragma mark  设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([collectionView isEqual:self.mainCollectionView]) {
        return self.viewModel.dataArray.count;
    }else if ([collectionView isEqual:self.imageCollectionView]) {
        return self.viewModel.dataArray.count;
    }else{
        return self.viewModel.dataArray.count;
    }
}

#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:self.mainCollectionView]) {
        ZHomeListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZHomeListCollectionViewCell class])] forIndexPath:indexPath];
        
        cell.backgroundColor = randomColor;
        
        if (self.viewModel.dataArray.count > indexPath.item) {
            cell.viewModel = self.viewModel.dataArray[indexPath.item];
        }
        return cell;
    }else if ([collectionView isEqual:self.imageCollectionView]) {
        ZGoodsDetailImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZGoodsDetailImageCell class])] forIndexPath:indexPath];
        
        cell.backgroundColor = randomColor;
        
        if (self.viewModel.dataArray.count > indexPath.item) {
            cell.viewModel = self.viewModel.dataArray[indexPath.item];
        }
        return cell;
    }else{
        ZGoodsDetailCommentCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZGoodsDetailCommentCell class])] forIndexPath:indexPath];
        
        if (self.viewModel.dataArray.count > indexPath.item) {
            cell.viewModel = self.viewModel.dataArray[indexPath.item];
        }
        return cell;
    }
}

#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:self.mainCollectionView]) {
        return CGSizeMake(SCREEN_WIDTH * 0.5 - 5,242);
    }else if ([collectionView isEqual:self.imageCollectionView]) {
        return CGSizeMake(SCREEN_WIDTH,300);
    }else{
        return  CGSizeMake(SCREEN_WIDTH * 0.7,90);
    }
}
#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0 ,0, 0);//（上、左、下、右）
}
#pragma mark  定义每个UICollectionView的横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if ([collectionView isEqual:self.mainCollectionView]) {
        return 10;
    }else{
        return 0;
    }
}

#pragma mark  定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if ([collectionView isEqual:self.mainCollectionView]) {
        return 10;
    }else{
        return  0;
    }
}

#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:self.mainCollectionView]) {
        [self.viewModel.cellClickSubject sendNext:nil];
    }else if ([collectionView isEqual:self.imageCollectionView]) {
        [self.viewModel.cellClickSubject sendNext:nil];
    }else{
    }
}
#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([collectionView isEqual:self.mainCollectionView]||[collectionView isEqual:self.imageCollectionView]) {
        return YES;
//    }else{
//        return NO;
//    }
}
#pragma mark  设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([collectionView isEqual:self.mainCollectionView]) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableGoodsDetailView" forIndexPath:indexPath];
        headerView.backgroundColor =[UIColor grayColor];
        
        [headerView addSubview:self.headContentView];
        [self.headContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(headerView);
        }];
        
        return headerView;
    }
    return nil;
}
#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scroll) {
        self.scroll(scrollView.contentOffset.y);
    }
}
- (void) scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    //1.根据偏移量判断一下应该显示第几个item
    CGFloat offSetX = targetContentOffset->x;
    
    CGFloat itemWidth = SCREEN_WIDTH;
    
    //item的宽度+行间距 = 页码的宽度
    NSInteger pageWidth = itemWidth;
    
    //根据偏移量计算是第几页
    NSInteger pageNum = (offSetX+pageWidth/2)/pageWidth;
    
    ZLog(@"%ld",pageNum);
    //2.根据显示的第几个item，从而改变偏移量
//    targetContentOffset->x = pageNum*pageWidth;
//
//    self.currentIndex = pageNum;
    
}
@end