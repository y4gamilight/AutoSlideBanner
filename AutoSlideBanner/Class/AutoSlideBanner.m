//
//  HorizontalSlideBanner.m
//  AutoSlideBanner
//
//  Created by admin on 10/27/15.
//  Copyright © 2015 HoangQP. All rights reserved.
//

#import "AutoSlideBanner.h"

#import "BannernViewCell.h"

static NSString * const reuseIdentifier = @"Cell";

#define WIDTH_ITEM_BANNER       180.0f

@interface AutoSlideBanner()<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>
{
    NSArray *contents;
    NSTimer *myTimer;
    NSInteger currentIndex;
}

@property (nonatomic, assign) CGFloat previousOffset;
@property (nonatomic, assign) NSInteger currentPage;

@property (strong, nonatomic) IBOutlet UICollectionView   *collectionView;
@property (nonatomic, strong) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation AutoSlideBanner

// Initation
- (instancetype)init
{
    NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"AutoSlideBanner" owner:self options:nil];
    id mainView = [subviewArray objectAtIndex:0];
    
    return mainView;
}

- (void)awakeFromNib
{
    myTimer = [NSTimer scheduledTimerWithTimeInterval:self.timer target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    
    currentIndex = 0;
    self.timer = 8.0f;
    
    // Flow layout
    UICollectionViewFlowLayout *horizonflowLayout = [UICollectionViewFlowLayout new];
    [horizonflowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    horizonflowLayout.minimumInteritemSpacing = 0.0f;
    [self.collectionView setCollectionViewLayout:horizonflowLayout];
    
    self.collectionView.bounces = YES;
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self.collectionView setShowsVerticalScrollIndicator:NO];
    
    self.collectionView.pagingEnabled   = NO;
    self.collectionView.delegate        = self;
    self.collectionView.dataSource      = self;
    
    // Register cell classes
    [self.collectionView registerClass:[BannernViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

#pragma mark Public Methods
- (void)setDatasource:(NSArray*)datasource
{
    contents = datasource;
    [self.collectionView reloadData];
}

- (void)setTimer:(float)timer
{
    //self.timer = timer;
    [self resetTimerAutoScroll:currentIndex];
}

#pragma mark Private Methods
// Scroll cell at next index path to center
- (void)changeImage
{
    if ([contents count] == 0 || contents == nil) {
        return;
    }
    
    currentIndex++;
    if (currentIndex >= [contents count]) {
        currentIndex = 0;
    }
    
    NSIndexPath *centerCellIndexPath = [NSIndexPath indexPathForRow:currentIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:centerCellIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

// Reset timer
- (void)resetTimerAutoScroll:(NSInteger)index
{
    currentIndex = index;
    [myTimer invalidate];
    myTimer = nil;
    myTimer = [NSTimer scheduledTimerWithTimeInterval:self.timer target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [contents count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BannernViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setImageWithName:contents[indexPath.row]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(WIDTH_ITEM_BANNER, CGRectGetHeight(self.frame));
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(autoSlideBannerDidSelectBannerAtIndex:)]) {
        [self.delegate autoSlideBannerDidSelectBannerAtIndex:indexPath.row];
    }
}

#pragma mark Scroll view
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self findCellNearestCenterView:[self.collectionView visibleCells]];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self findCellNearestCenterView:[self.collectionView visibleCells]];
    }
    
}

- (void)findCellNearestCenterView:(NSArray*)visibleCells
{
    CGPoint centerPoint = CGPointMake(self.collectionView.center.x + self.collectionView.contentOffset.x,
                                      self.collectionView.center.y + self.collectionView.contentOffset.y);
    NSIndexPath *centerCellIndexPath = [self.collectionView indexPathForItemAtPoint:centerPoint];
    [self.collectionView scrollToItemAtIndexPath:centerCellIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    // Reset timer
    [self resetTimerAutoScroll:centerCellIndexPath.row];
}
@end
