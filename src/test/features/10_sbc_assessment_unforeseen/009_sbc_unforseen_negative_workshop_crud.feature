  #1. Restricciones de eliminacion piezas en el estado autorizado
  Scenario: No se puede eliminar piezas del aviso autorizado con roles taller

  #como es que no puede eliminar? no existe el check? existe pero no se habilita el boton?
  Given que el usuario con rol <Rol> desea eliminar una pieza del aviso "Autorizado"
  When consulta la valoracion y hace uso de la accion de imprevistos
  Then el usuario no deberia poder eliminar piezas del aviso

  |Rol|
  |Asesor de servicio taller|
  |jefe de taller|
  |cotizador de daños taller|

 #2. Restricciones de agrupacion de pieza en el estado autorizado
  Scenario: No se puede agrupar piezas del aviso autorizado con roles taller

  Given que el usuario con rol <Rol> desea agrupar piezas del aviso "Autorizado"
  When consulta la valoracion y hace uso de la accion de imprevistos
  Then el usuario no deberia poder agrupar piezas del aviso

  |Rol|
  |Asesor de servicio taller|
  |jefe de taller|
  |cotizador de daños taller|

  #3. Restricciones de ajuste de piezas con accion cambio o TOT estado autorizado
  Scenario: No se puede cambiar el estado de piezas de cambio o TOT del aviso autorizado con roles taller

  Given que el usuario con rol <Rol> desea cambiar de estado piezas para el aviso "Autorizado"
  When consulta la valoracion y hace uso de la accion de imprevistos
  Then el usuario no deberia poder asignar un estado diferente a cambiar para piezas del aviso con dicho estado

  |Rol|
  |Asesor de servicio taller|
  |jefe de taller|
  |cotizador de daños taller|

  #4. Restricciones de ajuste de piezas con accion reparar estado autorizado
  Scenario: No se puede cambiar el estado de piezas de "reparacion" a "remover" para avisos "autorizado" con roles taller

  Given que el usuario con rol <Rol> desea cambiar de estado piezas de "reparacion" a "remover" para el aviso "Autorizado"
  When consulta la valoracion y hace uso de la accion de imprevistos
  Then el usuario no deberia poder asignar un el estado "remover" para piezas del aviso conel estado de "reparar"

  |Rol|
  |Asesor de servicio taller|
  |jefe de taller|
  |cotizador de daños taller|

  #5. Restricciones de ajuste de nivel de danio menor al esablecido
  Scenario: No se puede cambiar el nivel de dabio de piezas de "reparacion" a uno menor para avisos "autorizado" con roles taller
  Regla de negocio: no se podra asignar de un nivel de danio F pasar a M o L
  ni se podra pasar de un nivel de danio M a L

  Given que el usuario con rol <Rol> desea cambiar de nivel de danio para piezas de "reparacion" para el aviso "Autorizado"
  When consulta la valoracion y hace uso de la accion de imprevistos
  Then el usuario no deberia poder asignar un nivel de danio menor para piezas del aviso conel estado de "reparar"

  |Rol|
  |Asesor de servicio taller|
  |jefe de taller|
  |cotizador de daños taller|