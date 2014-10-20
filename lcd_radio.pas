unit lcd_radio;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Buttons;

type

  { TRadio }

  TRadio = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Panel3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }

    Anzeige : Boolean;

    function init : integer;
  public
    { public declarations }

    procedure PRG_Ende;
  end;

var
  Radio: TRadio;

implementation

{$R *.lfm}

{ TRadio }

uses lcd_var
    , lcd_tools
    , lcdTastatur
    , lcd_setup
    , lcd_sender
    , lcd_musik
    ;

procedure TRadio.FormActivate(Sender: TObject);
begin
  init;
end;

procedure TRadio.FormClick(Sender: TObject);
begin
  if DimmSchalter
     then begin
            if Ein_Aus_Schalter
               then Dimmen_Einschalten
               else Dimmen_Ausschalten;
            Panel3.Color  := clblack;
      //      label4.Visible:=False;
            DimmSchalter := False;
     end;
end;

procedure TRadio.Button1Click(Sender: TObject);
begin
  tastenzeile  := '';
  Tastatur.ShowModal;

end;

procedure TRadio.FormCreate(Sender: TObject);
begin
  anzeige := true;
  ZeitKurz := true;
//  ZeitKurz := False;

  DimmSchalter := true;
  DimmSchalter := False;

  Ein_Aus_Schalter := True;

  //  Dimmerwert := 5;
//  Dimmerzehler := 0;
  if ZeitKurz
    then Label5.Font.Height:= -44
    else Label5.Font.Height:= -36;

  Radio.Color:= clBlack;
  Radio.Top := 31;
  Radio.Left := 31;
{$IFDEF LINUX}
  Radio.Top := 0;
  Radio.Left := 0;
{$ENDIF}
  Radio.Width:= 320;
  Radio.Height:= 240;
end;

procedure TRadio.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if DimmSchalter
     then begin
            if Ein_Aus_Schalter
               then Dimmen_Einschalten
               else Dimmen_Ausschalten;

            Panel3.Color  := clblack;
//            label4.Visible:=False;
            DimmSchalter := False;
     end;
end;

procedure TRadio.Panel3Click(Sender: TObject);
begin
 // EinSchalten;
  DimmSchalter := Not(DimmSchalter);
  if DimmSchalter
    then begin
//           Einschalten;
           if Ein_Aus_Schalter
              then Dimmen_Einschalten
              else Dimmen_Ausschalten;
           Panel3.Color := clgray;
           Radio.Color  := clgray;
           Label4.Caption:='Sleep An';
//           label4.Visible:=true;
    end
    else begin
//           AusSchalten;
           if Ein_Aus_Schalter
              then Dimmen_Ausschalten
              else Dimmen_Einschalten;

           panel3.color := clblack;
           Radio.Color  := clBlack;
//           Label4.Visible:=false;
           Label4.Caption:='Sleep aus';
    end;
end;

function TRadio.init : integer;
Var Kommando : string;
begin
  Result := 0;
  Kommando:= 'sudo DISPLAY=:0 xinput --set-prop '
  + chr(39)
  + 'ADS7846 Touchscreen'
  + chr(39) + '  ' + chr(39)
  + 'Evdev Axis Inversion'
  + chr(39) + ' 0 1';
//  Showmessage(Kommando);
  Startextprg(Kommando);
end;

procedure  TRadio.PRG_Ende;
begin
  //Runterfahren          fehlt noch
  Close;
end;

procedure TRadio.SpeedButton1Click(Sender: TObject);
Var Kommando : string;
    UWert : integer;
begin
//  Screen.Cursor:= -1;

  // Kommando :=
 (* Kommando:= 'sudo DISPLAY=:0 xinput --set-prop '
  + chr(39)
  + 'ADS7846 Touchscreen'
  + chr(39) + '  ' + chr(39)
  + 'Evdev Axis Inversion'
  + chr(39) + ' 0 1';
  Showmessage(Kommando);
  Startextprg(Kommando);
 *)
  if DimmSchalter
     then begin
            if Ein_Aus_Schalter
               then Dimmen_Einschalten
               else Dimmen_Ausschalten;
            Panel3.Color := clblack;
            Radio.Color  := clblack;
//            label4.Visible:=False;
            DimmSchalter := False;
     end
     else begin
            UWert := Setup.ShowModal;
            case Setup.Wert of
             1:;
             4: PRG_Ende;

            end;
     end;
end;

procedure TRadio.SpeedButton2Click(Sender: TObject);
begin
//  close;
//  Lautstaerke.ShowModal;
  if DimmSchalter
     then begin
            if Ein_Aus_Schalter
               then Dimmen_Einschalten
               else Dimmen_Ausschalten;

            Panel3.Color := clblack;
            Radio.Color  := clblack;
//            label4.Visible:=False;
            DimmSchalter := False;
     end
     else Musik.Showmodal;
end;

procedure TRadio.SpeedButton4Click(Sender: TObject);
begin
  if DimmSchalter
     then begin
            if Ein_Aus_Schalter
               then Dimmen_Einschalten
               else Dimmen_Ausschalten;

            Panel3.Color := clblack;
            Radio.Color  := clblack;
//            label4.Visible:=False;
            DimmSchalter := False;
     end
     else Senderwahl.ShowModal;
end;

procedure TRadio.Timer1Timer(Sender: TObject);
Var Liste         : Tstringlist;
    Zeile         : string;
    Kommandozeile : string;
    Austausch     : string;
    tempstr       : string;
    posit         : integer;
    DatumStr      : string;
    debugstr      : string;
    Sender_str : string;
    Titel_str : string;
    Actor_str : string;

    Sender_nummer : integer;

begin
  if ZeitKurz
    then begin
          DatumStr :=  FormatDateTime('dd.mm.yy, hh:nn', now);
          Label5.Font.Size:=32;
    end
    else begin
           DatumStr :=  FormatDateTime('dd.mm.yy, hh:nn:ss', now);
           Label5.Font.Size:=26;
    end;
  Label5.Caption:= DatumStr;
  Austausch := 'play.lst';
  if anzeige then
  begin
     KommandoZeile := 'mpc current ' ;
      {$IFDEF LINUX}
     ExPrGStarten(KommandoZeile,Austausch);
     {$ENDIF}
     Liste := Tstringlist.Create;
      if FileExists(Austausch)
    then begin
           Liste.LoadFromFile(Austausch);
           if liste.count > 0
             then begin Zeile := Liste[0];
                     Posit :=  pos(':',Zeile)-1;
                    Label1.Caption := copy(Zeile,1,Posit);
                    Sender_str := copy(Zeile,1,Posit);
                    if pos('Radio Paradise',sender_Str) = 1
                      then begin
                          Sender_nummer := 1;
                          Sender_str := copy(Zeile,1,14);
                      end;

                    if pos('detektor.fm',sender_Str) = 1
                      then begin
                          Sender_nummer := 2;
                          Sender_str := copy(Zeile,1,11);
                      end;

                    delete(zeile,1,posit+1);
                    Posit :=  pos('-',Zeile)-1;
                    if posit < 0
                      then Posit :=  pos('  ',Zeile)-1;

                   Actor_str := copy(zeile,1,posit);

                   delete(zeile,1,posit+2);
                   posit :=  pos('-',Zeile)+1;
                   tempstr := trim(copy(zeile,posit,maxint));

                   case Sender_nummer of
                     1 : ;
                     2 : begin
                           Posit :=  pos('   ',tempstr);
                           Tempstr := copy(tempstr,1,posit);
                     end;
                   end;
                   Titel_str := tempstr;

                   label1.Caption:= trim(Sender_str);
                   label2.Caption:= trim(Actor_str);
                   label3.Caption:= trim(Titel_str);
             end;
    end;
  end;
end;

end.

