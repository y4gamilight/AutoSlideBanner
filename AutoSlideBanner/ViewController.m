//
//  ViewController.m
//  AutoSlideBanner
//
//  Created by admin on 10/27/15.
//  Copyright © 2015 HoangQP. All rights reserved.
//

#import "ViewController.h"

#import "AutoSlideBanner.h"

@interface ViewController ()

// Auto slide view
@property (strong, nonatomic) AutoSlideBanner   *autoSlideBannerView;

// Array images
@property (strong, nonatomic) NSArray   *imagesArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Images data source
    self.imagesArray = @[@"banner01", @"banner02", @"banner03", @"banner04", @"banner05"];
    
    // Init auto slide view
    self.autoSlideBannerView = [[AutoSlideBanner alloc] init];
    self.autoSlideBannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.slideContainView addSubview:self.autoSlideBannerView];
    [self.autoSlideBannerView setDatasource:self.imagesArray];
    
    // Set timer to auto slide
    self.autoSlideBannerView.timer = 5.0f; // seconds
    
    [self pinView:self.autoSlideBannerView toContentViewAttribute:NSLayoutAttributeLeading withPadding:0];
    [self pinView:self.autoSlideBannerView toContentViewAttribute:NSLayoutAttributeTrailing withPadding:0];
    [self pinView:self.autoSlideBannerView toContentViewAttribute:NSLayoutAttributeBottom withPadding:0];
    [self pinView:self.autoSlideBannerView toContentViewAttribute:NSLayoutAttributeTop withPadding:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Private Method
-(void)pinView:(UIView *)view toContentViewAttribute:(NSLayoutAttribute)attribute withPadding:(CGFloat)padding
{
    [self.slideContainView addConstraint:[NSLayoutConstraint constraintWithItem:self.slideContainView attribute:attribute relatedBy:NSLayoutRelationEqual toItem:view attribute:attribute multiplier:1 constant:padding]];
}

@end
