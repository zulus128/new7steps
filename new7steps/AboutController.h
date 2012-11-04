//
//  AboutController.h
//  new7steps
//
//  Created by Zul on 9/25/12.
//
//

#import <UIKit/UIKit.h>

@interface AboutController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel* xmlver;
@property (nonatomic, retain) IBOutlet UILabel* sleepLab;
@property (nonatomic, retain) IBOutlet UISwitch* sleepSw;

- (IBAction) swich;

- (IBAction) back;


@end
