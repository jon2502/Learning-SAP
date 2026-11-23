@EndUserText.label: 'params for checkoutCart'
define abstract entity ZA_CHECKOUT_PARAM

{

  UserId        : abap.int4;
  StreetAddress : abap.char(100);
  PostalCode    : abap.char(10);
  City          : abap.char(50);
  Country       : abap.char(3);    
  
}
