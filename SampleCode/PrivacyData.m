//
//  PrivacyInfo.m
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 23/09/2014.
//
//

#import "PrivacyData.h"

@implementation PrivacyData
@synthesize privacySettingList;
@synthesize privacyAwarenessList;
- (id) init
{
    self = [super init];
    
    if (self) {
        privacySettingList = [[NSMutableArray alloc] init];
        privacyAwarenessList = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

- (void) addPrivacyWithDefaultAwareness:(NSString *) privacy
{
    if (![privacySettingList containsObject:privacy]) {
        [privacySettingList addObject:privacy];
        [self addDefaultPrivacyAwarenessForKey:privacy];
    }
}

- (void) addPrivacy:(NSString *) privacy WithCustomAwareness:(NSString*) awareness
{
    if (![privacySettingList containsObject:privacy]) {
        [privacySettingList addObject:privacy];
        [self addCustomPrivacyAwareness:awareness ForKey:privacy];
    }
}

- (void) addDefaultPrivacyAwarenessForKey: (NSString*) key
{
    NSString *template = @"Only people in this '%@' group can access to this data";
    NSString *awareness = [NSString stringWithFormat:template, key,key];
    [self addCustomPrivacyAwareness:awareness ForKey:key];
}

- (void) addCustomPrivacyAwareness: (NSString*)awareness_ ForKey: (NSString*) key
{
    NSString *template = @"Awareness for '%@': \n- %@";
    NSString *awareness = [NSString stringWithFormat:template,key,awareness_];
    [privacyAwarenessList setValue:awareness forKey:key];
}

@end
