//
//  Item.m
//  iMenu
//
//  Created by вадим on 2/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Item.h"
#import "Transit.h"
#import "Common.h"

#define TAG 43

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

- (void)createImageView {
   
    if(self.imgView != nil)
        return;
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 81, 55)];
    self.imgView.tag = TAG;
    
    Transit* tr = [[Transit alloc] init];
    tr.view = self.imgView;
    tr.url = self.image;
    
    tr.image = [[Common instance] getImage:tr.url];
    if(tr.image != nil) {
        
        //            NSLog(@"Search image found %@", tr.url);
        [tr.view setImage:tr.image];
    }
    else {
        NSInvocationOperation *operation = [[NSInvocationOperation alloc]
                                            initWithTarget:self
                                            selector:@selector(loadSearchImage:)
                                            object:tr];
        [queue addOperation:operation];
    }
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

- (void) dealloc {
	
 	self.name = nil;
 	self.image = nil;
    self.ingrid_image = nil;
	
//	[super dealloc];
}

@end
