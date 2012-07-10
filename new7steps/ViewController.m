//
//  ViewController.m
//  new7steps
//
//  Created by вадим on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize vertScrollView;
@synthesize filePath = _filePath;
//@synthesize panelbut;
@synthesize panel1;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    
    NSString *appFile = [[NSBundle mainBundle] pathForResource:@"desc" ofType:@"plist"];
    favs = [[NSMutableDictionary alloc] initWithContentsOfFile:appFile];
    
    
    int y = 0;
    [[Common instance] addRecipes];

    for (int i = 1; i <= [[Common instance] getMaxCategory]/*8*/ ; i++) {
    
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, 320, 33)];
        imgView.image = [UIImage imageNamed:@"header_line.png"];
        [self.vertScrollView addSubview:imgView];
//      [imgView release];
        
        UILabel *sLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(21, y + 5, 150, 20) ];
//        sLabel.textAlignment =  UITextAlignmentCenter;
        sLabel.textColor = [UIColor redColor];
        sLabel.backgroundColor = [UIColor clearColor];
        sLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(12.0)];
        [self.vertScrollView addSubview:sLabel];
        sLabel.text = [NSString stringWithFormat: @"КУРС %d", i];
        
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y+33, 320, 162)];
        scroll.scrollEnabled = YES;
        scroll.contentSize = CGSizeMake(740, 162);
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.directionalLockEnabled = YES;
        [self.vertScrollView addSubview:scroll];

        for (int j = 1; j <= [[Common instance] getMaxRecipesForCategory:i]/*4*/ ; j++) {

            Item* it = [[Common instance] getRecipe:j forCategory:i];
            
            UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake((j-1) * 183 + 5, 0, 180, 161)];
            imgView1.image = [UIImage imageNamed:@"square_for_picture_new.png"];
            [scroll addSubview:imgView1];
            //      [imgView release];
            UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake((j-1) * 183 + 8, 2, 175, 116)];
//            imgView2.image = [UIImage imageNamed:[NSString stringWithFormat: @"%d_%d_100.jpg", i,j]];
            imgView2.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:it.image]]];
            [scroll addSubview:imgView2];
            //      [imgView release];
            
            UILabel *sLabel = [ [UILabel alloc ] initWithFrame:CGRectMake((j-1) * 183 + 10, 110, 170, 50) ];
            //        sLabel.textAlignment =  UITextAlignmentCenter;
            sLabel.textColor = [UIColor redColor];
            sLabel.backgroundColor = [UIColor clearColor];
//            sLabel.font = [UIFont fontWithName:@"DevanagariSangamMN-Bold" size:10.0];
            sLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:12.0];
            sLabel.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
            sLabel.numberOfLines = 2;
//            NSString *s = [favs objectForKey:[NSString stringWithFormat: @"%d_%d", i,j]];
//            sLabel.text = s;
            sLabel.text = it.name;
            [scroll addSubview:sLabel];
            
//            NSLog(@"%d, %d, %@",i,j,s);

        }

        y+= 198;
    }

    self.vertScrollView.contentSize = CGSizeMake(320, y);
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
//    [_filePath release];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//    } else {
//        return YES;
//    }
    
    return NO;
}

- (IBAction)panelButtonClick:(id)sender{
    
//    NSLog(@"panel button click");
    
    
    if(!panelhide) {
        
    f = self.panel1.frame;
    [UIView animateWithDuration:0.5 
                             animations:^{
                                 [self.panel1 setFrame:CGRectMake(f.origin.x - 250, f.origin.y, f.size.width, f.size.height)];
                             }
                             completion:^(BOOL finished){ if(finished) {
//                [[self ShowHideButton] setTitle:@"Show Panel" forState:UIControlStateNormal];
//                [self setCurrentState:kHidden];
            }
                             }];
    }
    else {
        [UIView animateWithDuration:0.5 
                         animations:^{
                             [self.panel1 setFrame:CGRectMake(f.origin.x, f.origin.y, f.size.width, f.size.height)];
                         }
                         completion:^(BOOL finished){ if(finished) {
            //                [[self ShowHideButton] setTitle:@"Show Panel" forState:UIControlStateNormal];
            //                [self setCurrentState:kHidden];
        }
                         }];
    }
    
    panelhide = !panelhide;
}


@end
