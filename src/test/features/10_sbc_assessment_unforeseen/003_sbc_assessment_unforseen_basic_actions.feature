  #regla general para imprevistos.
  #1.  Restricciones de edición en el estado autorizado
  Scenario: No se puede editar información en  mano de obra en el estado "autorizado"

  Given  que el usuario con rol <Rol> desea modificar la mano de obra para un aviso "Autorizado"
  When  consulta la valoracion sin hacer uso de la accion de imprevistos
  Then el usuario no deberia poder modificar la informacion de la mano de obra

  Scenario: No se puede cambiar el valor comercial en el estado autorizado
  Given Dado que el usuario está en el estado "autorizado"
  When intenta cambiar el valor comercial en el CRUD
  Then se espera que no se puededa cambiar el valor comercial

  Scenario: No se puede cambiar la ciudad del taller en el estado autorizado
  Given Dado que el usuario está en el estado "autorizado"
  When intenta cambiar la ciudad del taller en el CRUD
  Then se espera que no se puede cambiar la ciudad del taller

  Scenario: No se puede cambiar el taller en el estado autorizado
  Given Dado que el usuario está en el estado "autorizado"
  When intenta cambiar el taller en el CRUD
  Then se espera que no se puede cambiar el taller


  Scenario: Se pueden agregar notas en el estado autorizado
  Given Dado que el usuario está en el estado "autorizado"
  When agrega notas en el campo correspondiente en el CRUD
  Then se espera que las notas se guarden correctamente

  Scenario: Acceso a través del botón de imprevistos permite la edición en el estado "autorizado"
  Given Dado que el usuario ha ingresado al sistema y utilizando la funcion de "imprevistos"
  When intenta editar la información en el CRUD o en la pantalla de mano de obra
  Then se espera que todas las opciones de edición estén habilitadas y el usuario pueda realizar las ediciones permitidas
