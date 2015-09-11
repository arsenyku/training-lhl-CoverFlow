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
//    self.itemSize = CGSizeMake(75, self.collectionView.frame.size.height);
    self.itemSize = CGSizeMake(200, 200);
//    self.itemSize = CGSizeMake(150, 200);
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
//        itemAttributes.transform3D = CATransform3DRotate(CATransform3DIdentity, 0.0, itemAttributes.center.x, itemAttributes.center.y * (1.0-scaleFactor), 1.0);
	
//        NSIndexPath* indexPathForLeftItem =
//            [NSIndexPath indexPathForItem:itemAttributes.indexPath.row-1 inSection:itemAttributes.indexPath.section];
//        
//    	CGRect frameForLeftItem = [self layoutAttributesForItemAtIndexPath:indexPathForLeftItem].frame;
//        float rightEdgeForLeftItem = frameForLeftItem.origin.x + frameForLeftItem.size.width;
//        float translationDistance = itemAttributes.frame.origin.x - rightEdgeForLeftItem;
//        
//        itemAttributes.transform3D = CATransform3DTranslate(itemAttributes.transform3D, translationDistance, 0.0, 0.0);
        
        
        
//    	itemAttributes.frame = CGRectMake(rightEdgeForLeftItem, itemAttributes.frame.origin.y,
//                                          itemAttributes.frame.size.width, itemAttributes.frame.size.height);
    }
    
    
    // Modify the layout attributes as needed here
    
    return attributes;
}


//-(UICollectionViewLayoutAttributes *)layoutAttributesForCellAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"+++++");
//    UICollectionViewLayoutAttributes* atts =
//    [super layoutAttributesForCellAtIndexPath:indexPath];
//    
//    if (indexPath.item == 0) // degenerate case 1, first item of section
//        return atts;
//    
//    NSIndexPath* ipPrev =
//    [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
//    
//    CGRect fPrev = [self layoutAttributesForItemAtIndexPath:ipPrev].frame;
//    CGFloat rightPrev = fPrev.origin.x + fPrev.size.width;
//    if (atts.frame.origin.x <= rightPrev) // degenerate case 2, first item of line
//        return atts;
//    
//    CGRect f = atts.frame;
//    f.origin.x = rightPrev;
//    atts.frame = f;
//    return atts;
//}

@end