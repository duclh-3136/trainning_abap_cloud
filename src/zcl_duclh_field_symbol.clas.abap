CLASS zcl_duclh_field_symbol DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_duclh_field_symbol IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    data(flights) = new lcl_field_symbol( ).


    flights->use_work_area( ).
    flights->use_field_symbol( ).
    out->write( 'Done' ).
  ENDMETHOD.
ENDCLASS.
