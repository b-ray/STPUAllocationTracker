//
//  NSObject+AllocationTracker.m
//  STPUAllocationTracker
//
//  Created by Stefan Puehringer on 01/11/15.
//  Copyright © 2015 Stefan Puehringer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#import "NSObject+AllocationTracker.h"
#import "AllocationTracker.hpp"

void stpu_swizzleInstance(Class c, SEL orig, SEL patch) {
    Method origMethod = class_getInstanceMethod(c, orig);
    Method patchMethod = class_getInstanceMethod(c, patch);
    
    BOOL added = class_addMethod(c, orig,
                                 method_getImplementation(patchMethod),
                                 method_getTypeEncoding(patchMethod));
    
    if (added) {
        class_replaceMethod(c, patch,
                            method_getImplementation(origMethod),
                            method_getTypeEncoding(origMethod));
        return;
    }
    
    method_exchangeImplementations(origMethod, patchMethod);
}

void stpu_swizzleClass(Class c, SEL orig, SEL patch) {
    Method origMethod = class_getClassMethod(c, orig);
    Method patchMethod = class_getClassMethod(c, patch);
    
    class_addMethod(c, orig,
                    method_getImplementation(patchMethod),
                    method_getTypeEncoding(patchMethod));
    
    method_exchangeImplementations(origMethod, patchMethod);
}

@implementation NSObject (STPUAllocationTracker)

+ (instancetype)stpu_trackedAlloc {
    id object = [self stpu_trackedAlloc];
    AllocationTracker::tracker()->incrementInstanceCountForClass([object class]);
    return object;
}

- (void)stpu_trackedDealloc {
    AllocationTracker::tracker()->decrementInstanceCountForClass([self class]);
    [self stpu_trackedDealloc];
}

+ (void)stpu_enableAllocationTracking {
    stpu_swizzleClass(NSObject.class, @selector(alloc), @selector(stpu_trackedAlloc));
    stpu_swizzleInstance(NSObject.class, @selector(dealloc), @selector(stpu_trackedDealloc));
}

+ (void)stpu_saveAllocationSnapshotToFolder:(NSString *)path {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        vector<pair<Class, unsigned long long>> result = AllocationTracker::tracker()->countsSnapshot();
        NSMutableString *info = [NSMutableString string];
        for (auto itr = result.begin(); itr != result.end(); ++itr) {
            [info appendString:[NSString stringWithFormat:@"%@,%llu\n", NSStringFromClass(itr->first), itr->second]];
        }
        
        if (!path) {
            NSLog(@"Current allocations: %@", info);
        } else {
            NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
            NSString *timestamp = [NSString stringWithFormat:@"%ld.csv", (long)timeInterval];
            NSString *filePath = [path stringByAppendingPathComponent:timestamp];
            [info writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
    });
}

@end
