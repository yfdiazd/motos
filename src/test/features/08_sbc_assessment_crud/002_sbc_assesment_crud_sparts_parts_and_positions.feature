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


