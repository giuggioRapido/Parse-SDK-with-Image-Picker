//
//  DownloadViewController.h
//  Parse
//
//  Created by Chris on 9/21/15.
//  Copyright © 2015 Prince Fungus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>

@interface DownloadViewController : UIViewController
@property (weak, nonatomic) IBOutlet PFImageView *imageView;
@property (strong, nonatomic) PFObject *object;

@end
