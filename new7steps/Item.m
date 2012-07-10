//
//  Item.m
//  iMenu
//
//  Created by вадим on 2/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Item.h"


@implementation Item

@synthesize name;
@synthesize image;
@synthesize category;

- (void) dealloc {
	
 	self.name = nil;
 	self.image = nil;
	
//	[super dealloc];
}

@end
