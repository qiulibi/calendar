//
//  RLTCalendarCollectionViewCell.m
//  RaiseLeTang
//
//  Created by qiulibi on 16/3/17.
//  Copyright © 2016年 Messcat. All rights reserved.
//

#import "RLTCalendarCollectionViewCell.h"

@implementation RLTCalendarCollectionViewCell

- (void)initializeCellView {
    
    CGFloat height = self.frame.size.height;
    self.cellBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, height, height)];
    self.cellBgView.center = CGPointMake(CGRectGetWidth(self.frame)/2, height/2);
    self.cellBgView.layer.borderWidth = 1.0;
    self.cellBgView.layer.borderColor = generateColor(148, 192, 131, 1).CGColor;
    self.cellBgView.layer.masksToBounds = YES;
    self.cellBgView.layer.cornerRadius = CGRectGetHeight(self.cellBgView.frame)/2;
    self.cellBgView.hidden = YES;
    [self addSubview:self.cellBgView];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, self.frame.size.width, (height-10)/2)];
    [self.dateLabel setTextAlignment:NSTextAlignmentCenter];
    [self.dateLabel setFont:[UIFont systemFontOfSize:17]];
    [self addSubview:self.dateLabel];
    
    self.lunarDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (height-10)/2 + 5, self.frame.size.width, (height-10)/2)];
    [self.lunarDateLabel setTextAlignment:NSTextAlignmentCenter];
    [self.lunarDateLabel setFont:[UIFont systemFontOfSize:10]];
    self.lunarDateLabel.textColor = [UIColor grayColor];
    [self addSubview:self.lunarDateLabel];
    
}

@end
