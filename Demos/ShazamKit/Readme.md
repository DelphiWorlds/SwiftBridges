# ShazamKitObjC demo

Demonstrates how to use the `ShazamKitObjC` bridging framework, which bridges the Swift-only framework `ShazamKit`

## Requirements

### Mandatory

The following are required regardless of whether you are using the demo, or in your own project:

#### ShazamKit entitlement

In order for `ShazamKitObjC` to work, the provisioning profile that is used when compiling the project needs to be associated with an App ID that has the ShazamKit entitlement.

To do this:

1. Go to your [Apple Developer account](https://developer.apple.com/account)
2. Under Certificates, IDs and Profiles, go to the `Identifiers` list
3. Either edit an existing identifier that you can add the entitlement to, or create a new one
4. When presented with the editing page, click the `App Services` tab
5. Ensure that `ShazamKit` is checked, and complete editing of the App ID
6. Go to the `Profiles` page
7. Either edit an existing profile that is associated with the App ID, or create a new one. (Editing is required when an App ID is changed)

Once you have completed adding/editing the App ID and Profile:

1. Open Xcode on the Mac
2. In the Xcode menu, select `Settings`
3. Select `Apple Accounts` from the list on the left
4. Select the account relevant to the App ID and Profile
5. If you are associated with more than one team, select the relevant team
6. Click the `Download Manual Profiles` button
7. Restart `PAServer` on the Mac - this is necessary as `PAServer` appears to have problems when profiles have changed

In Delphi:

1. Open the Project Options dialog for the project
2. Select `Application > Version Info`
3. In the `Target` combo, select: `All Configurations - iOS Device 64-bit platform`
4. In the `CFBundleIdentifier` value, enter the identifier for the App ID
5. Click Save

#### Adding Swift compatibility

Swift compatibility files need to be added to the iOS SDK in order to use the framework.

[See these instructions](https://github.com/DelphiWorlds/HowTo/blob/main/Solutions/AddSwiftSupport/Readme.md) on how to add these files to the iOS SDK.

#### Additional Frameworks

The following frameworks need to be added to the iOS SDK you are building against:

- MusicKit
- ShazamKit

[These are some instructions](https://github.com/DelphiWorlds/HowTo/blob/main/Solutions/AddSDKFrameworks/ReadMe.md) about how to add them

### Configuration in your own project

The following are required if using the framework in your own project, in the Project Options:

#### Search path

This value will need to include any imports relevant to the framework, and dependencies of that import. The demo requires

- iOSapi.ShazamKitObjC.pas
- iOSapi.SwiftCompat.pas

Which are in the `Imports` folder of the repo.

#### Framework search path (Building > Delphi Compiler)

Set this value to a path where the `ShazamKitObjC.framework` folder is located. In the repo, this is in the `Frameworks` folder

#### Options passed to the LD linker (Building > Delphi Compiler > Linking)

Set this value to:

```
-ObjC -rpath /usr/lib/swift -weak_library /usr/lib/swift/libswift_Concurrency.dylib -weak_library /usr/lib/swift/libswift_StringProcessing.dylib -weak_library /usr/lib/swift/libswiftDataDetection.dylib -weak_library /usr/lib/swift/libswiftFileProvider.dylib -weak_library /usr/lib/swift/libswiftOSLog.dylib -weak_library /usr/lib/swift/libswiftXPC.dylib
```