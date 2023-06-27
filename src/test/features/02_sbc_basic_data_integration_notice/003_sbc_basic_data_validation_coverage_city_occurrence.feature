#1
Scenario: Validacion cobertura del aviso

    Given Que el aviso en estado "Sin valorar" para la <Aseguradora> tiene asociada la cobertura <Cobertura>
    When el usuario con  <Rol> ingresa al formulario datos basicos
    Then El sistema muestra el campo "Cobertura" con la <Cobertura> asociada al aviso
    And El campo "Cobertura" esta deshabilitado para edicion
    When El usuario avanza a la pantalla de "Detalle de Valoracion"
    Then El sistema muestra el campo "Cobertura"  con la <Cobertura> asociada al aviso
    And no permite editarse


  Examples:
  | Cobertura|Aseguradora|
  | PPD|Sura|
  | PPH|Sura|
  | RC|Sura|
  |PPD|Bolivar|
  |PPH|Bolivar|
  |RC|Bolivar|
  |RC-Daños a la propiedad ajena| Sura Panama|
  |PPD-Comprensivo, colisión o vuelco| Sura Panama|
  |PPH-Hurto| Sura Panama|

  |Cobertura Chile|
  |https://docs.google.com/spreadsheets/d/1NslC1QsXIAjq99HekmdQhkelETbZpw6p/edit#gid=184756209 hoja Homologacion|


  Examples:
  |Aseguradora|
  |Sura|
  |Bolivar|
  |Sura Panama|
  |Sura Chile|
  #2
    Scenario: Validar ciudad de ocurrencia asociada al aviso

    Given Que el aviso en estado "Sin valorar" esta asociado a  una ciudad de ocurrencia
    When El usuario con <Rol> de la <Aseguradora> ingresa al formulario datos basicos
    Then El sistema muestra el campo "Ciudad de ocurrencia" con la ciudad asociada al aviso
    And El campo "Ciudad de ocurrencia" está deshabilitado para edicion
    When El usuario completa el formulario de datos básicos
    And hace clic en el boton "Continuar"
    Then El sistema valida el campo "Ciudad de ocurrencia" como válido
    When El usuario avanza a la pantalla de "Detalle de Valoracion"
    Then El sistema muestra el campo "Ciudad de ocurrencia" con la ciudad asociada al aviso



