//
//  ZHUMovieImgViewController.h
//  MTimer
//
//  Created by apple on 13-9-9.
//  Copyright (c) 2013年 HelloZHU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTThumbView.h"
#import "KTPhotoScrollViewController.h"
#import "KTThumbsView.h"
#import "KTPhotoBrowserDataSource.h"
#import "ZHUMovieContentTableViewController.h"


@interface ZHUMovieImgViewController : UIViewController<KTPhotoBrowserDataSource,KTThumbsViewDataSource>

@property(nonatomic,strong)ZHUMovieContentTableViewController *movieContentCtrl;


@end
