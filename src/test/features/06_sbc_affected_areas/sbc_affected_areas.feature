#1
  Scenario: Redireccionamiento a la pantalla "Datos basicos" al hacer clic en el boton "Volver"

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Zonas afectadas"
  When El usuario hace clic en el boton "Volver"
  Then El sistema regresa al usuario a la pantalla de "Datos basicos" para consultar la informacion diligenciada
  And El sistema muestra habilitado el formulario para realiza edicion de informacion
  When El usuario modifica el taller
  And  Hace clic en el boton continuar
  Then El sistema lo redirecciona nuevamente a la pantalla de "Zonas Afectadas"


#2 Ajustar criterio para especificar tamaño permitido, formato porque en el criterio dice pdf pero la aplicacion
  #permite jpg, jpeg, png, mostrar a lore que no es claro que el botón continuar no se active porque falta subir fotos
  #también revisar con lore para ajustar porque el mensaje en galeria de fotos es redundante. Ademas el criterio dice que se permite por lateralidad y eso no es asi en motos y limite de fotos sin limite?

  Scenario: Validar cargue de documentos en los formatos permitidos

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Zonas afectadas"
  When El usuario hace clic en el cargue de documentos
  Then El sistema abre el explorador de archivos
  When El usuario selecciona los <documentos> a cargar
  And  El usuario hace clic en el boton "Abrir"
  Then El sistema muestra el mensaje "Los documentos se cargaron de manera correcta, en la pestaña de documentos puedes visualizarlos."
  When El usuario pulsa el boton "Cerrar" en el pop up
  Then El pop up se cierra
  And  El sistema deja al usuario en el mismo tab de "Cargue de documentos"
  When El usuario hace clic en el tab de "Documentos"
  Then El sistema muestra la lista de los documentos con nombre, extension, el nombre del usuario que lo cargo con el respectivo <Rol>
  And El sistema muestra por cada documento la fecha y hora en que fue agregado
  And El sistema muestra disponible los botones "Eliminar" y "Descargar" por cada documento
  When El usuario hace clic en el boton "Continuar"
  Then El sistema no ejecuta ninguna accion porque el boton "Continuar" se encuentra deshabilitado
  When El usuario hace clic en el tab  "Galeria de fotos"
  Then El sistema muestra activo el boton "Subir fotografias"
  When El usuario hace clic en el botón "Subir fotografias"
  Then El sistema abre el explorador de archivos
  When El usuario selecciona los <documentos> a cargar
  And  El usuario hace clic en el boton "Abrir"
  Then El sistema muestra el mensaje "Las imágenes se cargaron de manera correcta, en la pestaña de galería puedes visualizar las imágenes."
  When El usuario hace clic en el boton "x" del pop up
  Then El sistema cierra el pop up
  And  habilita el boton "Continuar"
  When El usuario hace clic en el boton "Continuar"
  Then El sistema redireccional usuario a la pantalla de "Detalle valoracion".

  Examples:
  |documentos|
  |jpg|
  |jpeg|
  |png|
  |pdf|

#3

  Scenario: Validar eliminacion de documentos cargados

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Zonas afectadas"
  And la valoracion ya tiene cargados documentos
  When El usuario hace clic  en el tab "Documentos"
  Then muestra la lista de los documentos con nombre, extension, el nombre del usuario que lo cargo con el respectivo <Rol>
  And El sistema muestra disponible los botones "Eliminar" y "Descargar" por cada documento
  When El usuario hace clic en el boton "Eliminar" del documento que desea eliminar
  Then El sistema muestra el pop up "Eliminar documentos" con el mensaje:"¿Está seguro de que deseas eliminar el documento?"
  When El usuario pulsa el boton "OK"
  Then El sistema quita del listado el documento eliminado

#4
Scenario: Validar cancelacion eliminacion de documentos cargados

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Zonas afectadas"
  And la valoracion ya tiene cargados documentos
  When El usuario hace clic  en el tab "Documentos"
  Then muestra la lista de los documentos con nombre, extension, el nombre del usuario que lo cargo con el respectivo <Rol>
  And El sistema muestra disponible los botones "Eliminar" y "Descargar" por cada documento
  When El usuario hace clic en el boton "Eliminar" del documento que desea eliminar
  Then El sistema muestra el pop up "Eliminar documentos" con el mensaje:"¿Está seguro de que deseas eliminar el documento?"
  When El usuario pulsa el boton "Cancelar"
  Then El sistema deja al usuario en el mismo tab de "Documentos"
  And muestra el listado de documentos inicial con el <documento> que se habia intentado eliminar.

#5
  Scenario: Validar descarga de documentos

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Zonas afectadas"
  And la valoracion ya tiene cargados documentos
  When El usuario hace clic  en el tab "Documentos"
  Then muestra la lista de los documentos con nombre, extension, el nombre del usuario que lo cargo con el respectivo <Rol>
  And El sistema muestra disponible los botones "Eliminar" y "Descargar" por cada documento
  When El usuario hace clic en el boton "Descargar"
  Then El sistema descarga el documento seleccionado


#6
  Scenario: Validar cargue de documentos en formatos no permitidos

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Zonas afectadas"
  When El usuario hace clic en el cargue de documentos
  Then El sistema abre el explorador de archivos
  When El usuario selecciona los archivos en formatos no permitidos para los <documentos>
  And  El usuario hace clic en el boton "Abrir"
  Then El sistema muestra el mensaje "El tipo del archivo es invalido.Formato de documento e imagen permitido: pdf, png, jpg, jpeg"
  When El usuario pulsa el boton "Cerrar" en el pop up
  Then El pop up se cierra
  When El usuario hace clic en el tab Documentos
  Then El sistema lista los documentos cargados
  And El sistema no muestra el documento que se intentó cargar en formato diferente



#7
  Scenario: Validar maximo de documentos permitidos para cargue

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Zonas afectadas"
  When El usuario hace clic en el cargue de documentos
  Then El sistema abre el explorador de archivos
  When El usuario selecciona los <documentos> a cargar
  And  El usuario hace clic en el boton "Abrir"
  Then El sistema muestra el mensaje "No se carga documentos, recuerde que el máximo de documentos a cargar son Cinco (5)"
  When El usuario pulsa el boton "x" en el pop up
  Then El pop up se cierra
  When El usuario hace clic en el tab Documentos
  Then El sistema lista los documentos cargados

# 8
  Scenario: Eliminar fotos en tab "Galeria de fotos"

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Zonas afectadas"
  When El usuario hace clic en el tab "Galeria de fotos"
  Then El sistema muestra activo el boton "Subir fotografias"
  When El usuario hace clic en el botón "Subir fotografias"
  Then El sistema abre el explorador de archivos
  When El usuario selecciona los <documentos> a cargar
  And  El usuario hace clic en el boton "Abrir"
  Then El sistema muestra el mensaje "Las imágenes se cargaron de manera correcta, en la pestaña de galería puedes visualizar las imágenes."
  When El usuario hace clic en el boton "x" del pop up
  Then El sistema cierra el pop up
  When El usuario hace click sobre el boton "x" de la fotografia
  Then El sistema muestra el mensaje: "¿Está seguro de que deseas eliminar la imagen?"
  When El usuario hace clic en el boton "Cancelar"
  Then El sistema cierra el pop up y deja al usuario en el mismo tab
  When El usuario hace click sobre el boton "x" de la fotografia
  Then El sistema muestra el mensaje: "¿Está seguro de que deseas eliminar la imagen?"
  When El usuario hace clic en el boton "Ok"
  Then El sistema elimina la fotografía de la pantalla
  And El sistema deja al usuario en el mismo tab
  And El sistema habilita el boton "Continuar" si existe mas fotografias de lo contrario lo muestra inactivo y el usuario debe ingresar al menos 1 fotografia
  When El usuario hace clic en el boton "Continuar"
  Then El sistema guarda los cambios realizados en la pantalla "Zonas Afectadas".

#9 actualmente la aplicacion asi lo hace pero en el criterio dice que el boton continuar se activa siempre y cuando
  #existan fotografías en cualquiera de los dos tabs , cambiar criterio donde dice que continuar lleva a detalle del aviso
  # es necesario reajustar todos los criterios de zonas afectadas.

  Scenario: Validar cargue de fotografias sin documentos en zonas afectadas

  Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Zonas afectadas"
  And la valoracion no tiene asociados documentos
  When El usuario hace clic en el tab "Galeria de fotos"
  Then El sistema muestra activo el boton "Subir fotografias"
  When El usuario hace clic en el botón "Subir fotografias"
  Then El sistema abre el explorador de archivos
  When El usuario selecciona los <documentos> a cargar
  And  El usuario hace clic en el boton "Abrir"
  Then El sistema muestra el mensaje "Las imágenes se cargaron de manera correcta, en la pestaña de galería puedes visualizar las imágenes."
  When El usuario hace clic en el boton "x" del pop up
  Then El sistema cierra el pop up
  When El usuario hace clic en el boton "Continuar"
  Then El sistema  guarda los cambios realizados en la pantalla "Zonas Afectadas"

