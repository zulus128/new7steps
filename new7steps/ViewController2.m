//
//  ViewController2.m
//  new7steps
//
//  Created by вадим on 7/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController2.h"
#import "Transit.h"
#import "Step.h"
#import "MSLabel.h"
#import "Common.h"
#import "ViewController.h"
#import "Ingridient.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidAppear:(BOOL)animated {
    
    [Common instance].prev_window = WT_RECIPE;
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES animated:NO];

//    int i = [Common instance].itemtag / CAT_MULT;
//    int j = [Common instance].itemtag - i * CAT_MULT;
//    
//    it = [[Common instance] getRecipe:j forCategory:i];
    
    it = [Common instance].curitem;
    
    NSString* s;
    switch ([Common instance].prev_window) {
        case WT_NONE:
        case WT_MAIN:
        case WT_FAVOURITES:
        case WT_RECIPE:
        case WT_SPISOK:
        case WT_SEARCH:
        default:
            s = NSLocalizedString(@"MAINBUTTON", nil);
            break;
//        case WT_SEARCH:
//            s = NSLocalizedString(@"SEARCHBUTTON", nil);
//            break;
    }
    [self.goRecipes setTitle:s forState:UIControlStateNormal];
    self.goRecipes.titleLabel.font = [UIFont fontWithName:@"Good-Book" size:20.0];

    [self setup];

}

- (void)setup {

    int y = 160;
    imgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, y)];
    [self.vertScrollView2 addSubview:imgView2];
    imgView2_1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, y)];
    [self.vertScrollView3 addSubview:imgView2_1];
    
    UIImage* img = [[Common instance] getImage:it.image];
    UIImage* img1 = [[Common instance] getImage:it.ingrid_image];
    
    queue = [NSOperationQueue new];
    
    if(img1 != nil)
        [imgView2 setImage:img1];
    else {
        NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                            initWithTarget:self
                                            selector:@selector(loadImage)
                                            object:nil];
        
        [queue addOperation:operation];
    }
    
    if(img != nil)
        [imgView2_1 setImage:img];
    else {
        
        NSInvocationOperation *operation1 = [[NSInvocationOperation alloc]
                                             initWithTarget:self
                                             selector:@selector(loadImage1)
                                             object:nil];
        
        [queue addOperation:operation1];
    }
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, 320, 45)];
    imgView.image = [UIImage imageNamed:@"back_for_button.png"];
    [self.vertScrollView2 addSubview:imgView];
    
    y += 32;
    
    //    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    //    but.frame = CGRectMake(56, y - 24, 208, 29);
    //    [but setImage:[UIImage imageNamed:@"button_position1.png"] forState:UIControlStateNormal];
    //    [but addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.vertScrollView2 addSubview:but];
    
    UIImageView *imgBut = [[UIImageView alloc] initWithFrame:CGRectMake(56, y - 24, 104, 29)];
    imgBut.image = [UIImage imageNamed:@"button01.png"];
    [self.vertScrollView2 addSubview:imgBut];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(160, y - 24, 104, 29);
    [but setImage:[UIImage imageNamed:@"button02.png"] forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:@"button04.png"] forState:UIControlStateHighlighted];
    [but addTarget:self action:@selector(buttonEvent1:) forControlEvents:UIControlEventTouchUpInside];
    [self.vertScrollView2 addSubview:but];
    
    y += 20;
    int y1 = y;
    
    //    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(4, y, 310, 152)];
    //    imgView1.image = [UIImage imageNamed:@"back_100procentov_for_text.png"];
    //    [self.vertScrollView2 addSubview:imgView1];
    //
    //    UIImageView *imgView21 = [[UIImageView alloc] initWithFrame:CGRectMake(4, y + 160, 310, 152)];
    //    imgView21.image = [UIImage imageNamed:@"back_100procentov_for_text.png"];
    //    [self.vertScrollView2 addSubview:imgView21];
    
    //    y += 160;
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, 320, 6)];
    imgView1.image = [UIImage imageNamed:@"top_place.png"];
    [self.vertScrollView2 addSubview:imgView1];
    
    y += 6;
    
    for (int i = 0; i < 45; i++) {
        
        UIImageView *imgView21 = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, 320, 3)];
        imgView21.image = [UIImage imageNamed:@"center_place.png"];
        [self.vertScrollView2 addSubview:imgView21];
        
        y += 3;
        
    }
    
    UIImageView *imgView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, 320, 7)];
    imgView3.image = [UIImage imageNamed:@"bottom_place.png"];
    [self.vertScrollView2 addSubview:imgView3];
    
    y += 7;
    
    
    MSLabel *sLabel = [ [MSLabel alloc ] initWithFrame:CGRectMake(10, y1 + 5, 300, 40) ];
    sLabel.textAlignment =  UITextAlignmentCenter;
    sLabel.backgroundColor = [UIColor clearColor];
    //            sLabel.font = [UIFont fontWithName:@"DevanagariSangamMN-Bold" size:10.0];
    sLabel.font = [UIFont fontWithName:@"Thonburi-Bold" size:16.0];
    sLabel.textColor = [UIColor colorWithRed:205/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
    sLabel.numberOfLines = 2;
    sLabel.lineHeight = 13;
    sLabel.text = it.name;
    sLabel.adjustsFontSizeToFitWidth = YES;
    sLabel.minimumFontSize = 5.0;
    [self.vertScrollView2 addSubview:sLabel];
    y1 += 38;
    
    //    UILabel *sLabel1 = [ [UILabel alloc ] initWithFrame:CGRectMake(0, y1, 150, 20) ];
    //    sLabel1.textAlignment =  UITextAlignmentRight;
    //    sLabel1.backgroundColor = [UIColor clearColor];
    //    sLabel1.font = [UIFont fontWithName:@"Thonburi-Bold" size:10.0];
    //    sLabel1.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
    //    sLabel1.text = NSLocalizedString(@"RECIPE_TYPE", nil);//@"Тип рецепта";
    //    [self.vertScrollView2 addSubview:sLabel1];
    //    UILabel *sLabel11 = [ [UILabel alloc ] initWithFrame:CGRectMake(170, y1, 150, 20) ];
    //    sLabel11.textAlignment =  UITextAlignmentLeft;
    //    sLabel11.backgroundColor = [UIColor clearColor];
    //    sLabel11.font = [UIFont fontWithName:@"Thonburi-Bold" size:10.0];
    //    sLabel11.textColor = [UIColor colorWithRed:205/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
    //    sLabel11.text = it.type;
    //    [self.vertScrollView2 addSubview:sLabel11];
    //
    //    y1 += 10;
    
    UILabel *sLabel2 = [ [UILabel alloc ] initWithFrame:CGRectMake(5, y1, 145, 20) ];
    sLabel2.textAlignment =  UITextAlignmentRight;
    sLabel2.backgroundColor = [UIColor clearColor];
    sLabel2.font = [UIFont fontWithName:@"Thonburi-Bold" size:14.0];
    sLabel2.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
    sLabel2.text = NSLocalizedString(@"RECIPE_TIME", nil);//@"Время приготовления";
    [self.vertScrollView2 addSubview:sLabel2];
    UILabel *sLabel21 = [ [UILabel alloc ] initWithFrame:CGRectMake(170, y1, 150, 20) ];
    sLabel21.textAlignment =  UITextAlignmentLeft;
    sLabel21.backgroundColor = [UIColor clearColor];
    sLabel21.font = [UIFont fontWithName:@"Thonburi-Bold" size:14.0];
    sLabel21.textColor = [UIColor colorWithRed:205/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
    sLabel21.text = it.time;
    [self.vertScrollView2 addSubview:sLabel21];
    
    y1 += 22;
    
    MSLabel *sLabel3 = [[MSLabel alloc] initWithFrame:CGRectMake(5, y1, 145, 23) ];
    sLabel3.textAlignment =  UITextAlignmentRight;
    sLabel3.numberOfLines = 2;
    sLabel3.lineHeight = 8;
    sLabel3.backgroundColor = [UIColor clearColor];
    sLabel3.font = [UIFont fontWithName:@"Thonburi-Bold" size:14.0];
    sLabel3.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
    sLabel3.text = NSLocalizedString(@"CALORIES", nil);//@"Калорий на 100 грамм";
    [self.vertScrollView2 addSubview:sLabel3];
    UILabel *sLabel31 = [ [UILabel alloc ] initWithFrame:CGRectMake(170, y1, 150, 20) ];
    sLabel31.textAlignment =  UITextAlignmentLeft;
    sLabel31.backgroundColor = [UIColor clearColor];
    sLabel31.font = [UIFont fontWithName:@"Thonburi-Bold" size:14.0];
    sLabel31.textColor = [UIColor colorWithRed:205/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
    sLabel31.text = it.calories;
    [self.vertScrollView2 addSubview:sLabel31];
    
    y1 += 17;
    
    UILabel *sLabel4 = [ [UILabel alloc ] initWithFrame:CGRectMake(5, y1, 145, 20) ];
    sLabel4.textAlignment =  UITextAlignmentRight;
    sLabel4.backgroundColor = [UIColor clearColor];
    sLabel4.font = [UIFont fontWithName:@"Thonburi-Bold" size:14.0];
    sLabel4.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
    sLabel4.text = NSLocalizedString(@"PROTEINS", nil);//@"Белки";
    [self.vertScrollView2 addSubview:sLabel4];
    UILabel *sLabel41 = [ [UILabel alloc ] initWithFrame:CGRectMake(170, y1, 150, 20) ];
    sLabel41.textAlignment =  UITextAlignmentLeft;
    sLabel41.backgroundColor = [UIColor clearColor];
    sLabel41.font = [UIFont fontWithName:@"Thonburi-Bold" size:14.0];
    sLabel41.textColor = [UIColor colorWithRed:205/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
    sLabel41.text = it.proteins;
    [self.vertScrollView2 addSubview:sLabel41];
    
    y1 += 17;
    
    UILabel *sLabel5 = [ [UILabel alloc ] initWithFrame:CGRectMake(5, y1, 145, 20) ];
    sLabel5.textAlignment =  UITextAlignmentRight;
    sLabel5.backgroundColor = [UIColor clearColor];
    sLabel5.font = [UIFont fontWithName:@"Thonburi-Bold" size:14.0];
    sLabel5.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
    sLabel5.text = NSLocalizedString(@"FATS", nil);//@"Жиры";
    [self.vertScrollView2 addSubview:sLabel5];
    UILabel *sLabel51 = [ [UILabel alloc ] initWithFrame:CGRectMake(170, y1, 150, 20) ];
    sLabel51.textAlignment =  UITextAlignmentLeft;
    sLabel51.backgroundColor = [UIColor clearColor];
    sLabel51.font = [UIFont fontWithName:@"Thonburi-Bold" size:14.0];
    sLabel51.textColor = [UIColor colorWithRed:205/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
    sLabel51.text = it.fats;
    [self.vertScrollView2 addSubview:sLabel51];
    
    y1 += 17;
    
    UILabel *sLabel6 = [ [UILabel alloc ] initWithFrame:CGRectMake(5, y1, 145, 20) ];
    sLabel6.textAlignment =  UITextAlignmentRight;
    sLabel6.backgroundColor = [UIColor clearColor];
    sLabel6.font = [UIFont fontWithName:@"Thonburi-Bold" size:14.0];
    sLabel6.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
    sLabel6.text = NSLocalizedString(@"CARBOS", nil);//@"Углеводы";
    [self.vertScrollView2 addSubview:sLabel6];
    UILabel *sLabel61 = [ [UILabel alloc ] initWithFrame:CGRectMake(170, y1, 150, 20) ];
    sLabel61.textAlignment =  UITextAlignmentLeft;
    sLabel61.backgroundColor = [UIColor clearColor];
    sLabel61.font = [UIFont fontWithName:@"Thonburi-Bold" size:14.0];
    sLabel61.textColor = [UIColor colorWithRed:205/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
    sLabel61.text = it.carbos;
    [self.vertScrollView2 addSubview:sLabel61];
    
    y += 5;
    
    UIButton *fav = [UIButton buttonWithType:UIButtonTypeCustom];
    fav.frame = CGRectMake(285, y - 90, 23, 31);
    [fav setImage:[UIImage imageNamed:@"STAR_Icons.png"] forState:UIControlStateNormal];
    [fav addTarget:self action:@selector(buttonFav:) forControlEvents:UIControlEventTouchUpInside];
    [self.vertScrollView2 addSubview:fav];
    
    y1 = y + 5;
    
    UIImageView *imgView11 = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, 320, 6)];
    imgView11.image = [UIImage imageNamed:@"top_place.png"];
    [self.vertScrollView2 addSubview:imgView11];
    
    y += 6;
    
    int count = it.ingrids.count;
    for (int i = 0; i <  (count * 7 + 3) ; i++) {
        
        UIImageView *imgView22 = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, 320, 3)];
        imgView22.image = [UIImage imageNamed:@"center_place.png"];
        [self.vertScrollView2 addSubview:imgView22];
        
        y += 3;
        
    }
    
    UIImageView *imgView31 = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, 320, 7)];
    imgView31.image = [UIImage imageNamed:@"bottom_place.png"];
    [self.vertScrollView2 addSubview:imgView31];
    
    //    y += 140;
    
    UIButton *sps = [UIButton buttonWithType:UIButtonTypeCustom];
    sps.frame = CGRectMake(285, y1 + 20, 20, 25);
    [sps setImage:[UIImage imageNamed:@"Spisok_Icons.png"] forState:UIControlStateNormal];
    [sps addTarget:self action:@selector(buttonSps:) forControlEvents:UIControlEventTouchUpInside];
    [self.vertScrollView2 addSubview:sps];
    
    //    for (NSString* i in [it.ingrids allKeys]) {
    for (Ingridient* ing in it.ingrids) {
        
        MSLabel *sLabel6 = [ [MSLabel alloc ] initWithFrame:CGRectMake(10, y1, 140, 35) ];
        sLabel6.textAlignment =  UITextAlignmentRight;
        sLabel6.backgroundColor = [UIColor clearColor];
        sLabel6.font = [UIFont fontWithName:@"Thonburi-Bold" size:14.0];
        sLabel6.numberOfLines = 2;
        sLabel6.lineHeight = 10;
        sLabel6.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
        sLabel6.text = ing.name;
        [self.vertScrollView2 addSubview:sLabel6];
        UILabel *sLabel61 = [ [UILabel alloc ] initWithFrame:CGRectMake(170, y1, 150, 35) ];
        sLabel61.textAlignment =  UITextAlignmentLeft;
        sLabel61.backgroundColor = [UIColor clearColor];
        sLabel61.font = [UIFont fontWithName:@"Thonburi-Bold" size:14.0];
        sLabel61.textColor = [UIColor colorWithRed:205/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
        sLabel61.text = ing.text;//[it.ingrids objectForKey:i];
        [self.vertScrollView2 addSubview:sLabel61];
        
        y1 += 20;
    }
    
    self.vertScrollView2.contentSize = CGSizeMake(320, y);
    
//    [self createSteps];

}

- (void)createSteps {
    
    int y = 160;
    
//    [self.vertScrollView3 addSubview:imgView2];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, 320, 45)];
//    imgView.image = [UIImage imageNamed:@"place2_under_picture.png"];
    imgView.image = [UIImage imageNamed:@"back_for_button.png"];
    [self.vertScrollView3 addSubview:imgView];
    
    y += 32;
    
//    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
//    but.frame = CGRectMake(56, y - 24, 208, 29);
//    [but setImage:[UIImage imageNamed:@"button_position2.png"] forState:UIControlStateNormal];
//    [but addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [self.vertScrollView3 addSubview:but];
    
    UIImageView *imgBut = [[UIImageView alloc] initWithFrame:CGRectMake(160, y - 24, 104, 29)];
    imgBut.image = [UIImage imageNamed:@"button04.png"];
    [self.vertScrollView3 addSubview:imgBut];
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    but.frame = CGRectMake(56, y - 24, 104, 29);
    [but setImage:[UIImage imageNamed:@"button03.png"] forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:@"button01.png"] forState:UIControlStateHighlighted];
    [but addTarget:self action:@selector(buttonEvent2:) forControlEvents:UIControlEventTouchUpInside];
    [self.vertScrollView3 addSubview:but];
    
    y += 20;
    
    for (Step* st in it.steps) {
    
        UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(19, y, 282, 190)];
        imgView1.image = [UIImage imageNamed:@"bottom_pict_place1.png"];
        [self.vertScrollView3 addSubview:imgView1];

        UIImageView *imgV = [[UIImageView alloc] initWithFrame:CGRectMake(24, y + 5, 272, 180)];
        [self.vertScrollView3 addSubview:imgV];

        y += 190;
     
        UILabel *sLabel6 = [ [UILabel alloc ] initWithFrame:CGRectMake(24, y, 272, 50) ];
//        sLabel6.textAlignment =  UITextAlignmentRight;
        sLabel6.backgroundColor = [UIColor clearColor];
        sLabel6.font = [UIFont fontWithName:@"Thonburi-Bold" size:14.0];
        sLabel6.textColor = [UIColor colorWithRed:227/255.0 green:213/255.0 blue:192/255.0 alpha:1.0];
//        sLabel6.text = i;
        sLabel6.text = st.text;
        sLabel6.numberOfLines = 0;
        [sLabel6 sizeToFit];
        [self.vertScrollView3 addSubview:sLabel6];

        Transit* tr = [[Transit alloc] init];
        tr.view = imgV;
//        tr.url = [it.steps objectForKey:i];
        tr.url = st.path;

        tr.image = [[Common instance] getImage:tr.url];
        if(tr.image != nil) {
            
            NSLog(@"Step image found %@", tr.url);
            //        [self displayStepImage:tr];
            [tr.view setImage:tr.image];
            
//            return;
        }
        else {
        NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                            initWithTarget:self
                                            selector:@selector(loadStepImage:)
                                            object:tr];
        [queue addOperation:operation];
        }
//        UIImageView *imgView8 = [[UIImageView alloc] initWithFrame:CGRectMake(0, y, 21, 23)];
//        imgView8.image = [UIImage imageNamed:[NSString stringWithFormat:@"step_%d.png", k++]];
//        [self.vertScrollView3 addSubview:imgView8];

//        NSLog(@"sLabel6.frame.size.height = %f", sLabel6.frame.size.height);
        y += ((sLabel6.frame.size.height < 30)?30:sLabel6.frame.size.height);
    }

    self.vertScrollView3.contentSize = CGSizeMake(320, y);

}

- (void)loadImage {
    
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:it.ingrid_image]];
    UIImage* image = [[UIImage alloc] initWithData:imageData];
//    [self performSelectorOnMainThread:@selector(displayImage:) withObject:image waitUntilDone:NO];
    [self performSelectorInBackground:@selector(displayImage:) withObject:image];
}

- (void)displayImage:(UIImage *)image {
    
    [imgView2 setImage:image]; //UIImageView
//    [imgView2_1 setImage:image]; //UIImageView
}

- (void)loadImage1 {
    
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:it.image]];
    UIImage* image = [[UIImage alloc] initWithData:imageData];
//    [self performSelectorOnMainThread:@selector(displayImage1:) withObject:image waitUntilDone:NO];
    [self performSelectorInBackground:@selector(displayImage1:) withObject:image];
}

- (void)displayImage1:(UIImage *)image {
    
//    [imgView2 setImage:image]; //UIImageView
    [imgView2_1 setImage:image]; //UIImageView
}

- (void)loadStepImage:(Transit*) tr {
    
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:tr.url]];
    tr.image = [[UIImage alloc] initWithData:imageData];
//    [self performSelectorOnMainThread:@selector(displayStepImage:) withObject:tr waitUntilDone:NO];
    [self performSelectorInBackground:@selector(displayStepImage:) withObject:tr];

}

- (void)displayStepImage:(Transit*)tr {

    [tr.view setImage:tr.image];
    
//    NSString* n = [tr.url lastPathComponent];
    NSString* n1 = [tr.url stringByReplacingOccurrencesOfString:@":" withString:@"-"];//[tr.url lastPathComponent];
    NSString* n = [n1 stringByReplacingOccurrencesOfString:@"/" withString:@"-"];

    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* docpath = [sp objectAtIndex: 0];
    NSString* filePath = [docpath stringByAppendingPathComponent:n];
    NSData *imgData = UIImagePNGRepresentation(tr.image);
    [imgData writeToFile:filePath atomically:YES];
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)buttonSps:(id)sender {
    
//    NSLog(@"Spisok");
    
//    [[Common instance].spsingrids addEntriesFromDictionary:it.ingrids];
//    [[Common instance] saveSpisokIngrids];
    
    [[Common instance] addSpsRecipe:it];
    
    NSString* s = NSLocalizedString(@"SPSMESSAGE", nil);
    UIAlertView* dialog = [[UIAlertView alloc] init];
    [dialog setTitle:@""];
    [dialog setMessage:s];
    [dialog addButtonWithTitle:@"OK"];
    [dialog show];

}

- (void)buttonFav:(id)sender {

//    NSLog(@"addFav");
    
    [[Common instance] addFavRecipe:it];

    NSString* s = NSLocalizedString(@"FAVMESSAGE", nil);
    UIAlertView* dialog = [[UIAlertView alloc] init];
    [dialog setTitle:@""];
    [dialog setMessage:s];
    [dialog addButtonWithTitle:@"OK"];
    [dialog show];
    

}

- (void)buttonEvent1:(id)sender {

//    b = !b;

    [self createSteps];

    self.vertScrollView2.hidden = YES;
    
    self.vertScrollView3.hidden = NO;
}

- (void)buttonEvent2:(id)sender {
    
//    b = !b;
    
    
    self.vertScrollView2.hidden = NO;
    
    self.vertScrollView3.hidden = YES;
}

- (IBAction) exit {
    
    switch ([Common instance].prev_window) {
        case WT_NONE:
        case WT_MAIN:
        case WT_FAVOURITES:
        case WT_RECIPE:
        case WT_SPISOK:
        case WT_SEARCH:
        default: {
            ViewController *ivc = [Common instance].mainController;
            [ivc dismissModalViewControllerAnimated:YES];
            break;
        }
//        case WT_SEARCH:
//            [self dismissModalViewControllerAnimated:YES];
//            break;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSLog(@"shouldAutorotate called");

    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

- (void)awakeFromNib
{
    isShowingLandscapeView = NO;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)orientationChanged:(NSNotification *)notification
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (UIDeviceOrientationIsLandscape(deviceOrientation) &&
        !isShowingLandscapeView)
    {
        [self performSegueWithIdentifier:@"DisplayHorizontalView" sender:self];
        isShowingLandscapeView = YES;
    }
    else if (UIDeviceOrientationIsPortrait(deviceOrientation) &&
             isShowingLandscapeView)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
        isShowingLandscapeView = NO;
    }
}

@end
