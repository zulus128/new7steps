//
//  HorizontalController.m
//  new7steps
//
//  Created by Zul on 10/19/12.
//
//

#import "HorizontalController.h"
#import "Common.h"
#import "Step.h"

@interface HorizontalController ()

@end

@implementation HorizontalController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl
        navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.delegate = self;
    self.pageViewController.dataSource = self;
    
    screenBounds = [[UIScreen mainScreen] bounds];
    
    int i = [Common instance].itemtag / CAT_MULT;
    int j = [Common instance].itemtag - i * CAT_MULT;

    it = [[Common instance] getRecipe:j forCategory:i];
    index = 1;
//    NSMutableArray *viewControllers = [NSMutableArray array];
//    int k = 1;
//    for (Step* st in it.steps) {
//        
//        UIImageView *imgView8 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
//        imgView8.image = [UIImage imageNamed:[NSString stringWithFormat:@"step_%d.png", k++]];
//        UIViewController *controller = [[UIViewController alloc] init];
//        controller.view = imgView8;
//        [viewControllers addObject:controller];
//    }
    NSMutableArray *viewControllers = [NSMutableArray array];
//        UIImageView *imgView8 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
//        imgView8.image = [UIImage imageNamed:[NSString stringWithFormat:@"step_%d.png", 1]];
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:it.image]];
//    UIImage* image = [[UIImage alloc] initWithData:imageData];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:screenBounds];
    imgV.image = [[UIImage alloc] initWithData:imageData];
    
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view = imgV;
        [viewControllers addObject:controller];

    [self.pageViewController setViewControllers:viewControllers
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO
                                     completion:nil];
    [self.view addSubview:self.pageViewController.view];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger currentIndex = [currentVC index];
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:it.image]];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:screenBounds];
    imgV.image = [[UIImage alloc] initWithData:imageData];
    
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view = imgV;
    return controller;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {

    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:it.image]];
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:screenBounds];
    imgV.image = [[UIImage alloc] initWithData:imageData];
    
    UIViewController *controller = [[UIViewController alloc] init];
    controller.view = imgV;
    return controller;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
