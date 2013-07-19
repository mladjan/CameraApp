//
//  EditorViewController.h
//  CameraApp
//
//  Created by Mladjan Antic on 5/16/13.
//  Copyright (c) 2013 Imperio. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 View for editing, saving into camera rool and sharing picture
 */
@interface EditorViewController : UIViewController<UIGestureRecognizerDelegate>

/**
 Saving into camera roll and sharing button
 */
@property (weak, nonatomic) IBOutlet UIButton *universalBtn;

/**
 Final image
 */
@property (nonatomic, strong) UIImage *capturedImage;

/**
 Image view for editing preview
 */
@property (weak, nonatomic) IBOutlet UIImageView *capturedImageView;

/**
 Asset image 1
 */
@property (weak, nonatomic) IBOutlet UIImageView *assetImageView1;

/**
 Asset image 2
 */
@property (weak, nonatomic) IBOutlet UIImageView *assetImageView2;

/**
 Asset image 3
 */
@property (weak, nonatomic) IBOutlet UIImageView *assetImageView3;

/**
 Asset image 4
 */
@property (weak, nonatomic) IBOutlet UIImageView *assetImageView4;

/**
 Asset image 5
 */
@property (weak, nonatomic) IBOutlet UIImageView *assetImageView5;


/**
 Back button action
 */
- (IBAction)backBtnTapped:(id)sender;

/**
 Universal button action (save to camera roll or share)
 */
- (IBAction)universalBtnTapped:(id)sender;

@end
