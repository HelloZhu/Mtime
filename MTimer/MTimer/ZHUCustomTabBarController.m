//
//  ZHUCustomTabBarController.m
//  MTimer
//
//  Created by apple on 13-8-29.
//  Copyright (c) 2013年 HelloZHU. All rights reserved.
//

#import "ZHUCustomTabBarController.h"



@interface ZHUCustomTabBarController ()

@end

@implementation ZHUCustomTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _indexViewController=[[ZHUIndexViewController alloc]init];
        _customTableViewController=[[ZHUCustomTableViewController alloc] init];
        _movieImgViewController=[[ZHUMovieImgViewController alloc]init];
        _movieContentCtrl=[[ZHUMovieContentTableViewController alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_customTabBar=[[ZHUCustomTabBar alloc]initWithFrame:self.tabBar.frame];
    _customTabBar.delegate=self;
    [self.view addSubview:_customTabBar];
    
   
    
    
}



- (void)tabBar:(ZHUCustomTabBar *)tabBar didSelectItem:(NSInteger)index
{
    self.selectedIndex = index;
    NSLog(@"%d",index);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
