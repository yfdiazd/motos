  #regla general para imprevistos.
  #1.  Restricciones de edición en el estado autorizado
  Scenario: No se puede editar información en  mano de obra en el estado "autorizado"
  Given Dado que el usuario está en el estado "autorizado"
  When intenta editar la información en mano de obra
  Then se espera que todas las opciones de edición estén deshabilitadas

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

    #???
  Scenario: No se puede cambiar el tipo de pintura en el estado autorizado
  Given Dado que el usuario está en el estado "autorizado"
  When intenta cambiar el tipo de pintura en el CRUD
  Then se espera que la se muestre un mensaje de error indicando que no se puede cambiar el tipo de pintura

  Scenario: Se pueden agregar notas en el estado autorizado
  Given Dado que el usuario está en el estado "autorizado"
  When agrega notas en el campo correspondiente en el CRUD
  Then se espera que las notas se guarden correctamente

  Scenario: Acceso a través del botón de imprevistos permite la edición en el estado "autorizado"
  Given Dado que el usuario ha ingresado al sistema y utilizando la funcion de "imprevistos"
  When intenta editar la información en el CRUD o en la pantalla de mano de obra
  Then se espera que todas las opciones de edición estén habilitadas y el usuario pueda realizar las ediciones permitidas
