*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcl_inernal_table definition.

  public section.
    METHODS constructor.

    METHODS get_output RETURNING VALUE(r_output) type string_table
                       RAISING cx_ABAP_INVALID_VALUE.
  protected section.
  private section.
    TYPES:
      BEGIN OF st_airport,
        departureairport   TYPE /dmo/airport_from_id,
        destinationairport TYPE /dmo/airport_to_id,
        AirportId          TYPE /dmo/airport_id,
        Name               TYPE /dmo/airport_name,
      END OF st_airport.

    TYPES tt_airports TYPE STANDARD TABLE OF st_airport
                           WITH NON-UNIQUE DEFAULT KEY.

    DATA: gt_airports TYPE tt_airports,
          gs_airport  TYPE st_airport.
endclass.

class lcl_inernal_table implementation.
    METHOD constructor.
     SELECT FROM /DMO/I_Connection
          FIELDS DepartureAirport, DestinationAirport, \_DepartureAirport-AirportID, \_DepartureAirport-Name
            INTO TABLE @gt_airports.
    ENDMETHOD.

    METHOD get_output.
        IF gt_airports IS INITIAL.
            RAISE EXCEPTION TYPE cx_abap_invalid_value.
        ENDIF.

        LOOP AT gt_airports INTO gs_airport.
            APPEND |--------------------------------|             TO r_output.
            APPEND |Airport:     { gs_airport-airportid } - { gs_airport-name }| TO r_output.
            APPEND |DepartureAirport:  { gs_airport-departureairport }|             TO r_output.
            APPEND |DestinationAirport:   {  gs_airport-destinationairport }|             TO r_output.
        ENDLOOP.
    ENDMETHOD.
endclass.
