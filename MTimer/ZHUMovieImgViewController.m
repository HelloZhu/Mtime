//
//  ZHUMovieImgViewController.m
//  MTimer
//
//  Created by apple on 13-9-9.
//  Copyright (c) 2013年 HelloZHU. All rights reserved.
//

#import "ZHUMovieImgViewController.h"
#import "JSONKit.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "ZHUCustomTabBarController.h"
#import "UIImage+WebP.h"


@interface ZHUMovieImgViewController ()
{
    NSArray *_dataArray;
    UILabel *_titleLabel1;
    UINavigationController *nav;
    NSDictionary *_dataDict;
}
@end

@implementation ZHUMovieImgViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //背景
    UIImageView *backimageView=[[[UIImageView alloc]initWithFrame:self.view.frame]autorelease];
    backimageView.image=[UIImage imageNamed:@"star_bg.png"];
    [self.view addSubview:backimageView];
    
    //读取数据
    NSString *path=[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"影片详情.json"];
    NSString *josnStr=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
   _dataDict=[[josnStr objectFromJSONString] retain];
   _dataArray=[[_dataDict objectForKey:@"actorimg"] retain];
    
    
    
   
    
    KTThumbsView *thumbsView=[[KTThumbsView alloc]initWithFrame:CGRectMake(0, 25, 320, 460)];
    
    thumbsView.dataSource=self;
    
    [self.view addSubview:thumbsView];
    [self operateNavigationLeftBar];
    	
    
}



- (NSInteger)numberOfPhotos
{

    return [_dataArray count];
}

- (NSInteger)thumbsViewNumberOfThumbs:(KTThumbsView *)thumbsView
{

    return [_dataArray count];
}
- (KTThumbView *)thumbsView:(KTThumbsView *)thumbsView thumbForIndex:(NSInteger)index
{
    
    KTThumbView *thumbView=[thumbsView dequeueReusableThumbView];
    
    if (thumbView == nil) {
        
        thumbView=[[KTThumbView alloc]initWithFrame:CGRectZero];
        [thumbView addTarget:self action:@selector(gotoLargeImageViewCtrl:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    thumbView.tag=index;
    NSDictionary *imgDict=[_dataArray objectAtIndex:index];
    NSString *path=[imgDict objectForKey:@"image"];
    
    [thumbView setImageWithURL:[NSURL URLWithString:path] forState:UIControlStateNormal];
    _titleLabel1.text=[_dataDict objectForKey:@"t"];
    
    return thumbView;

}

- (void)gotoLargeImageViewCtrl:(id)sender
{
    
    UIButton *btn=(UIButton *)sender;
    KTPhotoScrollViewController *photoCtrl = [[KTPhotoScrollViewController alloc] initWithDataSource:self andStartWithPhotoAtIndex:btn.tag];
    nav=[[[UINavigationController alloc]initWithRootViewController:photoCtrl] autorelease];
    nav.navigationBar.tintColor=[UIColor blackColor];
    
   
    [self presentViewController:nav animated:YES completion:^{
        
    }];

}


-(void)operateNavigationLeftBar
{
    
    self.navigationItem.hidesBackButton=YES;
    
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"返回" forState:UIControlStateNormal];
    leftBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"ele_btn_return_on.png"] forState:UIControlStateNormal];
    leftBtn.frame=CGRectMake(0, 0, 60, 30);
    [leftBtn addTarget:self action:@selector(gotoIndex) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *leftBarBtn=[[[UIBarButtonItem alloc]initWithCustomView:leftBtn]autorelease];
    self.navigationItem.leftBarButtonItem=leftBarBtn;
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBtn.frame=CGRectMake(0, 0, 40, 27);
    [rightBtn addTarget:self action:@selector(gotoIndex) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"ele_home.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarBtn=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem=rightBarBtn;
    
    UIView *titleView=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 40)]autorelease];
    _titleLabel1=[[[UILabel alloc]initWithFrame:CGRectMake(0, 10, 200, 20)]autorelease];
    _titleLabel1.backgroundColor=[UIColor clearColor];
    [_titleLabel1 setTextAlignment:(NSTextAlignmentCenter)];
    _titleLabel1.textColor=[UIColor whiteColor];
    [titleView addSubview:_titleLabel1];
    
   
    
    [titleView addSubview:_titleLabel1];
    
    self.navigationItem.titleView=titleView;
    
    
}

- (void)gotoIndex
{
    
    
    ZHUCustomTabBarController *tab=(ZHUCustomTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    tab.customTabBar.hidden=NO;
    tab.tabBar.hidden=NO;
    tab.view.frame = CGRectMake(0, 0, 320, tab.view.frame.size.height-49);
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


- (UIImage *)imageAtIndex:(NSInteger)index
{
    NSDictionary *imgDict=[_dataArray objectAtIndex:index];
    NSString *path=[imgDict objectForKey:@"image"];
    
    
    return [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
