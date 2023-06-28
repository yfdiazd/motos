  #1
  Scenario: Permitir a rol <Rol> de taller cargar imprevisto de remocion a reparacion en un aviso "Autorizado"

  Regla de negocio 1: El cambio de accion implica recalculo de horas en el baremo por ende actualizacion del valor de mano de obra
  y valor total de reparacion
  Posicion de la pieza: Debe mantener la misma posicion. Fila 127 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"

  Given que el usuario con rol <Rol> de taller requiere cambiar la accion de una pieza de "Remover" a "Reparar"
  And el aviso se encuentra "Autorizado"
  When el usuario realiza el cambio de accion de la pieza de "Remover" a "Reparar"
  Then el usuario deberia visualizar la pieza en estado pendiente por aprobar de primera en el listado de repuestos
  And al finalizar el proceso de cargue del imprevisto deberia tener que cargar fotografias que soporten el cambio realizado


  #2
  Scenario: Permitir a rol <Rol> de taller carga imprevisto de remocion a TOT en un aviso "Autorizado"

  Regla de negocio 1: como las TOT no tienen baremo ni mano de obra al hacer el cambio de accion si existia mano de obra asociada a la remocion
  entonces se debe descontar y recalcular el valor de mano de obra
  Posicion de la pieza: Debe mantener la misma posicion. Fila 128 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"


  Given que el usuario con rol <Rol> de taller requiere cambiar la accion de una pieza de "Remover" a "TOT"
  And el aviso se encuentra "Autorizado"
  When el usuario realiza el cambio de accion de la pieza de "Remover" a "TOT"
  Then el usuario deberia visualizar la pieza en estado pendiente por aprobar de primera en el listado de repuestos
  And al finalizar el proceso de cargue del imprevisto deberia tener que cargar fotografias que soporten el cambio realizado

  #3-
  Scenario: Permtir a rol <Rol> de taller cargar imprevisto de remocion a cambio en un aviso "Autorizado"

  Regla de negocio 1: Remover a Cambiar implica recalculo de horas en el baremo por ende actualizacion del valor de mano de obra
  y valor total de reparacion
  Posicion de la pieza: Debe mantener la misma posicion. Fila 126 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"


  Given que el usuario con rol <Rol> de taller requiere cambiar la accion de una pieza de "Remover" a "Cambiar"
  And el aviso se encuentra "Autorizado"
  When el usuario realiza el cambio de accion de la pieza de "Remover" a "Cambiar"
  Then el usuario deberia visualizar la pieza en estado pendiente por aprobar de primera en el listado de repuestos
  And al finalizar el proceso de cargue del imprevisto deberia tener que cargar fotografias que soporten el cambio realizado

  #4-
  Scenario: Permtir a rol <Rol> de taller cargar imprevisto de reparacion a cambio en un aviso "Autorizado"

  Posicion de la pieza: Debe mantener la misma posicion. Fila 126 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"


  Given que el usuario con rol <Rol> de taller requiere cambiar la accion de una pieza de "Reparar" a "Cambiar"
  And el aviso se encuentra "Autorizado"
  When el usuario realiza el cambio de accion de la pieza de "Reparar" a "Cambiar"
  Then el usuario deberia visualizar la pieza en estado pendiente por aprobar de primera en el listado de repuestos
  And al finalizar el proceso de cargue del imprevisto deberia tener que cargar fotografias que soporten el cambio realizado
