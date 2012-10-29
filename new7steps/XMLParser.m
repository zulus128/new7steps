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
#import "Step.h"

@implementation XMLParser

@synthesize item;

- (XMLParser *) initXMLParser: (int) type {
	
	self = [super init];
    
    itype = type;
    categ = 0;
    ingrid = NO;
    steps = NO;
    recipe = NO;
    
	return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict {
	
    
//    NSLog(@"+++ begin: %@ %d", elementName, ingrid);

    if([elementName isEqualToString:RECIPES_TAG]) {

        NSString* n = [attributeDict objectForKey:@"version"];
        NSLog(@"XML version = %@", n);
        [Common instance].versionXML = n.doubleValue;
    }
    
	if([elementName isEqualToString:RECIPE_TAG]) {

		self.item = [[Item alloc] init];
        self.item.category = categ;
        recipe = YES;
        
//        NSLog(@"Item alloc type = %i", itype);
	}
    else
        if([elementName isEqualToString:CATEGORY_TAG]) {
            categ++;
            NSLog(@"Category %d", categ);
        }
        else
            if([elementName isEqualToString:INGRIDS_TAG]) {
                ingrid = YES;
//                NSLog(@"--- ingrid begin");
            }
            else
                if([elementName isEqualToString:STEPS_TAG]) {
                    steps = YES;
                    //                NSLog(@"--- steps begin");
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


//    NSLog(@"+++ end: %@ %d", elementName, ingrid);
    
    if(ingrid) {

        if([elementName isEqualToString:NAME_TAG]) {

            name = trimedStr;
//            NSLog(@"ingridient name : %@", name);

        }
            else
                if([elementName isEqualToString:QUANTITY_TAG]) {
                    [item.ingrids setObject:trimedStr forKey:name];
//                    NSLog(@"ingridient %@ : %@", name, trimedStr);
                }
                else
                    if([elementName isEqualToString:INGRIDS_TAG]) {
                        ingrid = NO;
//                                                NSLog(@"--- ingrid end");
                    }

        
    }
    else
        if(steps) {
            
            if([elementName isEqualToString:IMAGE_TAG]) {
                
                name = trimedStr;
//                            NSLog(@"step image : %@", name);
                
            }
            else
                if([elementName isEqualToString:DESCRIPTION_TAG]) {
//                    [item.steps setObject:name forKey:trimedStr];
                    Step* step = [[Step alloc] init];
                    step.path = name;
                    step.text = trimedStr;
                    [item.steps addObject:step];
//                                        NSLog(@"ingridient %@ : %@", name, trimedStr);
                }
                else
                    if([elementName isEqualToString:STEPS_TAG]) {
                        steps = NO;
                        //                                                NSLog(@"--- steps end");
                    }
            
            
        }
    else
        if(recipe) {
            
            if([elementName isEqualToString:NAME_TAG])
                item.name = trimedStr;
            else
                if([elementName isEqualToString:IMAGE_TAG]) {
                    item.image = trimedStr;
//                    NSLog(@"image : %@", trimedStr);
                }
                else
                    if([elementName isEqualToString:INGRID_IMAGE_TAG]) {

                        item.ingrid_image = trimedStr;
    //                    NSLog(@"image1 = %@", item.ingrid_image);

                    }
                    else
                        if([elementName isEqualToString:TYPE_TAG])
                            item.type = trimedStr;
                        else
                            if([elementName isEqualToString:TIME_TAG])
                                item.time = trimedStr;
                            else
                                if([elementName isEqualToString:CALORIES_TAG])
                                    item.calories = trimedStr;
                                else
                                    if([elementName isEqualToString:PROTEINS_TAG])
                                        item.proteins = trimedStr;
                                    else
                                        if([elementName isEqualToString:FATS_TAG])
                                            item.fats = trimedStr;
                                        else
                                            if([elementName isEqualToString:CARBO_TAG])
                                                item.carbos = trimedStr;
                                            else
                                                if([elementName isEqualToString:RECIPE_TAG]) {
                                                    
                                                    [[Common instance] addRecipe:item];
                                                    self.item = nil;
                                                    recipe = NO;
                                                }

        }
    else
        if([elementName isEqualToString:NAME_TAG])
            [[Common instance].cats setObject:trimedStr forKey:[NSNumber numberWithInt:categ]];

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
