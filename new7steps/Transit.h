//
//  Transit.h
//  new7steps
//
//  Created by вадим on 8/17/12.
//
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface Transit : NSObject

@property (nonatomic, retain) UIImageView* view;
@property (nonatomic, retain) NSString* url;
@property (nonatomic, retain) UIImage* image;
@property (nonatomic, retain) Item* item;
@property (nonatomic, retain) UIActivityIndicatorView* activInd;
@property (nonatomic, retain) UIView* scroll;
@end
