# AOPermissionsKit
Clear and easy way for ask permissions in your iOS app written on Objective C.

### Usage
For example, you want check access for camera:
First we need call singletone AOPermissionsKit.
```objc
[[AOPermissionsKit shared] checkCameraAccess];
```
If access already denied we can check it by **setDeniedBlockKit** method:
```objc
[[AOPermissionsKit shared] setDeniedBlockKit:^{
NSLog(@"Denied!");
}];
```
Or if access already granted:
```objc
[[AOPermissionsKit shared] setGrantedBlockKit:^{
NSLog(@"Granted!");
}];
```

But what if you want to check access while the user has not yet selected access?
In this case, AOPermissionsKit have 2 blocks, called **setDeniedFromAlertBlockKit** and **setGrantedFromAlertBlockKit**!

We can see what the user chooses:
```objc
[[AOPermissionsKit shared] setGrantedFromAlertBlockKit:^{
NSLog(@"User granted access!");
}];
```
```objc
[[AOPermissionsKit shared] setDeniedFromAlertBlockKit:^{
NSLog(@"User denied access!");
}];
```
### About
AOPermissionsKit is based on a blocks system to make it easier for many users to adapt it for their own purposes.

### Example
AOPermissionsKitExample is in the folder with the project for understanding the operation of this kit.
