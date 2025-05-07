CLASS zcl_duclh_sort_hash_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_duclh_sort_hash_table IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    data(flights) = new lcl_flights( ).
    flights->access_standard( ).
    flights->access_sorted( ).
    flights->access_hashed( ).


    out->write( |Done| ).
  ENDMETHOD.
ENDCLASS.
