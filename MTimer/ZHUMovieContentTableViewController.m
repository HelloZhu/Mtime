//
//  ZHUMovieContentTableViewController.m
//  MTimer
//
//  Created by apple on 13-9-2.
//  Copyright (c) 2013年 HelloZHU. All rights reserved.
//

#import "ZHUMovieContentTableViewController.h"
#import "ZHUCustomTabBarController.h"
#import "JSONKit.h"
#import "UIImageView+WebCache.h"
#import "ZHUMovieImgViewController.h"

#define kImageViewTag           10
#define kAssessLabelTag         11
#define kAssessLabel2Tag        12
#define kTypeLabelTag           13
#define kTimeLabelTag           14
#define kShowTimeLabelTag       15
#define kBuyTicketbtnTag        16
#define kDiscriptionLabelTag    17
#define kCellBackImageViewTag   18
#define kDirectorLabelTag       19
#define kActorLabelTag          20
#define kMovieImageView1Tag     21
#define kMovieImageView2Tag     22
#define kMovieImageView3Tag     23
#define kMovieImageView4Tag     24
#define kHeadImageViewTag       25
#define kNameLabelTag           26
#define kScoreLabelTag          27
#define kAccessLabelTag         28
#define kScoreLabelTag2         29
#define kStoryLabelTag          30
#define kBackImageViewTag       31
#define kLineImageViewTag       32

@interface ZHUMovieContentTableViewController ()
{
    NSDictionary *_dataDict;
    NSArray *_accessArray;
//    UILabel *_titleLabel1;
//    UILabel *_titleLabel2;
    
    UITableView *_movieContentTableView;
    UILabel *discriptionLabel;
    UIImageView *cellBackImageView;
    NSString *disStr;
    BOOL flag;
    UIImageView *btnImageView;
    UIImageView *btnImageView2;
    BOOL    isHidden;
    UIView *_headerView;
    UILabel *_firstLabel;
    UILabel *_secondLabel;
    UILabel *_thirdLabel;
    UILabel *_fourthLabel;
}
@end

@implementation ZHUMovieContentTableViewController

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
	// Do any additional setup after loading the view.
    flag=NO;
    isHidden=NO;
    _movieContentTableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _movieContentTableView.delegate=self;
    _movieContentTableView.dataSource=self;
   _movieContentTableView.separatorColor=[UIColor clearColor];
    [self.view addSubview:_movieContentTableView];
    
    //读取数据
    NSString *path=[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"影片详情.json"];
    NSString *josnStr=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    _dataDict=[[josnStr objectFromJSONString]retain];
    //NSLog(@"%@",_dataDict);
    
    _accessArray=[_dataDict objectForKey:@"cts"];
    
    NSLog(@"_accessArray%d",[_accessArray count]);
    
    
    
    
    [self operateNavigationLeftBar];
    
    
    

    
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
    _titleLabel1=[[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)]autorelease];
    _titleLabel1.backgroundColor=[UIColor clearColor];
    [_titleLabel1 setTextAlignment:(NSTextAlignmentCenter)];
    _titleLabel1.textColor=[UIColor whiteColor];
    [titleView addSubview:_titleLabel1];
    
    _titleLabel2=[[[UILabel alloc]initWithFrame:CGRectMake(0, 23, 200, 13)]autorelease];
    _titleLabel2.backgroundColor=[UIColor clearColor];
    [_titleLabel2 setTextAlignment:(NSTextAlignmentCenter)];
    _titleLabel2.font=[UIFont systemFontOfSize:12];
    _titleLabel2.textColor=[UIColor whiteColor];
    
    [titleView addSubview:_titleLabel1];
    [titleView addSubview:_titleLabel2];
    self.navigationItem.titleView=titleView;
    
    
}
- (void)gotoIndex
{
    
    
    ZHUCustomTabBarController *tab=(ZHUCustomTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    
    tab.customTabBar.hidden=NO;
    tab.tabBar.hidden=NO;
    tab.view.frame = CGRectMake(0, 0, 320, tab.view.frame.size.height-49);
    [self.navigationController popViewControllerAnimated:YES];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int  rows;
    switch (section) {
        case 0:
            rows=1;
            break;
        case 1:
            rows=1;
            break;
        case 2:
            rows=1;
            break;
        case 3:
           rows=1;
            break;
        case 4:
            rows=[_accessArray count];
            break;
        
    }
    return rows;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    static NSString *CellIdentifier = @"Cell";
    static NSString *topCellIdent=@"topCell";
    static NSString *storyCellIdent=@"storyCell";
    static NSString *director=@"director";
    static NSString *movieImg=@"movieimg";
//    UITableViewCell *topCell=[tableView dequeueReusableCellWithIdentifier:topCellIdent ];
    
    if (indexPath.section==0) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:topCellIdent];
        
        if (cell == nil) {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:topCellIdent] autorelease];
            
            UIImageView *backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height/2)];
            backImageView.image=[UIImage imageNamed:@"star_bg.png"];
            [cell.contentView addSubview:backImageView];
            
            UIImageView *lineimageView=[[UIImageView alloc]initWithFrame:CGRectMake(6, 6, 320/3+2, self.view.bounds.size.height/2-60+2-5)];
            lineimageView.backgroundColor=[UIColor whiteColor];
            [cell.contentView addSubview:lineimageView];
            UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(7, 7, 320/3, self.view.bounds.size.height/2-60-5)];
            imageView.tag=kImageViewTag;
            [cell.contentView addSubview:imageView];
            
            //总评分Label
            UILabel *scoreLabel=[[[UILabel alloc]initWithFrame:CGRectMake(7+320/3+10, 7+5, 100, 20)]autorelease];
            scoreLabel.backgroundColor=[UIColor clearColor];
            scoreLabel.text=@"总评分:";
            scoreLabel.textColor=[UIColor whiteColor];
            scoreLabel.font=[UIFont systemFontOfSize:15];
            [cell.contentView addSubview:scoreLabel];
            
            //分数1
            UILabel *_assessLabel=[[[UILabel alloc]initWithFrame:CGRectMake(7+320/3+10+55, 7+5, 100, 20)]autorelease];
            _assessLabel.text=@"7";
            _assessLabel.tag=kAssessLabelTag;
            _assessLabel.textColor=[UIColor orangeColor];
            _assessLabel.backgroundColor=[UIColor clearColor];
            _assessLabel.font=[UIFont boldSystemFontOfSize:17];
            [cell.contentView addSubview:_assessLabel];
            //分数2
           UILabel *_assessLabel2=[[[UILabel alloc]initWithFrame:CGRectMake(7+320/3+10+55+10, 7, 100, 20)]autorelease];
            _assessLabel2.text=@".1";
            _assessLabel2.tag=kAssessLabel2Tag;
            _assessLabel2.textColor=[UIColor orangeColor];
            _assessLabel2.backgroundColor=[UIColor clearColor];
            _assessLabel2.font=[UIFont systemFontOfSize:15];
            [cell.contentView addSubview:_assessLabel2];
            
            //类型Label
            UILabel *typeLabel=[[[UILabel alloc]initWithFrame:CGRectMake(7+320/3+10, 7+5+20+10, 200, 20)]autorelease];
            typeLabel.tag=kTypeLabelTag;
            typeLabel.backgroundColor=[UIColor clearColor];
            //typeLabel.text=@"类型: 冒险/科幻";
            typeLabel.textColor=[UIColor whiteColor];
            typeLabel.font=[UIFont systemFontOfSize:15];
            [cell.contentView addSubview:typeLabel];
            
            //时长
            UILabel *timeLabel=[[[UILabel alloc]initWithFrame:CGRectMake(7+320/3+10, 7+5+20+20+10+10, 200, 20)]autorelease];
            timeLabel.tag=kTimeLabelTag;
            timeLabel.backgroundColor=[UIColor clearColor];
            timeLabel.text=@"时长: 127分钟";
            timeLabel.textColor=[UIColor whiteColor];
            timeLabel.font=[UIFont systemFontOfSize:15];
            [cell.contentView addSubview:timeLabel];
            
            //放映时间
            UILabel *showTimeLabel=[[[UILabel alloc]initWithFrame:CGRectMake(7+320/3+10, 7+5+20+20+20+10+20, 200, 20)]autorelease];
            showTimeLabel.tag=kShowTimeLabelTag;
            showTimeLabel.backgroundColor=[UIColor clearColor];
            //showTimeLabel.text=@"2013年8月20日中国上映";
            showTimeLabel.textColor=[UIColor whiteColor];
            showTimeLabel.font=[UIFont systemFontOfSize:15];
            [cell.contentView addSubview:showTimeLabel];
            
            UIButton *findTicketbtn=[UIButton buttonWithType:UIButtonTypeCustom];
            findTicketbtn.frame=CGRectMake(7+320/3+10, 7+5+20+20+20+10+20+30, 55, 30);
            [findTicketbtn setBackgroundImage:[UIImage imageNamed:@"btn_green_1_L.png"] forState:UIControlStateNormal];
            [findTicketbtn setTitle:@"查影讯" forState:UIControlStateNormal];
            findTicketbtn.titleLabel.font=[UIFont systemFontOfSize:13];
            [cell.contentView addSubview:findTicketbtn];
            
            UIButton *buyTicketbtn=[UIButton buttonWithType:UIButtonTypeCustom];
            buyTicketbtn.tag=kBuyTicketbtnTag;
            buyTicketbtn.frame=CGRectMake(7+320/3+10+56, 7+5+20+20+20+10+20+30, 55, 30);
            [buyTicketbtn setBackgroundImage:[UIImage imageNamed:@"btn_orange_1_L.png"] forState:UIControlStateNormal];
            [buyTicketbtn setTitle:@"购票" forState:UIControlStateNormal];
            buyTicketbtn.titleLabel.font=[UIFont systemFontOfSize:13];
            [cell.contentView addSubview:buyTicketbtn];
            
            //分割线
            UIImageView *diveLineImgeView=[[UIImageView alloc]initWithFrame:CGRectMake(5, 20+self.view.bounds.size.height/2-60-5, 320-10, 1)];
            diveLineImgeView.image=[UIImage imageNamed:@"ele_tipbg_middle.png"];
            [cell.contentView addSubview:diveLineImgeView];
            
            UIButton *accessBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            accessBtn.frame=CGRectMake(40, 20+self.view.bounds.size.height/2-60-5+5, 39/2, 36/2);
            [accessBtn setBackgroundImage:[UIImage imageNamed:@"ele_icon_grade.png"] forState:UIControlStateNormal];
            [cell.contentView addSubview:accessBtn];
            UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(40, 20+self.view.bounds.size.height/2-60-5+5+20, 39, 36/2)];
            label1.text=@"评分";
            label1.font=[UIFont systemFontOfSize:12];
            label1.textColor=[UIColor whiteColor];
            label1.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:label1];
            
            UIButton *likeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            likeBtn.frame=CGRectMake(320/3+40, 20+self.view.bounds.size.height/2-60-5+5, 39/2, 36/2);
            [likeBtn setBackgroundImage:[UIImage imageNamed:@"ele_icon_fav.png"] forState:UIControlStateNormal];
            [cell.contentView addSubview:likeBtn];
            UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(320/3+40-5, 20+self.view.bounds.size.height/2-60-5+5+20, 39, 36/2)];
            label2.text=@"收藏";
            label2.font=[UIFont systemFontOfSize:12];
            label2.textColor=[UIColor whiteColor];
            label2.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:label2];
            
            
            UIButton *sendBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            sendBtn.frame=CGRectMake(320/2+50+40, 20+self.view.bounds.size.height/2-60-5+5, 39/2, 36/2);
            [sendBtn setBackgroundImage:[UIImage imageNamed:@"ele_icon_relay1.png"] forState:UIControlStateNormal];
            [cell.contentView addSubview:sendBtn];
            UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(320/2+50+25, 20+self.view.bounds.size.height/2-60-5+5+20, 100, 36/2)];
            label3.text=@"发给朋友";
            label3.font=[UIFont systemFontOfSize:12];
            label3.textColor=[UIColor whiteColor];
            label3.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:label3];
            
            UIImageView *LineImgeView1=[[UIImageView alloc]initWithFrame:CGRectMake(320/3-10, 20+self.view.bounds.size.height/2-55, 2, 31)];
            LineImgeView1.image=[UIImage imageNamed:@"line_ciname_both2.png"];
            [cell.contentView addSubview:LineImgeView1];
            
            UIImageView *LineImgeView2=[[UIImageView alloc]initWithFrame:CGRectMake(320/2+50, 20+self.view.bounds.size.height/2-55, 2, 31)];
            LineImgeView2.image=[UIImage imageNamed:@"line_ciname_both2.png"];
            [cell.contentView addSubview:LineImgeView2];
            
            
            
        }
        
        UIImageView *imageView=(UIImageView *)[cell.contentView viewWithTag:kImageViewTag];
        NSString *imgPath=[_dataDict objectForKey:@"img"];
        NSURL *imgUrl=[NSURL URLWithString:imgPath];
        [imageView setImageWithURL:imgUrl];
        
        //分数
        UILabel *aLabel=(UILabel *)[cell.contentView viewWithTag:kAssessLabelTag];
        UILabel *a2Label=(UILabel *)[cell.contentView viewWithTag:kAssessLabel2Tag];
        NSNumber *score=[_dataDict objectForKey:@"r"];
        NSString *scoreStr=[NSString stringWithFormat:@"%@",score];
        aLabel.text=[scoreStr substringToIndex:1];
        a2Label.text=[scoreStr substringFromIndex:1];
        
        //类型
        UILabel *typeLabel=(UILabel *)[cell.contentView viewWithTag:kTypeLabelTag];
        NSArray *typeArray=[_dataDict objectForKey:@"p"];
        NSMutableString *typeStr=[NSMutableString stringWithCapacity:1];
        for (NSString *str in typeArray) {
            
            [typeStr appendFormat:@"%@",str];
        }
        typeLabel.text=[NSString stringWithFormat:@"类型 :%@",typeStr];
        
        //时长
        UILabel *timeLabel=(UILabel *)[cell.contentView viewWithTag:kTimeLabelTag];
        timeLabel.text=[NSString stringWithFormat:@"时长 :%@", [_dataDict objectForKey:@"d"]];
        
        //放映时间
        NSString *showTimeStr=[_dataDict objectForKey:@"rd"];
        NSMutableString *showTimeMutStr=[NSMutableString stringWithFormat:@"%@",showTimeStr];
        [showTimeMutStr insertString:@"年" atIndex:4];
        [showTimeMutStr insertString:@"月" atIndex:7];
        [showTimeMutStr insertString:@"日" atIndex:10];
        //放映地点
        NSString *showLocationStr=[_dataDict objectForKey:@"rLocation"];
        
        UILabel *showTimeLabel=(UILabel *)[cell.contentView viewWithTag:kShowTimeLabelTag];
        showTimeLabel.text=[showTimeMutStr stringByAppendingFormat:@"%@放映",showLocationStr];
        
    
    }else if(indexPath.section==1 ){
    
        
        cell=[tableView dequeueReusableCellWithIdentifier:storyCellIdent];
        if (cell == nil) {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:storyCellIdent] autorelease];
            
             cellBackImageView=[[UIImageView alloc]initWithFrame:CGRectMake(34, 10, 280, self.view.frame.size.height/6)];
            cellBackImageView.tag=kCellBackImageViewTag;
            cellBackImageView.image=[UIImage imageNamed:@"pic_combox@2x.png"];
            [cell.contentView addSubview:cellBackImageView];
            
            discriptionLabel=[[UILabel alloc]initWithFrame:CGRectMake(50, 13, 250, self.view.frame.size.height/6-5)];
            discriptionLabel.backgroundColor=[UIColor clearColor];
            discriptionLabel.tag=kDiscriptionLabelTag;
            discriptionLabel.font=[UIFont systemFontOfSize:12];
            //discriptionLabel.adjustsLetterSpacingToFitWidth=YES;
            discriptionLabel.numberOfLines=0;            
            [cell.contentView addSubview:discriptionLabel];
            
            btnImageView=[[UIImageView alloc]initWithFrame:CGRectMake(300-5, self.view.frame.size.height/6-20, 15, 10)];
            btnImageView.image=[UIImage imageNamed:@"arrow_down@2x.png"];
            [cell.contentView addSubview:btnImageView];
            
            btnImageView2=[[UIImageView alloc]initWithFrame:CGRectMake(300-5, self.view.frame.size.height/6-20, 15, 10)];
            btnImageView2.image=[UIImage imageNamed:@"arrow_up@2x.png"];
            btnImageView2.hidden=YES;
            [cell.contentView addSubview:btnImageView2];
            
            
            UIImageView *lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 2, self.view.frame.size.height/6+30)];
            lineImageView.image=[UIImage imageNamed:@"fenlan.png"];
            [cell.contentView addSubview:lineImageView];
            

            
          
        }
       // UILabel *discriptionLabel=(UILabel *)[cell.contentView viewWithTag:kDiscriptionLabelTag];
        disStr =[_dataDict objectForKey:@"pt"];
        NSLog(@"hhhhhh%d", disStr.length*12/260*14);
        NSLog(@"dis%@",discriptionLabel);
        //变化后的高度
        //discriptionLabel.bounds=CGRectMake(50, 13, 260, disStr.length*12/260*14);
        discriptionLabel.text=disStr;
    
    }else if (indexPath.section==2){
    
        cell=[tableView dequeueReusableCellWithIdentifier:director];
        
        if (cell==nil) {
            
             cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:director] autorelease];
            
           UIImageView *backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(34, 0, 280, self.view.frame.size.height/6-20)];
           
            backImageView.image=[UIImage imageNamed:@"pic_combox@2x.png"];
            [cell.contentView addSubview:backImageView];
            
            UILabel *directorLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 250, 20)];
            directorLabel.text=@"导演";
            directorLabel.tag=kDirectorLabelTag;
            directorLabel.font=[UIFont systemFontOfSize:13];
            directorLabel.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:directorLabel];
            
            
            UILabel *actorLabel=[[UILabel alloc]initWithFrame:CGRectMake(40, 5+25, 250, 20)];
            actorLabel.text=@"主演";
            actorLabel.tag=kActorLabelTag;
            actorLabel.font=[UIFont systemFontOfSize:13];
            actorLabel.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:actorLabel];
            
           UIImageView *rightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(300-5,5+25 , 15, 10)];
            rightImageView.image=[UIImage imageNamed:@"myaccount_btn_3.png"];
            [cell.contentView addSubview:rightImageView];
            
           
            
            UIImageView *lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 2, self.view.frame.size.height/6)];
            lineImageView.image=[UIImage imageNamed:@"fenlan.png"];
            [cell.contentView addSubview:lineImageView];
        
        }
       
        UILabel *directorLabel=(UILabel *)[cell.contentView viewWithTag:kDirectorLabelTag];
        NSString *directorStr=[NSString stringWithFormat:@"导演: %@",[_dataDict objectForKey:@"dN"]];
        directorLabel.text=directorStr;
        
        
        UILabel *actorLabel=(UILabel *)[cell.contentView viewWithTag:kActorLabelTag];
        NSString *actorStr=[NSString stringWithFormat:@"主演: %@,%@",[_dataDict objectForKey:@"aN1"],[_dataDict objectForKey:@"aN2"]];
        actorLabel.text=actorStr;
        
      
    
    }else if (indexPath.section==3) {
        
        cell=[tableView dequeueReusableCellWithIdentifier:movieImg];
        if (cell == nil) {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:movieImg] autorelease];
            
            UIImageView *backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(32, 10, 280, self.view.frame.size.height/6-20+2)];
            
            backImageView.image=[UIImage imageNamed:@"pic_combox@2x.png"];
            [cell.contentView addSubview:backImageView];
            
            UIImageView *movieImageView1=[[UIImageView alloc]initWithFrame:CGRectMake(50, 10, 50, 50)];
            movieImageView1.tag=kMovieImageView1Tag;
            [cell.contentView addSubview:movieImageView1];
            
            UIImageView *movieImageView2=[[UIImageView alloc]initWithFrame:CGRectMake(40+55+10, 10, 50, 50)];
            movieImageView2.tag=kMovieImageView2Tag;
            [cell.contentView addSubview:movieImageView2];
            
            UIImageView *movieImageView3=[[UIImageView alloc]initWithFrame:CGRectMake(40+55+55+10, 10, 50, 50)];
            movieImageView3.tag=kMovieImageView3Tag;
            [cell.contentView addSubview:movieImageView3];
            
            UIImageView *movieImageView4=[[UIImageView alloc]initWithFrame:CGRectMake(40+55+55+55+10, 10, 50, 50)];
            movieImageView4.tag=kMovieImageView4Tag;
            [cell.contentView addSubview:movieImageView4];
            
            UIImageView *rightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(300-5,5+25 , 15, 10)];
            rightImageView.image=[UIImage imageNamed:@"myaccount_btn_3.png"];
            [cell.contentView addSubview:rightImageView];

            UIImageView *lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 2, self.view.frame.size.height/6)];
            lineImageView.image=[UIImage imageNamed:@"fenlan.png"];
            [cell.contentView addSubview:lineImageView];
            


        }
        
        UIImageView *movieImageView1=(UIImageView *)[cell.contentView viewWithTag:kMovieImageView1Tag];
        NSArray *movieImgArray=[_dataDict objectForKey:@"movieimg"];
        NSDictionary *imgDict1= [movieImgArray objectAtIndex:0];
        NSString *imgStr1=[imgDict1 objectForKey:@"image"];
        [movieImageView1 setImageWithURL:[NSURL URLWithString:imgStr1]];
        
        UIImageView *movieImageView2=(UIImageView *)[cell.contentView viewWithTag:kMovieImageView2Tag];
        
        NSArray *movieImgArray1=[_dataDict objectForKey:@"movieimg"];
        NSDictionary *imgDict2= [movieImgArray1 objectAtIndex:1];
        NSString *imgStr2=[imgDict2 objectForKey:@"image"];
        [movieImageView2 setImageWithURL:[NSURL URLWithString:imgStr2]];
        
        UIImageView *movieImageView3=(UIImageView *)[cell.contentView viewWithTag:kMovieImageView3Tag];
        
        NSArray *movieImgArray2=[_dataDict objectForKey:@"movieimg"];
        NSDictionary *imgDict3= [movieImgArray2 objectAtIndex:2];
        NSString *imgStr3=[imgDict3 objectForKey:@"image"];
        [movieImageView3 setImageWithURL:[NSURL URLWithString:imgStr3]];
        
        
        UIImageView *movieImageView4=(UIImageView *)[cell.contentView viewWithTag:kMovieImageView4Tag];
        
        NSArray *movieImgArray3=[_dataDict objectForKey:@"movieimg"];
        NSDictionary *imgDict4= [movieImgArray3 objectAtIndex:3];
        NSString *imgStr4=[imgDict4 objectForKey:@"image"];
        [movieImageView4 setImageWithURL:[NSURL URLWithString:imgStr4]];
        
        

        

        
    }else  {
        
        cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
            
            UIImageView *backImageView=[[UIImageView alloc]initWithFrame:CGRectMake(34, 5, 280, self.view.frame.size.height/6-20+5)];
            backImageView.tag=kBackImageViewTag;
            backImageView.image=[UIImage imageNamed:@"pic_combox@2x.png"];
            [cell.contentView addSubview:backImageView];
            
            UIImageView *headImageView=[[UIImageView alloc]initWithFrame:CGRectMake(50, 10, 20, 20)];
            headImageView.tag=kHeadImageViewTag;
            [cell.contentView addSubview:headImageView];
            
            UILabel *nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(75, 10, 200, 20)];
            nameLabel.tag=kNameLabelTag;
            nameLabel.textColor=[UIColor grayColor];
            nameLabel.font=[UIFont systemFontOfSize:14];
            nameLabel.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:nameLabel];
            
            UILabel *scoreLabel1=[[UILabel alloc]initWithFrame:CGRectMake(240, 10, 25, 25)];
            scoreLabel1.text=@"评: ";
            scoreLabel1.font=[UIFont systemFontOfSize:14];
            scoreLabel1.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:scoreLabel1];
            
            UILabel *scoreLabel=[[UILabel alloc]initWithFrame:CGRectMake(260, 10, 20, 20)];
            scoreLabel.tag=kScoreLabelTag;
            scoreLabel.textColor=[UIColor greenColor];
            scoreLabel.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:scoreLabel];
            
            UILabel *scoreLabel2=[[UILabel alloc]initWithFrame:CGRectMake(280, 5, 20, 20)];
            scoreLabel2.tag=kScoreLabelTag2;
            scoreLabel2.textColor=[UIColor greenColor];
            scoreLabel2.font=[UIFont systemFontOfSize:12];
            scoreLabel2.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:scoreLabel2];
            
            UILabel *accessLabel=[[UILabel alloc]initWithFrame:CGRectMake(60, 30, 250, 40)];
            accessLabel.tag=kAccessLabelTag;
            accessLabel.font=[UIFont systemFontOfSize:12];
            accessLabel.numberOfLines=0;
            accessLabel.backgroundColor=[UIColor clearColor];
            [cell.contentView addSubview:accessLabel];
            
            UIImageView *lineImageView=[[UIImageView alloc]initWithFrame:CGRectMake(15, 0, 2, self.view.frame.size.height/6)];
            lineImageView.tag=kLineImageViewTag;
            lineImageView.image=[UIImage imageNamed:@"fenlan.png"];
            [cell.contentView addSubview:lineImageView];
            

        }
        
       
        
        UIImageView *headImageView=(UIImageView *)[cell.contentView viewWithTag:kHeadImageViewTag];
        NSDictionary *accessDict =[_accessArray objectAtIndex:indexPath.row];
                
        
        
        
        NSString *caimgStr=[accessDict objectForKey:@"caimg"];
        [headImageView setImageWithURL:[NSURL URLWithString:caimgStr]];
        
        UILabel *nameLabel=(UILabel *)[cell.contentView viewWithTag:kNameLabelTag];
        nameLabel.text=[accessDict objectForKey:@"ca"];
        
        UILabel *accessLabel=(UILabel *)[cell.contentView viewWithTag:kAccessLabelTag];
        
        NSString *acStr=[accessDict objectForKey:@"ce"];
        float height= acStr.length*12/250*14;
        
        accessLabel.frame=CGRectMake(60, 30, 250, height+20);
        accessLabel.text=acStr;
        
        
        UIImageView *backImageView=(UIImageView *)[cell.contentView viewWithTag:kBackImageViewTag];
        backImageView.frame=CGRectMake(34, 5, 280, self.view.frame.size.height/6-20+5+height);
        
        UIImageView *lineImageView=(UIImageView *)[cell.contentView viewWithTag:kLineImageViewTag];
        lineImageView.frame=CGRectMake(15, 0, 2, self.view.frame.size.height/6+height);
        
        
        UILabel *scoreLabel=(UILabel *)[cell.contentView viewWithTag: kScoreLabelTag];
        UILabel *scoreLabel2=(UILabel *)[cell.contentView viewWithTag: kScoreLabelTag2];
        
        NSNumber *scoreNum=[accessDict objectForKey:@"cr"];
        NSLog(@"num%@",scoreNum);
        if (scoreNum==nil) {
            scoreNum=@0;
        }
        
        NSString *scoreStr=[NSString stringWithFormat:@"%@",scoreNum];
        NSLog(@"Scor%@,%d",scoreStr,scoreStr.length);
        
        
        NSRange range=[scoreStr rangeOfString:@"."];
        
        if (scoreStr!=nil && [scoreStr isEqualToString:@""]==NO) {
            
            if (range.location !=NSNotFound) {
                
                scoreLabel.text=[scoreStr substringToIndex:range.location];
                scoreLabel2.text=[scoreStr substringWithRange:NSMakeRange(range.location, 2)];
                scoreLabel2.frame=CGRectMake(280-10, 5, 20, 20);
                
            }else{
                
               
                if (scoreStr.length>1) {
                    
                    scoreLabel.text=scoreStr;
                    scoreLabel2.text=@".0";
                    scoreLabel2.frame=CGRectMake(280, 5, 20, 20);
                    
                }else{
                
                    scoreLabel.text=scoreStr;
                    scoreLabel2.text=@".0";
                    scoreLabel2.frame=CGRectMake(280-10, 5, 20, 20);

                }
                
               
                
            }

        }else if (scoreStr.length==0){
        
            scoreLabel.text=@"0";
            scoreLabel2.text=@".0";
            
        }
        
    }
        
      
    _titleLabel1.text=[_dataDict objectForKey:@"t"];
    _titleLabel2.text=[_dataDict objectForKey:@"tEn"];
    
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    _headerView=[[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 30)]autorelease];
    _firstLabel=[[[UILabel alloc]initWithFrame:CGRectMake(5, 40, 28, 20)]autorelease];
    _firstLabel.font=[UIFont systemFontOfSize:13];
    _firstLabel.text=@"剧情";
    
    _secondLabel=[[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 28, 40)]autorelease];
    _secondLabel.numberOfLines=0;
    _secondLabel.font=[UIFont systemFontOfSize:13];
    _secondLabel.text=@"演职人员";
    
    _thirdLabel=[[[UILabel alloc]initWithFrame:CGRectMake(5, 40, 28, 20)]autorelease];
    _thirdLabel.font=[UIFont systemFontOfSize:13];
    _thirdLabel.text=@"剧照";
    
    _fourthLabel=[[[UILabel alloc]initWithFrame:CGRectMake(5, 40, 28, 40)]autorelease];
    _fourthLabel.numberOfLines=0;
    _fourthLabel.font=[UIFont systemFontOfSize:13];
    _fourthLabel.text=@"网又点评";
    
    switch (section) {
        case 1:
            [_headerView addSubview:_firstLabel];
            break;
        case 2:
            [_headerView addSubview:_secondLabel];
            break;
        case 3:
            [_headerView addSubview:_thirdLabel];
            break;
        case 4:
            [_headerView addSubview:_fourthLabel];
            break;
        case 0:
            
            break;
    }
    return _headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    CGFloat height;
    switch (section) {
        case 0:
            height=0;
            break;
        case 1:
            height=1;
            break;
        case 2:
            height=1;
            break;
        case 3:
            height=1;
            break;
        case 4:
            height=1;
            break;
        
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return self.view.frame.size.height/2;
    }else if(indexPath.section==1){
    
        
        if (flag==NO) {
            
            NSLog(@"height--%f",self.view.frame.size.height/6);
            return self.view.frame.size.height/6+20;
        
            
        }else {
            
            NSLog(@"height2--%d",disStr.length*12/260*14);
            return disStr.length*12/250*16+40;
            
        }
        
    }else if (indexPath.section==2){
    
       return self.view.frame.size.height/6-20;
    }else if (indexPath.section==3){
    
        return self.view.frame.size.height/6;
        
    
    }
    
    NSString *text=[[_accessArray objectAtIndex:indexPath.row] objectForKey:@"ce"];
   
    float height= text.length*12/250*14;
    
    
    
    return self.view.frame.size.height/6+height;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"diddis%@",discriptionLabel);
    if (indexPath.section==1 && indexPath.row==0) {
        
        if (isHidden==NO) {
          
            cellBackImageView.frame=CGRectMake(34, 10, 280, disStr.length*12/250*16+25);
            discriptionLabel.frame=CGRectMake(50, 13, 250, disStr.length*12/250*16+15);
            btnImageView2.frame=CGRectMake(300-5, disStr.length*12/250*16+15, 15,10);
            btnImageView2.hidden=NO;
            btnImageView.hidden=YES;
            flag=YES;
            [tableView reloadData];
            isHidden=YES;
        }else{
        
            cellBackImageView.frame=CGRectMake(34, 10, 280, self.view.frame.size.height/6);
            discriptionLabel.frame=CGRectMake(50, 13, 250, self.view.frame.size.height/6-5);
            btnImageView2.frame=CGRectMake(300-5, disStr.length*12/250*16+15, 15,10);
            btnImageView2.hidden=YES;
            btnImageView.hidden=NO;
            flag=NO;
            [tableView reloadData];
            isHidden=NO;
        }
        
        

    }else if (indexPath.section==3){
    
       ZHUCustomTabBarController *tabCtrl=(ZHUCustomTabBarController *)[[UIApplication sharedApplication]keyWindow].rootViewController;
        if (tabCtrl.movieImgViewController ==nil) {
            tabCtrl.movieImgViewController=[[ZHUMovieImgViewController alloc]init];
        }
        
        [self.navigationController pushViewController:tabCtrl.movieImgViewController animated:YES];
            
    
    }
       
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        if (indexPath.section==0) {
            
            return nil;
        }
    
    return indexPath;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
