#https://app.clickup.com/t/3138710/INC-1910

#1
Scenario: Redireccionamiento a pantallas anteriores al hacer clic en el boton "Volver"

Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
When El usuario hace clic en el boton "Volver"
Then El sistema regresa al usuario a la pantalla de "Zonas afectadas" para consultar la informacion diligenciada
And Permite cargar nuevamente fotografias y documentos
When el usuario hace clic en el boton "Volver" de "Zonas afectadas"
Then El sistema regresa al usuario a la pantalla de "Datos basicos" para consultar la informacion diligenciada
And El sistema muestra habilitado el formulario para realizar edicion de informacion
When El usuario modifica el numero del VIN a traves del OCR
And El sistema reconoce el VIN
Then El sistema carga nuevamente la informacion del vehiculo asociada al VIN, Marca, Linea, Version Modelo y Valor Comercial
And El sistema mantiene diligenciado los demas campos que no se han editado
When El usuario modifica la carroceria
And hace clic en el boton "Continuar"
Then El sistema lo redirecciona nuevamente a la pantalla de "Zonas Afectadas"
And muestra en la pestana de fotografias la imagen de la tarjeta de propiedad cargada
And muestra las otras fotografias y documentos cargados previamente
When El usuario hace clic en el boton "Continuar"
Then El sistema direcciona al usuario a la pantalla "Detalle Valoracion"
And muestra disponible la informacion actualizada del VIN en los campos "VIN", "Marca", "Linea", "Version", "Ano", "Valor comercial" y "Tipo de vehiculo"
When El usuario completa la informacion de la valoracion
And hace clic en el boton "Guardar"
Then el sistema muestra mensaje: "Los cambios fueron realizados"
And se habilita el boton "Finalizar"
When el usuario hace clic en el boton "Finalizar"
Then El sistema direcciona al usuario al "Detalle del aviso"
And el estado del aviso cambia a "Pendiente Ajuste"
And se visualiza la informacion de los campos "Placa Tercero", "Placa Asegurado" , "Marca", "Linea", "Version", "Ano", "Valor comercial", "Porcentaje perdida", "Valor de mano de obra", "Valor de repuestos", "Ciudad del taller" y "Taller" de acuerdo a la informacion de la valoracion

#2 validar que no permita avanzar sin un repuesto.

Scenario: Restriccion al avanzar de detalle de valoracion sin piezas

Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
When El usuario hace clic en el boton "Guardar"
And no se ha ingresado ningun repuesto en la tabla de piezaas.
Then El sistema debe mostrar un mejsaje con el texto: "Debes agregar minimo un repuesto para guardar la valoracion"
And no debe permitir avanzar.


 #3 validar que se permita cambiar el valor comercial:
Scenario: Edicion para el valor comercial, "taller" y "ciudad taller"

Given Que el usuario con <Rol> de la <Aseguradora> se encuentra ubicado en la pantalla "Detalle Valoracion"
When el usuario visualice la infomacion de los campos valor "comercial", "taller" y "ciudad de taller".
Then el usuario deberia poder realizar cambios si los desea.
And el usuario podra persistir dichos cambios.

