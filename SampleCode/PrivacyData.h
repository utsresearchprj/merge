//
//  PrivacyInfo.h
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 23/09/2014.
//
//

#import <Foundation/Foundation.h>

@interface PrivacyData : NSObject

@property (strong,nonatomic) NSMutableArray *privacySettingList;
@property (strong,nonatomic) NSMutableDictionary *privacyAwarenessList;

- (void) addPrivacyWithDefaultAwareness:(NSString *) privacy;
- (void) addPrivacy:(NSString *) privacy WithCustomAwareness:(NSString*) awareness;
- (void) addDefaultPrivacyAwarenessForKey: (NSString*) key;
- (void) addCustomPrivacyAwareness: (NSString*)awareness_ ForKey: (NSString*) key;
@end
