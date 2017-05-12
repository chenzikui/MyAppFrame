//
//  HMNavigationController.m
//  黑马微博
//
//  Created by apple on 14-7-3.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMNavigationController.h"
#import "UIBarButtonItem+Extension.h"
#import "BaseSkinColor.h"


@interface HMNavigationController ()

@end

@implementation HMNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/**
 *  当导航控制器的view创建完毕就调用
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = nil;
}

/**
 *  当第一次使用这个类的时候调用1次
 */
+ (void)initialize
{
    // 设置UINavigationBarTheme的主
    [self setupNavigationBarTheme];
    
    // 设置UIBarButtonItem的主题
    [self setupBarButtonItemTheme];
}

/**
 *  设置UINavigationBarTheme的主题
 */
+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    // 设置导航栏背景
    [appearance setBackgroundImage:[UIImage imageNamed:@"nav_BG"] forBarMetrics:UIBarMetricsDefault];

    
    // 设置文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = MainNavigationTitleColor_Normal;
    // UITextAttributeFont  --> NSFontAttributeName(iOS7)
    textAttrs[NSFontAttributeName] = MainNavigationTitleFont;
    [appearance setTitleTextAttributes:textAttrs];
}

/**
 *  设置UIBarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme
{
    // 通过appearance对象能修改整个项目中所有UIBarButtonItem的样式
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    /**设置文字属性**/
    // 设置普通状态的文字属性
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = MainNavigationTitleColor_Normal;
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置高亮状态的文字属性
//    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
//    highTextAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
//    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
//    
    // 设置不可用状态(disable)的文字属性
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = MainNavigationTitleColor_Disable;
    disableTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{

    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置导航栏按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"nav_back_button" highImageName:@"nav_back_button_hightlight" target:self action:@selector(back)];
      
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];

}

@end
