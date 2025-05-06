*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_abap_joins definition.

  public section.
    METHODS constructor.

    METHODS get_output RETURNING VALUE(r_output) type string_table
                       RAISING cx_ABAP_INVALID_VALUE.
  protected section.
  private section.
    TYPES:
      BEGIN OF st_connection_details,
        carrier_id        TYPE /dmo/carrier_id,
        connection_id     TYPE /dmo/connection_id,
        airport_from_id   TYPE /dmo/airport_from_id,
        airport_to_id     TYPE /dmo/airport_to_id,
        departure_time    TYPE /dmo/flight_departure_time,
        arrival_time      TYPE /dmo/flight_departure_time,
        air_from_name     TYPE /dmo/airport_name,
        air_to_name       TYPE /dmo/airport_name,
      END OF st_connection_details.

      DATA: gt_connections TYPE STANDARD TABLE OF st_connection_details,
            gs_connection  TYPE st_connection_details.

endclass.

class lcl_abap_joins implementation.
     METHOD constructor.
         SELECT
            FROM /dmo/connection as c
            LEFT OUTER JOIN /dmo/airport as f
                ON c~airport_from_id = f~airport_id
            LEFT OUTER JOIN /dmo/airport as t
                ON c~airport_from_id = t~airport_id
            FIELDS carrier_id,
                 connection_id,
                 airport_from_id,
                 airport_to_id,
                 departure_time,
                 arrival_time,
                 f~name AS air_from_name,
                 t~name AS air_to_name
            INTO TABLE @gt_connections.
    ENDMETHOD.

    METHOD get_output.
        Data lv_duration TYPE P DECIMALS 2.
        IF gt_connections IS INITIAL.
            RAISE EXCEPTION TYPE cx_abap_invalid_value.
        ENDIF.

        LOOP AT gt_connections INTO gs_connection.
            lv_duration = ( gs_connection-arrival_time - gs_connection-departure_time ) / 60.
            APPEND |--------------------------------|             TO r_output.
            APPEND |carrier_id:     { gs_connection-carrier_id } | TO r_output.
            APPEND |connection_id:     { gs_connection-connection_id } | TO r_output.
            APPEND |DepartureAirport:  { gs_connection-air_from_name }|             TO r_output.
            APPEND |DestinationAirport:   {  gs_connection-air_to_name }|             TO r_output.
            APPEND |Duration:       { lv_duration } minutes| TO r_output.
        ENDLOOP.
    ENDMETHOD.
endclass.
