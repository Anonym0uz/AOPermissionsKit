//
//  ViewController.m
//  AOPermissionsKitExample
//
//  Created by Alexander Orlov on 10.06.2019.
//  Copyright © 2019 Alexander Orlov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIButton *checkCameraButton;
@property (nonatomic, strong) UIButton *checkPLibraryButton;
@property (nonatomic, strong) UIButton *checkCameraButton;
@property (nonatomic, strong) UIButton *checkCameraButton;
@property (nonatomic, strong) UIButton *checkCameraButton;
@property (nonatomic, strong) UIButton *checkCameraButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AOPermissionsKit shared] setDeniedBlockKit:^{
        [[AOPermissionsKit shared] goToSettingsAlertWithTitle:@"Project Y" alertMessage:@"Go to settings to grand access for camera." buttonTitle:@"Settings" cancelButtonTitle:@"OK"];
    }];
    [[AOPermissionsKit shared] setGrantedBlockKit:^{
        NSLog(@"Granted!");
    }];
    [[AOPermissionsKit shared] setDeniedFromAlertBlockKit:^{
        [[AOPermissionsKit shared] goToSettingsAlertWithTitle:@"Project Y" alertMessage:@"Go to settings to grand access for camera." buttonTitle:@"Settings" cancelButtonTitle:@"OK"];
    }];
    [[AOPermissionsKit shared] checkCameraAccess];
}


@end
