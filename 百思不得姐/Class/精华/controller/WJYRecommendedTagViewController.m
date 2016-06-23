//
//  WJYRecommendedTagViewController.m
//  百思不得姐
//
//  Created by fangjs on 16/6/20.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYRecommendedTagViewController.h"
#import "WJYRecommendedTag.h"
#import "WJYRecommendedTagCell.h"


@interface WJYRecommendedTagViewController ()
/**数据源*/
@property (strong , nonatomic)  NSArray *dataSource;

@end

@implementation WJYRecommendedTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadContent];
}

- (void) setupTableView {
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WJYRecommendedTagCell class]) bundle:nil] forCellReuseIdentifier:recommandedTagCellId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = GlobalColor;
}

- (void) loadContent {
    [SVProgressHUD show];
    HttpClient *aClient = [HttpClient sharedClient];
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:4];
    param[@"a"] = @"tag_recommend";
    param[@"action"] = @"sub";
    param[@"c"] = @"topic";
    [aClient getPath:@"http://api.budejie.com/api/api_open.php" params:param resultBlock:^(id responseObject, NSError *error) {
        if (!error) {
            [SVProgressHUD dismiss];
             self.dataSource = [WJYRecommendedTag mj_objectArrayWithKeyValuesArray:responseObject];
             dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
             });
        }else {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error]];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJYRecommendedTagCell *cell = [tableView dequeueReusableCellWithIdentifier:recommandedTagCellId];
    
    cell.recommendedModel = self.dataSource[indexPath.row];
    
    return cell;
}

@end
