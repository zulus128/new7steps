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
    
    self.xmlver.text = [NSString stringWithFormat:@"XML version = %.1f", [Common instance].versionXML];
    
    NSString* s = NSLocalizedString(@"SLEEPLABEL", nil);
    self.sleepLab.text = s;
    self.sleepLab.font = [UIFont fontWithName:@"Good-Book" size:20.0];
    self.sleepLab.textColor = [UIColor colorWithRed:205/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];

    self.xmlver.textColor = [UIColor colorWithRed:205/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];

    BOOL sl = [[NSUserDefaults standardUserDefaults] boolForKey:@"sleep"];
    [self.sleepSw setOn:sl animated:YES];


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
