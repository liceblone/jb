unit UExportToExcel;

interface
  uses Classes,ZLib, Windows, Messages, SysUtils, Variants,  Graphics, Controls, Forms, DB, ADODB,
  Dialogs, StdCtrls,Jpeg , DBGrids,Excel2000,ComObj,ActiveX;

  procedure QExportExcel(AdbGrid:TDBGrid;Fn:String;Vis:Boolean ;RepeatCnt:integer=1);//zxh 08.2.18
implementation
 procedure QExportExcel(AdbGrid:TDBGrid;Fn:String;Vis:Boolean ;RepeatCnt:integer=1);//zxh 08.2.18
var
  ExcelApp: Variant;
  i,j,m,ii,p,MaxVisiableIndex:integer;
  k: Array [0..100] of integer;
  CellValue:string;
begin
  try
      ExcelApp := CreateOleObject('Excel.Application');
  except
      application.MessageBox('系统中的MS Excel软件没有安装或安装不正确！','错误',MB_ICONERROR+MB_OK);
      exit;
  end;
  ExcelApp.visible:=vis;
  try
   begin
    excelapp.caption:=fn;//'应用程序调用 Microsoft Excel';
    ExcelApp.WorkBooks.Add;
    //写入标题行
    m:=1;
    for i := 1 to AdbGrid.Columns.Count do
     begin
      if AdbGrid.Columns[i-1].Visible then
      begin
          k[i]:=1;
          if i>MaxVisiableIndex then MaxVisiableIndex:=i;
      end
      else
          k[i]:=0;
     end;

    for p:=0 to  RepeatCnt-1 do
    for i := 1 to AdbGrid.Columns.Count do
    begin
      if k[i]=1 then
        begin
           ExcelApp.Cells[1,m+p].Value := AdbGrid.Columns[i - 1].Title.Caption;
           if i< MaxVisiableIndex then
           inc(m);
        end;
    end;

      if   AdbGrid.DataSource.DataSet.IsEmpty then exit;
      AdbGrid.DataSource.DataSet.DisableControls ;
      with AdbGrid.DataSource.DataSet do
       begin
        First;
        i:=2;
         while not Eof do
         begin
              m:=0;
              for p:=0 to  RepeatCnt-1 do
              begin
                if not Eof then
                for j := 0 to AdbGrid.Columns.Count - 1 do
                begin
                  if k[j+1]=1 then
                  begin
                    if FindField (AdbGrid.Columns[j].FieldName )=nil then
                      CellValue:=''
                    else
                    begin
                      CellValue:=trim(FieldByName(AdbGrid.Columns[j].FieldName).AsString) ;

                      if  (   ADbGrid.DataSource.DataSet.FieldByName ( AdbGrid.Columns[j].FieldName)is  TNumericField)  then
                          ExcelApp.Cells[i,m+1+p].NumberFormatLocal:='0.000000'//TChyColumn(AdbGrid.Columns[j]).DeciamlFormat
                      else
                              ExcelApp.Cells[i,m+1+p].NumberFormatLocal:='@';

                    end;
                    ExcelApp.Cells[i,m+1+p].value := CellValue;
                    if j< MaxVisiableIndex - 1 then
                    inc(m);
                  end;
                end;
                Next;
              end;
           // Next;
            Inc(i);
           end;
       end;
       {if TModelDbGrid(AdbGrid).NeedSumRow then
          for j := 0 to AdbGrid.Columns.Count - 1 do
           if  AdbGrid.Columns[j].Visible then
           if  (   ADbGrid.DataSource.DataSet.FieldByName ( AdbGrid.Columns[j].FieldName)is  TNumericField)  then
           begin
                ExcelApp.Cells[i,m-2 +p].NumberFormatLocal:=TChyColumn(AdbGrid.Columns[j]).DeciamlFormat ;
                ExcelApp.Cells[i,m -2+p].value := TChyColumn(AdbGrid.Columns[j]).GroupValue ;
           end; }

     end;
  finally
    AdbGrid.DataSource.DataSet.EnableControls  ;
    //excelapp.quit; //退出EXCEL软件
  end;
end;

end.
 