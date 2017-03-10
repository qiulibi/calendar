//
//  SLBaseCollectionViewCell.m
//  SLStaticLibrary
//

#import "SLBaseCollectionViewCell.h"


@implementation SLBaseCollectionViewCell

- (instancetype)init {
    if (self = [super init]) {
        // 初始化 Cell View
        _didInitializeCellView = NO;
        [self initializeCellView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        // 初始化 Cell View
        _didInitializeCellView = NO;
        [self initializeCellView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 初始化 Cell View
        _didInitializeCellView = NO;
        [self initializeCellView];
    }
    return self;
}

- (void)initialize {
    if (!self.didInitializeCellView) {
        // 实际是调用了子类的方法
        [self initializeCellView];
        _didInitializeCellView = YES;
    }
}

- (void)initializeCellView {
    // 请在子类中重写该方法
}

- (void)reloadCellViewWithModel:(id)cellModel {
    // 请在子类中重写该方法
}


+ (NSString *)getCellIdentifier {
    return [NSString stringWithFormat:@"%@Identifier", NSStringFromClass([self class])];
}

@end
