//
//  ZHUCinemaCell.h
//  MTimer
//
//  Created by apple on 13-9-7.
//  Copyright (c) 2013年 HelloZHU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHUCinemaCell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *cinameNameLabel;

@property (retain, nonatomic) IBOutlet UILabel *cinameAddressLabel;
@property (retain, nonatomic) IBOutlet UILabel *priceLabel;
- (IBAction)allCinameBtn:(id)sender;
@property (retain, nonatomic) IBOutlet UIButton *allCnaBtn;
@property (retain, nonatomic) IBOutlet UIButton *nearbyBtn;
@property (retain, nonatomic) IBOutlet UIButton *arreaBtn;
@property (retain, nonatomic) IBOutlet UIButton *subwayBtn;
@property (retain, nonatomic) IBOutlet UILabel *pixLabel;
@property (retain, nonatomic) IBOutlet UIButton *isCanBuyTicBtn;
@property (retain, nonatomic) IBOutlet UILabel *qiLabel;

- (IBAction)changeGreenLocation:(id)sender;
@end
