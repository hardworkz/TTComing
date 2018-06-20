//
//  CustomTextField.m
//  xzb
//
//  Created by 张荣廷 on 16/6/14.
//  Copyright © 2016年 xuwk. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField
//- (void)setPlaceHolderColor:(UIColor *)placeHolderColor
//{
//    _placeHolderColor = placeHolderColor;
////    [self drawPlaceholderInRect:[self placeholderRectForBounds:self.bounds]];
//}
//控制placeHolder的位置，左右缩20
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 20, 10);
}
//控制placeHolder的颜色、字体
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    [[self placeholder] drawInRect:rect withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:self.placeHolderColor?self.placeHolderColor:white_color}];
//}
// 修改文本展示区域，一般跟editingRectForBounds一起重写
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 20, 0);
}

// 重写来编辑区域，可以改变光标起始位置，以及光标最右到什么地方，placeHolder的位置也会改变
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(bounds.origin.x+20, bounds.origin.y, bounds.size.width-25, bounds.size.height);//更好理解些
    return inset;
}
@end
