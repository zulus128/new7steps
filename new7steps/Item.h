//
//  Item.h
//  iMenu
//
//  Created by вадим on 2/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject {

}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* image;
@property (assign, readwrite) int category;

@end
