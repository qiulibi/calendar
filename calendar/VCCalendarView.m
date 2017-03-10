//
//  VCCalendarView.m
//  TestCalendar
//
//  Created by zhang on 16/2/24.
//  Copyright © 2016年 Messcat. All rights reserved.
//

#import "VCCalendarView.h"
#import "NSDate+VCDate.h"
#import "RLTCalendarCollectionViewCell.h"

#define cellBgViewTag 1000000
NSString *const calendarCellIdentifier = @"cell";
@interface VCCalendarView ()
{
    NSIndexPath *lastSelectIndexPath;
}
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIButton *leftbtn;
@property (nonatomic, strong) UIButton *rightbtn;
@property (nonatomic, strong) UILabel *showDateLabel;
@property (nonatomic, strong) UICollectionView *dateView;

@property (nonatomic, strong) NSArray *weekDayArray;
@property (nonatomic, strong) UIView *mask;

@property (nonatomic, strong) NSDate *dateTime;
@property (nonatomic, strong) NSDate *today;
@property (nonatomic, strong) NSDateFormatter *dateFormater;

@property (nonatomic, strong) NSMutableArray *list;
@property (nonatomic, strong) NSDate *lastSelectDate;
@end
@implementation VCCalendarView

@synthesize dateTime = _dateTime;

- (void)setDateTime:(NSDate *)dateTime{
    _dateTime = dateTime;
    self.showDateLabel.text = [self.dateFormater stringFromDate:_dateTime];
    [_dateView reloadData];
}

- (NSDate *)dateTime{
    if (!_dateTime) {
        _dateTime = self.today;
    }
    return _dateTime;
}

- (NSDate *)today{
    if (!_today) {
        _today = [NSDate date];
    }
    return _today;
}

- (NSDateFormatter *)dateFormater{
    if (!_dateFormater) {
        _dateFormater = [[NSDateFormatter alloc] init];
        [_dateFormater setDateFormat:@"yyyy-MM"];
    }
    return _dateFormater;
}


- (instancetype)initWithDateFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.list = [NSMutableArray array];
        _weekDayArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        
        self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 40)];
        self.topView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.topView];
        
        self.leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftbtn.frame = CGRectMake(0, 0, 40, 20);
        self.leftbtn.backgroundColor = [UIColor clearColor];
//        [self.leftbtn setCenterY:CGRectGetHeight(self.topView.frame)/2];
        self.leftbtn.center = CGPointMake(self.leftbtn.center.x,CGRectGetHeight(self.topView.frame)/2);
        [self.leftbtn setImage:appSetImage(@"calendarLeft") forState:UIControlStateNormal];
        [self.leftbtn addTarget:self action:@selector(previouseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:self.leftbtn];
        
        self.rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightbtn.frame = CGRectMake(CGRectGetWidth(frame) - 40, 0, 40, 20);
        self.rightbtn.backgroundColor = [UIColor clearColor];
        self.rightbtn.center = CGPointMake(self.rightbtn.center.x,CGRectGetHeight(self.topView.frame)/2);
        [self.rightbtn setImage:appSetImage(@"calendarRight") forState:UIControlStateNormal];
        [self.rightbtn addTarget:self action:@selector(nexAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView addSubview:self.rightbtn];
        
        self.showDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 100, 20)];
        [self.showDateLabel setCenter:CGPointMake(CGRectGetWidth(self.topView.frame)/2, CGRectGetHeight(self.topView.frame)/2)];
        self.showDateLabel.textAlignment = NSTextAlignmentCenter;
        self.showDateLabel.font = [UIFont systemFontOfSize:16];
        self.showDateLabel.text = [self.dateFormater stringFromDate:self.dateTime];
        [self.topView addSubview:self.showDateLabel];
        
        CGFloat itemWidth = CGRectGetWidth(self.frame) / 7;
        CGFloat itemHeight = (CGRectGetHeight(self.frame) - CGRectGetHeight(self.topView.frame))/7;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        
        self.dateView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(self.topView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(self.topView.frame)) collectionViewLayout:layout];
        [self.dateView registerClass:[RLTCalendarCollectionViewCell class] forCellWithReuseIdentifier:calendarCellIdentifier];
        self.dateView.dataSource = self;
        self.dateView.delegate = self;
        self.dateView.backgroundColor = [UIColor clearColor];
        self.dateView.userInteractionEnabled = YES;
        [self addSubview:self.dateView];
        
        [self.dateView setCollectionViewLayout:layout animated:YES];
        [self addSwipe];
    }
    return self;
}

#pragma -mark collectionView delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return _weekDayArray.count;
    } else {
        return 42;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RLTCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:calendarCellIdentifier forIndexPath:indexPath];
    
    cell.cellBgView.hidden = YES;
    if (indexPath.section == 0) {
        cell.backgroundColor = generateColor(243, 235, 214, 1);
        [cell.dateLabel setText:_weekDayArray[indexPath.row]];
        [cell.dateLabel setTextColor:[UIColor blackColor]];
        [cell.dateLabel setFrame:CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height)];
        cell.lunarDateLabel.text = @"";
    }
    else {
        cell.backgroundColor = [UIColor clearColor];
        [cell.dateLabel setFrame:CGRectMake(0, 5, cell.frame.size.width, (cell.frame.size.height-10)/2)];
        NSInteger daysInThisMonth = [self.dateTime totaldaysInMonth];
        NSInteger firstWeekday = [self.dateTime firstWeekdayInCurrentMonth];
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i < firstWeekday) {
            [cell.dateLabel setText:@""];
            cell.lunarDateLabel.text = @"";
            
        }else if (i > firstWeekday + daysInThisMonth - 1){
            [cell.dateLabel setText:@""];
            cell.lunarDateLabel.text = @"";
        }else{
            day = i - firstWeekday + 1;
            [cell.dateLabel setText:[NSString stringWithFormat:@"%ld",day]];
            [cell.dateLabel setTextColor:[UIColor brownColor]];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
            NSString *dateStr = [NSString stringWithFormat:@"%@-%ld",self.showDateLabel.text,(long)day];
            NSDate *date = [formatter dateFromString:dateStr];
            
            NSString *lunarDay = [date getLunarDay];
            NSString *lunarMonth = [date getLunarMonth];
            if ([lunarDay isEqualToString:@"初一"] && [lunarMonth isEqualToString:@"正月"]) {
                cell.lunarDateLabel.text = @"春节";
            }
            else if ([lunarDay isEqualToString:@"十五"] && [lunarMonth isEqualToString:@"正月"]) {
                cell.lunarDateLabel.text = @"元宵节";
            }
            else if ([lunarDay isEqualToString:@"初五"] && [lunarMonth isEqualToString:@"五月"]) {
                cell.lunarDateLabel.text = @"端午节";
            }
            else if ([lunarDay isEqualToString:@"初七"] && [lunarMonth isEqualToString:@"七月"]) {
                cell.lunarDateLabel.text = @"七夕";
            }
            else if ([lunarDay isEqualToString:@"十五"] && [lunarMonth isEqualToString:@"七月"]) {
                cell.lunarDateLabel.text = @"中元节";
            }
            else if ([lunarDay isEqualToString:@"十五"] && [lunarMonth isEqualToString:@"八月"]) {
                cell.lunarDateLabel.text = @"中秋节";
            }
            else if ([lunarDay isEqualToString:@"初九"] && [lunarMonth isEqualToString:@"九月"]) {
                cell.lunarDateLabel.text = @"重阳节";
            }
            else if ([lunarDay isEqualToString:@"初一"]) {
                cell.lunarDateLabel.text = lunarMonth;
            }
            else {
                cell.lunarDateLabel.text = lunarDay;
            }
            
            NSString *todayStr = [formatter stringFromDate:self.today];
            NSDate *todayDate = [formatter dateFromString:todayStr];
            if (self.lastSelectDate == nil && [date compare:todayDate] == NSOrderedSame) {
                self.lastSelectDate = todayDate;
                cell.cellBgView.hidden = NO;
            }
            else if (self.lastSelectDate != nil &&[date compare:self.lastSelectDate] == NSOrderedSame){
                cell.cellBgView.hidden = NO;
            }
            
            //当前月
            if ([self.today isEqualToDate:self.dateTime]) {
                if (day == [self.dateTime getDay]) {
//                    [cell.dateLabel setTextColor:defaultWhiteColor];
                    if (lastSelectIndexPath == nil) {
//                        cell.dateLabel.textColor = defaultWhiteColor;
//                        cell.cellBgView.hidden = NO;
                        
                        lastSelectIndexPath = indexPath;
                    }
//                    else {
//                        cell.dateLabel.textColor = [UIColor brownColor];
//                        cell.cellBgView.hidden = YES;
//                    }
//                    [cell.dateLabel setTextColor:RLTBlackColor];
                    
                } else if (day > [self.dateTime getDay]) {
                    [cell.dateLabel setTextColor:[UIColor grayColor]];
                }
            } else if ([_today compare:self.dateTime] == NSOrderedAscending) {
                [cell.dateLabel setTextColor:[UIColor grayColor]];
            }
            
        }
        
    }
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        NSInteger daysInThisMonth = [self.dateTime totaldaysInMonth];
        NSInteger firstWeekday = [self.dateTime firstWeekdayInCurrentMonth];
        
        NSInteger day = 0;
        NSInteger i = indexPath.row;
        
        if (i >= firstWeekday && i <= firstWeekday + daysInThisMonth - 1) {
            day = i - firstWeekday + 1;
            
            //this month
            if ([_today isEqualToDate:self.dateTime]) {
                if (day <= [self.dateTime getDay]) {
                    return YES;
                }
            } else if ([_today compare:self.dateTime] == NSOrderedDescending) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.dateTime];
    NSInteger firstWeekday = [self.dateTime firstWeekdayInCurrentMonth];
    
    NSInteger day = 0;
    NSInteger i = indexPath.row;
    day = i - firstWeekday + 1;
    if (self.calendarBlock) {
        self.calendarBlock(day, [comp month], [comp year]);
    }
    
//    UICollectionViewCell *cell = [self.dateView cellForRowAtIndexPath:indexPath];
//    NSLog(@"%ld",(long)[self.dateTime getDay]);
    RLTCalendarCollectionViewCell *lastSelectCell = (RLTCalendarCollectionViewCell *)[self.dateView cellForItemAtIndexPath:lastSelectIndexPath];
    lastSelectCell.cellBgView.hidden = YES;
    
    RLTCalendarCollectionViewCell *cell = (RLTCalendarCollectionViewCell *)[self.dateView cellForItemAtIndexPath:indexPath];
    cell.cellBgView.hidden = NO;
    
    lastSelectIndexPath = indexPath;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%ld-%ld",[comp year],[comp month],day];
    NSDate *date = [formatter dateFromString:dateStr];
    self.lastSelectDate = date;
//    NSLog(@"%ld,%ld,%ld",day,[comp year],[comp year]);
    
}

- (void)addSwipe
{
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nexAction:)];
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:swipLeft];
    
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previouseAction:)];
    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:swipRight];
}

- (void)nexAction:(id)sender
{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
        self.dateTime = [self.dateTime nextMonth];
    } completion:nil];
}

- (void)previouseAction:(id)sender
{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
        self.dateTime = [self.dateTime lastMonth];
    } completion:nil];
}

@end
