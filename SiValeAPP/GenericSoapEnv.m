//
//  GenericSoapEnv.m
//  
//
//  Created by Luis Ordaz on 11/19/15.
//
//

#import "GenericSoapEnv.h"

@implementation GenericSoapEnv

-(id)init {
    return [self initWithData: nil nameSpaces:nil attrs: nil vals: nil actionName: nil];
}

-(id) initWithData: (NSMutableArray *) tags nameSpaces: (NSMutableDictionary *) ns attrs: (NSMutableDictionary *) att vals: (NSMutableArray *) val actionName: (NSString *) name{
    self = [super init];
    if (self) {
        self.requiredTags = [[NSMutableArray alloc] initWithArray: tags];
        self.nameSpacesForTags = [[NSMutableDictionary alloc] initWithDictionary: ns];
        self.attrsForTags = [[NSMutableDictionary alloc] initWithDictionary: att];
        self.valueForTags = [[NSMutableArray alloc] initWithArray:val];
        self.rootElement = [GDataXMLNode elementWithName: @"soapenv:Envelope"];
        self.headerElement = [GDataXMLNode elementWithName: @"soapenv:Header"];
        self.bodyElement = [GDataXMLNode elementWithName: @"soapenv:Body"];
        self.actionElement = [GDataXMLNode elementWithName: name];
        [self.rootElement setNamespaces:[NSArray arrayWithObjects:[GDataXMLNode namespaceWithName:@"xsi" stringValue:@"http://www.w3.org/2001/XMLSchema-instance"], [GDataXMLNode namespaceWithName:@"xsd" stringValue:@"http://www.w3.org/2001/XMLSchema"], [GDataXMLNode namespaceWithName:@"web" stringValue:@"WebMethods"], [GDataXMLNode namespaceWithName:@"soapenv" stringValue:@"http://schemas.xmlsoap.org/soap/envelope/"],nil]];
        [self.actionElement addAttribute:[GDataXMLNode attributeWithName:@"n1:encodingStyle" stringValue:@"http://schemas.xmlsoap.org/soap/encoding/"]];
        [self.actionElement setNamespaces:[NSArray arrayWithObjects:[GDataXMLNode namespaceWithName:@"n0" stringValue:@"xsi"], [GDataXMLNode namespaceWithName:@"n1" stringValue:@"soapenv"],nil]];
        [self constructActionElement];
        [self nestElements];
        [self closeEnvelope];
    }
    return self;
}

-(void)constructActionElement{
    for(int i = 0; i < [self.requiredTags count]; i++){
        GDataXMLElement * nestedElement = [GDataXMLNode elementWithName:[self.requiredTags objectAtIndex:i]];
        [nestedElement addAttribute: [self.attrsForTags objectForKey:[self.requiredTags objectAtIndex:i]]];
        nestedElement.stringValue = [self.valueForTags objectAtIndex:i];
        [self.actionElement addChild: nestedElement];
    }
}

-(void)nestElements{
    [self.bodyElement addChild: self.actionElement];
    [self.rootElement addChild: self.headerElement];
    [self.rootElement addChild: self.bodyElement];
}

-(void)closeEnvelope{
    self.completeEnvelope = [[GDataXMLDocument alloc] initWithRootElement: self.rootElement];
    [self.completeEnvelope setCharacterEncoding: @"UTF-8"];
    [self.completeEnvelope setStandAlone: 1];
}

@end
