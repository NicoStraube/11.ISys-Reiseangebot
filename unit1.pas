unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ActnList;

type

  { TForm1 }

  TForm1 = class(TForm)
    buttonClear: TButton;
    buttonCalc: TButton;
    checkBox: TCheckBox;
    comboBox: TComboBox;
    editPrice: TLabeledEdit;
    editPersons: TLabeledEdit;
    editDays: TLabeledEdit;
    editECharge: TLabeledEdit;
    editPriceN: TLabeledEdit;
    labelError: TLabel;
    editDiscount: TLabeledEdit;
    editPriceE: TLabeledEdit;
    procedure buttonCalcClick(Sender: TObject);
    procedure buttonClearClick(Sender: TObject);
    procedure checkBoxChange(Sender: TObject);
    procedure comboBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

end;

procedure TForm1.comboBoxChange(Sender: TObject);
begin
  case comboBox.ItemIndex of
    0: editPrice.Text := '123.-€';
    1: editPrice.Text := '99.-€';
    2: editPrice.Text := '186.-€';
    3: editPrice.Text := '152.-€';
    4: editPrice.Text := '134.-€';
    5: editPrice.Text := '132.-€';
  end;

  checkBox.Enabled := True;
  editPersons.Enabled := True;
  editDays.Enabled := True;
  buttonCalc.Enabled := True;


  checkBox.Checked := False;
  editECharge.Text := '-';

  editPersons.Text := '1';
  editDays.Text := '1';

  editPriceN.Text := '-';
  editPriceE.Text := '-';
  editDiscount.Text := '-';
end;

procedure TForm1.checkBoxChange(Sender: TObject);
var
  price, eCharge, priceN, discount: currency;
  persons, days: integer;
  discountBool: boolean;
begin

  case checkBox.Checked of
    True:
    begin
      case comboBox.ItemIndex of
        0: editECharge.Text := '15.-€';
        1: editECharge.Text := '12.-€';
        2: editECharge.Text := '15.-€';
        3: editECharge.Text := '15.-€';
        4: editECharge.Text := '15.-€';
        5: editECharge.Text := '15.-€';
      end;
    end;
    False: editECharge.Text := '-';
  end;

  // recalc priceE
  price := StrToCurr(StringReplace(editPrice.Text, '.-€', '', [rfReplaceAll]));
  editDiscount.Text := '-';

  if (checkBox.Checked) then
    eCharge := StrToCurr(StringReplace(editECharge.Text, '.-€',
      '', [rfReplaceAll]));

  try
    persons := StrToInt(editPersons.Text);
  except
    persons := 1;
    editPersons.Text := '1';
    labelError.Caption := 'Invalid datatype at "Personen". | ' + TimeToStr(Time());
    editPersons.Clear;
    editPriceN.Text := '-';
    editDiscount.Text := '-';
    editPriceE.Text := '-';
  end;

  try
    days := StrToInt(editDays.Text);
  except
    days := 1;
    editDays.Text := '1';
    labelError.Caption := 'Invalid datatype at "Tage". | ' + TimeToStr(Time());
    editDays.Clear;
    editPriceN.Text := '-';
    editDiscount.Text := '-';
    editPriceE.Text := '-';
  end;


  // calc Netto
  if (checkBox.Checked) then
  begin
    priceN := (price + eCharge) * (persons * days);
    editPriceN.Text := floatToStr(priceN) + '.-€';
  end
  else
  begin
    priceN := price * (persons * days);
    editPriceN.Text := FloatToStr(priceN) + '.-€';
  end;


  // calc Rabatt
  if (priceN >= 400) then
  begin
    discount := 3 * (priceN / 100);
    discountBool := True;
    editDiscount.Text := floatToStr(discount) + '.-€';
  end
  else if (priceN >= 600) then
  begin
    discount := 5 * (priceN / 100);
    discountBool := True;
    editDiscount.Text := floatToStr(discount) + '.-€';
  end
  else if (priceN >= 800) then
  begin
    discount := 7 * (priceN / 100);
    discountBool := True;
    editDiscount.Text := floatToStr(discount) + '.-€';
  end
  else if (priceN >= 1000) then
  begin
    discount := 9 * (priceN / 100);
    discountBool := True;
    editDiscount.Text := floatToStr(discount) + '.-€';
  end;


  // calc Endpreis
  if (discountBool) then
    editPriceE.Text := FloatToStr(priceN - discount) + '.-€'
  else
    editPriceE.Text := FloatToStr(priceN) + '.-€';
end;

procedure TForm1.buttonCalcClick(Sender: TObject);
var
  price, eCharge, priceN, discount: currency;
  persons, days: integer;
  discountBool: boolean;
begin
  price := StrToCurr(StringReplace(editPrice.Text, '.-€', '', [rfReplaceAll]));
  editDiscount.Text := '-';

  if (checkBox.Checked) then
    eCharge := StrToCurr(StringReplace(editECharge.Text, '.-€', '', [rfReplaceAll]));

  try
    persons := StrToInt(editPersons.Text);
  except
    persons := 1;
    editPersons.Text := '1';
    labelError.Caption := 'Invalid datatype at "Personen". | ' + TimeToStr(Time());
    editPersons.Clear;
    editPriceN.Text := '-';
    editDiscount.Text := '-';
    editPriceE.Text := '-';
  end;

  try
    days := StrToInt(editDays.Text);
  except
    days := 1;
    editDays.Text := '1';
    labelError.Caption := 'Invalid datatype at "Tage". | ' + TimeToStr(Time());
    editDays.Clear;
    editPriceN.Text := '-';
    editDiscount.Text := '-';
    editPriceE.Text := '-';
  end;


  // calc Netto
  if (checkBox.Checked) then
  begin
    priceN := (price + eCharge) * (persons * days);
    editPriceN.Text := floatToStr(priceN) + '.-€';
  end
  else
  begin
    priceN := price * (persons * days);
    editPriceN.Text := FloatToStr(priceN) + '.-€';
  end;


  // calc Rabatt
  if (priceN >= 400) then
  begin
    discount := 3 * (priceN / 100);
    discountBool := True;
    editDiscount.Text := floatToStr(discount) + '.-€';
  end
  else if (priceN >= 600) then
  begin
    discount := 5 * (priceN / 100);
    discountBool := True;
    editDiscount.Text := floatToStr(discount) + '.-€';
  end
  else if (priceN >= 800) then
  begin
    discount := 7 * (priceN / 100);
    discountBool := True;
    editDiscount.Text := floatToStr(discount) + '.-€';
  end
  else if (priceN >= 1000) then
  begin
    discount := 9 * (priceN / 100);
    discountBool := True;
    editDiscount.Text := floatToStr(discount) + '.-€';
  end;


  // calc Endpreis
  if (discountBool) then
    editPriceE.Text := FloatToStr(priceN - discount) + '.-€'
  else
    editPriceE.Text := FloatToStr(priceN) + '.-€';
end;

procedure TForm1.buttonClearClick(Sender: TObject);
begin
  // reset everything to defaults
  checkBox.Checked := False;
  editECharge.Text := '-';
  editPersons.Text := '1';
  editDays.Text := '1';
  editPriceN.Text := '-';
  editDiscount.Text := '-';
  editPriceE.Text := '-';
end;

end.
