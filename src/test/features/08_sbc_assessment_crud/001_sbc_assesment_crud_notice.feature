  #1 - Escenario para validar  "Valor comercial" y "porcentaje perdida"
  Scenario: Validar modificacion de "Valor comercial"
  Given que se tiene un aviso en estado <estado>
  When el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla "Crud" desde el boton "Ir"
  And el sistema muestra el valor comercial asociado al vehiculo en el campo "Valor comercial"
  When el usuario edita el valor comercial por uno mayor a 0
  Then el sistema recalcula el campo "Porcentaje de perdida"
  When el usuario pulsa el boton "Finalizar"
  Then el sistema debe mostrar el mensaje modal con los botones No o Si
  When el usuario selecciona la opcion Si
  Then el sistema guarda los cambios en la base de datos y lleva al usuario a la pantalla de "Detalle del aviso"
  And si el <estado> del aviso es igual a pendiente ajuste el sistema debe actualizar el nuevo estado a ajustado, sino se mantiene el estado visualizado en CRUD
  And el sistema muestra en la pantalla los campos "Valor comercial" y "Porcentaje de perdida" con los valores previamente ajustados en el crud


  Examples:
  |estado|
  |pendiente ajuste|
  |ajustado|
  |pendiente autorizacion|
  |Pendiente Conciliación|
  |Pendiente Aceptación|



  #2 Escenario para validar  "Valor comercial" mayor a cero
  Scenario: Validar modificacion de "Valor comercial" igual a cero
  Given que se tiene un aviso en estado <estado>
  When el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla "Crud" desde la pantalla "Detalle aviso"
  And el sistema muestra el valor comercial asociado al vehiculo en el campo "Valor comercial"
  When el usuario puede editar el valor comercial e ingresa el valor cero
  Then el sistema recalcula el campo "Porcentaje de perdida"
  When el usuario pulsa el boton "Finalizar"
  Then el sistema no debe permitir guardar los cambios e indicar que el campo "Valor comercial" debe tener un valor mayor a cero


  Examples:
  |estado|
  |pendiente ajuste|
  |ajustado|
  |pendiente autorizacion|
  |Pendiente Conciliación|
  |Pendiente Aceptación|

  #3 - Escenario para validar  "ciudad del taller" y "taller"
  Scenario: Validar modificacion de los campos "ciudad del taller" y "Taller"
  Given que se tiene un aviso en estado <estado>
  When el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla "Crud" desde el boton "Ir"
  And el sistema muestra en los campos "ciudad del taller" y "Taller" habilitados para edicion
  When el usuario edita el valor del campo "ciudad del taller", el cual lista los talleres asociados a la <Aseguradora> del usuario
  Then el sistema debe limpiar el campo "Taller"
  When el usuario diligencia el cmapo <Taller>
  And el usuario pulsa el boton "Finalizar"
  Then el sistema debe mostrar el mensaje modal con los botones No o Si
  When el usuario selecciona la opcion Si
  Then el sistema guarda los cambios en la base de datos y lleva al usuario a la pantalla de "Detalle del aviso"
  And si el <estado> del aviso es igual a pendiente ajuste el sistema debe actualizar el nuevo estado a ajustado, sino se mantiene el estado visualizado en CRUD
  And el sistema muestra en la pantalla los campos "Ciudad Taller" y "Taller" con los valores previamente ajustados en el crud

  Examples:
  |estado|
  |pendiente ajuste|
  |ajustado|
  |pendiente autorizacion|
  |Pendiente Conciliación|
  |Pendiente Aceptación|

  #4 - Escenario para validar los campos no editables del Encabezado de reparación
  Scenario: Validar la no modificacion de campos informativos en el "Encabezado de reparación"
  Given que se tiene un aviso en estado <estado>
  When el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla "Crud" desde la pantalla "Detalle aviso"
  And el sistema muestra en el apartado "Encabezado de reparación" los campos: "Placa Asegurado", "Placa Tercero", "Marca", "Linea", "Version", "Año", "VIN", "Ciudad de ocurrencia", "N Aviso", "Estado", "Logo", "N Siniestro", "Cobertura", "Tipo de vehiculo/carroceria"
  When el usuario NO puede editar el valor de ninguno de los campos

  Examples:
  |estado|
  |pendiente ajuste|
  |ajustado|
  |pendiente autorizacion|
  |Pendiente Conciliación|
  |Pendiente Aceptación|

  #5 - Escenario para validar los botones de descargas y Valorado por

  Scenario: Validar descarga con los botones  "descargar valoración" y "Descargar imagenes"
  Given que se tiene un aviso en estado <estado>
  When el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla "Crud" desde el boton "Ir"
  And el sistema muestra el boton "descargar valoracion" situado en la parte superior derecha del grupo "Encabezado de reparacion"
  When el usuario pulsa el boton "descargar valoracion"
  Then el sistema debe permitir descargar de un archivo de extension ".PDF", el cual contiene los datos de la valoracion actual
  When el usuario tambien pulsa el boton "Descargar imagenes"
  Then el sistema debe permitir descargar de un archivo de extension ".ZIP", el cual contiene las imagenes guardadas en la valoracion
  When el usuario tambien puede visualizar el campo no editable "Valorado por" el cual muestra el nombre del usuario que valoro el aviso acompañado de la fecha y la hora

  Examples:
  |estado|
  |Pendiente ajuste
  |Ajustado|
  |Pendiente Aceptacion|
  |Pendiente Autorizacion|
  |Autorizado|
  |Reparado|
  |Entregado|
  |PTD|

  #6 - funcionalidad Agregar repuestos
  Scenario: Validar la opcion para poder agregar piezas al crud
  Given que se tiene un aviso en estado <estado>
  When el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla "Crud" desde la pantalla "Detalle aviso"
  Then el sistema muestra el campo "Agregar repuestos" el cual permite agregar nuevas piezas
  When el usuario ingresa la pieza a buscar
  Then el sistema lista piezas que contienen el valor ingresado en el campo
  When el usuario selecciona la pieza del listado
  Then el sistema la agrega a la tabla de piezas, con la accion reparar y nivel de danio "L" por defecto
  And el campo de "Precio" con el valor cero acompañado por el tipo de moneda del <pais>


  Examples:
  |estado|
  |pendiente ajuste|
  |ajustado|
  |pendiente autorizacion|
  |Pendiente Conciliación|
  |Pendiente Aceptación|

    #6 - funcionalidad Agregar repuestos ya existentes en la tabla
  Scenario: Validar el control de duplicidad de piezas
  Given que se tiene un aviso en estado <estado>
  When el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla "Crud" desde la pantalla "Detalle aviso"
  Then el sistema muestra el campo "Agregar repuestos" el cual permite agregar nuevas piezas
  When el usuario diligencia el campo "Agregar repuestos" con una <Pieza>
  Then el sistema lista piezas que contienen el valor ingresado en el campo
  And excluye la <Pieza> exactamente buscada, en caso de existir en la tabla de piezas


  Examples:
  |estado|
  |pendiente ajuste|
  |ajustado|
  |pendiente autorizacion|
  |Pendiente Conciliación|
  |Pendiente Aceptación|

  #7 funcionalidad botones eliminar
  Scenario: Validar la opcion para eliminar repuestos
  Given que se tiene un aviso en estado <estado>
  When el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla "Crud" desde el boton "Ir"
  Then el sistema muestra sobre la tabla de repuestos el boton "Eliminar"
  When el usuario selecciona repuestos de la tabla marcandolos con el campo "Check" o selecciona el campo "Seleccionar todos" tipo check
  And pulsa el boton "Eliminar"
  Then el sistema muestra el mensaje: "¿ Estas seguro de que deseas eliminar la informacion ?" de confirmacion con el boton "Aceptar"
  When el usuario pulsa el boton aceptar
  Then elimina los repuestos seleccionados previamente



    # x
  Scenario validar cambio de accion de "Reparar" a "Cambiar"
  Given que se tiene un aviso en estado <estado>
  When el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla "Crud" desde la pantalla "Detalle aviso"
  And agrega una pieza a la tabla de repuestos
  And guarda los cambios con el boton "Guardar"
  Then el sistema muestro el mensaje modal: "se guardo con exito"
  When el usuario cambia la accion del repuesto ingresado a "Cambiar"
  Then el sistema habilita para edicion el campo "Precio"
  And oculta la opcion "nivel de danio" y habilita el campo "cantidades"