//
//  BannernViewCell.h
//  AutoSlideBanner
//
//  Created by admin on 10/27/15.
//  Copyright © 2015 HoangQP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BannernViewCell : UICollectionViewCell

+(NSString *)reuseIdentifier;

// Display image with URL
-(void)setImageWithURL:(NSString *)url;

// Display image with name
- (void)setImageWithName:(NSString*)nameImage;

@end
