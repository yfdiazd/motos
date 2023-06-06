#1
  Scenario: Cargar imagen de tarjeta de propiedad para extraer número VIN a traves de OCR

  Given que el usuario con  <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  When el usuario hace clic en el campo para cargar la imagen de la tarjeta de propiedad
  Then el sistema muestra el explorador de archivos de windows para seleccionar el archivo de tipo <Formato>
  When el usuario hace clic en la imagen
  And el usuario hace clic en el boton "Abrir" del explorador de archivos
  Then El sistema procesa la imagen mediante OCR para extraer el numero VIN
  And El sistema muestra el numero vin en el campo "VIN"
  When El usuario diligencia el formulario de datos basicos
  And hace clic en el boton "Continuar"
  Then El sistema ubica al usuario en "Zonas afectadas"
  And muestra la imagen de la tarjeta de propiedad cargada

Examples:
  |Formato|
  |JPG|
  |JPEG|
  |PNG|


#2 Falta criterio
  Scenario: Reconocimiento errado del numero de vin a traves de OCR

  Given que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  When el usuario hace clic en el campo para cargar la imagen de la tarjeta de propiedad
  Then el sistema muestra el explorador de archivos de windows para seleccionar el archivo de tipo <Formato>
  When el usuario hace clic en la imagen
  And el usuario hace clic en el boton "Abrir" del explorador de archivos
  Then El sistema procesa la imagen mediante OCR para extraer el numero VIN
  And El sistema muestra el numero vin en el campo "VIN" con caracteres invalidos
  Then El sistema muestra el mensaje de error: "Ingresaste caracteres invalidos"


#3
  Scenario: Cargar imagen de tarjeta de propiedad inválida para extraer VIN a traves de OCR

  Given que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  When el usuario hace clic en el campo para cargar la imagen de la tarjeta de propiedad
  Then el sistema muestra el explorador de archivos de windows para seleccionar el archivo
  When el usuario hace clic en la imagen que cumple formato pero no es tarjeta de propiedad
  And el usuario hace clic en el boton "Abrir" del explorador de archivos
  Then El sistema muestra el mensaje "No fue posible leer la tarjeta de propiedad, por favor digite el VIN"
  When el usuario diligencia el formulario de datos basicos
  And hace clic en el boton "Continuar"
  Then El sistema ubica el usuario en "Zonas afectadas" y no debe visualizarse la imagen que se intento cargar

# 4 falta criterio

  Scenario: Cargar imagen de tarjeta de propiedad superior a las MB permitidas

  Given que el usuario con  <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  When el usuario hace clic en el campo para cargar la imagen de la tarjeta de propiedad
  Then el sistema muestra el explorador de archivos de windows para seleccionar el archivo
  When el usuario hace clic en la imagen que cumple formato pero excede el <tamano permitido>
  And el usuario hace clic en el boton "Abrir" del explorador de archivos
  Then El sistema muestra el mensaje "El archivo supera el tamaño permitido".

  Examples:
  |tamano permitido|
  |10MB|

# 5
  Scenario: Validar modificacion VIN reconocido por OCR

  Given que el usuario con  <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  When el usuario hace clic en el campo para cargar la imagen de la tarjeta de propiedad
  Then el sistema muestra el explorador de archivos de windows para seleccionar el archivo de tipo <Formato>
  When el usuario hace clic en la imagen
  And el usuario hace clic en el boton "Abrir" del explorador de archivos
  Then El sistema procesa la imagen mediante OCR para extraer el numero VIN
  And El sistema muestra el numero vin en el campo "VIN"
  And El campo "VIN" permite modificarse
  When El usuario modifica la informacion del VIN
  Then El sistema invoca nuevamente al servicio de vin search de IA con la nueva informacion diligenciada
  And El sistema carga la informacion de Marca, Linea, Version , Modelo , Valor comercial si ha sido reconocido el VIN , de lo contrario permite hacer la seleccion de la informacion
  When El usuario completa la informacion del formulario de datos basicos
  And hace clic en el boton "Continuar"
  Then El sistema ubica al usuario en la pantalla "Zonas afectadas"
  And no muestra la tarjeta de propiedad leída ya que fue modificada por vin ingresado

# 6
  Scenario: Validar modificacion VIN ingresado cuando se lee la tarjeta de propiedad por OCR

  Given que el usuario con  <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  When  el usuario digita el numero de VIN en el campo VIN
  Then  El sistema consume el servicio de IA con el "numero de vin", el "pais" y el "tipo de vehiculo"
  And  IA encuentra coincidencia exacta
  Then El sistema muestra la Marca, Linea, Version, Modelo y Valor comercial del vehiculo
  When El usuario carga la tarjeta de propiedad del vehiculo
  Then El sistema reemplaza el VIN extraido por OCR en el campo VIN
  And se consume nuevamente el servicio de IA con el "numero de vin", el "pais" y el "tipo de vehiculo"
  And IA encuentra coincidencia exacta
  Then El sistema carga la informacion del vehiculo Marca, Linea, Version, Modelo y Valor comercial
  When El usuario diligencia el formulario de datos basicos
  And hace clic en el boton "Continuar"
  Then El sistema ubica al usuario en "Zonas afectadas"
  When El usuario avanza a la pantalla de "Detalle Valoracion"
  Then El sistema muestra actualizada la informacion del vehiculo de acuerdo a la informacion diligenciada en datos basicos

