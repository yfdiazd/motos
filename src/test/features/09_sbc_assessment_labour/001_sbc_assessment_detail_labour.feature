#Nota: cambiar el titulo de la pantalla, debería decir Mano de Obra, actualmente aparece como "Valoración" y por ende se debe ajustar la miga de pan
#Falta incluir criterio
 #Validar con Lore si el sistema debe mantener los
 #1
Scenario: Validar acceso pantalla "Mano de Obra" desde bandeja de avisos

Given Que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla "Detalle Valoración" desde el botón "Ir" en la bandeja de avisos
When El usuario hace clic en el botón lápiz de la tarjeta "Mano de Obra"
Then el sistema direcciona al usuario a la pantalla "Mano de Obra"
And habilita la sección de ajuste en horas si el <rol> es un rol de <aseguradora>, sino muestra deshabilitada esta sección para su edición
And la sección de operaciones de control se encuentra habilitada para los roles de aseguradora

|Rol|
|analista aseguradora|
|ATS|
|administrador|
|gestor taller|
|mesa especializada|

|aseguradora|
|Sura|
|Bolivar|
|Sura Panama|

#Tener en cuenta que para motos no aplica Pintura
 #Falta incluir criterio
 #2
Scenario: Validar tarifa de taller para carrocería  y mecatronica cuando la marca que se esta valorando tiene tarifa configurada

Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
And  y la marca del vehiculo que se esta valorando tiene tarifa configurada para el taller asociado
Then el sistema muestra en los campos carrocería y mecatronica la tarifa configurada
And el campo no permite ser editado por el usuario

#Falta incluir criterio
 #3
Scenario: Validar tarifa de taller para carrocería  y mecatronica cuando la marca que se esta valorando no tiene tarifa configurada o no esta asociada al taller
Las tarifas de tller se configuran por marca y se consultan por talleres de Admin

Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
And  y la marca del vehiculo que se esta valorando no tiene tarifa configurada para el taller asociado
Then el sistema muestra en los campos carrocería y mecatronica la tarifa minima configurada para el taller
And el campo no permite ser editado por el usuario

#Validar con Lore cual es el comportamiento esperado, en pesados cambia el valor a 0 dado que tenga un valor negativo superior a Horas Orbika
  #entonces preguntar si va a adaptar ese comportamiento, o qué debe hacer el sistema
 #Falta incluir criterio
 #4
Scenario: Validar comportamiento cuando en campo Ajustes en Horas se ingrese valor negativo superior a Orbika

Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
When el usuario ingrese un <valor_no_permitido> en campo "Ajuste horas"
Then el sistema deja el campo en "0"
And no modifica valor en campo "Horas de Trabajo"
And el usuario debe ser notificado con el mensaje: "El valor en horas no puede ser menor a las horas orbika"



  #Se nombra como valor no permitido, aunque en realidad es valor númerido negativo superior a
  #Horas Orbika, ejemplo: Horas Orbika 3 valor no permitido sería -3.1 o -4
Examples:
|valor_no_permitido|
|-10|

 #5
Scenario: Validar comportamiento cuando en el campo Ajustes en Horas se ingrese valor igual a Valor Orbika en negativo

Given Que el usuario con <Rol> de Aseguradora se encuentra en la pantalla "Mano de Obra"
When  y el usuario ingrese un <valor> en campo "Ajustes en horas" al valor "Horas Orbika" en negativo
Then el sistema recalcula las "Horas de Trabajo"
And el valor de carrocería o mecatronica se recalcula
And permite al usuario guardar los cambios realizados

 #6
Scenario: Validar comportamiento cuando en el campo Ajustes en Horas se ingrese valor positivo superior a Orbika

Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
When el usuario ingrese un <valor> en campo "Ajustes en horas"
Then el sistema muestra en los campos valor total carrocería y mecatronica el valor ajustado


#Falta incluir criterio, pendiente de validar con Lore las horas para cada operación
#Validar con Lore si se va a dejar palabra Valor total mecánica o valor total mecatrónica
 #6
Scenario: Validar valor total para carrocería  y mecatronica cuando se selecciona operación de control
Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
When el usuario selecciona las <operaciones_carrocería>
Then el sistema recalcula el Valor total carroceria
When el usuario seleccione las <operaciones_mecatronica>
Then el sistema recalcula el Valor total mecatronica


Examples:
|operaciones_carroceria|
|Alineación de chasis|
|Bancada|

Examples:
|operaciones_mecanica|
|Diagnóstico electrónico|
|Programación|
|Enradiar|
|Diagnóstico mecánico|
|Balanceo|


#7 ajustar de acuerdo al figma boton guarrdar ya no va sino confirmar  ,
Scenario: Validar comportamiento del sistema al hacer clic botón "Confirmar"
Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
And ha realizado modificaciones en horas u operaciones de control
When el usuario haga clic en el botón "Confirmar"
Then el el sistema mantiene los cambios realizados los cuales se guardaran una vez finalizado el proceso de valoracion
And dirige a la pantalla del detalle de la valoración

#8
Scenario: Validar comportamiento del botón "Descartar"
Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
And ha realizado modificaciones en horas u operaciones de control
When el usuario haga clic en el botón "Descartar"
Then se muestr un mensaje con el texto: "¿Estas seguro que deseas salir? Perderás toda la información ingresada"
And al confimar dicha advertencia se descartan los cambios realizados
And deja al usuario en la pantalla de mano de obra

