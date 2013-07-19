//
//  ViewController.m
//  CameraApp
//
//  Created by Mladjan Antic on 5/16/13.
//  Copyright (c) 2013 Imperio. All rights reserved.
//

#import "TitleScreenViewController.h"
#import "CameraCaptureViewController.h"
#import <QuartzCore/QuartzCore.h>

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

@interface TitleScreenViewController ()

@end

@implementation TitleScreenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(!IS_IPHONE5){
        CGRect frameLeftRect = self.frameLeftImageView.frame;
        frameLeftRect.origin.y = 95;
        CGRect frameRightRect = self.frameRightImageView.frame;
        frameRightRect.origin.y = 95;

        CGRect iconFrame = self.iconImageView.frame;
        CGRect titleFrame = self.titleImageView.frame;
        iconFrame.origin.y = 80;
        titleFrame.origin.y = 273;
        
        [self.titleImageView setFrame:titleFrame];
        [self.iconImageView setFrame:iconFrame];
        [self.frameLeftImageView setFrame:frameLeftRect];
        [self.frameRightImageView setFrame:frameRightRect];
    }
    
    [self introAnimation];
}


-(void)introAnimation{
    // Fade out icon
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [self.iconImageView setAlpha:0];
    [UIView commitAnimations];
    
    
    
    // Move title top
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelay:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    CGRect titleRect = self.titleImageView.frame;
    if(IS_IPHONE5){
        titleRect.origin.y = 50.0f;
    }else{
        titleRect.origin.y = 20.0f;
    }
    [self.titleImageView setFrame:titleRect];
    [UIView commitAnimations];
    
    
    
    // Animate first picture frame
    self.frameLeftImageView.alpha = 0;
	self.frameLeftImageView.transform = CGAffineTransformMakeScale(1.6, 1.6);

	[UIView animateWithDuration:.5 delay:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
		self.frameLeftImageView.alpha = 1;
		self.frameLeftImageView.transform = CGAffineTransformMakeScale(1, 1); } completion:NULL];

    
    
    // Animate second picture frame
    self.frameRightImageView.alpha = 0;
	self.frameRightImageView.transform = CGAffineTransformMakeScale(1.6, 1.6);
    
	[UIView animateWithDuration:.5 delay:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
		self.frameRightImageView.alpha = 1;
		self.frameRightImageView.transform = CGAffineTransformMakeScale(1, 1); } completion:NULL];
    
    // Fade in "Get Started" button
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelay:1];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [self.gettingStartedBtn setAlpha:1];
    [UIView commitAnimations];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setIconImageView:nil];
    [self setTitleImageView:nil];
    [self setFrameLeftImageView:nil];
    [self setFrameRightImageView:nil];
    [self setGettingStartedBtn:nil];
    [super viewDidUnload];
}
- (IBAction)gettingStartedTapped:(id)sender {
    CameraCaptureViewController *cameraCaptureViewController = [[CameraCaptureViewController alloc] initWithNibName:@"CameraCaptureViewController" bundle:nil];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:cameraCaptureViewController];
    [self presentViewController:navController animated:YES completion:nil];
}
@end
