#1 Ajustar ya que por cada aseguradora hay una cobertura distinta (convenciones panamá y Chile)
Scenario: Validacion cobertura del aviso

    Given Que el aviso en estado "Sin valorar" para la <Aseguradora> tiene asociada la cobertura <Cobertura>
    When el usuario con  <Rol> ingresa al formulario datos basicos
    Then El sistema muestra el campo 'Cobertura' con la cobertura asociada al aviso
    And El campo 'Cobertura' esta deshabilitado para edicion
    When el usuario completa el formulario de datos basicos
    And hacer clic en el boton "Continuar"
    Then El sistema valida el campo 'Cobertura' como valido
  Examples:
  | Cobertura |
  | PPD       |
  | PPH|
  | RC|

  Examples:
  |Aseguradora|
  |Sura|
  |Bolivar|
  |Sura Panama|
  |Sura Chile|
  #2

  Scenario: Validacion ciudad de ocurrencia del aviso

  Given Que el aviso en estado "Sin valorar" para la <Aseguradora> tiene asociada la ciudad de ocurrencia
  When el usuario con  <Rol> ingresa al formulario datos basicos
  Then El sistema muestra el campo "Ciudad de ocurrencia" con la ciudad asociada al aviso
  And El campo "Ciudad de ocurrencia" esta deshabilitado para edicion
  When  El usuario completa el formulario de datos basicos
  And hace clic en el boton "Continuar"
  Then El sistema valida el campo "Ciudad de ocurrencia" como valido

  #3

  Scenario: Validacion actualizacion ciudad de ocurrencia en el  aviso

  Given Que se edita la "Ciudad de ocurrencia"  del aviso en estado "Sin valorar"
  When el usuario con  <Rol> de la <Aseguradora> ingresa al formulario datos basicos
  Then El sistema muestra el campo "Ciudad de ocurrencia" con la ciudad asociada al aviso
  And El campo "Ciudad de ocurrencia" esta deshabilitado para edicion
  When El usuario completa el formulario de datos basicos
  And hace clic en el boton "Continuar"
  Then El sistema valida el campo 'Ciudad de ocurrencia' como valido

