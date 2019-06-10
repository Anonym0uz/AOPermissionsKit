//
//  AOPermissionsKitLogic.m
//  AOPermissionsKit
//
//  Created by Alexander Orlov on 10.06.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import "AOPermissionsKit.h"

@implementation AOPermissionsKit
+ (AOPermissionsKit *)shared {
    static AOPermissionsKit *_shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shared = [[AOPermissionsKit alloc] init];
    });
    return _shared;
}

- (void)checkCameraAccess {
    [self setBlocks];
    [AOPermissionsKitModel checkCameraAccessModel];
}

- (void)checkMicrophoneAccess {
    [self setBlocks];
    [AOPermissionsKitModel checkMicrophoneAccessModel];
}

- (void)checkPhotoLibraryAccess {
    [self setBlocks];
    [AOPermissionsKitModel checkPhotoLibraryAccessModel];
}

- (void)checkCalendarAccess {
    [self setBlocks];
    [AOPermissionsKitModel checkCalendarAccessModel];
}

- (void)checkRemindersAccess {
    [self setBlocks];
    [AOPermissionsKitModel checkRemindersAccessModel];
}

- (void)checkContactsAccess {
    [self setBlocks];
    [AOPermissionsKitModel checkContactsAccessModel];
}

- (void)checkLocationWhenUseAccess {
    [self setBlocks];
    [AOPermissionsKitModel checkLocationWhenUseModel];
}

- (void)checkLocationAlwaysAccess {
    [self setBlocks];
    [AOPermissionsKitModel checkLocationAlwaysModel];
}

- (void)goToSettingsAlertWithTitle:(NSString *)alertTitle alertMessage:(NSString * _Nullable)alertMessage buttonTitle:(NSString * _Nonnull)buttonTitle cancelButtonTitle:(NSString *)cancelButtonTitle {
    [AOPermissionsKitModel goToSettingsAlertWithTitleModel:alertTitle
                                              alertMessage:alertMessage
                                               buttonTitle:buttonTitle
                                         cancelButtonTitle:cancelButtonTitle];
}

+ (void)goToSettingsActionSheetWithTitle:(NSString * _Nonnull)alertTitle alertMessage:(NSString * _Nonnull)alertMessage buttonTitle:(NSString * _Nonnull)buttonTitle cancelButtonTitle:(NSString *)cancelButtonTitle {
    [AOPermissionsKitModel goToSettingsSheetWithTitleModel:alertTitle
                                              alertMessage:alertMessage
                                               buttonTitle:buttonTitle
                                         cancelButtonTitle:cancelButtonTitle];
}


- (void)setBlocks {
    if (self.grantedBlockKit != nil) [[AOPermissionsKitModel sharedModel] setGrantedBlock:self.grantedBlockKit];
    else [[AOPermissionsKitModel sharedModel] setGrantedBlock:^{}];
    if (self.deniedBlockKit != nil) [[AOPermissionsKitModel sharedModel] setDeniedBlock:self.deniedBlockKit];
    else [[AOPermissionsKitModel sharedModel] setDeniedBlock:^{}];
    if (self.grantedFromAlertBlockKit != nil) [[AOPermissionsKitModel sharedModel] setGrantedFromAlertBlock:self.grantedFromAlertBlockKit];
    else [[AOPermissionsKitModel sharedModel] setGrantedFromAlertBlock:^{}];
    if (self.deniedFromAlertBlockKit != nil) [[AOPermissionsKitModel sharedModel] setDeniedFromAlertBlock:self.deniedFromAlertBlockKit];
    else [[AOPermissionsKitModel sharedModel] setDeniedFromAlertBlock:^{}];
}
@end
