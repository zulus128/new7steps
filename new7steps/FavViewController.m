//
//  FavViewController.m
//  new7steps
//
//  Created by Zul on 10/23/12.
//
//

#import "FavViewController.h"
#import "Common.h"
#import "MSLabel.h"
#define TAG 42

@interface FavViewController ()

@end

@implementation FavViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [Common instance].prev_window = WT_FAVOURITES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.titleLabel.text = NSLocalizedString(@"TITLE", nil);
    self.titleLabel.font = [UIFont fontWithName:@"Good-Black" size:22.0];

    NSString* s;
    switch ([Common instance].prev_window) {
        case WT_NONE:
        case WT_MAIN:
        default:
            s = NSLocalizedString(@"MAINBUTTON", nil);
            break;
        case WT_FAVOURITES:
            s = NSLocalizedString(@"MAINBUTTONFAV", nil);
            break;
        case WT_RECIPE:
            s = NSLocalizedString(@"MAINBUTTONREC", nil);
            break;
    }
    [self.goRecipes setTitle:s forState:UIControlStateNormal];
    
    [self setup];
}

- (void) setup {
    
    for(UIView *v in self.vertScrollView.subviews){
        if(v.tag > 0) {
            
            [v removeFromSuperview];
        }
    }
    
    int y = 20;
    
    for (int i = 0; i < [[Common instance] getFavRecipeCnt]; i++) {
        
        Item* it = [[Common instance] getFavRecipe:i];
        
        //        NSLog(@"Fav Item #%d", i);
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(0, y, 320, 72);
        [but setImage:[UIImage imageNamed:@"back_place_izbrannoe.png"] forState:UIControlStateNormal];
        but.tag = i + 1;
        [but addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
//        but.tag = TAG;
        [self.vertScrollView addSubview:but];
        
        UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
//        but1.frame = CGRectMake(292, y + 10, 15, 15);
        [but1 setImage:[UIImage imageNamed:@"krest_IZBRANNOE.png"] forState:UIControlStateNormal];
        but1.tag = 10000 + i;
        [but1 addTarget:self action:@selector(buttonDelEvent:) forControlEvents:UIControlEventTouchUpInside];
        [but1 setFrame: CGRectMake(284, y + 2, 31, 31)];
        [but1 setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];


//        but1.tag = TAG;
        [self.vertScrollView addSubview:but1];
        
        UIImage* img = [[Common instance] getImage:it.image];
        
        if(img == nil) {
            
            NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:it.image]];
            img = [[UIImage alloc] initWithData:imageData];
        }
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, y + 8, 81, 55)];
        imgView.image = img;
        imgView.tag = TAG;
        [self.vertScrollView addSubview:imgView];
        
        
        UILabel *sLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(100, y + 5, 150, 24) ];
        sLabel.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
        sLabel.backgroundColor = [UIColor clearColor];
        sLabel.font = [UIFont fontWithName:@"Good-Black" size:(12.0)];
        sLabel.tag = TAG;
        [self.vertScrollView addSubview:sLabel];
        sLabel.text = [[Common instance].cats objectForKey:[NSNumber numberWithInt:it.category]];
        
        MSLabel *sLabel1 = [ [MSLabel alloc ] initWithFrame:CGRectMake(100, y + 20, 150, 50) ];
        sLabel1.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
        sLabel1.backgroundColor = [UIColor clearColor];
        sLabel1.lineHeight = 13;
        sLabel1.font = [UIFont fontWithName:@"Good-Light" size:(12.0)];
        sLabel1.tag = TAG;
        [self.vertScrollView addSubview:sLabel1];
        sLabel1.numberOfLines = 3;
        sLabel1.text = it.name;
        
        y += 75;
    }
    
    self.vertScrollView.contentSize = CGSizeMake(320, y);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonEvent:(id)sender {
    
    int buttag = ((UIButton*)sender).tag;
    NSLog(@"Fav button %d clicked!!!", (buttag - 1));
    
    [Common instance].curitem = [[Common instance] getFavRecipe:(buttag - 1)];
    [self performSegueWithIdentifier: @"2ndSegue" sender: self];

}

- (void)buttonDelEvent:(id)sender {
    
    int buttag = ((UIButton*)sender).tag;
    NSLog(@"Fav DEL button %d clicked!!!", buttag);
    
    [[Common instance] delFavRecipe:(buttag - 10000)];
    
    [self setup];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {

    return NO;
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

- (IBAction) exit {
    
    [self dismissModalViewControllerAnimated:YES];
}

@end
