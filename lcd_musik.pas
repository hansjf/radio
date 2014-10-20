unit lcd_musik;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Grids;

type

  { TMusik }

  TMusik = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    ComboBox1: TComboBox;
    ListBox1: TListBox;
    OpenDialog1: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListBox1Click(Sender: TObject);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { private declarations }
    Dateiname  : string;
    KopfZeile  : Tstringlist;
    MusikListe : Tstringlist;
    Vorwaertsschalter : Boolean;

    Pfad : string;
    PlayListPfad : string;

    Filter_Str : string;
    procedure Anzeige(Datei_Name : string);
    procedure Suchdat(Maske : String);
    function DateiOeffnen : integer;
    procedure Filtern;
  public
    { public declarations }
  end;

var
  Musik : TMusik;

implementation

{$R *.lfm}

{ TMusik }

uses StringgridTools;

procedure TMusik.Suchdat(Maske : String);
var SearchRec : TSearchRec;
    Dummy     : string;
begin
  Dummy := '';
  getdir(0,Dummy);
//  Chdir(ArbeitsblattPfad);
  if DirectoryExists(PlayListPfad)
    then begin

  Chdir(PlayListPfad);

  Listbox1.Clear;
//  FindFirst('*.pkt', faAnyFile, SearchRec);
  FindFirst(Maske, faAnyFile, SearchRec);

  Listbox1.Items.Add(SearchRec.Name);
  while (FindNext(SearchRec) = 0) do
    Listbox1.Items.Add(SearchRec.Name);

  Listbox1.Sorted := True;
  FindClose(SearchRec);

    end
  else Showmessage(PlayListPfad + ' fehlt !!!');

  chdir(Dummy);
end;

procedure TMusik.FormCreate(Sender: TObject);
Var I, Imax : integer;
    Satz    : string;

begin
  Pfad := ExtractFilePath(paramstr(0));
  PlayListPfad := '/Users/hans/Documents/Dok_2014/doku-raspberryPI/SIK-Rasp-01/var/lib/mpd/playlists/';

  PlayListPfad := Pfad;

 {$IFDEF WINDOWS}
 {$else MACOS}
    Pfad := '/Users/hans/datenbank/Playlist/';
 PlayListPfad := '/Users/hans/Documents/Dok_2014/doku-raspberryPI/SIK-Rasp-01/var/lib/mpd/playlists/';
 {$endif}

  {$IFDEF LINUX}

 // Nur MAC  bei Linux falsch !!!
 Pfad := '/Users/hans/datenbank/Playlist/';
 PlayListPfad := '/Users/hans/Documents/Dok_2014/doku-raspberryPI/SIK-Rasp-01/var/lib/mpd/playlists/';
  {$ENDIF}

  Musik.Top  := 31;
  Musik.Left := 31;
{$IFDEF LINUX}
 Musik.Top  := 0;
 Musik.Left := 0;
  {$ENDIF}
 Musik.Width  := 320;
 Musik.Height := 240;

  Stringgrid1.Align:= alClient;
  MusikListe := Tstringlist.Create;
  KopfZeile  := Tstringlist.Create;

  Filter_str := uppercase(ComboBox1.text);

  KopfZeile.Add('Nr:');
  KopfZeile.Add('Titel');
  KopfZeile.Add('Kurz-titel');
  KopfZeile.Add('Name');
  KopfZeile.Add('Name neu');

  StringGrid1.Cells[0,0] := KopfZeile[0];
  StringGrid1.Cells[1,0] := KopfZeile[1];
  StringGrid1.Cells[2,0] := KopfZeile[2];
  StringGrid1.Cells[3,0] := KopfZeile[3];
  StringGrid1.Cells[4,0] := KopfZeile[4];

  Dateiname := 'Musik.lst';
  Dateiname := 'Yes.lst';
  (*
  if FileExists(Dateiname)
    then begin
          MusikListe.LoadFromFile(Dateiname);
          Imax := MusikListe.count;
          StringGrid1.RowCount:= Imax+1;

          For i := 0 to Imax -1 do
            begin
              Satz := MusikListe[i];
              StringGrid1.Cells[0,i+1] := IntToStr(i+1);
              StringGrid1.Cells[1,i+1] := copy(MusikListe[i],36,maxint);
              StringGrid1.Cells[2,i+1] := copy(Satz,37,2);
              StringGrid1.Cells[3,i+1] := copy(Satz,36,8);
              StringGrid1.Cells[4,i+1] := copy(Satz,40,3);
            end;
    end
  else Showmessage(Dateiname + '  fehlt !');         *)
end;

procedure TMusik.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TMusik.Button1Click(Sender: TObject);
begin
   Showmessage('Play -->' + IntToStr(StringGrid1.Row) + ' | ' +  (StringGrid1.Cells[1,StringGrid1.Row] ));
end;

procedure TMusik.Button3Click(Sender: TObject);
Var OutPutListe : Tstringlist;
    Satz        : string;
    i           : integer;
begin
   OutPutListe := Tstringlist.Create;

   For i := 0 to StringGrid1.RowCount-2 do
     begin
       satz := StringGrid1.cells[4,i+1];
       Satz := satz + '-' + IntToStr(i+1) + '.mp3';
       OutPutListe.Add(Satz);
     end;

   OutPutListe.SaveToFile(Dateiname + '.neu');
   OutPutListe.Free;
end;

procedure TMusik.Button4Click(Sender: TObject);
Type MP3Record = record
       Kennung : array[1..4] of char;
       Lenge   : integer;
//       Mp3_Label : string;

     end;

  MP3KopfRecord = record
         Kennung : array[1..3] of char;
         Version : word;
         Mp3_Label : Array[1..4] of char;

       end;

  FeldRecord = array[1..128] of char;

Var Inputstream : Tstream;
    DatName     : string;
    Gelesen     : integer;
    Satz        : FeldRecord; //Array[1..128] of char;
    MP3Tag      : MP3Record;// absolute Satz;
    MP3Kopf     : MP3KopfRecord;
    Mp3Satz     : Widestring;
    Lenge       : integer;
 //   K : integer;
       Abbruch : Boolean;

    function Konvert(I : integer) : integer;
    Var b :array[1..4] of byte;
        W : integer  absolute B;
        BByte : Byte;
    begin
      w := I;
      BByte := b[1];
      B[1] := b[4];
      b[4] := BByte;
      BByte := b[2];
      B[2] := b[3];
      b[3] := BByte;
      Result := W;
    end;

    function SatzLesen(S : FeldRecord) : string;
    Var k : integer;
        Abbruch : Boolean;
        Satz : string;
    begin
      Satz := '';//copy(satz,6,1);
      Abbruch := False;
      K := 6;
      repeat
        Satz := Satz + S[k];
        if k > lenge
          then Abbruch := true;
          inc(k,2);
      until Abbruch;
      Result := Satz;
    end;

begin
  DatName := 'i:\2014\Pascal\MP3Tag\Yes\07 - It Was All We Knew.mp3';

  if FileExists(DatName)
    then begin
  InputStream := TFileStream.Create(DatName,fmOpenReadWrite);
  satz [1] := ' ';
//  Gelesen     := InputStream.Read(Satz,Sizeof(satz));

  Gelesen     := InputStream.Read(MP3Kopf,Sizeof(MP3Kopf));
  Gelesen     := InputStream.Read(MP3Tag,Sizeof(MP3Tag));

  Lenge := Konvert(MP3Tag.Lenge);
  Setlength(MP3Satz,Lenge);
  Gelesen     := InputStream.Read(Satz,Lenge+2);
  MP3Satz := copy(satz,1,lenge);
(*
  Gelesen     := InputStream.Read(MP3Tag,Sizeof(MP3Tag));
  Lenge := Konvert(MP3Tag.Lenge);
  Gelesen     := InputStream.Read(Satz,Lenge+2);

  MP3Satz := SatzLesen(Satz);

  Gelesen     := InputStream.Read(MP3Tag,Sizeof(MP3Tag));
   Lenge := Konvert(MP3Tag.Lenge);
   Gelesen     := InputStream.Read(Satz,Lenge+2);
   MP3Satz := SatzLesen(Satz);

    Gelesen     := InputStream.Read(MP3Tag,Sizeof(MP3Tag));
   Lenge := Konvert(MP3Tag.Lenge);
   Gelesen     := InputStream.Read(Satz,Lenge+2);
   MP3Satz := SatzLesen(Satz);


   Gelesen     := InputStream.Read(MP3Tag,Sizeof(MP3Tag));
     Lenge := Konvert(MP3Tag.Lenge);
     Gelesen     := InputStream.Read(Satz,Lenge+2);
     MP3Satz := SatzLesen(Satz);

     Gelesen     := InputStream.Read(MP3Tag,Sizeof(MP3Tag));
        Lenge := Konvert(MP3Tag.Lenge);
        Gelesen     := InputStream.Read(Satz,Lenge+2);
        MP3Satz := SatzLesen(Satz);

        Gelesen     := InputStream.Read(MP3Tag,Sizeof(MP3Tag));
              Lenge := Konvert(MP3Tag.Lenge);
              Gelesen     := InputStream.Read(Satz,Lenge+2);
              MP3Satz := SatzLesen(Satz);

*)

  Abbruch := False;
  Repeat
    Gelesen := InputStream.Read(MP3Tag,Sizeof(MP3Tag));
    Lenge   := Konvert(MP3Tag.Lenge);
    Gelesen := InputStream.Read(Satz,Lenge+2);
    MP3Satz := SatzLesen(Satz);

    if Lenge = 0
      then Abbruch := true;
  until Abbruch;


  InputStream.Free;

    end
  else showmessage(DAtname + ' fehlt !');
end;


procedure TMusik.Anzeige(datei_name : string);
Var InputListe : Tstringlist;
    iMAX, i : integer;
    Satz : string;
begin
  if FileExists(datei_name)
    then begin
        InputListe := Tstringlist.Create;
        InputListe.LoadFromFile(datei_name);
          Imax := InputListe.count;
          ListBox1.Visible:= false;
          StringGrid1.RowCount:= Imax+1;

          For i := 0 to Imax -1 do
            begin
              Satz := InputListe[i];
              StringGrid1.Cells[0,i+1] := IntToStr(i+1);
              StringGrid1.Cells[1,i+1] := copy(InputListe[i],36,maxint);
              StringGrid1.Cells[2,i+1] := copy(Satz,37,2);
              StringGrid1.Cells[3,i+1] := copy(Satz,36,8);
              StringGrid1.Cells[4,i+1] := copy(Satz,40,3);
            end;
        InputListe.Free;

    end;
end;

function TMusik.DateiOeffnen : integer;
Var InputListe : Tstringlist;
    iMAX, i : integer;
    Satz : string;
begin
    Result := 0;
    opendialog1.InitialDir := Pfad;
    opendialog1.Filter     := 'File (*.m3u)|*.m3u|File (*.lst)|*.lst';

 //   Daten|*.dat|Radio *.m3u|*.m3u|Musik *.lst|*.lst|Alle|*.*

    if opendialog1.execute
      then Dateiname := opendialog1.Filename;
    if (Dateiname = '') or Not(FileExists(Dateiname))
      then Result := -10
      else begin
        InputListe := Tstringlist.Create;
        InputListe.LoadFromFile(Dateiname);
          Imax := InputListe.count;
          StringGrid1.RowCount:= Imax+1;

          For i := 0 to Imax -1 do
            begin
              Satz := InputListe[i];
              StringGrid1.Cells[0,i+1] := IntToStr(i+1);
              StringGrid1.Cells[1,i+1] := copy(InputListe[i],36,maxint);
              StringGrid1.Cells[2,i+1] := copy(Satz,37,2);
              StringGrid1.Cells[3,i+1] := copy(Satz,36,8);
              StringGrid1.Cells[4,i+1] := copy(Satz,40,3);
            end;
        InputListe.Free;
      end;
end;

procedure TMusik.Button5Click(Sender: TObject);
Var Suchfilter : string;
begin
//  DateiOeffnen;

  // neu a, 13.9.2014
 ListBox1.Visible:=True;
 Listbox1.Align:=alclient;
 //Nur beim MAC ???
 Suchfilter := lowercase('*.' + filter_str);
 Suchdat(Suchfilter);
// Anzeige;
end;

procedure TMusik.Filtern;
Var I,L, Imax : integer;
    Satz      : string;
begin
  Imax := Musikliste.count-1;
  L    := 1;
  StringGrid1.RowCount:= IMAX+2;

  For i := 0 to Imax Do
    begin
    Satz := uppercase(MusikListe[i]);
    if pos(Filter_Str,Satz) > 0
      then begin
            StringGrid1.Cells[0,L] := IntToStr(i+1);
            StringGrid1.Cells[1,L] := copy(MusikListe[i],36,maxint);
            StringGrid1.Cells[2,l] := copy(Satz,37,2);
            StringGrid1.Cells[3,L] := copy(Satz,36,8);
            StringGrid1.Cells[4,L] := copy(Satz,40,3);
            inc(l);
      end;
    end;

  StringGrid1.RowCount:= L;
end;

procedure TMusik.ComboBox1Change(Sender: TObject);
begin
  Filter_str := uppercase(ComboBox1.Text);
end;

procedure TMusik.FormDestroy(Sender: TObject);
begin
  MusikListe.Free;
  KopfZeile.Free;
end;

procedure TMusik.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key = 27 then Close;
  if Key = 13
    then Filtern;
end;

procedure TMusik.ListBox1Click(Sender: TObject);
Var Anzeige_Name : string;
begin
//  ShowMessage(Listbox1.Items[Listbox1.ItemIndex] );
  Anzeige_Name := Listbox1.Items[Listbox1.ItemIndex];
  Anzeige(Anzeige_Name);
end;

procedure TMusik.StringGrid1DblClick(Sender: TObject);
begin
  Showmessage('Play -->' + IntToStr(StringGrid1.Row) + ' | ' +  (StringGrid1.Cells[1,StringGrid1.Row] ));
end;

procedure TMusik.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  Var Column, Row, i : integer;
      Satz           : string;
      SpaltenAnzahl  : integer;

  begin
     Column := 0;
     Row    := 0;
     StringGrid1.MouseToCell(X, Y, Column, Row);

     SpaltenAnzahl := StringGrid1.ColCount;

     if (Row = 0) // and (TabAuswahl = poi)
     then // StringGrid1 nach der Spalte = Column sortieren
     begin
       Satz := StringGrid1.cells[Column, Row];

       for I := 0 to SpaltenAnzahl-1 do
         StringGrid1.cells[i,0] := Kopfzeile[i];

       if Satz[1] = '^'
       then begin
              Satz := 'v ' + Kopfzeile[Column];
              Vorwaertsschalter := true;
            end
       else begin
              Satz := '^ ' + Kopfzeile[Column];
              Vorwaertsschalter := false;
            end;

       StringGrid1.cells[Column, 0] := Satz;

       if Vorwaertsschalter
         then SortStringGrid(StringGrid1, Column, true)
         else SortStringGrid(StringGrid1, Column, false);
     end;
  end;

end.

