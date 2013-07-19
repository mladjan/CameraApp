//
//  CropImageViewController.m
//  CameraApp
//
//  Created by Mladjan Antic on 5/16/13.
//  Copyright (c) 2013 Imperio. All rights reserved.
//

#import "CropImageViewController.h"
#import "EditorViewController.h"

@interface CropImageViewController ()

@end

@implementation CropImageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
- (IBAction)backBtnTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cropImageBtn:(id)sender {
    NLImageCropperView *croppingView = (NLImageCropperView *)[self.view viewWithTag:1];
    UIImage *cropedImage = [croppingView getCroppedImage];
    EditorViewController *editor = [[EditorViewController alloc] initWithNibName:@"EditorViewController" bundle:nil];
    [editor setCapturedImage:cropedImage];
    
    [self.navigationController pushViewController:editor animated:YES];

}
@end
