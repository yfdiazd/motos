 #1. Restricciones de ajuste operacione de control
 Scenario: No se deben poder quitar "operaciones de control" para avisos "autorizado" con roles taller

 Given que el usuario con rol <Rol> desea quitar <operaciones de control> para el aviso "Autorizado"
 When consulta la valoracion y hace uso de la accion de imprevistos
 And consulte la mano de obra
 Then el usuario no deberia poder quitar <operaciones de control> existentes para el aviso.

 |Rol|
 |Asesor de servicio taller|
 |jefe de taller|
 |cotizador de daños taller|

 |operaciones de control|
 |alineación|
 |carga de aire|


 #2. Restricciones de ajuste operacione de control en disminucion de nivel
 Scenario: No se deben poder disminuir el nivel de "operaciones de control" para avisos "autorizado" con roles taller
 Regla de negocio: al poseer operacione de control como lo son bancada o balanceo que al poseer niveles, para los
 roles de talle no se debe poder pasar de un nivel 4 a uno menos como 3, 2 o 1.

 Given que el usuario con rol <Rol> desea disminuir el nivel de <operaciones de control> para el aviso "Autorizado"
 When consulta la valoracion y hace uso de la accion de imprevistos
 And consulte la mano de obra
 Then el usuario no deberia poder disminuir el nivel para las <operaciones de control> existentes en el aviso.

 |Rol|
 |Asesor de servicio taller|
 |jefe de taller|
 |cotizador de daños taller|

 |operaciones de control|
 |bancada|
 |balanceo|

  #3. Restricciones de ajuste para horas con roles de taller
 Scenario: No se deben poder agregar horas de carroceria o mecatronica para avisos "autorizado" con roles taller

 Given que el usuario con rol <Rol> desea realizar un ajustede horas para el aviso "Autorizado"
 When consulta la valoracion y hace uso de la accion de imprevistos
 And consulte la mano de obra
 Then el usuario no deberia poder ingresar horas de carroceria ni mecatronicaal aviso.

 |Rol|
 |Asesor de servicio taller|
 |jefe de taller|
 |cotizador de daños taller|