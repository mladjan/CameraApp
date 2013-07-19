//
//  CropImageViewController.h
//  CameraApp
//
//  Created by Mladjan Antic on 5/16/13.
//  Copyright (c) 2013 Imperio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLImageCropperView.h"

/**
View for cropping captured picture into desired dimenstion
 */
@interface CropImageViewController : UIViewController

/**
 Back button action
 */
- (IBAction)backBtnTapped:(id)sender;

/**
 Crop button action
 */
- (IBAction)cropImageBtn:(id)sender;
@end
