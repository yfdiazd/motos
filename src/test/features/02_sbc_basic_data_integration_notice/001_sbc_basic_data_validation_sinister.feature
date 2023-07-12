 #https://app.clickup.com/t/3138710/INC-1907

 #1
 Scenario: Valorar aviso sin número de siniestro
 Given Que el aviso en estado "Sin valorar" no tiene un número de siniestro asociado
 When El usuario con <Rol> de la <Aseguradora> realiza el proceso de valoracion
 Then EL usuario deberia poder completar el proceso de valoracion sin dicha informacion


 #2
 Scenario: Valorar aviso con número de siniestro
 Given Que el aviso en estado "Sin valorar" tiene un número de siniestro asociado
 When El usuario con <Rol> de la <Aseguradora> realiza el proceso de valoracion
 Then El proceso de valoracion tendra asociado el numero de siniestro