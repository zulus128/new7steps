//
//  KonkursViewController.m
//  new7steps
//
//  Created by вадим on 11/23/12.
//
//

#import "KonkursViewController.h"
#import "Common.h"

@interface KonkursViewController ()

@end

@implementation KonkursViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction) back {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.titleLabel.font = [UIFont fontWithName:@"Good-Black" size:22.0];
    self.titleLabel.text = NSLocalizedString(@"KONKBUTTON", nil);

    self.vertScrollView.contentSize = CGSizeMake(320, 982);
    
    NSString* s;
    switch ([Common instance].prev_window) {
        case WT_NONE:
        case WT_MAIN:
        case WT_FAVOURITES:
        case WT_RECIPE:
        case WT_SPISOK:
        case WT_SEARCH:
        default:
            s = NSLocalizedString(@"MAINBUTTON", nil);
            break;
            //        case WT_SEARCH:
            //            s = NSLocalizedString(@"SEARCHBUTTON", nil);
            //            break;
    }
    [self.goRecipes setTitle:s forState:UIControlStateNormal];
    self.goRecipes.titleLabel.font = [UIFont fontWithName:@"Good-Book" size:20.0];

    self.link1.frame = CGRectMake(2, 620, 290, 47);


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
