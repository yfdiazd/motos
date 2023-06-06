  #1
  Scenario: Validacion placa cuando cobertura es RC

  Given Que el aviso a valorar tiene asociada la cobertura "RC"
  When El usuario con <Rol> de la <Aseguradora> ingresa al formulario datos basicos
  Then El sistema muestra el campo "Placa" con la placa del tercero asociada al aviso
  And El campo "Placa" esta deshabilitado para edicion
  When El usuario completa el formulario de datos basicos
  And hace clic en el boton "Continuar"
  Then El sistema valida el campo "Placa" como valido
  When El usuario avanza a la pantalla de "Detalle de Valoracion"
  Then El sistema muestra en el campo "Placa Tercero" la placa del tercero asociada al aviso
  And El sistema muestra en el campo "Placa Asegurado" la placa del asegurado asociada al aviso

  #2 Falta ajustar figma para cambiar el orden de los campos, falta en criterio
  Scenario: Validacion de placa asegurado segun cobertura

  Given Que el aviso a valorar tiene asociada la <Cobertura>
  When el usuario con  <Rol> de la <Aseguradora> ingresa al formulario datos basicos
  Then El sistema muestra el campo "Placa" con la placa del asegurado asociada al aviso
  And el campo "Placa" está deshabilitado para edición
  When El usuario completa el formulario de datos basicos
  And hace clic en el boton "Continuar"
  Then el sistema valida el campo "Placa" como válido
  When El usuario avanza a la pantalla de "Detalle de Valoracion"
  Then El sistema muestra en el campo "Placa Asegurado" la placa del asegurado asociada al aviso
  And El sistema no muestra el campo "Placa Tercero"

  Examples:
  | Cobertura |
  | PPD       |
  | PPH       |


    """
  #4
  Scenario: Validacion del numero minimo de caracteres para la placa en Colombia

  Given Que el aviso a valorar corresponde a la aseguradora Bolivar
    And la placa del aviso tiene el minimo de caracteres que es 4
  When El usuario con rol  <Rol> ingresa al formulario datos basicos
  Then El sistema muestra el campo 'Placa' con la placa asociada al aviso
    And El campo 'Placa' esta deshabilitado para edicion
    And Al completar el formulario de datos basicos
    And hacer clic en el boton continuar
    Then El sistema valida el campo 'Placa' como valido


#5
  Scenario: Validacion del numero minimo de caracteres para la placa en Chile

  Given Que el aviso a valorar corresponde a la aseguradora Bolivar
    And la placa del aviso tiene el minimo de caracteres que es 5
  When El usuario con rol  <Rol> ingresa al formulario datos basicos
  Then El sistema muestra el campo 'Placa' con la placa asociada al aviso
    And El campo 'Placa' esta deshabilitado para edicion
    And Al completar el formulario de datos basicos
    And hacer clic en el boton continuar
    Then El sistema valida el campo 'Placa' como valido

"""