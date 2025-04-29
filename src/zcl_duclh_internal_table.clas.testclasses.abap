*"* use this source file for your ABAP unit test classes
class ltcl_inernal_table definition final for testing
  duration short
  risk level harmless.

  private section.
    DATA connection TYPE REF TO lcl_inernal_table.
    methods:
      setup,
      test_get_data_connect for testing.
endclass.


class ltcl_inernal_table implementation.
  method setup.
    connection = NEW #( ).
  endmethod.

  method test_get_data_connect.
    TRY.
        DATA(output) = connection->get_output( ).
      CATCH cx_abap_invalid_value.
        cl_abap_unit_assert=>fail( `Data not found` ).
    ENDTRY.
  endmethod.

endclass.
