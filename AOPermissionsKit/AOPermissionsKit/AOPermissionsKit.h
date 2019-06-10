//
//  AOPermissionsKitLogic.h
//  AOPermissionsKit
//
//  Created by Alexander Orlov on 10.06.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <EventKit/EventKit.h>
#import <ContactsUI/ContactsUI.h>
#import <CoreLocation/CoreLocation.h>
#import <AOPermissionsKit/AOPermissionsKitModel.h>

//! Project version number for AOPermissionsKit.
FOUNDATION_EXPORT double AOPermissionsKitVersionNumber;

//! Project version string for AOPermissionsKit.
FOUNDATION_EXPORT const unsigned char AOPermissionsKitVersionString[];

typedef void(^AccessGrantedBlock)(void);
typedef void(^AccessDeniedBlock)(void);
typedef void(^AccessGrantedFromAlertBlock)(void);
typedef void(^AccessDeniedFromAlertBlock)(void);

@interface AOPermissionsKit : NSObject
/*!
 @brief         Granted block
 @discussion    If already granted, you can use this method.
 @code          [[AOPermissionsKit sharedInstance] setGrantedBlockKit:^{}];
 @endcode
 */
@property (nonatomic, readwrite) AccessGrantedBlock grantedBlockKit;

/*!
 @brief         Denied block
 @discussion    If already denied, you can use this method.
 @code          [[AOPermissionsKit sharedInstance] setDeniedBlockKit:^{}];
 @endcode
 */
@property (nonatomic, readwrite) AccessDeniedBlock deniedBlockKit;

/*!
 @brief         Granted from alert
 @discussion    If user click on "Allow" in alert view.
 @code          [[AOPermissionsKit sharedInstance] setGrantedFromAlertBlockKit:^{}];
 @endcode
 */
@property (nonatomic, readwrite) AccessGrantedFromAlertBlock grantedFromAlertBlockKit;

/*!
 @brief         Check access to microphone
 @discussion    If user click on "Deny" in alert view.
 @code          [[AOPermissionsKit sharedInstance] setDeniedFromAlertBlockKit:^{}];
 @endcode
 */
@property (nonatomic, readwrite) AccessDeniedFromAlertBlock deniedFromAlertBlockKit;

/*!
 @brief         Singleton AOPermissionKit
 @discussion    Use for call AOPermissionKit methods.
 @code          [AOPermissionsKit sharedInstance];
 @endcode
 */
+ (AOPermissionsKit *)shared;

/*!
 @brief         Check access to camera
 @discussion    Use for check on camera access, with access blocks.
 @code          [[AOPermissionsKit sharedInstance] checkCameraAccess];
 @endcode
 */
- (void)checkCameraAccess;

/*!
 @brief         Check access to microphone
 @discussion    Use for check on microphone access, with access blocks.
 @code          [[AOPermissionsKit sharedInstance] checkMicrophoneAccess];
 @endcode
 */
- (void)checkMicrophoneAccess;

/*!
 @brief         Check access to photo library.
 @discussion    Use for check on photo library access, with access blocks.
 @code          [[AOPermissionsKit sharedInstance] checkPhotoLibraryAccess];
 @endcode
 */
- (void)checkPhotoLibraryAccess;

/*!
 @brief         Check access to calendar.
 @code          [[AOPermissionsKit sharedInstance] checkCalendarAccess];
 @endcode
 */
- (void)checkCalendarAccess;

/*!
 @brief         Check access to reminders.
 @code          [[AOPermissionsKit sharedInstance] checkRemindersAccess];
 @endcode
 */
- (void)checkRemindersAccess;

/*!
 @brief         Check access to contacts.
 @code          [[AOPermissionsKit sharedInstance] checkContactsAccess];
 @endcode
 */
- (void)checkContactsAccess;

/*!
 @brief         Check access to location (when use).
 @code          [[AOPermissionsKit sharedInstance] checkLocationWhenUseAccess];
 @endcode
 */
- (void)checkLocationWhenUseAccess;

/*!
 @brief         Check access to location (always).
 @code          [[AOPermissionsKit sharedInstance] checkLocationAlwaysAccess];
 @endcode
 */
- (void)checkLocationAlwaysAccess;

/*!
 @brief         'Go to settings' alert method
 @discussion    If you lazy - use this mothod :)
 @code
 [[AOPermissionsKit sharedInstance] goToSettingsAlertWithTitle:<#(NSString *)alertTitle#>
 alertMessage:<#(NSString * _Nullable)alertMessage#>
 buttonTitle:<#(NSString * _Nonnull)buttonTitle#>
 cancelButtonTitle:<#(NSString *)cancelButtonTitle#>];
 @endcode
 */
- (void)goToSettingsAlertWithTitle:(NSString *)alertTitle alertMessage:(NSString * _Nullable)alertMessage buttonTitle:(NSString * _Nonnull)buttonTitle cancelButtonTitle:(NSString *)cancelButtonTitle;

/*!
 @brief         'Go to settings' action sheet method
 @discussion    If you lazy - use this mothod :)
 @code
 [[AOPermissionsKit sharedInstance] goToSettingsActionSheetWithTitle:<#(NSString *)alertTitle#>
 alertMessage:<#(NSString * _Nullable)alertMessage#>
 buttonTitle:<#(NSString * _Nonnull)buttonTitle#>
 cancelButtonTitle:<#(NSString *)cancelButtonTitle#>];
 @endcode
 */
+ (void)goToSettingsActionSheetWithTitle:(NSString * _Nonnull)alertTitle alertMessage:(NSString * _Nonnull)alertMessage buttonTitle:(NSString * _Nonnull)buttonTitle cancelButtonTitle:(NSString *)cancelButtonTitle;
@end
