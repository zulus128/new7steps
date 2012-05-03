//
//  ViewController.m
//  new7steps
//
//  Created by вадим on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize vertScrollView;
@synthesize filePath = _filePath;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    
    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docpath = [sp objectAtIndex: 0];
    self.filePath = [docpath stringByAppendingPathComponent:@"desc.plist"];
    BOOL fe = [[NSFileManager defaultManager] fileExistsAtPath:self.filePath];
    if(!fe) {
        
        NSLog(@"NO desc.plist FILE !!! Creating...");
        NSString *appFile = [[NSBundle mainBundle] pathForResource:@"desc" ofType:@"plist"];
        NSError *error;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager copyItemAtPath:appFile toPath:self.filePath error:&error];
        
    }
    
    favs = [[NSMutableDictionary alloc] initWithContentsOfFile:self.filePath];

    
    
    int y = 0;
    
    for (int i = 1; i <= 8 ; i++) {
    
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
        
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, y+33, 320, 137)];
        scroll.scrollEnabled = YES;
        scroll.contentSize = CGSizeMake(465, 132);
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.directionalLockEnabled = YES;
        [self.vertScrollView addSubview:scroll];

        for (int j = 1; j <= 4 ; j++) {

            UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake((j-1) * 115 + 5, 0, 113, 132)];
            imgView1.image = [UIImage imageNamed:@"square_for_picture_.png"];
            [scroll addSubview:imgView1];
            //      [imgView release];
            UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake((j-1) * 115 + 8, 2, 108, 72)];
            imgView2.image = [UIImage imageNamed:[NSString stringWithFormat: @"%d_%d_100.jpg", i,j]];
            [scroll addSubview:imgView2];
            //      [imgView release];
            
            UILabel *sLabel = [ [UILabel alloc ] initWithFrame:CGRectMake((j-1) * 115 + 8, 110, 113, 60) ];
            //        sLabel.textAlignment =  UITextAlignmentCenter;
            sLabel.textColor = [UIColor redColor];
            sLabel.backgroundColor = [UIColor clearColor];
            sLabel.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:(12.0)];
            
            [scroll addSubview:sLabel];

        }

        y+= 170;
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

@end
