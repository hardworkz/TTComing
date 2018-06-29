//
//  ZHomeAdView.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/14.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZHomeAdView.h"
#import "ZHomeAdViewModel.h"
#import "ZHomeAdContentView.h"
#import "ZHomeAdContentViewModel.h"
#import "iCarousel.h"

@interface ZHomeAdView ()<iCarouselDelegate,iCarouselDataSource>

@property (nonatomic, strong) iCarousel *adsCarousel;

@property (strong, nonatomic) ZHomeAdViewModel *viewModel;

@property (assign, nonatomic) BOOL firstIndexComplete;

@end
@implementation ZHomeAdView
#pragma mark - system
- (instancetype)initWithViewModel:(id<ZViewModelProtocol>)viewModel {
    
    self.viewModel = (ZHomeAdViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

#pragma mark - private
- (void)z_setupViews {
    
    [self addSubview:self.adsCarousel];
    
}
- (void)z_bindViewModel
{
    [self.viewModel.refreshDataCommand execute:nil];
    
    @weakify(self);
    
    [self.viewModel.refreshUI subscribeNext:^(id x) {
        
        @strongify(self);
        [self.adsCarousel reloadData];
    }];
    //初始化的时候设置默认在中间显示的图片为第二张图片（index为1）
//    [self.adsCarousel scrollToItemAtIndex:1 animated:YES];
    [self.adsCarousel scrollToItemAtIndex:1 duration:5];
}
#pragma mark - action
#pragma mark - lazyLoad
-(iCarousel *)adsCarousel{
    if (_adsCarousel == nil) {
        _adsCarousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 0.25)];
        _adsCarousel.delegate = self;
        _adsCarousel.dataSource = self;
        _adsCarousel.backgroundColor = clear_color;
        _adsCarousel.bounces = NO;
        _adsCarousel.pagingEnabled = YES;
        _adsCarousel.type = iCarouselTypeCustom;
    }
    return _adsCarousel;
}

#pragma mark - iCarouselDataSource
-(NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.viewModel.dataArray.count * 100;
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(ZHomeAdContentView *)view{
    
    if (view == nil) {
        view = [[ZHomeAdContentView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.6, SCREEN_WIDTH * 0.3)];
        view.backgroundColor = clear_color;
    }
    if (self.viewModel.dataArray.count > (index%self.viewModel.dataArray.count)) {
        view.viewModel = self.viewModel.dataArray[index%self.viewModel.dataArray.count];
    }
    return view;
}

#pragma mark - iCarouselDelegate
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{
    NSLog(@"index---%lu",carousel.currentItemIndex);
    if (!self.firstIndexComplete) {
        //初始化的时候设置默认在中间显示的图片为第二张图片（index为1）
        [self.adsCarousel scrollToItemAtIndex:50 * self.viewModel.dataArray.count animated:NO];
        self.firstIndexComplete = YES;
    }
    // 支持循环的 可用（最后一个的下一个是第0个）
//    if (carousel.currentItemIndex == [self.viewModel.dataArray count] - 1) {
//        [carousel scrollToItemAtIndex:1 animated:NO];
//    }
//
//    if (carousel.currentItemIndex ==  1) {
//        [carousel scrollToItemAtIndex:[self.viewModel.dataArray count] - 2 animated:NO];
//    }
}
- (void)carouselWillBeginDragging:(iCarousel *)carousel{
    
}
- (void)carouselDidScroll:(iCarousel *)carousel{
//    NSLog(@"___2 %lu",carousel.currentItemIndex);
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
//    NSLog(@"___3 %lu",carousel.currentItemIndex);
}

-(CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform {
    
    static CGFloat max_sacle = 1.15f;/*控制放大的比例*/
    static CGFloat min_scale = 0.8f;/*控制缩小的比例*/
    if (offset <= 1 && offset >= -1) {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_sacle - min_scale) / 1;
        
        CGFloat scale = min_scale + slope*tempScale;
        transform = CATransform3DScale(transform, scale, scale, 1);
    }else{
        transform = CATransform3DScale(transform, min_scale, min_scale, 1);
    }
    
    return CATransform3DTranslate(transform, offset * carousel.itemWidth * 1.35/*控制相互之间的间隔*/, 0.0, 0.0);
}
@end
