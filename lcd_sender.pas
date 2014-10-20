unit lcd_sender;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons;

type

  { TSenderwahl }

  TSenderwahl = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
  private
    { private declarations }
  procedure Auswahl(sender : integer);

  public
    { public declarations }
  end;

var
  Senderwahl: TSenderwahl;

implementation

{$R *.lfm}

{ TSenderwahl }

uses lcd_tools;

procedure TSenderwahl.FormCreate(Sender: TObject);
Var Schrifthoehe : word;
begin
    Senderwahl.Top  := 31;
    Senderwahl.Left := 31;
 {$IFDEF LINUX}
   Senderwahl.Top  := 0;
   Senderwahl.Left := 0;
    {$ENDIF}
   Senderwahl.Width  := 320;
   Senderwahl.Height := 240;
   SpeedButton1.Font.Color:=clnavy;
   SpeedButton2.Font.Color:=clnavy;
   SpeedButton3.Font.Color:=clnavy;
   SpeedButton4.Font.Color:=clnavy;
   SpeedButton5.Font.Color:=clnavy;
   SpeedButton6.Font.Color:=clnavy;

   Schrifthoehe := 16;

  SpeedButton1.Top := 1;
  SpeedButton1.Left := 1;
  SpeedButton1.Height := 80;
  SpeedButton1.Width := 158;
  SpeedButton1.Font.Size := Schrifthoehe ;

  SpeedButton2.Top := 81;
  SpeedButton2.Left := 1;
  SpeedButton2.Height := 80;
  SpeedButton2.Width := 158;
  SpeedButton2.Font.Size := Schrifthoehe ;

  SpeedButton3.Top := 161;
  SpeedButton3.Left := 1;
  SpeedButton3.Height := 80;
  SpeedButton3.Width := 158;
  SpeedButton3.Font.Size := Schrifthoehe ;

  SpeedButton4.Top := 1;
  SpeedButton4.Left := 160;
  SpeedButton4.Height := 80;
  SpeedButton4.Width := 158;
  SpeedButton4.Font.Size := Schrifthoehe ;

  SpeedButton5.Top := 81;
  SpeedButton5.Left := 160;
  SpeedButton5.Height := 80;
  SpeedButton5.Width := 158;
  SpeedButton5.Font.Size := Schrifthoehe ;

  SpeedButton6.Top := 161;
  SpeedButton6.Left := 160;
  SpeedButton6.Height := 80;
  SpeedButton6.Width := 158;
  SpeedButton6.Font.Size := Schrifthoehe ;
(*
  SpeedButton7.Visible := False;
  SpeedButton8.Visible := False;
  SpeedButton9.Visible := False;
  SpeedButton10.Visible := False;
  SpeedButton11.Visible := False;
  SpeedButton12.Visible := False;
  SpeedButton13.Visible := False;
  SpeedButton14.Visible := False;
  SpeedButton15.Visible := False;
  SpeedButton16.Visible := False;
*)
end;

procedure TSenderwahl.FormActivate(Sender: TObject);
  Var Liste : Tstringlist;
      Zeile : string;
      Senderliste : string;
      i,imax : integer;
      Senderstr : array[0..12] of string;
      Kommando : string;
  begin
    SenderListe := 'Sender.lst';
    Liste := Tstringlist.Create;

   // procedure ExPrGStarten(Kommando : string; DatName : string)

    Kommando := 'mpc playlist ';
      {$IFDEF LINUX}
        ExPrGStarten(Kommando,SenderListe);
      {$ELSE}
  //      ShowMessage(Kommando);
      {$ENDIF}

    if FileExists(SenderListe)
      then begin
         Liste.LoadFromFile(Senderliste);

         imax := liste.Count -1;
         if Imax > 6
           then imax := 6;

        for I := 0 to imax do
        begin
          Zeile := Liste[i];
          Senderstr[i + 1] := copy(zeile,1,16);
        end;

        SpeedButton1.Caption:= copy(Senderstr[1] ,1, 7)
         + #13#10 +copy(Senderstr[1] ,8, 20) ;
 //       SpeedButton1.Caption:= Senderstr[1];
//        SpeedButton2.Caption:= Senderstr[2];
         SpeedButton2.Caption:= copy(Senderstr[2] ,1, 7)
         + #13#10 +copy(Senderstr[2] ,8, 20) ;
  //      SpeedButton3.Caption:= Senderstr[3];
         SpeedButton3.Caption:= copy(Senderstr[3] ,1, 7)
         + #13#10 +copy(Senderstr[3] ,8, 20) ;
        SpeedButton4.Caption:= Senderstr[4];
        SpeedButton5.Caption:= Senderstr[5];
        SpeedButton6.Caption:= Senderstr[6];
      end;
end;


procedure TSenderwahl.Auswahl(sender : integer);
begin
  Startextprg('mpc -f "%title%" play '+ IntToSTR(sender));
  close;
end;

procedure TSenderwahl.SpeedButton1Click(Sender: TObject);
begin
  Auswahl(1);
end;

procedure TSenderwahl.SpeedButton2Click(Sender: TObject);
begin
  Auswahl(2);
end;

procedure TSenderwahl.SpeedButton3Click(Sender: TObject);
begin
  Auswahl(3);
end;

procedure TSenderwahl.SpeedButton4Click(Sender: TObject);
begin
    Auswahl(4);
end;

procedure TSenderwahl.SpeedButton5Click(Sender: TObject);
begin
    Auswahl(5);
end;

procedure TSenderwahl.SpeedButton6Click(Sender: TObject);
begin
    Auswahl(6);
end;

end.

