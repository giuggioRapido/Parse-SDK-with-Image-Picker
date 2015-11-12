//
//  UploadViewController.m
//  Parse
//
//  Created by Chris on 9/18/15.
//  Copyright © 2015 Prince Fungus. All rights reserved.
//

#import "UploadViewController.h"

@interface UploadViewController ()

@end

@implementation UploadViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set Tab Bar icons and hide unwanted views
    self.tabBarItem.image = [UIImage imageNamed:@"UploadIcon"];
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    item1.image = [UIImage imageNamed:@"DownloadIcon"];
    
    self.uploadCompleteLabel.hidden = YES;
    
    self.progressView.hidden = YES;
    
}
- (IBAction)pressSelectImageButton:(id)sender
{
    // Call method to show image picker, passing in photo library parameter
    [self showImagePickerForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerController.sourceType = sourceType;
    imagePickerController.delegate = self;
    
    self.imagePickerController = imagePickerController;
    [self presentViewController:self.imagePickerController animated:YES completion:nil];
}


- (IBAction)pressUploadButton:(id)sender
{
    // Generate timestamp for naming files
    NSString *timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    NSString *imageFileName = [NSString stringWithFormat:@"Photo%@.png", timestamp];
    NSString *thumbnailFileName = [NSString stringWithFormat:@"Thumbnail%@.png", timestamp];
    NSString *photoName = [NSString stringWithFormat:@"Photo%@", timestamp];
    
    // Compress images (they're too large as is for Parse)
    NSData *imageData = UIImageJPEGRepresentation(self.selectedImageView.image, 0.5);
    PFFile *imageFile = [PFFile fileWithName:imageFileName data:imageData];
    
    // Create thumbnail
    UIImage *thumbnailImage = [UIImage imageWithImage:self.selectedImageView.image scaledToFillSize:CGSizeMake(50.0, 50.0)];
    NSData *thumbnailData = UIImageJPEGRepresentation(thumbnailImage, 1.0);
    PFFile *thumbnailFile = [PFFile fileWithName:thumbnailFileName data:thumbnailData];
    
    
    // Save file to Parse, tying progress bar and image alpha to upload status for UI cues
    [imageFile saveInBackgroundWithProgressBlock:^(int percentDone) {
        self.progressView.hidden = NO;
        self.progressView.progress = (float)percentDone/100;
        self.selectedImageView.alpha = self.progressView.progress;
        
        //         NSLog(@"Percent done: %i", percentDone);
        
        // When image is saved, [un]hide views accordingly
        if (percentDone == 100)
        {
            self.progressView.hidden = YES;
            self.uploadCompleteLabel.hidden = NO;
            NSLog(@"Image File upload succeeded");
        }
    }];
    
    // Save thumbnail file
    [thumbnailFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded){
            NSLog(@"Thumbnail file upload successful");
        } else {
            NSLog(@"thumbnail upload error: %@", error.localizedDescription);
        }
    }];
    
    // Save PFObjects to Parse
    PFObject *photo = [PFObject objectWithClassName:@"Photo"];
    [photo setObject:photoName forKey:@"imageName"];
    [photo setObject:imageFile forKey:@"imageFile"];
    [photo setObject:thumbnailFile forKey:@"thumbnailFile"];
    [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Photo upload succeeded");
        } else {
            NSLog(@"Photo upload failed with error: %@", error.localizedDescription);
        }
    }];
    
}

#pragma mark - UIImagePickerControllerDelegate

// This method is called when an image has been chosen from the library or taken from the camera.
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // When image selected, dismiss image picker and adjust views accordingly
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    self.selectedImageView.image = chosenImage;
    self.selectedImageView.alpha = 1.0;
    
    self.uploadButton.enabled = YES;
    
    self.uploadCompleteLabel.hidden = YES;
    
    self.addButton.hidden = YES;
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:NULL];
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
