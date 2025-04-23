CLASS zcl_duclh_cds_view DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_duclh_cds_view IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA connection TYPE REF TO lcl_cds_vew.
    TRY.
        connection = NEW #(
                            i_carrier_id    = 'LH'
                            i_connection_id = '0400'
                          ).

    CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.

    TRY.
        out->write( connection->get_output( ) ).
      CATCH cx_abap_invalid_value.
        out->write( `Data not found` ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
