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
@synthesize scrollView, scrollView1;
@synthesize vertScrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    self.scrollView.hidden = YES;
    self.scrollView.contentSize = CGSizeMake(465, 132);
    self.scrollView1.contentSize = CGSizeMake(465, 132);

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

        }

        y+= 170;
    }

    self.vertScrollView.contentSize = CGSizeMake(320, y);

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
