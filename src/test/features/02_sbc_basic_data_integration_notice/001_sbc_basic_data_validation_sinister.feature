#1
  Scenario: El aviso no tiene siniestro asociado


  Given Que el aviso en estado "Sin valorar" no tiene un numero de siniestro asociado
  When El usuario con <Rol> de la <Aseguradora> ingresa al formulario datos basicos
  Then El sistema muestra el campo 'Nro de Siniestro' con el valor "Sin Nro de Siniestro"
  And El campo 'Nro de Siniestro' está deshabilitado para edicion
  When El usuario completa el formulario de datos básicos
  And hace clic en el boton continuar
  Then El sistema valida el campo "Nro de Siniestro" como válido


#2 (valido o va como data de prueba?)
  Scenario: El aviso tiene siniestro asociado con maximo de caracteres permitido


  Given Que el aviso tiene asociado un numero de siniestro de 50 caracteres que es el maximo permitido
  When El usuario con rol  <Rol> de la <Aseguradora> ingresa al formulario datos basicos
  Then El sistema muestra el campo 'Nro de Siniestro' con el numero de siniestro asociado al aviso
  And El campo 'Nro de Siniestro' esta deshabilitado para edicion
  When El usuario completa el formulario de datos basicos
  And hace clic en el boton continuar
  Then El sistema valida el campo 'Nro de Siniestro' como valido

#3 (valido o va como data de prueba?)
  Scenario: El aviso tiene siniestro asociado con valor 0

  Given Que el aviso tiene asociado un numero de siniestro con valor 0
  When El usuario con  <Rol> de la <Aseguradora> ingresa al formulario datos basicos
  Then El sistema muestra el campo 'Nro de Siniestro' con el numero de siniestro asociado al aviso
  And El campo 'Nro de Siniestro' esta deshabilitado para edicion
  When El usuario completa el formulario de datos basicos
  And hace clic en el boton continuar
  Then El sistema valida el campo 'Nro de Siniestro' como valido


#4
  Scenario: El aviso no tenia numero de siniestro y se edito para asociar numero de siniestro

  Given Que el aviso en estado "Sin valorar" fue editado para asociar el numero de siniestro
  When El usuario con <Rol> de la <Aseguradora> ingresa al formulario datos basicos
  Then El sistema muestra el campo 'Nro de Siniestro' con el nuevo numero de siniestro asociado al aviso
  And El campo 'Nro de Siniestro' esta deshabilitado para edicion
  When El usuario completa el formulario de datos basicos
  And hace clic en el boton continuar
  Then El sistema valida el campo 'Nro de Siniestro' como valido


#5
  Scenario: El aviso tenia numero de siniestro asociado y se edito para modificar el numero de siniestro

  Given Que el aviso en estado "Sin valorar" fue editado para modificar el numero de siniestro
  When El usuario con <Rol> ingresa al formulario datos basicos
  Then El sistema muestra el campo 'Nro de Siniestro' con el nuevo numero de siniestro asociado al aviso
  And El campo 'Nro de Siniestro' esta deshabilitado para edicion
  When El usuario completa el formulario de datos basicos
  And hace clic en el boton continuar
  Then El sistema valida el campo 'Nro de Siniestro' como valido

