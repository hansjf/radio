program lcdradio;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, lcd_radio, lcd_setup, lcd_sender,
  lcd_volumen, lcdtastatur, lcd_musik, lcd_var;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TRadio, Radio);
  Application.CreateForm(TLautstaerke, Lautstaerke);
  Application.CreateForm(TSenderwahl,Senderwahl);
  Application.CreateForm(Tsetup, setup);
  Application.CreateForm(TTastatur, Tastatur);
  Application.CreateForm(TMusik, Musik);
  Application.Run;
end.

