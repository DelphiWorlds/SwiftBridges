# Swift Bridges

**Delphi-accessible bridges to modern Swift-only Apple frameworks**

## Overview

**Swift Bridges** is a collection of bridging frameworks and Delphi import units that allow Delphi (developers to use modern Apple frameworks that are written exclusively in Swift and therefore not directly accessible from Objective-C (and thus not from Delphi).

Apple has been moving many new APIs to Swift-only frameworks (e.g., SwiftUI, WidgetKit, TipKit, ShazamKit's newer classes). Since Delphi's iOS support is based on Objective-C interoperability, these APIs are normally unavailable to Delphi developers.

This repository provides:
- Xcode projects that create small Objective-C wrapper frameworks around selected Swift-only APIs.
- Ready-to-use Delphi import units (`.pas` files) generated from those wrappers.
- Demo projects showing real-world usage in Delphi apps.

The goal is to make the latest Apple platform features accessible to the Delphi community without requiring a full Swift rewrite.

## Current Bridges

| Framework | Minimum iOS |
|-----------|-------------|
| ShazamKitObjC | iOS 17.0 |

More bridges will be added over time (suggestions welcome!).

## Getting Started

### Prerequisites
- macOS with Xcode (latest recommended).
- Embarcadero Delphi (13 Florence or newer is recommended) 
- An Apple Developer account (required for some features like ShazamKit catalog access).

### Building a Bridge Framework (Xcode)

Most framework binaries/headers will be available in the `Frameworks` folder, however if you wish to build them yourself:

1. Open the desired framework project (e.g., `Bridges/ShazamKitObjC/ShazamKitObjC.xcodeproj`).
2. Build for device (arm64)
3. The resulting `.framework` bundle is ready for use under the folder `~/Library/Developer/Xcode/DerivedData/(FrameworkProjectName)-xxxxxxx` where `(FrameworkProjectName)` is the name of the bridging project (e.g ShazamKitObjC) and `xxxxxxxx` is a unique identifier created by Xcode. Under *that* folder will be `/Build/Products/Debug-iphoneos` where the `.framework` folder is located 
4. Copy the `.framework` folder mentioned in step 3 to a suitable location on your Windows machine for the Delphi compiler to find it using the `Framework search path` value in the Project Options of your Delphi project.

### Using in a Delphi Project

See the demo projects in the `Demos` folder for complete examples, including project configuration requirements.

## Contributing

Contributions are very welcome! Ideas for new bridges, bug fixes, improved wrappers, or additional demos are all appreciated.

Please open an issue first to discuss any major additions, and see the [contributions readme](https://github.com/DelphiWorlds/SwiftBridges/blob/main/Contributions.md) for conventions used in bridging projects in this repo, and other information

## Acknowledgements

- Huge **THANK YOU** to Chris Pimlott, whose [WidgetKit tutirial](https://github.com/MyBuzzTechnologies/WidgetKitObjCDelphi) inspired this work.
- Thanks to [Grok](https://www.grok.com), who worked tirelessly to help generate the Objective-C files for the [ShazamKitObjC Xcode project](https://github.com/DelphiWorlds/SwiftBridges/tree/main/Bridges/ShazamKitObjC) and gave valuable hints for configuring the project.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
