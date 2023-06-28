  #2 sesion 07-06-2023 Falta criterio para indicar que no se tiene en cuenta control de cantidades de IA, reparar lleva los 3 tipos de golpe
 #referencia va ir prametrizado por pais, campo unidades en accion reparar se deshabilita

 #falta ajustar en criterios
 #13-06-2023 cuando se pulse boton ir desde bandeja o valorar desde detalle va a ir directamente a detalle del aviso y permite regresarse, esto si el usuario ya se encontraba en detalle del aviso
 #13-06-2023# cuando se cambie de reparar a cualquier otra accion se debe ocultar el campo tipo de golpe,
 #13-06-2023 cuando se ha cambiado el tipo de golpe y no se ha guardado, se cambia a otra accion y luego vuelve a reparar debe volver a cargar el valor guardado en bd
 #13-06-2023#pregunta si yo tengo una pieza que estaba apagada con el agrupar y le cambio la accion deberia quedarse apagada o quedar con el agrupar prendido por default?, actualmente lo deja como estaba guardado. Rta se mantiene como esta
#13-06-2023 validar con lore si cuando hay una pieza con cantidad > 1 y se pasa a reparar deberia mantener la cantidad . En este momento la resetea a 1. Se mantiene como esta
#13-06-2023 sino se ha pulsado guardar no debe registrarse cambios.
#13-06-2023 seleccionar todos deberia comportarse igual a livianos y pesados, elimina toda la tabla


 #1 - funcionalidad Agregar repuestos
 Scenario: Validar la opcion para poder agregar piezas en "Detalle de valoracion"

 Given que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla "Detalle valoracion" desde la pantalla "Detalle aviso"
 Then el sistema muestra el campo "Agregar repuestos" el cual permite agregar nuevas piezas
 When el usuario ingresa la <pieza> a buscar
 Then el sistema lista piezas que contienen el valor ingresado en el campo
 When el usuario selecciona la pieza del listado
 Then el sistema agrega la pieza al listado de repuestos, con la accion reparar y nivel de danio "L" por defecto
 And el campo de "Precio" con el valor cero acompañado por el tipo de moneda del <pais>

 Example:
 |pieza|
 |Irs Motos https://docs.google.com/spreadsheets/d/1epoow7B10pgjJrVfO-wbOlw7TxT4vGdL/edit#gid=1854025519|

 #2 - funcionalidad Agregar repuestos ya existentes en la tabla# falta criterio
 Scenario: Validar control de duplicidad de piezas

 Given el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla "Detalle valoracion" desde el boton "Ir"
 And existe piezas en la tabla de repuestos
 When el usuario busca una pieza existente en el buscador de repuestos
 Then el sistema lista las piezas que contienen el valor ingresado en el buscador
 And excluye la <pieza> exactamente buscada

 #3 -Funcionalidad cambio de accion "Reparar" a "Cambiar"
 Scenario: Validar cambio de accion en piezas de "Reparar" a "Cambiar"

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
 And no se visualiza la tabla de repuestos
 When el usuario ingresa una pieza
 Then el sistema carga la pieza en la tabla de repuestos con la accion "Reparar" por defecto
 And muestra el tipo de golpe "L" por defecto
 And muestra el switch de "Agrupar" encendido por defecto
 And el campo precio se visualiza habilitado para ingresar informacion
 And muestra la moneda por <pais> y el valor "0.00"
 And el campo "Cantidades" se muestra habilitado para modificar la cantidad del repuesto
 And el campo "Ref" se visualiza habilitado si el <pais> esta configurado para trabajar con referencias, sino no deberia visualizarse este campo
 When el usuario cambia la accion del repuesto de "Reparar" a "Cambiar"
 Then el sistema habilita el campo "Precio" para ser diligenciado permaneciendo visible la moneda del <pais>
 And el sistema habilita el campo "Cantidad" para modificar la cantidad de repuesto
 And el sistema mantiene encendido por default el switch "Agrupar"
 When el usuario hace clic en el boton "Guardar"
 Then muestra el mensaje: "¡Muy bien! Los cambios fueron realizados"
 And guarda los cambios realizados
 And mantiene la misma posicion de la pieza en base de datos

 #4 -Funcionalidad cambio de accion "Reparar" a "Remover". Pdte criterio
 Scenario: Validar cambio de accion en piezas de "Reparar" a "Remover"

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
 And existe piezas en la tabla de repuestos con accion "Reparar"
 When el usuario cambia la accion de la pieza de "Reparar" a "Remover"
 Then el sistema oculta el campo tipo de golpe
 And muestra el switch de "Agrupar" con el estado previamente seleccionado
 And el campo precio se visualiza deshabilitado para ingresar el precio
 And el campo precio muestra la moneda por <pais> y el valor "0.00"
 And el campo "Cantidades" se muestra habilitado para modificar la cantidad del repuesto
 When el usuario hace clic en el boton "Guardar"
 Then muestra el mensaje: "¡Muy bien! Los cambios fueron realizados"
 And guarda los cambios realizados
 And mantiene la misma posicion de la pieza en base de datos


 # 5-Funcionalidad cambio de accion "Reparar a TOT". Falta criterio

 Scenario: Validar cambio de accion de piezas en "Reparar a "TOT"

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
 And existe piezas en la tabla de repuestos con accion "Reparar"
 When el usuario cambia la accion de la pieza de "Reparar" a "TOT"
 Then el sistema oculta el campo tipo de golpe
 And se oculta el switch "Agrupar"
 And el campo precio se visualiza deshabilitado para ingresar el precio
 And el campo "Cantidades" se muestra habilitado para modificar la cantidad del repuesto
 When el usuario modifica el campo Cantidad
 And hace clic en el boton "Guardar"
 Then muestra el mensaje: "¡Muy bien! Los cambios fueron realizados"
 And guarda los cambios realizados
 And mantiene la misma posicion de la pieza en base de datos

 #6-Funcionalidad cambio de accion "Cambiar a "Reparar". Pdte criterio
 Scenario: Validar cambio de accion de piezas en "Cambiar" a "Reparar"

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
 And existe piezas en la tabla de repuestos con accion "Cambiar"
 When el usuario cambia la accion de la pieza de "Cambiar" a "Reparar"
 Then el sistema habilita el campo "Cantidades" y lo resetea a 1
 And muestra el campo tipo de golpe con la opcion guardada inicialmente
 And se deshabilita el campo precio con el valor cero acompañado por el tipo de moneda del <pais>
 When el usuario hace clic en el boton "Guardar"
 Then muestra el mensaje: "¡Muy bien! Los cambios fueron realizados"
 And guarda los cambios realizados
 And mantiene la misma posicion de la pieza en base de datos


 #7-Funcionalidad cambio de accion "Cambiar a "TOT" . Pdte criterio
 Scenario: Validar cambio de accion de piezas en "Cambiar" a "TOT"

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
 And existe piezas en la tabla de repuestos con accion "Cambiar"
 When el usuario cambia la accion de la pieza de "Cambiar" a "TOT"
 Then el sistema oculta el campo tipo de golpe
 And se oculta el switch "Agrupar"
 And el campo precio se reseta a 0 y se visualiza deshabilitado para ingresar el precio
 And el campo "Cantidades" se muestra habilitado para modificar la cantidad del repuesto
 When el usuario hace clic en el boton "Guardar"
 Then muestra el mensaje: "¡Muy bien! Los cambios fueron realizados"
 And guarda los cambios realizados
 And mantiene la misma posicion de la pieza en base de datos

 #8-Funcionalidad cambio de accion "Cambiar a "Remover" . Pdte criterio
 Scenario: Validar cambio de accion en piezas de "Cambiar" a "Remover"

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
 And existe piezas en la tabla de repuestos con accion "Cambiar"
 When el usuario cambia la accion de la pieza de "Cambiar" a "Remover"
 Then el sistema oculta el campo tipo de golpe
 And muestra el switch de "Agrupar" con el estado previamente seleccionado
 And el campo precio se visualiza deshabilitado para ingresar el precio
 And se muestra la moneda por <pais> y el valor "0.00"
 And el campo "Cantidades" se muestra habilitado para modificar la cantidad del repuesto
 When el usuario hace clic en el boton "Guardar"
 Then muestra el mensaje: "¡Muy bien! Los cambios fueron realizados"
 And guarda los cambios realizados
 And mantiene la misma posicion de la pieza en base de datos

 #9-Funcionalidad cambio de accion "TOT a "Cambiar" . Pdte criterio

 Scenario: Validar cambio de accion en piezas de "TOT" a "Cambiar"

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
 And existe piezas en la tabla de repuestos con accion "TOT"
 When el usuario cambia la accion de la pieza de "TOT" a "Cambiar"
 Then el sistema muestra el switch de "Agrupar" con el estado previamente seleccionado
 And no se visualiza el campo tipo de golpe
 And el campo precio se visualiza habilitado para ingresar el precio
 And se muestra la moneda por <pais> y el valor "0.00"
 And el campo "Cantidades" se muestra habilitado con la cantidad registrada previamente
 And permite modificar la cantidad del repuesto
 When el usuario hace clic en el boton "Guardar"
 Then muestra el mensaje: "¡Muy bien! Los cambios fueron realizados"
 And guarda los cambios realizados
 And mantiene la misma posicion de la pieza en base de datos


 #10-Funcionalidad cambio de accion "TOT a "Reparar" . Pdte criterio

 Scenario: Validar cambio de accion en piezas de "TOT" a "Reparar"

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
 And existe piezas en la tabla de repuestos con accion "TOT"
 When el usuario cambia la accion de la pieza de "TOT" a "Reparar"
 Then el sistema muestra el campo tipo de golpe con la opcion guardada previamente
 And el sistema muestra el switch de "Agrupar" con el estado previamente seleccionado
 And el campo precio se visualiza deshabilitado para editar
 And se muestra la moneda por <pais> y el valor "0.00"
 And el campo "Cantidades" se muestra deshabilitado para modificar la cantidad del repuesto y se resetea a 1
 When el usuario hace clic en el boton "Guardar"
 Then muestra el mensaje: "¡Muy bien! Los cambios fueron realizados"
 And guarda los cambios realizados
 And mantiene la misma posicion de la pieza en base de datos

 #11-Funcionalidad cambio de accion "TOT a "Remover" . Pdte criterio

 Scenario: Validar cambio de accion en piezas de "TOT" a "Remover"

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
 And existe piezas en la tabla de repuestos con accion "TOT"
 When el usuario cambia la accion de la pieza de "TOT" a "Remover"
 Then el sistema muestra el switch de "Agrupar" con el estado previamente seleccionado
 And no se visualiza el campo tipo de golpe
 And el campo precio se visualiza deshabilitado para ingresar el precio
 And se muestra la moneda por <pais> y el valor "0.00"
 And el campo "Cantidades" se muestra habilitado con la cantidad registrada previamente
 And permite modificar la cantidad del repuesto
 When el usuario hace clic en el boton "Guardar"
 Then muestra el mensaje: "¡Muy bien! Los cambios fueron realizados"
 And guarda los cambios realizados
 And mantiene la misma posicion de la pieza en base de datos

 #12-Funcionalidad cambio de accion "Remover a "Reparar" . Pdte criterio

 Scenario: Validar cambio de accion en piezas de "Remover" a "Reparar"

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
 And existe piezas en la tabla de repuestos con accion "Remover"
 When el usuario cambia la accion de la pieza de "Remover" a "Reparar"
 Then el sistema muestra el campo tipo de golpe con la opcion guardada previamente
 And el sistema muestra el switch de "Agrupar" con el estado previamente seleccionado
 And el campo precio se visualiza deshabilitado para editar
 And se muestra la moneda por <pais> y el valor "0.00"
 And el campo "Cantidades" se muestra deshabilitado para modificar la cantidad del repuesto y se resetea a 1
 When el usuario hace clic en el boton "Guardar"
 Then muestra el mensaje: "¡Muy bien! Los cambios fueron realizados"
 And guarda los cambios realizados
 And mantiene la misma posicion de la pieza en base de datos

 #13-Funcionalidad cambio de accion "Remover a "TOT" . Pdte criterio

  Scenario: Validar cambio de accion en piezas de "Remover" a "TOT"

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
  And existe piezas en la tabla de repuestos con accion "Remover"
  When el usuario cambia la accion de la pieza de "Remover" a "TOT"
  Then el sistema no muestra el switch de "Agrupar"
  And no se visualiza el campo tipo de golpe
  And el campo precio se visualiza deshabilitado para ingresar el precio
  And se muestra la moneda por <pais> y el valor "0.00"
  And el campo "Cantidades" se muestra habilitado con la cantidad registrada previamente
  And permite modificar la cantidad del repuesto
  When el usuario hace clic en el boton "Guardar"
  Then muestra el mensaje: "¡Muy bien! Los cambios fueron realizados"
  And guarda los cambios realizados
  And mantiene la misma posicion de la pieza en base de datos

 # - Funcionalidad eliminar piezas . Pdte criterio
 Scenario: Validar eliminacion de pieza para cada <Accion>

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
 And existe piezas en la tabla de repuestos con accion <Accion>
 When el usuario selecciona la pieza
 And hace clic en el boton "Eliminar"
 Then el sistema muestra el pop up con el mensaje: "¿ Estás seguro de que deseas eliminar la información ?"
 And los botones "Cancelar" y "Eliminar"
 When el usuario hace clic en el boton "Cancelar"
 Then el sistema cierra el pop up y deja al usuario en la pantalla de "Detalle Valoracion"
 And la pieza queda seleccionada
 When el usuario hace clic nuevamente en el boton "Eliminar"
 Then el siste muestra el pop up con el mensaje: "¿ Estás seguro de que deseas eliminar la información ?"
 When el usuario hace clic en el boton "Ok"
 Then el sistema quita la pieza de la tabla de repuestos
 And los cambios solo se guardan cuando el usuario pulsa el boton "Guardar" de lo contrario no debe guardarse los cambios
 When el usuario hace clic en el boton "Guardar"
 Then muestra el mensaje: "¡Muy bien! Los cambios fueron realizados"
 And el sistema guarda los cambios realizados
 And mantiene la misma posicion de la pieza en base de datos
 And la pieza queda marcada con eliminar en "True"


 Example:
 |Accion|
 |Cambiar|
 |Reparar|
 |TOT|
 |Remover|




 #7-Funcionalidad paginador valida items por pagina
 Scenario: Validar cantidad de items por pagina en la tabla de repuestos

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
 And ya se encuentra cargados repuestos en la valoracion con accion <Accion>
 And los repuestos se encuentran distribuidos en diferentes paginas de la tabla de repuestos
 And el sistema muestra por defecto la cantidad de items por pagina en 10
 When el usuario modifica la cantidad de items a paginar
 Then el sistema reorganiza la tabla y distribuye la paginacion de acuerdo a esos items seleccionados

 #8-Funcionalidad paginador botones siguiente y atras
 Scenario: Validar paginador botones "Siguiente" y "Anterior" en la tabla de repuestos

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
 And la tabla de repuestos tiene varias paginas organizadas en items de 10 por default
 When el usuario hace clic en el boton "Siguiente" del paginador
 Then el sistema navega a la siguiente pagina de repuestos
 When el usuario hace clic en el boton "Anterior" del paginador
 Then el sistema navega a la pagina inmediatamente anterior

 #8-Funcionalidad paginador botones primera pagina y ultima pagina
 Scenario: Validar paginador botones "Primera pagina" y "Ultima pagina" en la tabla de repuestos

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
 And la tabla de repuestos tiene varias paginas organizadas en items de 10 por default
 When el usuario hace clic en el boton "Ultima pagina"
 Then el sistema muestra la ultima pagina de repuestos dentro de la tabla
 When el usuario hace clic en el boton "Primera pagina" desde la "Ultima pagina"
 Then el sistema muestra la primera pagina de repuestos dentro de la tabla


 #9 - Funcionalidad paginador cantidad de paginas cuando se elimina todos los repuestos
 #validar con Lore que sucede si cuando la tabla esta vacía se pulsa el boton guardar

 Scenario: Validar cantidad de paginas cuando se elimina todos los repuestos

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
 And la tabla de repuestos tiene varias paginas organizadas en items de 10 por default
 When el usuario selecciona todos los repuestos
 And hace clic en el boton "Eliminar"
 Then el sistema muestra la tabla de repuestos vacia
 And la cantidad de paginas del paginador es 1




#6 cual es el ordenamiento por default? si se agrega repuestos se mantiene que se liste de primero y se reseteria el ordenar por ?
#validar con vic comportamiento en el ordenamiento al agregar pieza
 Scenario: Validar visualizacion de repuestos de acuerdo al tipo de ordenamiento

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
 And ya se encuentra cargados repuestos en la valoracion con accion "Cambiar", "Reparar"
 And el campo "Ordenar por" se encuentra seleccionado por defecto con la opcion "Nombre del repuesto"
 And el listado de repuestos se visualiza ordenado por nombre
 When el usuario selecciona la opcion "Accion" en el campo "Ordenar por"
 Then el sistema ordena los repuestos en la tabla listando primero los de accion "Cambiar"
 And los de accion "Reparar" se listan posterior a los de cambio
 When el usuario selecciona la opcion "Precio" en el campo "Ordenar por"
 Then el sistema ordena los repuestos en la lista por precio de mayor a menor independiente del nombre y la accion
 When el usuario carga una nuevo repuesto desde el buscador de repuestos
 Then el sistema muestra el repuesto en primer lugar en la tabla
 And se mantiene el ordenamiento de los demas repuestos por nombre de repuesto
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
 When el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla "Detalle Valoracion"
 Then el sistema muestra en la seccion "Version de los hechos" la version cargada en el aviso
 When el usuario ingresa a la pantalla "Detalle del aviso"
 And edita el aviso para modificar la version de los hechos desde el boton "Editar"
 And hace clic en el boton "Guardar"
 Then el sistema guarda la modificacion
 And se visualiza la informacion actualizada en la misma pantalla de "Detalle del aviso"
 When el usuario hace clic en el boton "Valorar"
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


