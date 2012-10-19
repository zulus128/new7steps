//
//  HorizontalController.m
//  new7steps
//
//  Created by Zul on 10/19/12.
//
//

#import "HorizontalController.h"

@interface HorizontalController ()

@end

@implementation HorizontalController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void)awakeFromNib
//{
//    isShowingLandscapeView = NO;
//    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(orientationChanged:)
//                                                 name:UIDeviceOrientationDidChangeNotification
//                                               object:nil];
//}
//
//- (void)orientationChanged:(NSNotification *)notification
//{
//    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
//    if (UIDeviceOrientationIsLandscape(deviceOrientation) &&
//        !isShowingLandscapeView)
//    {
//        [self performSegueWithIdentifier:@"DisplayAlternateView" sender:self];
//        isShowingLandscapeView = YES;
//    }
//    else if (UIDeviceOrientationIsPortrait(deviceOrientation) &&
//             isShowingLandscapeView)
//    {
//        [self dismissViewControllerAnimated:YES completion:nil];
//        isShowingLandscapeView = NO;
//    }
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
