//
//  ZHomeAdContentView.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/14.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZHomeAdContentView.h"

@interface ZHomeAdContentView ()
@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation ZHomeAdContentView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.bgImageView];
        [self.bgImageView addSubview:self.imageView];
    }
    return self;
}

- (void)setViewModel:(ZHomeAdContentViewModel *)viewModel {
    
    if (!viewModel) {
        return;
    }
    
    _viewModel = viewModel;
    
    self.imageView.image = ImageNamed(viewModel.image);
}
#pragma mark - lazyLoad
- (UIImageView *)bgImageView
{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] initWithImage:[UIImage resizableImage:@"轮播背景外发光"]];
        _bgImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH * 0.6, SCREEN_WIDTH * 0.3);
    }
    return _bgImageView;
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH * 0.6 - 10, SCREEN_WIDTH * 0.3 - 10)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.backgroundColor = red_color;
    }
    return _imageView;
}

@end
