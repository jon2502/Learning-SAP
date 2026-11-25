@EndUserText.label: 'params for checkoutCart'
define abstract entity ZA_CHECKOUT_PARAM

{

  UserId        : abap.int4;
  street_address        : abap.char(50);
  postal_code           : abap.char(10);
  city                  : abap.char(50);
  country               : abap.char(3);
}
