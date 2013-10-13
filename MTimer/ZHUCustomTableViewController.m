//
//  ZHUCustomTableViewController.m
//  MTimer
//
//  Created by apple on 13-8-30.
//  Copyright (c) 2013年 HelloZHU. All rights reserved.
//

#import "ZHUCustomTableViewController.h"
#import "ZHUIndexViewController.h"
#import "ZHUCustomViewCell.h"
#import "JSONKit.h"
#import "UIImageView+WebCache.h"
#import "ZHUCustomTabBarController.h"

#define kTitleLeftBthTag        12
#define kTitleRightBthTag       13
#define kImageViewTag           14
#define kMovieNameLabelTag      15
#define kMovieStoryLabelTag     16
#define kDirectorLabelTag       17
#define kleftBtnTag             18
#define kRightBtnTag            19
#define kReleaseDateLabelTag    20
#define kMonthLabelTag          21
#define kImageView2Tag          22
#define kImageView3Tag          23
#define kDayLabelTag            24

@interface ZHUCustomTableViewController ()
{
    NSMutableArray *_dataArray;
    NSMutableArray *_releaseDateMutArray;
    NSMutableArray *_isSameMonthArray;
    NSMutableArray *_isSameDayArray;
    UILabel *releaseDateLabel;
    NSMutableArray *_monthArray;
    NSMutableArray *_dayArray;
}
@end

@implementation ZHUCustomTableViewController

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
    
    //去数据
    NSString *dataPath=[[[NSBundle mainBundle]resourcePath] stringByAppendingPathComponent:@"即将上映.json"];
    NSString *jsonStr=[NSString stringWithContentsOfFile:dataPath encoding:NSUTF8StringEncoding error:nil];
    // NSLog(@"%@",jsonStr);
    _dataArray=[[jsonStr objectFromJSONString]retain];
    //NSLog(@">>>%d",[_dataArray count]);
    _releaseDateMutArray=[[NSMutableArray arrayWithCapacity:1]retain];
    
    for (NSDictionary * dict in _dataArray) {
        NSString *releaseDateStr=[dict objectForKey:@"releaseDate"];
        [_releaseDateMutArray addObject:releaseDateStr];
    }
  //  NSLog(@"_releaseDateMutArray%d",[_releaseDateMutArray count]);
    NSNumber *num=@1;
    _isSameMonthArray=[[NSMutableArray alloc]initWithCapacity:1];
    [_isSameMonthArray addObject:num];
   
    _isSameDayArray=[[NSMutableArray alloc]initWithCapacity:1];
    [_isSameMonthArray addObject:num];
    
    _monthArray=[[NSMutableArray alloc]initWithCapacity:1];
    _dayArray=[[NSMutableArray alloc] initWithCapacity:1];
    
    
    
    
//    _myTableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
//    _myTableView.dataSource=self;
//    _myTableView.delegate=self;
//    _myTableView.separatorColor=[UIColor clearColor];
    
    
    
    
    [self createReleaseDateLabel];
    [self createTitleButton];
    [self createNavBarLeftAndRightBtn];
    [self compareDateStr];
    
}

 //将前一个日期与后一个比较,月份是否相同，相同则往数组写入1，反之写入0
- (void)compareDateStr
{
    
   
    
    //比较月份
    for (int i=1; i<[_releaseDateMutArray count]; i++) {
        
        NSString *str1=[_releaseDateMutArray objectAtIndex:i-1];
        NSString *str2=[_releaseDateMutArray objectAtIndex:i];
        
        // 取月份，日期
        NSRange monthRange1=[str1 rangeOfString:@"月"];
        NSString *monthStr1=[str1 substringToIndex:monthRange1.location];
        NSRange monthRange2=[str2 rangeOfString:@"月"];
        NSString *monthStr2=[str2 substringToIndex:monthRange2.location];
        
        NSRange dayRange1=[str1 rangeOfString:@"日"];
        NSString *dayStr1=[str1 substringWithRange:NSMakeRange(monthRange1.location+1, dayRange1.location-monthRange1.location-1)];
        NSRange dayRange2=[str2 rangeOfString:@"日"];
        NSString *dayStr2=[str2 substringWithRange:NSMakeRange(monthRange2.location+1, dayRange2.location-monthRange2.location-1)];
        NSLog(@"day1-day2,%@-%@",monthStr2,dayStr2);
        
        //比较月份
        if ([monthStr1 isEqualToString:monthStr2]) {
            NSNumber *same=@1;
            
            [_isSameMonthArray addObject:same];
            
        }else{
            
            NSNumber *different=@0;
            [_isSameMonthArray addObject:different];
        }
        
        //比较日
        if ([dayStr1 isEqualToString:dayStr2]) {
            NSNumber *same=@1;
            [_isSameDayArray addObject:same];
        } else {
           
            NSNumber *different=@0;
            [_isSameDayArray addObject:different];
        }
     }
    
    // NSLog(@"_day%d",[_isSameDayArray count]);
    //NSLog(@"_day%@",_isSameDayArray);
}

- (void)createReleaseDateLabel
{
 
    
   
    

}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
     NSDictionary *dataDict=[_dataArray objectAtIndex:indexPath.row];
    //放映时间
    NSString *releaseDateStr=[dataDict objectForKey:@"releaseDate"];
    //取到‘月’，‘日’的位置
    NSRange monthRange=[releaseDateStr rangeOfString:@"月"];
    NSRange dayRange=[releaseDateStr rangeOfString:@"日"];
    NSString *monthStr=[releaseDateStr substringToIndex:monthRange.location];
    
    NSString *dayStr=[releaseDateStr substringWithRange:NSMakeRange(monthRange.location+1, dayRange.location-monthRange.location-1)];
    
    [_monthArray addObject:monthStr];
    [_dayArray addObject:dayStr];
    
    ZHUCustomViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        cell = [[[ZHUCustomViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        UIImageView *backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(35, 3, 280, 105)];
        
        backImageView.image=[UIImage imageNamed:@"dialogbox_index.png"];
        [cell.contentView addSubview:backImageView];
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(45, 7, 100-5, 92+2+3)];
        imageView.tag=kImageViewTag;
        [cell.contentView addSubview:imageView];
        
        UILabel *movieNameLabel=[[UILabel alloc]initWithFrame:CGRectMake(148, 5+3, 320-145, 20)];
        movieNameLabel.tag=kMovieNameLabelTag;
        movieNameLabel.backgroundColor=[UIColor clearColor];
        movieNameLabel.font=[UIFont boldSystemFontOfSize:15];
        [cell.contentView addSubview:movieNameLabel];
        
        UILabel *movieStoryLabel=[[UILabel alloc]initWithFrame:CGRectMake(148, 25+3, 320-145, 20)];
        movieStoryLabel.tag=kMovieStoryLabelTag;
        movieStoryLabel.backgroundColor=[UIColor clearColor];
        movieStoryLabel.textColor=[UIColor grayColor];
        movieStoryLabel.font=[UIFont systemFontOfSize:13];
        [cell.contentView addSubview:movieStoryLabel];
        
        UILabel *directorLabel=[[UILabel alloc]initWithFrame:CGRectMake(148, 25+20+3, 320-145, 20)];
        directorLabel.tag=kDirectorLabelTag;
        directorLabel.backgroundColor=[UIColor clearColor];
        directorLabel.font=[UIFont systemFontOfSize:13];
        directorLabel.textColor=[UIColor grayColor];
        [cell.contentView addSubview:directorLabel];
        
        UIButton *leftBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame=CGRectMake(148, 25+20+10+20, 75, 25);
        leftBtn.tag=kleftBtnTag;
        [leftBtn setTitle:@"预告片" forState:UIControlStateNormal];
        leftBtn.titleLabel.font=[UIFont systemFontOfSize:13];        
        [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        leftBtn.titleEdgeInsets=UIEdgeInsetsMake(3, 25, 5, 2);
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"ele_trailer_enable.png"] forState:UIControlStateNormal];
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"ele_trailer.png"] forState:UIControlStateDisabled];
        [cell.contentView addSubview:leftBtn];
        
        UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        rightBtn.frame=CGRectMake(148+75, 25+20+10+20, 75, 25);
        
        [rightBtn setTitle:@"提醒" forState:UIControlStateNormal];
       // [rightBtn setTitle:@"取消提醒" forState:UIControlStateNormal];
        rightBtn.titleLabel.font=[UIFont systemFontOfSize:13];
       // rightBtn.highlighted=YES;
        rightBtn.tag=kRightBtnTag;
       // [rightBtn setBackgroundImage:[UIImage imageNamed:@"ele_remind_on.png"] forState:UIControlStateNormal ];
        [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        rightBtn.titleEdgeInsets=UIEdgeInsetsMake(3, 15, 5, 0);
        [rightBtn setBackgroundImage:[UIImage imageNamed:@"ele_remind.png"] forState:UIControlStateNormal];
        [cell.contentView addSubview:rightBtn];
        
        // 日期线条
        UIImageView *imageView3=[[UIImageView alloc]initWithFrame:CGRectMake(18, 0, 3, 112)];
       
        imageView3.image=[UIImage imageNamed:@"fenlan.png"];
        imageView3.hidden=NO;
        imageView3.tag=kImageView3Tag;
        [cell.contentView addSubview:imageView3];
        
        //日期Label
        UILabel *dayLabel=[[UILabel alloc]initWithFrame:CGRectMake(13,20,20,20)];
        dayLabel.tag=kDayLabelTag;
        dayLabel.backgroundColor=[UIColor whiteColor];
        dayLabel.font=[UIFont systemFontOfSize:17];
        dayLabel.textColor=[UIColor blackColor];
        dayLabel.text=@"17";
        dayLabel.hidden=YES;
        [cell.contentView addSubview:dayLabel];
        
        
        
        
        
        
        
    }
   
    //取图片
    NSString *imagePath=[dataDict objectForKey:@"image"];
    NSURL *imageUrl=[NSURL URLWithString:imagePath];
    UIImageView *imageView=(UIImageView *)[cell.contentView viewWithTag:kImageViewTag];
    [imageView setImageWithURL:imageUrl];
    
    //电影名
    NSString *movieNameStr=[dataDict objectForKey:@"title"];
    UILabel *movieNameLabel=(UILabel *)[cell.contentView viewWithTag:kMovieNameLabelTag];
    movieNameLabel.text=movieNameStr;
    
    //剧情
    NSString *movieStoryStr=[dataDict objectForKey:@"type"];
    if (movieStoryStr.length>8) {
        movieStoryStr=[movieStoryStr substringToIndex:8];
    }
    UILabel *movieStoryLabel=(UILabel *)[cell.contentView viewWithTag:kMovieStoryLabelTag];
    
    
    //想看的人数
    NSNumber *wantedNum=[dataDict objectForKey:@"wantedCount"];
    NSString *wantedCountAndTypeStr=[NSString stringWithFormat:@"%@人想看-%@",wantedNum,movieStoryStr];
    movieStoryLabel.text=wantedCountAndTypeStr;
    
    //导演
    NSString *directorStr=[dataDict objectForKey:@"director"];
    directorStr=[NSString stringWithFormat:@"导演: %@",directorStr];
    //NSLog(@"%@",directorStr);
    UILabel *directorLabel=(UILabel *)[cell.contentView viewWithTag:kDirectorLabelTag];
    directorLabel.text=directorStr;
    
    //是否有预告片
    NSNumber *isVideoNum=[dataDict objectForKey:@"isVideo"];
    UIButton *leftBtn=(UIButton *)[cell.contentView viewWithTag:kleftBtnTag];
    BOOL flag=isVideoNum.boolValue;
    if (!flag) {
        
        leftBtn.enabled = NO;
//        [leftBtn addTarget:nil action:nil forControlEvents:UIControlEventTouchUpInside];
    }else {
        leftBtn.enabled = YES;
    }
    
    
    NSIndexPath *index=[tableView indexPathForRowAtPoint:tableView.contentOffset];
    tableView.separatorColor=[UIColor clearColor];
    releaseDateLabel.text=[_dayArray objectAtIndex:index.row];
    
    if ([[_isSameMonthArray objectAtIndex:indexPath.row]intValue]==1 && [[_isSameDayArray objectAtIndex:indexPath.row]intValue]==1 ) {
        
        UILabel *dayLabel=(UILabel *)[cell.contentView viewWithTag:kDayLabelTag];
        dayLabel.hidden=YES;
        
    }else if ([[_isSameMonthArray objectAtIndex:indexPath.row]intValue]==1 && [[_isSameDayArray objectAtIndex:indexPath.row]intValue]==0 ) {
        
        UILabel *dayLabel=(UILabel *)[cell.contentView viewWithTag:kDayLabelTag];
        dayLabel.hidden=NO;
        dayLabel.text=dayStr;
        
    }

    
    
    
    
    
    
    
    return cell;
}

- (void)createNavBarLeftAndRightBtn
{
    
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
    [titleRightBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [titleRightBth addTarget:self action:@selector(changeIndexView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *titleLeftBth=[UIButton buttonWithType:UIButtonTypeCustom];
    titleLeftBth.frame=CGRectMake(80, 0, 80, 30);
    titleLeftBth.tag=kTitleLeftBthTag;
    [titleLeftBth setBackgroundImage:[UIImage imageNamed:@"ico_index_title_2.png"] forState:UIControlStateNormal];
    [titleLeftBth setTitle:@"即将上映" forState:UIControlStateNormal];
    [titleLeftBth setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [titleLeftBth addTarget:self action:@selector(changeIndexView:) forControlEvents:UIControlEventTouchUpInside];
    
    [myview addSubview:titleImageView];
    [myview addSubview:titleLeftBth];
    [myview addSubview:titleRightBth];
    
    UIView *dateView=[[UIView alloc]initWithFrame:CGRectMake(-80, 37, 40, 50)];
    dateView.backgroundColor=[UIColor whiteColor];
    //日期dayLabel
    releaseDateLabel=[[UILabel alloc]initWithFrame:CGRectMake(10,0,35,50)];
    releaseDateLabel.tag=kReleaseDateLabelTag;
    releaseDateLabel.backgroundColor=[UIColor whiteColor];
    releaseDateLabel.textAlignment=NSTextAlignmentLeft;
    releaseDateLabel.font=[UIFont systemFontOfSize:17];
    releaseDateLabel.textColor=[UIColor blackColor];
    releaseDateLabel.text=@"29";
    
    releaseDateLabel.hidden=NO;
    [dateView addSubview:releaseDateLabel];
    [myview addSubview:dateView];
   
    
    //分栏条
    UIImageView *imageView2=[[[UIImageView alloc]initWithFrame:CGRectMake(10, 38, 20, 3)]autorelease];
    imageView2.image=[UIImage imageNamed:@"CommingViewSeperator.png"];
    imageView2.hidden=NO;
    imageView2.tag=kImageView2Tag;
    [dateView addSubview:imageView2];
    
    //日期monthLabel
    UILabel *monthLabel=[[UILabel alloc]initWithFrame:CGRectMake(13,38+2,20,20)];
    monthLabel.tag=kMonthLabelTag;
    monthLabel.backgroundColor=[UIColor whiteColor];
    monthLabel.font=[UIFont systemFontOfSize:15];
    monthLabel.textColor=[UIColor greenColor];
    monthLabel.text=@"10";
    monthLabel.hidden=NO;
    [dateView addSubview:monthLabel];
    
    self.navigationItem.titleView=myview;
    
    
}
- (void)changeIndexView:(id)sender
{
    NSLog(@"changeview");
    UIButton *btn=(UIButton *)sender;
    if (btn.tag==kTitleRightBthTag){
        
        
        ZHUCustomTabBarController *tabBarControl = (ZHUCustomTabBarController *)[[UIApplication  sharedApplication] keyWindow].rootViewController;
        
        if (tabBarControl.indexViewController==nil) {
            
            tabBarControl.indexViewController=[[[ZHUIndexViewController alloc]init] autorelease];
        }
        
        
        [self.navigationController setViewControllers:[NSArray arrayWithObject:tabBarControl.indexViewController]];
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (480-20-44-49)/4+15+5;
}


    


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
