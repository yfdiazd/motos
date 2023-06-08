  #1 - funcionalidad Agregar repuestos
  Scenario: Validar la opcion para poder agregar piezas en "Detalle de valoracion"

  Given que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla "Detalle valoracion" desde la pantalla "Detalle aviso"
  Then el sistema muestra el campo "Agregar repuestos" el cual permite agregar nuevas piezas
  When el usuario ingresa la pieza a buscar
  Then el sistema lista piezas que contienen el valor ingresado en el campo
  When el usuario selecciona la pieza del listado
  Then el sistema la agrega a la tabla de piezas, con la accion reparar y nivel de danio "L" por defecto
  And el campo de "Precio" con el valor cero acompañado por el tipo de moneda del <pais>


  #2 - funcionalidad Agregar repuestos ya existentes en la tabla#
  Scenario: Validar control de duplicidad de piezas

  Given el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla "Detalle valoracion" desde el boton "Ir"
  And existe piezas en la tabla de repuestos
  When el usuario busca una pieza existente en el buscador de repuestos
  Then el sistema lista las piezas que contienen el valor ingresado en el buscador
  And excluye la <pieza> exactamente buscada

  #3
  Scenario: Validar cambio de repuestos de "Reparar" a "Cambiar"

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
  And no se visualiza la tabla de repuestos
  When el usuario ingresa una pieza
  Then el sistema carga la pieza en la tabla de repuestos con la accion "Reparar" por defecto
  And  muestra el tipo de golpe "L" por defecto
  And  muestra el switch de "Agrupar" encendido por defecto
  And el campo precio se visualiza deshabilitado para ingresar el precio en la accion Reparar
  And el campo precio muestra la moneda por <pais> y el valor "0.00" , no permite editarse
  And el campo "Unidades" se muestra deshabilitado para modificar la cantidad del repuesto en la accion "Reparar"
  And el campo "Ref" se visualiza habilitado si el <pais> esta configurado para trabajar con referencias, sino no deberia visualizarse este campo
  When el usuario cambia la accion del repuesto de "Reparar" a "Cambiar"
  Then el sistema habilita el campo "Precio" para ser diligenciado permaneciendo visible la moneda del <pais>
  And el sistema habilita el campo "Cantidad" para modificar la cantidad de repuesto
  And el sistema mantiene encendido por default el switch "Agrupar"

# 4
  Scenario: Validar cambio de repuestos de "Reparar" a "Remover"
  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"



  # 3 validar comportamiento con Lore que se oculte de las piezas TOT el campo Agrupar
  # que deberia pasar con el campo cantidad de las TOT
  Scenario: Validar cambio de repuestos de "Reparar" a TOT

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
  And existe repuestos cargados en la tabla de repuestos con accion "Reparar"
  When el usuario selecciona una pieza con accion "Reparar"
  And cambia la accion a "TOT"
  Then el sistema oculta el campo "Tipo de golpe"
  And  se mantiene deshabilitado el campo precio
  And se oculta el switch "Agrupar"



  #2 sesion 07-06-2023 Falta criterio  para indicar que no se tiene en cuenta control de cantidades de IA, reparar lleva los 3 tipos de golpe
  #referencia va ir prametrizado por pais, campo unidades en accion reparar se deshabilita
  #validar con lore si cuando ingrese desde el boton ir o valorar y la valoracion ya se encuentre en detalle si va a ir directamente al detalle o si sigue iniciando desde datos basicos
  Scenario: Validar carga de repuestos de accion "Reparar", "Cambiar" y "Valor de Repuestos"

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
  And no se visualiza la tabla de repuestos
  When el usuario ingresa el nombre del <repuesto> a buscar en el buscador de repuestos sea parcial o nombre completo
  Then el sistema muestra la lista de los repuestos con la coincidencia buscada
  When el usuario hace clic sobre el repuesto encontrado en la lista
  Then el sistema carga el repuesto en la tabla de repuestos con la accion "Reparar" por defecto
  And  muestra el tipo de golpe "Leve" por defecto
  And  muestra el check de "Agrupar" encendido por defecto
  And el campo precio se visualiza deshabilitado para ingresar el precio en la accion Reparar
  And el campo precio muestra la moneda por <pais> y el valor "0.00" , no permite editarse
  And el campo "Unidades" se muestra deshabilitado para modificar la cantidad del repuesto en la accion "Reparar"
  And el campo "Ref" se visualiza habilitado si el <pais> esta configurado para trabajar con referencias, sino no deberia visualizarse este campo
  When el usuario cambia la accion del repuesto de "Reparar" a "Cambiar"
  Then el sistema habilita el campo "Precio" para ser diligenciado permaneciendo visible la moneda del <pais>
  And el sistema habilita el campo "Cantidad" para modificar la cantidad de repuesto
  And el sistema mantiene encendido por default el check "Agrupar"
  When el usuario ingresa el precio en el campo "Precio"
  Then el sistema calcula el valor de los repuestos en el campo "Valor repuestos" multiplicando el precio ingresado por la cantidad de unidades del repuesto
  When el usuario modifica la cantidad del repuesto en el campo "Cantidad" para los repuestos con accion "Cambiar
  Then el sistema recalcula el valor de repuestos en el campo "Valor de repuestos"
  When el usuario apaga el check de "Agrupar"
  Then el sistema mantiene en el mismo valor el campo "Valor de Repuestos"
  When el usuario vuelve y pasa el repuesto de accion "Cambiar" a "Reparar"
  Then el sistema muestra nuevamente el precio en cero
  And recalcula el valor de repuestos
  When el usuario hace clic en el boton "Guardar"
  Then el sistema muestra el mensaje: "Los cambios fueron realizados"! y guarda la informacion diligenciada
  And el estado del aviso continua en "Sin Valorar"
  When el usuario sale de la pantalla "Detalle Valoracion"
  And accede nuevamente a la valoracion desde el boton "Ir"
  Then el sistema direcciona a la pantalla "Tipo de vehiculo"
  When el usuario avanza hasta la pantalla "Detalle valoracion" haciendo clic en el boton "Continuar"
  Then el sistema muestra la informacion que el usuario habia diligenciado

Example:
|repuesto|
|Irs Motos https://docs.google.com/spreadsheets/d/1epoow7B10pgjJrVfO-wbOlw7TxT4vGdL/edit#gid=1854025519|

#3 validar con lore porque en pesados en detalle no oculta el campo pero en crud si , cómo deberia funcionar?
  # **********validar con lore si cuando se pasa de remover a reparar y en reparar se habia seleccionado un tipo de golpe deberia cagar ese o el por default
  #pregunta si yo tengo una pieza que estaba apagada con el agrupar y le cambio la accion deberia quedarse apagada o quedar con el agrupar prendido por default?, actualmente lo deja como estaba guardado
# validar con lore si cuando hay una pieza con cantidad > 1 y se pasa a reparar deberia mantener la cantidad . En este momento la resetea a 1.
  Scenario:  Validar carga de repuestos de accion "Reparar" con diferentes tipos de golpe y accion "Remover"

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
  And existe repuestos cargados en la tabla de repuestos con accion "Reparar"
  And el tipo de golpe es "L" por default
  And el switch de "Agrupar" se encuentra encendido
  When el usuario hace clic en el campo "Tipo de golpe"
  Then el sistema despliega las opciones "L", "M", y "F"
  When el usuario cambia el tipo de golpe a "M"
  And  hace clic en el boton "Guardar"
  Then el sistema muestra el mensaje: "Los cambios fueron realizados"
  And guarda el cambio realizado sobre la pieza
  When el usuario selecciona otra pieza con accion "Reparar" y la cambia a accion "Remover"
  Then el sistema oculta el campo "Tipo de golpe"
  And  se mantiene deshabilitado el campo precio
  And se mantiene el switch "Agrupar" con el estado que tenia la pieza
  When el usuario cambia la accion de la pieza de "Remover" a "Reparar"
  Then el sistema habilita nuevamente el tipo de golpe con la opcion previamente registrada
  When el usuario cambia el tipo de golpe a "F"
  And  hace clic en el boton "Guardar"
  Then el sistema muestra el mensaje: "Los cambios fueron realizados"
  And guarda el cambio realizado sobre la pieza
  When el usuario selecciona una pieza de accion "Remover"
  And hace cambio de accion a "Cambiar"
  Then el sistema habilita el campo "Precio"
  When el usuario ingresa el precio en el campo "Precio"
  And hace clic en el boton "Agrupar"
  Then el sistema inactiva la opcion "Agrupar"
  And el sistema recalcula el valor de repuestos en el campo "Valor de repuestos" teniendo en cuenta el nuevo precio ingresado por la cantidad
  When el usuario cambia la accion de la pieza de "Cambiar" a "Remover"
  Then el sistema deshabilita el campo "Precio" con el valor cero por defecto




# 4  Pendiente revisar como va a funcionar el seleccionar todos.********************************************************
  Scenario: Validar eliminacion de repuestos y "Valor de Repuestos"

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
  And ya se encuentra cargados repuestos en la valoracion con accion "Cambiar", "Reparar"
  When el usuario seleccciona un repuesto con valor mayor a cero
  And hace clic en el boton "Eliminar"
  Then el sistema elimina el repuesto de la tabla de repuestos
  And los demas repuestos continuan visualizandose con la informacion previamente asociada a cada item
  And recalcula el valor de repuestos en el campo "Valor de repuestos"
  When el usuario hace clic en el check "Seleccionar todos"
  And en la pagina existe repuestos de cambio con precio mayor a "0"
  And con cantidades iguales o mayores a "1"
  Then el sistema selecciona todos los repuestos de la pagina en la que esta ubicado el usuario
  When el usuario hace clic en el boton "Eliminar"
  Then el sistema elimina todos los repuestos de la pagina seleccionada
  And recalcula el valor de repuestos en el campo "Valor de repuestos"
  When el usuario hace clic en el boton "Guardar"
  Then el sistema guarda la informacion cargada y eliminada
  And el estado del aviso continua en "Sin Valorar"
  When el usuario sale de la pantalla "Detalle Valoracion"
  And accede nuevamente a la pantalla de "Detalle Valoracion" desde el boton "Valorar" en la pantalla "Detalle del aviso"
  Then el sistema muestra la informacion que el usuario habia diligenciado

# 5 aclarar comportamiento de seleccionar todos si es por pagina o toda la tabla
  Scenario: Validar paginador de la tabla de repuestos repuestos

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
  And ya se encuentra cargados repuestos en la valoracion con accion "Cambiar", "Reparar"
  And los repuestos se encuentran distribuidos en diferentes paginas de la tabla de repuestos
  And el sistema muestra por defecto la cantidad de items por pagina en 10
  When el usuario modifica la cantidad de items a paginar
  Then el sistema reorganiza la tabla y distribuye la paginacion de acuerdo a esos items seleccionados
  When el usuario hace clic en el boton "Siguiente" del paginador
  Then el sistema navega a la siguiente pagina de repuestos
  When el usuario hace clic en el boton "Anterior" del paginador
  Then el sistema navega a la pagina inmediatamente anterior
  When el usuario hace clic en el boton "Ultima pagina"
  Then el sistema muestra la ultima pagina de repuestos dentro de la tabla
  When el usuario hace clic en el boton "Primera pagina" desde la "Ultima pagina"
  Then el sistema muestra la primera pagina de repuestos dentro de la tabla
  When el usuario hace clic en el boton "Ultima pagina"
  Then el sistema muestra nuevamente la ultima pagina de repuestos
  When el usuario hace clic al boton "Anterior" desde la ultima pagina
  Then el sistema regresa a la pagina inmediatamente anterior
  When el usuario pulsa sobre el numero de pagina especifica que desea visualizar
  Then el sistema muestra la pagina de repuestos seleccionada
  When el usuario selecciona un repuesto en una pagina intermedia con accion "Reparar"
  And hace clic en el boton "Eliminar"
  Then el sistema elimina el repuesto de la tabla de repuestos
  And los demas repuestos continuan visualizandose con la informacion previamente asociada a cada item
  When el usuario hace clic en el check "Seleccionar todos"
  Then el sistema selecciona todos los repuestos de la pagina en la que esta ubicado el usuario
  When el usuario hace clic en el boton "Eliminar"
  Then el sistema elimina todos los repuestos de la pagina seleccionada
  And recalcula la cantidad de paginas de la tabla
  When el usuario carga repuestos que superan la cantidad de items por pagina
  Then el sistema recalcula nuevamente la cantidad de paginas de la tabla
  When el usuario hace clic en el boton "Guardar"
  Then el sistema guarda la informacion cargada y eliminada
  And el estado del aviso continua en "Sin Valorar"
  When el usuario sale de la pantalla "Detalle Valoracion"
  And accede nuevamente a la pantalla de "Detalle Valoracion" desde el boton "Ir" en la bandeja de avisos"
  Then el sistema carga la informacion de los repuestos distribuida en la paginacion por defecto de 10 items por pagina
  And carga la cantidad de paginas de acuerdo a los items por pagina

#6 cual es el ordenamiento por default? si se agrega repuestos se mantiene que se liste de primero y se reseteria el ordenar por ?
#validar con vic comportamiento en el ordenamiento al agregar pieza
  Scenario: Validar visualizacion de repuestos de acuerdo al tipo de ordenamiento

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
  And ya se encuentra cargados repuestos en la valoracion con accion "Cambiar", "Reparar"
  And el campo "Ordenar por" se encuentra seleccionado por defecto con la opcion "Nombre del repuesto"
  And el listado de repuestos se visualiza ordenado por nombre
  When el usuario selecciona la opcion "Accion" en el campo "Ordenar por"
  Then el sistema ordena los repuestos en la tabla listando primero los de accion "Cambiar"
  And  los de accion "Reparar" se listan posterior a los de cambio
  When el usuario selecciona la opcion "Precio" en el campo "Ordenar por"
  Then el sistema ordena los repuestos en la lista  por precio de menor a mayor independiente del nombre y la accion
  When el usuario carga una nuevo repuesto desde el buscador de repuestos
  Then el sistema muestra el repuesto en primer lugar en la tabla
  And  se mantiene el ordenamiento de los demas repuestos por nombre de repuesto
  When el usuario hace clic en el boton "Guardar"
  Then el sistema guarda la informacion cargada
  And el estado del aviso continua en "Sin Valorar"
  When el usuario sale de la pantalla "Detalle Valoracion"
  And accede nuevamente a la pantalla de "Detalle Valoracion" desde el boton "Ir" en la bandeja de avisos"
  Then el sistema muestra la lista de repuestos ordenada por nombre
  And los repuestos adicionados antes del guardado se muestran ordenados de acuerdo al nombre

# aclarar con lore que como no hay precotizador de pesados entonces no hay valor minimo por defecto , eso se va a tener a futuro
  #para saber si vic mantiene la estructura en la bd o no se tiene en cuenta y a futuro se amplia?

#7 validar con lore y vic porque actualmente no se muestra fecha y hora y usuario y rol y no hay traza historica de eso
  #en el figma se ve un scroll como si se pretendiera mostrar historico y no hay como sacarlo
  Scenario: Validar sincronizacion de version de los hechos con la informacion del aviso

  Given Que el aviso en estado "Sin valorar" tiene asociada la version de los hechos
  When el usuario con <Rol> de la <Aseguradora> ingresa a  la pantalla "Detalle Valoracion"
  Then el sistema muestra en la seccion "Version de los hechos" la version cargada en el aviso
  When el usuario ingresa a la pantalla "Detalle del aviso"
  And edita el aviso para modificar la version de los hechos desde el boton "Editar"
  And hace clic en el boton "Guardar"
  Then el sistema guarda la modificacion
  And se visualiza la informacion actualizada en la misma pantalla de "Detalle del aviso"
  When el usuario  hace clic en el boton "Valorar"
  Then el sistema direcciona a la pantalla "Tipo de vehiculo"
  When el usuario hace clic en el boton "Continuar"
  Then el sistema direcciona a la pantalla "Datos basicos"
  When el usuario hace clic en el boton "Continuar"
  Then el sistema direcciona a la pantalla "Zonas afectadas"
  When el usuario hace clic en el boton "Continuar"
  Then el sistema direcciona a la pantalla "Detalle del aviso"
  And muestra la version de los hechos actualizada de acuerdo a la modificacion realizada en el detalle del aviso

#8 validar con lore que el mensaje deberia ser mas claro porque las 5 notas es durante todaaa la valoracion no solo en sin valorar
  #como esta escrito se entiende como si se pudiera agregar 5 por estado
  Scenario: Validar registro de observaciones

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
  And el aviso no tiene asociada ninguna observacion
  When el usuario hace clic en la seccion "Observaciones"
  Then el sistema muestra mensaje: "Ingresa máximo hasta cinco notas"
  And muestra el boton "Agregar Observacion"
  When el usuario hace clic en el boton "Agregar Observacion"
  Then el sistema muestra el pop up de "Agregar observacion"
  And se muestra el mensaje: "Ingresa hasta cinco notas en la valoración"
  And se muestra la caja de comentarios con el texto "

