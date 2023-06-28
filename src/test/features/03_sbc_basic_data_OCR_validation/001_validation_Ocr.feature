#1
 Scenario: Cargar imagen de tarjeta de propiedad para extraer número VIN a traves de OCR

 Given que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
 When el usuario hace clic en el campo para cargar la imagen de la tarjeta de propiedad
 Then el sistema muestra el explorador de archivos de archivos para seleccionar el archivo de tipo <Formato>
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
#3 validar con Lore mensaje cargar de nuevo porque actualmente dice tarjeta cargada exitosamente y no es cierto
 Scenario: Cargar imagen de tarjeta de propiedad inválida para extraer VIN a traves de OCR

 Given que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
 When el usuario carga una imagen
 Then el sistema realiza el reconocimiento OCR
 And no reconoce el valor del VIN
 Then El sistema muestra el mensaje "No fue posible leer la tarjeta de propiedad, por favor digite el VIN"
 And se muestra el mensaje:"Cargar de nuevo"
 When el usuario diligencia el formulario de datos basicos
 And hace clic en el boton "Continuar"
 Then El sistema ubica el usuario en "Zonas afectadas" y no debe visualizarse la imagen que se intento cargar

# 4 falta criterio

 Scenario: Cargar imagen de tarjeta de propiedad superior a las MB permitidas

 Given que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla de datos basicos
 When el usuario carga una imagen que excede el <tamanio permitido>
 Then El sistema muestra el mensaje "El archivo supera el peso permitido".
 And se muestra el mensaje:"Intentalo de nuevo"

 Examples:
 |tamano permitido|
 |10MB|

 #5
 #caso para que la tarjeta no sea visible cuando no se lee.

