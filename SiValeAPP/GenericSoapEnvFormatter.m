//
//  GenericSoapEnvFormatter.m
//  
//
//  Created by Luis Ordaz on 11/19/15.
//
//

#import "GenericSoapEnvFormatter.h"


@implementation GenericSoapEnvFormatter
/*
-(id)init{
    self = [super init];
    return self;
}
*/
+(NSData *) genericSoapRequest: (NSString *)action parameters:(NSArray *) parameters{
    
    if([action isEqualToString:@"login"]){
        return [[self class] login: parameters];
    }
    else
        if ([action isEqualToString:@"getBalances"]){
           return [[self class] getBalances: parameters];
        }
        else
            if ([action isEqualToString:@"getTransactions"]){
             return [[self class] getTransactions: parameters];
            }
            else{
                NSLog(@"Unrecognized operation.");
                return nil;
            }
    return nil;
}

+(void) constructActionElement: (GDataXMLElement **) actionElement withEnvelope: (GenericSoapEnv *) envelope{
    for(int i = 0; i < [envelope.requiredTags count]; i++){
        GDataXMLElement * nestedElement = [GDataXMLNode elementWithName:[envelope.requiredTags objectAtIndex:i]];
        [nestedElement addAttribute: [envelope.attrsForTags objectForKey:[envelope.requiredTags objectAtIndex:i]]];
        nestedElement.stringValue = [envelope.valueForTags objectAtIndex:i];
        [*actionElement addChild: nestedElement];
    }
}

+(NSData *)login: (NSArray *) parameters{
    GenericSoapEnv *envelope = [[GenericSoapEnv alloc] initWithData:[NSMutableArray arrayWithObjects:@"huella_aleatoria", @"num_tarjeta",@"passwd",@"securityLevel", nil] nameSpaces:nil attrs:[NSMutableDictionary dictionaryWithDictionary: @{@"huella_aleatoria":[GDataXMLNode attributeWithName:@"xsi:type" stringValue:@"xsd:string"],@"num_tarjeta":[GDataXMLNode attributeWithName:@"xsi:type" stringValue:@"xsd:string"],@"passwd":[GDataXMLNode attributeWithName:@"xsi:type" stringValue:@"xsd:string"],@"securityLevel":[GDataXMLNode attributeWithName:@"xsi:type" stringValue:@"xsd:string"]}] vals:[NSMutableArray arrayWithArray:parameters]];
    GDataXMLElement * rootElement = [GDataXMLNode elementWithName: @"soapenv:Envelope"];
    GDataXMLElement * headerElement = [GDataXMLNode elementWithName: @"soapenv:Header"];
    GDataXMLElement * bodyElement = [GDataXMLNode elementWithName: @"soapenv:Body"];
    GDataXMLElement * actionElement = [GDataXMLNode elementWithName: @"web:login"];
    [rootElement setNamespaces:[NSArray arrayWithObjects:[GDataXMLNode namespaceWithName:@"xsi" stringValue:@"http://www.w3.org/2001/XMLSchema-instance"], [GDataXMLNode namespaceWithName:@"xsd" stringValue:@"http://www.w3.org/2001/XMLSchema"], [GDataXMLNode namespaceWithName:@"web" stringValue:@"WebMethods"], [GDataXMLNode namespaceWithName:@"soapenv" stringValue:@"http://schemas.xmlsoap.org/soap/envelope/"],nil]];
    [actionElement addAttribute:[GDataXMLNode attributeWithName:@"soapenv:encodingStyle" stringValue:@"http://schemas.xmlsoap.org/soap/encoding/"]];
    [self constructActionElement:&actionElement withEnvelope:envelope];
    [bodyElement addChild: actionElement];
    [rootElement addChild: headerElement];
    [rootElement addChild: bodyElement];
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement: rootElement];
    [document setCharacterEncoding: @"UTF-8"];
    [document setStandAlone: 1];
    return document.XMLData;
}
+(NSData *)getBalances: (NSArray *) parameters{
    GenericSoapEnv *envelope = [[GenericSoapEnv alloc] initWithData:[NSMutableArray arrayWithObjects:@"web:P_ID_SESION", nil] nameSpaces:nil attrs:[NSMutableDictionary dictionaryWithDictionary: @{@"web:P_ID_SESION":[GDataXMLNode attributeWithName:@"xsi:type" stringValue:@"xsd:decimal"]}] vals:[NSMutableArray arrayWithArray:parameters]];
    GDataXMLElement * rootElement = [GDataXMLNode elementWithName: @"soapenv:Envelope"];
    GDataXMLElement * headerElement = [GDataXMLNode elementWithName: @"soapenv:Header"];
    GDataXMLElement * bodyElement = [GDataXMLNode elementWithName: @"soapenv:Body"];
    GDataXMLElement * actionElement = [GDataXMLNode elementWithName: @"n0:getSaldo"];
    [rootElement setNamespaces:[NSArray arrayWithObjects:[GDataXMLNode namespaceWithName:@"xsi" stringValue:@"http://www.w3.org/2001/XMLSchema-instance"], [GDataXMLNode namespaceWithName:@"xsd" stringValue:@"http://www.w3.org/2001/XMLSchema"], [GDataXMLNode namespaceWithName:@"web" stringValue:@"WebMethods"], [GDataXMLNode namespaceWithName:@"soapenv" stringValue:@"http://schemas.xmlsoap.org/soap/envelope/"],nil]];
    [actionElement addAttribute:[GDataXMLNode attributeWithName:@"n1:encodingStyle" stringValue:@"http://schemas.xmlsoap.org/soap/encoding/"]];
    [actionElement setNamespaces:[NSArray arrayWithObjects:[GDataXMLNode namespaceWithName:@"n0" stringValue:@"xsi"], [GDataXMLNode namespaceWithName:@"n1" stringValue:@"soapenv"],nil]];
    [self constructActionElement:&actionElement withEnvelope:envelope];
    [bodyElement addChild: actionElement];
    [rootElement addChild: headerElement];
    [rootElement addChild: bodyElement];
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement: rootElement];
    [document setCharacterEncoding: @"UTF-8"];
    [document setStandAlone: 1];
    return document.XMLData;
}
+(NSData *)getTransactions: (NSArray *) parameters{
    
    GenericSoapEnv *envelope = [[GenericSoapEnv alloc] initWithData:[NSMutableArray arrayWithObjects:@"web:P_ID_SESION", nil] nameSpaces:nil attrs:[NSMutableDictionary dictionaryWithDictionary: @{@"web:P_ID_SESION":[GDataXMLNode attributeWithName:@"xsi:type" stringValue:@"xsd:decimal"]}] vals:[NSMutableArray arrayWithArray:parameters]];
    GDataXMLElement * rootElement = [GDataXMLNode elementWithName: @"soapenv:Envelope"];
    GDataXMLElement * headerElement = [GDataXMLNode elementWithName: @"soapenv:Header"];
    GDataXMLElement * bodyElement = [GDataXMLNode elementWithName: @"soapenv:Body"];
    GDataXMLElement * actionElement = [GDataXMLNode elementWithName: @"n0:getMovimientos"];
    [rootElement setNamespaces:[NSArray arrayWithObjects:[GDataXMLNode namespaceWithName:@"xsi" stringValue:@"http://www.w3.org/2001/XMLSchema-instance"], [GDataXMLNode namespaceWithName:@"xsd" stringValue:@"http://www.w3.org/2001/XMLSchema"], [GDataXMLNode namespaceWithName:@"web" stringValue:@"WebMethods"], [GDataXMLNode namespaceWithName:@"soapenv" stringValue:@"http://schemas.xmlsoap.org/soap/envelope/"],nil]];
    [actionElement addAttribute:[GDataXMLNode attributeWithName:@"n1:encodingStyle" stringValue:@"http://schemas.xmlsoap.org/soap/encoding/"]];
    [actionElement setNamespaces:[NSArray arrayWithObjects:[GDataXMLNode namespaceWithName:@"n0" stringValue:@"xsi"], [GDataXMLNode namespaceWithName:@"n1" stringValue:@"soapenv"],nil]];
    [self constructActionElement:&actionElement withEnvelope:envelope];
    [bodyElement addChild: actionElement];
    [rootElement addChild: headerElement];
    [rootElement addChild: bodyElement];
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement: rootElement];
    [document setCharacterEncoding: @"UTF-8"];
    [document setStandAlone: 1];
    return document.XMLData;
}

@end
