//
//  ParseMaster.m
//  ParseMaster
//
//  Created by Miles Alden on 10/21/12.
//  Copyright (c) 2012 MilesAlden. All rights reserved.
//

#import "FiR3FiParseMaster.h"
#import "FiR3FiOBJCReturnTypes.h"

@implementation FiR3FiParseMaster

- (void)sendSomeUnion:(UnionTemplate)theUnion {
    //Do something
}


- (NSString *)parsePrimitive: (NSError **)error {
       
    // Error checking
    
    // Nil data
    if ( self.ptrAsData == nil ) {
        if (*error) {
            *error = [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier]
                                        code:2
                                    userInfo: @{ NSLocalizedDescriptionKey : @"Data was NULL."} ];
            NSLog(@"-[%@ %@] ~ERROR~ %@", self, NSStringFromSelector(_cmd), [*error localizedDescription]);
            return nil;
        }
        NSLog(@"-[%@ %@] ~ERROR~ %@", self, NSStringFromSelector(_cmd), @"Data was NULL.");
        return nil;
    }
    
    
    // Nil data type
    if ( self.dataType == nil ) {
        if (*error) {
            *error = [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier]
                                        code:3
                                    userInfo: @{ NSLocalizedDescriptionKey : @"Data type was NULL."} ];
            NSLog(@"-[%@ %@] ~ERROR~ %@", self, NSStringFromSelector(_cmd), [*error localizedDescription]);
            return nil;
        }
        NSLog(@"-[%@ %@] ~ERROR~ %@", self, NSStringFromSelector(_cmd), @"Data type was NULL.");
        return nil;

    }
    
    
    return [self stringFromPrimitive];
    
}


- (NSString *)parsePrimitiveWithData: (NSData *)data andType:(NSString *)dType error:(NSError **)error {
    
    [self setData:data];
    [self setDType:dType];
    return [self parsePrimitive:error];
    
}



- (NSString *)stringFromPrimitive {
    
    return [self parseDataToString];
}



- (void)setData: (NSData *)data {
    
    self.ptrAsData = data;
}

- (void)setDType: (NSString *)dType {
    
    self.dataType = dType;
}

- (void)setData: (NSData *)data andType: (NSString *)dType {
    
    [self setData:data];
    [self setDType:dType];
    
}



// CORE
//
// Losing ptr references
// Need to retain these as NSData
- (NSString *)parseDataToString {
    

    // There really is no other way around
    // this activity than to handle it in
    // some kind of flow-control manner.
    //
    // At least this way the code can finally be reused,
    // and not fucking cut-paste.
    //
    
    const void *arg = self.ptrAsData.bytes;
    NSString *argType = self.dataType;
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber * number = @0;
    NSString * string = @"";
    
    if ( arg != NULL ) {
        
        if ( [argType isEqualToString:@"i"] ) {
            int *temp = (int*)arg;
            number = [NSNumber numberWithInt:*temp];

        } else if ( [argType isEqualToString:@"B"] ) {
            BOOL *temp = (BOOL*)arg;
            number = [NSNumber numberWithBool:*temp];
            
        } else if ( [argType isEqualToString:@"s"] ) {
            short *temp = (short*)arg;
            number = [NSNumber numberWithShort:*temp];
            
        } else if ( [argType isEqualToString:@"l"] ) {
            long *temp = (long*)arg;
            number = [NSNumber numberWithLong:*temp];
            
        } else if ( [argType isEqualToString:@"q"] ) {
            long long *temp = (long long*)arg;
            number = [NSNumber numberWithLongLong:*temp];

        
        } else if ( [argType isEqualToString:@"C"] ) {
            unsigned char *temp = (unsigned char*)arg;
            number = [NSNumber numberWithUnsignedChar:*temp];

        
        } else if ( [argType isEqualToString:@"I"] ) {
            unsigned int *temp = (unsigned int*)arg;
            number = [NSNumber numberWithUnsignedInt:*temp];

        
        } else if ( [argType isEqualToString:@"S"] ) {
            unsigned short *temp = (unsigned short*)arg;
            number = [NSNumber numberWithUnsignedShort:*temp];
            
            
        } else if ( [argType isEqualToString:@"L"] ) {
            unsigned long *temp = (unsigned long*)arg;
            number = [NSNumber numberWithUnsignedLong:*temp];
            
            
        } else if ( [argType isEqualToString:@"Q"] ) {
            unsigned long long *temp = (unsigned long long*)arg;
            number = [NSNumber numberWithUnsignedLongLong:*temp];

            
        } else if ( [argType isEqualToString:@"f"] ) {
            float *temp = (float *)arg;
            number = [NSNumber numberWithFloat:*temp];
            
            
        } else if ( [argType isEqualToString:@"d"] ) {
            double *temp = (double*)arg;
            number = [NSNumber numberWithDouble:*temp];
        }
        
        // Flip to string
        string = [number stringValue];
            
        
        // This one is handled slightly differently
        if ( [argType isEqualToString:@"*"] ) {
            char *temp = (char*)arg;
            string = [NSString stringWithCString:temp encoding:NSASCIIStringEncoding];
            
        } else if ( [argType isEqualToString:@"c"] ) {
            char *someChar = (char*)arg;
            
            // Most likely means this char
            // was actually a BOOL.
            //
            // Register values accordingly as
            // 1 & 0.
            if ( ((int)*someChar == 1) ) {
                *someChar = '1';
            } else if ( ((int)*someChar == 0) ) {
                *someChar = '0';
            }
            string = [NSString stringWithFormat:@"%c", *someChar];
            
            // SEL
        } else if ( [argType isEqualToString:@":"] ) {
            SEL *temp = (SEL*)arg;
            string = NSStringFromSelector(*temp);
        
            // Pointer
        } else if ( [argType isEqualToString:@"^"] ) {
            string = [NSString stringWithFormat:@"ptr: <%p>", arg];
            
            
            // TODO FIX HERE
            // Right now if the arg is a struct,
            // array or union, there really is no
            // way to properly parse out the value.
            // If it was possible to build a type from
            // a string, that might work.
            //
            // Without this however there are simply
            // too many possibilites to follow this
            // same sequence of actions as we've done
            // with basic data types.
            //
            // So all I can really do here is return
            // the raw type as the value. At least that
            // way you'll know what it is.
            //

            // Arrays, Structs and Unions
        } else if ( argType.length > 1  ) {
            string = argType;
        }


    }

    return string;
}

@end
