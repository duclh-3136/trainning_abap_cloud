CLASS zcl_duclh_internal_table DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_duclh_internal_table IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA connection TYPE REF TO lcl_inernal_table.
    connection = NEW #( ).

    TRY.
        out->write( connection->get_output( ) ).
      CATCH cx_abap_invalid_value.
        out->write( `Data not found` ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
