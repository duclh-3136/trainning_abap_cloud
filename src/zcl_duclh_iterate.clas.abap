CLASS zcl_duclh_iterate DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_duclh_iterate IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

   CONSTANTS max_count TYPE i VALUE 20.
   DATA: gt_numbers TYPE STANDARD TABLE OF i,
         gs_number  TYPE i,
         gv_counter TYPE i,
         gt_output  TYPE STANDARD TABLE OF string.


   DO max_count TIMES.
    CASE sy-index.
      WHEN 1.
        APPEND 0 TO gt_numbers.
      WHEN 2.
        APPEND 1 TO gt_numbers.
      WHEN OTHERS.
          APPEND gt_numbers[  sy-index - 2 ]
               + gt_numbers[  sy-index - 1 ]
              TO gt_numbers.
    ENDCASE.
   ENDDO.

   gv_counter = 0.
   LOOP AT gt_numbers INTO gs_number.
       gv_counter = gv_counter + 1.

       APPEND |{ gv_counter WIDTH = 4 }: { gs_number WIDTH = 10 ALIGN = RIGHT }|
         TO gt_output.
   ENDLOOP.

   out->write(
         data   = gt_output
         name   = |The first { max_count } Fibonacci Numbers|
                ) .

  ENDMETHOD.
ENDCLASS.
