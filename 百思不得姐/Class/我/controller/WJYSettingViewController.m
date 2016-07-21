//
//  WJYSettingViewController.m
//  百思不得姐
//
//  Created by fangjs on 16/7/21.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "WJYSettingViewController.h"


@interface WJYSettingViewController ()

/**缓存大小*/
@property (assign , nonatomic)  CGFloat cacheSize;

@end

@implementation WJYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self cleanDisk];
//    [self clearDisk];
    
    self.title = @"设置";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"setting"];
    }
    
    //获取缓存的大小
    CGFloat size = [SDImageCache sharedImageCache].getSize / 1000.0 / 1000.0;
    cell.textLabel.text = [NSString stringWithFormat:@"清除缓存(已使用:%.2fM)",size];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [[SDImageCache sharedImageCache] clearDisk];
    [SVProgressHUD showSuccessWithStatus:@"清楚完毕"];
    [self.tableView reloadData];
   
}

- (void) cleanDisk {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileManager *manager = [NSFileManager defaultManager];
        //缓存路径
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        //沙河全路径
        NSString *cachesPath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
        //遍历器
        NSDirectoryEnumerator *enumerator = [manager enumeratorAtPath:cachesPath];
        NSInteger totalSize = 0;
        for (NSString *fileName in enumerator) {
            //获取文件夹内文件的路径
            NSString *filePath = [cachesPath stringByAppendingPathComponent:fileName];
            NSDictionary *attrs = [manager attributesOfItemAtPath:filePath error:nil];
            if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
            totalSize += [attrs[NSFileSize] integerValue];
        }
        self.cacheSize = totalSize / 1000.0 / 1000.0;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)clearDisk {
    NSFileManager *manager = [NSFileManager defaultManager];
    //缓存路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //沙河全路径
    NSString *cachesPath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    // 获得文件夹内部的所有内容
    NSArray *cachArr = [manager subpathsAtPath:cachesPath];
    NSLog(@"%@",cachArr);
    NSInteger totalSize = 0;
    for (NSString *fileName in cachArr) {
        //获取文件夹内文件的路径
        NSString *filePath = [cachesPath stringByAppendingPathComponent:fileName];
        NSDictionary *attrs = [manager attributesOfItemAtPath:filePath error:nil];
        if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
        totalSize += [attrs[NSFileSize] integerValue];
        
    }
    self.cacheSize = totalSize / 1000.0 / 1000.0;
}



@end
