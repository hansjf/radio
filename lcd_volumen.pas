unit lcd_volumen;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  ComCtrls, StdCtrls;

type

  { TLautstaerke }

  TLautstaerke = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    TrackBar1: TTrackBar;
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
  private
    { private declarations }
    Radiolevel : word;
  public
    { public declarations }
  end;

var
  Lautstaerke: TLautstaerke;

implementation

{$R *.lfm}

{ TLautstaerke }

uses lcd_tools;

procedure TLautstaerke.SpeedButton1Click(Sender: TObject);
begin
   RadioLevel := 0;
   Startextprg('mpc volume ' + inttostr(Radiolevel));
   TrackBar1.Position := RadioLevel;
end;

procedure TLautstaerke.FormCreate(Sender: TObject);
Var Schrifthoehe : word;
begin
  Lautstaerke.Top  := 31;
  Lautstaerke.Left := 31;
{$IFDEF LINUX}
 Lautstaerke.Top  := 0;
 Lautstaerke.Left := 0;
  {$ENDIF}
 Lautstaerke.Width  := 320;
 Lautstaerke.Height := 240;

 Schrifthoehe := 18;

 SpeedButton1.Font.Size := Schrifthoehe ;
 SpeedButton2.Font.Size := Schrifthoehe ;
 SpeedButton3.Font.Size := Schrifthoehe ;
 SpeedButton4.Font.Size := Schrifthoehe ;


  Radiolevel := 85;
end;

procedure TLautstaerke.FormActivate(Sender: TObject);
begin
  TrackBar1.Position:=Radiolevel;
end;

procedure TLautstaerke.SpeedButton2Click(Sender: TObject);
begin
  close;
end;

procedure TLautstaerke.SpeedButton3Click(Sender: TObject);
begin
  RadioLevel := 85;
  Startextprg('mpc volume ' + inttostr(Radiolevel));
  TrackBar1.Position := RadioLevel;
end;

procedure TLautstaerke.SpeedButton4Click(Sender: TObject);
begin
   RadioLevel := 100;
   Startextprg('mpc volume ' + inttostr(Radiolevel));
   TrackBar1.Position := RadioLevel;
end;

procedure TLautstaerke.TrackBar1Change(Sender: TObject);
begin
  RadioLevel := TrackBar1.Position;
  Edit1.text := IntTOsTr(Radiolevel);
  Startextprg('mpc volume ' + inttostr(Radiolevel));
end;

end.

