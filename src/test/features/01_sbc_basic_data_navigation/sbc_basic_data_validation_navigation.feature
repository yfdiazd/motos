#1
  Scenario: Redireccionamiento a la pantalla "Tipo de vehiculo" al hacer clic en el boton "Volver"

  Given Que el usuario con <Rol> de la <Aseguradora> ingresa en la pantalla de datos basicos
  When el usuario da clic en el boton "Volver"
  Then El sistema debe redireccionar al usuario a la pantalla "Tipo de vehiculo"
  And el usuario no puede seleccionar otro tipo de vehiculo diferente

  Examples:
  |Rol|
  |Superadministrador|
  |Administrador|
  |Facilitador|
  |Movil|
  |ATS|
  |Mesa especializada|
  |Analista aseguradora|
  |perito aseguradora|
  |gestor taller|
  |cotizador danos taller|
  |asesor de servicio taller|
  |jefe taller|

  Examples:
  |Aseguradora|
  |Sura|
  |Bolivar|
  |Sura Panama|
  |Sura Chile|

#2
  Scenario: Boton continuar guarda la informacion de datos basicos

  Given Que el usuario con <Rol> de la <Aseguradora>  ingresa a la pantalla de datos basicos
  When El usuario diligencia el formulario de datos básicos
  And El usuario da clic en el botón "Continuar"
  Then El sistema redirecciona a la pantalla de "Zonas afectadas"
  When El usuario da clic en el boton "Volver"
  Then El sistema regresa a la pantalla de datos basicos mostrando toda la información diligenciada

#3 Falta criterio
  Scenario: Boton "Continuar" en la pantalla de datos basicos solo debe permitirse accionar una unica vez

  Given Que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  When El usuario diligencia el formulario de datos basicos
  And Hace clic en el boton "Continuar"
  Then El sistema debe bloquear el boton
  And no permitir que se accione, incluso si el usuario esta en otra pestaña o navegador

# 4 Falta criterio cambio nuevo
  Scenario: Validación de campos obligatorios en el formulario datos basicos

  Given Que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  And no diligencia ningun campo
  When El usuario hace clic en el boton "Continuar"
  Then El sistema no recibe ninguna accion porque el boton esta deshabilitado
  And  El sistema muestra el label "Este campo es requerido" para los campos obligatorios
  And  El sistema muestra el label "Ingresa mínimo 3 caracteres" , "El valor debe ser mayor a cero" en el campo "Valor comercial"

#5 Falta criterio
  Scenario: Validacion <Tipos de carroceria> por <Aseguradora>

  Given Que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  When se consulta la lista de tipos de carrocería asociados a la <Aseguradora>
  Then el sistema muestra los <Tipos de carroceria> activos que pertenecen a la <Aseguradora>
  And no muestra tipos de carrocería inactivos o no asociados a la <Aseguradora>


  Examples:
  |Tipos de carroceria|
  |Scooter|
  |Mega scooter|
  |Naked|
  |Trail|
  |Deportiva 125 cc|
  |Gran turismo|
  |Clasica 125 cc|
  |Electrica|
  |Custom|
  |Triciclo / Cuatriciclo|
  |Moto carro|
