//
//  CollectionViewController.h
//  Parse
//
//  Created by Chris on 9/18/15.
//  Copyright © 2015 Prince Fungus. All rights reserved.
//

#import "PFQueryCollectionViewController.h"
#import "CVCell.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "DownloadViewController.h"

@interface CollectionViewController : PFQueryCollectionViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic) PFFile *fileToPass;
@property (nonatomic, strong) PFObject *objectToPass;


@end
