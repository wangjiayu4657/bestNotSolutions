//
//  AppDelegate.m
//  百思不得姐
//
//  Created by fangjs on 16/6/13.
//  Copyright © 2016年 fangjs. All rights reserved.
//

#import "AppDelegate.h"
#import "WJYTabBarController.h"
#import "WJYPushGuideView.h"
#import "WJYTopWindow.h"



@interface AppDelegate ()<UITabBarControllerDelegate>

@property (strong , nonatomic) UIWindow *test;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    WJYTabBarController *tabVC = [[WJYTabBarController alloc] init];
    tabVC.delegate = self;
    self.window.rootViewController = tabVC;
    [self.window makeKeyAndVisible];

    //显示引导页
    [WJYPushGuideView show];

    return YES;
}

- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [[NSNotificationCenter defaultCenter] postNotificationName:tabbarSelectedNotification object:nil userInfo:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //UIWindow 这个控件刚创建的时候默认是隐藏的，之所以创建window的这段代码块要延时一段时间来执行，是因为程序在刚启动的时候，会查看你创建的窗口有没有设置根控制器，如果发现你没有设置，苹果就会抛错，让程序崩溃这（在之前只是警告），来告诉你不设置根控制器是不合适的。我们只要错过这段检查的时间，就可以避免程序崩溃了。以上这段代码也就证明了UIWindow控件是能够直接显示在手机屏幕上。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [WJYTopWindow show];
    });
  
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
