//
//  ReusableView.m
//  ReusableView
//
//  Created by Zhiwei on 2019/8/10.
//  Copyright © 2019 Zhiwei. All rights reserved.
//

#import "ReusableView.h"

@implementation ReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setupView];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupView];
    }
    return self;
}

- (void)setupView {
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 300, 100)];
    self.label.numberOfLines = 0;
    self.backgroundColor = [self randomColor];
    [self addSubview:self.label];
}

-(UIColor *)randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
