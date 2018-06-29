//
//  ZHomeListView.m
//  BaseProject
//
//  Created by 泡果 on 2018/5/31.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZHomeListView.h"
#import "ZHomeListViewModel.h"
#import "ZHomeListCollectionViewCell.h"
#import "ZHomeListCollectionViewCellViewModel.h"
#import "ZHomeAdView.h"
#import "ZHomeAdViewModel.h"

@interface ZHomeListView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (strong, nonatomic) UICollectionView *mainCollectionView;

@property (strong, nonatomic) ZHomeListViewModel *viewModel;

@property (strong, nonatomic) ZHomeAdView *adView;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (strong, nonatomic) ZHomeAdViewModel *adViewModel;

@property (nonatomic, strong) ZView *buttonView;

@property (nonatomic, strong) ZView *dailySpecialView;

@property (nonatomic, strong) ZHomeListCollectionViewCell *tempCell;

@end
@implementation ZHomeListView

#pragma mark - system

- (instancetype)initWithViewModel:(id<ZViewModelProtocol>)viewModel {
    
    self.viewModel = (ZHomeListViewModel *)viewModel;
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
    }];
    
    [self.viewModel.refreshEndSubject subscribeNext:^(id x) {
        @strongify(self);
        
        [self.mainCollectionView reloadData];
        
        switch ([x integerValue]) {
            case LSHeaderRefresh_HasMoreData: {
                
                [self.mainCollectionView.mj_header endRefreshing];
                
//                if (self.mainCollectionView.mj_footer == nil) {
//                    self.mainCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//                        @strongify(self);
//                        [self.viewModel.nextPageCommand execute:nil];
//                    }];
//                }
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
- (ZHomeListViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZHomeListViewModel alloc] init];
    }
    
    return _viewModel;
}
- (UICollectionView *)mainCollectionView
{
    if (!_mainCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //设置每个item的大小
//        flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH * 0.5 - 5,242);
        //设置headerView的尺寸大小
        flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT - 30);
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
        [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        
        WS(weakSelf)
        _mainCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [weakSelf.viewModel.refreshDataCommand execute:nil];
        }];
//        _mainCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//
//            [weakSelf.viewModel.nextPageCommand execute:nil];
//        }];
        
        self.tempCell = [[ZHomeListCollectionViewCell alloc] init];
//        self.tempCell = [_mainCollectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZHomeListCollectionViewCell class])] forIndexPath:[NSIndexPath indexPathWithIndex:0]];
    }
    return _mainCollectionView;
}
- (ZHomeAdView *)adView
{
    if (!_adView) {
        _adView = [[ZHomeAdView alloc] initWithViewModel:self.adViewModel];
    }
    return _adView;
}
- (ZHomeAdViewModel *)adViewModel
{
    if (!_adViewModel) {
        _adViewModel = [[ZHomeAdViewModel alloc] init];
    }
    return _adViewModel;
}
- (ZView *)buttonView
{
    if (!_buttonView) {
        _buttonView = [[ZView alloc] init];
        
        for (int i = 0; i<4; i++) {
            MCButton *button = [[MCButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.25 * i, 0, SCREEN_WIDTH * 0.25, 100)];
            button.buttonStyle = imageTop;
            button.imageView.contentMode = UIViewContentModeCenter;
            button.titleLabel.font = [UIFont systemFontOfSize:15.0];
            [button setTitleColor:MAIN_TEXT_COLOR forState:UIControlStateNormal];
            
            [_buttonView addSubview:button];
            switch (i) {
                case 0:
                    [button setTitle:@"拦精灵" forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@"拦精灵"] forState:UIControlStateNormal];
                    break;
                    
                case 1:
                    [button setTitle:@"情趣衣" forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@"情趣衣"] forState:UIControlStateNormal];
                    break;
                    
                case 2:
                    [button setTitle:@"女用品" forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@"女用品"] forState:UIControlStateNormal];
                    break;
                    
                case 3:
                    [button setTitle:@"男用品" forState:UIControlStateNormal];
                    [button setImage:[UIImage imageNamed:@"男用品"] forState:UIControlStateNormal];
                    break;
                    
                default:
                    break;
            }
        }
    }
    return _buttonView;
}
- (ZView *)dailySpecialView
{
    if (!_dailySpecialView) {
        _dailySpecialView = [[ZView alloc] init];
        _dailySpecialView.backgroundColor = white_color;
        
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage resizableImage:@"6381530175663_.pic"]];
        bgImageView.frame = CGRectMake(MARGIN_10, MARGIN_20, SCREEN_WIDTH - MARGIN_10*2, 200 - 30);
        [_dailySpecialView addSubview:bgImageView];
        
        UIImageView *contentImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"4")];
        contentImageView.frame = CGRectMake(MARGIN_15 + MARGIN_10, - MARGIN_15, 160 * 350/430, 200 - 40);
        contentImageView.clipsToBounds = YES;
        contentImageView.contentMode = UIViewContentModeScaleAspectFill;
        [bgImageView addSubview:contentImageView];
        
    }
    return _dailySpecialView;
}
- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:ImageNamed(@"背景")];
        _bgImageView.backgroundColor = white_color;
        _bgImageView.clipsToBounds = YES;
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _bgImageView;
}
#pragma mark  设置CollectionView的组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark  设置CollectionView每组所包含的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.dataArray.count;
}

#pragma mark  设置CollectionCell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZHomeListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ZHomeListCollectionViewCell class])] forIndexPath:indexPath];
    
    if (self.viewModel.dataArray.count > indexPath.item) {
        cell.viewModel = self.viewModel.dataArray[indexPath.item];
    }
    return cell;
}

#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZHomeListCollectionViewCellViewModel *viewModel = self.viewModel.dataArray[indexPath.row];
    if (viewModel.cellHeight == 0) {
        CGFloat cellHeight = [self.tempCell cellHeightForViewModel:viewModel];
        
        // 缓存给model
        viewModel.cellHeight = cellHeight;
        
        return CGSizeMake(SCREEN_WIDTH * 0.5 - 5,cellHeight);
    } else {
        return CGSizeMake(SCREEN_WIDTH * 0.5 - 5,viewModel.cellHeight);
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
    return 10;
}

#pragma mark  定义每个UICollectionView的纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

#pragma mark  点击CollectionView触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.viewModel.cellClickSubject sendNext:nil];
}

#pragma mark  设置CollectionViewCell是否可以被点击
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark  设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    headerView.backgroundColor = white_color;
    
    self.bgImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.5);
    [headerView addSubview:self.bgImageView];
    
    self.adView.frame = CGRectMake(0, SCREEN_HEIGHT * 0.325, SCREEN_WIDTH, SCREEN_HEIGHT * 0.25);
    [headerView addSubview:self.adView];
    
    self.buttonView.frame = CGRectMake(0, CGRectGetMaxY(self.adView.frame) - 40, SCREEN_WIDTH, 100);
    [headerView addSubview:self.buttonView];
    
    self.dailySpecialView.frame = CGRectMake(0, CGRectGetMaxY(self.buttonView.frame), SCREEN_WIDTH, 200);
    [headerView addSubview:self.dailySpecialView];
    
    return headerView;
}
#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scroll) {
        self.scroll(scrollView.contentOffset.y);
    }
}
@end
