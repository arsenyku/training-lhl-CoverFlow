//
//  CFCoverFlowLayout.m
//  CoverFlow
//
//  Created by asu on 2015-09-10.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "CFCoverFlowLayout.h"

@implementation CFCoverFlowLayout

#pragma mark - Overrides for Flow Layout

-(void)prepareLayout{
     //scroll direction and item size

    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.itemSize = CGSizeMake(100, self.collectionView.frame.size.height);

}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSArray* attributes = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRegion;
    visibleRegion.origin = self.collectionView.contentOffset;
    visibleRegion.size   = self.collectionView.bounds.size;
    
    float visibleRegionCentreX = visibleRegion.origin.x + ( visibleRegion.size.width / 2.0f );
    float maxDistanceFromCentreX = (visibleRegion.size.width/2.0f);
    
    NSLog(@"---- %@ ---- maxfromcentrex = %f", [NSValue valueWithCGRect:visibleRegion], maxDistanceFromCentreX);
    for (UICollectionViewLayoutAttributes *itemAttributes in attributes) {
        
        //float centreXOfItem = itemAttributes.frame.origin.x + (itemAttributes.frame.size.width/2.0f);
        //itemAttributes.center.x;
        float distanceFromCentre = fabs(itemAttributes.center.x - visibleRegionCentreX);
        itemAttributes.alpha = 1.0 - (distanceFromCentre / maxDistanceFromCentreX);
    
        NSLog(@"%@ c=%f, d=%f",[NSValue valueWithCGRect:itemAttributes.frame], itemAttributes.center.x, distanceFromCentre);
    
    }
    
    //CATransform3DScale(CATransform3D t, <#CGFloat sx#>, <#CGFloat sy#>, <#CGFloat sz#>)
    
    // Modify the layout attributes as needed here
    
    return attributes;
}
@end