//
//  SearchViewController.h
//  new7steps
//
//  Created by вадим on 11/11/12.
//
//

#import <UIKit/UIKit.h>

@interface SearchViewController : UIViewController <UISearchBarDelegate> {
    
    NSMutableArray *filtered;
    NSOperationQueue *queue;

}

@property (nonatomic, retain) IBOutlet UILabel* titleLabel;
@property (nonatomic, retain) IBOutlet UIButton* goRecipes;
@property (nonatomic, retain) IBOutlet UIScrollView* vertScrollView;
@property (nonatomic, retain) IBOutlet UISearchBar* sbar;
@property (nonatomic, retain) NSString* text;
- (IBAction) exit;

@end
