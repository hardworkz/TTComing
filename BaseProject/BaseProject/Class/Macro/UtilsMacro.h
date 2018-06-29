//
//  UtilsMacro.h
//  PhoneSearch
//
//  Created by 王隆帅 on 15/5/20.
//  Copyright (c) 2015年 王隆帅. All rights reserved.
//

/**
 *  本类放一些方便使用的宏定义
 */

// ios7之上的系统
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >=7.0 ? YES : NO)

// 获取屏幕 宽度、高度 bounds就是屏幕的全部区域
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define IS_IPHONE4 [UIScreen mainScreen].bounds.size.height == 480

// 获取当前屏幕的高度 applicationFrame就是app显示的区域，不包含状态栏
#define kMainScreenHeight ([UIScreen mainScreen].applicationFrame.size.height)
#define kMainScreenWidth  ([UIScreen mainScreen].applicationFrame.size.width)

// 判断字段时候为空的情况
#define IF_NULL_TO_STRING(x) ([(x) isEqual:[NSNull null]]||(x)==nil)? @"":TEXT_STRING(x)
// 转换为字符串
#define TEXT_STRING(x) [NSString stringWithFormat:@"%@",x]

// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
// 设置颜色RGB
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]
#define ImageNamed(name) [UIImage imageNamed:name]

// 每次请求列表 数据量
#define LS_REQUEST_LIST_COUNT @"10"
#define LS_REQUEST_LIST_NUM_COUNT 10

// 个人信息
#define IS_LOGIN (((NSString *)SEEKPLISTTHING(USER_ID)).length > 0)

#define YC_USER_ID IF_NULL_TO_STRING(((NSString *)SEEKPLISTTHING(USER_ID)))
#define YC_USER_PHONE IF_NULL_TO_STRING(((NSString *)SEEKPLISTTHING(USER_PHONE)))
#define YC_USER_EASEMOB_NAME IF_NULL_TO_STRING(((NSString *)SEEKPLISTTHING(USER_EASEMOB_NAME)))

//app主体颜色-----------------------
#define MAIN_COLOR UIColorFromRGB(0xfdb63c)
//app主体背景颜色
#define MAIN_BG_COLOR COLOR(255, 255, 255, 1)
//app主体字体颜色-------------------
#define MAIN_TEXT_COLOR COLOR(33, 33, 33, 1)
//app主体字体颜色-------------------
#define MAIN_HOME_SEARCH_BG_COLOR COLOR(33, 33, 33, 0.25)
//app浅灰色字体颜色
#define MAIN_LIGHT_GRAY_TEXT_COLOR UIColorFromRGB(0xCBCBCB)
//app线颜色-----------------------
#define MAIN_LINE_COLOR UIColorFromRGB(0xe9e9e9)

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//字体大小
#define FONT_NORMAL_10 FONT(10)
#define FONT_NORMAL_11 FONT(11)
#define FONT_NORMAL_12 FONT(12)
#define FONT_NORMAL_13 FONT(13)
#define FONT_NORMAL_14 FONT(14)
#define FONT_NORMAL_15 FONT(15)
#define FONT_NORMAL_16 FONT(16)
#define FONT_NORMAL_17 FONT(17)
#define FONT_NORMAL_18 FONT(18)
#define FONT_NORMAL_19 FONT(19)
#define FONT_NORMAL_20 FONT(20)












