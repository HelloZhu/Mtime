//
//  ZHUMovieContentTableViewController.h
//  MTimer
//
//  Created by apple on 13-9-2.
//  Copyright (c) 2013年 HelloZHU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHUMovieContentTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic ,strong)UILabel *titleLabel1;
@property(nonatomic ,strong)UILabel *titleLabel2;

-(void)operateNavigationLeftBar;
@end
