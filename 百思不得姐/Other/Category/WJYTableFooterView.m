//
//  WJYTableFooterView.m
//  百思不得姐
//
//  Created by fangjs on 16/7/15.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYTableFooterView.h"
#import "WJYSquareModel.h"
#import "WJYSquareButton.h"
#import "WJYWebViewController.h"

@interface WJYTableFooterView()

@end

@implementation WJYTableFooterView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self downloadContent];
    }
    return self;
}

- (void) downloadContent {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithCapacity:5];
    param[@"a"] = @"square";
    param[@"c"] = @"topic";
    
    HttpClient *aClient = [HttpClient sharedClient];
    [aClient getPath:@"http://api.budejie.com/api/api_open.php" params:param resultBlock:^(id responseObject, NSError *error) {
        
        if (!error) {
            NSArray *square = [WJYSquareModel mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
            dispatch_async(dispatch_get_main_queue(), ^{
               [self createSquare:square];
            });
        }else {
            //如果有错误....
        }
    }];
}

- (void) createSquare:(NSArray *) squares {

    int maxCols = 4;
    NSInteger buttonWidth = screenWidth / maxCols;
    NSInteger buttonHeight = buttonWidth ;
    for (int i = 0; i < squares.count; i++) {
        WJYSquareButton *button = [WJYSquareButton buttonWithType:UIButtonTypeCustom];
        button.square = squares[i];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
       
        int row = i / maxCols; //行
        int col = i % maxCols;//列
        button.x = col * buttonWidth;
        button.y = row * buttonHeight;
        button.width = buttonWidth;
        button.height = buttonHeight;
//        self.height = CGRectGetMaxY(button.frame);
    }
    
    NSInteger totalRows = (squares.count + maxCols - 1) / maxCols;
    self.height = totalRows * buttonHeight;

}

- (void) buttonClick:(WJYSquareButton *) button {
    if(![button.square.url hasPrefix:@"http"]) return;
    
    WJYWebViewController *webVC = [[WJYWebViewController alloc] init];
    webVC.title = button.square.name;
    webVC.url = button.square.url;
    UITabBarController *tabBarVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)tabBarVC.selectedViewController;
    [nav pushViewController:webVC animated:YES];
}

@end
