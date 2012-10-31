//
//  SpsController.m
//  new7steps
//
//  Created by Zul on 10/30/12.
//
//

#import "SpsController.h"
#import "Common.h"

#define TAG 42

@interface SpsController ()

@end

@implementation SpsController

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
    
    self.titleLabel.font = [UIFont fontWithName:@"Good-Black" size:22.0];
    self.titleLabel.text = NSLocalizedString(@"TITLE", nil);
    
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
    
    for (int i = 0; i < [[Common instance] getSpsRecipeCnt]; i++) {
        
        Item* it = [[Common instance] getFavRecipe:i];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, y + 8, 320, 40)];
        imgView.image = [UIImage imageNamed:@"HEADER1_SPISOK.png"];
        imgView.tag = TAG;
        [self.vertScrollView addSubview:imgView];
        
        UILabel *sLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(100, y + 5, 150, 24) ];
        sLabel.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
        sLabel.backgroundColor = [UIColor clearColor];
        sLabel.font = [UIFont fontWithName:@"Good-Black" size:(12.0)];
        sLabel.tag = TAG;
        [self.vertScrollView addSubview:sLabel];
        sLabel.text = it.name;
        
        UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [but1 setImage:[UIImage imageNamed:@"krest_SPISOK.png"] forState:UIControlStateNormal];
        but1.tag = 10000 + i;
        [but1 addTarget:self action:@selector(buttonDelEvent:) forControlEvents:UIControlEventTouchUpInside];
        [but1 setFrame: CGRectMake(284, y + 2, 31, 31)];
        [but1 setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];

        for (int j = 0; j < it.ingrids.count; j++) {

            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, y + 8, 293, 25)];
            imgView.image = [UIImage imageNamed:@"table_SPISOK.png"];
            imgView.tag = TAG;
            [self.vertScrollView addSubview:imgView];

            UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [but1 setImage:[UIImage imageNamed:@"on_SPISOK.png"] forState:UIControlStateNormal];
            but1.tag = i * CAT_MULT + j;
            [but1 addTarget:self action:@selector(buttonCheckEvent:) forControlEvents:UIControlEventTouchUpInside];
            [but1 setFrame: CGRectMake(15, y + 2, 20, 22)];
            [but1 setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];

            UILabel *sLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(100, y + 5, 150, 24) ];
            sLabel.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
            sLabel.backgroundColor = [UIColor clearColor];
            sLabel.font = [UIFont fontWithName:@"Good-Book" size:(12.0)];
            sLabel.tag = TAG;
            [self.vertScrollView addSubview:sLabel];
            sLabel.text = [it.ingrids.allKeys objectAtIndex:j];

            UILabel *sLabel1 = [ [UILabel alloc ] initWithFrame:CGRectMake(150, y + 5, 150, 24) ];
            sLabel1.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
            sLabel1.backgroundColor = [UIColor clearColor];
            sLabel1.font = [UIFont fontWithName:@"Good-Book" size:(12.0)];
            sLabel1.tag = TAG;
            [self.vertScrollView addSubview:sLabel1];
            sLabel1.text = [it.ingrids.allValues objectAtIndex:j];

            y += 25;
        }
        
        y += 75;
    }
    
    self.vertScrollView.contentSize = CGSizeMake(320, y);
    
}

- (void)buttonCheckEvent:(id)sender {
    
    int buttag = ((UIButton*)sender).tag;
    NSLog(@"Spisok check button %d clicked!!!", buttag);
}

- (void)buttonDelEvent:(id)sender {
    
    int buttag = ((UIButton*)sender).tag;
    NSLog(@"Spisok DEL button %d clicked!!!", buttag);
    
    [[Common instance] delSpsRecipe:(buttag - 10000)];
    
    [self setup];
    
}

- (IBAction) exit {
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
