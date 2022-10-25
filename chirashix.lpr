program chirashix;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}      
  Windows,
  Dialogs,
  Messages,
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1, Unit2
  { you can add units after this };

{$R *.res}
const
  UniqueName:string = 'Cirashi_xA81wJNINtFWbA6wBGpk';

//-----------------------------------------------------------------------------
//  EnumWindows のコールバック関数
//  起動済みのアプリを最前面に表示するために使用
//
//  lazarus-2.0.8 では ShowWindow(hWindow, SW_RESTORE) は機能しない
//  代わりに WM_SYSCOMMAND で SC_RESTORE をポストしている
//-----------------------------------------------------------------------------
function EnumWndProc(hWindow: HWND; lData: LPARAM): BOOL;stdcall;
begin
  Result := True;
  if GetProp(hWindow, PChar(lData)) = 1111 then begin
    if IsIconic(hWindow) then begin
      PostMessage(hWindow, WM_SYSCOMMAND, $FFF0 and SC_RESTORE, 0);
    end;
    SetForegroundWindow(hWindow);
    Result := False;
  end;
end;

//-----------------------------------------------------------------------------
//  引数で指定したプロパティを持つウィンドウが起動しているかを確認する関数
//-----------------------------------------------------------------------------
function IsPrevAppExist(AName: string):Boolean;
begin
  Result := False;
  CreateMutex(nil, True, PChar(AName));
  if GetLastError = ERROR_ALREADY_EXISTS then begin
    ShowMessage('このアプリは二重起動できません');
    EnumWindows(@EnumWndProc, LPARAM(PChar(AName)));
    Result := True;
  end;
end;
begin
  if IsPrevAppExist(UniqueName) then Exit;

  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

