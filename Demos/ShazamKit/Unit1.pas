unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  iOSapi.ShazamKitObjC;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    FSession: SHManagedSessionOC;
    procedure SessionPrepareCompletionHandler;
    procedure SessionResultCompletionHandler(result: SHSessionResultOC);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  iOSapi.Foundation,
  Macapi.Helpers;

procedure TForm1.Button1Click(Sender: TObject);
begin
  // SHLibrary.items;
  if FSession = nil then
  begin
    FSession := TSHManagedSessionOC.Create;
    FSession.prepareWithCompletion(SessionPrepareCompletionHandler);
  end;
  FSession.resultWithCompletion(SessionResultCompletionHandler);
end;

procedure TForm1.SessionPrepareCompletionHandler;
begin
  Memo1.Lines.Add('SessionPrepareCompletionHandler');
end;

procedure TForm1.SessionResultCompletionHandler(result: SHSessionResultOC);
var
  I: Integer;
  LMediaItems: NSArray;
  LMediaItem: SHMediaItemOC;
begin
  if result <> nil then
  begin
    if result.isMatch and (result.match <> nil) and (result.match.mediaItems.count > 0) then
    begin
      LMediaItems := result.match.mediaItems;
      for I := 0 to LMediaItems.count - 1 do
      begin
        LMediaItem := TSHMediaItemOC.Wrap(LMediaItems.objectAtIndex(I));
        Memo1.Lines.Add(Format('Title: %s', [NSStrToStr(LMediaItem.title)]));
        Memo1.Lines.Add(Format('Artist: %s', [NSStrToStr(LMediaItem.artist)]));
      end;
    end
    else
      Memo1.Lines.Add('No match found');
  end;
end;

end.
