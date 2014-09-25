//
//  EducationInfo.m
//  Social Network Privacy Management
//
//  Created by Cong Phap Bui on 18/09/2014.
//
//

#import "EducationInfo.h"

@implementation EducationInfo

@synthesize keyList;
@synthesize inputTypeList;
@synthesize propertyList;
@synthesize privacySettingList;
- (id) init
{
    if (self) {
        keyList = [[NSMutableArray alloc] init];
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
        
        inputTypeList = [[NSMutableArray alloc] init];
        
        privacySettingList = [[NSMutableArray alloc] init];
        
=======
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
        [keyList addObject:@"school"];
        [keyList addObject:@"type"];
        [keyList addObject:@"year"];
        [keyList addObject:@"concentration"];
        
        inputTypeList = [[NSMutableArray alloc] init];
        
        [inputTypeList addObject:[NSNumber numberWithInt:KeyboardType]];
        [inputTypeList addObject:[NSNumber numberWithInt:SchoolPickerType]];
        [inputTypeList addObject:[NSNumber numberWithInt:DatePickerType]];
        [inputTypeList addObject:[NSNumber numberWithInt:KeyboardType]];
        
        privacySettingList = [[NSMutableArray alloc] init];
        
        [privacySettingList addObject:@"Public"];
        [privacySettingList addObject:@"Public"];
        [privacySettingList addObject:@"Public"];
        [privacySettingList addObject:@"Public"];
        
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
        propertyList = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) addProperty:(Property *)property_
{
    [propertyList addObject: property_];
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    
    [privacySettingList addObject:@"Public"];
}

- (void) loadFacebookKeyList
{
    [keyList addObject:@"school"];
    [keyList addObject:@"type"];
    [keyList addObject:@"year"];
    [keyList addObject:@"degree"];
    [keyList addObject:@"concentration"];
}

- (void) loadFacebookInput
{
    [inputTypeList addObject:[NSNumber numberWithInt:KeyboardType]];
    [inputTypeList addObject:[NSNumber numberWithInt:SchoolPickerType]];
    [inputTypeList addObject:[NSNumber numberWithInt:DatePickerType]];
    [inputTypeList addObject:[NSNumber numberWithInt:KeyboardType]];
    [inputTypeList addObject:[NSNumber numberWithInt:KeyboardType]];
}


- (void) loadPrepareDataForFacebook
{
    [self loadFacebookKeyList];
    [self loadFacebookInput];
}

- (void) loadGooglePlusKeyList
{
    
}

- (void) loadGooglePlusInput
{
    
}

- (void) loadPrepareDataForGooglePlus
{
    [self loadGooglePlusKeyList];
    [self loadGooglePlusInput];
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
=======
>>>>>>> FETCH_HEAD
}

@end
