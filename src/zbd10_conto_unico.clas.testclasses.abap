class ltcl_ definition final for testing
  duration short
  risk level harmless.

  private section.
    methods:
      first_test for testing raising cx_static_check.
endclass.


class ltcl_ implementation.

  method first_test.
    data(a) = zbd10_conto_unico=>crea_istanza(  ).
    data(saldo) = a->deposito( 1000 ).
    cl_abap_unit_assert=>assert_equals( msg = 'msg' exp = 1000 act = saldo ).
  endmethod.

endclass."* use this source file for your ABAP unit test classes
