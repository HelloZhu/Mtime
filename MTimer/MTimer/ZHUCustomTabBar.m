//
//  ZHUCustomTabBar.m
//  MTimer
//
//  Created by apple on 13-8-29.
//  Copyright (c) 2013年 HelloZHU. All rights reserved.
//

#import "ZHUCustomTabBar.h"
#import "ZHUCinemaViewController.h"

@implementation ZHUCustomTabBar


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *tabBarBgImage=[UIImage imageNamed:@"botmenu_bg.png"];
        
        [tabBarBgImage stretchableImageWithLeftCapWidth:1 topCapHeight:0];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 49)];
        imageView.image=tabBarBgImage;
        [self addSubview:imageView];
        
        _homeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _homeBtn.frame=CGRectMake(125, -8, 67, 55);
        [_homeBtn setBackgroundImage:[UIImage imageNamed:@"botmenu_icon_index.png"] forState:UIControlStateNormal];
        [_homeBtn addTarget:self action:@selector(diclicked:) forControlEvents:UIControlEventTouchUpInside];
        _homeBtn.tag=0;
        [self addSubview:_homeBtn];
        
        _cinamerBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _cinamerBtn.frame=CGRectMake(12, 3, 30, 30);
        [_cinamerBtn setBackgroundImage:[UIImage imageNamed:@"botmenu_icon_ciname.png"] forState:UIControlStateNormal];
        [_cinamerBtn addTarget:self action:@selector(diclicked:) forControlEvents:UIControlEventTouchUpInside];
        _cinamerBtn.tag=1;
        
        [self addSubview:_cinamerBtn];
        UILabel *cinamerLabel=[[UILabel alloc]initWithFrame:CGRectMake(14, 29, 30, 20)];
        cinamerLabel.text=@"影院";
        
        cinamerLabel.backgroundColor=[UIColor clearColor];
        cinamerLabel.textColor=[UIColor whiteColor];
        cinamerLabel.font=[UIFont systemFontOfSize:12];
        [self addSubview:cinamerLabel];
        
        _cheapBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _cheapBtn.frame=CGRectMake(60, 3, 30, 30);
        [_cheapBtn setBackgroundImage:[UIImage imageNamed:@"botmenu_icon_coup.png"] forState:UIControlStateNormal];
        [_cheapBtn addTarget:self action:@selector(diclicked:) forControlEvents:UIControlEventTouchUpInside];
        _cheapBtn.tag=2;
        [self addSubview:_cheapBtn];
        
        UILabel *cheapLabel=[[UILabel alloc]initWithFrame:CGRectMake(62, 29, 30, 20)];
        cheapLabel.text=@"优惠";
        cheapLabel.backgroundColor=[UIColor clearColor];
        cheapLabel.textColor=[UIColor whiteColor];
        cheapLabel.font=[UIFont systemFontOfSize:12];
        [self addSubview:cheapLabel];
        
        _selectionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _selectionBtn.frame=CGRectMake(230, 3, 30, 40);
        [_selectionBtn setBackgroundImage:[UIImage imageNamed:@"botmenu_icon_topic.png"] forState:UIControlStateNormal];
        [_selectionBtn addTarget:self action:@selector(diclicked:) forControlEvents:UIControlEventTouchUpInside];
        _selectionBtn.tag=3;
        [self addSubview:_selectionBtn];
       
        
        
        _moreBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.frame=CGRectMake(280, 3, 30, 30);
        [_moreBtn setBackgroundImage:[UIImage imageNamed:@"botmenu_icon_more.png"] forState:UIControlStateNormal];
        _moreBtn.tag=4;
        [_moreBtn addTarget:self action:@selector(diclicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_moreBtn];
        UILabel *selectionLabel=[[UILabel alloc]initWithFrame:CGRectMake(282, 29, 30, 20)];
        selectionLabel.text=@"更多";
        selectionLabel.backgroundColor=[UIColor clearColor];
        selectionLabel.textColor=[UIColor whiteColor];
        selectionLabel.font=[UIFont systemFontOfSize:12];
        [self addSubview:selectionLabel];
        
    }
    return self;
}

- (void)diclicked:(id)sender
{
    
    UIButton *btn=(UIButton *)sender;
    if (_delegate && [_delegate respondsToSelector:@selector(tabBar:didSelectItem:)]) {
        [_delegate tabBar:self didSelectItem:btn.tag];
    }
    
}
@end
