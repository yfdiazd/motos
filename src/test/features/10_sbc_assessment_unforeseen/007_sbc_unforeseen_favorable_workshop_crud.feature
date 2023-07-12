  Background:
  Reglas de negocio globales en imprevistos!
  Regla de negocio 1: El imprevisto de cambio ó TOT no viaja a compras hasta que no se aprueba por parte de la aseguradora
  Regla de negocio 2: Para una pieza de cambio no se visualiza tipo de golpe y  el precio por defecto es 0 y no permite modificarse
  Regla de negocio 3: El cambio de accion implica recalculo de horas en el baremo por ende actualizacion del valor de mano de obra
  y valor total de reparacion.
  Regla de negocio 5: Las TOT no tienen baremo ni mano de obra, al hacer el cambio de accion si existia mano de obra asociada a la accion anterior
  entonces se debe descontar y recalcular el valor de mano de obra y total de reparacion
  Regla de negocio 6: Para los imprevistos de reparacion no se permite modificar precio, ni cantidad y no se debe visualizar referencia
  Regla de negocio 7: Los roles de taller no pueden modificar la condicion de agrupado cuando cargan imprevistos positivos por cambio de accion


  #1
  Scenario: Permitir a rol <Rol> de taller cargar imprevisto  por cambio de accion de remocion a reparacion en un aviso "Autorizado"
  Aplica Regla de Negocio 6
  Posicion de la pieza: No enviada a compras. Debe mantener la misma posicion. Fila 127 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"

  Given que el usuario con rol <Rol> de taller requiere cambiar la accion de una pieza de "Remover" a "Reparar"
  And el aviso se encuentra "Autorizado"
  When el usuario realiza el cambio de accion de la pieza de "Remover" a "Reparar"
  Then el usuario deberia visualizar la pieza en estado pendiente por aprobar de primera en el listado de repuestos
  And deberia poder modificar el nivel de danio
  And al finalizar el proceso de cargue del imprevisto deberia tener que cargar fotografias que soporten el cambio realizado



  #2
  Scenario: Permitir a rol <Rol> de taller carga imprevisto de remocion a TOT en un aviso "Autorizado"

  Posicion de la pieza:No enviada a compras. Debe mantener la misma posicion. Fila 128 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"

  Given que el usuario con rol <Rol> de taller requiere cambiar la accion de una pieza de "Remover" a "TOT"
  And el aviso se encuentra "Autorizado"
  When el usuario realiza el cambio de accion de la pieza de "Remover" a "TOT"
  Then el usuario deberia visualizar la pieza en estado pendiente por aprobar de primera en el listado de repuestos
  And al finalizar el proceso de cargue del imprevisto deberia tener que cargar fotografias que soporten el cambio realizado

  #3-
  Scenario: Permtir a rol <Rol> de taller cargar imprevisto de remocion a cambio en un aviso "Autorizado"

  Posicion de la pieza: No enviada a compras.Debe mantener la misma posicion. Fila 126 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"

  Given que el usuario con rol <Rol> de taller requiere cambiar la accion de una pieza de "Remover" a "Cambiar"
  And el aviso se encuentra "Autorizado"
  When el usuario realiza el cambio de accion de la pieza de "Remover" a "Cambiar"
  Then el usuario deberia visualizar la pieza en estado pendiente por aprobar de primera en el listado de repuestos
  And al finalizar el proceso de cargue del imprevisto deberia tener que cargar fotografias que soporten el cambio realizado

  #4- validar con equipo regla de negocio 1 porque actualmente cuando se pasa a cambio como no se ha guardado permite cambiar a reparar o TOT
  Scenario: Permtir a rol <Rol> de taller cargar imprevisto de reparacion a cambio en un aviso "Autorizado"

  Regla de negocio 1: El taller no puede cambiar las acciones que se consideran imprevisto negativo: Cambiar a cualquier otra accion
  Posicion de la pieza: No enviada a compras. Debe mantener la misma posicion. Fila 122 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"


  Given que el usuario con rol <Rol> de taller requiere cambiar la accion de una pieza de "Reparar" a "Cambiar"
  And el aviso se encuentra "Autorizado"
  When el usuario realiza el cambio de accion de la pieza de "Reparar" a "Cambiar"
  Then el usuario deberia visualizar la pieza en estado pendiente por aprobar de primera en el listado de repuestos
  And deberia poder realizar las siguientes acciones <acciones>
  And al finalizar el proceso de cargue del imprevisto deberia tener que cargar fotografias que soporten el cambio realizado


  Examples:
  |acciones|
  |Agrupar|
  |modificar referencia|
  |modificar cantidad|


  # 5-

  Scenario: Restringir imprevistos por modificacion del valor comercial a rol <Rol> de taller para avisos "Autorizados"

  Given que el usuario con rol <Rol> de taller ingresa a la valoracion de un aviso en estado "Autorizado"
  When el usuario accede a los imprevistos
  Then el usuario no deberia poder modificar el valor comercial del vehiculo como imprevisto

  Examples:
  |Rol|
  |Jefe de taller|Asesor de servicio taller|Cotizador de danios taller|