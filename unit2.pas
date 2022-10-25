unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ShellAPI, Windows;

type

  { TForm2 }

  TForm2 = class(TForm)
    ImageSuper: TImage;
    ImageSushi: TImage;
    ImagePachi1: TImage;
    ImageKaden: TImage;
    ImageButsudan: TImage;
    ImageWare: TImage;
    ImagePachi2: TImage;
    Imagecar: TImage;
    Label1: TLabel;
    Label2: TLabel;
    LabelURL: TLabel;
    LabelVersion: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ImageSuperClick(Sender: TObject);
    procedure LabelURLClick(Sender: TObject);
    procedure LabelURLDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LabelURLMouseEnter(Sender: TObject);
    procedure LabelURLMouseLeave(Sender: TObject);
    procedure LabelURLMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

function GetSelfVersion: String;
var
  VerInfoSize  : DWORD;
  VerInfo      : Pointer;
  VerValueSize : DWORD;
  VerValue     : PVSFixedFileInfo;
  Dummy        : DWORD;
begin
  VerInfoSize := GetFileVersionInfoSize( PChar(ParamStr(0)), Dummy );

  GetMem(VerInfo, VerInfoSize);
  try
    GetFileVersionInfo( PChar(ParamStr(0)), 0, VerInfoSize, VerInfo );
    VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);

    with VerValue^ do begin
      Result := Format('Ver %d.%d.%d' , [(dwFileVersionMS shr 16)
                                          , (dwFileVersionMS and $FFFF)
                                          , (dwFileVersionLS shr 16)])
    end;
  finally
    FreeMem(VerInfo, VerInfoSize);
  end;
end;

{ TForm2 }

procedure TForm2.ImageSuperClick(Sender: TObject);
begin

end;

procedure TForm2.LabelURLClick(Sender: TObject);
begin
  ShellExecute(Self.Handle, 'open', PChar('https://nelog.jp/chirashi'),
        '', '', SW_SHOWNORMAL);
end;

procedure TForm2.LabelURLDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin

end;

procedure TForm2.LabelURLMouseEnter(Sender: TObject);
begin
  LabelURL.Font.Color:=clRed;
end;

procedure TForm2.LabelURLMouseLeave(Sender: TObject);
begin
  LabelURL.Font.Color:=clBlue;
end;

procedure TForm2.LabelURLMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin

end;

procedure TForm2.FormCreate(Sender: TObject);
var
  r: Integer;
begin
  LabelVersion.Caption := GetSelfVersion();

  Randomize;
  r := Random(99);
  if (r = 0) then begin
    // 1/100
    ImageButsudan.Align := alClient;
    ImageButsudan.Visible := True;
  end else if (r <= 1) and (r <= 2) then begin
   // 2/100
    ImagePachi2.Align := alClient;
    ImagePachi2.Visible := True;
  end else if (r <= 3) and (r <= 5) then begin
    // 3/100
    ImageSushi.Align := alClient;
    ImageSushi.Visible := True;
  end else if (r <= 6) and (r <= 9) then begin
    // 4/100
    ImageCar.Align := alClient;
    ImageCar.Visible := True;
  end else if (r <= 10) and (r <= 14) then begin
    // 5/100
    ImageKaden.Align := alClient;
    ImageKaden.Visible := True;
  end else if (r <= 15) and (r <= 19) then begin
    // 5/100
    ImageWare.Align := alClient;
    ImageWare.Visible := True;
  end else if (r <= 20) and (r <= 29) then begin
    // 10/100
    ImagePachi1.Align := alClient;
    ImagePachi1.Visible := True;
  end else begin
    // 70/100
    ImageSuper.Align := alClient;
    ImageSuper.Visible := True;
  end;
end;

end.

