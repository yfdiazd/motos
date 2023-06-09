#1
  Scenario: Valorar aviso sin numero de siniestro

  Given Que el aviso en estado "Sin valorar" no tiene un numero de siniestro asociado
  When El usuario con <Rol> de la <Aseguradora> ingresa al formulario datos basicos
  Then El sistema muestra el campo "Nro de Siniestro" con el valor "Sin Nro de Siniestro"
  And El campo "Nro de Siniestro" está deshabilitado para edicion
  When El usuario completa el formulario de datos básicos
  And hace clic en el boton "Continuar"
  Then El sistema valida el campo "Nro de Siniestro" como válido
  When El usuario avanza a la pantalla de "Detalle de Valoracion"
  Then El sistema muestra el campo "Nro de Siniestro" con el valor "Sin Nro de Siniestro"


#2
  Scenario: Valorar aviso con numero de siniestro
  Given  Que el aviso en estado "Sin valorar" tiene un numero de siniestro asociado
  When El usuario con <Rol> de la <Aseguradora> ingresa al formulario datos basicos
  Then El sistema muestra el campo "Nro de Siniestro" con el siniestro asociado al aviso
  When el usuario avanza hasta la pantalla "Detalle valoracion"
  Then El sistema muestra el campo "Nro de Siniestro" con el siniestro asociado al aviso







