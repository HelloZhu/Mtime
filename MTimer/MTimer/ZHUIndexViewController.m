//
//  ZHUIndexViewController.m
//  MTimer
//
//  Created by apple on 13-8-29.
//  Copyright (c) 2013年 HelloZHU. All rights reserved.
//

#import "ZHUIndexViewController.h"
#import "JSONKit.h"
#import "UIImageView+WebCache.h"
#import "ZHUCustomTableViewController.h"
#import "ZHUCustomTabBarController.h"
#import "ZHUMovieContentTableViewController.h"

#define kCommaImageViewTag  10
#define kBuyTicketbtnTag    11
#define kTitleLeftBthTag    12
#define kTitleRightBthTag   13

@interface ZHUIndexViewController ()
{
    NSMutableArray *_dataArray;
    UILabel *_movieNameLabel;
    UILabel *_assessLabel;
    UILabel *_assessLabel2;
    UILabel *_showTimeLabel;
    UILabel *_storyLabel;
    NSMutableString *_showdateStr;
    UILabel *_dicriptionLabel;
    UILabel *_movieCountLabel;
    NSInteger _movieNameStrLength;
}
@end

@implementation ZHUIndexViewController

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
	// Do any additional setup after loading the view.
   
 
    UIImageView *backimageView=[[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 480-20-44-49)]autorelease];
    backimageView.image=[UIImage imageNamed:@"star_bg.png"];
    [self.view addSubview:backimageView];
    
    NSLog(@"%@", NSStringFromCGRect( self.navigationController.navigationBar.bounds));
    UIImage *navBarImage=[UIImage imageNamed:@"menu_top_bg@2x.png"];
    [navBarImage stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    [self.navigationController.navigationBar setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    
    
    
    
    
    //去数据
    NSString *dataPath=[[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:@"首页.json"];
    NSString *jsonStr=[NSString stringWithContentsOfFile:dataPath encoding:NSUTF8StringEncoding error:nil];
   // NSLog(@"%@",jsonStr);
    NSDictionary *dataDict=[jsonStr objectFromJSONString];
   // NSLog(@"%@",dataDict);
    
    NSArray *subArray=[dataDict objectForKey:@"ms"];
   // NSLog(@"%@",subArray);
    _dataArray=[[NSMutableArray arrayWithArray:subArray]retain];
    //旋转图片
    iCarousel *icar=[[[iCarousel alloc]initWithFrame:CGRectMake(0, 44, 320, (480-44-49-20)/2) ]autorelease];
    icar.delegate=self;
    icar.dataSource=self;
    icar.type=iCarouselTypeInvertedTimeMachine;
    icar.contentOffset=CGSizeMake(-60, -10);
    

   // icar.viewpointOffset=CGSizeMake(30, 10);
    
    [self.view addSubview:icar];
    
    
    [self createNavBarLeftAndRightBtn];
    [self createMovieNameLabel];
    [self createAssessLabel];
    [self createAssessLabel2];
    [self createShowTimeLabel];
    [self createMovieDiscription];
    [self createCommaImageView];
    [self createfindAndBuyTicketSegment];
    [self createMovieStory];
    [self createMovieCount];
    [self createTitleButton];
    
    
    
    
}

- (void)createNavBarLeftAndRightBtn
{
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBtn.frame=CGRectMake(0, 0, 40, 35);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"topmenu_btn_index_ablum_on.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarBtn=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=rightBarBtn;
    
    UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    leftBtn.frame=CGRectMake(0, 0, 55, 35);
    leftBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [leftBtn setTitle:@"北京" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"ico_index_title_4.png"] forState:UIControlStateNormal];
    UIBarButtonItem *leftBarBtn=[[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem=leftBarBtn;
}
- (void)createTitleButton
{
    UIView *myview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 160, 30)];
    
   
    UIImageView *titleImageView=[[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 160, 30)]autorelease];
    titleImageView.image=[UIImage imageNamed:@"ico_index_title_1.png"];
    UIButton *titleRightBth=[UIButton buttonWithType:UIButtonTypeCustom];
    titleRightBth.frame=CGRectMake(0, 0, 80, 30);
    titleRightBth.tag=kTitleRightBthTag;
    [titleRightBth setTitle:@"正在热映" forState:UIControlStateNormal];
    [titleRightBth setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleRightBth setBackgroundImage:[UIImage imageNamed:@"ico_index_title_2.png"] forState:UIControlStateNormal];
    [titleRightBth addTarget:self action:@selector(changeIndexView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *titleLeftBth=[UIButton buttonWithType:UIButtonTypeCustom];
    titleLeftBth.frame=CGRectMake(80, 0, 80, 30);
    titleLeftBth.tag=kTitleLeftBthTag;
    [titleLeftBth setTitle:@"即将上映" forState:UIControlStateNormal];
    [titleLeftBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [titleLeftBth addTarget:self action:@selector(changeIndexView:) forControlEvents:UIControlEventTouchUpInside];
   
    [myview addSubview:titleImageView];
     [myview addSubview:titleLeftBth];
    [myview addSubview:titleRightBth];
    
    self.navigationItem.titleView=myview;
    
    
}
- (void)changeIndexView:(id)sender
{
    NSLog(@"changeview");
    UIButton *btn=(UIButton *)sender;
    if (btn.tag==kTitleLeftBthTag) {
        
        ZHUCustomTabBarController *tabBarControl = (ZHUCustomTabBarController *)[[UIApplication  sharedApplication] keyWindow].rootViewController;
        if (tabBarControl.customTableViewController==nil) {
            
            tabBarControl.customTableViewController=[[[ZHUCustomTableViewController alloc]init]autorelease];
        }

        [self.navigationController setViewControllers:[NSArray arrayWithObject:tabBarControl.customTableViewController]];
    }else if (btn.tag==kTitleRightBthTag){
    
        
    }
   
    
    
}

- (void)createMovieCount
{
    
    _movieCountLabel=[[[UILabel alloc]initWithFrame:CGRectMake(200, (480-44-49-20)/2-50, 320, (480-44-49-20)/2)]autorelease];
    _movieCountLabel.text=@"1/37";
    
    _movieCountLabel.textColor=[UIColor whiteColor];
    _movieCountLabel.backgroundColor=[UIColor clearColor];
    _movieCountLabel.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:_movieCountLabel];
    
}

-(void)createMovieNameLabel
{
    _movieNameLabel=[[[UILabel alloc]initWithFrame:CGRectMake(70, 250, 320, 50)]autorelease];
    _movieNameLabel.text=@"被偷走的那五年";
    _movieNameLabel.textColor=[UIColor whiteColor];
    _movieNameLabel.backgroundColor=[UIColor clearColor];
    _movieNameLabel.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:_movieNameLabel];

}

-(void)createAssessLabel
{
    _assessLabel=[[[UILabel alloc]initWithFrame:CGRectMake(145, 5, 40, 30)]autorelease];
    _assessLabel.text=@"5";
    
    _assessLabel.textColor=[UIColor orangeColor];
    _assessLabel.backgroundColor=[UIColor clearColor];
    _assessLabel.font=[UIFont boldSystemFontOfSize:20];
    [_movieNameLabel addSubview:_assessLabel];
    
}

-(void)createAssessLabel2
{
    _assessLabel2=[[[UILabel alloc]initWithFrame:CGRectMake(160, 0, 40, 30)]autorelease];
    _assessLabel2.text=@".1";
    
    _assessLabel2.textColor=[UIColor orangeColor];
    _assessLabel2.backgroundColor=[UIColor clearColor];
    _assessLabel2.font=[UIFont systemFontOfSize:17];
    [_movieNameLabel addSubview:_assessLabel2];
    
}

-(void)createShowTimeLabel
{
    _showTimeLabel=[[[UILabel alloc]initWithFrame:CGRectMake(5, 280, 320, 30)]autorelease];
    
    _showTimeLabel.text=@"2013年08月29日上映-今日101家影院上映670场";
    
    _showTimeLabel.textColor=[UIColor whiteColor];
    _showTimeLabel.backgroundColor=[UIColor clearColor];
    _showTimeLabel.font=[UIFont systemFontOfSize:14];
    [self.view addSubview:_showTimeLabel];
    
}

- (void)createMovieDiscription
{
    
    _dicriptionLabel=[[[UILabel alloc]initWithFrame:CGRectMake(40, 330, 320, 30)]autorelease];
    
    _dicriptionLabel.text=@"有些人，在心底从来没忘记";
    
    _dicriptionLabel.textColor=[UIColor orangeColor];
    _dicriptionLabel.backgroundColor=[UIColor clearColor];
    _dicriptionLabel.font=[UIFont systemFontOfSize:20];
    [self.view addSubview:_dicriptionLabel];
}

- (void)createMovieStory
{
    _storyLabel=[[[UILabel alloc]initWithFrame:CGRectMake(10, 305, 320, 30)]autorelease];
    
    _storyLabel.text=@"爱情/喜剧";
    _storyLabel.textAlignment=NSTextAlignmentLeft;
    _storyLabel.textColor=[UIColor whiteColor];
    _storyLabel.backgroundColor=[UIColor clearColor];
    _storyLabel.font=[UIFont systemFontOfSize:18];
    [self.view addSubview:_storyLabel];
}

- (void)createCommaImageView
{
    UIImageView *imageView=[[[UIImageView alloc]initWithFrame:CGRectMake(23, 335, 15, 20)]autorelease];
    imageView.tag=kCommaImageViewTag;
    imageView.image=[UIImage imageNamed:@"btn_marks_1.png"];
    [self.view addSubview:imageView];
    
}

- (void)createfindAndBuyTicketSegment
{
   
    UIButton *findTicketbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    findTicketbtn.frame=CGRectMake(185, 305, 55, 30);
    [findTicketbtn setBackgroundImage:[UIImage imageNamed:@"btn_green_1_L.png"] forState:UIControlStateNormal];
    [findTicketbtn setTitle:@"查影讯" forState:UIControlStateNormal];
    findTicketbtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:findTicketbtn];
    
    UIButton *buyTicketbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    buyTicketbtn.tag=kBuyTicketbtnTag;
    buyTicketbtn.frame=CGRectMake(240, 305, 55, 30);
    [buyTicketbtn setBackgroundImage:[UIImage imageNamed:@"btn_orange_1_L.png"] forState:UIControlStateNormal];
    [buyTicketbtn setTitle:@"购票" forState:UIControlStateNormal];
    buyTicketbtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [self.view addSubview:buyTicketbtn];
    
    
}

#pragma mark-icarouselDatesource
- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{

    return [_dataArray count];
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    NSDictionary *dict = [_dataArray objectAtIndex:index];
    NSString *imgPath = [dict objectForKey:@"img"];
   
   
    NSURL *url = [NSURL URLWithString:imgPath];
    
    if (view == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 250, 230)];
        [imageView setImageWithURL:url];
        imageView.contentMode=UIViewContentModeScaleAspectFit;
        return imageView;
    }

    UIImageView *imageView = (UIImageView *)view;
    [imageView setImageWithURL:url];
    return imageView;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    NSLog(@"%d",carousel.currentItemIndex);
    
    NSDictionary *dict = [_dataArray objectAtIndex:carousel.currentItemIndex];
    
    //电影名
    NSString *movieNameStr=[dict objectForKey:@"t"];
     _movieNameLabel.text=movieNameStr;
    _movieNameStrLength=movieNameStr.length;
    NSLog(@"_movieNameStrLength%d",_movieNameStrLength*20);
    _assessLabel.center=CGPointMake(_movieNameStrLength*20+25,15);
    _assessLabel2.center=CGPointMake(_movieNameStrLength*20+25+10,10);
    
    
    //评价分数
    NSNumber * assessLabelText=[dict objectForKey:@"r"];
    NSString *aStr=[NSString stringWithFormat:@"%.1f",assessLabelText.floatValue];
    _assessLabel.text=[aStr substringToIndex:1];
    _assessLabel2.text=[aStr substringFromIndex:1];
    NSLog(@"aaa%@",_assessLabel.text);
    
    //放映时间
    NSString *showTime=[dict objectForKey:@"rd"];
   
    //放映影院数
    NSNumber *showCinemaCount=[dict objectForKey:@"NearestCinemaCount"];
    
    //播放次数
    NSNumber *showCount=[dict objectForKey:@"NearestShowtimeCount"];
    
    _showdateStr=[NSMutableString stringWithString:showTime];
    [_showdateStr insertString:@"年" atIndex:4];
    [_showdateStr insertString:@"月" atIndex:7];
    [_showdateStr insertString:@"日上映-今日" atIndex:10];
    
    [_showdateStr insertString:[NSString stringWithFormat:@"%d",showCinemaCount.intValue] atIndex:16];
    NSLog(@"%@",_showdateStr);
    
    NSString *str=@"家影院上映";
    NSMutableString *showCountStr=[NSMutableString stringWithString:str];
    [showCountStr insertString:[NSString stringWithFormat:@"%d",showCount.intValue] atIndex:5];
    NSLog(@"%@",showCountStr);
    NSString *str2=@"场";
    NSMutableString *str3=[NSMutableString stringWithFormat:@"%@%@%@",_showdateStr,showCountStr,str2];
    _showTimeLabel.text=str3;
    NSLog(@"str3%@",str3);
    
   
    //影片描述
    NSString *discriptionStr=[dict objectForKey:@"commonSpecial"];
     UIImageView *commaImageView=(UIImageView *)[self.view viewWithTag:kCommaImageViewTag];
    if ([discriptionStr isEqualToString:@""] || nil==discriptionStr ) {
       
        commaImageView.hidden=YES;
    }else{
        commaImageView.hidden=NO;
    }
    _dicriptionLabel.text=discriptionStr;
    
    
    //剧情
    NSArray *movieStoryArray=[dict objectForKey:@"p"];
    NSMutableString *storyStr=[[NSMutableString alloc]initWithCapacity:0];
   
    for (NSString *str in movieStoryArray) {
        NSLog(@"%@",str);
        [storyStr appendFormat:@"%@", str];
       
    }
   
    for (int i=2; i<storyStr.length; i=i+3) {
        [storyStr insertString:@"/" atIndex:i];
    }
    NSLog(@"mmmm%@",storyStr);
    
    if (storyStr.length>5) {
        NSString *storyStr2=[storyStr substringToIndex:5];
        NSLog(@"xxx%@",storyStr2);
        storyStr=[NSMutableString stringWithFormat:@"%@",storyStr2];
    }
  
    
    
    NSLog(@"%@",storyStr);
    //片长
    NSString *allTime=[dict objectForKey:@"d"];
    NSString *allTimeAppend=[allTime stringByAppendingString:@" - "];
    allTimeAppend = [NSString stringWithFormat:@"%@", allTimeAppend];
    [storyStr insertString:allTimeAppend atIndex:0];
    _storyLabel.text=storyStr;
    NSLog(@"%@",movieNameStr);
   
    
    
    NSLog(@"flag%@",[dict objectForKey:@"isTicket"]);
    //是否有票,无票则隐藏购票按钮
    NSNumber *num=[dict objectForKey:@"isTicket"];
    BOOL flag=num.boolValue;
    UIButton *btn=(UIButton *)[self.view viewWithTag:kBuyTicketbtnTag];
    if (!flag) {
        btn.hidden=YES;
    }else{
    
        btn.hidden=NO;
    }
    
    
    //第几部电影
    _movieCountLabel.text=[NSString stringWithFormat:@"%d/%d",carousel.currentItemIndex+1,[_dataArray count]];
    
}

#pragma mark-icarouselDelegate
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    
    ZHUMovieContentTableViewController *movieContent=[[ZHUMovieContentTableViewController alloc]init];
    
    ZHUCustomTabBarController *tab=(ZHUCustomTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;

    tab.customTabBar.hidden=YES;
    tab.tabBar.hidden=YES;
    tab.view.frame = CGRectMake(0, 0, 320, tab.view.frame.size.height+49);
    
    tab.view.backgroundColor = [UIColor clearColor];
    [self.navigationController pushViewController:movieContent animated:YES];
    

}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    
    if (option == iCarouselOptionSpacing)
    {
        return value * 1.1f;
    }
    return value;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
