//
//  AllocationTracker.cpp
//  STPUAllocationTracker
//
//  Created by Stefan Puehringer on 01/11/15.
//  Copyright © 2015 Stefan Puehringer. All rights reserved.
//

#include "AllocationTracker.hpp"

AllocationTracker* AllocationTracker::_instance = NULL;

AllocationTracker* AllocationTracker::tracker() {
    if (!_instance) {
        _instance = new AllocationTracker();
    }
    return _instance;
}

AllocationTracker::AllocationTracker() {
    _classCount = *new map<Class, unsigned long long>();
}

void AllocationTracker::incrementInstanceCountForClass(Class aCls) {
    _classCount[aCls] += 1;
}

void AllocationTracker::decrementInstanceCountForClass(Class aCls) {
    if (_classCount.find(aCls) != _classCount.end()) {
        if (_classCount[aCls] <= 1) {
            _classCount.erase(aCls);
        } else {
            _classCount[aCls] -= 1;
        }
    }
}

vector<pair<Class, unsigned long long>> AllocationTracker::countsSnapshot() {
    vector<pair<Class, unsigned long long>> pairs;
    
    for (auto itr = _classCount.begin(); itr != _classCount.end(); ++itr) {
        pairs.push_back(*itr);
    }
    
    sort(pairs.begin(), pairs.end(), [=](pair<Class, unsigned long long>& a, pair<Class, unsigned long long>& b) {
        return a.second > b.second;
    });
    
    return pairs;
}
