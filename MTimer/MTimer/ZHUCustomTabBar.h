//
//  ZHUCustomTabBar.h
//  MTimer
//
//  Created by apple on 13-8-29.
//  Copyright (c) 2013年 HelloZHU. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZHUCustomTabBar;

@protocol ZHUCustomTabBarDelegate <NSObject>

- (void)tabBar:(ZHUCustomTabBar *)tabBar didSelectItem:(NSInteger)index;

@end

@interface ZHUCustomTabBar : UIView
{
    UIButton *_homeBtn;
    UIButton *_cinamerBtn;
    UIButton *_cheapBtn;
    UIButton *_selectionBtn;
    UIButton *_moreBtn;
}

@property(nonatomic,assign)id <ZHUCustomTabBarDelegate> delegate;

@property(nonatomic,retain) UIImage *backgroundImage;
@end
