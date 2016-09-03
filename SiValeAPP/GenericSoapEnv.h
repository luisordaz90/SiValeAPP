//
//  GenericSoapEnv.h
//  
//
//  Created by Luis Ordaz on 11/19/15.
//
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface GenericSoapEnv : NSObject
@property (strong, nonatomic) NSMutableArray *requiredTags; //XMLNodes
@property (strong, nonatomic) NSMutableDictionary *nameSpacesForTags; //xmlns for tags
@property (strong, nonatomic) NSMutableDictionary *attrsForTags; //xmlns for tags
@property (strong, nonatomic) NSMutableArray *valueForTags; //xmlns for tags
@property (strong, nonatomic) GDataXMLElement * rootElement;
@property (strong, nonatomic) GDataXMLElement * headerElement;
@property (strong, nonatomic) GDataXMLElement * bodyElement;
@property (strong, nonatomic) GDataXMLElement * actionElement;
@property (strong, nonatomic) GDataXMLDocument *completeEnvelope;
-(id) initWithData: (NSMutableArray *) tags nameSpaces: (NSMutableDictionary *) ns attrs: (NSMutableDictionary *) att vals: (NSMutableArray *) val actionName: (NSString *) name;
-(void)constructActionElement;
-(void)nestElements;
-(void)closeEnvelope;
@end
