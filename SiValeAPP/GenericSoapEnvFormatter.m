//
//  GenericSoapEnvFormatter.m
//  
//
//  Created by Luis Ordaz on 11/19/15.
//
//

#import "GenericSoapEnvFormatter.h"


@implementation GenericSoapEnvFormatter

+(NSData *) genericSoapRequest: (NSString *)action parameters:(NSArray *) parameters{
    
    if([action isEqualToString:@"login"]){
        return [self login: parameters];
    }
    else
        if ([action isEqualToString:@"getBalances"]){
           return [self getBalances: parameters];
        }
        else
            if ([action isEqualToString:@"getTransactions"]){
             return [self getTransactions: parameters];
            }
            else{
                NSLog(@"Unrecognized operation.");
                return nil;
            }
    return nil;
}

+(NSData *)login: (NSArray *) parameters{
    GenericSoapEnv *envelope = [[GenericSoapEnv alloc] initWithData:[NSMutableArray arrayWithObjects:@"huella_aleatoria", @"num_tarjeta",@"passwd",@"securityLevel", nil] nameSpaces:nil attrs:[NSMutableDictionary dictionaryWithDictionary: @{@"huella_aleatoria":[GDataXMLNode attributeWithName:@"xsi:type" stringValue:@"xsd:string"],@"num_tarjeta":[GDataXMLNode attributeWithName:@"xsi:type" stringValue:@"xsd:string"],@"passwd":[GDataXMLNode attributeWithName:@"xsi:type" stringValue:@"xsd:string"],@"securityLevel":[GDataXMLNode attributeWithName:@"xsi:type" stringValue:@"xsd:string"]}] vals:[NSMutableArray arrayWithArray:parameters] actionName: @"web:login"];
    return envelope.completeEnvelope.XMLData;
}

+(NSData *)getBalances: (NSArray *) parameters{
    GenericSoapEnv *envelope = [[GenericSoapEnv alloc] initWithData:[NSMutableArray arrayWithObjects:@"web:P_ID_SESION", nil] nameSpaces:nil attrs:[NSMutableDictionary dictionaryWithDictionary: @{@"web:P_ID_SESION":[GDataXMLNode attributeWithName:@"xsi:type" stringValue:@"xsd:decimal"]}] vals:[NSMutableArray arrayWithArray:parameters] actionName:@"n0:getSaldo"];
    return envelope.completeEnvelope.XMLData;
}

+(NSData *)getTransactions: (NSArray *) parameters{
    GenericSoapEnv *envelope = [[GenericSoapEnv alloc] initWithData:[NSMutableArray arrayWithObjects:@"web:P_ID_SESION", nil] nameSpaces:nil attrs:[NSMutableDictionary dictionaryWithDictionary: @{@"web:P_ID_SESION":[GDataXMLNode attributeWithName:@"xsi:type" stringValue:@"xsd:decimal"]}] vals:[NSMutableArray arrayWithArray:parameters] actionName:@"n0:getMovimientos"];
    return envelope.completeEnvelope.XMLData;
}

@end
