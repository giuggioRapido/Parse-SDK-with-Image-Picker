//
//  DownloadViewController.m
//  Parse
//
//  Created by Chris on 9/21/15.
//  Copyright © 2015 Prince Fungus. All rights reserved.
//

#import "DownloadViewController.h"

@interface DownloadViewController ()

@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = [UIImage imageNamed:@"placeholder_small"];
    self.imageView.file = [self.object objectForKey:@"imageFile"];
    [self.imageView loadInBackground];
   // NSLog(@"image in DLVC: %@", self.imageView.image);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
