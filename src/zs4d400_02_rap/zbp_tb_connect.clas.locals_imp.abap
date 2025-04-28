CLASS LHC_ZDM_TB_CONNECT DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR Connection_Duclh
        RESULT result,
      CheckSemanticKey FOR VALIDATE ON SAVE
            IMPORTING keys FOR Connection_Duclh~CheckSemanticKey,
      getCities FOR DETERMINE ON SAVE
            IMPORTING keys FOR Connection_Duclh~getCities.
ENDCLASS.

CLASS LHC_ZDM_TB_CONNECT IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD CheckSemanticKey.
    READ ENTITIES OF zdm_tb_connect IN LOCAL MODE
    ENTITY Connection_Duclh FIELDS ( uuid Carrid Connid )
    WITH CORRESPONDING #( keys )
    RESULT DATA(connections).

    LOOP AT connections INTO DATA(connection).
        SELECT FROM ZTB_CONNECT
        FIELDS uuid
        WHERE carrid = @connection-Carrid AND connid = @connection-Connid
        UNION
        SELECT FROM ztb_connect_d
        FIELDS uuid
        WHERE carrid = @connection-Carrid AND connid = @connection-Connid
        INTO TABLE @DATA(check_result).

        IF check_result IS NOT INITIAL.
            DATA(message) = me->new_message(
                id = 'ZCL_DUCLH_MESSGAE'
                number = '001'
                severity = if_abap_behv_message=>severity-error
                v1 = connection-Carrid
                v2 = connection-Connid
             ).

            DATA reported_record LIKE LINE OF reported-connection_duclh.
            reported_record-%tky = connection-%tky.
            reported_record-%msg = message.
            reported_record-%element-carrid = if_abap_behv=>mk-on.
            reported_record-%element-connid = if_abap_behv=>mk-on.

            APPEND reported_record to reported-connection_duclh.

            DATA failed_record LIKE LINE OF failed-connection_duclh.
            failed_record-%tky = connection-%tky.
            APPEND failed_record TO failed-connection_duclh.
        ENDIF.


    ENDLOOP.
  ENDMETHOD.

  METHOD getCities.
    DATA: read_data   TYPE TABLE FOR READ RESULT zdm_tb_connect,
          update_data TYPE TABLE FOR UPDATE zdm_tb_connect.

    READ ENTITIES OF zdm_tb_connect IN LOCAL MODE
    ENTITY Connection_Duclh FIELDS ( CityFrom CityTo )
    WITH CORRESPONDING #( keys )
    RESULT read_data.

    LOOP AT read_data INTO DATA(row_data).
        SELECT SINGLE FROM /DMO/I_Airport
        FIELDS City, CountryCode
        WHERE AirportID = @row_data-AirportFrom
        INTO ( @row_data-CityFrom, @row_data-CountryFrom ).

        SELECT SINGLE FROM /DMO/I_Airport
        FIELDS City, CountryCode
        WHERE AirportID = @row_data-AirportTo
        INTO ( @row_data-CityTo, @row_data-CountryTo ).

        MODIFY read_data FROM row_data.
    ENDLOOP.

    update_data = CORRESPONDING #( read_data ).

  ENDMETHOD.

ENDCLASS.
