//
//  ViewController2.m
//  new7steps
//
//  Created by вадим on 7/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController2.h"
#import "Common.h"

@interface ViewController2 ()

@end

@implementation ViewController2
@synthesize itemtag;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    int i = itemtag / CAT_MULT;
    int j = itemtag - i * CAT_MULT;
    
    Item* it = [[Common instance] getRecipe:j forCategory:i];
    
    int y = 160;
    
    UIImageView *imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, y)];
    imgView2.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:it.ingrid_image]]];
    [self.vertScrollView2 addSubview:imgView2];

    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, 320, 32)];
    imgView.image = [UIImage imageNamed:@"place2_under_picture.png"];
    [self.vertScrollView2 addSubview:imgView];
        
    y += 32;
    
    self.vertScrollView2.contentSize = CGSizeMake(320, y);

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
