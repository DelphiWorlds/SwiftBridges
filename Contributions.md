# Contributions

## Bridging frameworks

The following conventions must be used when creating a bridging framework:

- The project must be named the same as the existing Swift-only framework, and suffixed with `ObjC`, e.g. `ShazamKitObjC`
- The bridging Swift file must be named using the existing Swift-only framework name, suffixed with `Bridge`, e.g. `ShazamKitBridge.swift`
- Objective-C wrapper types must be named the same as in the existing Swift-only framework, suffixed with `OC`, e.g. `SHManagedSessionOC`

These conventions are in place to ensure consistency in the bridging frameworks, and to reflect exactly what they represent, e.g. The wrapper class named `SHManagedSessionOC` is an Objective-C equivalent of the `SHManagedSession` class in the existing Swift-only framework, and `SHManagedSessionSwift` (from `ShazamKitBridge.swift`) is a "conduit" into `SHManagedSession`

## Imports

It is envisaged that when a bridging framework is provided, a matching Delphi import is also provided, using [Octoid](https://github.com/Embarcadero/octoid) so that imports are consistent.

## Demos

Feel free to provide demos for bridging frameworks that do not have one, or make suggestions as to enhancements to existing demos


