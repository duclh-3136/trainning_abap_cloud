*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_flight DEFINITION.
  PUBLIC SECTION.
    TYPES: BEGIN OF st_connection_details,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             departure_time  TYPE /dmo/flight_departure_time,
             arrival_time    TYPE /dmo/flight_departure_time,
             duration        TYPE i,
           END OF st_connection_details.

    DATA carrier_id    TYPE /dmo/carrier_id       READ-ONLY.
    DATA connection_id TYPE /dmo/connection_id    READ-ONLY.
    DATA flight_date   TYPE /dmo/flight_date      READ-ONLY.

    METHODS get_description
      RETURNING VALUE(r_result2) TYPE string_table.

    METHODS constructor
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id
        i_flight_date   TYPE /dmo/flight_date
        i_connection_details TYPE st_connection_details OPTIONAL.

  PROTECTED SECTION.
    DATA planetype          TYPE /dmo/plane_type_id VALUE 'A320'.
    DATA connection_details TYPE st_connection_details.
ENDCLASS.

CLASS lcl_flight IMPLEMENTATION.
  METHOD constructor.
    " Gán các giá trị từ tham số vào thuộc tính
    carrier_id = i_carrier_id.
    connection_id = i_connection_id.
    flight_date = i_flight_date.
    " Nếu không truyền connection_details, để mặc định (giá trị ban đầu của kiểu)
    IF i_connection_details IS SUPPLIED.
      connection_details = i_connection_details.
    ENDIF.
  ENDMETHOD.

  METHOD get_description.
    DATA txt TYPE string.

    txt = 'Flight &carrid& &connid& on &date& from &from& to &to&'(005).
    txt = replace( val = txt sub = '&carrid&' with = carrier_id ).
    txt = replace( val = txt sub = '&connid&' with = connection_id ).
    txt = replace( val = txt sub = '&date&'   with = |{ flight_date DATE = USER }| ).
    txt = replace( val = txt sub = '&from&'   with = connection_details-airport_from_id ).
    txt = replace( val = txt sub = '&to&'     with = connection_details-airport_to_id ).

    APPEND txt TO r_result2.
    APPEND |{ 'Planetype:'(006)      } { planetype  } | TO r_result2.

    RETURN r_result2.
  ENDMETHOD.
ENDCLASS.

" Lưu ý: Lớp con phải được định nghĩa hoàn toàn sau lớp cha
CLASS lcl_cargo_flight DEFINITION INHERITING FROM lcl_flight.
  PUBLIC SECTION.
    METHODS get_description REDEFINITION.
    METHODS constructor
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id
        i_flight_date   TYPE /dmo/flight_date
        i_connection_details TYPE st_connection_details OPTIONAL.
ENDCLASS.

CLASS lcl_cargo_flight IMPLEMENTATION.
  METHOD constructor.
   super->constructor(
     i_carrier_id    = i_carrier_id
     i_connection_id = i_connection_id
     i_flight_date   = i_flight_date
     i_connection_details = i_connection_details
   ).
  ENDMETHOD.

  METHOD get_description.
    r_result2 = super->get_description( ).
    APPEND |Cargo flight with extra handling for goods.| TO r_result2.

    RETURN r_result2.
  ENDMETHOD.
ENDCLASS.
