//
//  AOPermissionsKitModel.m
//  AOPermissionsKitModel
//
//  Created by Alexander Orlov on 08.10.2018.
//  Copyright © 2018 Alexander Orlov. All rights reserved.
//

#import "AOPermissionsKitModel.h"
#import "AOPermissionsKit.h"

@implementation AOPermissionsKitModel
#pragma mark - Singleton model
+ (AOPermissionsKitModel *)sharedModel {
    static AOPermissionsKitModel *_sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedModel = [[AOPermissionsKitModel alloc] init];
    });
    
    return _sharedModel;
}

#pragma mark - Check camera access
+ (void)checkCameraAccessModel {
    __weak typeof(self)weakSelf = self;
    [[weakSelf sharedModel] checkInfoPlistByType:AOPermissionsKitAccessCamera];
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    switch (authStatus) {
        case AVAuthorizationStatusAuthorized:
                [weakSelf sharedModel].grantedBlock();
            break;
        case AVAuthorizationStatusNotDetermined: {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted)
             {
                 if(granted)
                 {
                     [weakSelf sharedModel].grantedFromAlertBlock();
                 }
                 else
                 {
                     [weakSelf sharedModel].deniedFromAlertBlock();
                 }
             }];
            break;
        }
        case AVAuthorizationStatusDenied:
            [weakSelf sharedModel].deniedBlock();
            break;
        default:
            break;
    }
}

#pragma mark - Check microphone access
+ (void)checkMicrophoneAccessModel {
    __weak typeof(self)weakSelf = self;
    [[weakSelf sharedModel] checkInfoPlistByType:AOPermissionsKitAccessMicrophone];
    AVAudioSessionRecordPermission permissionStatus = [[AVAudioSession sharedInstance] recordPermission];
    
    switch (permissionStatus) {
        case AVAudioSessionRecordPermissionUndetermined:{
            [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                // CALL YOUR METHOD HERE - as this assumes being called only once from user interacting with permission alert!
                if (granted) {
                    // Microphone enabled code
                    [weakSelf sharedModel].grantedFromAlertBlock();
                }
                else {
                    // Microphone disabled code
                    [weakSelf sharedModel].deniedFromAlertBlock();
                }
            }];
            break;
        }
        case AVAudioSessionRecordPermissionDenied:
            // direct to settings...
            [weakSelf sharedModel].deniedBlock();
            break;
        case AVAudioSessionRecordPermissionGranted:
            // mic access ok...
            [weakSelf sharedModel].grantedBlock();
            break;
        default:
            // this should not happen.. maybe throw an exception.
            break;
    }
}

#pragma mark - Check photo library access
+ (void)checkPhotoLibraryAccessModel {
    __weak typeof(self)weakSelf = self;
    [[weakSelf sharedModel] checkInfoPlistByType:AOPermissionsKitAccessPhotoLibrary];
//    dispatch_async(dispatch_get_main_queue(), ^{
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusAuthorized)
        {
            //We have permission. Do whatever is needed
            [weakSelf sharedModel].grantedBlock();
        }
        else if (status == PHAuthorizationStatusNotDetermined)
        {
            //No permission. Trying to normally request it
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    [weakSelf sharedModel].grantedFromAlertBlock();
                }
                else {
                    [weakSelf sharedModel].deniedFromAlertBlock();
                }
            }];
        }
        else if (status == PHAuthorizationStatusDenied) {
            [weakSelf sharedModel].deniedBlock();
        }
//    });
}

#pragma mark - Check calendar access
+ (void)checkCalendarAccessModel {
    __weak typeof(self)weakSelf = self;
    [[weakSelf sharedModel] checkInfoPlistByType:AOPermissionsKitAccessCalendar];
//    dispatch_async(dispatch_get_main_queue(), ^{
        EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
        if (status == EKAuthorizationStatusAuthorized) {
            [weakSelf sharedModel].grantedBlock();
        }
        else if (status == EKAuthorizationStatusNotDetermined) {
            EKEventStore *store = [EKEventStore new];
            [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                if (!granted) {
                    [weakSelf sharedModel].grantedFromAlertBlock();
                }
                else {
                    [weakSelf sharedModel].deniedFromAlertBlock();
                }
            }];
        }
        else if (status == EKAuthorizationStatusDenied) {
            [weakSelf sharedModel].deniedBlock();
        }
//    });
}

#pragma mark - Check reminder access
+ (void)checkRemindersAccessModel {
    __weak typeof(self)weakSelf = self;
    [[weakSelf sharedModel] checkInfoPlistByType:AOPermissionsKitAccessReminders];
//    dispatch_async(dispatch_get_main_queue(), ^{
        EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
        if (status == EKAuthorizationStatusAuthorized) {
            [weakSelf sharedModel].grantedBlock();
        }
        else if (status == EKAuthorizationStatusNotDetermined) {
            EKEventStore *store = [EKEventStore new];
            [store requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
                if (!granted) {
                    [weakSelf sharedModel].grantedFromAlertBlock();
                }
                else {
                    [weakSelf sharedModel].deniedFromAlertBlock();
                }
            }];
        }
        else if (status == EKAuthorizationStatusDenied) {
            [weakSelf sharedModel].deniedBlock();
        }
//    });
}

#pragma mark - Check contacts access
+ (void)checkContactsAccessModel {
    __weak typeof(self)weakSelf = self;
    [[weakSelf sharedModel] checkInfoPlistByType:AOPermissionsKitAccessContacts];
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (status == CNAuthorizationStatusAuthorized) {
        [weakSelf sharedModel].grantedBlock();
    }
    else if (status == CNAuthorizationStatusNotDetermined) {
        CNContactStore *store = [CNContactStore new];
        [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                [weakSelf sharedModel].grantedFromAlertBlock();
            }
            else {
                [weakSelf sharedModel].deniedFromAlertBlock();
            }
        }];
    }
    else if (status == CNAuthorizationStatusDenied) {
        [weakSelf sharedModel].deniedBlock();
    }
}

#pragma mark - Check location (when use) access
+ (void)checkLocationWhenUseModel {
    __strong __typeof(self)strongSelf = self;
    [[strongSelf sharedModel] checkInfoPlistByType:AOPermissionsKitAccessLocationWhenUse];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        CLLocationManager *manager = [[CLLocationManager alloc] init];
        [manager requestWhenInUseAuthorization];
        [manager startUpdatingLocation];
    }
    else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [strongSelf sharedModel].grantedFromAlertBlock();
    }
//    else if (status == kCLAuthorizationStatusDenied) {
//        [weakSelf sharedModel].deniedBlock();
//    }
}

#pragma mark - Check location (always) access
+ (void)checkLocationAlwaysModel {
    __strong __typeof(self)strongSelf = self;
    [[strongSelf sharedModel] checkInfoPlistByType:AOPermissionsKitAccessLocationAlways];
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        CLLocationManager *manager = [[CLLocationManager alloc] init];
        [manager requestAlwaysAuthorization];
        [manager startUpdatingLocation];
    }
    else if (status == kCLAuthorizationStatusAuthorizedAlways) {
        [strongSelf sharedModel].grantedFromAlertBlock();
    }
    else if (status == kCLAuthorizationStatusDenied) {
        [strongSelf sharedModel].deniedBlock();
    }
}

#pragma mark - Private helpers
#pragma mark Check Info.plist by type
- (void)checkInfoPlistByType:(AOPermissionsKitAccess)accessType {
    if (accessType == AOPermissionsKitAccessCamera) {
        NSAssert([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSCameraUsageDescription"]!=nil,@"'NSCameraUsageDescription' need to add in Info.plist.");
    }
    if (accessType == AOPermissionsKitAccessMicrophone) {
        NSAssert([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSMicrophoneUsageDescription"]!=nil,@"'NSMicrophoneUsageDescription' need to add in Info.plist.");
    }
    if (accessType == AOPermissionsKitAccessPhotoLibrary) {
        NSAssert([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSPhotoLibraryUsageDescription"]!=nil,@"'NSPhotoLibraryUsageDescription' need to add in Info.plist.");
    }
    if (accessType == AOPermissionsKitAccessCalendar) {
        NSAssert([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSCalendarsUsageDescription"]!=nil,@"'NSCalendarsUsageDescription' need to add in Info.plist.");
    }
    if (accessType == AOPermissionsKitAccessReminders) {
        NSAssert([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSRemindersUsageDescription"]!=nil,@"'NSRemindersUsageDescription' need to add in Info.plist.");
    }
    if (accessType == AOPermissionsKitAccessContacts) {
        NSAssert([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSContactsUsageDescription"]!=nil,@"'NSContactsUsageDescription' need to add in Info.plist.");
    }
    if (accessType == AOPermissionsKitAccessLocationWhenUse) {
        NSAssert([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]!=nil,@"'NSLocationWhenInUseUsageDescription' need to add in Info.plist.");
    }
    if (accessType == AOPermissionsKitAccessLocationAlways) {
        NSAssert([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]!=nil,@"'NSLocationAlwaysUsageDescription' need to add in Info.plist.");
    }
}

#pragma mark Go to settings alert
+ (void)goToSettingsAlertWithTitleModel:(NSString * _Nonnull)alertTitle alertMessage:(NSString * _Nonnull)alertMessage buttonTitle:(NSString * _Nonnull)buttonTitle cancelButtonTitle:(NSString *)cancelButtonTitle {
    NSAssert(![alertTitle isEqualToString:@""],@"'alertTitle' not may be empty, null (nil) string.");
    NSAssert(![alertMessage isEqualToString:@""],@"'alertMessage' not may be empty, null (nil) string.");
    NSAssert(![buttonTitle isEqualToString:@""],@"'buttonTitle' not may be empty, null (nil) string.");
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    [alertController addAction:settingsAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    });
}
#pragma mark Go to settings sheet
+ (void)goToSettingsSheetWithTitleModel:(NSString * _Nonnull)alertTitle alertMessage:(NSString * _Nonnull)alertMessage buttonTitle:(NSString * _Nonnull)buttonTitle cancelButtonTitle:(NSString *)cancelButtonTitle {
    NSAssert(![alertTitle isEqualToString:@""],@"'alertTitle' not may be empty, null (nil) string.");
    NSAssert(![alertMessage isEqualToString:@""],@"'alertMessage' not may be empty, null (nil) string.");
    NSAssert(![buttonTitle isEqualToString:@""],@"'buttonTitle' not may be empty, null (nil) string.");
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    [alertController addAction:settingsAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}
@end
