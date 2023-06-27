  #regla general para imprevistos.
  #1.  Restricciones de edición en el estado autorizado
  Scenario: No se puede editar información en  mano de obra en el estado "autorizado"

  Given  que el usuario con rol <Rol> desea modificar la mano de obra para un aviso "Autorizado"
  When  consulta la valoracion sin hacer uso de la accion de imprevistos
  Then el usuario no deberia poder modificar la informacion de la mano de obra


  Scenario: No se puede cambiar el valor comercial en el estado autorizado

  Given  que el usuario con rol <Rol> desea modificar el valor comercial para un aviso "Autorizado"
  When  consulta la valoracion sin hacer uso de la accion de imprevistos
  Then el usuario no deberia poder modificar la informacion del valor comercial

  Scenario: No se puede cambiar la ciudad del taller en el estado autorizado

  Given  que el usuario con rol <Rol> desea modificar la ciudad del taller para un aviso "Autorizado"
  When  consulta la valoracion sin hacer uso de la accion de imprevistos
  Then el usuario no deberia poder modificar la informacion de la ciudad del taller


  Scenario: No se puede cambiar el taller en el estado autorizado

  Given  que el usuario con rol <Rol> desea modificar el taller para un aviso "Autorizado"
  When  consulta la valoracion sin hacer uso de la accion de imprevistos
  Then el usuario no deberia poder modificar la informacion del taller


  Scenario: Se pueden agregar notas en el estado autorizado

  Given que el usuario con rol <Rol> desea agregar notas para un aviso "Autorizado"
  When consulta la valoracion y hace uso de la accion de imprevistos
  Then el usuario deberia poder agregar las notas
  And se espera que se guarden correctamente


  Scenario: Permiter la edición del aviso estado "autorizado"

  Given que el usuario con rol <Rol> desea agregar notas para un aviso "Autorizado"
  When consulta la valoracion y hace uso de la accion de imprevistos
  Then el usuario deberia poder agregar las notas
  And se espera que se guarden correctamente


  Given que el usuario con rol <Rol> desea editar un aviso "Autorizado"
  When consulta la valoracion y hace uso de la accion de imprevistos
  And  intenta editar la información en el CRUD o la mano de obra
  Then se espera que todas las opciones de edición estén habilitadas
  And el usuario pueda realizar las ediciones permitidas
