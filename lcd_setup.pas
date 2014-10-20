unit lcd_setup;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls, ExtCtrls;

type

  { Tsetup }

  Tsetup = class(TForm)
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    Wert : integer;
    { public declarations }
  end;

var
  setup: Tsetup;

implementation

{$R *.lfm}

{ Tsetup }

uses lcd_var,
     lcd_tools,
     lcdTastatur
    , lcd_volumen
    , lcd_radio
    ;

procedure Tsetup.SpeedButton1Click(Sender: TObject);
begin
//  Shutdown
  Wert := 4;
  Close;
  //Program Beenden
end;

procedure Tsetup.FormCreate(Sender: TObject);
Var Schrifthoehe : word;
begin
  setup.Top  := 0;//31;
  setup.Left := 0; //31;
{$IFDEF LINUX}
   setup.Top  := 0;
   setup.Left := 0;
{$ENDIF}
 setup.Width  := 320;
 setup.Height := 240;

 Schrifthoehe := 16;

 SpeedButton1.Font.Size := Schrifthoehe;
 SpeedButton2.Font.Size := Schrifthoehe;
 SpeedButton3.Font.Size := Schrifthoehe;
 SpeedButton4.Font.Size := Schrifthoehe;
 SpeedButton5.Font.Size := Schrifthoehe;
 SpeedButton6.Font.Size := Schrifthoehe;

end;

procedure Tsetup.SpeedButton2Click(Sender: TObject);
begin
  Wert := 1;
  close;
end;

procedure Tsetup.SpeedButton3Click(Sender: TObject);
begin
  if SpeedButton3.Caption = 'Cursor ON'
  then begin
     SpeedButton3.Caption := 'Cursor OFF';
 //    unclutter
 // Startextprg(s: string):integer;
 //   Startextprg(s: string):integer;
    Screen.Cursor:= -1;
  end
  else begin
         SpeedButton3.Caption := 'Cursor ON';
         Screen.Cursor:=  +1;
         // Für Windows ????
         //http://wiki.lazarus.freepascal.org/Cursor/de
         Screen.Cursor:=  crHourGlass;
         Screen.Cursor:=  crHandPoint;
  end;
  close;
end;

procedure Tsetup.SpeedButton4Click(Sender: TObject);
begin
  //BildShirm dunkel
//  AusSchalten;
//  Close;
 Lautstaerke.ShowModal;
//

end;

procedure Tsetup.SpeedButton5Click(Sender: TObject);
begin
  if SpeedButton5.Caption = 'Zeit Anzeige ON'
  then begin
         SpeedButton5.Caption := 'Zeit Anzeige OFF';
         ZeitKurz := False;
  end
  else begin
         SpeedButton5.Caption := 'Zeit Anzeige ON';
         ZeitKurz := true;
  end;
  close;
end;

procedure Tsetup.SpeedButton6Click(Sender: TObject);
begin
  if SpeedButton6.Caption = 'Bild Hell'
  then begin
         SpeedButton6.Caption := 'Bild Dunkel';
         Dimmschalter := False;
         Radio.Panel3.Color  := clBlack;
         Radio.Color         := clblack;
         Radio.Label4.Caption:='Sleep Aus';
         if Ein_Aus_Schalter
            then Dimmen_Ausschalten
            else Dimmen_Einschalten;
   //      Radio.label4.Visible:=true;
  end
  else begin
         SpeedButton6.Caption := 'Bild Hell';
         Dimmschalter := True;
         if Ein_Aus_Schalter
           then Dimmen_Einschalten
           else Dimmen_Ausschalten;

         Radio.Panel3.Color  := clGray;
         Radio.Color         := clGray;
         Radio.Label4.Caption:='Sleep An';
   //      Radio.label4.Visible:=False;
  end;

  //BildShirm dunkel
(*  if Dimmschalter
    then begin

    end;

  EinSchalten;*)
//   Close;
end;

procedure Tsetup.SpeedButton7Click(Sender: TObject);
begin
  tastenzeile  := '';
  Timer1.enabled := true;
  Tastatur.ShowModal;
   Timer1.enabled := false;

  Label1.caption := tastenzeile;
end;

procedure Tsetup.Timer1Timer(Sender: TObject);
begin
  Label1.caption := tastenzeile;
end;

end.

