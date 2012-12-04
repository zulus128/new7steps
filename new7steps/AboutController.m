//
//  AboutController.m
//  new7steps
//
//  Created by Zul on 9/25/12.
//
//

#import "AboutController.h"
#import "Common.h"

@interface AboutController ()

@end

@implementation AboutController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) swich {
    
    NSLog(@"switch %d", self.sleepSw.isOn);
    
    [UIApplication sharedApplication].idleTimerDisabled = self.sleepSw.on;
    [[NSUserDefaults standardUserDefaults] setBool:self.sleepSw.on forKey:@"sleep"];

}

- (IBAction) back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.xmlver.text = [NSString stringWithFormat:@"Номер версии: %.0f", [Common instance].versionXML];
    
    NSString* s = NSLocalizedString(@"SLEEPLABEL", nil);
    self.sleepLab.text = s;
    self.sleepLab.font = [UIFont fontWithName:@"Good-Book" size:20.0];
    self.sleepLab.textColor = [UIColor colorWithRed:205/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];

    self.xmlver.textColor = [UIColor colorWithRed:205/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];

    BOOL sl = [[NSUserDefaults standardUserDefaults] boolForKey:@"sleep"];
    [self.sleepSw setOn:sl animated:YES];

    self.vertScrollView.contentSize = CGSizeMake(320, 1100);
    
    //    self.link1.frame = CGRectMake(11, 4, 290, 47);
    
    //    NSLog(@"self.link1 = %@", self.link1);
    
    self.link1.frame = CGRectMake(11, 394, 290, 47);
    self.link2.frame = CGRectMake(11, 466, 290, 47);
    self.link3.frame = CGRectMake(11, 539, 290, 47);
    self.link4.frame = CGRectMake(160, 666, 290, 47);
    self.link5.frame = CGRectMake(11, 717, 290, 47);
    self.link6.frame = CGRectMake(11, 770, 290, 47);
    
//    NSString* s1;
    switch ([Common instance].prev_window) {
        case WT_NONE:
        case WT_MAIN:
        case WT_SPISOK:
        default:
            s = NSLocalizedString(@"MAINBUTTON", nil);
            break;
        case WT_FAVOURITES:
            s = NSLocalizedString(@"MAINBUTTONFAV", nil);
            break;
        case WT_RECIPE:
            s = NSLocalizedString(@"MAINBUTTONREC", nil);
            break;
            //        case WT_SPISOK:
            //            s = NSLocalizedString(@"MAINBUTTONSPS", nil);
            //            break;
        case WT_SEARCH:
            s = NSLocalizedString(@"SEARCHBUTTON", nil);
            break;
    }
    [self.goRecipes setTitle:s forState:UIControlStateNormal];
    self.goRecipes.titleLabel.font = [UIFont fontWithName:@"Good-Book" size:20.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSLog(@"shouldAutorotate called");
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

@end
