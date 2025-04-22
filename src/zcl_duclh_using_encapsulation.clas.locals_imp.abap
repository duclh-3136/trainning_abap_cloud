*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_duclh definition.

  public section.
      CLASS-DATA conn_counter TYPE i READ-ONLY.

      METHODS constructor
          IMPORTING
            i_connection_id TYPE /dmo/connection_id
            i_carrier_id    TYPE /dmo/carrier_id
          RAISING
            cx_ABAP_INVALID_VALUE.

      METHODS get_output
        RETURNING VALUE(r_output) type string_table.

      METHODS set_attributes
        IMPORTING
            i_carrier_id    TYPE /dmo/carrier_id
            i_connection_id TYPE /dmo/connection_id
        RAISING
            cx_abap_invalid_value.

  protected section.
  private section.
    DATA: carrier_id    TYPE /DMO/CARRIER_ID,
          connection_id TYPE /DMO/CONNECTION_ID.

endclass.

class lcl_duclh implementation.
  method constructor.
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    me->connection_id = i_connection_id.
    me->carrier_id    = i_carrier_id.
    conn_counter = conn_counter + 1.
  endmethod.

  method get_output.
     APPEND |------------------------------| TO r_output.
     APPEND |Carrier:     { carrier_id    }| TO r_output.
     APPEND |Connection:  { connection_id }| TO r_output.
  endmethod.

  method set_attributes.
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    carrier_id = i_carrier_id.
    connection_id = i_connection_id.
  endmethod.

endclass.
