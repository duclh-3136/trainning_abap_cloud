*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

" Interface định nghĩa xe
INTERFACE lif_car.
  METHODS drive RETURNING VALUE(result) TYPE string.
ENDINTERFACE.

" Lớp cụ thể: Xe đạp
CLASS lcl_bicycle DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_car.
ENDCLASS.

CLASS lcl_bicycle IMPLEMENTATION.
  METHOD lif_car~drive.
    result = 'I am a bicycle, pedaling...'.
  ENDMETHOD.
ENDCLASS.

" Lớp cụ thể: Xe hơi
CLASS lcl_car DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_car.
ENDCLASS.

CLASS lcl_car IMPLEMENTATION.
  METHOD lif_car~drive.
    result = 'I am a car, driving fast...'.
  ENDMETHOD.
ENDCLASS.

" Lớp factory để tạo xe
CLASS lcl_car_factory DEFINITION CREATE PRIVATE.
  PUBLIC SECTION.
    CLASS-METHODS get_instance
      RETURNING
        VALUE(r_factory) TYPE REF TO lcl_car_factory.
    METHODS create_car
      IMPORTING
        i_type TYPE string
      RETURNING
        VALUE(r_car) TYPE REF TO lif_car.
    PRIVATE SECTION.
      CLASS-DATA instance TYPE REF TO lcl_car_factory.
      METHODS constructor.
ENDCLASS.

CLASS lcl_car_factory IMPLEMENTATION.
  METHOD constructor.
    " Private constructor
  ENDMETHOD.

  METHOD get_instance.
    IF instance IS INITIAL.
      CREATE OBJECT instance.
    ENDIF.
    r_factory = instance.
  ENDMETHOD.

  METHOD create_car.
    CASE i_type.
      WHEN 'BICYCLE'.
        CREATE OBJECT r_car TYPE lcl_bicycle.
      WHEN 'CAR'.
        CREATE OBJECT r_car TYPE lcl_car.
      WHEN OTHERS.
        CREATE OBJECT r_car TYPE lcl_bicycle. " Mặc định
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
