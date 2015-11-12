//
//  UIImage+UImage_ResizeAdditions.h
//  Parse
//
//  Created by Chris on 9/23/15.
//  Copyright © 2015 Prince Fungus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UImage_ResizeAdditions)

+ (UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size;
@end
