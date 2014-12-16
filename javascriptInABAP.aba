report  z_bpm_fake_bsn_becon.

* Please note that the embedded javascript is taken from some places (there are more with the same code) 
* So I do not earn any credit for that.
* Shows just the way to embed Javascript in ABAP


data source type string.
data js_processor type ref to cl_java_script.
js_processor = cl_java_script=>create( ).

perform bsnnumber.
perform beconnumber.

*&---------------------------------------------------------------------*
*&      Form  bsnnumber
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
form bsnnumber.

  concatenate


  'function ElfProef()'
  '{'
  '  var Result1="";'
  '  var Nr9=Math.floor(Math.random()*3); /* nummer begint met 0,1 of 2 */'
  '  var Nr8=Math.floor(Math.random()*10);'
  '  var Nr7=Math.floor(Math.random()*10);'
  '  var Nr6=Math.floor(Math.random()*10); '
  '  var Nr5=Math.floor(Math.random()*10);'
  '  var Nr4=Math.floor(Math.random()*10);'
  '  var Nr3=Math.floor(Math.random()*10);'
  '  var Nr2=Math.floor(Math.random()*10);'
  '   var Nr1=0;'
  '  var SofiNr=0;'


  '  /* Sofinummer mag niet met drie nullen beginnen */'
  '  if ((Nr9 == 0) && (Nr8 == 0) && (Nr7 == 0))'
  '  {'
  '      Nr8 = 1; '
  '  }'

  '  SofiNr = 9*Nr9 + 8*Nr8 + 7*Nr7 + 6*Nr6 + 5*Nr5 + 4*Nr4 + 3*Nr3 + 2*Nr2;'

  '  /* Het laatste nummer is de rest van deling door 11 */'
  '  Nr1 = Math.floor(SofiNr - (Math.floor(SofiNr/11)) * 11); '

  '  if (Nr1 > 9)'
  '  {'
  '    /* rest bij deling kan ook 10 zijn. Dat is een fout sofinummer */'
  '    if (Nr2 > 0)'
  '    {'
  '      Nr2 -= 1;'
  '      /* in de formule staat 2*Nr2, bij Nr2 heb ik er 1 afgehaald. Nr1 = 10'
  '         dus om het kloppend te maken wordt Nr1 10-2 = 8 */'
  '      Nr1 = 8;'
  '    }'
  '    else /* Als Nr2 nul is... */'
  '    {'
  '      Nr2 += 1; '
  '      /* in de formule staat 2*Nr2, bij Nr2 heb ik er 1 bij opgeteld. Nr1 = 10'
  '         dus om het kloppend te maken wordt Nr1 10+2 = 12 rest bij deling is dan 1 */'
  '      Nr1 = 1; '
  '    }'
  '   }'
  '  Result1 += Nr9; '
  '  Result1 += Nr8;'
  '  Result1 += Nr7;'
  '  Result1 += Nr6;'
  '  Result1 += Nr5;'
  '  Result1 += Nr4;'
  '  Result1 += Nr3;'
  '  Result1 += Nr2; '

  '  Result1 += Nr1;'

  '  return Result1;'

  '  /* alert(Result1); */'
  '  /* this.document.write(Result1); */'

  '  /* this.document.forms[0].write(Result1); */    '
  '}'
  'ElfProef();'

  into source separated by cl_abap_char_utilities=>cr_lf.

  js_processor->evaluate( java_script = source ).

  data return_value type string.
  return_value = js_processor->evaluate( java_script = source ).
  write : / 'BSN:', return_value.

endform.                    "bsnnumber


*&---------------------------------------------------------------------*
*&      Form  beconnumber
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
form beconnumber.

  concatenate


'function BeconProef()'
'{'
'  var Result1="";'
'  var Nr6=Math.floor(Math.random()*10);'
'  var Nr5=Math.floor(Math.random()*10);'
'  var Nr4=Math.floor(Math.random()*10);'
'  var Nr3=Math.floor(Math.random()*10);'
'  var Nr2=Math.floor(Math.random()*10);'
'  var Nr1=0;'
'  var SofiNr=0;'

'  SofiNr =  6*Nr6 + 5*Nr5 + 4*Nr4 + 3*Nr3 + 2*Nr2;'

'  /* Het laatste nummer is de rest van deling door 11 */'
'  Nr1 = Math.floor(SofiNr - (Math.floor(SofiNr/11)) * 11); '

'  if (Nr1 > 9)'
'   {'
'    /* rest bij deling kan ook 10 zijn. Dat is een fout sofinummer */'
'    if (Nr2 > 0)'
'    {'
'      Nr2 -= 1;'
'      /* in de formule staat 2*Nr2, bij Nr2 heb ik er 1 afgehaald. Nr1 = 10'
'         dus om het kloppend te maken wordt Nr1 10-2 = 8 */'
'      Nr1 = 8;'
'    }'
'    else /* Als Nr2 nul is... */'
'    {'
'      Nr2 += 1;'
'      /* in de formule staat 2*Nr2, bij Nr2 heb ik er 1 bij opgeteld. Nr1 = 10'
'         dus om het kloppend te maken wordt Nr1 10+2 = 12 rest bij deling is dan 1 */'
'      Nr1 = 1;'
'    }'
'  }'
'  Result1 += Nr6;'
'  Result1 += Nr5;'
'  Result1 += Nr4;'
'  Result1 += Nr3;'
'  Result1 += Nr2;'
'  Result1 += Nr1;'

'  return Result1;'

'}'

'BeconProef();'


  into source separated by cl_abap_char_utilities=>cr_lf.

  js_processor->evaluate( java_script = source ).

  data return_value type string.
  return_value = js_processor->evaluate( java_script = source ).
  write : / 'BEC:', return_value.

endform.                    "beconnumber
