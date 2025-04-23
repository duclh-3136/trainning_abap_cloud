*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_cds_vew definition.

  public section.
      METHODS constructor
          IMPORTING
            i_connection_id TYPE /dmo/connection_id
            i_carrier_id    TYPE /dmo/carrier_id
          RAISING
            cx_ABAP_INVALID_VALUE.

      METHODS get_output RETURNING VALUE(r_output) type string_table
                         RAISING cx_ABAP_INVALID_VALUE.

  protected section.
  private section.
    DATA: carrier_id    TYPE /DMO/CARRIER_ID,
          connection_id TYPE /DMO/CONNECTION_ID.

    DATA airport_from_id TYPE /dmo/airport_from_id.
    DATA airport_to_id   TYPE /dmo/airport_to_id.

    DATA carrier_name    TYPE /dmo/carrier_name.

endclass.

class lcl_cds_vew implementation.
  method constructor.
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    me->connection_id = i_connection_id.
    me->carrier_id    = i_carrier_id.
  endmethod.

  method get_output.
     SELECT SINGLE
           FROM /DMO/I_Connection
        FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
         WHERE AirlineID    = @carrier_id
           AND ConnectionID = @connection_id
          INTO ( @airport_from_id, @airport_to_id, @carrier_name ).

        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE cx_abap_invalid_value.
        ENDIF.

        APPEND |--------------------------------|             TO r_output.
        APPEND |Carrier:     { carrier_id } { carrier_name }| TO r_output.
        APPEND |Connection:  { connection_id   }|             TO r_output.
        APPEND |Departure:   { airport_from_id }|             TO r_output.
        APPEND |Destination: { airport_to_id   }|             TO r_output.
  endmethod.

endclass.
