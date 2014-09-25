//
//  Account.h
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 23/09/2014.
//
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "WorkInfo.h"
#import "BasicInfo.h"
#import "EducationInfo.h"
#import "PrivacyData.h"

@interface Account : NSObject
{
    BOOL isNew;
}

@property (strong,nonatomic) BasicInfo * basicInfo;
@property (strong,nonatomic) WorkInfo * workInfo;
@property (strong,nonatomic) EducationInfo * educationInfo;
@property (strong,nonatomic) PrivacyData * privacyData;

- (void) loadPrepareDataForFacebook;
- (void) loadPrepareDataForGooglePlus;

- (void) fetchFacebookDataFromFBGraphObject: (FBGraphObject *)result;

- (void) fetchFacebookPrivacySettingDataFromFBGraphObject: (FBGraphObject *)result;

- (void) addPropertyToBasicInfo: (Property *) prop;
- (void) addPropertyToWorkInfo: (Property *) prop;
- (void) addPropertyToEducationInfo: (Property *) prop;
- (void) addPrivacySettingData: (NSString *) privacyValue;

- (BOOL) isNeedReload;
- (void) needReload;

@end
