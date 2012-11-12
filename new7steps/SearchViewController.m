//
//  SearchViewController.m
//  new7steps
//
//  Created by вадим on 11/11/12.
//
//

#import "SearchViewController.h"
#import "Common.h"
#import "MSLabel.h"
#import "Transit.h"

#define TAG 42

@interface SearchViewController ()

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) viewDidAppear:(BOOL)animated {
    
    [Common instance].prev_window = WT_SEARCH;

}

- (void) viewWillAppear:(BOOL)animated {

    self.text = @"";
    [self setup];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    filtered = [NSMutableArray array];

    self.titleLabel.text = NSLocalizedString(@"TITLE", nil);
    self.titleLabel.font = [UIFont fontWithName:@"Good-Black" size:22.0];
    
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
        case WT_SPISOK:
            s = NSLocalizedString(@"MAINBUTTONSPS", nil);
            break;
        case WT_SEARCH:
            s = NSLocalizedString(@"SEARCHBUTTON", nil);
            break;
    }
    [self.goRecipes setTitle:s forState:UIControlStateNormal];
    self.goRecipes.titleLabel.font = [UIFont fontWithName:@"Good-Book" size:20.0];
    
    queue = [NSOperationQueue new];

//    for(int c = 20000; c < 20100; c++) {
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(-500, -500, 81, 55)];
//    imgView.tag = c;
//    [self.vertScrollView addSubview:imgView];
//    }

    self.text = @"s";
    [self setup];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    NSLog(@"Text for search: %@", searchText);
    self.text = searchText;

    [self setup];
    
    NSLog(@"Search end");

}

//- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//
//    NSLog(@"Text end editing");
//
//}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.sbar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {

    [self.sbar resignFirstResponder];
}

- (void) setup {
    
    if(self.text == nil)
        return;
//    if([self.text isEqualToString:@""])
//        return;
    
    [filtered removeAllObjects];
    NSArray *data = [[Common instance] getRecipes];
    for(Item* it in data) {
        NSRange rangeValue = [it.name rangeOfString:self.text options:NSCaseInsensitiveSearch];
        if (rangeValue.location != NSNotFound) {
            
            [filtered addObject:it];
        }
    }

    for(UIView *v in self.vertScrollView.subviews){
        
//        if(v.tag >= 20000) {
//        
//            v.center = CGPointMake(-500, -500);
//            continue;
//        }
        
        if(v.tag > 0) {
            
            [v removeFromSuperview];
        }
    }
    
    int y = 40;
    int t = 20000;
    int i = 0;
    for(Item* it in filtered) {
//    for (int i = 0; i < [[Common instance] getFavRecipeCnt]; i++) {
//        
//        Item* it = [[Common instance] getFavRecipe:i];
        
        //        NSLog(@"Fav Item #%d", i);
        
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.frame = CGRectMake(0, y, 320, 72);
        [but setImage:[UIImage imageNamed:@"back_place_izbrannoe.png"] forState:UIControlStateNormal];
        but.tag = ++i;
        [but addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        //        but.tag = TAG;
        [self.vertScrollView addSubview:but];
        

        [it createImageView];

        [self.vertScrollView addSubview:it.imgView];
        it.imgView.center = CGPointMake(10 + 40.5f, y + 8 + 27.5f);
        
//        UIImageView* imgView = (UIImageView*) [self.vertScrollView viewWithTag:t++];
//        if(imgView == nil) {
//        
//            NSLog(@"imgView nil");
//            imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, y + 8, 81, 55)];
//            imgView.tag = TAG;
//        }
//        else
//            imgView.center = CGPointMake(10 + 40.5f, y + 8 + 27.5f);
//
////        [self.vertScrollView addSubview:imgView];
//
//        Transit* tr = [[Transit alloc] init];
//        tr.view = imgView;
//        tr.url = it.image;
//        
//        tr.image = [[Common instance] getImage:tr.url];
//        if(tr.image != nil) {
//            
////            NSLog(@"Search image found %@", tr.url);
//            [tr.view setImage:tr.image];
//        }
//        else {
//            NSInvocationOperation *operation = [[NSInvocationOperation alloc]
//                                                initWithTarget:self
//                                                selector:@selector(loadSearchImage:)
//                                                object:tr];
//            [queue addOperation:operation];
//        }
        
        
//        UIImage* img = [[Common instance] getImage:it.image];
//        if(img == nil) {
//            
//            NSLog(@"Search image is nil");
//            NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:it.image]];
//            img = [[UIImage alloc] initWithData:imageData];
//        }
        
//        imgView.image = img;
        
        
        UILabel *sLabel = [ [UILabel alloc ] initWithFrame:CGRectMake(100, y + 5, 150, 24) ];
        sLabel.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
        sLabel.backgroundColor = [UIColor clearColor];
        sLabel.font = [UIFont fontWithName:@"Good-Black" size:(12.0)];
        sLabel.tag = TAG;
        [self.vertScrollView addSubview:sLabel];
        sLabel.text = [[Common instance].cats objectForKey:[NSNumber numberWithInt:it.category]];
        
        MSLabel *sLabel1 = [ [MSLabel alloc ] initWithFrame:CGRectMake(100, y + 20, 150, 50) ];
        sLabel1.textColor = [UIColor colorWithRed:105/255.0 green:76/255.0 blue:56/255.0 alpha:1.0];
        sLabel1.backgroundColor = [UIColor clearColor];
        sLabel1.lineHeight = 13;
        sLabel1.font = [UIFont fontWithName:@"Good-Light" size:(12.0)];
        sLabel1.tag = TAG;
        [self.vertScrollView addSubview:sLabel1];
        sLabel1.numberOfLines = 3;
        sLabel1.text = it.name;
        
        y += 75;
    }
    
    self.vertScrollView.contentSize = CGSizeMake(320, y);
    
}
- (void)loadSeachImage:(Transit*) tr {
    
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:tr.url]];
    tr.image = [[UIImage alloc] initWithData:imageData];
    [self performSelectorInBackground:@selector(displaySearchImage:) withObject:tr];
    
}

- (void)displaySearchImage:(Transit*)tr {
    
    [tr.view setImage:tr.image];
    
    //    NSString* n1 = [tr.url stringByReplacingOccurrencesOfString:@":" withString:@"-"];//[tr.url lastPathComponent];
    //    NSString* n = [n1 stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    //
    //    NSArray* sp = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    NSString* docpath = [sp objectAtIndex: 0];
    //    NSString* filePath = [docpath stringByAppendingPathComponent:n];
    //    NSData *imgData = UIImagePNGRepresentation(tr.image);
    //    [imgData writeToFile:filePath atomically:YES];
}

- (void)buttonEvent:(id)sender {
    
    [self.sbar resignFirstResponder];

    int buttag = ((UIButton*)sender).tag - 1;
    NSLog(@"Search recipe %d clicked!!!", buttag);
    
    [Common instance].curitem = [filtered objectAtIndex:buttag];
    [self performSegueWithIdentifier: @"2ndSegue" sender: self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return NO;
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

- (IBAction) exit {
    
    [self dismissModalViewControllerAnimated:YES];
}

@end
