//
//  SpsController.m
//  new7steps
//
//  Created by Zul on 10/30/12.
//
//

#import "SpsController.h"
#import "Common.h"
#import "MSLabel.h"
#import "Ingridient.h"

#define TAG 42
#define ZACH 100000

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

- (void)viewDidAppear:(BOOL)animated {
    
    [Common instance].prev_window = WT_SPISOK;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.titleLabel.font = [UIFont fontWithName:@"Good-Black" size:22.0];
//    self.titleLabel.text = NSLocalizedString(@"TITLE", nil);
    self.titleLabel.text = NSLocalizedString(@"MAINBUTTONSPS", nil);
    
    prev_window = [Common instance].prev_window;

    NSString* s;
    switch ([Common instance].prev_window) {
        case WT_NONE:
        case WT_MAIN:
        case WT_FAVOURITES:
        default:
            s = NSLocalizedString(@"MAINBUTTON", nil);
            break;
//        case WT_FAVOURITES:
//            s = NSLocalizedString(@"MAINBUTTONFAV", nil);
//            break;
        case WT_RECIPE:
            s = NSLocalizedString(@"MAINBUTTONREC", nil);
            break;
        case WT_SPISOK:
            s = NSLocalizedString(@"MAINBUTTONSPS", nil);
            break;
        case WT_SEARCH:
            s = NSLocalizedString(@"SEARCHBUTTON", nil);
            break;
    }
    [self.goRecipes setTitle:s forState:UIControlStateNormal];
    self.goRecipes.titleLabel.font = [UIFont fontWithName:@"Good-Book" size:20.0];

    [self setup];
}

- (void) setup {
    
    for(UIView *v in self.vertScrollView.subviews){
        if(v.tag > 0) {
            
            [v removeFromSuperview];
        }
    }
    
    
    int y = 20;
//    int cnt = 1;
    
    for (int i = 0; i < [[Common instance] getSpsRecipeCnt]; i++) {
        
        Item* it = [[Common instance] getSpsRecipe:i];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, 320, 40)];
        imgView.image = [UIImage imageNamed:@"HEADER1_SPISOK.png"];
        imgView.tag = TAG;
        [self.vertScrollView addSubview:imgView];
        
        MSLabel *sLabel = [[MSLabel alloc] initWithFrame:CGRectMake(20, y + 7, 280, 34) ];
        sLabel.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
        sLabel.backgroundColor = [UIColor clearColor];
        sLabel.textAlignment = UITextAlignmentLeft;
        sLabel.font = [UIFont fontWithName:@"Good-Black" size:(12.0)];
        sLabel.tag = TAG;
        sLabel.numberOfLines = 2;
        sLabel.lineHeight = 13;
        [self.vertScrollView addSubview:sLabel];
        sLabel.text = it.name;
        
        UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [but1 setImage:[UIImage imageNamed:@"krest_SPISOK.png"] forState:UIControlStateNormal];
        but1.tag = 10000 + i;
        [but1 addTarget:self action:@selector(buttonDelEvent:) forControlEvents:UIControlEventTouchUpInside];
        [but1 setFrame: CGRectMake(282, y + 3, 31, 31)];
        [but1 setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
        [self.vertScrollView addSubview:but1];

        y += 35;
        
        for (int j = 0; j < it.ingrids.count; j++) {

            Ingridient* ing = [it.ingrids objectAtIndex:j];
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, y, 293, 25)];
            imgView.image = [UIImage imageNamed:@"table_SPISOK.png"];
            imgView.tag = TAG;
            [self.vertScrollView addSubview:imgView];

//            UILabel *sLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(45, y + 3, 150, 24) ];
//            sLabel.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
//            sLabel.backgroundColor = [UIColor clearColor];
//            sLabel.font = [UIFont fontWithName:@"Good-Book" size:(12.0)];
//            sLabel.tag = TAG;
//            sLabel.textAlignment = UITextAlignmentLeft;
//            [self.vertScrollView addSubview:sLabel];
//            sLabel.text = ing.name;//[it.ingrids.allKeys objectAtIndex:j];

            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            but.tag = 1000000 + i * CAT_MULT + j + 1;
            [but addTarget:self action:@selector(buttonCheckEvent:) forControlEvents:UIControlEventTouchUpInside];
            [but setFrame: CGRectMake(45, y + 3, 300, 24)];
            [but setTitle:ing.name forState:UIControlStateNormal];
            [but setTitleColor:[UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0] forState:UIControlStateNormal];
            but.titleLabel.backgroundColor = [UIColor clearColor];
            but.titleLabel.font = [UIFont fontWithName:@"Good-Book" size:(12.0)];
//            but.titleLabel.textAlignment = UITextAlignmentLeft;
            [but setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];

            [self.vertScrollView addSubview:but];

            UILabel *sLabel1 = [ [UILabel alloc ] initWithFrame:CGRectMake(150, y + 3, 150, 24) ];
            sLabel1.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
            sLabel1.backgroundColor = [UIColor clearColor];
            sLabel1.font = [UIFont fontWithName:@"Good-Book" size:(12.0)];
            sLabel1.tag = TAG;
            sLabel1.textAlignment = UITextAlignmentRight;
            [self.vertScrollView addSubview:sLabel1];
            sLabel1.text = ing.text;//[it.ingrids.allValues objectAtIndex:j];

            BOOL b = NO;
            NSString* key = ing.name;//[it.ingrids.allKeys objectAtIndex:j];
            NSString* checked = [it.ingrids_checked objectForKey:key];
            if(checked != nil)
                if([checked isEqualToString:@"YES"]) {

                    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(43, y + 12, 260, 1)];
                    imgView.image = [UIImage imageNamed:@"zacherkivanie_SPISOK.png"];
                    imgView.tag = ZACH + i * CAT_MULT + j + 1;
                    [self.vertScrollView addSubview:imgView];
                    b = YES;
                    
                }

            UIButton *but1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [but1 setImage:[UIImage imageNamed:b?@"off_SPISOK.png":@"on_SPISOK.png"] forState:UIControlStateNormal];
            but1.tag = i * CAT_MULT + j + 1;
            [but1 addTarget:self action:@selector(buttonCheckEvent:) forControlEvents:UIControlEventTouchUpInside];
            [but1 setFrame: CGRectMake(15, y - 2, 28, 29)];
            [but1 setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
            [self.vertScrollView addSubview:but1];

            y += 25;
        }
        
        y += 25;
    }
    
    self.vertScrollView.contentSize = CGSizeMake(320, y);
    
}

- (void)buttonCheckEvent:(id)sender {
    
    int buttag = ((UIButton*)sender).tag - 1;

    if(buttag > 900000)
        buttag -= 1000000;
    
    UIButton* send = (UIButton*)[self.vertScrollView viewWithTag:(buttag + 1)];
    
//    float x = ((UIButton*)sender).frame.origin.x;
//    float y = ((UIButton*)sender).frame.origin.y;
    float x = send.frame.origin.x;
    float y = send.frame.origin.y;

    NSLog(@"Spisok check button %d clicked!!! x = %f, y = %f", buttag, x, y);

    
    
    int i = buttag / CAT_MULT;
    int j = buttag - i * CAT_MULT;
    Item* it = [[Common instance] getSpsRecipe:i];
    Ingridient* ing = [it.ingrids objectAtIndex:j];
    NSString* key = ing.name;//[it.ingrids.allKeys objectAtIndex:j];
    
    if ([@"YES" isEqualToString:[it.ingrids_checked objectForKey:key]]) {
        
        [[self.vertScrollView viewWithTag:(buttag + ZACH + 1)] removeFromSuperview];
        [it.ingrids_checked setObject:@"NO" forKey:key];
        NSLog(@"UnChecked i = %d, j = %d, buttag = %d, key = %@", i, j, buttag - ZACH + 1, key);
        [[Common instance] saveSpsRecipes];
        
//        [((UIButton*)sender) setImage:[UIImage imageNamed:@"on_SPISOK.png"] forState:UIControlStateNormal];
        [send setImage:[UIImage imageNamed:@"on_SPISOK.png"] forState:UIControlStateNormal];

        return;
    }
    
    float a = 28;
    float b = 14;
    UIImageView *polosa = [[UIImageView alloc] initWithFrame:CGRectMake(x + a, y + b, /*260*/2, 1)];
    polosa.image = [UIImage imageNamed:@"zacherkivanie_SPISOK.png"];
    polosa.tag = ZACH + i * CAT_MULT + j + 1;
    [self.vertScrollView addSubview:polosa];

    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         polosa.frame = CGRectMake(x + a, y + b, 260, 1);
                     }
                     completion:^(BOOL finished) {
                         
                     }
     ];
    
    

    [it.ingrids_checked setObject:@"YES" forKey:key];
    NSLog(@"Checked i = %d, j = %d, buttag = %d, key = %@", i, j, ZACH + i * CAT_MULT + j + 1, key);
    [[Common instance] saveSpsRecipes];
    
//    [((UIButton*)sender) setImage:[UIImage imageNamed:@"off_SPISOK.png"] forState:UIControlStateNormal];
    [send setImage:[UIImage imageNamed:@"off_SPISOK.png"] forState:UIControlStateNormal];

}

- (void)buttonDelEvent:(id)sender {
    
    int buttag = ((UIButton*)sender).tag - 10000;
    NSLog(@"Spisok DEL button %d clicked!!!", buttag);
    
    Item* it = [[Common instance] getSpsRecipe:buttag];
    [it.ingrids_checked removeAllObjects];

    [[Common instance] delSpsRecipe:buttag];
    
    [self setup];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return NO;
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

- (IBAction) exit {
    
    switch (prev_window) {
        case WT_NONE:
        case WT_MAIN:
        case WT_RECIPE:
        case WT_SPISOK:
        case WT_SEARCH:
        default: {
            [self dismissModalViewControllerAnimated:YES];
            break;
        }
        case WT_FAVOURITES:
        {
            ViewController *ivc = [Common instance].mainController;
            [ivc dismissModalViewControllerAnimated:YES];
            break;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
