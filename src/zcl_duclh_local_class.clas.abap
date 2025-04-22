CLASS zcl_duclh_local_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_duclh_local_class IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA connection TYPE REF TO lcl_duclh.
    DATA connections TYPE TABLE OF REF TO lcl_duclh.

    connection = NEW #(  ).

    TRY.
        connection->set_attributes(
          EXPORTING
            i_carrier_id    = 'LH'
            i_connection_id = '0400'
        ).

*        connection->carrier_id    = 'LH'.
*        connection->connection_id = '0400'.

        APPEND connection TO connections.

      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.

    APPEND connection TO connections.

    connection = NEW #(  ).

    connection->carrier_id    = 'SQ'.
    connection->connection_id = '0001'.

    APPEND connection TO connections.

    LOOP AT connections INTO connection.
        out->write( connection->get_output( ) ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
