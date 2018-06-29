//
//  ZHomeViewController.m
//  BaseProject
//
//  Created by 泡果 on 2018/5/29.
//  Copyright © 2018年 com.general.*. All rights reserved.
//

#import "ZHomeViewController.h"
#import "ZHomeListView.h"
#import "ZHomeListViewModel.h"
#import "ZHomeSearchView.h"

@interface ZHomeViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) ZHomeListView *mainView;

@property (nonatomic, strong) ZHomeListViewModel *viewModel;

@property (nonatomic, strong) ZHomeSearchView *searchView;

@property (nonatomic, strong) CustomTextField *searchBar;

@property (nonatomic, strong) UIButton *cover;
@end

@implementation ZHomeViewController
#pragma mark - system
- (void)updateViewConstraints {
    
    WS(weakSelf)
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(0, 0, iPhoneX?IPHONEX_BOTTOM_BACK_BAR_H:0, 0));
    }];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.height.equalTo(kNavHeight);
    }];
    
    [super updateViewConstraints];
}

#pragma mark - private
- (void)z_addSubviews {
    
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.searchView];
    
    WS(weakSelf)
    self.mainView.scroll = ^(CGFloat y) {
//        ZLog(@"%f",y);
        float alpha = y/(SCREEN_HEIGHT * 0.6 - kNavHeight);
        if (alpha >= 1) {
            alpha = 1;
            if ([weakSelf firstColor:[weakSelf.searchBar valueForKeyPath:@"_placeholderLabel.textColor"] secondColor:white_color]) {
                [weakSelf.searchBar setValue:gray_color forKeyPath:@"_placeholderLabel.textColor"];
                weakSelf.searchBar.tintColor = gray_color;
                weakSelf.searchBar.textColor = MAIN_TEXT_COLOR;
            }
        }else{
            if ([weakSelf firstColor:[weakSelf.searchBar valueForKeyPath:@"_placeholderLabel.textColor"] secondColor:gray_color]) {
                [weakSelf.searchBar setValue:white_color forKeyPath:@"_placeholderLabel.textColor"];
                weakSelf.searchBar.tintColor = white_color;
                weakSelf.searchBar.textColor = white_color;
            }
        }
        weakSelf.searchView.backgroundColor = COLOR(255, 255, 255, alpha);
    };
}

- (void)z_bindViewModel {
    
    @weakify(self);
    //cell点击方法实现代码
    [[self.viewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        @strongify(self);
        ZGoodsDetailController *goodsDetailVC = [[ZGoodsDetailController alloc] init];
        [self.navigationController pushViewController:goodsDetailVC animated:YES];
    }];
}
- (void)z_layoutNavigation {
    [self hideNavigationBar:YES animated:NO];
}
#pragma mark - layzLoad
- (ZHomeListView *)mainView
{
    if (!_mainView) {
        _mainView = [[ZHomeListView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
- (ZHomeListViewModel *)viewModel {
    
    if (!_viewModel) {
        
        _viewModel = [[ZHomeListViewModel alloc] init];
    }
    
    return _viewModel;
}
- (ZHomeSearchView *)searchView
{
    if (!_searchView) {
        _searchView = [[ZHomeSearchView alloc] init];
        _searchView.backgroundColor = COLOR(255, 255, 255, 0);
        
        CGFloat Height = 30;
        
        _searchBar = [[CustomTextField alloc] init];
        _searchBar.returnKeyType = UIReturnKeySearch;
        _searchBar.placeholder = @"冈本十八号";
        _searchBar.font = FONT(17);
        _searchBar.frame = CGRectMake(20, kStatusBarHeight + (kNavHeight - kStatusBarHeight - Height) * 0.5 - 5, SCREEN_WIDTH - Height, Height);
        _searchBar.layer.cornerRadius = _searchBar.height * 0.5;
        _searchBar.borderStyle = UITextBorderStyleNone;
        _searchBar.backgroundColor = MAIN_HOME_SEARCH_BG_COLOR;
        _searchBar.textColor = white_color;
        _searchBar.tintColor = white_color;
        _searchBar.delegate = self;
        [_searchBar setValue:white_color forKeyPath:@"_placeholderLabel.textColor"];
        [_searchView addSubview:_searchBar];
        
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:ImageNamed(@"搜索")];
        searchIcon.frame = CGRectMake(_searchBar.width - Height - 10, 0, Height, Height);
        searchIcon.contentMode = UIViewContentModeCenter;
        [_searchBar addSubview:searchIcon];
    }
    return _searchView;
}
- (UIButton *)cover
{
    if (!_cover) {
        _cover = [UIButton buttonWithType:UIButtonTypeCustom];
        _cover.backgroundColor = clear_color;
        _cover.frame = self.view.bounds;
        [[_cover rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self.cover removeFromSuperview];
            [self.searchBar resignFirstResponder];
        }];
    }
    return _cover;
}
#pragma mark - action

#pragma mark - textfield delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view insertSubview:self.cover belowSubview:self.searchView];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text != nil) {
        [self.cover removeFromSuperview];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![textField.text isEqualToString:@""]) {
        
        [textField resignFirstResponder];
        [self.cover removeFromSuperview];
    }
    return YES;
}
- (void)textDidChange:(NSNotification *)note
{
    UITextField *textField = note.object;
    NSLog(@"textDidChange:%@",textField.text);
}
#pragma mark - scrollViewDelegate

@end
