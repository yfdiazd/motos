 #1.Eliminacion piezas en el estado autorizado
 Scenario: Se puede eliminar piezas del aviso autorizado con roles de aseguradora

 Given que el usuario con rol <Rol> desea eliminar una pieza del aviso "Autorizado"
 When consulta la valoracion y hace uso de la accion de imprevistos
 Then el usuario deberia poder eliminar las pizas deseadas del aviso
 And el valor de mano de obra, valor repuestos y valor total de la valoracion deberian disminuir
 And al finalizar el proceso, no se debe solicitar la carga de fotografias

 |Rol|
 |analista aseguradora|
 |ATS|
 |administrador|
 |perito aseguradora|
 |administrador|
 |gestor taller|
 |mesa especializada|


  #2. Ajuste de piezas con accion cambio a reparar estado autorizado
 Scenario: Permitir cambiar el estado de piezas de cambio a reparar del aviso autorizado con roles de aseguradora

 Given que el usuario con rol <Rol> desea cambiar de estado piezas para el aviso "Autorizado"
 When consulta la valoracion y hace uso de la accion de imprevistos
 Then el usuario no deberia poder asignar la accion reparar para piezas con accion cambiar
 And deberia poder asignar un nivel de danio, ingresar cantidades, no visualizar la referencia y no poder asignar costo de repuesto
 And el valor repuestos y valor total de la valoracion deberian disminuir
 And al finalizar el proceso, se debe solicitar la carga de fotografias

 |Rol|
 |analista aseguradora|
 |ATS|
 |administrador|
 |perito aseguradora|
 |administrador|
 |gestor taller|
 |mesa especializada|

 #3. Ajuste de piezas con accion cambio a remover estado autorizado
 Scenario: Permitir cambiar el estado de piezas de cambio a remover del aviso autorizado con roles de aseguradora

 Given que el usuario con rol <Rol> desea cambiar de estado piezas para el aviso "Autorizado"
 When consulta la valoracion y hace uso de la accion de imprevistos
 Then el usuario deberia poder asignar la accion remover para piezas con accion cambiar
 And no deberia poder asignar un nivel de danio, ingresar cantidades, no visualizar la referencia y no poder asignar costo de repuesto
 And el valor repuestos y valor total de la valoracion deberian disminuir
 And al finalizar el proceso, se debe solicitar la carga de fotografias

 |Rol|
 |analista aseguradora|
 |ATS|
 |administrador|
 |perito aseguradora|
 |administrador|
 |gestor taller|
 |mesa especializada|


 #4. Ajuste de piezas con accion cambio a remover estado autorizado
 Scenario: Permitir cambiar el estado de piezas de cambio a remover del aviso autorizado con roles de aseguradora

 Given que el usuario con rol <Rol> desea cambiar de estado piezas para el aviso "Autorizado"
 When consulta la valoracion y hace uso de la accion de imprevistos
 Then el usuario deberia poder asignar la accion remover para piezas con accion cambiar
 And no deberia poder asignar un nivel de danio, ingresar cantidades, no visualizar la referencia y no poder asignar costo de repuesto
 And el valor repuestos y valor total de la valoracion deberian disminuir
 And al finalizar el proceso, se debe solicitar la carga de fotografias

 |Rol|
 |analista aseguradora|
 |ATS|
 |administrador|
 |perito aseguradora|
 |administrador|
 |gestor taller|
 |mesa especializada|

 #4. Ajuste de piezas con accion cambio a TOT estado autorizado
 Scenario: Permitir cambiar el estado de piezas de cambio a TOT del aviso autorizado con roles de aseguradora
 Regla de negocio: al cambiar una pieza enviada a compras de accion cambio y se pasa a accion TOT
 deberia crear una nuva posicion y enviar nuevamente a compras

 Given que el usuario con rol <Rol> desea cambiar de estado piezas para el aviso "Autorizado"
 When consulta la valoracion y hace uso de la accion de imprevistos
 Then el usuario deberia poder asignar la accion "TOT" para piezas con accion "cambiar"
 And no deberia poder asignar un nivel de danio, ingresar cantidades, no visualizar la referencia y no poder asignar costo de repuesto
 And el valor repuestos y valor total de la valoracion deberian disminuir
 And al finalizar el proceso, se debe solicitar la carga de fotografias y enviar al proceso de compras las piezas ajustadas

 |Rol|
 |analista aseguradora|
 |ATS|
 |administrador|
 |perito aseguradora|
 |administrador|
 |gestor taller|
 |mesa especializada|


 #4. Ajuste de piezas con accion TOT a  cambioestado autorizado
 Scenario: Permitir cambiar el estado de piezas de TOT a cambio del aviso autorizado con roles de aseguradora
 Regla de negocio: al cambiar una pieza enviada a compras de accion TOT y se pasa a accion cambiar
 deberia crear una nuva posicion y enviar nuevamente a compras

 Given que el usuario con rol <Rol> desea cambiar de estado piezas para el aviso "Autorizado"
 When consulta la valoracion y hace uso de la accion de imprevistos
 Then el usuario deberia poder asignar la accion "TOT" para piezas con accion "cambiar"
 And no deberia poder asignar un nivel de danio, ingresar cantidades, no visualizar la referencia y no poder asignar costo de repuesto
 And el valor repuestos y valor total de la valoracion deberian disminuir
 And al finalizar el proceso, se debe solicitar la carga de fotografias y enviar al proceso de compras las piezas ajustadas

 |Rol|
 |analista aseguradora|
 |ATS|
 |administrador|
 |perito aseguradora|
 |administrador|
 |gestor taller|
 |mesa especializada|
