#1
Scenario: Eliminar repuestos en el proceso de ajuste independientemente si se enviaron o no a compras

Given que el usuario con <Rol> de la <Aseguradora> se encuentra ajustando la valoracion en estado <estado>
When el usuario selecciona la pieza con <accion> a eliminar y la elimina
Then el sistema solicita confirmacion al usuario: "¿ Estas seguro de que deseas eliminar la informacion ?"
When el usuario confirma la eliminacion
Then el sistema elimina los repuestos seleccionados previamente del listado de repuestos
And guarda los cambios de la eliminacion al finalizar los ajustes sobre la misma posicion <posicion> de la pieza

Examples:
|accion|
|reparar|
|remover|
|cambiar|
|Tot|

Examples:
|estado|
|Pendiente ajuste *
|Ajustado| *
|Pendiente Aceptacion|*
|Actualizar Siniestro|*
|Pendiente conciliacion|*
|Pendiente Autorizacion|*
|Autorizado|*

|Pendiente Aceptacion|Eliminada: True, Envio_cotizar: False, Envio_Administracion: False|
|Ajustado|Eliminada: True, Envio_cotizar: False, Envio_Administracion: False|


#2
Scenario: Sistema no permite finalizar valoracion sin piezas en el listado de repuestos

Given que el usuario con <Rol> de la <Aseguradora> se encuentra ajustando la valoracion en estado <estado>
When elimina todos los repuestos del listado de repuestos
And  intenta finalizar la valoracion
Then el sistema alerta al usuario con el mensaje:"Debes agregar minimo un repuesto para guardar la valoracion"
And no permite avanzar con el proceso

#3

Scenario: Buscar pieza no existente en listado para avisos en estados <estado> previos a la autorizacion

Given que el usuario con <Rol> de la <Aseguradora> se encuentra ajustando la valoracion
And el <estado> del aviso es previo a la "Autorizacion"
When el usuario busca una pieza en el buscador de repuestos
Then el sistema lista las piezas que contienen el valor buscado
And permite seleccionar la pieza buscada

Examples:
|estado|
|Pendiente ajuste *
|Ajustado| *
|Pendiente Aceptacion|*
|Actualizar Siniestro|*
|Pendiente conciliacion|*
|Pendiente Autorizacion|*

#4
Scenario: Validar control de duplicidad de piezas

Given el usuario con <Rol> de la <Aseguradora> se encuentra ajustando la valoracion
When el usuario busca una pieza existente en el buscador de repuestos
Then el sistema lista las piezas que contienen el valor ingresado en el buscador
And excluye la pieza exactamente buscada

#5
Scenario: Agregar pieza en el proceso de ajuste de la valoracion para avisos en estados <estado> previos a la autorizacion

Given que el usuario con <Rol> de la <Aseguradora> se encuentra ajustando la valoracion para un aviso en estado <estado>
And desea agregar una pieza al listado de repuestos
When el usuario busca y selecciona la pieza
Then el sistema agrega la pieza al listado de repuestos, con la accion reparar y nivel de danio "L" por defecto, switch de Agrupacion activo
And no permite ingresar precio ni cantidades, si permite ingresar referencia
And guarda los cambios  al finalizar los ajustes asignando una nueva posicion unica para la pieza

Example:
|pieza|
|Irs Motos https://docs.google.com/spreadsheets/d/1epoow7B10pgjJrVfO-wbOlw7TxT4vGdL/edit#gid=1854025519|

#6
Scenario: Validar cambio de accion en piezas de "Reparar" a "Cambiar" pieza existente en listado no enviada a compras

Precondition: Existe piezas en la tabla de repuestos con accion "Reparar" no enviada a compras en acciones anteriores

Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
When el usuario cambia la accion del repuesto de "Reparar" a "Cambiar"
Then el sistema permite ingresar el precio, modificar las cantidades del repuesto, ingresar la referencia
And  no muestra el tipo de golpe y muestra el switch de agrupacion con el estado guardado en la accion anterior de la pieza
And  guarda los cambios  al finalizar los ajustes, manteniendo la misma posicion <posicion> para la pieza

Examples:
|estado|Posicion|
|pendiente ajuste|
|Ajustado|Eliminada: False, Envio_cotizar: False, Envio_Administracion: False|
|Pendiente Aceptacion|Eliminada: False, Envio_cotizar: False, Envio_Administracion: False|
|Actualizar Siniestro|
|Pendiente conciliacion|
|Pendiente Autorizacion|


#7
Scenario: Validar cambio de accion en piezas de "Reparar" a "Remover" pieza existente en listado no enviada a compras

Precondition: Existe piezas en la tabla de repuestos con accion "Reparar" no enviada a compras en acciones anteriores

Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
When el usuario cambia la accion de la pieza de "Reparar" a "Remover"
Then el sistema no muestra el tipo de golpe, no permite ingresar precio
And permite modificar la referencia, las cantidades y muestra el switch de agrupacion con el estado guardado en la accion anterior de la pieza
And  guarda los cambios  al finalizar los ajustes, manteniendo la misma posicion para la pieza

Examples:
|estado|
|Pendiente Aceptacion|
|Ajustado|

#8
Scenario: Validar cambio de accion de piezas en "Reparar a "TOT" pieza existente en listado no enviada a compras

Precondition: Existe piezas en la tabla de repuestos con accion "Reparar" no enviada a compras en acciones anteriores

Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
When el usuario cambia la accion de la pieza de "Reparar" a "TOT"
Then el sistema permite  modificar las cantidades del repuesto
And  no muestra el tipo de golpe, precio, referencia y el switch de agrupacion
And  guarda los cambios  al finalizar los ajustes, manteniendo la misma posicion para la pieza

Examples:
|estado|
|Pendiente Aceptacion|
|Ajustado|

#9
Scenario: Validar cambio de accion de piezas en "Cambiar" a "Reparar" pieza existente en listado no enviada a compras

Precondition: Existe piezas en la tabla de repuestos con accion "Cambiar" no enviada a compras

Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
When el usuario cambia la accion de la pieza de "Cambiar" a "Reparar"
Then el sistema muestra nuevamente el tipo de golpe con la opcion guardada inicialmente, permite modificar la referencia
And el precio se resetea a 0 y no permite modificarse, las cantidades se resetean a valor 1
And  guarda los cambios  al finalizar los ajustes, manteniendo la misma posicion para la pieza

Examples:
|estado|
|Pendiente Aceptacion|
|Ajustado|

#11-
Scenario: Validar cambio de accion de piezas en "Cambiar" a "TOT" pieza existente en listado no enviada a compras

Precondition: Existe piezas en la tabla de repuestos con accion "Cambiar" no enviada a compras

Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
When el usuario cambia la accion de la pieza de "Cambiar" a "TOT"
Then el sistema permite  modificar las cantidades del repuesto, la referencia
And  oculta el switch de agrupamiento, no muestra tipo de golpe, no permite modificar el precio y lo resetea a 0
And  guarda los cambios  al finalizar los ajustes, manteniendo la misma posicion para la pieza

Examples:
|estado|
|Pendiente Aceptacion|
|Ajustado|

#12- Ajustar en figma
Scenario: Validar cambio de accion en piezas de "Cambiar" a "Remover" pieza existente en listado no enviada a compras

Precondition: Existe piezas en la tabla de repuestos con accion "Cambiar" no enviada a compras

Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
When el usuario cambia la accion de la pieza de "Cambiar" a "Remover"
Then el sistema mantiene visible el switch de agrupamiento con el estado guardado previamente, permite modificar la referencia y las cantidades de repuesto
And  no muestra el tipo de golpe, no permite modificar el precio y lo resetea a 0
And  guarda los cambios  al finalizar los ajustes, manteniendo la misma posicion para la pieza

Examples:
|estado|
|Pendiente Aceptacion|
|Ajustado|


#13-

Scenario: Validar cambio de accion en piezas de "TOT" a "Cambiar" pieza existente en listado no enviada a compras

Precondition: Existe piezas en la tabla de repuestos con accion "TOT" no enviada a compras

Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
When el usuario cambia la accion de la pieza de "TOT" a "Cambiar"
Then el sistema muestra el switch de "Agrupar" con el estado anteriormente guardado, permite modificar cantidad, precio y referencia
And  no muestra el tipo de golpe
And  guarda los cambios  al finalizar los ajustes, manteniendo la misma posicion para la pieza

#14-
Scenario: Validar cambio de accion en piezas de "TOT" a "Reparar" pieza existente en listado no enviada a compras

Precondition: Existe piezas en la tabla de repuestos con accion "TOT" no enviada a compras

Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
When el usuario cambia la accion de la pieza de "TOT" a "Reparar"
Then el sistema muestra el campo tipo de golpe con la opcion guardada previamente,muestra el switch agrupar con el estado guardado previamente,permite modificar la referencia
And no permite modificar precio y lo muestra en 0, no permite modificar cantidad y lo resetea a 1
And  guarda los cambios  al finalizar los ajustes, manteniendo la misma posicion para la pieza

#15-

Scenario: Validar cambio de accion en piezas de "TOT" a "Remover" pieza existente en listado no enviada a compras

Precondition: Existe piezas en la tabla de repuestos con accion "TOT" no enviada a compras

Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
When el usuario cambia la accion de la pieza de "TOT" a "Remover"
Then el sistema muestra el switch de "Agrupar" con el estado previamente guardado, permite modificar la cantidad del repuestos
And no muestra el tipo de golpe, no permite modificar la referencia ni precio y lo muestra en 0


And no se visualiza el campo tipo de golpe
And el campo precio se visualiza deshabilitado para ingresar el precio
And se muestra la moneda por <pais> y el valor "0.00"
And el campo "Cantidades" se muestra habilitado con la cantidad registrada previamente
And permite modificar la cantidad del repuesto
When el usuario hace clic en el boton "Guardar"
Then  muestra el mensaje: "¡Muy bien! Los cambios fueron realizados"
And  guarda los cambios realizados
And  mantiene la misma posicion de la pieza en base de datos

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
Then  muestra el mensaje: "¡Muy bien! Los cambios fueron realizados"
And  guarda los cambios realizados
And  mantiene la misma posicion de la pieza en base de datos

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
Then  muestra el mensaje: "¡Muy bien! Los cambios fueron realizados"
And  guarda los cambios realizados
And  mantiene la misma posicion de la pieza en base de datos

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
Then  muestra el mensaje: "¡Muy bien! Los cambios fueron realizados"
And el sistema guarda los cambios realizados
And  mantiene la misma posicion de la pieza en base de datos
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
When el usuario pulsa sobre el numero de pagina especifica intermedia que desea visualizar
Then el sistema muestra la pagina de repuestos seleccionada

  #9 - Funcionalidad paginador cantidad de paginas cuando se elimina todos los repuestos
      #validar con Lore que sucede si cuando la tabla esta vacía se pulsa el boton guardar

Scenario: Validar cantidad de paginas cuando se elimina todos los repuestos

Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
And la tabla de repuestos tiene varias paginas organizadas en items de 10 por default
When el usuario  selecciona todos los repuestos
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

# aclarar con lore que como no hay precotizador de motos entonces no hay valor minimo por defecto , eso se va a tener a futuro
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

