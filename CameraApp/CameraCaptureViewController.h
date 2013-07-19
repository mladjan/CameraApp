//
//  CameraCaptureViewController.h
//  CameraApp
//
//  Created by Mladjan Antic on 5/16/13.
//  Copyright (c) 2013 Imperio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

/**
    View for capturing or selecting image
 */
@interface CameraCaptureViewController : UIViewController <UIImagePickerControllerDelegate>

/**
 Camera live preview
 */
@property (weak, nonatomic) IBOutlet UIImageView *livePreviewImageView;

/**
 Standard AVImageOutput 
 */
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;


/**
 Capture button action
 */
- (IBAction)captureBtnTapped:(id)sender;

/**
 Close button action
 */
- (IBAction)closeBtnTapped:(id)sender;

/**
 Album button action
 */
- (IBAction)albumBtnTapped:(id)sender;

@end
