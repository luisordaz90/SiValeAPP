//
//  iOSRequest.m
//  WebServiceDemo
//
//  Created by Andrew Barba on 10/14/12.
//  Copyright (c) 2012 Andrew Barba. All rights reserved.
//

#import "iOSRequest.h"
#import "NSString+WebService.h"

NSString *basePath = @"http://148.223.134.18:8888/bancamovil/WebMethods";

@implementation iOSRequest
+(void)requestPath:(NSData *) xmlData onCompletion:(RequestCompletionHandler)complete
{
    // Background Queue
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];

    // URL Request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString: basePath]
                                                  cachePolicy:0
                                              timeoutInterval:60];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody: xmlData];
    
    // Send Request
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:backgroundQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {

        /*NSLog(@"LOG ARR: %@",[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);*/
        if (complete) complete(data,error);
                           
    }
     
    ];
}


+(void)generalRequest: (NSData *)xmlData forAction: (NSString *) action onCompletion:(RequestDictionaryCompletionHandler)complete{
    [iOSRequest requestPath:xmlData onCompletion:^(NSData *result, NSError *error){
        if (error || (result == nil)) {
            if (complete) complete(nil);
        } else {
            int i = 0;
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:result options:0 error:&error];
            NSMutableDictionary *testDict = [[NSMutableDictionary alloc]init];
            NSArray *partyMembers = [[NSArray alloc] init];
            if ([action isEqualToString:@"login"]) {
                partyMembers = [doc nodesForXPath:@"//item/*" error:nil];
            }
            else
                if([action isEqualToString:@"balances"]){
                    partyMembers = [doc nodesForXPath:@"//saldo" error:nil];
                }
                else{
                    partyMembers = [doc nodesForXPath:@"//objMovimientos/*" error:nil];
                }
            
            for(GDataXMLNode *node in partyMembers){
                if(action == nil)
                    [testDict setValue:[node stringValue] forKey:[[node name] stringByAppendingFormat:@"%d",i++]];
                else{
                    [testDict setValue:[node stringValue] forKey:[node name]];
                }
            }
            if (complete) complete(testDict);
        }
    }];
}



/*
+(void)generalRequest:(NSString *)SID andUser: (NSString *)user andToken: (NSString *)token andAction: (NSString *)action andController:(NSString *)controller andParams: (NSMutableDictionary *) params onCompletion:(RequestDictionaryCompletionHandler)complete{
    [iOSRequest requestPath:basePath onCompletion:^(NSString *result, NSError *error){
        if (error || [result isEqualToString:@""]) {
            if (complete) complete(nil);
        } else {
            NSLog(@"RESULTADO: %@",result);
            NSError *parseError = nil;
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[XMLReader dictionaryForXMLString:result error:&parseError]
                                                               options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                                 error:&error];
            NSDictionary *user = [[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] JSON];
            if (complete) complete(user);
        }
    }];
}*/

/*
+(void)imageRequest:(NSString *)SID andUser: (NSString *)user andToken: (NSString *)token andAction: (NSString *)action andController:(NSString *)controller onCompletion:(RequestDictionaryCompletionHandler)complete{
    SID = [SID URLEncode];
    user = [user URLEncode];
    token = [token URLEncode];
    NSString *fullPath = [basePath stringByAppendingFormat:@"%@?mobile=1&usuarios=%@&SID=%@&token=%@&accion=%@",controller,user,SID,token,action];
    NSLog(@"%@",fullPath);
    [iOSRequest requestPath:fullPath onCompletion:^(NSString *result, NSError *error){
        if (error || [result isEqualToString:@""]) {
            if (complete) complete(nil);
        } else {
            NSDictionary *user = [result JSON];
            if (complete) complete(user);
        }
    }];
}*/

@end
