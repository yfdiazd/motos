# https://app.clickup.com/t/3138710/INC-1909
  #1
  Scenario: Eliminar repuestos en el proceso de ajuste independientemente si se enviaron o no a compras

  Guardado de la pieza: La posicion de la pieza en la bd debe marcarse como eliminada, no enviada a cotizar, ni enviada a administracion
  Posibles cambios de accion de la pieza: Fila 64-71 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"

  Given que el usuario con <Rol> de la <Aseguradora> se encuentra ajustando la valoracion en estado <estado>
  When el usuario desea eliminar una pieza con <accion>
  Then deberia visualizar una alerta de confirmacion
  And poder elegir si confirma o no la eliminacion

 |rol|
 |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|

  Examples:
  |accion|
  |reparar|
  |remover|
  |cambiar|
  |Tot|

  Examples:
  |estado|Rol|
  |Pendiente ajuste *|
  |Ajustado| *
  |Pendiente Aceptacion|*
  |Actualizar Siniestro|*
  |Pendiente conciliacion|*
  |Pendiente Autorizacion|*
  |Autorizado|*



  #2
  Scenario: Usuario <Rol> no deberia poder ajustar la valoracion sin minimo una pieza cargada en cualquier accion <accion>

  Given que el usuario con <Rol> de la <Aseguradora> se encuentra ajustando la valoracion en estado <estado>
  When elimina todos los repuestos del listado de repuestos
  And  intenta finalizar la valoracion
  Then no deberia poder finalizar el proceso porque debe tener minimo una pieza cargada independiente de la accion <accion> de la pieza

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|
  #3

  Scenario: Buscar pieza no existente en listado de repuestos para avisos en estado <estado> previo a la autorizacion

  Given que el usuario con <Rol> de la <Aseguradora> se encuentra ajustando la valoracion
  And el <estado> del aviso es previo a la "Autorizacion"
  When el usuario busca una pieza en el buscador de repuestos
  Then deberia visualizar las piezas que contienen el valor buscado
  And deberia poder seleccionar la pieza buscada

  Examples:
  |estado|
  |Pendiente ajuste
  |Ajustado|
  |Pendiente Aceptacion|
  |Actualizar Siniestro|
  |Pendiente conciliacion|
  |Pendiente Autorizacion|

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|


  #4
  Scenario: Validar control de duplicidad de piezas

  Given el usuario con <Rol> de la <Aseguradora> se encuentra ajustando la valoracion
  When el usuario busca una pieza en el buscador de repuestos
  And la pieza ya existe en el listado de repuestos
  Then el usuario deberia poder visualizar las piezas que contienen el valor buscado excluyendo  la pieza exactamente buscada

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|
  #5
  Scenario: Agregar pieza en el proceso de ajuste de la valoracion para avisos en estados <estado> previos a la autorizacion

  Guardado de la pieza: La pieza cargada deberia generar una nueva posicion unica en la base de datos

  Given que el usuario con <Rol> de la <Aseguradora> se encuentra ajustando la valoracion para un aviso en estado <estado>
  And desea agregar una pieza al listado de repuestos
  When el usuario busca y selecciona la pieza
  Then el usuario deberia visualizar la pieza en el listado de repuestos, con la accion reparar, agrupada y nivel de danio "L" por defecto
  And no deberia poder modificar precio, cantidad ni referencia

  Example:
  |pieza|
  |Irs Motos https://docs.google.com/spreadsheets/d/1epoow7B10pgjJrVfO-wbOlw7TxT4vGdL/edit#gid=1854025519|

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|

  #6
  Scenario: Validar cambio de accion en piezas de "Reparar" a "Cambiar" pieza existente en listado no enviada a compras
  Guardado de la pieza: la pieza deberia mantener la misma posicion en la base de datos y marcarse como no eliminada, no enviada a cotizar, ni enviada a administracion
  Posibles cambios de accion de la pieza: "TOT"-> "Reparar"->"Cambiar".Filas 47 y 62 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"


  Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
  And existe una pieza con accion "Reparar" en el listado de repuestos no enviada a compras en acciones anteriores
  When el usuario cambia la accion del repuesto de "Reparar" a "Cambiar"
  Then deberia visualizar la agrupacion de la pieza con el estado que tenia asignado
  And no deberia visualizar tipo de golpe
  And deberia poder modificar  el precio, la referencia, la cantidad del repuesto


  Examples:
  |estado|Posicion|
  |pendiente ajuste|
  |Ajustado|Eliminada: False, Envio_cotizar: False, Envio_Administracion: False|
  |Pendiente Aceptacion|Eliminada: False, Envio_cotizar: False, Envio_Administracion: False|
  |Actualizar Siniestro|
  |Pendiente conciliacion|
  |Pendiente Autorizacion|

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|
  #7
  Scenario: Validar cambio de accion en piezas de "Reparar" a "Remover" pieza existente en listado no enviada a compras

  Guardado de la pieza: la pieza deberia mantener la misma posicion en la base de datos  y marcarse como no eliminada, no enviada a cotizar, ni enviada a administracion
  Regla de negocio 1: Para las piezas de remocion el precio es 0.00
  Regla de negocio 2: La agrupacion de la pieza al ser modificada de accion debe permanecer con el estado actual
  Posibles cambios de accion de la pieza: Fila 48 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"

  Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
  And existe una pieza con accion "Reparar" en el listado de repuestos no enviada a compras en acciones anteriores
  When el usuario cambia la accion de la pieza de "Reparar" a "Remover"
  Then deberia poder modificar la agrupacion y la cantidad del repuesto
  And no deberia visualizar tipo de golpe, referencia ni modificar el precio de la pieza
  And deberia guardar los cambios  al finalizar los ajustes

  Examples:
  |estado|
  |Pendiente Aceptacion|
  |Ajustado|

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|

  #8
  Scenario: Validar cambio de accion de piezas en "Reparar a "TOT" pieza existente en listado no enviada a compras

  Guardado de la pieza: la pieza deberia mantener la misma posicion en la base de datos  y marcarse como no eliminada, no enviada a cotizar, ni enviada a administracion
  Posibles cambios de accion de la pieza: "Cambiar"-> "Reparar"->"TOT". Filas 49 y 59 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"
  Regla de negocio 1: Para las piezas TOT el precio es 0.00 hasta que se reciba el precio del proceso de cotizacion y compra


  Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
  And existe una pieza con accion "Reparar" en el listado de repuestos no enviada a compras en acciones anteriores
  When el usuario cambia la accion de la pieza de "Reparar" a "TOT"
  Then el usuario deberia poder modificar la cantidad del repuesto
  And no deberia visualizar el tipo de golpe, referencia, agrupacion, ni modificar el precio
  And deberia guardar los cambios  al finalizar los ajustes

  Examples:
  |estado|
  |Pendiente Aceptacion|
  |Ajustado|

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|

  #9
  Scenario: Validar cambio de accion de piezas en "Cambiar" a "Reparar" pieza existente en listado no enviada a compras

  Guardado de la pieza: la pieza deberia mantener la misma posicion en la base de datos  y marcarse como no eliminada, no enviada a cotizar, ni enviada a administracion
  Regla de negocio 1: Cuando se cambia una pieza de Cambiar a Reparar , si la pieza ya tiene un precio se resetea a 0 y si la cantidad era mayor a 1 se resetea a 1
  Posibles cambios de accion de la pieza: Fila 50 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"

  Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
  And existe una pieza con accion "Cambiar" en el listado de repuestos no enviada a compras
  When el usuario cambia la accion de la pieza de "Cambiar" a "Reparar"
  Then el usuario deberia visualizar nuevamente el tipo de golpe de la pieza con el nivel de danio guardado
  And no deberia modificar el precio  ni la cantidad del repuesto, ni visualizar referencia
  And deberia guardar los cambios  al finalizar los ajustes

  Examples:
  |estado|
  |Pendiente Aceptacion|
  |Ajustado|

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|

  #10-
  Scenario: Validar cambio de accion de piezas en "Cambiar" a "TOT" pieza existente en listado no enviada a compras

  Guardado de la pieza: la pieza deberia mantener la misma posicion en la base de datos  y marcarse como no eliminada, no enviada a cotizar, ni enviada a administracion
  Regla de negocio 1: Para las piezas TOT el precio es 0.00 hasta que se reciba el precio del proceso de cotizacion y compra
  Posibles cambios de accion de la pieza: Fila 51 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"


  Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
  And existe una pieza con accion "Cambiar" en el listado de repuestos no enviada a compras
  When el usuario cambia la accion de la pieza de "Cambiar" a "TOT"
  Then el usuario deberia poder modificar la cantidad del repuesto
  And no deberia visualizar el tipo de golpe, referencia, agrupacion, ni modificar el precio
  And deberia guardar los cambios  al finalizar los ajustes

  Examples:
  |estado|
  |Pendiente Aceptacion|
  |Ajustado|

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|

  #11- Ajustar en figma
  Scenario: Validar cambio de accion en piezas de "Cambiar" a "Remover" pieza existente en listado no enviada a compras

  Regla de negocio 1: Para las piezas de remocion el precio es 0.00
  Regla de negocio 2: La agrupacion de la pieza al ser modificada de accion debe permanecer con el estado actual
  Posibles cambios de accion de la pieza: Fila 52 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"


  Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
  And existe una pieza con accion "Cambiar" en el listado de repuestos no enviada a compras
  When el usuario cambia la accion de la pieza de "Cambiar" a "Remover"
  Then deberia poder modificar la agrupacion y la cantidad del repuesto
  And no deberia visualizar tipo de golpe, referencia ni modificar el precio de la pieza
  And deberia guardar los cambios  al finalizar los ajustes

  Examples:
  |estado|
  |Pendiente Aceptacion|
  |Ajustado|

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|

  #12-

  Scenario: Validar cambio de accion en piezas de "TOT" a "Cambiar" pieza existente en listado no enviada a compras

  Regla de negocio 1: La agrupacion de la pieza al ser modificada de accion debe permanecer con el estado actual
  Posibles cambios de accion de la pieza: Fila 53 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"


  Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
  And existe una pieza con accion "TOT" en el listado de repuestos no enviada a compras
  When el usuario cambia la accion de la pieza de "TOT" a "Cambiar"
  Then deberia poder modificar la cantidad del repuesto, precio, referencia y agrupacion
  And no deberia visualizar el tipo de golpe
  And deberia guardar los cambios  al finalizar los ajustes


  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|
  #13-
  Scenario: Validar cambio de accion en piezas de "TOT" a "Reparar" pieza existente en listado no enviada a compras

  Regla de negocio 1: Cuando se cambia una pieza de TOT a Reparar el precio se resetea a 0 y si la cantidad era mayor a 1 se resetea a 1
  Posibles cambios de accion de la pieza: Fila 54 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"



  Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
  And existe una pieza con accion "TOT" en el listado de repuestos no enviada a compras
  When el usuario cambia la accion de la pieza de "TOT" a "Reparar"
  Then el usuario deberia visualizar nuevamente el tipo de golpe de la pieza con el nivel de danio guardado
  And no deberia modificar el precio  ni la cantidad del repuesto, ni visualizar referencia
  And deberia guardar los cambios  al finalizar los ajustes

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|

  #14-

  Scenario: Validar cambio de accion en piezas de "TOT" a "Remover" pieza existente en listado no enviada a compras

  Regla de negocio 1: Para las piezas de remocion el precio es 0.00
  Regla de negocio 2: La agrupacion de la pieza al ser modificada de accion debe permanecer con el estado actual
  Posibles cambios de accion de la pieza: Fila 55 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"


  Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
  And existe una pieza con accion "TOT" en el listado de repuestos no enviada a compras
  When el usuario cambia la accion de la pieza de "TOT" a "Remover" no enviada a compras
  Then deberia poder modificar la agrupacion y la cantidad del repuesto
  And no deberia visualizar tipo de golpe, referencia ni modificar el precio de la pieza
  And deberia guardar los cambios  al finalizar los ajustes

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|

  #15-
  Scenario: Validar cambio de accion en piezas de "Remover" a "Cambiar" pieza existente en listado no enviada a compras

  Regla de negocio 1: La agrupacion de la pieza al ser modificada de accion debe permanecer con el estado actual
  Posibles cambios de accion de la pieza: "TOT"-> "Remover"->"Cambiar" .Filas 56 y 61 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"

  Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
  And existe una pieza con accion "Remover" en el listado de repuestos no enviada a compras en acciones anteriores
  When el usuario cambia la accion de la pieza de "Remover" a "Cambiar"
  Then deberia poder modificar la cantidad del repuesto, precio, referencia y agrupacion
  And no deberia visualizar el tipo de golpe
  And deberia guardar los cambios  al finalizar los ajustes

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|
  #16-

  Scenario: Validar cambio de accion en piezas de "Remover" a "Reparar" pieza existente en listado no enviada a compras

  Regla de negocio 1: Cuando se cambia una pieza de Remover a Reparar si la cantidad era mayor a 1 se resetea a 1
  Posibles cambios de accion de la pieza: Fila 57 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"


  Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
  And existe una pieza con accion "Remover" en el listado de repuestos no enviada a compras en acciones anteriores
  When el usuario cambia la accion de la pieza de "Remover" a "Reparar"
  Then el usuario deberia visualizar nuevamente el tipo de golpe de la pieza con el nivel de danio guardado
  And no deberia modificar el precio  ni la cantidad del repuesto, ni visualizar referencia
  And deberia guardar los cambios  al finalizar los ajustes

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|

  #17

  Scenario: Validar cambio de accion en piezas de "Remover" a "TOT" pieza existente en listado no enviada a compras

  TOT: Otros trabajos tercerizados de reparacion
  Posibles cambios de accion de la pieza: "Cambiar"-> "Remover"->"TOT". Filas 58 y 60 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"

  Guardado de la pieza: Mantiene la misma posicion


  Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
  And Existe piezas en el listado de repuestos con accion "Remover" no enviada a compras
  When el usuario cambia la accion de la pieza de "Remover" a "TOT"
  Then el usuario deberia poder modificar la cantidad del repuesto,
  And  no deberia poder  realizar las siguientes acciones <Acciones>
  And  deberia guardar los cambios  al finalizar los ajustes

  Examples:
  |Acciones|
  |Agrupar|
  |seleccionar tipo de golpe|
  |modificar referencia|
  |modificar precio|

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|
  #18-
  Scenario: Cargar pieza que ha sido eliminada en cualquier accion <accion> durante el proceso de ajuste enviada o no a compras

  Regla de negocio 1: Cualquier pieza eliminada haya sido o no enviada a compras, si se vuelve a cargar genera nueva posicion
  y la posicion anterior no altera la marcacion de las banderas
  Posibles cambios de accion de la pieza: Filas 79-114 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"


  Given que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
  And ha eliminado previamente una pieza con accion <accion>
  When el usuario agrega la pieza nuevamente al listado de repuestos
  Then el usuario debe visualizar la pieza en el listado de repuestos
  And debe poder modificarla de acuerdo a la accion <accion> que le haya asignado


  Examples:
  |accion|
  |reparar|
  |Cambiar|
  |remover|
  |tot|

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|
  #19-
  Scenario: Pieza de cambio con cotizacion recibida que cambia a reparacion o remocion no debe mostrar informacion de la cotizacion
  Posibles cambios de accion de la pieza: Filas 72-75 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"


  Given  que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
  And desea cambiar a "Reparar" una pieza de cambio que ya tiene asignada una cotizacion
  And desea cambiar a "Remover" otra pieza de cambio que ya tiene asignada una cotizacion
  When el usuario cambia la accion a las piezas
  Then el usuario no deberia visualizar la informacion de la cotizacion de la pieza
  And deberia visualizar la actualizacion en el valor de repuestos y mano de obra

  #20-
  Scenario: Piezas TOT con cotizacion recibida que cambia a reparacion o remocion no debe mostrar informacion de la cotizacion
  Posibles cambios de accion de la pieza: Filas 76 y 77 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"


  Given  que el usuario con <Rol> de la <Aseguradora> se encuentra realizando proceso de ajuste al aviso en estado <estado>
  And desea cambiar a "Reparar" una pieza TOT que ya tiene asignada una cotizacion
  And desea cambiar a "Remover" otra pieza TOT que ya tiene asignada una cotizacion
  When el usuario cambia la accion a las piezas
  Then el usuario no deberia visualizar la informacion de la cotizacion de la pieza
  And deberia visualizar la actualizacion en el valor de repuestos y mano de obra

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|
 #21-
  Scenario: Permitir al usuario con <Rol> enviar a cotizar las piezas de cambio o TOT para los avisos en estado <estado>

  Given que el usuario con rol <Rol> de la <Aseguradora> ingresa a la valoracion de un aviso en estado <estado>
  And desea enviar a cotizar las piezas de cambio y/o TOT
  When el usuario elija las piezas a cotizar
  Then se deberia mostrar al usuario la informacion a enviar y solicitar la confirmacion del envio
  And una vez se confirme el envio se deberia notificar que el envio fue realizado

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|
  #22  Pendiente confirmar comportamiento en sesion****
  Scenario: Notificar al usuario cuando se presenta fallos en la solicitud de cotizacion de piezas

  Given que el usuario con rol <Rol> de la <Aseguradora> desea cotizar piezas de cambio y TOT
  When el usuario envia a cotizar las piezas
  And se presenta fallos en el proceso de envio
  Then se deberia notificar al usuario la causa del fallo del envio
  And permitir enviar las piezas nuevamente una vez se haya solucionado el fallo

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|
  #23
  Scenario: Permitir enviar a cotizar pieza TOT que habia sido enviada como repuesto de cambio

  Regla de negocio 1: Cuando se ha enviado a cotizar un repuesto de cambio y pasa a reparacion o remocion
  y luego se cambia a TOT, se debe crear una nueva posicion para ser enviada a compras
  Posibles cambios de accion de la pieza: Filas 115 - 117 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"

  Given que el usuario con rol <Rol> de la <Aseguradora> desea cambiar la accion <accion> de una pieza a TOT
  And la pieza ya habia sido enviada a compras como repuesto de cambio
  When el usuario cambia la accion de la pieza a "TOT"
  Then el usuario no deberia visualizar informacion de la cotizacion registrada
  And deberia poder enviar a cotizar la TOT como una nueva pieza

  Examples:
  |accion|
  |reparar|
  |remover|
  |cambiar|

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|
  #24
  Scenario: Permitir enviar a cotizar pieza de cambio que habia sido enviada a compras como TOT

  Regla de negocio 1: Cuando se ha enviado a cotizar una TOT y pasa a reparacion o remocion
  y luego se pasa a "Cambiar", se debe crear una nueva posicion para ser enviada a compras
  Posibles cambios de accion de la pieza: Filas 118 y 119 en matriz de posiciones "https://docs.google.com/spreadsheets/d/1J6Ek8xsj5tvhUefBc6Rm6fmlH3-5KhOB/edit#gid=292882700"

  Given que el usuario con rol <Rol> de la <Aseguradora> desea cambiar la accion <accion> de una pieza a "Cambiar"
  And la pieza ya habia sido enviada a compras como TOT
  When el usuario cambia la accion de la pieza a "Cambiar"
  Then el usuario no deberia visualizar informacion de la cotizacion registrada
  And deberia poder enviar a cotizar el repuesto de cambio como una nueva pieza

  Examples:
  |accion|
  |reparar|
  |remover|
  |cambiar|
  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|
  #25-
  Scenario: Recuperar informacion de la cotizacion para repuestos de cambio

  Given que el usuario con rol <Rol> de la <Aseguradora> desea recuperar la informacion de cotizacioin de una pieza de cambio
  And esta pieza no ha sido eliminada previamente
  And se tiene cotizacion registrada para la pieza
  When el usuario modifica la accion <accion> de la pieza a "Cambiar"
  Then el usuario deberia visualizar la <informacion> de la cotizacion
  And deberia visualizar la actualizacion del valor de repuestos y mano de obra en la valoracion

  Examples:
  |accion|
  |remover|
  |reparar|

  |informacion>
  |precio, calidad, dias de entrega, descuento, sucursal|

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|
  #26-
  Scenario: Recuperar informacion de la cotizacion para TOT

  Given que el usuario con rol <Rol> de la <Aseguradora> desea recuperar la informacion de cotizacion de una pieza TOT
  And esta pieza no ha sido eliminada previamente
  And se tiene cotizacion registrada para la pieza
  When el usuario modifica la accion <accion> de la pieza a "TOT"
  Then el usuario deberia visualizar la <informacion> de la cotizacion
  And deberia visualizar la actualizacion del valor de repuestos en la valoracion

  Examples:
  |accion|
  |remover|
  |reparar|

  |informacion>
  |precio, calidad, dias de entrega, descuento, sucursal|

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|
  #27
  Scenario: Permitir al usuario ordenar la informacion del listado de repuestos

  Given que el usuario con rol <Rol> de la <Aseguradora> desea visualizar el listado de repuestos con un criterio de ordenamiento <criterio de ordenamiento>
  When  el usuario selecciona el <criterio de ordenamiento>
  Then deberia visualizar el listado de repuestos de acuerdo al criterio seleccionado

  Examples:
  |criterio de ordenamiento|
  |Nombre de repuesto|
  |Accion|
  |Precio|

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|
  #28 No permitir el ordenamiento hasta el guardado de datos
  Scenario: No permitir al usuario realizar un ordenamiento de repuestos si se ha modificado algun valor en el listado de repuestos
  Given que el usuario con rol <Rol> de la <Aseguradora> ha realizado algun cambio sobre el listado de repuestos
  When el usuario intente ralizar un ordenamiento <criterio de ordenamiento>
  Then el usuario no deberia poder realizar algun ordenamiento del listado de repuestos

  Examples:
  |criterio de ordenamiento|
  |Nombre de repuesto|
  |Accion|
  |Precio|

  #28 Permitir el ordenamiento hasta el guardado de datos
  Scenario: Permitir al usuario realizar un ordenamiento de repuestos en el listado de repuestos
  Given que el usuario con rol <Rol> de la <Aseguradora> ha realizado algun cambio sobre el listado de repuestos
  And el usuario realiza el guardado de cambios
  When el usuario intente ralizar un ordenamiento <criterio de ordenamiento>
  Then el usuario deberia poder realizar el ordenamiento del listado de repuestos

  Examples:
  |criterio de ordenamiento|
  |Nombre de repuesto|
  |Accion|
  |Precio|

  |rol|
  |https://docs.google.com/spreadsheets/d/1Je__26V8IVffdymRRvrEk3dlwC9WGkhX/edit#gid=676454652|