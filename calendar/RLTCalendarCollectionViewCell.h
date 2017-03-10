//
//  RLTCalendarCollectionViewCell.h
//  RaiseLeTang
//
//  Created by qiulibi on 16/3/17.
//  Copyright © 2016年 Messcat. All rights reserved.
//

#import "SLBaseCollectionViewCell.h"

@interface RLTCalendarCollectionViewCell : SLBaseCollectionViewCell
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *lunarDateLabel;
@property (nonatomic, strong) UIView *cellBgView;
@end
