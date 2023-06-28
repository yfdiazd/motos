  #1-

  Scenario: Agregar pieza con accion <accion> a un aviso "Autorizado"

  Given que el usuario con rol <Rol> de la <Aseguradora> desea agregar una nueva pieza con accion <accion>
  And el aviso se encuentra "Autorizado"
  When el usuario agrega la pieza en el listado de repuestos
  Then el usuario deberia visualizar la pieza de primera en el listado de repuestos en estado pendiente por aprobar
  And no deberia poder modificar ni el precio ni la referencia de la pieza
  And para finalizar el proceso de cargue de imprevistos deberia tener que cargar fotografias que soporten el imprevisto solicitado

  Examples:
  |accion|
  |cambiar|
  |reparar|

  #2-
  Scenario: Cargar imprevisto por cambio de accion de "Reparar" a "Cambiar" en un aviso "Autorizado"

  Posicion de la pieza: Debe mantener la misma posicion. Fila 122 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"


  Given que el usuario con rol <Rol> de la <Aseguradora> desea cambiar una pieza prevista inicialmente para reparacion
  And el aviso se encuentra "Autorizado"
  When el usuario modifica la accion de la pieza de "Reparar" a "Cambiar"
  Then el usuario deberia visualizar la pieza en estado pendiente por aprobar de primera en el listado de repuestos
  And no deberia poder modificar ni el precio ni la referencia de la pieza
  And al finalizar el proceso de cargue del imprevisto deberia tener que cargar fotografias que soporten el cambio realizado


  #3-
  Scenario: Cargar imprevisto por aumento en el nivel de danio de una pieza de reparacion en un aviso "Autorizado"

  Given que el usuario con rol <Rol> de la <Aseguradora> desea aumentar el nivel de danio de una pieza de reparacion
  And el aviso se encuentra "Autorizado"
  When el usuario modifica el nivel de danio <nivel de danio> de la pieza
  Then el usuario deberia visualizar la pieza en estado pendiente por aprobar de primera en el listado de repuestos
  And al finalizar el proceso de cargue del imprevisto deberia tener que cargar fotografias que soporten el cambio realizado

  Examples:
  |nivel de danio|
  |Leve|
  |Medio|
  |Fuerte|

  #4- validar con lorena como deberia funcionar el aumento de cantidad porque como ahora se deja modificar en tot, remover y cambiar
  Scenario: Cargar imprevisto por aumento de cantidad en piezas con accion <accion> en un aviso "Autorizado"

  Given que el usuario con rol <Rol> de la <Aseguradora> desea aumentar la cantidad de repuesto para una pieza con accion <accion>
  And el aviso se encuentra "Autorizado"
  When el usuario carga nuevamente la pieza al listado de repuestos
  Then deberia poder modificar la cantidad del repuesto que requiere
  And al finalizar el proceso de cargue del imprevisto deberia tener que cargar fotografias que soporten el cambio realizado

  Examples:
  |accion|
  |cambiar|

  #5-