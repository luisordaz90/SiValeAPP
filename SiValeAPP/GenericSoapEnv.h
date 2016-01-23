//
//  GenericSoapEnv.h
//  
//
//  Created by Luis Ordaz on 11/19/15.
//
//

#import <Foundation/Foundation.h>

@interface GenericSoapEnv : NSObject
@property (strong, nonatomic) NSMutableArray *requiredTags; //XMLNodes
@property (strong, nonatomic) NSMutableDictionary *nameSpacesForTags; //xmlns for tags
@property (strong, nonatomic) NSMutableDictionary *attrsForTags; //xmlns for tags
@property (strong, nonatomic) NSMutableArray *valueForTags; //xmlns for tags
-(id) initWithData: (NSMutableArray *) tags nameSpaces: (NSMutableDictionary *) ns attrs: (NSMutableDictionary *) att vals: (NSMutableArray *) val;
@end
