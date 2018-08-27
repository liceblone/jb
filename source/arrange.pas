unit arrange;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,StdCtrls;

procedure LeftSide(fParent:TWinControl;fSelectedColor:TColor);
procedure RightSide(fParent:TWinControl;fSelectedColor:TColor);
procedure TopSide(fParent:TWinControl;fSelectedColor:TColor);
procedure BottomSide(fParent:TWinControl;fSelectedColor:TColor);
procedure HCenter(fParent:TWinControl;fSelectedColor:TColor);
procedure VCenter(fParent:TWinControl;fSelectedColor:TColor);
procedure HAverage(fParent:TWinControl;fSelectedColor:TColor);
procedure VAverage(fParent:TWinControl;fSelectedColor:TColor);
procedure HMove(fParent:TWinControl;fSelectedColor:TColor);
procedure VMove(fParent:TWinControl;fSelectedColor:TColor);


implementation

procedure LeftSide(fParent:TWinControl;fSelectedColor:TColor);
 var i,lp:integer;
begin
 lp:=0;
 with fParent do
 begin
   for i:=0 to ControlCount-1 do
   begin
     if TEdit(Controls[i]).Color=fSelectedColor then
     begin
       if lp=0 then
          lp:=Controls[i].Left
       else
          Controls[i].Left:=lp;
     end;
   end;
 end;
end;

procedure RightSide(fParent:TWinControl;fSelectedColor:TColor);
 var i,lp,w:integer;
begin
 lp:=0;
 with fParent do
 begin
   for i:=0 to ControlCount-1 do
   begin
     if TEdit(Controls[i]).Color=fSelectedColor then
     begin
       w:=Controls[i].Width;
       if lp=0 then
          lp:=Controls[i].Left+w
       else
          Controls[i].Left:=lp-w;
     end;
   end;
 end;
end;

procedure HCenter(fParent:TWinControl;fSelectedColor:TColor);
 var i,lp,w:integer;
begin
 lp:=0;
 with fParent do
 begin
   for i:=0 to ControlCount-1 do
   begin
     if TEdit(Controls[i]).Color=fSelectedColor then
     begin
       w:=Controls[i].Width div 2;
       if lp=0 then
          lp:=Controls[i].Left+w
       else
          Controls[i].Left:=lp-w;
     end;
   end;  
 end;
end;

procedure VCenter(fParent:TWinControl;fSelectedColor:TColor);
 var i,lp,w:integer;
begin
 lp:=0;
 with fParent do
 begin
   for i:=0 to ControlCount-1 do
   begin
     if TEdit(Controls[i]).Color=fSelectedColor then
     begin
       w:=Controls[i].Height div 2;
       if lp=0 then
          lp:=Controls[i].Top+w
        else
          Controls[i].Top:=lp-w;
     end;
   end;
 end;
end;

procedure HAverage(fParent:TWinControl;fSelectedColor:TColor);
 var i,t,b,c,ii,v,h,hh:integer;
begin
 c:=-1;
 t:=0;
 b:=0;
 ii:=0;
 hh:=0;
 with fParent do
 begin
   for i:=0 to ControlCount-1 do
   begin
     if TEdit(Controls[i]).Color=fSelectedColor then
     begin
       c:=c+1;
       v:=Controls[i].Left;
       h:=Controls[i].Width;
       hh:=hh+h;
       if (v<t) or (t=0) then
          t:=v;
       v:=v+h;
       if (v>b) or (b=0) then
          b:=v;
     end;
   end;
   for i:=0 to ControlCount-1 do
   begin
     if TEdit(Controls[i]).Color=fSelectedColor then
     begin
       if ii<>0 then
          Controls[i].Left:=ii+(b-t-hh) div c;
       ii:=Controls[i].Left+Controls[i].Width;
     end;
   end;
 end;
end;

procedure VAverage(fParent:TWinControl;fSelectedColor:TColor);
 var i,t,b,c,ii,v,h,hh:integer;
begin
 c:=-1;
 t:=0;
 b:=0;
 ii:=0;
 hh:=0;
 with fParent do
 begin
   for i:=0 to ControlCount-1 do
   begin
     if TEdit(Controls[i]).Color=fSelectedColor then
     begin
       c:=c+1;
       v:=Controls[i].Top;
       h:=Controls[i].Height;
       hh:=hh+h;
       if (v<t) or (t=0) then
          t:=v;
       v:=v+h;
       if (v>b) or (b=0) then
          b:=v;
     end;
   end;
   for i:=0 to ControlCount-1 do
   begin
     if TEdit(Controls[i]).Color=fSelectedColor then
     begin
       if ii<>0 then
          Controls[i].Top:=ii+(b-t-hh) div c;
       ii:=Controls[i].Top+Controls[i].Height;
     end;
   end;
 end;
end;

procedure TopSide(fParent:TWinControl;fSelectedColor:TColor);
 var i,t:integer;
begin
 t:=0;
 with fParent do
 begin
   for i:=0 to ControlCount-1 do
   begin
     if TEdit(Controls[i]).Color=fSelectedColor then
     begin
       if t=0 then
          t:=Controls[i].Top
       else
          Controls[i].Top:=t;
     end;
   end;
 end;
end;

procedure BottomSide(fParent:TWinControl;fSelectedColor:TColor);
 var i,t,h:integer;
begin
 t:=0;
 with fParent do
 begin
   for i:=0 to ControlCount-1 do
   begin
     if TEdit(Controls[i]).Color=fSelectedColor then
     begin
        h:=Controls[i].Height;
        if t=0 then
           t:=Controls[i].Top+h
        else
           Controls[i].Top:=t-h;
     end;
   end;
 end;
end;

procedure VMove(fParent:TWinControl;fSelectedColor:TColor);
 var i:integer;s:String;
begin
  if InputQuery(' ‰»Î','«Î ‰»Î…œœ¬“∆∂Øæ‡¿Î:',s) then
    with fParent do
    begin
      for i:=0 to ControlCount-1 do
      begin
        with TEdit(Controls[i]) do
          if Color=fSelectedColor then
             Top:=Top+strToint(s);
      end;
    end;
end;

procedure HMove(fParent:TWinControl;fSelectedColor:TColor);
 var i:integer;s:String;
begin
  if InputQuery(' ‰»Î','«Î ‰»Î◊Û”““∆∂Øæ‡¿Î:',s) then
    with fParent do
    begin
      for i:=0 to ControlCount-1 do
      begin
         with TEdit(Controls[i]) do
              if Color=fSelectedColor then
                 Left:=Left+strToint(s);
      end;
    end;
end;

end.
