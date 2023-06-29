  #1-
  Scenario: Agregar operaciones de control de carroceria a un aviso "Autorizado"

  Given que el usuario con rol <Rol> de la <Aseguradora> desea agregar operaciones de control a una valoracion
  And el aviso se encuentra "Autorizado"
  When el usuario carga las operacion de control <operaciones_carroceria>
  Then el usuario deberia visualizar la actualizacion del total de carroceria y el valor total de la mano de obra

  Examples:
  |operaciones_carroceria|
  |Alineación de chasis|
  |Bancada|

  #2-
  Scenario: Agregar operaciones de control de mecatronica a un aviso "Autorizado"

  Given que el usuario con rol <Rol> de la <Aseguradora> desea agregar operaciones de control a una valoracion
  And el aviso se encuentra "Autorizado"
  When el usuario carga las operacion de control <operaciones_mecatronica>
  Then el usuario deberia visualizar la actualizacion del total de mecatronica y el valor total de la mano de obra

  Examples:
  |operaciones_mecanica|
  |Diagnóstico electrónico|
  |Programación|
  |Enradiar|
  |Diagnóstico mecánico|
  |Balanceo|
