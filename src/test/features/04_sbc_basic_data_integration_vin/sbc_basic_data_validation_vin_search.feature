#1
  Scenario: Validacion VIN digitado 17 caracteres con Coincidencia Exacta en el pais buscado

  Given Que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  When  el usuario digita el numero de VIN en el campo VIN
  Then  El sistema consume el servicio de IA con el "numero de vin", el "pais" y el "tipo de vehiculo"
  And  IA encuentra coincidencia exacta
  Then El sistema muestra la marca asociada al VIN en el campo "Marca"
  And  no puede ser valor vacio
  And  El sistema muestra la linea asociada al VIN en el campo "Linea"
  And  no puede ser valor vacio
  And  El sistema muestra la Version asociada al VIN en el campo "Version"
  And  no puede ser valor vacio
  And  El sistema muestra el Año de vehículo asociado al VIN en el campo "Modelo"
  And  no puede ser valor vacio
  And  El sistema muestra el valor comercial asociado al VIN en el campo "Valor comercial"
  When   El usuario diligencia los demas campos del formulario datos basicos
  And  hace clic en el boton continuar
  Then   El sistema redirecciona a la pantalla de zonas afectadas
  And  Asigna identificador que permita determinar que el vin fue digitado

#2
Scenario: Validacion VIN OCR con Coincidencia Exacta 17 caracteres en pais diferente al buscado

  Given Que el usuario con  <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  When  el usuario carga la tarjeta de propiedad
  Then  El sistema extrae el VIN a traves del OCR
  And   El sistema muestra el numero de VIN en el campo VIN
  Then  El sistema consume el servicio de IA con el "numero de vin", el "pais" y el "tipo de vehiculo"
  And   IA encuentra coincidencia exacta en pais diferente al buscado
  Then El sistema muestra la marca asociada al VIN en el campo "Marca"
  And  no puede ser valor vacio
  And  El sistema muestra la linea asociada al VIN en el campo "Linea"
  And  no puede ser valor vacio
  And  El sistema muestra la Version asociada al VIN en el campo "Version"
  And  no puede ser valor vacio
  And  El sistema muestra el Año de vehículo asociado al VIN en el campo "Modelo"
  And  no puede ser valor vacio
  And  El sistema muestra el valor comercial en cero
  When El usuario completa la informacion de datos basicos
  And  hace clic en el boton "Continuar"
  Then   El sistema valida que el campo "Valor comercial no pueda ser cero"
  And muestra el mensaje: "El valor comercial debe ser mayor a cero"
  When El usuario ingresa valor comercial diferente de cero
  And hace clic en el boton "Continuar"
  Then El sistema redirecciona a la pantalla de "Zonas afectadas"
  And  Asigna identificador que permita determinar que el vin fue reconocido

#3

Scenario: Validacion Reconocimiento Parcial VIN 11 caracteres para el pais buscado

  Given Que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  When  el usuario digita el numero de <VIN> en el campo VIN
  And completa la informacion del VIN con "0" a la derecha hasta completar los 17 caracteres
  Then  El sistema consume el servicio de IA con los parametros "numero de vin", "pais" y "tipo de vehiculo"
  And   IA encuentra coincidencia parcial en el pais buscado
  Then El sistema muestra la marca asociada al VIN en el campo "Marca"
  And  no puede ser valor vacio
  And  El sistema muestra la linea asociada al VIN en el campo "Linea"
  And  no puede ser valor vacio
  And  El sistema muestra la Version asociada al VIN en el campo "Version"
  And  no puede ser valor vacio
  And  El sistema muestra el año "1950"
  And  permite ser modificado
  And  El sistema muestra el valor comercial del vehiculo
  And permite ser modificado
  When   El usuario diligencia los demas campos del formulario datos basicos
  And  hace clic en el boton continuar
  Then   El sistema redirecciona a la pantalla de zonas afectadas
  And  Asigna identificador que permita determinar que el vin fue digitado


Examples:
  |VIN|
  |123456|
  |09876534526|
  |12345678901234567|

#4

  Scenario Validacion Reconocimiento Parcial VIN 6 caracteres para otros paises

  Given Que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  When  el usuario digita el numero de <VIN> en el campo VIN
  And completa la informacion del VIN con "0" hasta completar los 17 caracteres
  Then  El sistema consume el servicio de IA con los parametros "numero de vin", "pais" y "tipo de vehiculo"
  And   IA encuentra coincidencia parcial en otro pais diferente al buscado
  Then El sistema muestra la marca asociada al VIN en el campo "Marca"
  And  no puede ser valor vacio
  And  El sistema muestra la linea asociada al VIN en el campo "Linea"
  And  no puede ser valor vacio
  And  El sistema muestra la Version asociada al VIN en el campo "Version"
  And  no puede ser valor vacio
  And  El sistema muestra el año "1950"
  And  permite ser modificado
  And  El sistema muestra el valor comercial del vehiculo en cero
  And permite ser modificado
  When   El usuario diligencia los demas campos del formulario datos basicos
  And  hace clic en el boton continuar
  Then   El sistema redirecciona a la pantalla de zonas afectadas
  And  Asigna identificador que permita determinar que el vin fue digitado



#5

  Scenario: Validacion VIN No encontrado

  Given Que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  When  el usuario digita el numero de <VIN> en el campo VIN
  Then  El sistema consume el servicio de IA con los parametros "numero de vin", "pais" y "tipo de vehiculo"
  And IA responde que el VIN no fue encontrado
  Then El sistema muestra el listado de marcas disponibles para el tipo de vehiculo
  And  El sistema solo permite seleccionar una marca
  When  El usuario selecciona la marca
  Then El sistema consume el servicio de IA con los parametros "numero de vin", "pais", "tipo de vehiculo" y "marca"
  And  IA entrega el listado de lineas disponibles
  And  El sistema solo permite seleccionar una linea
  When  El usuario selecciona la linea
  Then El sistema consume el servicio de IA con los parametros "numero de vin", "pais","tipo de vehiculo",  "marca" y "linea"
  And  IA entrega el listado de Modelos
  And  El sistema solo permite seleccionar un Modelo
  When  El usuario selecciona el Modelo
  Then El sistema no identifica valor comercial porque el VIN no fue encontrado
  And  El sistema antepone el prefijo de moneda
  And  El sistema permite modificar la informacion del campo "Valor comercial"
  When El usuario ingresa el valor comercial
  And  diligencia los demas campos del formulario datos basicos
  And  hace clic en el boton continuar
  Then   El sistema redirecciona a la pantalla de zonas afectadas
  And  Asigna identificador que permita determinar que el vin fue digitado


  #6  Falta criterio
  Scenario: Validacion VIN menor a 17 digitos

  Given Que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  When  el usuario digita el numero de <VIN> en el campo VIN con valor menor a 17 caracteres
  Then  El sistema  valida el VIN ingresado
  And muestra el mensaje: "Por favor complete 17 caracteres ingresando '0' a la derecha"
  And el sistema no permite listar las Marcas disponibles para seleccionar

