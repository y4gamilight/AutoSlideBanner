//
//  HorizontalSlideBanner.h
//  AutoSlideBanner
//
//  Created by admin on 10/27/15.
//  Copyright © 2015 HoangQP. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AutoSlideBannerDelegate <NSObject>

@optional
- (void)autoSlideBannerDidSelectBannerAtIndex:(NSInteger)index;

@end
@interface AutoSlideBanner : UIView

@property (weak, nonatomic) id<AutoSlideBannerDelegate> delegate;

// Timer for slide. Unit is seconds
@property (nonatomic, assign) float timer;

- (void)setDatasource:(NSArray*)datasource;

@end
