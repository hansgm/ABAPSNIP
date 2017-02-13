report zzhp_exact.

start-of-selection.

  try.
      data(float0) = exact decfloat34( 4 / 2 ).
      write : / 'Exact',  float0.
    catch cx_sy_conversion_rounding into data(ex0).
      write :  |Not exact: { ex0->value }| .
  endtry.

  try.
      data(float1) = exact decfloat34( 2 / 3 ).
      write : / 'Exact',  float1.
    catch cx_sy_conversion_rounding into data(ex1).
      write : / |Not exact: { ex1->value }| .
  endtry.

  try.
      data(float2) = exact decfloat34( ( 3 / 2 ) * ( 2 / 3 ) ).
      write : / 'Exact',  float2.
    catch cx_sy_conversion_rounding into data(ex2).
      write : /  |Not exact: { ex2->value }| .
  endtry.

  try.
      data(float3) = exact decfloat34( ( ( 5 / 3 ) * 12 )  / 20 ).
      write : / 'Exact',  float3.
    catch cx_sy_conversion_rounding into data(ex3).
      write : /  |Not exact: { ex3->value }| .
  endtry.
