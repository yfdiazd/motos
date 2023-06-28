 #1 -

  Scenario: Validar que el usuario de la aseguradora o del taller no pueda editar los <datos del vehiculo> y la <informacion del aviso>

  Given que el usuario con <Rol> de la <Aseguradora> desea conocer los <datos del vehículo> valorado y la <informacion del aviso>
  When el usuario consulta la informacion de la valoracion
  Then el usuario deberia poder visualizar los <datos del vehículo> y la <informacion del aviso>
  And no deberia poder editar estos datos asi se tenga <permisos asociados> de edicion a la valoracion


  Examples:
  |Rol|Aseguradora|datos del vehiculo|informacion del aviso|
  |Superadministrador|Subocol|Marca,Linea,Version,Anio, VIN, Tipo de vehiculo/carroceria|Placa Asegurado|Placa Tercero|Ciudad de ocurrencia|N Aviso|Estado|Logo|N Siniestro|Cobertura|
  |Administrador|Sura Chile|Marca,Linea,Version,Anio, VIN, Tipo de vehiculo/carroceria|Placa Asegurado|Placa Tercero|Ciudad de ocurrencia|N Aviso|Estado|Logo|N Siniestro|Cobertura|
  |Facilitador|Sura|Marca,Linea,Version,Anio, VIN, Tipo de vehiculo/carroceria|Placa Asegurado|Placa Tercero|Ciudad de ocurrencia|N Aviso|Estado|Logo|N Siniestro|Cobertura|
  |Movil|Bolivar|Marca,Linea,Version,Anio, VIN, Tipo de vehiculo/carroceria|Placa Asegurado|Placa Tercero|Ciudad de ocurrencia|N Aviso|Estado|Logo|N Siniestro|Cobertura|
  |Analista aseguradora|Sura Panama|Marca,Linea,Version,Anio, VIN, Tipo de vehiculo/carroceria|Placa Asegurado|Placa Tercero|Ciudad de ocurrencia|N Aviso|Estado|Logo|N Siniestro|Cobertura|
  |cotizador danos taller|Sura chile|Marca,Linea,Version,Anio, VIN, Tipo de vehiculo/carroceria|Placa Asegurado|Placa Tercero|Ciudad de ocurrencia|N Aviso|Estado|Logo|N Siniestro|Cobertura|
  |asesor de servicio taller|Sura panama|Marca,Linea,Version,Anio, VIN, Tipo de vehiculo/carroceria|Placa Asegurado|Placa Tercero|Ciudad de ocurrencia|N Aviso|Estado|Logo|N Siniestro|Cobertura|
  |jefe taller|Sura|Marca,Linea,Version,Anio, VIN, Tipo de vehiculo/carroceria|Placa Asegurado|Placa Tercero|Ciudad de ocurrencia|N Aviso|Estado|Logo|N Siniestro|Cobertura|

 #2 - decir "informacion detallada" suena ambiguo pero como hacer para no detallar todos los campos porque
 #basicamente el pdf deberia mostrar la foto de la pantalla crud
 # esc 2 y 3 aplica para todos los roles de las aseguradoras , se entiende al dejarlo como variable que va cualquier valor para no repetir los examples de roles y aseguradoras?

 Scenario: Descargar PDF Valoracion con estado <estado>

 Given que el usuario con <Rol> de la <Aseguradora> desea descargar el informe de la valoracion
 When el usuario consulta la valoracion del aviso en <estado>
 And descarga la valoracion
 Then el usuario deberia poder obtener un documento PDF con la informacion detallada de la valoracion

 #3 -
 Scenario: Descargar Imagenes Valoracion con estado <estado>

 Given que el usuario con <Rol> de la <Aseguradora> desea descargar las fotos de la valoracion
 When el usuario consulta la valoracion del aviso en <estado>
 And descarga las fotos de la valoracion
 Then el usuario deberia poder obtener una carpeta .zip con las imagenes guardadas de la valoracion

 Examples:
 |estado|Rol|
 |Pendiente ajuste|asesor de servicio taller|
 |Ajustado|jefe de taller|
 |Pendiente Aceptacion|Facilitador|
 |Actualizar Siniestro|Movil|
 |Pendiente Autorizar Pago|ATS|
 |Pago Autorizado|Mesa especializada|
 |Pago programado|Analista aseguradora|
 |Pendiente conciliacion|perito aseguradora|
 |Pendiente Autorizacion|gestor taller|
 |Autorizado|cotizador danos taller|
 |Reparado|Superadministrador|
 |Entregado|Administrador|
 |PTD|Analista aseguradora|
 |Objetado|Analista aseguradora|
 |Asesoria|Analista aseguradora|
 |Desistido|Analista aseguradora|
 |Pagado|Analista aseguradora|
 |Anulado|Analista aseguradora|


 #4 -

 Scenario: Restringir imprevistos por modificacion del valor comercial a rol <Rol> de taller para avisos "Autorizados"

 Given que el usuario con rol <Rol> de taller ingresa a la valoracion de un aviso en estado "Autorizado"
 When el usuario accede a los imprevistos
 Then el usuario no deberia poder modificar el valor comercial del vehiculo como imprevisto

 Examples:
 |Rol|
 |Jefe de taller|Asesor de servicio taller|Cotizador de danios taller|

 #5 -

 Scenario: Permitir cargar como imprevisto la modificacion del valor comercial a rol <Rol> de aseguradora para avisos "Autorizados"

 Given que el usuario con rol <Rol> de aseguradora ingresa a la valoracion de un aviso en estado "Autorizado"
 When el usuario accede a los imprevistos
 Then el usuario deberia poder modificar el valor comercial del vehiculo


 Examples:
 |Rol|
 |Facilitador|Móvil|ATS|Mesa especializada|Analista Aseguradora|Administrador|Superadministrador|Perito aseguradora|Gestor taller|

 #6 -

 Scenario: Modificar valor comercial del vehiculo en los estados <estado> del aviso independiente del rol <Rol>

 Given que el usuario con rol <Rol> de aseguradora desea modificar el valor comercial del vehiculo durante el proceso de ajuste de la valoracion
 When el usuario ingresa a la valoracion del aviso en estado <estado>
 Then el usuario deberia poder modificar el valor comercial del vehiculo

 Examples:
 |estado|
 |Pendiente ajuste|Ajustado|Pendiente Autorizacion|Pendiente conciliacion|Pendiente Aceptacion|Actualizar siniestro|

 #7 -

 Scenario: Validar calculo del porcentaje de perdida del vehiculo cuando se ajusta el valor comercial
 Porcentaje de perdida = valor de la reparacion / valor comercial
 Validacion: el valor comercial y % de perdida se notifican de manera sincrona al modulo de Admin (Detalle del aviso) cuando se finaliza la valoracion

 Given que el usuario con rol <Rol> de aseguradora desea modificar el valor comercial del vehiculo
 When el usuario ingresa a la valoracion
 And modifica el valor comercial
 Then el usuario deberia poder visualizar la actualizacion del porcentaje de perdida del vehiculo en la valoracion


 Examples:
 |Rol|
 |Facilitador|Móvil|ATS|Mesa especializada|Analista Aseguradora|Administrador|Superadministrador|Perito aseguradora|Gestor taller|

 #8
 Scenario: Listar talleres que solo correspondan al tipo de vehiculo "Moto" en el CRUD

 Given que el usuario con <Rol> de la <Aseguradora> con <permisos asociados> se encuentra ajustando la valoracion
 And el aviso se encuentra en estado <estado>
 Then el usuario deberia poder modificar la ciudad del taller y el taller
 And en la lista de talleres debe visualizar unicamente los talleres que se encuentran asociados al tipo de vehiculo "Moto"
 Examples:
 |estado|Rol|
 |pendiente ajuste|Facilitador|
 |ajustado|Móvil|
 |pendiente autorizacion|ATS|
 |Pendiente Conciliación|Mesa especializada|
 |Pendiente Aceptación|Analista Aseguradora|
 |Actualizar Siniestro|Perito aseguradora, Gestor taller|
 |Autorizado|Administrador|



 #9 -
 Scenario: Permitir a los roles <Rol> de aseguradora cambiar el taller en los estados <estado> previos a la autorizacion

 Given que el usuario con <Rol> de la <Aseguradora> con <permisos asociados> requiere ajustar la valoracion
 And el aviso se encuentra en estado <estado>
 When el rol <Rol> se encuentra en el proceso de ajuste
 Then deberia poder realizar la reasignacion de taller asociado al aviso

 Examples:
 |estado|Rol|
 |pendiente ajuste|Facilitador|
 |ajustado|Móvil|
 |pendiente autorizacion|ATS|
 |Pendiente Conciliación|Mesa especializada|
 |Pendiente Aceptación|Analista Aseguradora|
 |Actualizar Siniestro|Perito aseguradora, Gestor taller|


 #10 - por imprevisto es un comportamiento de acceso diferente se vale dejarlo asi o tocaría separarlo?
 Scenario: Restringir a los roles <Rol> de taller el cambio de Ciudad de Taller y/o Taller en cualquier estado <estado> de la valoracion

 Given que el usuario con <Rol> de taller con <permisos asociados> requiere ajustar la valoracion
 And el aviso se encuentra en estado <estado>
 When el rol <Rol> se encuentra en el proceso de ajuste
 Then no deberia poder realizar la reasignacion del Taller en la misma ciudad ni Ciudad diferente

 Examples:
 |Rol|
 |Cotizador de danios taller|
 |Asesor de servicio taller|
 |Jefe de taller|

 Examples:
 |estado|
 |Pendiente ajuste
 |Ajustado|
 |Pendiente Aceptacion|
 |Actualizar Siniestro|
 |Pendiente conciliacion|
 |Pendiente Autorizacion|
 |Autorizado|
 |Pendiente Autorizar Pago|
 |Pago Autorizado|
 |Pago programado|
 |Reparado|
 |Entregado|
 |PTD|
 |Objetado|
 |Asesoria|
 |Desistido|
 |Pagado|
 |Anulado|

 #11-

 Scenario: Recalcular tarifas y mano de obra cuando se realiza un cambio de taller si el taller tiene configurada la marca que se esta valorando
 Validacion: Se notifica el valor de mano de obra al modulo Administracion en el detalle del aviso al finalizar la valoracion

 Given que el usuario con <Rol> de la <Aseguradora> con <permisos asociados> se encuentra ajustando la valoracion
 And desea realizar un cambio de taller
 And el aviso se encuentra en estado <estado>
 When modifica el taller en la misma ciudad o ciudad diferente
 Then el usuario deberia visualizar las tarifas que el taller seleccionado maneja para la marca que se esta valorando
 And el valor de la mano de obra actualizada

 Examples:
 |estado|
 |pendiente ajuste|
 |ajustado|
 |pendiente autorizacion|
 |Pendiente Conciliación|
 |Pendiente Aceptación|
 |Actualizar Siniestro|
 |Autorizado|

 #12
 Scenario: Recalcular tarifas y mano de obra cuando se realiza un cambio de taller y la marca valorada no esta asociada al taller
 Validacion: Se notifica el valor de mano de obra al modulo Administracion en el detalle del aviso al finalizar la valoracion

 Given que el usuario con <Rol> de la <Aseguradora> con <permisos asociados> desea realizar un cambio de taller
 And el taller seleccionado no trabaja con la marca que se esta valorando
 When el usuario modifica el taller en la misma ciudad o ciudad diferente
 Then deberia visualizar la menor tarifa configurada para el taller seleccionado
 And el valor de la mano de obra actualizada


 Examples:
 |estado|
 |pendiente ajuste|
 |ajustado|
 |pendiente autorizacion|
 |Pendiente Conciliación|
 |Pendiente Aceptación|
 |Actualizar Siniestro|
 |Autorizado|

  #13
 Scenario: Imprevisto por modificacion de valor comercial no requiere subir fotografias

 Validacion: Se notifica el valor comercial al modulo Administracion en el detalle del aviso al finalizar la valoracion

 Given que el usuario con rol <Rol> de aseguradora desea modificar el valor comercial del vehiculo como imprevisto de un aviso "Autorizado"
 When el usuario modifica el valor comercial
 And finaliza el proceso de valoracion
 Then no debería requerir subir fotografias como soporte de la modificacion



 #14
 Scenario: Imprevisto por reasignacion de taller en la misma ciudad no requiere subir fotografias

 Validacion: Se notifica el cambio de taller al modulo Administracion en el detalle del aviso al finalizar la valoracion

 Given que el usuario con rol <Rol> de aseguradora desea reasignar la valoracion a otro taller en la misma ciudad
 When el usuario modifica el taller en la misma ciudad
 And finaliza el proceso de valoracion
 Then no debería requerir subir fotografias como soporte de la modificacion


 #15
 Scenario: Imprevisto por modificacion de Ciudad de taller y Taller no requiere fotografias

 Validacion: Se notifica el cambio de taller y ciudad del taller al modulo Administracion en el detalle del aviso al finalizar la valoracion

 Given que el usuario con rol <Rol> de aseguradora desea reasignar la valoracion en otra ciudad diferente
 When el usuario modifica la ciudad del taller y el taller
 And finaliza el proceso de valoracion
 Then no debería requerir subir fotografias como soporte de la modificacion

 #16
 Scenario: Validar alerta de notificacion por cambio de taller cuando el aviso esta en estado "Autorizado"

 Given que el Administrador desea reasignar el caso a otro taller en la misma ciudad
 When el Administrador modifica el taller en la misma ciudad
 Then deberia visualizar una alerta por posible afectacion a los procesos de cotizacion y compra asociados a la valoracion
 And deberia poder elegir si acepta o no la modificacion


 #17
 Scenario: Validar alerta de notificacion por cambio de Ciudad de taller cuando el aviso esta en estado "Autorizado"

 Given que el Administrador desea reasignar el taller en otra ciudad diferente
 When el Administrador modifica la ciudad del taller
 Then deberia visualizar una alerta por posible afectacion a los procesos de cotizacion y compra asociados a la valoracion
 And deberia poder elegir si acepta o no la modificacion

 #18
 Scenario: Restringir imprevistos para cambio de Ciudad de Taller o Taller a roles diferente al "Administrador"

 Given que el usuario con rol <Rol> diferente a "Administrador" ingresa a la valoracion de un aviso en estado "Autorizado"
 When el usuario realiza el proceso de cargue de imprevistos
 Then no deberia poder modificar ni la ciudad del taller ni el taller


 #19
 Scenario: Validar informacion del usuario que realizo la valoracion con fecha y hora

 Given que el usuario con rol <Rol> de la <Aseguradora> ingresa a la valoracion de un aviso en estado <estado>
 And el <estado> es diferente a "Sin valorar"
 Then el usuario deberia poder visualizar el nombre del usuario que valoro el aviso con la fecha y hora en que lo hizo

 Examples:
 |estado|Rol|
 |Pendiente ajuste|asesor de servicio taller|
 |Ajustado|jefe de taller|
 |Pendiente Aceptacion|Facilitador|
 |Actualizar Siniestro|Movil|
 |Pendiente Autorizar Pago|ATS|
 |Pago Autorizado|Mesa especializada|
 |Pago programado|Analista aseguradora|
 |Pendiente conciliacion|perito aseguradora|
 |Pendiente Autorizacion|gestor taller|
 |Autorizado|cotizador danos taller|
 |Reparado|Superadministrador|
 |Entregado|Administrador|
 |PTD|Analista aseguradora|
 |Objetado|Analista aseguradora|
 |Asesoria|Analista aseguradora|
 |Desistido|Analista aseguradora|
 |Pagado|Analista aseguradora|
 |Anulado|Analista aseguradora|

 #20
 Scenario: Validar informacion del usuario que autorizo la valoracion con fecha y hora

 Given que el usuario con rol <Rol> de la <Aseguradora> ingresa a la valoracion de un aviso en estado <estado>
 And el <estado> es diferente a "Sin valorar"
 Then el usuario deberia poder visualizar el nombre del usuario que autorizo la valoracion con la fecha y hora en que lo hizo

 Examples:
 |estado|Rol|
 |Autorizado|cotizador danos taller|
 |Reparado|Superadministrador|
 |Entregado|Administrador|
 |PTD|Analista aseguradora|
 |Objetado|Asesor de servicio taller|
 |Asesoria|Cotizador de danios taller|
 |Desistido|Jefe de taller|
 |Pagado|Perito aseguradora|

