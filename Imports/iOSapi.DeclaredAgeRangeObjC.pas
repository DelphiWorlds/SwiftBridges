unit iOSapi.DeclaredAgeRangeObjC;

interface

uses
  Macapi.ObjectiveC, Macapi.CoreFoundation,
  iOSapi.CocoaTypes, iOSapi.Foundation, iOSapi.UIKit;

const
  AgeRangeDeclarationNone = -1;
  AgeRangeDeclarationSelfDeclared = 0;
  AgeRangeDeclarationGuardianDeclared = 1;
  AgeRangeDeclarationCheckedByOtherMethod = 2;
  AgeRangeDeclarationGuardianCheckedByOtherMethod = 3;
  AgeRangeDeclarationGovernmentIDChecked = 4;
  AgeRangeDeclarationGuardianGovernmentIDChecked = 5;
  AgeRangeDeclarationPaymentChecked = 6;
  AgeRangeDeclarationGuardianPaymentChecked = 7;
  AgeRangeDeclarationUnknown = 999;

type
  AgeRangeOC = interface;
  AgeRangeResponseOC = interface;
  DeclaredAgeRangeOC = interface;
  ParentalControlsOC = interface;

  AgeRangeDeclaration = NSInteger;
  TDeclaredAgeRangeOCBlockMethod1 = procedure(response: AgeRangeResponseOC; error: NSError) of object;
  TDeclaredAgeRangeOCBlockMethod2 = procedure(eligible: Boolean; error: NSError) of object;

  AgeRangeOCClass = interface(NSObjectClass)
    ['{CD8A4055-94CA-4D84-A0E2-933640B23A98}']
  end;

  AgeRangeOC = interface(NSObject)
    ['{6CF52BD0-1B77-4300-88F5-608E4A293AF5}']
    function activeParentalControls: ParentalControlsOC; cdecl;
    function ageRangeDeclaration: NSNumber; cdecl;
    function ageRangeDeclarationType: AgeRangeDeclaration; cdecl;
    function lowerBound: NSNumber; cdecl;
    function upperBound: NSNumber; cdecl;
  end;
  TAgeRangeOC = class(TOCGenericImport<AgeRangeOCClass, AgeRangeOC>) end;

  AgeRangeResponseOCClass = interface(NSObjectClass)
    ['{509347EF-D5A0-4E6D-82C9-C1A87BA4EE9C}']
  end;

  AgeRangeResponseOC = interface(NSObject)
    ['{C5706020-9649-454C-AC30-521571C159A3}']
    function declinedSharing: Boolean; cdecl;
    function sharedRange: AgeRangeOC; cdecl;
  end;
  TAgeRangeResponseOC = class(TOCGenericImport<AgeRangeResponseOCClass, AgeRangeResponseOC>) end;

  DeclaredAgeRangeOCClass = interface(NSObjectClass)
    ['{29F17DFF-15B3-474E-A6FE-5E86DBEB5940}']
    {class} function shared: DeclaredAgeRangeOC; cdecl;
  end;

  DeclaredAgeRangeOC = interface(NSObject)
    ['{C4E97C9C-EE91-486E-A499-ED81A258CA08}']
    procedure isEligibleForAgeFeaturesWithCompletion(completion: TDeclaredAgeRangeOCBlockMethod2); cdecl;
    procedure requestAgeRangeWithThreshold(threshold1: NSInteger; threshold2: NSInteger; threshold3: NSInteger; viewController: UIViewController;
      completion: TDeclaredAgeRangeOCBlockMethod1); cdecl;
  end;
  TDeclaredAgeRangeOC = class(TOCGenericImport<DeclaredAgeRangeOCClass, DeclaredAgeRangeOC>) end;

  ParentalControlsOCClass = interface(NSObjectClass)
    ['{90684E10-7A40-400F-B06E-6FD702EF5945}']
    {class} function communicationLimits: ParentalControlsOC; cdecl;
    {class} function significantAppChangeApprovalRequired: ParentalControlsOC; cdecl;
  end;

  ParentalControlsOC = interface(NSObject)
    ['{F63BFC72-C544-4D11-AD82-CBA5B2105DF1}']
    function communicationLimits: Boolean; cdecl;
    function initWithRawValue(rawValue: NSInteger): Pointer; cdecl;
    function rawValue: NSInteger; cdecl;
    function significantAppChangeApprovalRequired: Boolean; cdecl;
  end;
  TParentalControlsOC = class(TOCGenericImport<ParentalControlsOCClass, ParentalControlsOC>) end;

implementation

uses
  iOSapi.SwiftCompat;

const
  libDeclaredAgeRange = '/System/Library/Frameworks/DeclaredAgeRange.framework/DeclaredAgeRange';

procedure libswiftsimdLoader; cdecl; external '/usr/lib/swift/libswiftsimd.dylib';
procedure libswiftSpatialLoader; cdecl; external '/usr/lib/swift/libswiftSpatial.dylib';

procedure CLangRTLoader; cdecl; external '/usr/lib/clang/lib/darwin/libclang_rt.ios.a';
procedure DeclaredAgeRangeLoader; cdecl; external libDeclaredAgeRange;
procedure DeclaredAgeRangeObjCLoader; cdecl; external framework 'DeclaredAgeRangeObjC';

end.