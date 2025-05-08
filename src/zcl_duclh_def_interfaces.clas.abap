CLASS zcl_duclh_def_interfaces DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_duclh_def_interfaces IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
   DATA: output_obj TYPE REF TO lcl_interface,
          result     TYPE lif_output=>tt_output.

    " Tạo đối tượng của lcl_interface
    output_obj = new #(  ).

    " Gọi phương thức get_output thông qua interface
    result = output_obj->lif_output~get_output(  ).

    " In kết quả
    out->write( result ).
  ENDMETHOD.
ENDCLASS.
