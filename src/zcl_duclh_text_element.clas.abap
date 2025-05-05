CLASS zcl_duclh_text_element DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_duclh_text_element IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    out->write( text-001 ).
    out->write( 'duclh'(002) ).
  ENDMETHOD.
ENDCLASS.
