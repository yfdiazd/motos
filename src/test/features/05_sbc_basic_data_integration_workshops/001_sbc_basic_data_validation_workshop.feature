# https://app.clickup.com/t/3138710/INC-1907
#1
 Scenario: Validar informacion de taller y ciudad de taller asociada en la creacion del aviso

 Given Que el aviso en estado "Sin valorar" tiene asociado un "Taller"
 And tiene asociada la "Ciudad del taller"
 When El usuario con <Rol> de la <Aseguradora> ingresa al formulario datos basicos
 Then El sistema muestra el campo "Taller" con el taller asociado al aviso
 And El sistema muestra el campo "Ciudad del taller" con la ciudad del taller al que se encuentra asociado el aviso
 When El usuario completa el formulario de datos básicos
 And hace clic en el boton continuar
 Then El sistema ubica al usuario en la pantalla "Zonas afectadas"
 When El usuario carga las fotografias
 And hace clic en el boton "Continuar"
 Then El sistema ubica al usuario en la pantalla "Detalle Valoracion"
 And muestra el "Taller" y "Ciudad de taller" asociado al aviso
 And no permite realizar edicion de esta informacion

#2
Scenario: Validar cambio de taller asociado al aviso en la misma ciudad desde la edicion del detalle del aviso

 Given Que el aviso en estado "Sin valorar" tiene un cambio de taller desde el detalle del aviso
 And la ciudad del taller es la misma
 When El usuario con <Rol> de la <Aseguradora> ingresa al formulario datos basicos
 Then El sistema muestra el campo "Taller" con el taller asociado al aviso
 And El sistema muestra el campo "Ciudad del taller" con la ciudad del taller al que se encuentra asociado el aviso
 When El usuario completa el formulario de datos básicos
 And hace clic en el boton "Continuar"
 Then El sistema ubica al usuario en la pantalla "Zonas afectadas"
 When El usuario carga los documentos
 And hace clic en el boton "Continuar"
 Then El sistema ubica al usuario en la pantalla "Detalle Valoracion"
 And muestra el "Taller" actualizado y "Ciudad de taller" asociado al aviso
 And no permite realizar edicion de esta informacion

#3
 Scenario: Validar cambio de "Taller" y "Ciudad de Taller" desde la edicion del detalle del aviso

 Given Que el aviso en estado "Sin valorar" tiene un cambio de taller desde el detalle del aviso
 And la ciudad del taller tambien se modifica
 When El usuario con <Rol> de la <Aseguradora> ingresa al formulario datos basicos
 Then El sistema muestra el campo "Taller" con el taller asociado al aviso
 And El sistema muestra el campo "Ciudad del taller" con la ciudad del taller al que se encuentra asociado el aviso
 When El usuario completa el formulario de datos básicos
 And hace clic en el boton "Continuar"
 Then El sistema ubica al usuario en la pantalla "Zonas afectadas"
 When El usuario carga las fotografias
 And hace clic en el boton "Continuar"
 Then El sistema ubica al usuario en la pantalla "Detalle Valoracion"
 And muestra el "Taller" actualizado y "Ciudad de taller" asociado al aviso
 And no permite realizar edicion de esta informacion

#4
 Scenario: Validar cambio de taller en la misma ciudad desde datos basicos

 Regla de negocio: Roles de taller (cotizador de daños taller, asesor de servicio y jefe de taller ) direccionan a la bandeja
 todos los roles de aseguradora direccionan al detalle del aviso.

 Given Que el usuario con <Rol> de la <Aseguradora> ingresa al formulario de datos basicos
 When El usuario despliega la lista en el campo "Taller"
 Then El sistema unicamente muestra los talleres asociados al tipo de vehiculo "Moto" para la ciudad seleccionada
 When El usuario cambia el taller en el campo "Taller"
 And completa el formulario de datos básicos
 And hace clic en el boton "Continuar"
 Then El sistema ubica al usuario en la pantalla "Zonas afectadas"
 When El usuario carga las fotografias
 And hace clic en el boton "Continuar"
 Then El sistema ubica al usuario en la pantalla "Detalle Valoracion"
 And muestra el "Taller" actualizado y "Ciudad de taller" asociado al aviso
 And no permite realizar edicion de esta informacion
 When El usuario completa la informacion de detalle valoracion
 And guarda y finaliza la valoracion
 Then El sistema direcciona al usuario a la pantalla "detalle del aviso"
 And El sistema muestra en el campo "Taller" el taller que ha sido modificado desde datos basicos
 And El sistema muestra en el campo "Ciudad del taller" la ciudad del taller que quedo seleccionada desde datos basicos asociada al taller



#5
 Scenario: Validar cambio de "Ciudad de Taller" y "Taller" desde datos basicos

 Regla de negocio: Roles de taller (cotizador de daños taller, asesor de servicio y jefe de taller ) direccionan a la bandeja
 todos los roles de aseguradora direccionan al detalle del aviso.

 Given Que el usuario con <Rol> de la <Aseguradora> ingresa al formulario de datos basicos
 When El usuario modifica la ciudad del taller en el campo "Ciudad del taller"
 Then El sistema lista en el campo "Taller" unicamente los talleres asociados al tipo de vehiculo "Moto" para la ciudad seleccionada
 When El usuario cambia el taller en el campo "Taller"
 And completa el formulario de datos basicos
 And hace clic en el boton continuar
 Then El sistema ubica al usuario en la pantalla "Zonas afectadas"
 When El usuario carga los documentos y fotografias
 And hace clic en el boton "Continuar"
 Then El sistema ubica al usuario en la pantalla "Detalle Valoracion"
 And muestra el "Taller" actualizado y "Ciudad de taller" asociado al aviso
 And no permite realizar edicion de esta informacion
 When El usuario completa la informacion de detalle valoracion
 And guarda y finaliza la valoracion
 Then El sistema direcciona al usuario a la pantalla "detalle del aviso"
 Then El sistema muestra en el campo "Taller" el taller que ha sido modificado desde datos basicos
 And El sistema muestra en el campo "Ciudad del taller" la ciudad del taller que quedo seleccionada desde datos basicos asociada al taller


#6
 Scenario: Validar informacion de "Ciudad del taller" y "Taller" asociado en la creacion del aviso cuando el taller no corresponde al tipo de vehiculo "Moto"

 Given Que el aviso en estado "Sin valorar" tiene asociado un "Taller" que no pertenece al tipo de vehiculo "Moto"
 And tiene asociada la "Ciudad del taller"
 When El usuario con <Rol> de la <Aseguradora> ingresa al formulario datos basicos
 Then El sistema muestra el campo "Taller" vacío para que el usuario asigne el taller
 And muestra el mensaje: "Seleccione un taller de motos"
 And El sistema muestra el campo "Ciudad del taller" con la ciudad del taller al que se encuentra asociado el aviso
 When el usuario selecciona el taller
 And completa la informacion de datos basicos
 And hace clic en el boton "Continuar"
 Then el sistema avanza a la pantalla de "Zonas afectadas"
 When el usuario avanza a la pantalla "Detalle de valoracion"
 Then el sistema muestra en el campo Taller, el taller asociado desde datos basicos y en el campo "Ciudad del taller" la ciudad asociada al aviso
 When el usuario sale de la pantalla sin guardar
 And accede a la bandeja de avisos
 Then el sistema muestra en la bandeja de avisos de admin y en el detalle del aviso  el taller asociado al aviso desde datos basicos
 And muestra el historico de taller vinculado al aviso  mediante un tooltip tanto en el campo taller de la bandeja de avisos como en el campo taller en detalle del aviso.


