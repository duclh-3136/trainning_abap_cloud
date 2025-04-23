*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_data_str definition.

  public section.

    TYPES:
      BEGIN OF st_details,
        DepartureAirport   TYPE /dmo/airport_from_id,
        DestinationAirport TYPE   /dmo/airport_to_id,
        AirlineName        TYPE   /dmo/carrier_name,
      END OF st_details.

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
          connection_id TYPE /DMO/CONNECTION_ID,
          details        TYPE st_details.

endclass.

class lcl_data_str implementation.
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
        FIELDS DepartureAirport, DestinationAirport, \_Airline-Name as AirlineName
         WHERE AirlineID    = @carrier_id
           AND ConnectionID = @connection_id
          INTO CORRESPONDING FIELDS OF @details.

        IF sy-subrc <> 0.
          RAISE EXCEPTION TYPE cx_abap_invalid_value.
        ENDIF.

        APPEND |--------------------------------|             TO r_output.
        APPEND |Carrier:     { carrier_id } { details-airlinename }| TO r_output.
        APPEND |Connection:  { connection_id   }|             TO r_output.
        APPEND |Departure:   { details-departureairport }|             TO r_output.
        APPEND |Destination: { details-destinationairport   }|             TO r_output.
  endmethod.

endclass.
