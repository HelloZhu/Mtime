//
//  ZHUDiscountViewController.m
//  MTimer
//
//  Created by apple on 13-9-12.
//  Copyright (c) 2013年 HelloZHU. All rights reserved.
//

#import "ZHUDiscountViewController.h"

@interface ZHUDiscountViewController ()

@end

@implementation ZHUDiscountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    iCarousel *icar=[[[iCarousel alloc]initWithFrame:CGRectMake(0, 44, 320, (480-44-49-20)/2) ]autorelease];
    
    icar.delegate=self;
    icar.dataSource=self;
    icar.type=iCarouselTypeInvertedTimeMachine;
    icar.contentOffset=CGSizeMake(-60, -10);
    
    
    // icar.viewpointOffset=CGSizeMake(30, 10);
    
    [self.view addSubview:icar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
