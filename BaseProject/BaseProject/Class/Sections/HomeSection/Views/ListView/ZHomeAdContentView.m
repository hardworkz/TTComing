//
//  ZHomeAdContentView.m
//  BaseProject
//
//  Created by 泡果 on 2018/6/14.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZHomeAdContentView.h"

@interface ZHomeAdContentView ()

@property (nonatomic, strong) UIImageView *imageView;
@end
@implementation ZHomeAdContentView
- (void)z_setupViews {
    
    [self addSubview:self.imageView];

}

- (void)setViewModel:(ZHomeAdContentViewModel *)viewModel {
    
    if (!viewModel) {
        return;
    }
    
    _viewModel = viewModel;
    _imageView.backgroundColor = randomColor;
    
}
#pragma mark - lazyLoad
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.6, SCREEN_WIDTH * 0.3)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imageView;
}

@end
