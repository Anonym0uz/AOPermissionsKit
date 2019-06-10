//
//  AOPermissionsKitModel.h
//  AOPermissionsKitModel
//
//  Created by Alexander Orlov on 08.10.2018.
//  Copyright © 2018 Alexander Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, AOPermissionsKitAccess) {
    AOPermissionsKitAccessCamera = 0,
    AOPermissionsKitAccessMicrophone = 1,
    AOPermissionsKitAccessPhotoLibrary = 2,
    AOPermissionsKitAccessCalendar = 3,
    AOPermissionsKitAccessReminders = 4,
    AOPermissionsKitAccessContacts = 5,
    AOPermissionsKitAccessLocationWhenUse = 6,
    AOPermissionsKitAccessLocationAlways = 7
};
typedef void(^AccessGrantedBlockModel)(void);
typedef void(^AccessDeniedBlockModel)(void);
typedef void(^AccessGrantedFromAlertBlockModel)(void);
typedef void(^AccessDeniedFromAlertBlockModel)(void);

@interface AOPermissionsKitModel : NSObject
@property (nonatomic, readwrite) AccessGrantedBlockModel grantedBlock;
@property (nonatomic, readwrite) AccessDeniedBlockModel deniedBlock;
@property (nonatomic, readwrite) AccessGrantedFromAlertBlockModel grantedFromAlertBlock;
@property (nonatomic, readwrite) AccessDeniedFromAlertBlockModel deniedFromAlertBlock;

+ (AOPermissionsKitModel *)sharedModel;
#pragma mark - Camera, Mic & photo library
+ (void)checkCameraAccessModel;
+ (void)checkMicrophoneAccessModel;
+ (void)checkPhotoLibraryAccessModel;
#pragma mark - Calendar & Reminder
+ (void)checkCalendarAccessModel;
+ (void)checkRemindersAccessModel;
#pragma mark - Contacts
+ (void)checkContactsAccessModel;
#pragma mark - Location
+ (void)checkLocationWhenUseModel;
+ (void)checkLocationAlwaysModel;
#pragma mark - 
+ (void)goToSettingsAlertWithTitleModel:(NSString * _Nonnull)alertTitle alertMessage:(NSString * _Nonnull)alertMessage buttonTitle:(NSString * _Nonnull)buttonTitle cancelButtonTitle:(NSString *)cancelButtonTitle;
+ (void)goToSettingsSheetWithTitleModel:(NSString * _Nonnull)alertTitle alertMessage:(NSString * _Nonnull)alertMessage buttonTitle:(NSString * _Nonnull)buttonTitle cancelButtonTitle:(NSString *)cancelButtonTitle;
@end
