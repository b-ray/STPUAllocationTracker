//
//  STPUBackgroundAllocationTracker.m
//  STPUAllocationTracker
//
//  Created by Stefan Puehringer on 01/11/15.
//  Copyright © 2015 Stefan Puehringer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STPUBackgroundAllocationTracker.h"
#import "NSObject+AllocationTracker.h"

@interface STPUBackgroundAllocationTracker ()

@property (nonatomic, copy) NSString *folderPath;

@end

@implementation STPUBackgroundAllocationTracker

+ (id)sharedInstance {
    static STPUBackgroundAllocationTracker *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

+ (void)load {
    [STPUBackgroundAllocationTracker sharedInstance];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
        NSString *timestamp = [NSString stringWithFormat:@"allocations/run_%ld", (long)timeInterval];
        self.folderPath = [documentsPath stringByAppendingPathComponent:timestamp];
        
        [[NSFileManager defaultManager] createDirectoryAtPath:self.folderPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:nil];
        
        [NSObject stpu_enableAllocationTracking];
        [self registerNotifications];
        
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private

- (void)registerNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveCurrentSnapshot)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(saveCurrentSnapshot)
                                                 name:UIApplicationWillTerminateNotification
                                               object:nil];
}

- (void)saveCurrentSnapshot {
    [NSObject stpu_saveAllocationSnapshotToFolder:self.folderPath];
}

@end
