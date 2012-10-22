//
//  ParseMasterTests.m
//  ParseMasterTests
//
//  Created by Miles Alden on 10/21/12.
//  Copyright (c) 2012 MilesAlden. All rights reserved.
//

#import "ParseMasterTests.h"
#import "ParseMaster.h"
#import "OBJCReturnTypes.h"
#import "NSTNDictionaryAdditions.h"



@implementation ParseMasterTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testPtrSetting
{
    ParseMaster *parser = [[ParseMaster alloc] init];
    
    // Values to test
    const char *aPtr = "Silly String";
    char aChar = 'a';
    int anInt = INT_MAX;
    BOOL aBOOL = NO;
    float aFloat = 3.141592f;
    double aDouble = 3.14159265358973;
    short aShort = SHRT_MAX;
    long aLong = LONG_MAX;
    unsigned short aUShort = USHRT_MAX;
    unsigned long aULong = ULLONG_MAX;
    unsigned int aUInt = UINTMAX_MAX;
    void *nullPtr = NULL;
    long long aLongLong = LONG_LONG_MAX;
    char boolAsChar = (char)NO;
    
    // char *
    const char *newType = [OBJCReturnTypes returnTypeForKey:@"char *"];
    NSString *stringResult = [parser stringWithPrimitiveType:newType pointerToData:aPtr];
    STAssertNotNil( stringResult, @"ptr is null" );    
    NSLog(@"result: %s : %@", aPtr, stringResult);
    
    // char
    newType = [OBJCReturnTypes returnTypeForKey:@"char"];
    stringResult = [parser stringWithPrimitiveType:newType pointerToData:&aChar];
    STAssertNotNil( stringResult, @"ptr is null" );
    NSLog(@"result: %c : %@",aChar, stringResult);
    
    // int
    newType = [OBJCReturnTypes returnTypeForKey:@"int"];
    stringResult = [parser stringWithPrimitiveType:newType pointerToData:&anInt];
    STAssertNotNil( stringResult, @"ptr is null" );
    NSLog(@"result: %d : %@",anInt, stringResult);
    
    // bool
    newType = [OBJCReturnTypes returnTypeForKey:@"bool"];
    stringResult = [parser stringWithPrimitiveType:newType pointerToData:&aBOOL];
    STAssertNotNil( stringResult, @"ptr is null" );
    NSLog(@"result: %d : %@",aBOOL, stringResult);
    
    // float
    newType = [OBJCReturnTypes returnTypeForKey:@"float"];
    stringResult = [parser stringWithPrimitiveType:newType pointerToData:&aFloat];
    STAssertNotNil( stringResult, @"ptr is null" );
    NSLog(@"result: %f : %@",aFloat, stringResult);
    
    // double
    newType = [OBJCReturnTypes returnTypeForKey:@"double"];
    stringResult = [parser stringWithPrimitiveType:newType pointerToData:&aDouble];
    STAssertNotNil( stringResult, @"ptr is null" );
    NSLog(@"result: %f : %@",aDouble, stringResult);
    
    // short
    newType = [OBJCReturnTypes returnTypeForKey:@"short"];
    stringResult = [parser stringWithPrimitiveType:newType pointerToData:&aShort];
    STAssertNotNil( stringResult, @"ptr is null" );
    NSLog(@"result: %hd : %@",aShort, stringResult);
    
    // long
    newType = [OBJCReturnTypes returnTypeForKey:@"long"];
    stringResult = [parser stringWithPrimitiveType:newType pointerToData:&aLong];
    STAssertNotNil( stringResult, @"ptr is null" );
    NSLog(@"result: %li : %@", aLong, stringResult);
    
    
    // uShort
    newType = [OBJCReturnTypes returnTypeForKey:@"unsigned short"];
    stringResult = [parser stringWithPrimitiveType:newType pointerToData:&aUShort];
    STAssertNotNil( stringResult, @"ptr is null" );
    NSLog(@"result: %u : %@",aUShort, stringResult);
    
    // uLong
    newType = [OBJCReturnTypes returnTypeForKey:@"unsigned long"];
    stringResult = [parser stringWithPrimitiveType:newType pointerToData:&aULong];
    STAssertNotNil( stringResult, @"ptr is null" );
    NSLog(@"result: %lu : %@", aULong, stringResult);
    
    // uInt
    newType = [OBJCReturnTypes returnTypeForKey:@"unsigned int"];
    stringResult = [parser stringWithPrimitiveType:newType pointerToData:&aUInt];
    STAssertNotNil( stringResult, @"ptr is null" );
    NSLog(@"result: %u : %@",aUInt, stringResult);
    
    // NULL
    newType = [OBJCReturnTypes returnTypeForKey:@"pointer"];
    stringResult = [parser stringWithPrimitiveType:newType pointerToData:&nullPtr];
    STAssertNotNil( stringResult, @"ptr is null" );
    NSLog(@"result: %p : %@",nullPtr, stringResult);

    // long long
    newType = [OBJCReturnTypes returnTypeForKey:@"unsigned long long"];
    stringResult = [parser stringWithPrimitiveType:newType pointerToData:&aLongLong];
    STAssertNotNil( stringResult, @"ptr is null" );
    NSLog(@"result: %llu : %@",aLongLong, stringResult);

    // bool as char
    newType = [OBJCReturnTypes returnTypeForKey:@"char"];
    stringResult = [parser stringWithPrimitiveType:newType pointerToData:&boolAsChar];
    STAssertNotNil( stringResult, @"ptr is null" );
    NSLog(@"result: %c : %@",boolAsChar, stringResult);


}

@end
