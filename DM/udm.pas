unit uDM;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, ZConnection, ZDataset;

type

  { TDM }

  TDM = class(TDataModule)
    DSStagiaires: TDataSource;
    ZNX: TZConnection;
    ZqryStagiaires: TZQuery;
  private

  public
        function RechercherStagiaire(code: string): boolean;
        function AjouterStagiaire(
            noms ,prenoms,phone : string; naissance : TdAte ;
            adresse :string; sexe : char
          ):Boolean;
        function ModifierStagiaire(
            noms ,prenoms,phone : string; naissance : TdAte ;
            adresse :string; sexe : char
          ):Boolean;
  end;

var
  DM: TDM;

implementation

{$R *.lfm}

{ TDM }

function TDM.RechercherStagiaire(code: string): boolean;
begin
  Result := False;
  self.ZqryStagiaires.close;
  self.ZqryStagiaires.sql.Clear;
  self.ZqryStagiaires.SQL.add('select * from stagiaires ');
  if trim(code) <> '' then
  begin
  self.ZqryStagiaires.SQL.add('where code =:code ');
  self.ZqryStagiaires.ParamByName('code').AsString:=trim(code);
  end;
  self.ZqryStagiaires.Open;
  if self.ZqryStagiaires.RecNo = 1 then Result := true;

end;

function TDM.AjouterStagiaire(noms, prenoms, phone: string; naissance: TdAte;
  adresse: string; sexe: char): Boolean;
begin
  Result := False;
  self.ZqryStagiaires.close;
  self.ZqryStagiaires.sql.Clear;
  self.ZqryStagiaires.SQL.add('insert into stagiaires values( ');
  self.ZqryStagiaires.SQL.add( 'null,:nom,:prenom,:phone,:naissance,:adresse,:sexe,null )');
  self.ZqryStagiaires.ParamByName('nom').AsString:= noms;
  self.ZqryStagiaires.ParamByName('prenom').AsString:= prenoms;
  self.ZqryStagiaires.ParamByName('phone').AsString:= phone;
  self.ZqryStagiaires.ParamByName('naissance').AsDate:= naissance;
  self.ZqryStagiaires.ParamByName('adresse').AsString:= adresse;
  self.ZqryStagiaires.ParamByName('sexe').AsString:= sexe;
  self.ZqryStagiaires.ExecSQL;
  self.RechercherStagiaire('');
  Result := True;
end;

function TDM.ModifierStagiaire(noms, prenoms, phone: string; naissance: TdAte;
  adresse: string; sexe: char): Boolean;
begin
    Result := False;
  self.ZqryStagiaires.close;
  self.ZqryStagiaires.sql.Clear;
  self.ZqryStagiaires.SQL.add('update stagiaires set ');
  self.ZqryStagiaires.SQL.add( 'noms=:nom,prenoms=:prenom,phone=:phone,naissance=:naissance,adresse=:adresse,sexe=:sexe )');
  self.ZqryStagiaires.ParamByName('nom').AsString:= noms;
  self.ZqryStagiaires.ParamByName('prenom').AsString:= prenoms;
  self.ZqryStagiaires.ParamByName('phone').AsString:= phone;
  self.ZqryStagiaires.ParamByName('naissance').AsDate:= naissance;
  self.ZqryStagiaires.ParamByName('adresse').AsString:= adresse;
  self.ZqryStagiaires.ParamByName('sexe').AsString:= sexe;
  self.ZqryStagiaires.ExecSQL;
  self.RechercherStagiaire('');
  Result := True;
end;

end.

