CLASS zcl_duclh_content_of_itable DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_duclh_content_of_itable IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TYPES t_flights TYPE STANDARD TABLE OF /dmo/flight
                WITH NON-UNIQUE KEY carrier_id connection_id flight_date.
    TYPES: BEGIN OF t_results_with_Avg,
        occupied TYPE /dmo/plane_seats_occupied,
        maximum TYPE /dmo/plane_seats_max,
        average TYPE p LENGTH 16 DECIMALS 2,
    END OF t_results_with_avg.
    DATA  flights TYPE t_flights.

    flights = VALUE #( ( client        = sy-mandt
                         carrier_id    = 'LH'
                         connection_id = '0400'
                         flight_date = '20230201'
                         plane_type_id = '747-400'
                         price = '600'
                         currency_code = 'EUR'
                         seats_max = 350
                         seats_occupied = 310 )
                       ( client = sy-mandt
                         carrier_id = 'LH'
                         connection_id = '0400'
                         flight_date = '20230115'
                         plane_type_id = '747-400'
                         price = '600' currency_code = 'EUR'
                         seats_max = 180
                         seats_occupied = 90 )
                       ( client = sy-mandt
                         carrier_id = 'QF'
                         connection_id = '0006'
                         flight_date = '20230112'
                         plane_type_id = 'A380'
                         price = '1600' currency_code = 'AUD'
                         seats_max = 225
                         seats_occupied = 220 )
                       ( client = sy-mandt
                         carrier_id = 'AA'
                         connection_id = '0017'
                         flight_date = '20230110'
                         plane_type_id = '747-400'
                         price = '600'
                         currency_code = 'USD'
                         seats_max = 350
                         seats_occupied = 190 )
                       ( client = sy-mandt
                         carrier_id = 'UA'
                         connection_id = '0900'
                         flight_date = '20230201'
                         plane_type_id = '777-200'
                         price = '600'
                         currency_code = 'USD'
                         seats_max = 220
                         seats_occupied = 192 )
                     ).
     SORT flights BY carrier_id connection_id.
     out->write( 'Effect of SORT with field list and sort direction' ).
     out->write( '_________________________________________________' ).
     out->write( flights ).
     out->write( ` ` ).

     DELETE ADJACENT DUPLICATES FROM flights COMPARING carrier_id connection_id.
     out->write( 'Contents after DELETE ADJACENT DUPLICATES with COMPARING and field list' ).
     out->write( 'Entries with identical values of carrier_id and connection_id have been deleted' ).
     out->write( flights ).

     DATA(result_with_Average) = REDUCE t_results_with_avg( INIT totals_avg TYPE t_results_with_avg count = 1
     FOR line IN flights NEXT totals_avg-occupied += line-seats_occupied
         totals_avg-maximum += line-seats_max
         totals_avg-average = totals_avg-occupied / count
         count += 1 ).
     out->write( result_with_average ).
  ENDMETHOD.
ENDCLASS.
