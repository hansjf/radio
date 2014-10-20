unit unix;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;


const O_RdOnly = True;
      O_WrOnly = False;

function fpopen(s : string;w : Boolean) : integer;
function fpread(W : integer;S : String;W2 : integer) : integer;
function fpclose(W : integer) : integer;
function  fpwrite(W : integer; s : string; W2 : integer) : integer;

implementation


//fpopen('/sys/class/gpio/gpio30/value', O_RdOnly);

function fpopen(s : string;w : Boolean) : integer;
begin

end;



//fpread(fileDesc, buttonStatus[1], 1);

function fpread(W : integer;S : String;W2 : integer): integer;
begin

end;

//fpclose(fileDesc);

function fpclose(W : integer) : integer;
begin

end;

//fpwrite(fileDesc, PIN_29[0], 2);

function  fpwrite(W : integer; s : string; W2 : integer) : integer;
begin

end;

end.

