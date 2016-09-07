unit UFormMainErrores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, UNumero;

type

  { TFormMainErroes }

  TFormMainErroes = class(TForm)
    ButtonClean: TButton;
    ButtonConvert: TButton;
    ComboBoxBaseDeparture: TComboBox;
    ComboBoxTDigit: TComboBox;
    ComboBoxBaseArrival: TComboBox;
    EditNumber: TEdit;
    LabelBasePartida: TLabel;
    LabelQuantityDigit: TLabel;
    LabelTitleNumber: TLabel;
    LabelShowNumberCutS: TLabel;
    LabelShowNumberCut: TLabel;
    LabelCutS: TLabel;
    LabelTitleFormat: TLabel;
    LabelCut: TLabel;
    LabelShowNormalized: TLabel;
    LabelNormalized: TLabel;
    LabelShowPFN: TLabel;
    LabelPFN: TLabel;
    LabelShowNumberConvert: TLabel;
    LabelShowBase: TLabel;
    LabelNumber: TLabel;
    LabelBaseConvert: TLabel;
    LabelEnterNumber: TLabel;
    PanelShowRepresents: TPanel;
    PanelNumberConvert: TPanel;
    procedure ButtonCleanClick(Sender: TObject);
    procedure ButtonConvertClick(Sender: TObject);
    procedure CloseMain(Sender: TObject; var CloseAction: TCloseAction);
    procedure ComboBoxBaseArrivalChange(Sender: TObject);
    procedure ComboBoxBaseDepartureChange(Sender: TObject);
    procedure ComboBoxTDigitChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  FormMainErroes: TFormMainErroes;
  Numero: TNumero; {Objetos de la clase TNumero}
  sNumero, sNumeroConv, sBaseArrival, sBaseDeparture, sMantiza: string; {Numero en String, Convertido y Bases}
  sPartEntera, sParteDecimal, sParteEnteraConv, sParteDecimalConv: string;
  sNumeroNormalizado : string;
  sCorteSimetrico, sCorte, cadAux : string;
  bBaseArrival, bBaseDeparture, bMantiza, e, t : byte;  {Base B´ y "e" es el error para Val()}

implementation

{$R *.lfm}

{ TFormMainErroes }

procedure TFormMainErroes.ButtonConvertClick(Sender: TObject);
begin
  { Recibimos el numero del TEdit}
  sNumero:=EditNumber.Text;
  { Recibimos del ComoboBox la Base de Partida y la convertimos a byte}
  Val(sBaseDeparture,bBaseDeparture,e);
  { Lo mismo hacemos con el Digito de Presicion "t" }
  Val(sMantiza,bMantiza,e);
  { Una vez que tenemos los 3 datos para el Numero, instanciamos el Objeto de TNumero }
  Numero := TNumero.create(sNumero,bBaseDeparture,bMantiza);
  { Luego la base de llegada }
  Val(sBaseArrival,bBaseArrival,e);
  { ---- Verificamos que la Base de Partida y la Base de Llegada no sean las mismas ---- }
  if (bBaseDeparture = bBaseArrival) then
    begin
      ShowMessage('La Base de Partida es la misma que la Base de Llegada.'+sLineBreak+'Por Favor, verifique los datos para poder continuar.');
    end
  else
    begin
      { ************* CARGA DE DATOS EN EL PANEL DE CONVERSIÓN DE NUMEROS *********** }
      { Obtenemos la Parte Entera del Numero ingresado y lo guardamos en una variable }
      sPartEntera := Numero.calcularPEntera();
      { Ahora obtenemos la Parte Decimal del Numero y lo guardamos en otra variable }
      sParteDecimal:= Numero.calcularPDecimal();
      { Una vez que tenemos ambas parte calculadas, lo que hacemos es convertirlas en la Base de Llegada }
      { Primero la Parte Entera}
      sParteEnteraConv:=Numero.divisionReiterada(bBaseArrival,sPartEntera);
      { Luego la Parte Decimal}
      sParteDecimalConv:=Numero.cambioBaseFraccion(Numero.getBase(),bBaseArrival,sParteDecimal);
      { Ahora unimos ambas partes para mostrar en la pantalla }
      sNumeroConv:=sParteEnteraConv+','+sParteDecimalConv;
      { Normalizamos el Numero Convertido y lo guardamos como un String }
      sNumeroNormalizado:=Numero.normalizar(sParteEnteraConv,sParteDecimalConv,bBaseArrival);

      { ******** CARGA DE DATOS EN EL PANEL DE FORMATOS DE REPRESENTACIÓN *********** }
      {}
      { Realizamos el Corte Simetrico del Numero  }
      sCorteSimetrico:=Numero.corteSimetrico(sNumeroNormalizado,Numero.getTMantiza(),bBaseArrival);
      {}
      sCorte:=Numero.corte(sNumeroNormalizado,Numero.getTMantiza());
      // Muestas en la Interfaz
      LabelShowNumberConvert.Caption:=sNumeroConv;
      LabelShowBase.Caption:=sBaseArrival+') =';
      LabelShowPFN.Caption:=sNumeroNormalizado;
      LabelShowNormalized.Caption:=sNumeroConv;
      { Redondeo por Corte }
      LabelShowNumberCut.Caption:=sCorte;
      { Redondeo por Corte Simetrico }
      LabelShowNumberCutS.Caption:=sCorteSimetrico;
      end;

  end;

procedure TFormMainErroes.CloseMain(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  ShowMessage('----- INTEGRANTES DEL GRUPO ------'+sLineBreak+
  'MOGRO, Guillermo'+sLineBreak+'MIRO, Brian'+sLineBreak+'PALACIO, Diego'+sLineBreak+'OROZCO, Eliseo'
  +sLineBreak+'BARBOSA, Emanuel'+sLineBreak+ 'Pablo, Nicolas'+sLineBreak+'ALANCAY, Kevin');
end;

{ ------------- BUTTON "LIMPIAR" ----------------------}
procedure TFormMainErroes.ButtonCleanClick(Sender: TObject);
begin
  { Limpiamos todos los campos para poder ingresar nuevos datos }
  EditNumber.Text:='';
  ComboBoxBaseDeparture.Text:='Base de Partida';
  ComboBoxBaseArrival.Text:='Base de Llegada';
  ComboBoxTDigit.Text:='Mantiza';

  { **************** PANEL "CONVERSION DE NUMEROS" *************************}
  LabelShowBase.Caption:='';LabelShowNumberConvert.Caption:='';LabelShowNormalized.Caption:='';
  LabelShowPFN.Caption:='';

  { **************** PANEL "FOMATOS DE REPRESENTACION" *************************}
  LabelShowNumberCut.Caption:='';LabelShowNumberCutS.Caption:='';

  { Por ultimo limpiamos la memoria que contenia al Objeto Numero}
  Numero.destroyObject();
end;

procedure TFormMainErroes.ComboBoxBaseDepartureChange(Sender: TObject);
begin
  { Asignamos el valor de la Base de Partida del ComboBox }
  case ComboBoxBaseDeparture.ItemIndex of
       0 : sBaseDeparture:='2';
       1 : sBaseDeparture:='3';
       2 : sBaseDeparture:='4';
       3 : sBaseDeparture:='5';
       4 : sBaseDeparture:='6';
       5 : sBaseDeparture:='7';
       6 : sBaseDeparture:='8';
       7 : sBaseDeparture:='9';
       8 : sBaseDeparture:='10';
       9 : sBaseDeparture:='11';
       10 : sBaseDeparture:='12';
       11 : sBaseDeparture:='13';
       12 : sBaseDeparture:='14';
       13 : sBaseDeparture:='15';
       14 : sBaseDeparture:='16';
  end;
end;

procedure TFormMainErroes.ComboBoxTDigitChange(Sender: TObject);
begin
  { Asignamos el valor del Digito de Presicion del ComboBox }
  case ComboBoxTDigit.ItemIndex of
       0 : sMantiza:='1';
       1 : sMantiza:='2';
       2 : sMantiza:='3';
       3 : sMantiza:='4';
       4 : sMantiza:='5';
       5 : sMantiza:='6';
       6 : sMantiza:='7';
       7 : sMantiza:='8';
       8 : sMantiza:='9';
       9 : sMantiza:='10';
       10 : sMantiza:='11';
       11 : sMantiza:='12';
  end;
end;


procedure TFormMainErroes.ComboBoxBaseArrivalChange(Sender: TObject);
begin
  { Asignamos el valor de la Base de Llegada del ComboBox }
  case ComboBoxBaseArrival.ItemIndex of
       0 : sBaseArrival:='2';
       1 : sBaseArrival:='3';
       2 : sBaseArrival:='4';
       3 : sBaseArrival:='5';
       4 : sBaseArrival:='6';
       5 : sBaseArrival:='7';
       6 : sBaseArrival:='8';
       7 : sBaseArrival:='9';
       8 : sBaseArrival:='10';
       9 : sBaseArrival:='11';
       10 : sBaseArrival:='12';
       11 : sBaseArrival:='13';
       12 : sBaseArrival:='14';
       13 : sBaseArrival:='15';
       14 : sBaseArrival:='16';
  end;
end;

end.

