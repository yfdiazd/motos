#1
 Scenario: Cargar imagen de tarjeta de propiedad para extraer número VIN a traves de OCR

 Given que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
 When el usuario hace clic en el campo para cargar la imagen de la tarjeta de propiedad
 Then el sistema muestra el explorador de archivos  para seleccionar el archivo de tipo <Formato>
 When el usuario hace clic en la imagen
 And el usuario hace clic en el boton "Abrir" del explorador de archivos
 Then El sistema procesa la imagen mediante OCR para extraer el numero VIN
 And El sistema muestra el mensaje: "la tarjeta se cargó exitosamente"
 And muestra el numero vin en el campo "VIN"
 When El usuario diligencia el formulario de datos basicos
 And hace clic en el boton "Continuar"
 Then El sistema ubica al usuario en "Zonas afectadas"
 And muestra la imagen de la tarjeta de propiedad cargada

Examples:
 |Formato|
 |JPG|
 |JPEG|
 |PNG|
#2
 Scenario: Cargar imagen  inválida para extraer VIN a traves de OCR

 Given que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
 When el usuario carga una imagen
 Then el sistema realiza el reconocimiento OCR
 And no reconoce el valor del VIN
 Then El sistema muestra el mensaje "el tipo de archivo es inválido"
 And muestra el link "Intenta de nuevo"
 When el usuario digita el VIN y diligencia el formulario de datos basicos
 And hace clic en el boton "Continuar"
 Then El sistema ubica el usuario en "Zonas afectadas" y no debe visualizarse la imagen que se intento cargar

#3 este mensaje no deberia aplicar para la tarjeta sino para el VIN- Ver con Joha y Lore

 Scenario: Cargar imagen de tarjeta de propiedad con caracteres invalidos

 Given que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
 When el usuario carga tarjeta de propiedad con letras solapadas en el VIN
 Then El sistema realiza el reconocimiento y escribe el VIN con caracteres especiales
 And se muestra el mensaje:"la tarjeta contiene caracteres inválidos"
 And muestar el link "Intenta de nuevo"
 When el usuario digita el VIN y diligencia el formulario de datos basicos
 And hace clic en el boton "Continuar"
 Then El sistema ubica el usuario en "Zonas afectadas" y no debe visualizarse la imagen que se intento cargar

 Examples:
 |tamano permitido|
 |10MB|

 #4
 Scenario: Cargar imagen de tarjeta de propiedad superior a las MB permitidas

 Given que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
 When el usuario carga una imagen que excede el <tamanio permitido>
 Then El sistema muestra el mensaje "El archivo supera el peso permitido".
 And se muestra el mensaje:"Intentalo de nuevo"
 When el usuario digita el VIN y diligencia el formulario de datos basicos
 And hace clic en el boton "Continuar"
 Then El sistema ubica el usuario en "Zonas afectadas" y no debe visualizarse la imagen que se intento cargar


 #5 inválido hace referencia otro tipo de formato o no legible o no se lee
 Scenario: Cargar imagen de tarjeta de propiedad inválida para extraer VIN a traves de OCR

 Given que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
 When el usuario carga una imagen
 Then el sistema realiza el reconocimiento OCR
 And no reconoce el valor del VIN
 Then El sistema muestra el mensaje "No fue posible leer la tarjeta de propiedad, por favor digite el VIN"
 When el usuario digita el VIN y diligencia el formulario de datos basicos
 And hace clic en el boton "Continuar"
 Then El sistema ubica el usuario en "Zonas afectadas" y no debe visualizarse la imagen que se intento cargar
