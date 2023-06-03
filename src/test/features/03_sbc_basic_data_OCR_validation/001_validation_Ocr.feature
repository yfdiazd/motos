#1

  Scenario: Cargar imagen de tarjeta de propiedad para extraer número VIN a traves de OCR

  Given que el usuario con  <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  When el usuario hace clic en el campo para cargar la imagen de la tarjeta de propiedad
  Then el sistema muestra el explorador de archivos de windows para seleccionar el archivo de tipo <Formato>
  When el usuario hace clic en la imagen
  And el usuario hace clic en el boton "Abrir" del explorador de archivos
  Then El sistema procesa la imagen mediante OCR para extraer el numero VIN
  And El sistema muestra el numero vin en el campo "VIN"

Examples:
  |Formato|
  |JPG|
  |JPEG|
  |PNG|

  #tarjeta MOTO HONDA REC VIN **aclarar duda
#2
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

# 4 validar con Lore mensaje de excepcion

  Scenario: Cargar imagen de tarjeta de propiedad superior a las MB permitidas

  Given que el usuario con  <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
  When el usuario hace clic en el campo para cargar la imagen de la tarjeta de propiedad
  Then el sistema muestra el explorador de archivos de windows para seleccionar el archivo
  When el usuario hace clic en la imagen que cumple formato pero no es tarjeta de propiedad
  And el usuario hace clic en el boton "Abrir" del explorador de archivos
  Then El sistema muestra el mensaje "El archivo supera el tamaño permitido".


