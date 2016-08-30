unit UFormMainErrores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, StdCtrls, UNumero;

type

  { TErrores }

  TErrores = class(TForm)
    BarMenu: TMainMenu;
    ButtonConvert: TButton;
    ComboBoxBase: TComboBox;
    EditNumber: TEdit;
    LabelPFN: TLabel;
    LabelNotN: TLabel;
    LabelShowNumberConvert: TLabel;
    LabelShowBase: TLabel;
    LabelBaseConvert: TLabel;
    LabelOptionBaseConvert: TLabel;
    LabelNumber: TLabel;
    MenuArchive: TMenuItem;
    MenuAbout: TMenuItem;
    ItemArchiveConvert: TMenuItem;
    ItemAbout: TMenuItem;
    ItemArchiveRepresnt: TMenuItem;
    PanelShowNumber: TPanel;
    PanelConvertNumber: TPanel;
    procedure ButtonConvertClick(Sender: TObject);
    procedure ItemArchiveConvertClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Errores: TErrores;
  Numero1 : TNumero;
  e : byte;

implementation

{$R *.lfm}

{ TErrores }

procedure TErrores.ItemArchiveConvertClick(Sender: TObject);
begin
    { Hacemos Visible los paneles del menu Archivo }
    PanelConvertNumber.Visible:=true;
    PanelShowNumber.Visible:=true;

end;

procedure TErrores.ButtonConvertClick(Sender: TObject);
var
  textNumber : string;
begin
  Numero1 := TNumero.create(); // Instanciamos el Objeto
  { Recibimos el numero como un String del Edit }
  textNumber:=EditNumber.Text;
  LabelShowNumberConvert.Caption:=textNumber;
end;

end.

