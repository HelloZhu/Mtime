//
//  ZHUCustomTableViewController.h
//  MTimer
//
//  Created by apple on 13-8-30.
//  Copyright (c) 2013年 HelloZHU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHUCustomTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,retain)UITableView *myTableView;
@end
