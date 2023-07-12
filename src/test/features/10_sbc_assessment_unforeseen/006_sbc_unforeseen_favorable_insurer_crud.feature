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
  |remover|
  |TOT|

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

  #5
  Scenario: Permitir cargar como imprevisto la modificacion del valor comercial a rol <Rol> de aseguradora para avisos "Autorizados"

  Given que el usuario con rol <Rol> de aseguradora ingresa a la valoracion de un aviso en estado "Autorizado"
  When el usuario accede a los imprevistos
  Then el usuario deberia poder modificar el valor comercial del vehiculo

  #6
  Scenario: Imprevisto por modificacion de valor comercial no requiere subir fotografias

  Validacion: Se notifica el valor comercial al modulo Administracion en el detalle del aviso al finalizar la valoracion

  Given que el usuario con rol <Rol> de aseguradora desea modificar el valor comercial del vehiculo como imprevisto de un aviso "Autorizado"
  When el usuario modifica el valor comercial
  And finaliza el proceso de valoracion
  Then no debería requerir subir fotografias como soporte de la modificacion



 #7
  Scenario: Imprevisto por reasignacion de taller en la misma ciudad no requiere subir fotografias

  Validacion: Se notifica el cambio de taller al modulo Administracion en el detalle del aviso al finalizar la valoracion

  Given que el usuario con rol <Rol> de aseguradora desea reasignar la valoracion a otro taller en la misma ciudad
  When el usuario modifica el taller en la misma ciudad
  And finaliza el proceso de valoracion
  Then no debería requerir subir fotografias como soporte de la modificacion


 #8
  Scenario: Imprevisto por modificacion de Ciudad de taller y Taller no requiere fotografias

  Validacion: Se notifica el cambio de taller y ciudad del taller al modulo Administracion en el detalle del aviso al finalizar la valoracion

  Given que el usuario con rol <Rol> de aseguradora desea reasignar la valoracion en otra ciudad diferente
  When el usuario modifica la ciudad del taller y el taller
  And finaliza el proceso de valoracion
  Then no debería requerir subir fotografias como soporte de la modificacion

 #9
  Scenario: Validar alerta de notificacion por cambio de taller cuando el aviso esta en estado "Autorizado"

  Given que el Administrador desea reasignar el caso a otro taller en la misma ciudad
  When el Administrador modifica el taller en la misma ciudad
  Then deberia visualizar una alerta por posible afectacion a los procesos de cotizacion y compra asociados a la valoracion
  And deberia poder elegir si acepta o no la modificacion


 #10
  Scenario: Validar alerta de notificacion por cambio de Ciudad de taller cuando el aviso esta en estado "Autorizado"

  Given que el Administrador desea reasignar el taller en otra ciudad diferente
  When el Administrador modifica la ciudad del taller
  Then deberia visualizar una alerta por posible afectacion a los procesos de cotizacion y compra asociados a la valoracion
  And deberia poder elegir si acepta o no la modificacion

 #11
  Scenario: Restringir imprevistos para cambio de Ciudad de Taller o Taller a roles diferente al "Administrador"

  Given que el usuario con rol <Rol> diferente a "Administrador" ingresa a la valoracion de un aviso en estado "Autorizado"
  When el usuario realiza el proceso de cargue de imprevistos
  Then no deberia poder modificar ni la ciudad del taller ni el taller