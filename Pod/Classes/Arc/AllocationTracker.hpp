//
//  AllocationTracker.hpp
//  STPUAllocationTracker
//
//  Created by Stefan Puehringer on 01/11/15.
//  Copyright © 2015 Stefan Puehringer. All rights reserved.
//

#ifndef AllocationTracker_hpp
#define AllocationTracker_hpp

#include <objc/runtime.h>

#include <stdio.h>
#include <map>
#include <vector>
#include <algorithm>

using namespace std;

class AllocationTracker {
public:
    static AllocationTracker* tracker();
    
    void incrementInstanceCountForClass(Class aCls);
    void decrementInstanceCountForClass(Class aCls);
    vector<pair<Class, unsigned long long>> countsSnapshot();
    
private:
    AllocationTracker();
    static AllocationTracker* _instance;
    map<Class, unsigned long long> _classCount;
};

#endif /* AllocationTracker_hpp */
