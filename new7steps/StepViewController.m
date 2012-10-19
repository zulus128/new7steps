//
//  StepViewController.m
//  new7steps
//
//  Created by Zul on 10/19/12.
//
//

#import "StepViewController.h"

@interface StepViewController ()

@end

@implementation StepViewController

- (id) initWithImage:(UIImage*) im {
    
    self = [super init];
    if (self) {
        // Custom initialization
        CGRect screenBounds = [[UIScreen mainScreen] bounds];

        UIImageView *imgV = [[UIImageView alloc] initWithFrame:screenBounds];
        imgV.image = im;
        [self.view addSubview:imgV];

    }
    return self;
}

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//- (BOOL)shouldAutorotate {
//    
//    return YES;
//}
//
//- (NSUInteger)supportedInterfaceOrientations {
////    NSLog(@"supported called");
//    return UIInterfaceOrientationMaskAll;//Which is actually a default value
////    return UIInterfaceOrientationMaskLandscapeLeft;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
////    NSLog(@" preferred called");//This method is never called. WHY?
////    return UIInterfaceOrientationLandscapeRight;
//    return UIInterfaceOrientationLandscapeLeft;
//}

@end
