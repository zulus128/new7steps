//
//  XMLParser.m
//  XMLpars
//
//  Created by вадим on 2/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Common.h"
#import "XMLParser.h"
#import "Item.h"

@implementation XMLParser

@synthesize item;

- (XMLParser *) initXMLParser: (int) type {
	
	self = [super init];
    
    itype = type;
    
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict {
	
  //  NSLog(@"Start Element");
   
//    if(itype == TYPE_BANNERS)
//        return;
    
	if([elementName isEqualToString:RECIPE_TAG]) {

		self.item = [[Item alloc] init];
        
        NSLog(@"Item alloc type = %i", itype);
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	
	if(!currentElementValue)
		currentElementValue = [[NSMutableString alloc] initWithString:string];
	else
		[currentElementValue appendString:string];
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
		
	NSString* trimedStr;
	if(currentElementValue)
		trimedStr = [currentElementValue stringByTrimmingCharactersInSet:
						   [NSCharacterSet whitespaceAndNewlineCharacterSet]];


    if([elementName isEqualToString:RECIPE_TAG]) {
			
        [[Common instance] addRecipe:item];                
        
        self.item = nil;
    }
    else
        if([elementName isEqualToString:NAME_TAG])
            item.name = trimedStr;

//	[currentElementValue release];
	currentElementValue = nil;

}

//- (void) dealloc {
//
////	[item release];
//	
////	[currentElementValue release];
////	[super dealloc];
//}

@end
