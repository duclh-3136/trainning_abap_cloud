CLASS zcl_duclh_factory_method DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_duclh_factory_method IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: factory TYPE REF TO lcl_car_factory,
          car     TYPE REF TO lif_car.

    " Lấy instance factory (Singleton)
    factory = lcl_car_factory=>get_instance( ).

    " Sử dụng factory để tạo xe (Factory Method)
    car = factory->create_car( 'BICYCLE' ).
    out->write( car->drive( ) ).

    car = factory->create_car( 'CAR' ).
    out->write( car->drive( ) ).
  ENDMETHOD.
ENDCLASS.
