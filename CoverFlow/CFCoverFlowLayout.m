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
    self.itemSize = CGSizeMake(200, 200);
    self.minimumInteritemSpacing = 0.0;

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
    
    
    for (UICollectionViewLayoutAttributes *itemAttributes in attributes) {
        
        float distanceFromCentre = fabs(itemAttributes.center.x - visibleRegionCentreX);
        float scaleFactor = (distanceFromCentre / maxDistanceFromCentreX);

        float rotatationDirection = (itemAttributes.center.x < visibleRegionCentreX) ? -1.0 : 1.0;

        
        itemAttributes.alpha = 1.0 - scaleFactor ;
        itemAttributes.transform3D = CATransform3DScale(CATransform3DIdentity, 1.0-scaleFactor, 1.0, 1.0);
        itemAttributes.transform3D = CATransform3DRotate(itemAttributes.transform3D, 0.0, itemAttributes.center.x, itemAttributes.center.y * (1.0-scaleFactor) * rotatationDirection, 1.0);
    }
    
    
    
    return attributes;
}


@end