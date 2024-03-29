unit Radio_unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, Grids;


{const GenreListe :
 0. Blues
  1. Classic Rock
  2. Country
  3. Dance
  4. Disco
  5. Funk
  6. Grunge
  7. Hip-Hop
  8. Jazz
  9. Metal
 10. New Age
 11. Oldies
 12. Other
 13. Pop
 14. R&B
 15. Rap
 16. Reggae
 17. Rock
 18. Techno
 19. Industrial
 20. Alternative
 21. Ska
 22. Death Metal
 23. Pranks
 24. Soundtrack
 25. Euro-Techno
 26. Ambient
 27. Trip-Hop
 28. Vocal
 29. Jazz+Funk
 30. Fusion
 31. Trance
 32. Classical
 33. Instrumental
 34. Acid
 35. House
 36. Game
 37. Sound Clip
 38. Gospel
 39. Noise
 40. AlternRock
 41. Bass
 42. Soul
 43. Punk
 44. Space
 45. Meditative
 46. Instrumental Pop
 47. Instrumental Rock
 48. Ethnic
 49. Gothic
 50. Darkwave
 51. Techno-Industrial
 52. Electronic
 53. Pop-Folk
 54. Eurodance
 55. Dream
 56. Southern Rock
 57. Comedy
 58. Cult
 59. Gangsta
 60. Top 40
 61. Christian Rap
 62. Pop/Funk
 63. Jungle
 64. Native American
 65. Cabaret
 66. New Wave
 67. Psychadelic
 68. Rave
 69. Showtunes
 70. Trailer
 71. Lo-Fi
 72. Tribal
 73. Acid Punk
 74. Acid Jazz
 75. Polka
 76. Retro
 77. Musical
 78. Rock & Roll
 79. Hard Rock

The following genres are Winamp extensions

 80. Folk
 81. Folk-Rock
 82. National Folk
 83. Swing
 84. Fast Fusion
 85. Bebob
 86. Latin
 87. Revival
 88. Celtic
 89. Bluegrass
 90. Avantgarde
 91. Gothic Rock
 92. Progressive Rock
 93. Psychedelic Rock
 94. Symphonic Rock
 95. Slow Rock
 96. Big Band
 97. Chorus
 98. Easy Listening
 99. Acoustic
100. Humour
101. Speech
102. Chanson
103. Opera
104. Chamber Music
105. Sonata
106. Symphony
107. Booty Bass
108. Primus
109. Porn Groove
110. Satire
111. Slow Jam
112. Club
113. Tango
114. Samba
115. Folklore
116. Ballad
117. Power Ballad
118. Rhythmic Soul
119. Freestyle
120. Duet
121. Punk Rock
122. Drum Solo
123. A capella
124. Euro-House
125. Dance Hall

}
type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ComboBox1: TComboBox;
    Panel1: TPanel;
    Panel2: TPanel;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StringGrid1DblClick(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { private declarations }
    Dateiname  : string;
    KopfZeile  : Tstringlist;
    MusikListe : Tstringlist;
    Vorwaertsschalter : Boolean;

    Filter_Str : string;
    procedure Filtern;
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

uses StringgridTools;

procedure TForm1.FormCreate(Sender: TObject);
Var I, Imax : integer;
    Satz    : string;

begin
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
  else Showmessage(Dateiname + '  fehlt !');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
   Showmessage('Play -->' + IntToStr(StringGrid1.Row) + ' | ' +  (StringGrid1.Cells[1,StringGrid1.Row] ));
end;

procedure TForm1.Button3Click(Sender: TObject);
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

procedure TForm1.Button4Click(Sender: TObject);
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
    K : integer;
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
    Gelesen     := InputStream.Read(MP3Tag,Sizeof(MP3Tag));
    Lenge := Konvert(MP3Tag.Lenge);
    Gelesen     := InputStream.Read(Satz,Lenge+2);
    MP3Satz := SatzLesen(Satz);

    if Lenge = 0
      then Abbruch := true;
  until Abbruch;


  InputStream.Free;
end;

procedure TForm1.Filtern;
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

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  Filter_str := uppercase(ComboBox1.Text);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  MusikListe.Free;
  KopfZeile.Free;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key = 27 then Close;
  if Key = 13
    then Filtern;
end;

procedure TForm1.StringGrid1DblClick(Sender: TObject);
begin
  Showmessage('Play -->' + IntToStr(StringGrid1.Row) + ' | ' +  (StringGrid1.Cells[1,StringGrid1.Row] ));
end;

procedure TForm1.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
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

