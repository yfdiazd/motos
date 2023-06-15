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
And  y el usuario ingrese un <valor_no_permitido> en campo "Ajuste horas"
Then el sistema deja el campo en "0"
And no modifica valor en campo "Horas de Trabajo"

  #Se nombra como valor no permitido, aunque en realidad es valor númerido negativo superior a
  #Horas Orbika, ejemplo: Horas Orbika 3 valor no permitido sería -3.1 o -4
  Examples:
  |valor_no_permitido|
  |-10|

 #5
Scenario: Validar comportamiento cuando en el campo Ajustes en Horas se ingrese valor positivo igual a Valor Orbika en negativo

Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
And  y el usuario ingrese un <valor> en campo "Ajustes en horas" igual al valor "Horas Orbika"
Then el sistema muestra permite en Campo "Horas de Trabajo" 0

#Validar con Lore cual es el valor máximo que debe permitir Ajuste en horas
#o si este campo no tiene limite superior (como en pesados) que se deja 1000000 h y permite
#Falta incluir criterio
 #6
Scenario: Validar comportamiento cuando en el campo Ajustes en Horas se ingrese valor positivo superior a Orbika

Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
And  y el usuario ingrese un <valor> en campo "Ajustes en horas"
Then el sistema muestra en los campos carrocería y mecatronica la tarifa configurada
And modifica valor en campo "Horas de Trabajo"

#Falta incluir criterio, pendiente de validar con Lore las horas para cada operación
#Validar con Lore si se va a dejar palabra Valor total mecánica o valor total mecatrónica
 #6
Scenario: Validar valor total para carrocería  y mecatronica cuando se selecciona operación de control asociada a carrocería
Given Que el usuario con <Rol> de la <Aseguradora> se encuentra en la pantalla "Mano de Obra"
When la sección de operaciones de control se encuentra habilitada para los roles de aseguradora
And se marquen <operaciones_carroceria> de control asociadas a carrocería
And se marquen <operaciones_mecanica> de control asociadas a mecanica
Then el sistema muestra en los campos Valor total carrocería y mecatronica el incremento de valor


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

#Validar % de perdida, colores
#0-40 % Azul
#41-60 % Naranja
#61-100 % Rojo (no puede superar el 100%)