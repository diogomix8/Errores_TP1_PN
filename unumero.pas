  unit UNumero;

  {$mode objfpc}{$H+}

  interface

  uses
    Classes, SysUtils, Math;

  type
      { TNumero }
      TNumero = class
        numero : double; { Numero con parte fraccionaria }
        base : byte;     { Base del numero }
        tMantiza : byte; { Mantiza }

        private
           function expo(a,b:integer):longint;

        public
          { El Constructor crea un Nuevo Objeto del TNumero que contiene:
          n : El numero
          b : La base de Partida
          t : Cantidad de Digitos de Precision }
          constructor create(n:double; b:byte; t:byte);

          function corte(n:string; t:byte):string;
          function corteSimetrico(n:string;t,b:byte):string;
          function divisionReiterada(b:byte; n:integer):string;
          function multReiterada(baseLlegada:byte;numeroEntrada:double):string;
          function cambioBaseFraccion(basePartida,baseLlegada:byte;numeroEntrada:double):string;
          function fraccionADecimal(basePartida:byte;numeroEntrada:double):string;
          function normalizar(pe,pd:string; b:byte):string;

          {Setters y Getters}
          procedure setNumero(newN:double);
          function getNumero():double;
          procedure setBase(newBase:byte);
          function getBase():byte;
          procedure setTMantiza(newT:byte);
          function getTMantiza():byte;

          { Destructor }
          destructor destroyObject();
      end;



  implementation

  constructor TNumero.create(n:double; b:byte; t:byte);
  begin
       numero:=n;
       base:=b;
       tMantiza:=t;
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

  function TNumero.expo(a,b:integer):longint;
  var
    i: integer;
  begin
   if b<>0 then
   begin
     for i:= 2 to b do
       	  a:=a*a;
     end
   else
 	  a:=1;
  expo:= a;
  end;

  function TNumero.corteSimetrico(n:string;t,b:byte):string;
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
  function TNumero.divisionReiterada(b:byte; n:integer):string;
    var
          resto2:string;
          resto:integer;

    begin
         result:='';
         while (n>=b)do
           begin
              resto:= (n mod b);
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

  function TNumero.multReiterada(baseLlegada:byte;numeroEntrada:double):string; //el decimal a convertir debe de ser de tipo 0.*numeros*
  var
  i,parteEntera,error:integer;
  iter:double;
  b:boolean;
  numeroSalida:string;
  begin
    i:=1;
    { Convertimos en tipo numerico el numero pasado por string }
    //val(numeroEntrada,iter,error);
    iter := numeroEntrada;
    b:=true;
    while (i<10) and (b) do   //el 10 es cuantos digitos despues de la coma vamos a tomar
       begin
          iter:=iter*baseLlegada; //multiplico por la base
          parteEntera:=trunc(iter); //obtengo su parte entera
          if parteEntera<=9 then insert(IntToStr(parteEntera),numeroSalida,length(numeroSalida)+1)//en caso de ser base superior a 10 agrego los caracteres del alfabeto
           else
           begin
           if parteEntera=10 then insert('A',numeroSalida,length(numeroSalida)+1) //inserta el caracter 'A' en el string numeroSalida
           else
           if parteEntera=11 then insert('B',numeroSalida,length(numeroSalida)+1)
            else
           if parteEntera=12 then insert('C',numeroSalida,length(numeroSalida)+1)
           else
           if parteEntera=13 then insert('D',numeroSalida,length(numeroSalida)+1)
           else
           if parteEntera=14 then insert('E',numeroSalida,length(numeroSalida)+1)
           else
               insert('F',numeroSalida,length(numeroSalida)+1);
           end;
          iter:=iter-parteEntera;
          i:=i+1;
          if (iter=0) then b:=false; //para que no queden ceros sin valor al final
       end;
    result := numeroSalida;
  end;

  function TNumero.cambioBaseFraccion(basePartida,baseLlegada:byte;numeroEntrada:double):string;
  var
  sIntermedio, sNumSalida: string;
  dIntermedio : double;
  e : byte;
  begin
     if basePartida=10 then sNumSalida := multReiterada(baseLLegada,numeroEntrada)
     else
     begin
       if baseLlegada=10 then sNumSalida := fraccionADecimal(basePartida,numeroEntrada)
       else
       begin
           sIntermedio := fraccionADecimal(basePartida,numeroEntrada);
           Val(sIntermedio,dIntermedio,e);
           sNumSalida := multReiterada(baseLLegada,dIntermedio);
       end;
     end;
     result := sNumSalida;
  end;

  function TNumero.fraccionADecimal(basePartida:byte;numeroEntrada:double):string;
  var
  i,j,num,error:byte;
  aDecimal:double;
  sNumSalida,sNumEntrada:string;
  begin
    Str(numeroEntrada,sNumEntrada);
    aDecimal:=0;
    j:=1;
    for i:=3 to length(sNumEntrada) do
       begin
          if sNumEntrada[i]='A' then num:=10
          else
          begin
          if sNumEntrada[i]='B' then num:=11
           else
           begin
           if sNumEntrada[i]='C' then num:=12
           else
           if sNumEntrada[i]='D' then num:=13
            else
            if sNumEntrada[i]='E' then num:=14
             else
             if sNumEntrada[i]='F' then num:=15
              else
              val(sNumEntrada[i],num,error);
           end;
          end;
         aDecimal:=aDecimal+num*1/(basePartida)*j;
         j:=j+1;
       end;
   str(aDecimal,sNumSalida);
   result := sNumSalida;
end;



  function TNumero.normalizar(pe,pd:string; b:byte):string;
    var
         sNormalizado,sBase,exp:string;
         j,i,k,lengthNumero:byte;
    begin
         str(b,sBase);
         if (pe[1]<>'0') then
           begin
            lengthNumero:= length(pe);
            str(lengthNumero,exp);
            sNormalizado:= '0.'+pe+pd+'x'+sBase+'^'+exp;
           end
         else
            if pd[1]<>'0' then
               sNormalizado:='0.'+pd+'x'+sBase+'^'+'0'
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
               str(i,exp);
               sNormalizado:='0.'+pd+'x'+sBase+'^'+'-'+exp;
              end;
           result:= sNormalizado;
    end;

  procedure TNumero.setNumero(newN:double);
  begin
       numero := newN;
  end;

  function TNumero.getNumero():double;
  begin
       result := numero;
  end;

  procedure TNumero.setBase(newBase:byte);
  begin
       base := newBase;
  end;

  function TNumero.getBase():byte;
  begin
       result := base;
  end;

  procedure TNumero.setTMantiza(newT:byte);
  begin
       tMantiza := newT;
  end;

  function TNumero.getTMantiza():byte;
  begin
       result := tMantiza;
  end;

  { Liberamos la Memoria }
  destructor TNumero.destroyObject();
  begin
       inherited Destroy;
  end;

  end.

