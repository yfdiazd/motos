  #regla general para imprevistos.
  #1.  Restricciones de edición en el estado autorizado
  Scenario: No se puede editar información en  mano de obra en el estado "autorizado"

  Given  que el usuario con rol <Rol> desea modificar la mano de obra para un aviso "Autorizado"
  When  consulta la valoracion sin hacer uso de la accion de imprevistos
  Then el usuario no deberia poder modificar la informacion de la mano de obra

  #2
  Scenario: No se puede cambiar el valor comercial en el estado autorizado

  Given  que el usuario con rol <Rol> desea modificar el valor comercial para un aviso "Autorizado"
  When  consulta la valoracion sin hacer uso de la accion de imprevistos
  Then el usuario no deberia poder modificar la informacion del valor comercial

  #3
  Scenario: No se puede cambiar la ciudad del taller en el estado autorizado

  Given  que el usuario con rol <Rol> desea modificar la ciudad del taller para un aviso "Autorizado"
  When  consulta la valoracion sin hacer uso de la accion de imprevistos
  Then el usuario no deberia poder modificar la informacion de la ciudad del taller

  #4
  Scenario: No se puede cambiar el taller en el estado autorizado

  Given  que el usuario con rol <Rol> desea modificar el taller para un aviso "Autorizado"
  When  consulta la valoracion sin hacer uso de la accion de imprevistos
  Then el usuario no deberia poder modificar la informacion del taller

  #5
  Scenario: Se pueden agregar notas en el estado autorizado

  Given que el usuario con rol <Rol> desea agregar notas para un aviso "Autorizado"
  When consulta la valoracion y hace uso de la accion de imprevistos
  Then el usuario deberia poder agregar las notas
  And  deberia visualizarlas con los datos de <auditoria>
  And finalizar el proceso, no se deben solicitar la carga de imagenes

  |auditoria|
  |rol, usuario, fecha y hora|


  #6
  Scenario: Permiter la edición del aviso estado "autorizado"

  Given que el usuario con rol <Rol> desea editar un aviso "Autorizado"
  When consulta la valoracion y hace uso de la accion de imprevistos
  And  intenta editar la información en de valor comercial, taller o ciudad del talle
  Then se espera que todas las opciones de edición estén habilitadas
  And el usuario pueda realizar las ediciones permitidas
  And finalizar el proceso, no se deben solicitar la carga de imagenes

  |Rol|
  |Administrador|

    # Imprevistos pendientes por aprobar o rechazar
  #7
  Scenario: aprobar imprevistos pendientes, con estado TOT o Cambio.

  Given que el usuario de rol <Rol> desea aprobar imprevistos pendientes
  When selecciona los imprevistos a aprobar
  Then deberia visualizar los repuestos seleccionados en estado aprobado
  And al finalizar el proceso, el usuario deberia ser notificado del envio al proceso de compras, de los repuestos aprobados

  |Rol|
  |analista aseguradora|
  |ATS|
  |administrador|
  |perito aseguradora|
  |gestor taller|
  |mesa especializada|

  #8-
  Scenario: aprobar imprevistos pendietes, con estado diferente a TOT o Cambio.
  Regla de negocio: los repuestos aprobados de accion Reparar o Remover no se deben enviar a compras

  Given que el usuario de rol <Rol> desea aprobar imprevistos pendientes
  When selecciona los imprevistos a aprobar
  Then deberia visualizar los repuestos seleccionados en estado aprobado
  And al finalizar el proceso, el usuario deberia ser notificado del ajuste realziado

  |Rol|
  |analista aseguradora|
  |ATS|
  |administrador|
  |perito aseguradora|
  |gestor taller|
  |mesa especializada|

  #9
  Scenario: Rechazar imprevistos pendientes

  Given que el usuario de rol <Rol> desea rechazar imprevistos pendientes
  When selecciona los imprevistos a rechazar
  Then deberia visualizar los repuestos seleccionados en estado rechazado
  And deberia visualizar la actualizacion de los valores para mano de obra, repuestos y el total del costo de la reparacion
  And al finalizar el proceso, el usuario deberia ser notificado del ajuste realziado

  |Rol|
  |analista aseguradora|
  |ATS|
  |administrador|
  |perito aseguradora|
  |gestor taller|
  |mesa especializada|

  #10
  Scenario: No permitir incluir nuevos imprevistos a rol <Rol> de aseguradora si hay imprevistos pendientes por aprobar

  Given que el usuario de rol <Rol> de aseguradora desea cargar nuevos imprevistos
  And el existe imprevistos pendientes por aprobar o rechazar
  When el usuario ingresa a la valoracion
  Then el usuario no deberia poder cargar nuevos imprevistos positivos o negativos hasta no ser aprobabos o rechazados los que estan pendientes
