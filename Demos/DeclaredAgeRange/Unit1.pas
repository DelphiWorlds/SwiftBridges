unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  iOSapi.DeclaredAgeRangeObjC, iOSapi.Foundation;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure DoRequestAgeRange;
    procedure IsEligibleForAgeFeaturesCompletionHandler(eligible: Boolean; error: NSError);
    procedure RequestAgeRange(const AThreshold1, AThreshold2, AThreshold3: Integer);
    procedure RequestAgeRangeCompletionHandler(response: AgeRangeResponseOC; error: NSError);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses
  iOSapi.Helpers;

type
  TAgeRangeDeclaration = (
    None,
    SelfDeclared,
    GuardianDeclared,
    CheckByOtherMethod,
    GuardianCheckedByOtherMethod,
    GovernmentIDChecked,
    GuardianGovernmentIDChecked,
    PaymentChecked,
    GuardianPaymentChecked,
    Unknown
  );

const
  cAgeRangeDeclarationCaptions: array[TAgeRangeDeclaration] of string = (
    'No age range declaration exists',
    'The user signed in to iCloud to set their own age range',
    'A parent, guardian, or Family Organizer in a Family Sharing group set the age range',
    'The user set their age range using an unspecified method',
    'A parent, guardian, or Family Organizer in a Family Sharing group set the age range using an unspecified method',
    'The user set their age range using a government ID',
    'A parent, guardian, or Family Organizer in a Family Sharing group set the age range using a government ID',
    'The user set their age range using a payment method',
    'A parent, guardian, or Family Organizer in a Family Sharing group set the age range using a payment method',
    'The age range declaration method is unknown'
  );

function GetAgeRangeDeclaration(const ADeclarationType: AgeRangeDeclaration): TAgeRangeDeclaration;
begin
  case ADeclarationType of
    AgeRangeDeclarationNone:
      Result := TAgeRangeDeclaration.None;
    AgeRangeDeclarationSelfDeclared:
      Result := TAgeRangeDeclaration.SelfDeclared;
    AgeRangeDeclarationGuardianDeclared:
      Result := TAgeRangeDeclaration.GuardianDeclared;
    AgeRangeDeclarationCheckedByOtherMethod:
      Result := TAgeRangeDeclaration.GuardianCheckedByOtherMethod;
    AgeRangeDeclarationGuardianCheckedByOtherMethod:
      Result := TAgeRangeDeclaration.GuardianCheckedByOtherMethod;
    AgeRangeDeclarationGovernmentIDChecked:
      Result := TAgeRangeDeclaration.GovernmentIDChecked;
    AgeRangeDeclarationGuardianGovernmentIDChecked:
      Result := TAgeRangeDeclaration.None;
    AgeRangeDeclarationPaymentChecked:
      Result := TAgeRangeDeclaration.PaymentChecked;
    AgeRangeDeclarationGuardianPaymentChecked:
      Result := TAgeRangeDeclaration.GuardianPaymentChecked;
  else
    Result := TAgeRangeDeclaration.Unknown;
  end;
end;

function DeclaredAgeRange: DeclaredAgeRangeOC;
begin
  Result := TDeclaredAgeRangeOC.OCClass.shared;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  if TOSVersion.Check(26, 2) then
  begin
    Memo1.Lines.Add('iOS 26.2 Detected.'#13#10'Calling isEligibleForAgeFeaturesWithCompletion');
    DeclaredAgeRange.isEligibleForAgeFeaturesWithCompletion(IsEligibleForAgeFeaturesCompletionHandler);
  end
  else
    DoRequestAgeRange;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Memo1.Lines.Clear;
  DoRequestAgeRange;
end;

procedure TForm1.IsEligibleForAgeFeaturesCompletionHandler(eligible: Boolean; error: NSError);
begin
  if eligible then
  begin
    Memo1.Lines.Add('Eligible');
    DoRequestAgeRange;
  end
  else
    Memo1.Lines.Add('Not eligible for age features.'#13#10'Probably not in Texas, or other places');
end;

procedure TForm1.RequestAgeRange(const AThreshold1, AThreshold2, AThreshold3: Integer);
begin
  DeclaredAgeRange.requestAgeRangeWithThreshold(AThreshold1, AThreshold2, AThreshold3,
    TiOSHelper.SharedApplication.keyWindow.rootViewController, RequestAgeRangeCompletionHandler);
end;

procedure TForm1.RequestAgeRangeCompletionHandler(response: AgeRangeResponseOC; error: NSError);
var
  LDeclaration: TAgeRangeDeclaration;
begin
  // Beware #1: If declinedSharing is True, response.sharedRange will be NIL!
  if not response.declinedSharing then
  begin
    if response.sharedRange.activeParentalControls.communicationLimits then
      Memo1.Lines.Add('Communication limits are imposed');
    if response.sharedRange.activeParentalControls.significantAppChangeApprovalRequired then
      Memo1.Lines.Add('Approval is required for significant app changes');
    LDeclaration := GetAgeRangeDeclaration(response.sharedRange.ageRangeDeclarationType);
    Memo1.Lines.Add(cAgeRangeDeclarationCaptions[LDeclaration]);
    // Beware #2: If there is no upper bound, response.sharedRange.upperBound will be NIL!
    if response.sharedRange.upperBound <> nil then
      Memo1.Lines.Add(Format('Age Range - Lower: %d, Upper: %d', [response.sharedRange.lowerBound.integerValue, response.sharedRange.upperBound.integerValue]))
    else
      Memo1.Lines.Add(Format('Age Range - %d+', [response.sharedRange.lowerBound.integerValue]));
  end
  else
    Memo1.Lines.Add('The user declined sharing their age range');
end;

procedure TForm1.DoRequestAgeRange;
begin
  if TOSVersion.Check(26) then
  begin
    Memo1.Lines.Add('Requesting age range..');
    RequestAgeRange(13, 16, 18);
  end
  else
    Memo1.Lines.Add('Device does not have iOS 26 or later');
end;

end.
