 #1. Ajuste operacione de control
 Scenario: Se deben poder quitar "operaciones de control" para avisos "autorizado" con roles de aseguradora

 Given que el usuario con rol <Rol> desea quitar <operaciones de control> para el aviso "Autorizado"
 When consulta la valoracion y hace uso de la accion de imprevistos
 And consulte la mano de obra
 Then el usuario deberia poder quitar <operaciones de control> existentes para el aviso
 And el valor de mano de obra y total valoracion deberian disminuir
 And al finalizar el proceso, se debe solicitar la carga de fotografias


 |Rol|
 |analista aseguradora|
 |ATS|
 |administrador|
 |gestor taller|
 |mesa especializada|

 |operaciones de control|
 |alineación|
 |carga de aire|


 #2. Ajuste operacione de control en disminucion de nivel
 Scenario: Se debe poder disminuir el nivel de "operaciones de control" para avisos "autorizado" con roles de aseguradora

 Given que el usuario con rol <Rol> desea disminuir el nivel de <operaciones de control> para el aviso "Autorizado"
 When consulta la valoracion y hace uso de la accion de imprevistos
 And consulte la mano de obra
 Then el usuario deberia poder disminuir el nivel para las <operaciones de control> existentes en el aviso.
 And el valor de mano de obra y total valoracion deberian disminuir
 And al finalizar el proceso, se debe solicitar la carga de fotografias

 |Rol|
 |analista aseguradora|
 |ATS|
 |administrador|
 |gestor taller|
 |mesa especializada|

 |operaciones de control|
 |bancada|
 |balanceo|

  #3. Ajuste para horas con roles de aseguradora
 Scenario: Se deben poder agregar horas de carroceria o mecatronica para avisos "autorizado" con roles de aseguradora

 Given que el usuario con rol <Rol> desea realizar un ajustede horas para el aviso "Autorizado"
 When consulta la valoracion y hace uso de la accion de imprevistos
 And consulte la mano de obra
 Then el usuario deberia poder disminuir las horas de carroceria o mecatronicaal del aviso.
 And el valor de mano de obra y total valoracion deberian disminuir
 And al finalizar el proceso, se debe solicitar la carga de fotografias

 |Rol|
 |Asesor de servicio taller|
 |jefe de taller|
 |cotizador de daños taller|