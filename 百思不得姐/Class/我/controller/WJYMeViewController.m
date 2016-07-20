//
//  WJYMeViewController.m
//  百思不得姐
//
//  Created by fangjs on 16/6/14.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYMeViewController.h"
#import "WJYMeCell.h"
#import "WJYTableFooterView.h"
#import "WJYSquareModel.h"

@interface WJYMeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong , nonatomic) UITableView  *tableView;

@end

@implementation WJYMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNav];
    [self setUpTableView];
}

- (void) setUpNav {
    self.navigationItem.title = @"我";
    UIBarButtonItem *settingButton = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highLightImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
    UIBarButtonItem *moonButton = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highLightImage:@"mine-moon-icon-click" target:self action:@selector(moonClick)];
    self.navigationItem.rightBarButtonItems = @[settingButton,moonButton];
    self.view.backgroundColor = GlobalColor;
}

- (void) setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[WJYMeCell class] forCellReuseIdentifier:@"me"];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = topicCellMargin;
    self.tableView.contentInset = UIEdgeInsetsMake(topicCellMargin - 35, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[WJYTableFooterView alloc] init];
}



- (void) settingClick {
    LogFunction;
}

- (void) moonClick {
    LogFunction;
}

#pragma mark - UITableViewDataSource 
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJYMeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"me"];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"mine_icon_nearby"];
        cell.textLabel.text = @"登录/注册";
    }else if (indexPath.section == 1) {
        cell.textLabel.text = @"离线下载";
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat sectionFooterHeight = 370;
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY >= 0 && offsetY <= sectionFooterHeight){
        scrollView.contentInset = UIEdgeInsetsMake(-offsetY, 0, -sectionFooterHeight, 0);
    }else if (offsetY > sectionFooterHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionFooterHeight, 0, -sectionFooterHeight, 0);
    } else {
        scrollView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    }
}

#pragma mark - UITableViewDelegate 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
