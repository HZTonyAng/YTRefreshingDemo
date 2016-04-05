//
//  YTSunnyRefreshController.h
//  YALSunyPullToRefresh
//
//  Created by TonyAng on 16/4/5.
//  Copyright © 2016年 TonyAng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTSunnyRefreshController : UIControl

- (void)attachToScrollView:(UIScrollView *)scrollView;

- (void)beginRefreshing;

- (void)endRefreshing;

@end
