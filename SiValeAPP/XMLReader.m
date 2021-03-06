//
//  XMLReader.m
//
//  Created by Troy Brant on 9/18/10.
//  Updated by Antoine Marcadet on 9/23/11.
//  Updated by Divan Visagie on 2012-08-26
//

#import "XMLReader.h"

#if !defined(__has_feature) || !__has_feature(objc_arc)
#error "XMLReader requires ARC support."
#endif

NSString *const kXMLReaderTextNodeKey		= @"text";
NSString *const kXMLReaderAttributePrefix	= @"@";

@interface XMLReader ()

@property (nonatomic, strong) NSMutableArray *dictionaryStack;
@property (nonatomic, strong) NSMutableString *textInProgress;
@property (nonatomic, strong) NSDictionary *queriedFields;
@property (nonatomic, strong) NSError *errorPointer;
@property (nonatomic, strong) NSString *currentElement;

@end

NSString *currElement;

@implementation XMLReader

#pragma mark - Public methods

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)error
{
    XMLReader *reader = [[XMLReader alloc] initWithError:error];
    NSDictionary *rootDictionary = [reader objectWithData:data options:0];
    return rootDictionary;
}

+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)error
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [XMLReader dictionaryForXMLData:data error:error];
}

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data options:(XMLReaderOptions)options error:(NSError **)error
{
    XMLReader *reader = [[XMLReader alloc] initWithError:error];
    NSDictionary *rootDictionary = [reader objectWithData:data options:options];
    return rootDictionary;
}

+ (NSDictionary *)dictionaryForXMLString:(NSString *)string options:(XMLReaderOptions)options error:(NSError **)error
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [XMLReader dictionaryForXMLData:data options:options error:error];
}


#pragma mark - Parsing

- (id)initWithError:(NSError **)error
{
	self = [super init];
    if (self)
    {
        self.errorPointer = *error;
    }
    return self;
}

- (NSDictionary *)objectWithData:(NSData *)data options:(XMLReaderOptions)options
{
    // Clear out any old data
    self.queriedFields = @{@"item":@1,@"nomTarjeta":@2,@"numTarjeta":@3,@"idSesion":@4};
    self.dictionaryStack = [[NSMutableArray alloc] init];
    self.textInProgress = [[NSMutableString alloc] init];
    self.currentElement = [[NSString alloc] init];
    
    // Initialize the stack with a fresh dictionary
    [self.dictionaryStack addObject:[NSMutableDictionary dictionary]];
    
    // Parse the XML
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    
    [parser setShouldProcessNamespaces:(options & XMLReaderOptionsProcessNamespaces)];
    [parser setShouldReportNamespacePrefixes:(options & XMLReaderOptionsReportNamespacePrefixes)];
    [parser setShouldResolveExternalEntities:(options & XMLReaderOptionsResolveExternalEntities)];
    
    parser.delegate = self;
    BOOL success = [parser parse];
	
    // Return the stack's root dictionary on success
    if (success)
    {
        NSDictionary *resultDict = [self.dictionaryStack objectAtIndex:0];
        return resultDict;
    }
    
    return nil;
}


#pragma mark -  NSXMLParserDelegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    self.currentElement = nil;
    NSLog(@"ELEMENTO: %@",elementName);
    if((int)[self.queriedFields objectForKey:elementName] > 0){
        // Get the dictionary for the current level in the stack
        self.currentElement = elementName;
        NSMutableDictionary *parentDict = [self.dictionaryStack lastObject];

        // Create the child dictionary for the new element, and initilaize it with the attributes
        NSMutableDictionary *childDict = [NSMutableDictionary dictionary];
        [childDict addEntriesFromDictionary:attributeDict];
    
        // If there's already an item for this key, it means we need to create an array
        id existingValue = [parentDict objectForKey:elementName];
        if (existingValue)
        {
            NSMutableArray *array = nil;
            if ([existingValue isKindOfClass:[NSMutableArray class]])
            {
                // The array exists, so use it
                array = (NSMutableArray *) existingValue;
            }
            else
            {
                // Create an array if it doesn't exist
                array = [NSMutableArray array];
                [array addObject:existingValue];

                // Replace the child dictionary with an array of children dictionaries
                [parentDict setObject:array forKey:elementName];
            }
        
            // Add the new child dictionary to the array
            [array addObject:childDict];
        }
        else
        {
            // No existing value, so update the dictionary
            [parentDict setObject:childDict forKey:elementName];
        }
    
        // Update the stack
        [self.dictionaryStack addObject:childDict];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if((int)[self.queriedFields objectForKey:elementName] > 0){
    // Update the parent dict with text info
    NSMutableDictionary *dictInProgress = [self.dictionaryStack lastObject];
    
    // Set the text property
    if ([self.textInProgress length] > 0)
    {
        // trim after concatenating
        NSString *trimmedString = [self.textInProgress stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [dictInProgress setObject:[trimmedString mutableCopy] forKey:kXMLReaderTextNodeKey];

        // Reset the text
        self.textInProgress = [[NSMutableString alloc] init];
    }
    
    // Pop the current dict
    [self.dictionaryStack removeLastObject];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if((int)[self.queriedFields objectForKey:self.currentElement] > 0){
        // Build the text value
        [self.textInProgress appendString:string];
    }
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    // Set the error pointer to the parser's error object
    self.errorPointer = parseError;
}

@end
