//
//  ZHUCustomTabBarController.h
//  MTimer
//
//  Created by apple on 13-8-29.
//  Copyright (c) 2013年 HelloZHU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHUCustomTabBar.h"
#import "ZHUCustomTableViewController.h"
#import "ZHUIndexViewController.h"
#import "ZHUMovieImgViewController.h"
#import "ZHUMovieContentTableViewController.h"

@interface ZHUCustomTabBarController : UITabBarController<ZHUCustomTabBarDelegate>
{
    
}
@property(nonatomic,strong)ZHUCustomTabBar *customTabBar;
@property (nonatomic,retain)ZHUIndexViewController *indexViewController;
@property (nonatomic,retain)ZHUCustomTableViewController *customTableViewController;
@property(nonatomic ,retain) ZHUMovieImgViewController *movieImgViewController;
@property(nonatomic,retain)ZHUMovieContentTableViewController *movieContentCtrl;
@end
