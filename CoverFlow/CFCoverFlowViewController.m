//
//  ViewController.m
//  CoverFlow
//
//  Created by asu on 2015-09-10.
//  Copyright (c) 2015 asu. All rights reserved.
//

#import "CFCoverFlowViewController.h"

@interface CFCoverFlowViewController () <UICollectionViewDataSource>
@property(nonatomic)NSArray *photos;
@end

@implementation CFCoverFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.photos = @[
                    [UIImage imageNamed:@"IMG1"],
                    [UIImage imageNamed:@"IMG2"],
                    [UIImage imageNamed:@"IMG3"],
                    [UIImage imageNamed:@"IMG4"],
                    [UIImage imageNamed:@"IMG5"],
                    [UIImage imageNamed:@"IMG6"],
                    [UIImage imageNamed:@"IMG7"],
                    [UIImage imageNamed:@"IMG8"],
                    [UIImage imageNamed:@"IMG9"],
                    [UIImage imageNamed:@"IMG10"]
                    ];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.photos count];
}

// The cell that is returned must be retrieved from a call to
// -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = (UICollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"flowcell" forIndexPath:indexPath];
    cell.backgroundView = [[UIImageView alloc] initWithImage:self.photos[indexPath.row]];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

@end
