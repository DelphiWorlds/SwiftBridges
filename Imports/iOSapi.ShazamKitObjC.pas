unit iOSapi.ShazamKitObjC;

interface

uses
  Macapi.ObjectiveC, Macapi.CoreFoundation,
  iOSapi.CocoaTypes, iOSapi.Foundation;

type
  SHLibraryOC = interface;
  SHManagedSessionOC = interface;
  SHMediaItemOC = interface;
  SHSessionResultOC = interface;
  SHCatalogOC = interface;
  SHMatchOC = interface;
  SHSignatureOC = interface;

  TSHLibraryOCBlockMethod1 = procedure(error: NSError) of object;
  TSHManagedSessionOCBlockMethod1 = procedure of object;
  TSHManagedSessionOCBlockMethod2 = procedure(result: SHSessionResultOC) of object;

  SHLibraryOCClass = interface(NSObjectClass)
    ['{723A7965-8C8A-4450-A949-FFAF6F4284BE}']
    {class} function defaultLibrary: SHLibraryOC; cdecl;
  end;

  SHLibraryOC = interface(NSObject)
    ['{969908BF-5774-4A22-BEB7-1F6C25FBF628}']
    procedure addItems(items: NSArray; completion: TSHLibraryOCBlockMethod1); cdecl;
    function items: NSArray; cdecl;
    procedure removeItems(items: NSArray; completion: TSHLibraryOCBlockMethod1); cdecl;
  end;
  TSHLibraryOC = class(TOCGenericImport<SHLibraryOCClass, SHLibraryOC>) end;

  SHManagedSessionOCClass = interface(NSObjectClass)
    ['{B38E49A5-682D-4BA4-B768-419093808F3B}']
    {class} function stateIdle: NSInteger; cdecl;
    {class} function stateMatching: NSInteger; cdecl;
    {class} function statePrerecording: NSInteger; cdecl;
  end;

  SHManagedSessionOC = interface(NSObject)
    ['{F0DEAB2C-F461-4D4A-A5A5-865507CB62B8}']
    procedure cancel; cdecl;
    function initWithCatalog(catalog: SHCatalogOC): Pointer; cdecl;
    procedure prepareWithCompletion(completion: TSHManagedSessionOCBlockMethod1); cdecl;
    procedure resultWithCompletion(completion: TSHManagedSessionOCBlockMethod2); cdecl;
    function state: NSInteger; cdecl;
  end;
  TSHManagedSessionOC = class(TOCGenericImport<SHManagedSessionOCClass, SHManagedSessionOC>) end;

  SHMediaItemOCClass = interface(NSObjectClass)
    ['{3253D7FC-BD72-404E-86CD-E08CA3CBE44E}']
  end;

  SHMediaItemOC = interface(NSObject)
    ['{44DD52E5-9910-439A-8BA3-ADF58E2DC769}']
    function appleMusicID: NSString; cdecl;
    function appleMusicURL: NSURL; cdecl;
    function artist: NSString; cdecl;
    function artworkURL: NSURL; cdecl;
    function frequencySkewRanges: NSArray; cdecl;
    function id: NSUUID; cdecl;
    function isrc: NSString; cdecl;
    function shazamID: NSString; cdecl;
    function songs: NSArray; cdecl;
    function subtitle: NSString; cdecl;
    function timeRanges: NSArray; cdecl;
    function title: NSString; cdecl;
    function videoURL: NSURL; cdecl;
    function webURL: NSURL; cdecl;
  end;
  TSHMediaItemOC = class(TOCGenericImport<SHMediaItemOCClass, SHMediaItemOC>) end;

  SHSessionResultOCClass = interface(NSObjectClass)
    ['{FE0E3DD0-B113-4E5F-BE5E-5D44C01E3F53}']
  end;

  SHSessionResultOC = interface(NSObject)
    ['{E84C7020-E57F-453D-9DFC-D4438D51C0DC}']
    function error: NSError; cdecl;
    function isError: Boolean; cdecl;
    function isMatch: Boolean; cdecl;
    function isNoMatch: Boolean; cdecl;
    function match: SHMatchOC; cdecl;
    function signature: SHSignatureOC; cdecl;
  end;
  TSHSessionResultOC = class(TOCGenericImport<SHSessionResultOCClass, SHSessionResultOC>) end;

  SHCatalogOCClass = interface(NSObjectClass)
    ['{2CAF6618-05F2-4E85-988C-153D73D5A41E}']
  end;

  SHCatalogOC = interface(NSObject)
    ['{789A418D-A9F6-4E20-8AE3-AC98CDF3EFF8}']
  end;
  TSHCatalogOC = class(TOCGenericImport<SHCatalogOCClass, SHCatalogOC>) end;

  SHMatchOCClass = interface(NSObjectClass)
    ['{D8F4F0F8-2181-4174-859E-787813807E56}']
  end;

  SHMatchOC = interface(NSObject)
    ['{6242714C-5F6E-408E-AF7C-E59FC4D33740}']
    function mediaItems: NSArray; cdecl;
  end;
  TSHMatchOC = class(TOCGenericImport<SHMatchOCClass, SHMatchOC>) end;

  SHSignatureOCClass = interface(NSObjectClass)
    ['{92F672FC-4A2D-46CD-9088-9D8C5ED878A2}']
  end;

  SHSignatureOC = interface(NSObject)
    ['{F06EF5A4-6F1D-445A-B43E-8036D1C32A2B}']
  end;
  TSHSignatureOC = class(TOCGenericImport<SHSignatureOCClass, SHSignatureOC>) end;

implementation

uses
//  Posix.Dlfcn,
  iOSapi.SwiftCompat;

const
  libMusicKit = '/System/Library/Frameworks/MusicKit.framework/MusicKit';
  libShazamKit = '/System/Library/Frameworks/ShazamKit.framework/ShazamKit';

var
  ShazamKitModule: THandle;

procedure libswiftAVFoundation; cdecl; external '/usr/lib/swift/libswiftAVFoundation.dylib';
procedure libswiftCoreAudioLoader; cdecl; external '/usr/lib/swift/libswiftCoreAudio.dylib';
procedure libswiftCoreMediaLoader; cdecl; external '/usr/lib/swift/libswiftCoreMedia.dylib';
procedure libswiftCoreMIDILoader; cdecl; external '/usr/lib/swift/libswiftCoreMIDI.dylib';
procedure libswiftsimdLoader; cdecl; external '/usr/lib/swift/libswiftsimd.dylib';

procedure MusicKitLoader; cdecl; external libMusicKit;
procedure ShazamKitLoader; cdecl; external libShazamKit;
procedure ShazamKitObjCLoader; cdecl; external framework 'ShazamKitObjC';

//initialization
//  ShazamKitModule := dlopen(MarshaledAString(libShazamKit), RTLD_LAZY);
//
//finalization
//  dlclose(ShazamKitModule);

end.