//
//  ReusableView.h
//  ReusableView
//
//  Created by Zhiwei on 2019/8/10.
//  Copyright © 2019 Zhiwei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReusableView : UIView

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) NSInteger index;

@end

NS_ASSUME_NONNULL_END
