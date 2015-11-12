//
//  UploadViewController.h
//  Parse
//
//  Created by Chris on 9/18/15.
//  Copyright © 2015 Prince Fungus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "UIImage+UImage_ResizeAdditions.h"


@interface UploadViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *uploadCompleteLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet UIButton *selectImageButton;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (nonatomic) UIImagePickerController *imagePickerController;
@property (weak, nonatomic) IBOutlet UIButton *addButton;


@end
