//
//  ViewController.m
//  new7steps
//
//  Created by вадим on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
#import "ViewController2.h"
#import "Transit.h"
#import "MSLabel.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize vertScrollView;
@synthesize filePath = _filePath;
//@synthesize panelbut;
@synthesize panel1;

- (void)viewDidLoad {

//    NSLog(@"EEEEEEEEEEEE");
    
    [Common instance].mainController = self;
    
    sView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    sView.image = [UIImage imageNamed:@"Default.png"];
    [self.view addSubview:sView];
    
    sIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    sIndicator.alpha = 1.0;
    sIndicator.center = CGPointMake(160, 280);
    sIndicator.hidesWhenStopped = YES;
    [sIndicator setColor:[UIColor grayColor]];
    [self.view addSubview:sIndicator];
    [sIndicator startAnimating];

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];

    self.titleLabel.font = [UIFont fontWithName:@"Good-Black" size:22.0];
    
    self.imgdict = [[NSMutableDictionary alloc] init];
    
    //    NSString *appFile = [[NSBundle mainBundle] pathForResource:@"desc" ofType:@"plist"];
    //    favs = [[NSMutableDictionary alloc] initWithContentsOfFile:appFile];
    
    queue = [NSOperationQueue new];
    self.titleLabel.text = NSLocalizedString(@"TITLE", nil);
//    [[Common instance] addRecipes];

//    [self setup];

}

//- (void)viewWillAppear:(BOOL)animated {
//
//    NSLog(@"SSSSSSSSSSSS");
//    
//}

- (void) viewDidAppear:(BOOL)animated {

   [Common instance].prev_window = WT_MAIN;

   if(again)
       return;
    
    again = YES;
    
    [[Common instance] addRecipes];
    [self setup];

    NSLog(@"SSSSSSSSSSSS1");
    [sIndicator stopAnimating];
    
    [sView removeFromSuperview];

}

- (void) setup {
    
    int y = 0;//
    
    for (int i = 1; i <= [[Common instance] getMaxCategory]/*8*/ ; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, 320, 30)];
        imgView.image = [UIImage imageNamed:@"plase_for_header.png"];
        [self.vertScrollView addSubview:imgView];
        
        UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, y + 28, 320, 301)];
        imgView1.image = [UIImage imageNamed:@"back-place2.png"];
        [self.vertScrollView addSubview:imgView1];
        
        //        UILabel *sLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(10, y + 3, 150, 20) ];
        UILabel *sLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(10, y + 5, 350, 24) ];
        sLabel.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
        sLabel.backgroundColor = [UIColor clearColor];
        //        sLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(14.0)];
        sLabel.font = [UIFont fontWithName:@"Good-Black" size:(18.0)];
        [self.vertScrollView addSubview:sLabel];
        sLabel.text = [[Common instance].cats objectForKey:[NSNumber numberWithInt:i]];
        
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y+33, 320, 301)];
        scroll.tag = i;
        scroll.delegate = self;
        scroll.scrollEnabled = YES;
        scroll.contentSize = CGSizeMake([[Common instance] getMaxRecipesForCategory:i] * 160 / 2 + 20, 301);
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.directionalLockEnabled = YES;
        [self.vertScrollView addSubview:scroll];
        
        int jj = 0;
        for (int j = 1; j <= [[Common instance] getMaxRecipesForCategory:i]/*4*/ ; j++) {
            
            Item* it = [[Common instance] getRecipe:j forCategory:i];
            int yy;
            int xx;
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            if(j%2) {
                
                yy = 0;
                xx = jj * 160 + 10;
            }
            else {
                
                yy = 145;
                xx = jj * 160 + 10;
                jj++;
            }
            but.frame = CGRectMake(xx, yy, 160, 106);
            [but setImage:[UIImage imageNamed:@"background_for_photo.png"] forState:UIControlStateNormal];
            but.tag = i * CAT_MULT + j;
            [but addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
            [scroll addSubview:but];
            
            //            UILabel *sLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(xx + 5, yy + 100, 140, 40) ];
//            UILabel *sLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(xx + 5, yy + 105, 140, 45) ];
            MSLabel *sLabel = [ [MSLabel alloc ] initWithFrame:CGRectMake(xx + 5, yy + 107, 140, 45) ];
            sLabel.textColor = [UIColor redColor];
            sLabel.lineHeight = 13;
            sLabel.backgroundColor = [UIColor clearColor];
            //            sLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:11.0];
            sLabel.font = [UIFont fontWithName:@"Good-Book" size:12.0];
            sLabel.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
            sLabel.numberOfLines = 3;
            sLabel.text = it.name;
            [scroll addSubview:sLabel];
        }
        
        [self refreshImages:scroll cnt1:3 cat:i];
        
        y+= 340;
    }
    
    self.vertScrollView.contentSize = CGSizeMake(320, y);
    
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

//    NSLog(@"Scroll");

    [self refreshImages:scrollView cnt1:1e5 cat:scrollView.tag];

}

- (void)refreshImages: (UIView*) scroll cnt1:(int) cnt1 cat:(int)i {
    
    int jj = 0;
    int cnt = 0;
    for (int j = 1; j <= [[Common instance] getMaxRecipesForCategory:i]/*4*/ ; j++) {
        
        Item* it = [[Common instance] getRecipe:j forCategory:i];
        int yy;
        int xx;
//        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        if(j%2) {
            
            yy = 0;
            xx = jj * 160 + 10;
        }
        else {
            
            yy = 145;
            xx = jj * 160 + 10;
            jj++;
        }
//        but.frame = CGRectMake(xx, yy, 160, 106);
//        [but setImage:[UIImage imageNamed:@"background_for_photo.png"] forState:UIControlStateNormal];
//        but.tag = i * CAT_MULT + j;
//        [but addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
//        [scroll addSubview:but];
        
        int t = i * CAT_MULT + j;
        if([self.imgdict objectForKey:[NSNumber numberWithInt:t]] != nil)
            continue;
        
        UIImage* img = [[Common instance] getImage:it.image];
           
        if((cnt > cnt1) && (img == nil))
        continue;
                        
        UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(xx + 2, yy + 2, 156, 102)];
        imgView2.image = img;
        imgView2.tag = t;
        //            if(imgView2.image == nil)
        //                imgView2.image = [UIImage imageNamed:@"background_for_photo.png"];
        [scroll addSubview:imgView2];
        [self.imgdict setObject:imgView2 forKey:[NSNumber numberWithInt:t]];

        cnt++;

        if(imgView2.image == nil) {
            
            Transit* tr = [[Transit alloc] init];
            tr.view = imgView2;
            tr.url = it.image;
            
            UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            activityIndicator.alpha = 1.0;
            activityIndicator.center = CGPointMake(79, 52);
            activityIndicator.hidesWhenStopped = YES;
            [tr.view addSubview:activityIndicator];
            [activityIndicator startAnimating];
            tr.activInd = activityIndicator;
            
            NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                                initWithTarget:self
                                                selector:@selector(loadImage:)
                                                object:tr];
            [queue addOperation:operation];
        }
        
//        UILabel *sLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(xx + 5, yy + 100, 140, 40) ];
//        sLabel.textColor = [UIColor redColor];
//        sLabel.backgroundColor = [UIColor clearColor];
//        sLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:11.0];
//        sLabel.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
//        sLabel.numberOfLines = 2;
//        sLabel.text = it.name;
//        [scroll addSubview:sLabel];

    }

}

- (void)loadImage:(Transit*) tr {
    
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:tr.url]];
    tr.image = [[UIImage alloc] initWithData:imageData];

    [self performSelectorOnMainThread:@selector(displayImage:) withObject:tr waitUntilDone:YES];
}

- (void)displayImage:(Transit*)tr {
    
    [tr.view setImage:tr.image];
    
    NSString* n1 = [tr.url stringByReplacingOccurrencesOfString:@":" withString:@"-"];//[tr.url lastPathComponent];
    NSString* n = [n1 stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
//    NSLog(@"url = %@", n);
    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docpath = [sp objectAtIndex: 0];
    NSString* filePath = [docpath stringByAppendingPathComponent:n];
    NSData *imgData = UIImagePNGRepresentation(tr.image);
    [imgData writeToFile:filePath atomically:YES];
    
    [tr.activInd stopAnimating];
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

- (void)buttonEvent:(id)sender {
    
    buttag = ((UIButton*)sender).tag;
    NSLog(@" button %d clicked!!!", buttag);
    
    [self performSegueWithIdentifier: @"2ndSegue" sender: self];

}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
//    NSLog(@"prepareForSegue");
//    
    if ([segue.identifier isEqualToString:@"2ndSegue"]) {

//        ViewController2* detailViewController = (ViewController2*)segue.destinationViewController;
//        detailViewController.itemtag = buttag;
        [Common instance].itemtag = buttag;
        
        int i = [Common instance].itemtag / CAT_MULT;
        int j = [Common instance].itemtag - i * CAT_MULT;
        
        [Common instance].curitem = [[Common instance] getRecipe:j forCategory:i];

    }
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

- (BOOL)shouldAutorotate {
    
    return NO;
}

@end
