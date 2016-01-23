//
//  iOSRequest.h
//  WebServiceDemo
//
//  Created by Andrew Barba on 10/14/12.
//  Copyright (c) 2012 Andrew Barba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMLReader.h"
#import "GDataXMLNode.h"

typedef void(^RequestCompletionHandler)(NSData*,NSError*);
typedef void(^RequestDictionaryCompletionHandler)(NSDictionary*);

@interface iOSRequest : NSObject

+(void)requestPath:(NSData *) xmlData
      onCompletion:(RequestCompletionHandler)complete;
+(void)generalRequest:(NSData *) xmlData forAction: (NSString *) action onCompletion:(RequestDictionaryCompletionHandler)complete;
/*
+(void)generalRequest:(NSString *)SID
             andUser:(NSString *)user
           andToken: (NSString *)token
          andAction: (NSString *) action
        andController: (NSString *)controller
            andParams: (NSMutableDictionary *) params
            onCompletion:(RequestDictionaryCompletionHandler)complete;*/
@end
