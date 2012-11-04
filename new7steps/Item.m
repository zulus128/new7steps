//
//  Item.m
//  iMenu
//
//  Created by вадим on 2/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Item.h"


@implementation Item

- (id) init {
	
	self = [super init];
    
    if( self != nil ) {
    
//        self.ingrids = [NSMutableDictionary dictionary];
        self.ingrids = [NSMutableArray array];
//        self.steps = [NSMutableDictionary dictionary];
        self.steps = [NSMutableArray array];
        self.ingrids_checked = [NSMutableDictionary dictionary];

    }
    
    return self;
}

- (void) dealloc {
	
 	self.name = nil;
 	self.image = nil;
    self.ingrid_image = nil;
	
//	[super dealloc];
}

@end
