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