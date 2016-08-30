  unit UNumero;

  {$mode objfpc}{$H+}

  interface

  uses
    Classes, SysUtils;

  type
      TNumero = class
        numero : double;
        base : byte;
        constructor create();
        function corte(n:string; t:byte):string;
        function cortesimetrico(n:string;t,b:byte):string;
        function conversion(b:byte; n:integer):string;
        function mult_reiterada(n:real; b:byte):string;
        function normalizar(pe,pd:string; b:byte):string;
      end;



  implementation

  constructor TNumero.create();
  begin

  end;

  function TNumero.corte(n:string; t:byte):string;
       var
            p:byte;
            cad:string;
       begin
            p:=pos('x',n);
            cad:=copy(n,p,length(n));
            delete(n,3+t,length(n));
            result:=n+cad;
       end;

  function TNumero.cortesimetrico(n:string;t,b:byte):string;
       var
           ac,a,digito,d:integer;
           c:char;
           cad,cadena,l:string;
           t1,p:byte;
       begin
            t1:=0;
            c:= n[t+3];
            if((c='A')or(c='B')or(c='C')or(c='D')or(c='E')or(c='F'))then
            begin
               case c of
               'A': digito:=10;
               'B': digito:=11;
               'C': digito:=12;
               'D': digito:=13;
               'E': digito:=14;
               'F': digito:=15;
               end;
            end
            else
            begin
                 val(c,digito,a);
            end;
            ac:=1;
            p:=pos('x',n);
            cad:=copy(n,p,length(n));
            if(t<=length(n))then
               begin
               if(digito>=b/2)then
                   begin
                          c:=n[t+2];

                          if((c='A')or(c='B')or(c='C')or(c='D')or(c='E')or(c='F'))then
                           begin
                           case c of
                             'A': d:=10;
                             'B': d:=11;
                             'C': d:=12;
                             'D': d:=13;
                             'E': d:=14;
                             'F': d:=15;
                             end;
                           d:=d+1;
                          end
                         else
                         begin val(c,d,a);

                          d:=d+1;
                          end;
                          if(d=b)then
                                     begin

                                         str(d,l);
                                         c:=l[1];
                                         l:='';
                                         n[t+2]:=c;
                                         t:=t-1;
                                         ac:=1;
                                        while((ac=1) and (t<>0))do
                                                       begin
                                                           c:=n[t+2];
                                                           if((c='A')or(c='B')or(c='C')or(c='D')or(c='E')or(c='F'))then
                                                      begin
                                                        case c of
                                                        'A': d:=10;
                                                        'B': d:=11;
                                                        'C': d:=12;
                                                        'D': d:=13;
                                                        'E': d:=14;
                                                        'F': d:=15;
                                                        end;
                                                         d:=d+1;
                                                      end
                                                         else
                                                         begin val(c,d,a);
                                                           d:=d+1;
                                                           end;
                                                       if(d=b)then
                                                                  begin
                                                                      d:=0;
                                                                      str(d,l);
                                                                       c:=l[1];
                                                                       l:='';
                                                                      n[t+2]:=c;
                                                                      t:=t-1;
                                                                      ac:=1;
                                                                    end
                                                      else
                                                           begin
                                                             if(d>=10)then
                                                               begin
                                                                 case d of
                                                                       10: c:='A';
                                                                       11: c:='B';
                                                                        12: c:='C';
                                                                         13: c:='D';
                                                                        14: c:='E';
                                                                        15: c:='F';
                                                                      end;
                                                                end
                                                             else begin
                                                               str(d,l);
                                                             c:=l[1];
                                                             l:='';end;
                                                             n[t+2]:=c;
                                                              t:=t-1;
                                                              ac:=0;

                                                            end
                                                      end;
                                    if(n[3]='0')then
                                               begin cadena:=copy(n,3,t1+3);
                                                  delete(cadena,t+1,length(n));
                                                  p:=pos('^',cad);
                                                  c:=cad[p+1]; val(c,d,a); d:=d+1;  str(d,l); c:=l[1]; l:=''; cad[p+1]:=c;
                                                  result:='0'+','+'1'+cadena+cad;
                                               end
                                    else begin
                                    delete(n,3+t,length(n));
                                           result:=n;
                                         end;
                                   end
                          else
                             begin
                              str(d,l);
                              c:=l[1];
                              n[t+2]:=c;
                              delete(n,3+t,length(n));
                              result:=n+cad;
                             end;
                  end

                             else
                                begin
                                result:=corte(n,t);
                               end;
               end
               else
                begin
                 result:=corte(n,t);
               end;
       end;
  function TNumero.conversion(b:byte; n:integer):string;
    var
          resto2:string;
          resto:integer;

    begin
         result:='';
         while (n>=b)do
           begin
              resto:= n mod b;
              n:=n div b;
              if resto in [10..16] then
                 begin
                     case resto of
                         10: resto2:='A';
                         11: resto2:='B';
                         12: resto2:='C';
                         13: resto2:='D';
                         14: resto2:='E';
                         15: resto2:='F';
                     end;
                 end
              else
                 str(resto,resto2);
              result:=resto2+result;
           end;
           if n in [10..16] then
              begin
                case n of
                   10: resto2:='A';
                   11: resto2:='B';
                   12: resto2:='C';
                   13: resto2:='D';
                   14: resto2:='E';
                   15: resto2:='F';
                end;
              end
           else
              str(n,resto2);
         result:=resto2+result;
    end;

  function TNumero.mult_reiterada(n:real; b:byte):string;
    var
         pent:string;
         partent,iter:byte;

    begin
         result:='';
         iter:=0;
         while (iter<=9) and (n<>0) do
          begin
               n:= n*b;
               partent:=trunc(n);
               n:= n-partent;
               if partent in [10..16] then
               begin
                 case partent of
                    10: pent:='A';
                    11: pent:='B';
                    12: pent:='C';
                    13: pent:='D';
                    14: pent:='E';
                    15: pent:='F';
                 end;
               end
               else
                 str(partent,pent);
               result:=result+pent;
               iter:=iter+1;
          end;
    end;

  function TNumero.normalizar(pe,pd:string; b:byte):string;
    var
         norm,base2,ex:string;
         j,i,cd,k:byte;
    begin
         str(b,base2);
         if (pe[1]<>'0') then
           begin
            cd:= length(pe);
            str(cd,ex);
            norm:= '0.'+pe+pd+'x'+base2+'^'+ex;
           end
         else
            if pd[1]<>'0' then
               norm:='0.'+pd+'x'+base2+'^'+'0'
            else
              begin
               i:=1;
               k:=1;
               while (pd[1]='0') do
                 begin
                     for j:=i to length(pd)-1 do
                       pd[j]:=pd[j+1];
                       delete(pd,length(pd),1);
                   k:=k+1;
                 end;
               i:=k-1;
               str(i,ex);
               norm:='0.'+pd+'x'+base2+'^'+'-'+ex;
              end;
           result:= norm;
    end;

  end.

