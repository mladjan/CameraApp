//
//  CameraCaptureViewController.m
//  CameraApp
//
//  Created by Mladjan Antic on 5/16/13.
//  Copyright (c) 2013 Imperio. All rights reserved.
//

#import "CameraCaptureViewController.h"
#import "CropImageViewController.h"
#import "NSTimer+PSYBlockTimer.h"
#import "UIImage+Resize.h"

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)

@interface CameraCaptureViewController ()<AVCaptureVideoDataOutputSampleBufferDelegate>

@end

@implementation CameraCaptureViewController

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
    
    // Hide navBar
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    if(!IS_IPHONE5){
        CGRect frame = self.livePreviewImageView.frame;
        frame.size.height = 377;
        [self.livePreviewImageView setFrame:frame];
    }
    
    // Live Preview
    [self setupLivePreview];
}


#pragma mark - Camera
-(void)setupLivePreview{
    
    // Session
    AVCaptureSession *session = [AVCaptureSession new];
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    
    // Device input
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:[self cameraWithPosition:AVCaptureDevicePositionFront] error:&error];
	if ( [session canAddInput:deviceInput] )
		[session addInput:deviceInput];
    
    // Output
    self.stillImageOutput = [AVCaptureStillImageOutput new];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    if ([session canAddOutput:self.stillImageOutput])
        [session addOutput:self.stillImageOutput];

    
    // Preview
	AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [previewLayer setBackgroundColor:[[UIColor blackColor] CGColor]];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    CALayer *rootLayer = [self.livePreviewImageView layer];
	[rootLayer setMasksToBounds:YES];
	[previewLayer setFrame:CGRectMake(-70, 0, rootLayer.bounds.size.height, rootLayer.bounds.size.height)];
    [rootLayer insertSublayer:previewLayer atIndex:0];
        
    [session startRunning];
}

- (AVCaptureDevice *) cameraWithPosition:(AVCaptureDevicePosition) position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Buttons actions
- (IBAction)captureBtnTapped:(id)sender {
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.stillImageOutput.connections){
        for (AVCaptureInputPort *port in [connection inputPorts]){
            
            if ([[port mediaType] isEqual:AVMediaTypeVideo]){
                
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error){
                
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        
        CropImageViewController *cropImageView = [[CropImageViewController alloc] initWithNibName:@"CropImageViewController" bundle:nil];
        NLImageCropperView *cropView = [[NLImageCropperView alloc] initWithFrame:CGRectMake(15, 15, 290, 446)];
        cropView.tag = 1;
        [cropImageView.view addSubview:cropView];
        [cropView setImage:[image imageByScalingAndCroppingForSize:CGSizeMake(580, 892)]];
        [cropView setCropRegionRect:CGRectMake(0, 104, 580, 664)];
        [self.navigationController pushViewController:cropImageView animated:YES];
    }];    
}

- (IBAction)closeBtnTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)albumBtnTapped:(id)sender {
    UIImagePickerController	 *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [picker setDelegate:(id)self];
    [self presentViewController:picker animated:YES completion:nil];

}

#pragma mark - UIImagePicker delegates
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];

    CropImageViewController *cropImageView = [[CropImageViewController alloc] initWithNibName:@"CropImageViewController" bundle:nil];
    NLImageCropperView *cropView = [[NLImageCropperView alloc] initWithFrame:CGRectMake(15, 15, 290, 446)];
    cropView.tag = 1;
    [cropImageView.view addSubview:cropView];
    [cropView setImage:[[info objectForKey:@"UIImagePickerControllerOriginalImage"] imageByScalingAndCroppingForSize:CGSizeMake(580, 892)]];
    [cropView setCropRegionRect:CGRectMake(0, 104, 580, 664)];
    [self.navigationController pushViewController:cropImageView animated:YES];
    
}



- (void)viewDidUnload {
    [self setLivePreviewImageView:nil];
    [super viewDidUnload];
}
@end
