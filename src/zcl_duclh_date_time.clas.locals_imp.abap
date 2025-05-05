*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_date_time definition.

  public section.
    METHODS constructor.

    METHODS get_output RETURNING VALUE(r_output) type string_table
                       RAISING cx_ABAP_INVALID_VALUE.
  protected section.
  private section.
    TYPES:
      BEGIN OF st_connection_details,
        departureairport   TYPE /dmo/airport_from_id,
        destinationairport TYPE /dmo/airport_to_id,
        AirportId          TYPE /dmo/airport_id,
        Name               TYPE /dmo/airport_name,
        DepartureTime      TYPE /dmo/flight_departure_time,
        ArrivalTime        TYPE /dmo/flight_departure_time,
      END OF st_connection_details.

      DATA: gt_connections TYPE STANDARD TABLE OF st_connection_details,
            gs_connection  TYPE st_connection_details.

endclass.

class lcl_date_time implementation.
     METHOD constructor.
     SELECT FROM /DMO/I_Connection
          FIELDS DepartureAirport,
                 DestinationAirport,
                 \_DepartureAirport-AirportID,
                 \_DepartureAirport-Name,
                 DepartureTime,
                 ArrivalTime
            INTO TABLE @gt_connections.
    ENDMETHOD.

    METHOD get_output.
        Data lv_duration TYPE P DECIMALS 2.

        IF gt_connections IS INITIAL.
            RAISE EXCEPTION TYPE cx_abap_invalid_value.
        ENDIF.

        LOOP AT gt_connections INTO gs_connection.
            lv_duration = ( gs_connection-arrivaltime - gs_connection-departuretime ) / 60.
            APPEND |--------------------------------|             TO r_output.
            APPEND |Airport:     { gs_connection-airportid } - { gs_connection-name }| TO r_output.
            APPEND |DepartureAirport:  { gs_connection-departureairport }|             TO r_output.
            APPEND |DestinationAirport:   {  gs_connection-destinationairport }|             TO r_output.
            APPEND |Duration:       { lv_duration } minutes| TO r_output.
        ENDLOOP.
    ENDMETHOD.
endclass.
