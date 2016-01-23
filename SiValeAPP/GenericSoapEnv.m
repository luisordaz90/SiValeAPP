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
    return [self initWithData: nil nameSpaces:nil attrs: nil vals: nil];
}

-(id) initWithData: (NSMutableArray *) tags nameSpaces: (NSMutableDictionary *) ns attrs: (NSMutableDictionary *) att vals: (NSMutableArray *) val{
    self = [super init];
    if (self) {
        self.requiredTags = [[NSMutableArray alloc] initWithArray: tags];
        self.nameSpacesForTags = [[NSMutableDictionary alloc] initWithDictionary: ns];
        self.attrsForTags = [[NSMutableDictionary alloc] initWithDictionary: att];
        self.valueForTags = [[NSMutableArray alloc] initWithArray:val];
    }
    return self;
}

@end
