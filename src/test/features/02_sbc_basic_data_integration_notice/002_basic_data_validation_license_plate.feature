  #1
  Scenario: Validar campo placa en "Datos basicos" y "Detalle Valoracion" cuando cobertura es RC

  Given Que el aviso a valorar tiene asociada la cobertura "RC"
  When El usuario con <Rol> de la <Aseguradora> ingresa al formulario datos basicos
  Then El sistema muestra el campo "Placa" con la placa del tercero asociada al aviso
  And El campo "Placa" esta deshabilitado para edicion
  When El usuario completa el formulario de datos basicos
  And hace clic en el boton "Continuar"
  And avanza a la pantalla de "Detalle de Valoracion"
  Then El sistema muestra en el campo "Placa Tercero" la placa del tercero asociada al aviso

  #2 Falta ajustar figma para cambiar el orden de los campos, falta en criterio
  Scenario: Validar campo placa en "Datos basicos" y "Detalle Valoracion" cuando cobertura es diferente a RC

  Given Que el aviso a valorar tiene asociada la <Cobertura>
  When el usuario con  <Rol> de la <Aseguradora> ingresa al formulario datos basicos
  Then El sistema muestra el campo "Placa" con la placa del asegurado asociada al aviso
  And el campo "Placa" está deshabilitado para edición
  When El usuario completa el formulario de datos basicos
  And hace clic en el boton "Continuar"
  And avanza a la pantalla de "Detalle de Valoracion"
  Then El sistema muestra en el campo "Placa Asegurado" la placa del asegurado asociada al aviso

  Examples:
  | Cobertura | descripcion |
  | PPD       |cobertura perdida parcial por daños |
  | PPH       |cobertura perdida parcial por hurto |


