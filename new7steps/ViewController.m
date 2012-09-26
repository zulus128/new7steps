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
    

    if(again)
        return;
    again = YES;
    
    NSString *appFile = [[NSBundle mainBundle] pathForResource:@"desc" ofType:@"plist"];
    favs = [[NSMutableDictionary alloc] initWithContentsOfFile:appFile];
    
    queue = [NSOperationQueue new];
    
    int y = 0;//
    [[Common instance] addRecipes];

    for (int i = 1; i <= [[Common instance] getMaxCategory]/*8*/ ; i++) {
    
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, 320, 30)];
        imgView.image = [UIImage imageNamed:@"plase_for_header.png"];
        [self.vertScrollView addSubview:imgView];

        UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, y + 28, 320, 301)];
        imgView1.image = [UIImage imageNamed:@"back-place2.png"];
        [self.vertScrollView addSubview:imgView1];

        UILabel *sLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(10, y + 3, 150, 20) ];
//        sLabel.textAlignment =  UITextAlignmentCenter;
//        sLabel.textColor = [UIColor redColor];
        sLabel.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
        sLabel.backgroundColor = [UIColor clearColor];
        sLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(14.0)];
        [self.vertScrollView addSubview:sLabel];
//        sLabel.text = [NSString stringWithFormat: @"%@ %d", NSLocalizedString(@"COURSE", nil), i];
        sLabel.text = [[Common instance].cats objectForKey:[NSNumber numberWithInt:i]];
        
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y+33, 320, 301)];
        scroll.scrollEnabled = YES;
        scroll.contentSize = CGSizeMake([[Common instance] getMaxRecipesForCategory:i] * 160 / 2 + 20, 301);
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.directionalLockEnabled = YES;
        [self.vertScrollView addSubview:scroll];

//        NSLog(@"fff %d, %d, %d, %d", 1%2, 2%2, 3%2, 4%2);
//        BOOL row = NO;
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
            
            
            
            UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(xx + 2, yy + 2, 156, 102)];
            imgView2.image = [[Common instance] getImage:it.image];
            [scroll addSubview:imgView2];

//            UIProgressView* progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
//            progressView.frame = CGRectMake(0, 0, 20, 20);
//            [scroll addSubview: progressView];

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
            UILabel *sLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(xx + 5, yy + 100, 140, 40) ];
            sLabel.textColor = [UIColor redColor];
            sLabel.backgroundColor = [UIColor clearColor];
            sLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:11.0];
            sLabel.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
            sLabel.numberOfLines = 2;
            sLabel.text = it.name;
            [scroll addSubview:sLabel];
            
//            NSLog(@"%d, %d, %@",i,j,s);
//            row =b !row;
            

        }

        y+= 340;
    }

    self.vertScrollView.contentSize = CGSizeMake(320, y);
    

    self.titleLabel.text = NSLocalizedString(@"TITLE", nil);
}

- (void)loadImage:(Transit*) tr {
    
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:tr.url]];
    tr.image = [[UIImage alloc] initWithData:imageData];

    [self performSelectorOnMainThread:@selector(displayImage:) withObject:tr waitUntilDone:YES];
}

- (void)displayImage:(Transit*)tr {
    
    [tr.view setImage:tr.image];
    
    NSString* n = [tr.url lastPathComponent];
    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docpath = [sp objectAtIndex: 0];
    NSString* filePath = [docpath stringByAppendingPathComponent:n];
    NSData *imgData = UIImagePNGRepresentation(tr.image);
    [imgData writeToFile:filePath atomically:YES];
    
//    [tr.activInd stopAnimating];
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

        ViewController2* detailViewController = (ViewController2*)segue.destinationViewController;
        detailViewController.itemtag = buttag;
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


@end
