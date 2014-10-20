unit StringgridTools;

interface

Uses Grids, Classes;

procedure SortStringGrid(var GenStrGrid: TStringGrid; ThatCol: Integer;Vorwaerts:boolean);


implementation

procedure SortStringGrid(var GenStrGrid: TStringGrid; ThatCol: Integer;Vorwaerts:boolean);
const // Define the Separator
//  TheSeparator = '@';
    TheSeparator = '�';
var
  CountItem, I, J, K, ThePosition: integer;
  MyList: TStringList;
  MyString, TempString: string;
begin
  // Give the number of rows in the StringGrid
  CountItem := GenStrGrid.RowCount;
  //Create the List
  MyList        := TStringList.Create;
  MyList.Sorted := False;
  try
    begin
      for I := 1 to (CountItem - 1) do
        MyList.Add(GenStrGrid.Rows[I].Strings[ThatCol] + TheSeparator +
          GenStrGrid.Rows[I].Text);
      //Sort the List
      Mylist.Sort;

      for K := 1 to Mylist.Count do
      begin
        //Take the String of the line (K � 1)
        MyString := MyList.Strings[(K - 1)];
        //Find the position of the Separator in the String
        ThePosition := Pos(TheSeparator, MyString);
        TempString  := '';
        {Eliminate the Text of the column on which we have sorted the StringGrid}
        TempString := Copy(MyString, (ThePosition + 1), Length(MyString));
        MyList.Strings[(K - 1)] := '';
        MyList.Strings[(K - 1)] := TempString;
      end;

      // Refill the StringGrid
{        for J := 1 to (CountItem - 1) do    //Vorw�rts
          begin
          tempstring := MyList.Strings[(J - 1)];
          GenStrGrid.Rows[J].Text := MyList.Strings[(J - 1)];
          end;
}
      if Vorwaerts
        then for J := 1 to (CountItem - 1) do    //Vorw�rts
          GenStrGrid.Rows[J].Text := MyList.Strings[(J - 1)]
//            GenStrGrid.Rows[J].Text := MyList.Strings[(J)]
        else for J := 1 to (CountItem - 1) do    //R�ckw�rts
          GenStrGrid.Rows[CountItem-j].Text := MyList.Strings[(J - 1)];
//            GenStrGrid.Rows[CountItem-j].Text := MyList.Strings[(J)];
    end;
  finally
    //Free the List
    MyList.Free;
  end;
end;


end.