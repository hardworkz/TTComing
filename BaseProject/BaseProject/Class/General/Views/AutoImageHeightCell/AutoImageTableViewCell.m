//
//  AutoImageTableViewCell.m
//  JiDing
//
//  Created by zhangrongting on 2017/6/17.
//  Copyright © 2017年 zhangrongting. All rights reserved.
//

#import "AutoImageTableViewCell.h"

@interface AutoImageTableViewCell ()
{
    UIImageView *autoImageView;
}
@end
@implementation AutoImageTableViewCell

+(AutoImageTableViewCell *)cellWithTableView:(UITableView *)tableView
{
    AutoImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([AutoImageTableViewCell class])]];
    if (cell == nil) {
        cell = [[AutoImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithUTF8String:object_getClassName([AutoImageTableViewCell class])]];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        autoImageView = [[UIImageView alloc] init];
        autoImageView.contentMode = UIViewContentModeScaleAspectFit;
        autoImageView.clipsToBounds = YES;
        autoImageView.userInteractionEnabled = YES;
        [autoImageView addTapGestureWithTarget:self action:@selector(showZoomImageView:)];
        [self.contentView addSubview:autoImageView];
    }
    return self;
}
- (void)setFrameModel:(AutoImageViewHeightFrameModel *)frameModel
{
    _frameModel = frameModel;
    
    autoImageView.frame = frameModel.imageViewF;
    autoImageView.image = frameModel.image;
}
- (void)showZoomImageView:(UITapGestureRecognizer *)tap
{
    if (self.tapImage) {
        self.tapImage(tap);
    }
}
@end
