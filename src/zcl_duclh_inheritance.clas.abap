CLASS zcl_duclh_inheritance DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_duclh_inheritance IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: cargo_flight TYPE REF TO lcl_cargo_flight,
          conn_details TYPE lcl_flight=>st_connection_details,
          description  TYPE string_table.

    " Khởi tạo dữ liệu cho connection_details
    conn_details-airport_from_id = 'JFK'.
    conn_details-airport_to_id   = 'LAX'.
    conn_details-departure_time  = '143022'.
    conn_details-arrival_time    = '173022'.
    conn_details-duration        = 180.

    " Tạo đối tượng lcl_cargo_flight
    CREATE OBJECT cargo_flight
      EXPORTING
        i_carrier_id    = 'AA'
        i_connection_id = '0017'
        i_flight_date   = '20250505'
        i_connection_details = conn_details.

    " Gọi phương thức get_description
    description = cargo_flight->get_description( ).

    " In kết quả ra console
    out->write( description ).
  ENDMETHOD.
ENDCLASS.
