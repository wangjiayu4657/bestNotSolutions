//
//  WJYEssenceViewController.m
//  百思不得姐
//
//  Created by fangjs on 16/6/14.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYEssenceViewController.h"
#import "WJYRecommendedTagViewController.h"
#import "WJYAllViewController.h"
#import "WJYVideoViewController.h"
#import "WJYVoiceViewController.h"
#import "WJYPictureViewController.h"
#import "WJYWordViewController.h"


@interface WJYEssenceViewController ()<UIScrollViewDelegate>


/**顶部的所有标签内容*/
@property (weak , nonatomic) UIView *titleView;

/**标签下面的红色指示条*/
@property (weak , nonatomic) UIView *indcatorView;
/**当前选中的按钮*/
@property (strong , nonatomic) UIButton *selectButton;

/** 底部的全部内容*/
@property (weak , nonatomic) UIScrollView *contentView;

@end

@implementation WJYEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = GlobalColor;
    
    //设置导航栏
    [self setUpNavgation];
    //设置顶部的标签栏
    [self setUpTitleView];
    //初始化子控件
    [self setUpChildController];
    //设置底部的 scrollView
    [self setUpContentView];
}


//e设置导航栏按钮
- (void) setUpNavgation {
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highLightImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

- (void) tagClick {
    [self.navigationController pushViewController:[[WJYRecommendedTagViewController alloc] init] animated:YES];
}

- (void) setUpTitleView {
    //标题按钮的背景
    UIView *titleView = [[UIView alloc] init];
    titleView.width = self.view.width;
    titleView.height = 35;
    titleView.y = 64;
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    //标签下面的红色指示条
    UIView *indcatorView = [[UIView alloc] init];
    indcatorView.height = 2;
    indcatorView.y = titleView.height - indcatorView.height;
    indcatorView.backgroundColor = [UIColor redColor];
    [titleView addSubview:indcatorView];
    self.indcatorView = indcatorView;
   
    NSArray *titlesArray = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    CGFloat width = titleView.width / titlesArray.count;
    CGFloat height = titleView.height;
    for (int i = 0; i < titlesArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.width = width;
        button.height = height;
        button.x = i * width;
        button.tag = 300 + i;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titlesArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titleView addSubview:button];
        
        //默认选中第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectButton = button;
            //让按钮内部的 label 根据文字内容来计算 titleLabel 的宽度
            [button.titleLabel sizeToFit];
            self.indcatorView.width = button.titleLabel.width;
            self.indcatorView.centerX = button.centerX;
        }
    }
}

- (void)buttonClick:(UIButton *) button {
    //修改按钮的状态
    self.selectButton.enabled = YES;
    button.enabled = NO;
    self.selectButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indcatorView.width = button.titleLabel.width;
        self.indcatorView.centerX = button.centerX;
    }];
    
    CGPoint offset = self.contentView.contentOffset;
    offset.x = (button.tag - 300) * self.view.width;
    [self.contentView setContentOffset:offset animated:YES];
}

- (void) setUpChildController {
    WJYAllViewController *allVC = [[WJYAllViewController alloc] init];
    [self addChildViewController:allVC];
    
    WJYVideoViewController *videoVC = [[WJYVideoViewController alloc] init];
    [self addChildViewController:videoVC];
    
    WJYVoiceViewController *voiceVC = [[WJYVoiceViewController alloc] init];
    [self addChildViewController:voiceVC];
    
    WJYPictureViewController *pictureVC = [[WJYPictureViewController alloc] init];
    [self addChildViewController:pictureVC];
    
    WJYWordViewController *wordVC = [[WJYWordViewController alloc] init];
    [self addChildViewController:wordVC];
}

- (void) setUpContentView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    
    self.contentView = contentView;
    
    [self scrollViewDidEndScrollingAnimation:contentView];
}


- (void) scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.width;

    UITableViewController *tableViewController = self.childViewControllers[index];
    tableViewController.view.x = index * scrollView.width;
    CGFloat top = CGRectGetMaxY(self.titleView.frame);
    CGFloat bottom = self.tabBarController.tabBar.height;
    tableViewController.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    [scrollView addSubview:tableViewController.view];
}

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    NSInteger index = scrollView.contentOffset.x / scrollView.width + 300;
    
    [self buttonClick:[self.view viewWithTag:index]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
