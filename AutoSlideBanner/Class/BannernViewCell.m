//
//  BannernViewCell.m
//  AutoSlideBanner
//
//  Created by admin on 10/27/15.
//  Copyright © 2015 HoangQP. All rights reserved.
//

#import "BannernViewCell.h"

@interface BannernViewCell ()

@property (nonatomic, weak, readonly) UIImageView *imageView;

@end

@implementation BannernViewCell

+(NSString *)reuseIdentifier
{
    return NSStringFromClass(self);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        UIImageView *img = [UIImageView new];
        img.translatesAutoresizingMaskIntoConstraints = NO;
        img.contentMode     = UIViewContentModeScaleAspectFill;
        img.clipsToBounds   = YES;

        [self.contentView addSubview:img];
        _imageView = img;
        
        // Pin to superview edge with RDH_CELL_PADDING inset
        [self pinView:img toContentViewAttribute:NSLayoutAttributeLeft withPadding:0];
        [self pinView:img toContentViewAttribute:NSLayoutAttributeTop withPadding:0];
        [self pinView:img toContentViewAttribute:NSLayoutAttributeRight withPadding:0];
        [self pinView:img toContentViewAttribute:NSLayoutAttributeBottom withPadding:0];
        
        self.backgroundView = [UIView new];
        self.backgroundView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
    }
    return self;
}

-(void)pinView:(UIView *)view toContentViewAttribute:(NSLayoutAttribute)attribute withPadding:(CGFloat)padding
{
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:self.contentView attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view attribute:attribute multiplier:1 constant:padding]];
}

// Display image with URL
-(void)setImageWithURL:(NSString *)url
{
    
}

// Display image with name
- (void)setImageWithName:(NSString*)nameImage
{
    [self.imageView setImage:[UIImage imageNamed:nameImage]];
}


@end
