//
//  ViewController.h
//  CameraApp
//
//  Created by Mladjan Antic on 5/16/13.
//  Copyright (c) 2013 Imperio. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 Starting title view
 */
@interface TitleScreenViewController : UIViewController

/**
 Icon image view
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

/**
 Title image view
 */
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;

/**
 First picture frame (left)
 */
@property (weak, nonatomic) IBOutlet UIImageView *frameLeftImageView;

/**
 Second picture frame (right)
 */
@property (weak, nonatomic) IBOutlet UIImageView *frameRightImageView;

/**
 Getting started button
 */
@property (weak, nonatomic) IBOutlet UIButton *gettingStartedBtn;

/**
 Getting started button action
 */
- (IBAction)gettingStartedTapped:(id)sender;
@end
