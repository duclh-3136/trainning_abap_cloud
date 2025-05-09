*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
"! Interface defining methods for employee management.
"!
CLASS lcl_flight_model DEFINITION.
  PUBLIC SECTION.
  "! Type for returning parameter of method {@link .METH:get_airports}
  TYPES tt_airports TYPE STANDARD TABLE OF /dmo/airport with NON-UNIQUE KEY airport_id.

    "! This method returns a list of airports for a given country
    "! There is an authorization check. Possible activities are
    "! @parameter iv_country | Country key
    "! @parameter rt_airports | List of airports
    METHODS get_airports
      IMPORTING iv_country TYPE land1
      RETURNING VALUE(rt_airports) TYPE tt_airports.
ENDCLASS.

CLASS lcl_flight_model IMPLEMENTATION.
  METHOD get_airports.
    IF sy-subrc <> 0.
      SELECT FROM /dmo/airport
        FIELDS airport_id
        WHERE country = @iv_country
        INTO TABLE @rt_airports.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
