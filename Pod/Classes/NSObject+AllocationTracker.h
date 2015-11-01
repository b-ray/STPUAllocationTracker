//
//  NSObject+AllocationTracker.h
//  STPUAllocationTracker
//
//  Created by Stefan Puehringer on 01/11/15.
//  Copyright © 2015 Stefan Puehringer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (STPUAllocationTracker)

+ (void)stpu_enableAllocationTracking;
+ (void)stpu_saveAllocationSnapshotToFolder:(NSString *)path;

@end

