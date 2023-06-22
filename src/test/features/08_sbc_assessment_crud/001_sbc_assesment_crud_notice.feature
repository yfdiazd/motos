 #1 -

    Scenario: Validar que el usuario de la aseguradora o del taller no pueda editar los <datos del vehiculo> y la <informacion del aviso>

    Given que el usuario con <Rol> de la <Aseguradora> desea conocer los <datos del vehículo> valorado y la <informacion del aviso>
    When el usuario consulta la informacion de la valoracion
    Then el sistema muestra en el encabezado los <datos del vehículo> y la <informacion del aviso>
    And  NO permite editarse asi se tenga <permisos asociados> de edicion a la valoracion


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

  #2 - decir "informacion detallada" suena ambiguo pero como hacer para no detallar todo los campos porque
  #basicamente el pdf deberia mostrar la foto de la pantalla crud
  # esc 2 y 3 aplica para todos los roles de las aseguradoras , se entiende al dejarlo como variable que va cualquier valor para no repetir los examples de roles y aseguradoras?

 Scenario: Descargar PDF Valoracion con estado <estado>

 Given que el usuario con <Rol> de la <Aseguradora> desea descargar el informe de la valoracion
 When el usuario consulta la valoracion del aviso en <estado>
 And descarga la valoracion
 Then el sistema genera un documento PDF con la informacion detallada de la valoracion

 #3 -
 Scenario: Descargar Imagenes Valoracion con estado <estado>

 Given que el usuario con <Rol> de la <Aseguradora> desea descargar las fotos de la valoracion
 When el usuario consulta la valoracion del aviso en <estado>
 And descarga las fotos de la valoracion
 Then el sistema genera una carpeta .zip con las imagenes guardadas de la valoracion

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
  Then El sistema valida el estado <estado> del aviso y el rol autenticado
  And no permite modificar el valor comercial del vehiculo como imprevisto

 Examples:
 |Rol|
 |Jefe de taller|Asesor de servicio taller|Cotizador de danios taller|

 #5 -

 Scenario: Permitir cargar como  imprevisto la modificacion del valor comercial a rol <Rol> de aseguradora para avisos "Autorizados"

 Given que el usuario con rol <Rol> de aseguradora ingresa a la valoracion de un aviso en estado "Autorizado"
 When el usuario accede a los imprevistos
 Then El sistema valida el estado <estado> del aviso y el rol autenticado
 And permite modificar el valor comercial del vehiculo como imprevisto


 Examples:
 |Rol|
 |Facilitador|Móvil|ATS|Mesa especializada|Analista Aseguradora|Administrador|Superadministrador|Perito aseguradora|Gestor taller|

  #6 -

 Scenario: Modificar valor comercial del vehiculo en los estados <estado> del aviso independiente del rol <Rol>

 Given que el usuario con rol <Rol> de aseguradora desea modificar el valor comercial del vehiculo durante el proceso de ajuste de la valoracion
 When el usuario ingresa a la valoracion del aviso en estado <estado>
 Then El sistema habilita el campo valor comercial para su modificacion

 Examples:
 |estado|
 |Pendiente ajuste|Ajustado|Pendiente Autorizacion|Pendiente conciliacion|Pendiente Aceptacion|Actualizar siniestro|

 #7 -

 Scenario: Validar calculo del porcentaje de perdida del vehiculo cuando se ajusta el valor comercial

 Given que el usuario con rol <Rol> de aseguradora desea modificar el valor comercial del vehiculo
 When el usuario ingresa a la valoracion
 And modifica el valor comercial
 Then El sistema calcula nuevamente el porcentaje de perdida del vehiculo tomando el valor de la reparacion sobre el valor comercial actualizado
 And guarda los cambios y los notifica al modulo de administracion al finalizar la valoracion

 Examples:
 |Rol|
 |Facilitador|Móvil|ATS|Mesa especializada|Analista Aseguradora|Administrador|Superadministrador|Perito aseguradora|Gestor taller|

  #8
 Scenario: Listar talleres que solo correspondan al tipo de vehiculo "Moto" en el CRUD

 Given que el usuario con <Rol> de la <Aseguradora> con <permisos asociados> se encuentra ajustando la valoracion
 And  el aviso se encuentra en estado <estado>
 Then el sistema habilita la ciudad del taller y el taller para ser modificados
 And lista unicamente los talleres que se encuentran asociados al tipo de vehiculo "Moto"
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

  Given que el usuario con <Rol> de la <Aseguradora> ingresa a la valoracion de un aviso en estado <estado>
  Then el sistema valida el rol autenticado
  And habilita los campos ciudad del taller y el taller para su modificacion

 Examples:
 |estado|Rol|
 |pendiente ajuste|Facilitador|
 |ajustado|Móvil|
 |pendiente autorizacion|ATS|
 |Pendiente Conciliación|Mesa especializada|
 |Pendiente Aceptación|Analista Aseguradora|
 |Actualizar Siniestro|Perito aseguradora, Gestor taller|


 #10 - por imprevisto es un comportamiento de acceso diferente se vale dejarlo asi o tocaría separarlo?
 Scenario: Restringir a los roles <Rol> de taller el cambio de ciudad del taller y/o el taller en cualquier estado <estado> de la valoracion

 Given que el usuario con <Rol> de taller  ingresa a la valoracion de un aviso en estado <estado>
 Then el sistema valida el rol autenticado
 And el estado <estado> del aviso
 And deshabilita para su edicion la ciudad del taller y el taller asociado a la valoracion

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

  Scenario: Recalcular tarifas cuando se realiza un cambio de taller si el taller tiene configurada la marca que se esta valorando

  Given que el usuario con <Rol> de la <Aseguradora> con <permisos asociados> se encuentra ajustando la valoracion
  And desea realizar un cambio de taller
  And  el aviso se encuentra en estado <estado>
  When modifica el taller en la misma ciudad o ciudad diferente
  Then el sistema calcula las tarifas del nuevo taller configuradas para la marca que se esta valorando
  And se muestra al usuario la actualizacion en el valor de Mano de Obra
  And guarda los cambios y los notifica al modulo de Admin al finalizar la valoracion

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
  Scenario: Recalcular tarifas cuando se realiza un cambio de taller y la marca valorada no esta asociada al taller

  Given que el usuario con <Rol> de la <Aseguradora> con <permisos asociados> se encuentra ajustando la valoracion
  And desea realizar un cambio de taller a un taller que no tiene configurada la marca que se esta valorando
  And  el aviso se encuentra en estado <estado>
  When modifica el taller en la misma ciudad o ciudad diferente
  Then el sistema calcula la menor tarifa configurada independiente de la marca
  And se muestra al usuario la actualizacion en el valor de Mano de Obra
  And guarda los cambios y los notifica al modulo de Admin al finalizar la valoracion

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
  Scenario: Imprevisto por modificacion de valor comercial no requiere fotografias

  Given que el usuario con rol <Rol> de aseguradora desea modificar el valor comercial del vehiculo como imprevisto de un aviso "Autorizado"
  When el usuario ingresa a los imprevistos de la valoracion
  And modifica el valor comercial
  And finaliza el proceso de valoracioni
  Then El sistema no debe solicitar fotografias de soporte del cambio de valor comercial
  And guarda los cambios y los notifica al modulo de Admin


  #14
  Scenario: Imprevisto por modificacion de Taller en la misma ciudad no requiere fotografias

  Given que el usuario con rol <Rol> de aseguradora desea reasignar el caso a otro taller en la misma ciudad
  When el usuario ingresa a los imprevistos de la valoracion
  And modifica el taller asociado a la valoracion en la misma ciudad
  And finaliza el proceso de valoracion
  Then El sistema no debe solicitar fotografias de soporte de la reasignacion de taller
  And guarda los cambios y los notifica al modulo de Admin

  #15
  Scenario: Imprevisto por modificacion de Ciudad de taller y Taller no requiere fotografias

  Given que el usuario con rol <Rol> de aseguradora desea reasignar el caso a otro taller en una ciudad diferente
  When el usuario ingresa a los imprevistos de la valoracion
  And modifica la ciudad del taller y el taller
  And finaliza el proceso de valoracioni
  Then El sistema no debe solicitar fotografias de soporte de la reasignacion de taller
  And guarda los cambios y los notifica al modulo de Admin

  #16
  Scenario: Validar alerta de notificacion por cambio de taller cuando el aviso esta en estado "Autorizado"

  Given que el usuario con rol "Administrador" desea reasignar el caso a otro taller en la misma ciudad
  When el usuario ingresa a los imprevistos de la valoracion
  And modifica el taller asociado a la valoracion en la misma ciudad
  Then el sistema alerta al usuario con el mensaje: "Cuidado, si cambias de taller es posible que afectes los procesos de cotización y compra de repuestos, antes de hacerlo valida la información."
  And permite realizar el cambio si el usuario acepta los cambios
  And guarda los cambios y los notifica al modulo de Admin al finalizar la valoracion

 #17
  Scenario: Validar alerta de notificacion por cambio de Ciudad de taller cuando el aviso esta en estado "Autorizado"

  Given que el usuario con rol "Administrador" desea reasignar el caso a otro taller en una ciudad diferente
  When el usuario ingresa a los imprevistos de la valoracion
  And modifica la ciudad del taller
  Then el sistema alerta al usuario con el mensaje: "Cuidado, si cambias la ciudad del taller es posible que afectes los procesos de cotización y compra de repuestos, antes de hacerlo valida la información."
  And permite realizar el cambio si el usuario acepta los cambios
  And guarda los cambios y los notifica al modulo de Admin al finalizar la valoracion

  #18
  Scenario: Restringir imprevistos para cambio de Ciudad de Taller o Taller a roles diferente al "Administrador"

  Given que el usuario con rol diferente a "Administrador" ingresa a la valoracion de un aviso en estado "Autorizado"
  When el usuario accede a los imprevistos
  Then El sistema valida el estado <estado> del aviso y el rol autenticado
  And no permite modificar ni la ciudad del taller ni el taller

  #19
  Scenario: Validar registro del usuario con fecha y hora en que se realizo la valoracion

  Given que el usuario con rol <Rol> de la <Aseguradora> ingresa a la valoracion de un aviso en estado <estado>
  And el <estado> es diferente a "Sin valorar"
  Then el sistema muestra en la informacion del Valorado Por, el nombre del usuario que valoro el aviso con la fecha y hora

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
  Scenario: Validar registro del usuario con fecha y hora en que se autorizó  la valoracion

  Given que el usuario con rol <Rol> de la <Aseguradora> ingresa a la valoracion de un aviso en estado <estado>
  And el <estado> es igual o posterior a la Autorizacion
  Then el sistema muestra en la informacion del Autorizado Por, el nombre del usuario que autorizo la reparacion con la fecha y hora

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

