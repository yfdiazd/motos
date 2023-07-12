#HU: https://app.clickup.com/t/3138710/INC-1909

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


  #Se mueve escenario 5 a feature 006_sbc_unforeseen_favorable_insurer_crud.feature carpeta 10. Se mueve escenario 4 a feature 007_sbc_unforeseen_favorable_workshop_crud.feature donde queda como escenario 5 en carpeta 10. Se movió los dos escenarios por obedecer a escenarios de imprevistos.




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

 Regla de negocio 1: Se notifica el valor de mano de obra al modulo Administracion en el detalle del aviso al finalizar la valoracion
 Regla de negocio 2: Al cambiar el taller en el campo valor hora MO de la pantalla MO se debe visualizar las nuevas tarifas del taller y se debe recalcular los valores de MO carroceria y mecatronica y por ende el valor total de MO

 Given que el usuario con <Rol> de la <Aseguradora> con <permisos asociados> se encuentra ajustando la valoracion
 And desea realizar un cambio de taller
 And el aviso se encuentra en estado <estado>
 When modifica el taller en la misma ciudad o ciudad diferente
 Then el usuario deberia visualizar las tarifas que el taller seleccionado maneja para la marca que se esta valorando
 And el valor de la mano de obra actualizada, y total valoracion

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
 And el valor de la mano de obra actualizada junto al total de valoracion


 Examples:
 |estado|
 |pendiente ajuste|
 |ajustado|
 |pendiente autorizacion|
 |Pendiente Conciliación|
 |Pendiente Aceptación|
 |Actualizar Siniestro|
 |Autorizado|

# Los escenarios 13, 14 , 15, 16, 17 y 18 se mueven a feature 006_sbc_unforeseen_favorable_insurer_crud.feature como 7,8,9,10,11 respectivamente


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

    #21 No permitir el ordenamiento hasta el guardado de datos
 Scenario: No permitir al usuario realizar un ordenamiento de repuestos si se ha modificado algun valor en el listado de repuestos
 Given que el usuario con rol <Rol> de la <Aseguradora> ha realizado algun cambio sobre el listado de repuestos
 When el usuario intente ralizar un ordenamiento <criterio de ordenamiento>
 Then el usuario no deberia poder realizar algun ordenamiento del listado de repuestos

 Examples:
 |criterio de ordenamiento|
 |Nombre de repuesto|
 |Accion|
 |Precio|

 #22 Permitir el ordenamiento hasta el guardado de datos
 Scenario: Permitir al usuario realizar un ordenamiento de repuestos en el listado de repuestos
 Given que el usuario con rol <Rol> de la <Aseguradora> ha realizado algun cambio sobre el listado de repuestos
 And el usuario finaliza el proceso de CRUD
 And el usuario consulta nuevamente CRUD
 When el usuario intente ralizar un ordenamiento <criterio de ordenamiento>
 Then deberia poder realizar el ordenamiento del listado de repuestos

 Examples:
 |criterio de ordenamiento|
 |Nombre de repuesto|
 |Accion|
 |Precio|

 #23 -
 Scenario: Descargar Documentos Valoracion con estado <estado>

 Given que el usuario con <Rol> de la <Aseguradora> desea descargar los documentos de la valoracion
 When el usuario consulta la valoracion del aviso en <estado>
 And descarga los documentos de la valoracion
 Then el usuario deberia poder obtener una carpeta .zip con los documentos guardadas de la valoracion