//
//  ZHUCinemaCell.m
//  MTimer
//
//  Created by apple on 13-9-7.
//  Copyright (c) 2013年 HelloZHU. All rights reserved.
//

#import "ZHUCinemaCell.h"

@implementation ZHUCinemaCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
   
    [_cinameAddressLabel release];
    [_cinameNameLabel release];
    [_priceLabel release];
    [_allCnaBtn release];
    [_nearbyBtn release];
    [_arreaBtn release];
    [_subwayBtn release];
    [_isCanBuyTicBtn release];
    [_qiLabel release];
    [_pixLabel release];
    [super dealloc];
}
- (IBAction)allCinameBtn:(id)sender {
}
- (IBAction)changeGreenLocation:(id)sender {
}
@end
