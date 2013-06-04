//
//  BloomFilterTests.m
//  BloomFilterTests
//
//  Created by Ryan on 6/4/13.
//  Copyright (c) 2013 Pickmoto. All rights reserved.
//

#import "BloomFilterTests.h"
#import "BloomFilter.h"

@interface BloomFilterTests ()
@property(nonatomic, strong) BloomFilter *filter;
@end

@implementation BloomFilterTests

- (void)setUp {
    [super setUp];
    
    // Set-up code here.
    self.filter = [[BloomFilter alloc] initWithNumberOfBits:1000000 andWithNumberOfHashes:3];
}

- (void)tearDown {
    // Tear-down code here.
    self.filter = nil;
    [super tearDown];
}

- (void)testEmpty {
    STAssertFalse([self.filter lookup:@"anything"], @"Verify that a lookup in an empty filter returns false");
}

- (void)testSimple {
    [self.filter addToSet:@"first test"];
    STAssertTrue([self.filter lookup:@"first test"], @"Perform a simple set and lookup");
}

- (void)testMultiple {
    [self.filter addToSet:@"second test"];
    [self.filter addToSet:@"The quick brown fox jumps over the lazy dog"];
    [self.filter addToSet:@"supercalifragilisticexpialidocious"];
    [self.filter addToSet:@"h"];
    [self.filter addToSet:@"end of test"];
    
    STAssertTrue([self.filter lookup:@"second test"], @"Perform a simple set and lookup");
    STAssertTrue([self.filter lookup:@"The quick brown fox jumps over the lazy dog"], @"Perform a simple set and lookup");
    STAssertTrue([self.filter lookup:@"supercalifragilisticexpialidocious"], @"Perform a simple set and lookup");
    STAssertTrue([self.filter lookup:@"h"], @"Perform a simple set and lookup");
    STAssertTrue([self.filter lookup:@"end of test"], @"Perform a simple set and lookup");
}

- (void)testWordFile {
    @autoreleasepool {
        NSString * filePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"words" ofType:@"txt"];
        FILE *libFile = fopen([filePath UTF8String],"r");
        if(libFile){
            char wah[200];
            while(fgets(wah, 200, libFile)) {
                [self.filter addToSet:[[[NSString alloc] initWithUTF8String:wah] stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
            }
        }
    }
    
    STAssertTrue([self.filter lookup:@"abarticulation"], @"Lookup a random word from the file");
}


@end
