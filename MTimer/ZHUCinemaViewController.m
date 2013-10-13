//
//  ZHUCinemaViewController.m
//  MTimer
//
//  Created by apple on 13-9-7.
//  Copyright (c) 2013年 HelloZHU. All rights reserved.
//

#import "ZHUCinemaViewController.h"
#import "ZHUCinemaCell.h"
#import "JSONKit.h"

@interface ZHUCinemaViewController ()
{
    NSArray *_dataArray;
}
@end

@implementation ZHUCinemaViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *path=[[[NSBundle mainBundle]resourcePath]stringByAppendingPathComponent:@"全部影院.json"];
    NSString *josnStr=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    _dataArray=[[josnStr objectFromJSONString]retain];
    
    [self createNaviView];
    [self createNavBarLeftAndRightBtn];
   
}

- (void)createNaviView
{
    UIImage *navBarImage=[UIImage imageNamed:@"menu_top_bg@2x.png"];
    [navBarImage stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    [self.navigationController.navigationBar setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
    
    UIImageView *titleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 21)];
    titleImageView.image=[UIImage imageNamed:@"ele_logo_mtime@2x.png"];
    titleImageView.contentMode=UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView=titleImageView;
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
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightBtn.frame=CGRectMake(0, 0, 35, 25);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"menu_top_btn_1@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarBtn=[[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=rightBarBtn;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_dataArray count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cinameContent";
    static NSString *topCell=@"cell";
    ZHUCinemaCell *cell=nil;
    
    
    if (indexPath.row==0) {
        
        cell=[tableView dequeueReusableCellWithIdentifier:topCell];
        
        if (cell==nil) {
            
            NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"ZHUCinemaCellTop" owner:self options:nil];
            cell=[array objectAtIndex:0];
            
            

        }
    
    }else{
        
        cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell==nil) {
            
            NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"ZHUCinemaCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
            cell.qiLabel.textColor=[UIColor grayColor];
            
        }

        NSDictionary *dataDict=[_dataArray objectAtIndex:indexPath.row-1];
        cell.cinameNameLabel.text=[dataDict objectForKey:@"cinameName"];
        NSNumber *price=[dataDict objectForKey:@"minPrice"];
        NSMutableString *priceStr=[NSMutableString stringWithFormat:@"%@",price];
        if (priceStr.length>2) {
           
            
            cell.priceLabel.hidden=NO;
            cell.qiLabel.hidden=NO;
            cell.pixLabel.hidden=NO;
            [priceStr insertString:@"." atIndex:2];
            cell.priceLabel.text=priceStr;
            
            
        }else{
        
            cell.priceLabel.hidden=YES;
            cell.qiLabel.hidden=YES;
            cell.pixLabel.hidden=YES;
        }
        
        
        
    
    }
        return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heigth;
    switch (indexPath.row) {
        case 0:
            heigth=60.0;
            break;
            
        default:
            heigth=40.0;
            break;
    }
    
    return heigth;

}

@end
