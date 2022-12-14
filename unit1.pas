unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ActnList, StdActns,
  Menus, ComCtrls, RichMemo, ExtIniFile, Windows;

type

  { TForm1 }

  TForm1 = class(TForm)
    ActionVersion: TAction;
    ActionTopMost: TAction;
    ActionFont: TAction;
    ActionEditClear: TAction;
    ActionNewMemo: TAction;
    ActionList1: TActionList;
    ActionEditCopy: TEditCopy;
    ActionEditCut: TEditCut;
    ActionEditDelete: TEditDelete;
    ActionEditPaste: TEditPaste;
    ActionEditSelectAll: TEditSelectAll;
    ActionEditUndo: TEditUndo;
    FontDialog1: TFontDialog;
    ImageList1: TImageList;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    PopupMenu1: TPopupMenu;
    RichEdit1: TRichMemo;
    Separator1: TMenuItem;
    Separator2: TMenuItem;
    Separator3: TMenuItem;
    Separator4: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure ActionEditClearExecute(Sender: TObject);
    procedure ActionEditCutExecute(Sender: TObject);
    procedure ActionFontExecute(Sender: TObject);
    procedure ActionNewMemoExecute(Sender: TObject);
    procedure ActionTopMostExecute(Sender: TObject);
    procedure ActionTopMostUpdate(Sender: TObject);
    procedure ActionVersionExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1; 
  ExIniFile: TExtIniFile;

implementation      

uses Unit2;

{$R *.lfm}

{ TForm1 }


procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  //????????????????????????
  RichEdit1.Lines.SaveToFile(ChangeFileExt( Application.ExeName, '.txt' ));

  //???????????????
  ExIniFile.WriteForm2('Main', Self);
  ExIniFile.WriteFont('Edit', 'Font', RichEdit1.Font);
  //ExIniFile.WriteBool('Config', 'TopForm', ActionTop.Checked);

  //??????
  ExIniFile.Free;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  FileName: String;
 begin
   //??????????????????????????????
   FileName := ChangeFileExt( Application.ExeName, '.txt' );
   if FileExists(FileName) then
   begin
     RichEdit1.Lines.LoadFromFile(FileName);
   end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  //??????
  ExIniFile := TExtIniFile.Create(Self);
  ExIniFile.FileName := 'settings.ini';

  //?????????????????????????????????
  ExIniFile.ReadFormEx2('Main' ,Self);
  ExIniFile.ReadFont('Edit', 'Font', RichEdit1.Font);
  //ActionTop.Checked := ExIniFile.ReadBool('Config', 'TopForm', ActionTop.Checked);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin  
  RichEdit1.SetFocus;
end;

procedure TForm1.ActionEditCutExecute(Sender: TObject);
begin
  RichEdit1.CutToClipboard;
end;

procedure TForm1.ActionFontExecute(Sender: TObject);
begin
  FontDialog1.Font := RichEdit1.Font;
  if FontDialog1.Execute then
  begin
   RichEdit1.Font := FontDialog1.Font;
  end;
end;

procedure TForm1.ActionEditClearExecute(Sender: TObject);
begin
  RichEdit1.Clear;
end;

procedure TForm1.ActionNewMemoExecute(Sender: TObject);
begin
  RichEdit1.Lines.Insert(0, '----------------------------------------');
  RichEdit1.Lines.Insert(0, DateTimeToStr(Now));
  RichEdit1.Lines.Insert(0, '');
  RichEdit1.Lines.Insert(0, '');
  with RichEdit1 do
  begin
    SelStart := Perform(EM_LINEINDEX, 0, 0); // ??????????????????????????????
    Perform(WM_VSCROLL,SB_TOP,0);            // ?????????????????????????????????
    SetFocus;                                // ??????????????????????????????
   end;
end;

procedure TForm1.ActionTopMostExecute(Sender: TObject);
begin

end;

procedure TForm1.ActionTopMostUpdate(Sender: TObject);
begin
  if ActionTopMost.Checked then begin
    //?????????????????????
    FormStyle := fsSystemStayOnTop;
  end else begin
    //??????????????????????????????
    FormStyle := fsStayOnTop;
  end;
end;

procedure TForm1.ActionVersionExecute(Sender: TObject);
begin
  Form2 := TForm2.Create(self);
  try
    Form2.ShowModal;
  finally
    Form2.Free;
  end;
end;

end.

