//
//  XMLParser.h
//  XMLpars
//
//  Created by вадим on 2/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "Item.h"
@class Item;

@interface XMLParser : NSObject <NSXMLParserDelegate> {

	NSMutableString* currentElementValue;
    int itype;
    int categ;
    BOOL ingrid;
    BOOL steps;
    NSString* name;
}

- (XMLParser *) initXMLParser: (int) type;

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
	attributes:(NSDictionary *)attributeDict;
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;

@property (nonatomic, retain) Item* item;

@end
