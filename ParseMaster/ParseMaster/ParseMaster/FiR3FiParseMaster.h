//
//  ParseMaster.h
//  ParseMaster
//
//  Created by Miles Alden on 10/21/12.
//  Copyright (c) 2012 MilesAlden. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FiR3FiOBJCReturnTypes.h"


typedef union UnionTemplate {
    int intValue;
    bool boolValue;
} UnionTemplate;


@interface FiR3FiParseMaster : NSObject {
    
}

@property (nonatomic, strong) NSString *dataType;
@property (nonatomic, strong) NSData   *ptrAsData;

// This was just here to make testing easier.
// It does nothing.
- (void)sendSomeUnion:(UnionTemplate)theUnion;

- (NSString *)parsePrimitive: (NSError **)error;
- (NSString *)parsePrimitiveWithData: (NSData *)data andType:(NSString *)dType error:(NSError **)error;

- (void)setData: (NSData *)data;
- (void)setDType: (NSString *)dType;
- (void)setData: (NSData *)data andType: (NSString *)dType;



@end
