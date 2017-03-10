//
//  NSDate+VCDate.h
//  RaiseLeTang
//
//  Created by zhang on 16/2/24.
//  Copyright © 2016年 Messcat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (VCDate)
- (NSInteger)getDay;

- (NSInteger)getMonth;

- (NSInteger)getYear;

- (NSInteger)firstWeekdayInCurrentMonth;

- (NSInteger)totaldaysInCurrentMonth;

- (NSInteger)totaldaysInMonth;

- (NSDate *)lastMonth;

- (NSDate*)nextMonth;

- (NSString *)getLunarDay;

- (NSString *)getLunarMonth;
@end
