    #1.  Restricciones de eliminacion repuestos en el estado autorizado
    Scenario: No se puede eliminar repuestos del aviso autorizado con roles taller

        #como es que no puede eliminar? no existe el check? existe pero no se habilita el boton?
    Given  que el usuario con rol <Rol> desea eliminar un repuesto del aviso "Autorizado"
    When  consulta la valoracion y hace uso de la accion de imprevistos
    Then el usuario no deberia poder eliminar repuestos del aviso

    |Rol|
    |Asesor de servicio taller|
    |jefe de taller|
    |cotizador de daños taller|

     #2.  Restricciones de agrupacion de repuestos en el estado autorizado
    Scenario: No se puede agrupar repuestos del aviso autorizado con roles taller

    Given  que el usuario con rol <Rol> desea agrupar repuestos del aviso "Autorizado"
    When  consulta la valoracion y hace uso de la accion de imprevistos
    Then el usuario no deberia poder agrupar repuestos del aviso

    |Rol|
    |Asesor de servicio taller|
    |jefe de taller|
    |cotizador de daños taller|

    #3.  Restricciones de ajuste de repuesto con accion cambio o TOT estado autorizado
    Scenario: No se puede cambiar el estado de repuestos de cambio o TOT del aviso autorizado con roles taller

    Given  que el usuario con rol <Rol> desea cambiar de estado repuestos para el aviso "Autorizado"
    When  consulta la valoracion y hace uso de la accion de imprevistos
    Then el usuario no deberia poder asignar un estado diferente a cambiar para  repuestos del aviso con dicho estado

    |Rol|
    |Asesor de servicio taller|
    |jefe de taller|
    |cotizador de daños taller|

    #4.  Restricciones de ajuste de repuesto con accion reparar estado autorizado
    Scenario: No se puede cambiar el estado de repuestos de "reparacion" a "remover" para avisos "autorizado" con roles taller

    Given  que el usuario con rol <Rol> desea cambiar de estado repuestos de "reparacion" a "remover" para el aviso "Autorizado"
    When  consulta la valoracion y hace uso de la accion de imprevistos
    Then el usuario no deberia poder asignar un el estado "remover" para  repuestos del aviso conel estado de "reparar"

    |Rol|
    |Asesor de servicio taller|
    |jefe de taller|
    |cotizador de daños taller|

    #5.  Restricciones de ajuste de nivel de danio menor al esablecido
    Scenario: No se puede cambiar el nivel de dabio de repuestos de "reparacion" a uno menor para avisos "autorizado" con roles taller
    Regla de negocio: no se podra asignar de un nivel de danio F pasar a M o L
    ni se podra pasar de un nivel de danio M a L

    Given  que el usuario con rol <Rol> desea cambiar de nivel de danio para repuestos de "reparacion" para el aviso "Autorizado"
    When  consulta la valoracion y hace uso de la accion de imprevistos
    Then el usuario no deberia poder asignar un nivel de daniomenor para  repuestos del aviso conel estado de "reparar"

    |Rol|
    |Asesor de servicio taller|
    |jefe de taller|
    |cotizador de daños taller|