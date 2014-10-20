unit lcd_tools;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils
   ,process // AsyncProcess,  ,
  // , FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  , Unix, BaseUnix
  ;


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


const
  PIN_ON  : PChar = '1';
  PIN_OFF : PChar = '0';

  Var  ZeitKurz : Boolean;
    TastenZeile : string;
// Var  Dimmerwert   : integer;

procedure Dimmen_EinSchalten;
procedure Dimmen_AusSchalten;

procedure ExPrGStarten(Kommando : string; DatName : string);
function Startextprg(s: string):integer;

implementation


procedure Dimmen_EinSchalten;
Var UP_filedes : integer;
    gReturnCode: longint; {stores the result of the IO operation}
begin
  try
    UP_filedes := fpopen('/sys/class/backlight/fb_ili9341/bl_power', O_WrOnly);
    gReturnCode := fpwrite(UP_filedes, PIN_OFF[0], 1);
  finally
    gReturnCode := fpclose(UP_filedes);
  end;
end;


procedure Dimmen_AusSchalten;
Var UP_filedes : integer;
    gReturnCode: longint; {stores the result of the IO operation}
begin
  try
    UP_filedes := fpopen('/sys/class/backlight/fb_ili9341/bl_power', O_WrOnly);
    gReturnCode := fpwrite(UP_filedes, PIN_ON[0], 1);
  finally
    gReturnCode := fpclose(UP_filedes);
  end;
end;



procedure ExPrGStarten(Kommando : string; DatName : string);
var AProcess: TProcess;
    AStringList: TStringList;

// Ab hier startet Ihr Programm
begin
  // Jetzt erzeugen wir das TProcess Objekt und
  // ordnen es der Variablen AProcess zu.
  AProcess := TProcess.Create(nil);

  // Erzeugen des TStringList Objekts.
  AStringList := TStringList.Create;

  // Gibt an, welcher Befehl vom Prozess ausgefÃ¼hrt werden soll
  // Lassen sie uns den FreePascal Compiler verwenden
  // AProcess.CommandLine := 'ppc386 -h';
  AProcess.CommandLine := Kommando;

  // Wir definieren eine Option, wie das Programm
  // ausgefÃ¼hrt werden soll. Dies stellt sicher, dass
  // unser Programm nicht vor Beendigung des aufgerufenen
  // Programmes fortgesetzt wird. AuÃerdem geben wir an,
  // dass wir die Ausgabe lesen wollen
  AProcess.Options := AProcess.Options + [poWaitOnExit, poUsePipes];

  // Startet den Prozess, nachdem die Parameter entsprechend
  // gesetzt sind
  AProcess.Execute;

  // Folgendes wird erst nach Beendigung von ppc386 ausgefÃ¼hrt

  // Die Ausgabe wird nun in die Stringliste gelesen
  AStringList.LoadFromStream(AProcess.Output);

  // Speichert den output in eine Datei.
//  AStringList.SaveToFile('output.txt');

 //  AStringList.SaveToFile(Austauschdateiname);
     AStringList.SaveToFile(datname);

  // Nun da die Datei gespeichert ist kÃ¶nnen wir
  // TStringList und TProcess freigeben.
  AStringList.Free;
  AProcess.Free;
end;

function Startextprg(s: string):integer;
Var RunProgram :  TProcess;
begin
    RunProgram := TProcess.Create(nil);
    RunProgram.CommandLine := S;
    RunProgram.Options := RunProgram.Options + [poWaitOnExit];
     {$IFDEF LINUX}
      RunProgram.Execute;
      {$ENDIF}
    RunProgram.Free;
end;

end.

