CLASS zcl_02_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_02_eml IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA aency_up TYPE TABLE FOR UPDATE /DMO/I_AgencyTP.


   aency_up = VALUE #( ( agencyid = '070002' name = 'Some fancy new name' ) ).


     MODIFY ENTITIES OF /dmo/i_agencytp
        ENTITY /dmo/agency
        UPDATE FIELDS ( name )
          WITH aency_up.


     out->write( `Method execution finished!`  ).


  ENDMETHOD.
ENDCLASS.
