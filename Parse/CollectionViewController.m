//
//  CollectionViewController.m
//  Parse
//
//  Created by Chris on 9/18/15.
//  Copyright © 2015 Prince Fungus. All rights reserved.
//

#import "CollectionViewController.h"

@interface CollectionViewController ()

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up collection view, set nav bar title, and call queryPhotos
    self.collectionView.delegate = self;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView.collectionViewLayout = flowLayout;
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.collectionView registerClass:[CVCell class] forCellWithReuseIdentifier:@"CVCell"];
    
//    self.title = @"Your Parse Photos";
    self.navigationItem.title = @"Your Parse Photos";
    [self queryPhotos];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) queryPhotos
{
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    // Query for photos. Reload collection view on success, else print error
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error) {
             // The find succeeded.
             //             NSLog(@"Retrieved %lu photos.", (unsigned long)objects.count);
             //             // Do something with the found objects
             //             for (PFObject *object in objects) {
             //                 NSLog(@"%@", object);
             //
             //             }
             //             NSLog(@"Objects: %lu.", (unsigned long)self.objects.count);
             [self.collectionView reloadData];
             
         } else {
             // Log details of the failure
             NSLog(@"Error: %@ %@", error, [error userInfo]);
         }
     }];
    
}
- (NSInteger)collectionView:(UICollectionView * _Nonnull)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return self.objects.count;
}

- (PFUI_NULLABLE PFCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath object:(PFUI_NULLABLE PFObject *)object
{
    CVCell *cell = (CVCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"CVCell" forIndexPath:indexPath];
    
    cell.imageView.image = [UIImage imageNamed:@"placeholder_small"];
    //cell.imageView.file = [object objectForKey:@"imageFile"];
    cell.imageView.file = [object objectForKey:@"thumbnailFile"];
    
    [cell.imageView loadInBackground:^(UIImage * _Nullable image, NSError * _Nullable error) {
        if (image){
            //NSLog(@"image loaded");
            NSLog(@"after loading image: %@", cell.imageView.image);
        } else {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // When user selects image, perform segue to next VC and pass it the selected PFObject for displaying image
    self.objectToPass = [self.objects objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"downloadSegue" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    DownloadViewController *vc = segue.destinationViewController;
    vc.object = self.objectToPass;
}


@end
