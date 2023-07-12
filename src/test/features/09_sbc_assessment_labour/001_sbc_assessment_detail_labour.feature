#https://app.clickup.com/t/3138710/INC-1915
 #1
 Scenario: Validar acceso pantalla "Mano de Obra" desde bandeja de avisos para rol de aseguradora

 Given Que el usuario con <Rol> de la <Aseguradora> ingresa a la pantalla "Detalle Valoración" desde el botón "Ir" en la bandeja de avisos
 When El usuario hace clic en el botón lápiz de la tarjeta "Mano de Obra"
 Then el sistema direcciona al usuario a la pantalla "Mano de Obra"
 And habilita la sección de ajuste en horas para su edicion
 And la sección de operaciones de control para su modificacion

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

 #2
  Scenario: Validar acceso pantalla "Mano de Obra" desde bandeja de avisos para rol de taller

  Given Que el usuario con <Rol> de taller ingresa a la pantalla "Detalle Valoración" desde el botón "Ir" en la bandeja de avisos
  When El usuario hace clic en el botón lápiz de la tarjeta "Mano de Obra"
  Then el sistema direcciona al usuario a la pantalla "Mano de Obra"
  And muestra deshabilitada para edición la sección de ajuste de mano de obra
  And la sección de operaciones de control se encuentra habilitada para su edicion

 #3
 Scenario: Validar tarifa de taller para carrocería  y mecatronica cuando la marca que se esta valorando tiene tarifa configurada
 Regla de negocio: La tarifa consulta en administracion es la tarifa configurada al taller para la marca

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
 And  y la marca del vehiculo que se esta valorando tiene tarifa configurada para el taller asociado
 Then el sistema muestra en los campos carrocería y mecatronica la tarifa configurada
 And el campo no permite ser editado por el usuario


 #4
 Scenario: Validar tarifa de taller para carrocería  y mecatronica cuando la marca que se esta valorando no tiene tarifa configurada o no esta asociada al taller

 Regla de negocio: Las tarifas de taller se configuran por marca y se consultan por talleres de Admin

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
 And  y la marca del vehiculo que se esta valorando no tiene tarifa configurada para el taller asociado
 Then el sistema muestra en los campos carrocería y mecatronica la tarifa minima configurada para el taller
 And el campo no permite ser editado por el usuario


 #5
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

 #6
 Scenario: Validar comportamiento cuando en el campo Ajustes en Horas se ingrese valor igual a Valor Orbika en negativo

 Given Que el usuario con <Rol> de Aseguradora se encuentra en la pantalla "Mano de Obra"
 When  y el usuario ingrese un <valor> en campo "Ajustes en horas" al valor "Horas Orbika" en negativo
 Then el sistema recalcula las "Horas de Trabajo"
 And el valor de carrocería o mecatronica se recalcula
 And permite al usuario guardar los cambios realizados

 #7
 Scenario: Validar comportamiento cuando en el campo Ajustes en Horas se ingrese valor positivo superior a Orbika

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
 When el usuario ingrese un <valor> en campo "Ajustes en horas"
 Then el sistema muestra en los campos valor total carrocería y mecatronica el valor ajustado


 #8
 Scenario: Validar valor total para carrocería  y mecatronica cuando se selecciona operación de control

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
 When el usuario selecciona las <operaciones_carrocería>
 Then el sistema recalcula el Valor total carroceria
 When el usuario seleccione las <operaciones_mecatronica>
 Then el sistema recalcula el Valor total mecatronica


 Examples:
 |operaciones_carroceria|
 |Alineación de chasis|3|
 |Bancada nivel 1|1.5|
 |Bancada nivel 2|3|
 |Bancada nivel 3|6|

 Examples:
 |operaciones_mecanica|horas|
 |Diagnóstico electrónico|1|
 |Programación|1|
 |Enradiar|2|
 |Diagnóstico mecánico|1.5|
 |Balanceo 1|0.3|
 |Balanceo 2|0.6|



 #9
 Scenario: Validar comportamiento del sistema al hacer clic botón "Confirmar"

 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
 And ha realizado modificaciones en horas u operaciones de control
 When el usuario haga clic en el botón "Confirmar"
 Then el el sistema mantiene los cambios realizados los cuales se guardaran una vez finalizado el proceso de valoracion
 And dirige a la pantalla del detalle de la valoración

#10
 Scenario: Validar comportamiento del botón "Descartar"
 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
 And ha realizado modificaciones en horas u operaciones de control
 When el usuario haga clic en el botón "Descartar"
 Then se muestr un mensaje con el texto: "¿Estas seguro que deseas salir? Perderás toda la información ingresada"
 And al confimar dicha advertencia se descartan los cambios realizados
 And deja al usuario en la pantalla de mano de obra

 #11
 Scenario: Validar comportamiento del botón "Volver"
 Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
 And ha realizado modificaciones en horas u operaciones de control
 When el usuario haga clic en el botón "Volver"
 Then se muestr un mensaje con el texto: "¿Estas seguro que deseas salir? Perderás toda la información ingresada"
 And al confimar dicha advertencia se descartan los cambios realizados
 And deja al usuario en la pantalla de mano de obra