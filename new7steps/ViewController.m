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
#import "CMTwoToneProgressBar.h"

#define GAP 190
#define SPACE 20

@interface ViewController ()

@end

@implementation ViewController
@synthesize vertScrollView;
@synthesize filePath = _filePath;

- (void)viewDidLoad {

//    NSLog(@"EEEEEEEEEEEE");
    
    [Common instance].mainController = self;
    
    if([[UIScreen mainScreen]bounds].size.height == 568) {
        
        sView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        sView.image = [UIImage imageNamed:@"Default-568h.png"];
    
        progBar = [[CMTwoToneProgressBar alloc] initWithFrame:CGRectMake(80, 350, 160, 10)];

    }
    else {

        sView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
        sView.image = [UIImage imageNamed:@"Default.png"];

        progBar = [[CMTwoToneProgressBar alloc] initWithFrame:CGRectMake(80, 280, 160, 10)];

    }

    [self.view addSubview:sView];
    
    [self.view addSubview:progBar];

    sIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    sIndicator.alpha = 1.0;
    sIndicator.center = CGPointMake(160, 280);
    sIndicator.hidesWhenStopped = YES;
    [sIndicator setColor:[UIColor grayColor]];
//    [self.view addSubview:sIndicator];
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

    NSString* s = NSLocalizedString(@"SEARCHBUTTON", nil);
    [self.goRecipes setTitle:s forState:UIControlStateNormal];
    self.goRecipes.titleLabel.font = [UIFont fontWithName:@"Good-Book" size:20.0];
    

}

- (void) loadAllImages {

//    NSOperationQueue* queue1 = [NSOperationQueue new];

    u = 0;
    
    for(NSString* name in [Common instance].allImages) {

        NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                            initWithTarget:self
                                            selector:@selector(loadImage5:)
                                            object:name];
        [queue addOperation:operation];
        
        u++;
    }

    u = queue.operationCount;
}

- (void)loadImage5:(NSString*) name {

    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docpath = [sp objectAtIndex: 0];
    NSString* n1 = [name stringByReplacingOccurrencesOfString:@":" withString:@"-"];//[tr.url lastPathComponent];
    NSString* n = [n1 stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    NSString* filePath = [docpath stringByAppendingPathComponent:n];

    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {

        NSLog(@"file exists %@", n);

        return;
    }

    int k = 15;
    while(k) {
    
        NSData* imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:name]];
        
        if(imageData) {
            
            k = 0;
            NSData *imgData = UIImageJPEGRepresentation([[UIImage alloc] initWithData:imageData], 1);
            [imgData writeToFile:filePath atomically:YES];
            NSLog(@"file loaded %@", n);
        }
        else {
            
            k--;
            NSLog(@"NIL !!!!!!!!!!!!!!!!!!!!!!!!!! %d %@", k, name);
        }
    }

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"didReceiveMemoryWarning11");
    memfull = YES;
}

//- (void) loadAllImages {
//    
//    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString* docpath = [sp objectAtIndex: 0];
//
//    for(NSString* name in [Common instance].allImages) {
//        
//        NSString* n1 = [name stringByReplacingOccurrencesOfString:@":" withString:@"-"];
//        NSString* n = [n1 stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
//        NSString* filePath = [docpath stringByAppendingPathComponent:n];
//        
//        if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
//            continue;
//        
//        NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:name]];
////        NSData *imgData = UIImagePNGRepresentation([[UIImage alloc] initWithData:imageData]);
//        NSData *imgData = UIImageJPEGRepresentation([[UIImage alloc] initWithData:imageData], 1.0f);
//        [imgData writeToFile:filePath atomically:YES];
//        NSLog(@"file loaded %@", n);
////        [imageData release];
//        if(memfull)
//            break;
//    }
//    
//}

//- (void)viewWillAppear:(BOOL)animated {
//
//    NSLog(@"SSSSSSSSSSSS");
//    
//}

//- (void) showBar {
//    
//    [progBar setProgress:1 animated:NO];
//
//}

- (void) updateBar {
    
//    NSLog(@"updateBar");

    if(u < 1)
        u = 1;
    ff = (float)(u - queue.operationCount)/u;
    NSLog(@"f = %f %f %d", ff, u, queue.operationCount);

    [progBar setProgress:ff animated:YES];
    [progBar setNeedsDisplay];

    if (ff < 0.98f)
    [NSTimer scheduledTimerWithTimeInterval:1.0
                                                          target:self
                                                        selector:@selector(updateBar)
                                                        userInfo:nil
                                                         repeats:NO];
    else {
        
        [self setup];

        [progBar removeFromSuperview];
        [sIndicator stopAnimating];
        [sView removeFromSuperview];

    }

}

- (void) viewDidAppear:(BOOL)animated {

   [Common instance].prev_window = WT_MAIN;

   if(again)
       return;
    
    again = YES;
    
    [[Common instance] addRecipes];
//    [self setup];

//    [progBar setProgress:1 animated:NO];
   

    [self performSelectorInBackground:@selector(loadAllImages) withObject:nil];
//    u = queue.operationCount;
//    [self updateBar];
    [NSTimer scheduledTimerWithTimeInterval:2.0
                                     target:self
                                   selector:@selector(updateBar)
                                   userInfo:nil
                                    repeats:NO];
    
//    [self performSelectorInBackground:@selector(loadAllImages) withObject:nil];
//    [self performSelectorOnMainThread:@selector(loadAllImages) withObject:nil waitUntilDone:YES];
//    
//    BOOL b = YES;
//    u = queue.operationCount;
//    while (b) {
//        b = NO;
////        int k = 0;
////        NSLog(@"queue.operationCount = %d", queue.operationCount);
//        for(NSOperation *op in [queue operations]) {
//            
//            if(op.isExecuting) {
//                
//                b = YES;
////                k++;
//            }
//        }
//
//    }

    
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
        int k = [[Common instance] getMaxRecipesForCategory:i];
        if((k % 2) != 0)
            k++;
        scroll.contentSize = CGSizeMake(k * GAP / 2 + 2 * SPACE, 301);
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
                xx = jj * GAP + SPACE;
            }
            else {
                
                yy = 145;
                xx = jj * GAP + SPACE;
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
        
//        [self refreshImages:scroll cnt1:3 cat:i];
        [self refreshImages:scroll cnt1:1e5 cat:i];
        
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

        if(j%2) {
            
            yy = 0;
            xx = jj * GAP + SPACE;
        }
        else {
            
            yy = 145;
            xx = jj * GAP + SPACE;
            jj++;
        }

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
            tr.item = it;
            
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
        else
            [it createImageView];

        
    }

}

- (void)loadImage:(Transit*) tr {
    
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:tr.url]];
    tr.image = [[UIImage alloc] initWithData:imageData];

//    [self performSelectorOnMainThread:@selector(displayImage:) withObject:tr waitUntilDone:YES];
    [self performSelectorInBackground:@selector(displayImage:) withObject:tr];


}

- (void)displayImage:(Transit*)tr {
    
    [tr.view setImage:tr.image];
    
    NSString* n1 = [tr.url stringByReplacingOccurrencesOfString:@":" withString:@"-"];//[tr.url lastPathComponent];
    NSString* n = [n1 stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
//    NSLog(@"url = %@", n);
    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docpath = [sp objectAtIndex: 0];
    NSString* filePath = [docpath stringByAppendingPathComponent:n];
//    NSData *imgData = UIImagePNGRepresentation(tr.image);
    NSData *imgData = UIImageJPEGRepresentation(tr.image, 1.0f);
    [imgData writeToFile:filePath atomically:YES];
    [tr.item createImageView];
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

//- (IBAction)panelButtonClick:(id)sender{
//    
////    NSLog(@"panel button click");
//    
//    
//    if(!panelhide) {
//        
//    f = self.panel1.frame;
//    [UIView animateWithDuration:0.5 
//                             animations:^{
//                                 [self.panel1 setFrame:CGRectMake(f.origin.x - 250, f.origin.y, f.size.width, f.size.height)];
//                             }
//                             completion:^(BOOL finished){ if(finished) {
////                [[self ShowHideButton] setTitle:@"Show Panel" forState:UIControlStateNormal];
////                [self setCurrentState:kHidden];
//            }
//                             }];
//    }
//    else {
//        [UIView animateWithDuration:0.5 
//                         animations:^{
//                             [self.panel1 setFrame:CGRectMake(f.origin.x, f.origin.y, f.size.width, f.size.height)];
//                         }
//                         completion:^(BOOL finished){ if(finished) {
//            //                [[self ShowHideButton] setTitle:@"Show Panel" forState:UIControlStateNormal];
//            //                [self setCurrentState:kHidden];
//        }
//                         }];
//    }
//    
//    panelhide = !panelhide;
//}

//- (IBAction) search {
//
//    NSLog(@"Search");
//}

- (BOOL)shouldAutorotate {
    
    return NO;
}

@end
