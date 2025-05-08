*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
INTERFACE lif_output.

  TYPES t_output  TYPE string.
  TYPES tt_output TYPE STANDARD TABLE OF t_output
                  WITH NON-UNIQUE DEFAULT KEY.
  METHODS get_output
     RETURNING
       VALUE(r_result) TYPE tt_output.

ENDINTERFACE.

class lcl_interface definition .

  public section.
    INTERFACES lif_output.
  protected section.
  private section.

endclass.

class lcl_interface implementation.

  method lif_output~get_output.
    APPEND 'duclh' to r_result.
  endmethod.

endclass.
