*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
class lcx_no_connection definition INHERITING FROM cx_static_Check.

  public section.
    interfaces if_t100_message.
    METHODS constructor IMPORTING textid LIKE if_t100_message=>t100key OPTIONAL
                                  previous LIKE previous OPTIONAL
                                  airlineid TYPE /DMO/CARRIER_ID OPTIONAL
                                  connectionnumber TYPE /DMO/CONNECTION_ID OPTIONAL.
    DATA airlineid TYPE /dmo/carrier_id READ-ONLY.
    DATA connectionnumber TYPE /dmo/connection_id READ-ONLY.
        protected section.
        private section.

    CONSTANTS:
        BEGIN OF gty_message,
            msgid TYPE symsgid VALUE 'ZCL_DUCLH_EXCEPTION',
            msgno TYPE symsgno VALUE '001',
            attr1 TYPE scx_attrname VALUE 'AIRLINEID',
            attr2 TYPE scx_attrname VALUE 'CONNECTIONNUMBER',
            attr3 TYPE scx_attrname VALUE 'attr3',
            attr4 TYPE scx_attrname VALUE 'attr4',
        END OF gty_message.

endclass.

class lcx_no_connection implementation.
    METHOD constructor.

        super->constructor( previous = previous ).

        me->airlineid = airlineid.
        me->connectionnumber = connectionnumber.

        CLEAR me->textid.
        IF textid IS INITIAL.
          if_t100_message~t100key = gty_message.
        ELSE.
          if_t100_message~t100key = textid.
        ENDIF.
    ENDMETHOD.
endclass.

CLASS lcl_connection DEFINITION.
PUBLIC SECTION.
    METHODS constructor IMPORTING i_airlineid TYPE /dmo/carrier_id
                                i_connectionnumber TYPE /dmo/connection_id
                      RAISING lcx_no_connection.

PRIVATE SECTION.
    DATA AirlineId TYPE /dmo/carrier_id.
    DATA ConnectionNumber TYPE /dmo/connection_id.
    DATA fromAirport TYPE /dmo/airport_from_id.
    DATA toAirport TYPE /dmo/airport_to_id.
ENDCLASS.


CLASS lcl_Connection IMPLEMENTATION.
    METHOD constructor.
        DATA fromairport TYPE /dmo/airport_from_Id.
        DATA toairport TYPE /dmo/airport_to_id.


        SELECT SINGLE FROM /dmo/connection
                  FIELDS airport_from_id, airport_to_id
                  WHERE carrier_id = @i_airlineid
                  AND connection_id = @i_connectionnumber
                  INTO ( @fromairport, @toairport ).


        IF sy-subrc <> 0.
            RAISE EXCEPTION TYPE lcx_no_connection EXPORTING airlineid = i_airlineid
                                                             connectionnumber = i_connectionnumber.
        ELSE.
            me->connectionnumber = i_connectionnumber.
            me->fromairport = fromairport.
            me->toairport = toairport.
        ENDIF.
    ENDMETHOD.
ENDCLASS.
