#1
Scenario: Redireccionamiento a pantallas anteriores al hacer clic en el boton "Volver"

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
  When El usuario hace clic en el boton "Volver"
  Then El sistema regresa al usuario a la pantalla de "Zonas afectadas" para consultar la informacion diligenciada
  And Permite cargar nuevamente fotografias y documentos
  When el usuario hace clic en el boton "Volver" de "Zonas afectadas"
  Then El sistema regresa al usuario a la pantalla de "Datos basicos" para consultar la informacion diligenciada
  And El sistema muestra habilitado el formulario para realiza edicion de informacion
  When El usuario modifica el numero del VIN a traves del OCR
  And El sistema reconoce el VIN
  Then  El sistema carga nuevamente la informacion del vehiculo asociada al VIN, Marca, Linea, Version Modelo y Valor Comercial
  And El sistema mantiene diligenciado los demas campos que no se han editado
  When El usuario modifica la carroceria
  And hace clic en el boton "Continuar"
  Then El sistema lo redirecciona nuevamente a la pantalla de "Zonas Afectadas"
  And muestra en la pestana de fotografias la imagen de la tarjeta de propiedad cargada
  And muestra las otras fotografias y documentos cargados previamente
  When El usuario hace clic en el boton "Continuar"
  Then El sistema direcciona al usuario a la pantalla "Detalle Valoracion"
  And muestra disponible la informacion actualizada del VIN en los campos "VIN", "Marca", "Linea", "Version", "Ano", "Valor comercial" y "Tipo de vehiculo"
  When El usuario completa la informacion de la valoracion
  And hace clic en el boton "Guardar"
  Then el sistema muestra mensaje: ""
  And se habilita el boton "Finalizar"
  When el usuario hace clic en el boton "Finalizar"
  Then El sistema direcciona al usuario al "Detalle de la valoracion"
  And  el estado del aviso cambia a "Pendiente Ajuste"
  And  se visualiza la informacion de los campos "Placa Tercero", "Placa Asegurado" , "Marca", "Linea", "Version", "Ano", "Valor comercial", "Porcentaje perdida", "Valor de mano de obra", "Valor de repuestos", "Ciudad del taller" y "Taller" de acuerdo a la informacion de la valoracion


  #2 Falta criterio , validar con lorena comportamiento de unidades, también si reparar lleva tipo de golpe o no
  #validar con Lore campo referencia del figma, validar con lore el campo unidades en accion reparar para que no se habilite
  Scenario: Validar carga de repuestos y valor de repuestos

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
  And no se visualiza la tabla de repuestos
  When el usuario ingresa el nombre del <repuesto> a buscar en el buscador de repuestos sea parcial o nombre completo
  Then el sistema muestra la lista de los repuestos con la coincidencia buscada
  When el usuario hace clic sobre el repuesto encontrado en la lista
  Then el sistema carga el repuesto en la tabla de repuestos con la accion "Reparar" por defecto
  And el campo "Unidades" se muestra deshabilitado para modificar la cantidad del repuesto en la accion "Reparar"
  And el campo "Ref" se visualiza habilitado si el <pais> esta configurado para trabajar con referencias, sino no deberia visualizarse este campo
  And el campo precio se visualiza deshabilitado para ingresar el precio en la accion Reparar, muestra por defecto la moneda del <pais> con el  valor "0" con dos decimales separados por (.)
  When el usuario cambia la accion del repuesto de "Reparar" a "Cambiar"
  Then el sistema habilita el campo "Precio" para ser diligenciado
  When el usuario ingresa el precio en el campo "Precio"
  Then el sistema calcula el valor de los repuestos en el campo "Valor repuestos" multiplicando el precio ingresado por la cantidad de unidades del repuesto
  When el usuario modifica la cantidad del repuesto en el campo "Cantidad"
  Then el sistema recalcula el valor de repuestos en el campo "Valor de repuestos"



  Example:
  |repuesto|
  |Irs Motos https://docs.google.com/spreadsheets/d/1epoow7B10pgjJrVfO-wbOlw7TxT4vGdL/edit#gid=1854025519|