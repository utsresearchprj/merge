//
//  Account.m
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 23/09/2014.
//
//

#import "Account.h"

@implementation Account

@synthesize basicInfo;
@synthesize workInfo;
@synthesize educationInfo;
@synthesize privacyData;
- (id) init
{
    if(self)
    {
        isNew = TRUE;
        basicInfo = [[BasicInfo alloc] init];
        workInfo = [[WorkInfo alloc] init];
        educationInfo = [[EducationInfo alloc] init];
        privacyData = [[PrivacyData alloc]init];
    }
    return self;
}
#pragma mark -----ADD METHODS TO ADD PROPERTY FOR BI/WI/EI
- (void) addPropertyToBasicInfo: (Property *) prop
{
    [basicInfo addProperty:prop];
}

- (void) addPropertyToWorkInfo: (Property *) prop
{
    [workInfo addProperty:prop];
}

- (void) addPropertyToEducationInfo: (Property *) prop
{
    [educationInfo addProperty:prop];
}

- (void) addPrivacySettingData: (NSString *) privacyValue
{
    [privacyData addPrivacyWithDefaultAwareness:privacyValue];
}

#pragma mark -----LOAD METHODS TO LOAD DEFAULT DATA USING FOR FACEBOOK/GOOGLE PLUS
- (void) loadBasicFacebookPrivacyData
{
    NSString *publicAwareness = @"All people can access this data on Facebook";
    [privacyData addPrivacy:@"Public" WithCustomAwareness:publicAwareness];
    
    NSString *onlyMeAwareness = @"Only you can acess to this data on Facebook";
    [privacyData addPrivacy:@"Only me" WithCustomAwareness:onlyMeAwareness];
    
    NSString *friendsAwareness = @"Only your Facebook's friends in your friend lists can acess to this data on Facebook";
    [privacyData addPrivacy:@"Friends" WithCustomAwareness:friendsAwareness];
    
    NSString *friendsOfFriendsAwareness = @"All friends of your Facebook's friends in your friend lists can acess to this data on Facebook";
    [privacyData addPrivacy:@"Friends of Friends" WithCustomAwareness:friendsOfFriendsAwareness];
}

- (void) loadBasicGooglePlusPrivacyData
{
    [privacyData.privacySettingList addObject:@"Public"];
}

- (void) loadPrepareDataForFacebook
{
    [self loadBasicFacebookPrivacyData];
    [basicInfo loadPrepareDataForFacebook];
    [workInfo loadPrepareDataForFacebook];
    [educationInfo loadPrepareDataForFacebook];
}

- (void) loadPrepareDataForGooglePlus
{
    [self loadBasicGooglePlusPrivacyData];
    [basicInfo loadPrepareDataForGooglePlus];
    [workInfo loadPrepareDataForGooglePlus];
    [educationInfo loadPrepareDataForGooglePlus];
}
#pragma mark -----FETCH DATA FOR FACEBOOK
- (void) fetchFacebookBasicInfoFromFBGraphObject: (FBGraphObject *)result
{
    NSMutableArray *bIkeyList = [basicInfo keyList];
    
    for (NSString * key in bIkeyList) {
        NSString* value = [result objectForKey:key];
        if (!value) {
            value = @"";
        }
        Property *prop = [[Property alloc]initWithKey:key Value:value];

        [self addPropertyToBasicInfo:prop];
    }
}

- (void) fetchFacebookWorkInfoFromFBGraphObject: (FBGraphObject *)result
{
    NSMutableArray *wIkeyList = [workInfo keyList];
    
    int workCount = [[result objectForKey:@"work"] count];
    
    for (int i=0; i<workCount; i++) {
        FBGraphObject * workInfoGraph = [result objectForKey:@"work"][i];
        NSMutableArray * workDetail = [[NSMutableArray alloc] init];
        
        for (NSString * key in wIkeyList) {
            NSString* value = [workInfoGraph objectForKey:key];
            if ([[workInfoGraph objectForKey:key] isKindOfClass:([FBGraphObject class])]) {
                value = [[workInfoGraph objectForKey:key] objectForKey:@"name"];
            }
            if (!value) {
                value = @"";
            }
            Property *prop = [[Property alloc]initWithKey:key Value:value];
            [workDetail addObject:prop];
        }
        NSString * mainKey = [NSString stringWithFormat:@"Work_%d",i+1];
        Property *workDetailProp = [[Property alloc] initWithKey:mainKey Value:workDetail];

        [self addPropertyToWorkInfo:workDetailProp];
    }
}

- (void) fetchFacebookEducationInfoFromFBGraphObject: (FBGraphObject *)result
{
    NSMutableArray *eIkeyList = [educationInfo keyList];
    
    int eduCount = [[result objectForKey:@"education"] count];
    
    for (int i=0; i<eduCount; i++) {
        FBGraphObject * eduInfoGraph = [result objectForKey:@"education"][i];
        NSMutableArray * eduDetail = [[NSMutableArray alloc] init];
        
        for (NSString * key in eIkeyList) {
            
            id value = [eduInfoGraph objectForKey:key];
            
            if ([value isKindOfClass:([NSString class])])
            {
                value = (NSString *)value;
            }else if ([value isKindOfClass:([FBGraphObject class])])
            {
                value = [value objectForKey:@"name"];
            }
            else
            {
                int total = 0;
                @try
                {
                    total = [[eduInfoGraph objectForKey:key] count];
                    if (total > 0)
                    {
                        value = @"";
                        int total = [[eduInfoGraph objectForKey:key] count];
                        for (int i=0; i<total; i++)
                        {
                            NSString *newValue = [[eduInfoGraph objectForKey:key][i] objectForKey:@"name"];
                            
                            if ([value length]>0) {
                                value = newValue;
                            }
                            else
                            {
                                value = [NSString stringWithFormat:@"%@, %@", value, newValue];
                            }
                        }
                    }
                }
                @catch(NSException *ex)
                {
                    NSLog(@"Error happen at Key: %@",key);
                }
            }
            if (!value) {
                value = @"";
            }
            Property *prop = [[Property alloc]initWithKey:key Value:value];
            [eduDetail addObject:prop];
        }
        NSString * mainKey = [NSString stringWithFormat:@"Education_%d",i+1];
        Property *eduDetailProp = [[Property alloc] initWithKey:mainKey Value:eduDetail];
        
        [self addPropertyToEducationInfo:eduDetailProp];
    }
}

- (void) fetchFacebookDataFromFBGraphObject: (FBGraphObject *)result
{
    [self loadPrepareDataForFacebook];
    
    [self fetchFacebookBasicInfoFromFBGraphObject:result];
    
    [self fetchFacebookWorkInfoFromFBGraphObject:result];
    
    [self fetchFacebookEducationInfoFromFBGraphObject:result];
}

- (void) fetchFacebookPrivacySettingDataFromFBGraphObject: (FBGraphObject *)result
{
    id data = [result objectForKey:@"data"];
    if ([data count] > 0) {
        for (FBGraphObject * obj in data)
        {
            NSString *value = [obj objectForKey:@"name"];
            
            [self addPrivacySettingData:value];
        }
    }
}

#pragma mark -----FETCH DATA FOR GOOGLE PLUS


#pragma mark -----GENERAL METHODS
- (BOOL) isNeedReload
{
    return !isNew;
}

- (void) needReload
{
    isNew = FALSE;
}

@end
