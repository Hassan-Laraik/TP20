unit uClients;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids, StdCtrls,
  ExtCtrls, DateTimePicker;

type

  { TFrmClients }

  TFrmClients = class(TForm)
    BtnRechercger: TButton;
    BtnAjouter: TButton;
    DateNaissance: TDateTimePicker;
    DBGrid1: TDBGrid;
    edtNom: TEdit;
    EdtPrenom: TEdit;
    edtPhoen: TEdit;
    EdtRecherchzr: TEdit;
    MemAdresse: TMemo;
    RadioGroup1: TRadioGroup;
    procedure BtnAjouterClick(Sender: TObject);
    procedure BtnRechercgerClick(Sender: TObject);
  private

  public

  end;

var
  FrmClients: TFrmClients;

implementation
 uses UDM;
{$R *.lfm}

 { TFrmClients }

 procedure TFrmClients.BtnRechercgerClick(Sender: TObject);
 begin
   if DM.RechercherStagiaire(trim(EdtRecherchzr.Text)) then
   ShowMessage('Stagiaire Enregistre et Trouvé')
   else
    ShowMessage('Stagiaire Non Enregistre et Non Trouvé')
 end;

procedure TFrmClients.BtnAjouterClick(Sender: TObject);
var
  noms, prenoms, phone , adresse :String;
  naissance  : TDate;
  sexe   :char;
begin
   noms := edtNom.text;
   prenoms:=EdtPrenom.text;
   phone :=edtPhoen.text;
   adresse:=MemAdresse.Text;
   naissance:=DateNaissance.date;
   sexe := 'F';
    ShowMessage('1');
   if DM.AjouterStagiaire(noms,prenoms,phone,naissance,adresse,sexe) then
   ShowMessage('Stagiaire ajoute')
   else
    ShowMessage('Stagiaire Non  ajoute');
     ShowMessage('2');
end;

end.

