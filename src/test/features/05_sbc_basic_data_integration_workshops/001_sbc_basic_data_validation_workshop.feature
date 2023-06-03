#1
  Scenario: Validar informacion  de taller y ciudad de taller asociada en la creacion del aviso

  Given Que el aviso en estado "Sin valorar" tiene asociado un "Taller"
  And tiene asociada la "Ciudad del taller"
  When El usuario con <Rol> de la <Aseguradora> ingresa al formulario datos basicos
  Then El sistema muestra el campo "Taller" con el taller asociado al aviso
  And  El sistema muestra el campo "Ciudad del taller" con la ciudad del taller al que se encuentra asociado el aviso
  And  El sistema lista en el  campo "Tipo de pintura" los <Tipo de pintura> disponibles segun la <Tecnologia de pintura> asociada al taller
  When El usuario completa el formulario de datos básicos
  And hace clic en el boton continuar
  Then El sistema valida el campo "Taller" como válido
  And  El sistema valida el campo "Ciudad del taller" como valido

  Examples:
  |Tecnologia de pintura|
  |Agua|
  |Solvente|

  Examples: Solvente
  |Tipo de pintura|
  |Monocapa|
  |Solido Bicapa|
  |Metalizada|
  |Perlada|
  |Tricapa|

  Examples: Agua
  |Tipo de pintura Agua|
  |Solido Bicapa|
  |Metalizada|
  |Perlada|
  |Tricapa|

#2
Scenario: Validar cambio de taller asociado al aviso en la misma ciudad desde la edicion del detalle del aviso

  Given Que el aviso en estado "Sin valorar" tiene un cambio de taller de Agua a Solvente desde el detalle del aviso
  And la ciudad del taller es la misma
  When El usuario con <Rol> de la <Aseguradora> ingresa al formulario datos basicos
  Then El sistema muestra el campo "Taller" con el taller asociado al aviso
  And  El sistema muestra el campo "Ciudad del taller" con la ciudad del taller al que se encuentra asociado el aviso
  And  El sistema lista en el  campo "Tipo de pintura" los <Tipo de pintura> asociados a la tecnologia Solvente configurada al taller cambiado
  When El usuario completa el formulario de datos básicos
  And hace clic en el boton continuar
  Then El sistema valida el campo "Taller" como válido
  And  El sistema valida el campo "Ciudad del taller" como valido

#3
  Scenario: Validar cambio de "Taller" y "Ciudad de Taller" desde la edicion del detalle del aviso

  Given Que el aviso en estado "Sin valorar" tiene un cambio de taller de Solvente a Agua desde el detalle del aviso
  And la ciudad del taller tambien se modifica
  When El usuario con <Rol> de la <Aseguradora> ingresa al formulario datos basicos
  Then El sistema muestra el campo "Taller" con el taller asociado al aviso
  And  El sistema muestra el campo "Ciudad del taller" con la ciudad del taller al que se encuentra asociado el aviso
  And  El sistema lista en el  campo "Tipo de pintura" los <Tipo de pintura> asociados a la tecnologia Agua configurada al taller cambiado
  When El usuario completa el formulario de datos básicos
  And hace clic en el boton continuar
  Then El sistema valida el campo "Taller" como válido
  And  El sistema valida el campo "Ciudad del taller" como valido
#4
  Scenario: Validar cambio de taller en la misma ciudad desde datos basicos

  Given Que el usuario con <Rol> de la <Aseguradora> ingresa al formulario de datos basicos
  When El usuario despliega la lista en el campo "Taller"
  Then El sistema unicamente muestra los talleres asociados al tipo de vehiculo "Moto" para la ciudad seleccionada
  When El usuario cambia el taller en el campo "Taller"
  Then El sistema lista en el  campo "Tipo de pintura" los <Tipo de pintura> disponibles segun la <Tecnologia de pintura> asociada al taller
  When El usuario completa el formulario de datos básicos
  And hace clic en el boton continuar
  Then El sistema valida el campo "Taller" como válido
  And  El sistema valida el campo "Ciudad del taller" como valido
  When El usuario accede al detalle del aviso
  Then El sistema muestra en el campo "Taller" el taller que ha sido modificado desde datos basicos
  And El sistema muestra en el campo "Ciudad del taller" la ciudad del taller que quedo seleccionada desde datos basicos asociada al taller


#5
  Scenario: Validar cambio de "Ciudad de Taller" y "Taller" desde datos basicos

  Given Que el usuario con <Rol> de la <Aseguradora> ingresa al formulario de datos basicos
  When El usuario modifica la ciudad del taller en el campo "Ciudad del taller"
  Then El sistema lista en el campo "Taller" unicamente los talleres asociados al tipo de vehiculo "Moto" para la ciudad seleccionada
  When El usuario cambia el taller en el campo "Taller"
  Then El sistema lista en el  campo "Tipo de pintura" los <Tipo de pintura> disponibles segun la <Tecnologia de pintura> asociada al taller
  When El usuario completa el formulario de datos básicos
  And hace clic en el boton continuar
  Then El sistema valida el campo "Taller" como valido
  And  El sistema valida el campo "Ciudad del taller" como valido
  When El usuario accede al detalle del aviso
  Then El sistema muestra en el campo "Taller" el taller que ha sido modificado desde datos basicos
  And El sistema muestra en el campo "Ciudad del taller" la ciudad del taller que fue modificada desde datos basicos asociada al taller

# 6 Validar con Lore comportamiento esperado

  Scenario: Validar informacion de "Ciudad del taller" y "Taller" asociado en la creacion del aviso cuando no corresponde al tipo de vehiculo Moto

  Given Que el aviso en estado "Sin valorar" tiene asociado un "Taller" que no pertenece al tipo de vehiculo "Moto"
  And tiene asociada la "Ciudad del taller"
  When El usuario con <Rol> de la <Aseguradora> ingresa al formulario datos basicos
 """ Then El sistema muestra el campo "Taller" con el taller asociado al aviso
  And  El sistema muestra el campo "Ciudad del taller" con la ciudad del taller al que se encuentra asociado el aviso
