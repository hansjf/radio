unit lcdtastatur;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  StdCtrls, ExtCtrls;

const
    DE_Tastatur : array[0..29] of string
      = ('q','w','e','r','t','z','u','i','o','p'
      , 'a','s','d','f','g','h','j','k','l','ß'
      , 'y','x','c','v','b','n','m','ä','ö','ü'
      );

      DE_gros_Tastatur : array[0..29] of string
      = ('Q','W','E','R','T','Z','U','I','O','P'
      , 'A','S','D','F','G','H','J','K','L',' '
      , 'Y','X','C','V','B','N','M','Ä','Ö','Ü'
      );
      Ziffer_Symbole_Tastatur  : array[0..29] of String
      = ('!','"','§','$','%','&','/','(',')','='
      , '?','`','*','+','#',chr(39),'œ','æ','‘','@'
      , '¡','“','¶','¢','[',']','|','{','}','¿'
      );
      Sonder_Tastatur : array[0..29] of string
      = ('Q','1','2','3','4','5','6','7','8','9'
      , '┌','┬','┐','├','┼','┤','└','┴','┘',' '
      , 'Y','X','C','V','B','N','M','Ä','Ö','Ü'
      );

type


  { TTastatur }

  TTastatur = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Edit1: TEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { private declarations }
    Tastenfeld : array[0..30] of TButton;
    ShiftSchalter : Boolean;
    SymbolSchalter : Boolean;
    NumSchalter : Boolean;
    Abstand,
    TastenPosit : integer;
    function Tastenfeld_Anzeige : integer;
//    procedure TastenClick(Var Zeile : String;i : word;Sender: TObject);
      procedure TastenClick(Sender: TObject);
  public
//     TastenZeile : string;
    { public declarations }
  end;

var
  Tastatur: TTastatur;

implementation

{$R *.lfm}

{ TTastatur }

uses lcd_tools;

function TTastatur.Tastenfeld_Anzeige : integer;
Var Spalte,Zeile,i : word;
  begin
    if NumSchalter then
    begin
        Tastatur.Top  := 120;//31;
    Tastatur.Left := 0; //31;
  {$IFDEF LINUX}
     Tastatur.Top  := 0;
     Tastatur.Left := 0;
  {$ENDIF}
   Tastatur.Width  := 2+ 4*Abstand+2; //320;
   Tastatur.Height := 140;

      Panel1.Align:= alLeft;
      Panel1.Width := 4*Abstand;

      for i := 12 to 26 do
       Tastenfeld[i].Visible:= False;

      spalte := 1;
      Zeile  := 1;

      Tastenfeld[0].Caption := chr(48);
      Tastenfeld[0].Left    := 1 + Abstand;
      Tastenfeld[0].Top     := 3 * (Abstand + 1);

      Tastenfeld[10].Caption := '<';
      Tastenfeld[10].Left    := 1;
      Tastenfeld[10].Top     := 3 * (Abstand + 1);
      Tastenfeld[11].Caption := 'C';
      Tastenfeld[11].Left    := 2* (1 + Abstand);
      Tastenfeld[11].Top     := 3 * (Abstand + 1);


      for i := 1 to 9 do
       begin
        Tastenfeld[i].Left    := Spalte;
        Tastenfeld[i].Top     := Zeile;

        inc (Spalte,abstand + 1);
        if Spalte > (3 * (abstand +1))
          then begin
            spalte := 1;
            inc(Zeile,Abstand + 1);
          end;
        if Shiftschalter
          then Tastenfeld[i].Caption := Sonder_Tastatur[i+9]
    //    Tastenfeld[i].Caption := chr(48 + i)
          else Tastenfeld[i].Caption := Sonder_Tastatur[i];

       end;
    end
    else begin
      Tastatur.Top  := 120;//31;
        Tastatur.Left := 0; //31;
      {$IFDEF LINUX}
         Tastatur.Top  := 0;
         Tastatur.Left := 0;
      {$ENDIF}
       Tastatur.Width  := 320;
       Tastatur.Height := 120;

      Panel1.Align:= alTop;
   //   Panel1.Width := 4*Abstand;

     Zeile  := 1;
     Spalte := 1;

     for i := 0 to 29 do
     begin

       Tastenfeld[i].Visible:= True;
           Tastenfeld[i].Left    := Spalte;
           Tastenfeld[i].Top     := Zeile;

           inc(spalte,1 + Abstand);
           if Spalte > 10 *(1+Abstand)
             then begin
                    if zeile mod 2 = 1
                      then Spalte := abstand div 2
                      else Spalte := 1;
                    inc(Zeile,1 + Abstand);
                  end;

        if ShiftSchalter
          then begin
           if SymbolSchalter
                   then Tastenfeld[i].Caption := chr(30 + 6 +  2 + i)
    //               else  Tastenfeld[i].Caption := chr(65+i);
                     else  Tastenfeld[i].Caption := DE_gros_Tastatur[i];
          end
          else begin
                 if SymbolSchalter
              //     then Tastenfeld[i].Caption := chr(40 +10 + 6 + i)
                     then Tastenfeld[i].Caption := Ziffer_Symbole_Tastatur[i]
             //
             //      else Tastenfeld[i].Caption := chr(65+26 + 6 + i);
                   else Tastenfeld[i].Caption := DE_Tastatur[i];
                 //chr(65+26 + 6 + i);

          end;
     end;
    end;
end;

//procedure TTastatur.TastenClick(Var Zeile : String;i : word;Sender: TObject);
procedure TTastatur.TastenClick(Sender: TObject);
Var Zeichen : String;
var Temp      : TComponent;
   TastenName : string;
   i,j : integer;
   Debugstr : string;
begin
//  if Sender.
 // if Sender.

                       //===============
 { var Temp      : TComponent;
    LabelName : string;
    EditName  : string;
    i         : integer;

begin  }
  TastenName := 'T';
  Zeichen := '';

  if Sender is TButton
    then begin

 //   ShowMessage(''''+TButton(Sender).Caption+''' geclickt.');
    Zeichen := TButton(Sender).Caption;
    end;

  case Zeichen of
  '<' :  Delete(TastenZeile,length(TastenZeile),1);

    else TastenZeile := TastenZeile + Zeichen;
  end;


  Edit1.Text := TastenZeile;
end;

procedure TTastatur.FormCreate(Sender: TObject);
Var Zeile,Spalte : word;
  i : integer;
  Schrifthoehe : integer;
  begin
    Tastatur.Top  := 120;//31;
    Tastatur.Left := 0; //31;
  {$IFDEF LINUX}
     Tastatur.Top  := 0;
     Tastatur.Left := 0;
  {$ENDIF}
   Tastatur.Width  := 320;
   Tastatur.Height := 120;

   Schrifthoehe := 16;
   Abstand := 24;

   ShiftSchalter := False;
   SymbolSchalter := False;

 Zeile  := 1;
 Spalte := 1;
 for i := 0 to 29 do
  begin
   // Tastenfeld[i]..Anzeige_Bild := TButton.Create(self);
     Tastenfeld[i] := TButton.Create(self);

     Tastenfeld[i].Name := 'T' + intToStr(i);
(*     if ShiftSchalter
       then Tastenfeld[i].Caption := chr(65+i)
       else Tastenfeld[i].Caption := chr(65+26 +6 + i);
       *)
       if ShiftSchalter
       then Tastenfeld[i].Caption := DE_gros_Tastatur[i]
       else Tastenfeld[i].Caption := DE_Tastatur[i];

    Tastenfeld[i].Parent := Panel1;
    Tastenfeld[i].Left    := Spalte;
    Tastenfeld[i].Top     := Zeile;
    Tastenfeld[i].width   := Abstand; // + 2;
    Tastenfeld[i].Height  := Abstand;

    Tastenfeld[i].OnClick := @TastenClick;
    Tastenfeld[i].visible := True;

    inc(spalte,1 + Abstand);
    if Spalte > 10 *(1+Abstand)
      then begin
             if zeile mod 2 = 1
               then Spalte := abstand div 2
               else Spalte := 1;
             inc(Zeile,1 + Abstand);
      end;
  end;
end;

procedure TTastatur.Button2Click(Sender: TObject);
begin
  ShiftSchalter := Not(ShiftSchalter);
   if ShiftSchalter
     then begin
            Button2.Caption:= 'Shift ON';
     end
     else begin
            Button2.Caption:= 'Shift OFF';
     end;
     Tastenfeld_Anzeige;
end;

procedure TTastatur.Button1Click(Sender: TObject);
begin
  NUMSchalter := Not(NUMSchalter);
   if NUMSchalter
     then begin
            Button1.Caption:= 'NUM ON';
     end
     else begin
            Button1.Caption:= 'NUM OFF';
     end;
     Tastenfeld_Anzeige;

end;

procedure TTastatur.Button3Click(Sender: TObject);
begin
  SymbolSchalter := Not(SymbolSchalter);
   if SymbolSchalter
     then begin
            Button3.Caption:= 'Symbol ON';
     end
     else begin
            Button3.Caption:= 'Symbol OFF';
     end;
     Tastenfeld_Anzeige;
end;

procedure TTastatur.Button4Click(Sender: TObject);
begin
  TastenZeile := '';
  Edit1.Text:= TastenZeile;
end;

procedure TTastatur.Button5Click(Sender: TObject);
begin
  Delete(TastenZeile,length(TastenZeile),1);
  Edit1.Text:= TastenZeile;
end;

procedure TTastatur.Button6Click(Sender: TObject);
begin
  close;
end;

procedure TTastatur.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

end.

