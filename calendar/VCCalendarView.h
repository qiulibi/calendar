//
//  VCCalendarView.h
//  TestCalendar
//
//  Created by zhang on 16/2/24.
//  Copyright © 2016年 Messcat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCCalendarView : UIView<UICollectionViewDelegate , UICollectionViewDataSource>
@property (nonatomic, copy) void(^calendarBlock)(NSInteger day, NSInteger month, NSInteger year);

- (instancetype)initWithDateFrame:(CGRect)frame;
@end
