#1
 Scenario: Validacion VIN 17 caracteres con Coincidencia Exacta

 Given Que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
 When el usuario digita el numero de <VIN> en el campo VIN
 Then El sistema muestra los datos del vehiculo pertenecientes al VIN
 And El sistema persiste la informacion de la valoracion
 And identifica si el vin fue digitado o leido por OCR
 |VIN|
 |KMHD741CBHU050542|
 |KMHCT41BAGU901748|
 |MPATFS86JGT002164|
 |MALA741CBKM303212|
 |KMHCT51BAGU240317|
 |KNABX512BET629669|

 #2Sebas
 Scenario: Validacion VIN menor a 17 digitos
 al ingresar el vin menor a 17 caracteres, no se debe hacer llamado al modelo de vin

 Given Que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
 When el usuario digita el numero de <VIN> en el campo VIN
 Then El sistema valida el VIN ingresado
 And muestra el mensaje: "Ingresa 17 caracteres - Completa con ceros a la derecha."
 And no permite listar datos de vehiculos

 Examples:
 |VIN|
 |123456|
 |09876534526|
 |12345678901234567|

 #3

 Scenario: Validacion Reconocimiento Parcial VIN menor a 17 caracteres

 Given Que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
 When el usuario digita el numero de <VIN> en el campo VIN
 And completa la informacion del VIN con "0" a la derecha hasta completar los 17 caracteres
 Then El sistema consume el servicio de IA
 And  IA encuentra coincidencia parcial
 Then El sistema muestra la marca asociada al VIN en el campo "Marca"
 And no puede ser valor vacio
 And El sistema muestra la linea asociada al VIN en el campo "Linea"
 And no puede ser valor vacio
 And El sistema muestra la Version asociada al VIN en el campo "Version"
 And no puede ser valor vacio
 And El sistema muestra el año "1950"
 And permite ser modificado
 And El sistema muestra el valor comercial del vehiculo
 And permite ser modificado
 When  El usuario diligencia los demas campos del formulario datos basicos
 And hace clic en el boton continuar
 Then El sistema persiste la informacion de la valoracion
 And identifica si el vin fue digitado o leido por OCR
 And avanza a la pantalla de "Zonas afectadas"


Examples:
 |VIN|
 |123456|
 |09876534526|
 |12345678901234567|



 #4

 Scenario: Validacion VIN No encontrado

 Given Que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
 When el usuario digita el numero de <VIN> en el campo VIN
 Then El sistema consume el servicio de IA
 And IA responde que el VIN no fue encontrado
 Then El sistema muestra el listado de marcas disponibles para el tipo de vehiculo
 And El sistema solo permite seleccionar una marca
 When El usuario selecciona la marca
 Then El sistema lista las lineas disponibles para la marca
 And  solo permite seleccionar una linea
 When El usuario selecciona la linea
 Then El sistema lista las versiones asociadas a la Marca y Linea
 And solo permite seleccionar una version
 When el usuario selecciona la version
 Then el sistema lista los anios asociados a la Marca, Linea y Version en el campo "Modelo"
 When El usuario selecciona el Modelo
 Then El sistema muestra el valor comercial asociado a la Marca , Linea, Version y Modelo en el campo "Valor comercial"
 And si el valor comercial es = 0
 Then el sistema muestra el mensaje: "El valor debe ser mayor a cero"
 And permite modificar la informacion del campo "Valor comercial"
 When El usuario ingresa el valor comercial
 And diligencia los demas campos del formulario datos basicos
 And hace clic en el boton continuar
 Then El sistema persiste la informacion de la valoracion
 And identifica si el vin fue digitado o leido por OCR
 And avanza a la pantalla de "Zonas afectadas"

 #5 Falta criterio
 Scenario: Validar caracteres especiales en campo VIN

 Given que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
 When el usuario diligencie la informacion del VIN sea digitada o traves de OCR
 Then el sistema valida que el campo VIN no contenga <caracteres especiales>
 And en caso de tener <caracteres especiales>
 Then El sistema muestra el mensaje de error: "Ingresaste caracteres invalidos"


 Examples:
 |caracteres especiales|


 # 6
 Scenario: Realizar validacion de VIN reconocido cuando es modificado

 Given que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
 And se encuentra completada la informacion del vehiculo
 When el usuario modifica el campo el vin
 Then el sistema realiza la validacion nuevamente del vin en IA
 And actualiza la informacion del vehiculo en los campos "Marca", "Linea", "Version", "Modelo" y "Valor Comercial"


 # 7
 Scenario: Realizar validacion cuando se borra la informacion del campo VIN

 Given que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
 And se encuentra completada la informacion del vehiculo
 When el usuario borra el campo el vin
 Then el sistema borra la informacion del vehiculo en los campos "Marca", "Linea", "Version", "Modelo" y "Valor Comercial"

