

Manual de usuario de aptitude


Versión 0.6.6


Daniel Burrows

<dburrows@debian.org>

Copyright © 2004-2008 Daniel Burrows

This manual is free software; you can redistribute it and/or modify it under the
terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.

This manual is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this manual; if not, write to the Free Software Foundation, Inc., 59 Temple
Place, Suite 330, Boston, MA 02111-1307 USA

--------------------------------------------------------------------------------
Tabla de contenidos



  Introducción


        ¿Qué es aptitude?

        ¿Qué es un gestor de paquetes?

        ¿Qué es el sistema apt?

        ¿Como puedo conseguir aptitude?


              Paquetes pre-compilados de aptitude, o &#8220;lo que el 99% de los
              usuarios debería hacer&#8221;.

              Construir aptitude desde el código fuente.

              Cómo seguir y participar en el desarrollo de aptitude.



  1. Empezar


        Usar aptitude


              Introducción al uso de aptitude.

              Explorar la lista de paquetes de aptitude.

              Encontrar paquetes por nombre.

              Gestionar paquetes

              Actualizar la lista de paquetes e instalar paquetes.


        Usar aptitude en la línea de órdenes


  2. Guía de referencia de aptitude


        La interfaz de usuario de aptitude en la terminal


              Usar los menús.

              Órdenes del menú.

              Trabajar con varias vistas.

              Convertirse en root.


        Gestionar paquetes


              Gestionar la lista de paquetes.

              Acceso a la información de los paquetes.

              Modificar los estados de los paquete.

              Descargar, instalar y eliminar paquetes.

              Llaves GPG: Entender y gestionar la confianza de los paquetes.

              Gestionar paquetes automáticamente instalados.


        Resolver las dependencias de los paquetes


              Resolución de dependencias de aptitude.

              Resolución inmediata de dependencias.

              Resolver dependencias de manera interactiva.

              Costs in the interactive dependency resolver

              Configurar el solucionador interactivo de dependencias.


        Patrones de búsqueda


              Buscar cadenas de caracteres.

              Abreviaturas de términos de búsqueda.

              Búsquedas y versiones.

              Objetivos explícitos de búsqueda.

              Referencia de los términos de búsqueda.


        Personalizar aptitude


              Personalizar la lista de paquetes.

              Personalizar teclas rápidas.

              Personalizar los colores del texto y estilos.

              Personalizar el diseño de la interfaz.

              Referencia del archivo de configuración.

              Temas.


        Jugar al Buscaminas


  3. Preguntas más frecuentes de aptitude

  4. Créditos

  I. Referencia de la línea de órdenes


        aptitude --; interfaz de alto nivel para la gestión de paquetes

        aptitude-create-state-bundle --; empaquetar el estado actual de
        aptitude

        aptitude-run-state-bundle --; desempaquetar un archivo de estado de
        aptitude e invocar aptitude sobre éste


Lista de figuras



  2.1. Órdenes disponibles en el menú Acciones.

  2.2. Órdenes disponibles en el menú Deshacer.

  2.3. Órdenes disponibles en el menú Paquete.

  2.4. Órdenes disponibles en el menú Solucionador.

  2.5. Órdenes disponibles en el menú Buscar.

  2.6. Órdenes disponibles en el menú Opciones.

  2.7. Órdenes disponibles en el menú Vistas.

  2.8. Órdenes disponibles en el menú Ayuda.

  2.9. Valores de la marca de &#8220;estado actual&#8221;

  2.10. Valores de la marca de &#8220;acción&#8221;

  2.11. Syntax of compound cost components

  2.12. Safety cost levels

  2.13. Sintaxis del término ?for

  2.14. Estilos personalizables en aptitude

Lista de tablas



  2.1. Basic cost components

  2.2. Default safety cost levels

  2.3. Guía rápida de términos de búsqueda

Lista de ejemplos



  2.1. Sample resolver costs

  2.2. Uso del término ?=.

  2.3. Uso del término ?bind.

  2.4. Uso del término ?exact-name.

  2.5. Uso del término ?for.

  2.6. Uso del término ?term-prefix.

  2.7. Uso de pattern (patrón) para agrupar paquetes en base a su
  desarrollador.

  2.8. Uso de pattern con algunos paquetes del nivel superior.

  2.9. Uso de la directriz de agrupación pattern con sub-directrices.

  10. Uso de --show-summary.


Introducción

Tabla de contenidos



  ¿Qué es aptitude?

  ¿Qué es un gestor de paquetes?

  ¿Qué es el sistema apt?

  ¿Como puedo conseguir aptitude?


        Paquetes pre-compilados de aptitude, o &#8220;lo que el 99% de los
        usuarios debería hacer&#8221;.

        Construir aptitude desde el código fuente.

        Cómo seguir y participar en el desarrollo de aptitude.



�  &#8220;Maestro, ¿posee Emacs la naturaleza del Buda?&#8221; preguntó el � 
   novicio.

   &#8220;No veo porqué no,&#8221; respondió el maestro. &#8220;Va sobrado
   en todo lo demás.&#8221; Varios años después, de súbito, el novicio
   alcanzó la iluminación.

�                                                                 -- John Fouhy


¡Hola y bienvenido al Manual de usuario de aptitude! Esta sección
introductoria explica qué es aptitude y como conseguirlo; en lo referente a
información de su uso, véase Capítulo� 1, Empezar.


¿Qué es aptitude?

aptitude es un gestor de paquetes con varias funciones diseñado para sistemas
Debian GNU/Linux, y basado en la infraestructura del conocido gestor de paquetes
apt. aptitude ofrece la funcionalidad de dselect y apt-get así como otras
funciones adicionales que no se encuentran en ninguno de los programas
anteriormente mencionados.


¿Qué es un gestor de paquetes?

Un gestor de paquetes mantiene un registro del software que está instalado en
su ordenador, y le permite instalar software nuevo, actualizarlo a versiones
más recientes, o eliminar software de una manera sencilla. Como su propio
nombre sugiere, los gestores de paquetes gestionan paquetes: conjuntos de
archivos que se agrupan y que puede instalar y eliminar como conjunto.

A menudo, un paquete es un solo programa. Por ejemplo, el cliente de mensajería
instantánea gaim se encuentra dentro en un paquete Debian del mismo nombre. Por
otro lado, es común que un programa consista de varios paquetes relacionados
entre ellos. Por ejemplo, el editor de imágenes gimp no solo consiste del
paquete gimp, sino también del paquete gimp-data; además, hay otros paquetes
opcionales también disponibles (los cuales contienen datos esotéricos,
documentación y así en adelante). También es posible que varios programas
pequeños y relacionados entre si se encuentren en el mismo paquete: por
ejemplo, el paquete fileutils contiene varias órdenes de Unix, tales como ls,
cp, etc.

Algunos paquetes requieren de otros para funcionar. En Debian, algunos paquetes
pueden depender de otro, recomendar, sugerir, romper, o entrar en conflicto con
otros paquetes.


* Si un paquete A depende de otro paquete B, entonces B es necesario para que A
  funcione correctamente. Por ejemplo, el paquete gimp depende del paquete gimp-
  data para permitir que el editor gráfico GIMP pueda acceder a sus archivos
  críticos de datos.

* Si un paquete A recomienda otro paquete B, entonces B ofrece una importante
  funcionalidad adicional para A que sería deseable en la mayoría de las
  circunstancias. Por ejemplo, el paquete mozilla-browser recomienda el paquete
  mozilla-psm, que añade la capacidad para la transferencia segura de datos al
  navegador web de Mozilla. Aunque mozilla-psm no es estrictamente necesario
  para que Mozilla funcione, la mayoría de usuarios desearán que Mozilla
  permita la transmisión de datos de manera confidencial (tales como los
  números de una tarjeta de crédito).

* Si un paquete A sugiere otro paquete B, entonces el paquete B ofrece a A una
  funcionalidad que puede que mejore A, pero que no es necesaria en la mayoría
  de los casos. Por ejemplo, el paquete kmail sugiere el paquete gnupg, el cual
  contiene software de cifrado que KMail puede emplear.

* Si un paquete A entra en conflicto con otro paquete B, los dos paquetes no se
  pueden instalar a la vez. Por ejemplo, fb-music-hi entra en conflicto con fb-
  music-low porque ofrecen conjuntos alternativos de sonidos para el juego
  Frozen Bubble.


La labor de un gestor de paquetes es la de presentar una interfaz que asista al
usuario en la tarea de administrar el conjunto de paquetes que están instalados
en su sistema. aptitude proporciona una interfaz que se basa en el sistema de
administración de paquetes apt.


¿Qué es el sistema apt?

Poder instalar y eliminar paquetes está muy bien, pero el software básico que
realiza esta función (conocido como dpkg) hace exactamente esto y nada más.
Esto es suficiente si se descarga uno o dos paquetes a mano, pero enseguida se
convierte en una ardua tarea cuando intenta gestionar un número mayor de
paquetes. Mas aún, si su flamante paquete nuevo requiere software que no ha
instalado previamente, tendrá que descargarse los paquetes requeridos a mano. Y
si después decide eliminar el ya obsoleto software, esos paquetes adicionales
se quedarían en el sistema consumiendo espacio a menos que los elimine
manualmente.

Obviamente, toda esta labor manual es una tarea tediosa, y por ello la mayoría
de sistemas de gestión de paquetes incorporan software que se ocupa de parte o
de toda esta labor por Ud. apt proporciona una base común sobre la que
construir estos programas: además de aptitude, programas tales como synaptic y
apt-watch hacen uso de apt.

apt funciona mediante el registro de una lista de los paquetes que se pueden
descargar desde Debian a su ordenador. Esta lista es útil a la hora de
encontrar los paquetes a actualizar y para instalar paquetes nuevos. apt
también puede resolver problemas de dependencias automáticamente: por ejemplo,
cuando escoja instalar un paquete, encontrará cualquier paquete adicional
requerido e instalará esos también.

Cuando use un gestor de paquetes basado en apt, tales como aptitude, por lo
general realizará tres tareas básicas: actualizar la lista de paquetes que
están disponibles mediante la descarga de listas nuevas desde los servidores de
Debian, seleccionar qué paquetes se deberían instalar, actualizar o eliminar,
y finalmente confirmar sus selecciones llevando a cabo las instalaciones,
eliminaciones, etc.

Los sistemas de gestión de paquetes basados en apt leen la lista de
&#8220;fuentes&#8221; («sources», repositorios de paquetes para Debian) del
archivo /etc/apt/sources.list. El formato y contenido de este archivo están
más allá del alcance de este documento, pero se describen en la página de
manual sources.list(5).


 ¿Como puedo conseguir aptitude?

En el caso de que esté leyendo este manual sin tener aptitude instalado en su
sistema, esta sección le ayudará a corregir esta desafortunada situación. La
mayoría de usuarios deberían leer directamente la sección de paquetes pre-
compilados.


Paquetes pre-compilados de aptitude, o &#8220;lo que el 99% de los usuarios
debería hacer&#8221;.

Los paquetes pre-compilados, o paquetes &#8220;binarios&#8221;, ofrecen la
manera más sencilla y común de instalar aptitude. Solo se debe intentar una
instalación desde las fuentes si los paquetes binarios no están disponibles
por alguna razón, o si tiene necesidades especiales que no cubren los paquetes
binarios.

Si está usando un sistema Debian, ejecute la siguiente orden como root
(administrador): apt-get install aptitude. Si no está usando un sistema Debian,
puede que su proveedor de software haya creado un paquete pre-compilado de
aptitude; puede contactarles para preguntas posteriores si no está seguro.


Construir aptitude desde el código fuente.

También puede construir aptitude desde las fuentes; por otro lado, este no es
un ejercicio útil a menos que tenga apt ya instalado en su sistema. Si lo
está, puede instalar aptitude desde las fuentes mediante los siguientes pasos:


  1. Instalar los siguientes programas:


     * Un compilador C++, por ejemplo g++.

     * Los archivos de desarrollo de apt, que generalmente se encuentran en un
       paquete con un nombre parecido a libapt-pkg-dev.

     * La biblioteca libsigc++-2.0, disponible en el paquete libsigc++-2.0-dev o
       desde http://libsigc.sourceforge.net.

     * La biblioteca cwidget, disponible en el paquete libcwidget-dev o en http:
       //cwidget.alioth.debian.org.

     * El programa gettext, que debería estar incluido en su distribución de
       Linux.

     * Una herramienta make, tal como GNU make.


  2. Por último pero no por ello menos importante, descargue la versión más
     reciente del código fuente, disponible en http://packages.debian.org/
     unstable/admin/aptitude (desplácese hasta la base de la página y
     descargue el archivo &#8220;.orig.tar.gz&#8221;).


Una vez que disponga de todos los componentes necesarios, abra una terminal y
ejecute la orden tar zxf aptitude-0.6.6.tar.gz para desempaquetar el código
fuente. Una vez que haya desempaquetado el código fuente, introduzca cd
aptitude-0.6.6 && ./configure && make para compilar aptitude. Si tiene éxito,
asegúrese de que es el usuario root (usando su, por ejemplo), y después teclee
make install para instalar aptitude en su equipo. Una vez que haya instalado
aptitude con éxito, ejecutar aptitude en una terminal debería iniciar el
programa.


Cómo seguir y participar en el desarrollo de aptitude.


Obtener las fuentes del árbol de desarrollo de aptitude

If you want to test the latest bleeding-edge source code for aptitude, you can
download unreleased aptitude source code using Git. Install Git (available from
http://git-scm.com/) and execute the command git clone git://git.debian.org/git/
aptitude/aptitude.git to retrieve the most recent source code.


 [Aviso]  Aviso

          The aptitude Git repository is an active development tree; it will
          change as bugs are fixed and features are added, and there is
          absolutely no guarantee that it will even compile, let alone run
          properly! Bug reports are welcome, but be aware that you use
          development code entirely at your own risk![1]



Lista de correo

La lista de correo principal para aptitude es <aptitude-
devel@lists.alioth.debian.org>. Los archivos de esta lista se encuentra en http:
//lists.alioth.debian.org/pipermail/aptitude-devel/. Para suscribirse, visite la
página web http://lists.alioth.debian.org/mailman/listinfo/aptitude-devel.


Enviar parches

Preferentemente, los parches se han de enviar a la lista de correo de aptitude
<aptitude-devel@lists.alioth.debian.org>. Pero si prefiere mandarlos a través
de un correo privado, debe hacerlo a <aptitude@packages.debian.org> o a
<dburrows@debian.org>. Apreciaríamos de manera especial una breve descripción
de la motivación que hay detrás de su parche, y una explicación de su
funcionamiento.


Seguir los cambios en el árbol de fuentes de aptitude

The aptitude source tree is regularly updated with new features, bugfixes, and
new bugs. Once the source code is available on your computer (see the previous
section), you can cd into it and type git pull to update it with any changes
made to the main repository.

To automatically receive notifications when changes are made to the aptitude
codebase, subscribe to the Atom feed available at http://anonscm.debian.org/
gitweb/?p=aptitude/aptitude.git;a=atom or RSS feed available at http://
anonscm.debian.org/gitweb/?p=aptitude/aptitude.git;a=rss.


Compilar aptitude desde el árbol de desarrollo

To build aptitude from the Git repository, you must have the programs autoconf
and automake installed. Type sh ./autogen.sh && ./configure to generate the
files needed to compile aptitude, then execute make and make install.



--------------------------------------------------------------------------------
[1]Por supuesto, todo el software libre se emplea bajo la responsabilidad del
usuario, pero el riesgo relacionado con usar un árbol de desarrollo activo es
mucho mayor.


Capítulo 1. Empezar

Tabla de contenidos



  Usar aptitude


        Introducción al uso de aptitude.

        Explorar la lista de paquetes de aptitude.

        Encontrar paquetes por nombre.

        Gestionar paquetes

        Actualizar la lista de paquetes e instalar paquetes.


  Usar aptitude en la línea de órdenes


�  Una travesía de mil millas debe empezar con un solo paso. � 

�                                                     -- Lao Tsu


aptitude es un programa relativamente grande con muchas características, y que
puede presentar ciertas dificultades al usuario a la hora de familiarizarse con
él. Este capítulo no describe de manera exhaustiva las características de
aptitude (véase Capítulo� 2, Guía_de_referencia_de_aptitude para ello), pero
ofrece una presentación de las funciones más básicas y empleadas.


Usar aptitude

Esta sección describe como usar la interfaz gráfica de aptitude. Para
información relacionada con el uso de la interfaz en línea de órdenes de
aptitude, véase &#8220;Usar aptitude en la línea de órdenes&#8221;.


Introducción al uso de aptitude.

Para iniciar aptitude abra su terminal de texto favorita y, en la línea de
órdenes, teclee:

foobar$ aptitude

Once the cache is loaded (this may take some time on slower machines), the main
aptitude screen should appear:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
aptitude 0.2.14.1
--- Paquetes instalados
--- Paquetes no instalados
--- Paquetes obsoletos y creados localmente
--- Paquetes virtuales
--- Tareas






Estos paquetes están instalados en su ordenador.








Como puede ver, la pantalla principal de aptitude está dividida en varias
áreas. La línea azul en la parte superior de la terminal es la barra de menú,
y las líneas inferiores muestran mensajes informativos que describen algunas
órdenes importantes. El espacio negro a continuación es la lista de todos los
paquetes disponibles, en la cual aparecen algunos grupos de paquetes. El grupo
seleccionado (&#8220;Paquetes instalados&#8221;) está resaltado, y su
descripción se muestra en el espacio inferior en negro.

As the top line of the screen suggests, you can access aptitude's menus by
pressing Control+t; you can also click the mouse on a menu title if your system
supports it. Pressing Control+t will open the Actions menu:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
+-------------------------+  u: Actualizar  g: Descarga/Instala/Elimina Paqs
|Instalar/eliminar paquetes g     |
|Actualizar la lista de paquetes u|
|Olvidar paquetes nuevos         f|
|Limpiar el almacén de paquetes   |
|Limpiar ficheros obsoletos       |
|Marcar actualizable             U|
|Jugar al buscaminas              |
|Convertirse en administrador     |
+---------------------------------+
|Salir                           Q|
+---------------------------------+










Realizar todas las instalaciones y eliminaciones pendientes

Use las teclas de dirección e Intro para seleccionar los elementos del menú (o
si su sistema lo permite, pulse sobre ellos con el ratón); para cerrar el menú
sin seleccionar nada, pulse Control+t otra vez. Una descripción del elemento
del menú resaltado aparecerá en la base de la pantalla. Si un elemento del
menú se puede activar mediante un atajo de teclado, el atajo aparecerá en el
menú: por ejemplo, puede ejecutar la orden &#8220;Actualizar la lista de
paquetes&#8221; pulsando u.

En cualquier momento, puede pulsar ? para mostrar una tabla de referencia en
línea con los atajos de teclado disponibles.


Explorar la lista de paquetes de aptitude.

La lista de paquetes es la interfaz primaria de aptitude. Al iniciar aptitude la
lista se organiza en grupos, como puede ver en la siguiente imagen:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
aptitude 0.2.14.1
--- Paquetes instalados
--- Paquetes no instalados
--- Paquetes obsoletos y creados localmente
--- Paquetes virtuales
--- Tareas






Estos paquetes están instalados en su ordenador.









 [Nota]  Nota

         aptitude ocultará automáticamente los grupos de paquetes que estén
         vacíos, así que puede que vea más o menos grupos de los que aparecen
         en esta imagen.


En la captura de pantalla anterior, el primer grupo (&#8220;Paquetes
instalados&#8221;) está resaltado, indicando que está seleccionado en ese
momento. Puede navegar a través de la lista con las flechas de dirección;
observe que la descripción en el campo inferior a la lista de paquetes varía a
medida que navega. Para &#8220;expandir&#8221; un grupo, pulse Intro cuando el
grupo esté resaltado:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menu ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
aptitude 0.2.14.1
--\ Paquetes instalados

  --- admin - Utilidades de administración (instalación de programas, gestión
de usuarios, etc)
  --- devel - Utilidades y programas para desarollo de programas
  --- doc - Documentación y programas especializados para ver documentación
  --- editors - Editores y procesadores de texto
  --- electronics - Programas para trabajar con circuitos y electrónica
  --- games - Juegos, jugetes y programas divertidos
  --- gnome - El sistema de escritorio GNOME
  --- graphics - Utilidades para crear ver y editar ficheros de gráficos

Estos paquetes están instalados en su ordenador.








Como puede ver, el grupo &#8220;Paquetes instalados&#8221; se ha expandido para
mostrar su contenido: contiene un número de sub-grupos, definidos de manera
abierta dependiendo del tipo de software que contienen. Si expandimos la
sección &#8220;admin&#8221; resaltándolo y pulsando Intro, podemos ver:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menu ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
aptitude 0.2.14.1
--\ Paquetes instalados
  --- admin - Utilidades de administración (instalación de programas, gestión
de usuarios, etc)
    ---principal
  --- devel - Utilidades y programas para desarollo de programas
  --- doc - Documentación y programas especializados para ver documentación
  --- editors - Editores y procesadores de texto
  --- electronics - Programas para trabajar con circuitos y electrónica
  --- games - Juegos, jugetes y programas divertidos
  --- gnome - El sistema de escritorio GNOME

Los paquetes en la sección 'admin' permiten realizar tareas de administración
como instalar programas, gestionar los usuarios, configurar y monotorizar tu
sistema,
examinar el tráfico de red, y así sucesivamente.






El grupo &#8220;admin&#8221; contiene un solo sub-grupo, el archivo
&#8220;principal&#8221; («main») de Debian. ¡Si expande este grupo verá
algunos paquetes!


 [Sugerencia]  Sugerencia

               Para ahorrar tiempo, puede usar la tecla [ para expandir todos
               los sub-grupos de un grupo a la vez. Seleccionar &#8220;Paquetes
               instalados&#8221; y pulsar [ revelaría inmediatamente los
               paquetes de la imagen inferior.


 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menu ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
aptitude 0.2.14.1
--\ Paquetes instalados
  --\ admin - Utilidades de administración (instalación de programas, gestión
de usuarios, etc)
    --\ principal
i     acpid                                                1.0.3-19   1.0.3-19
i     alien                                                8.44       8.44
i     anacron                                              2.3-9      2.3-9
i     apt-show-versions                                    0.07       0.07
i A   apt-utils                                            0.5.25     0.5.25
i     apt-watch                                            0.3.2-2    0.3.2-2
i     aptitude                                             0.2.14.1-2 0.2.14.1-2








Además de las flechas de dirección, puede mover la selección a través de la
lista de paquetes mostrando una página de información cada vez usando las
teclas Repág y Avpág.


 [Sugerencia]  Sugerencia

               Cuando hay más información en la zona inferior de la pantalla
               de la que cabe en el espacio disponible, puede emplear las teclas
               a y z para desplazarse a través de la información.



Encontrar paquetes por nombre.

Para encontrar rápidamente un paquete cuyo nombre conoce, pulse / para abrir
una ventana de diálogo de búsqueda:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menu ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
aptitude 0.2.14.1
i     frozen-bubble                                        1.0.0-5    1.0.0-5
i A   frozen-bubble-data                                   1.0.0-5    1.0.0-5
i     geekcode                                             1.7.3-1    1.7.3-1
i     gfpoken                                              0.25-3     0.25-3
i     ggz-gnome-client                                     0.0.7-2    0.0.7-2
i     ggz-gtk-client                                       0.0.7-1    0.0.7-1
i     ggz-gtk-game-data                                    0.0.7-2    0.0.7-2
i +--------------------------------------------------------------------------+
i |Buscar:                                                                   |
i |froz                                                                      |
Po|                             [ Aceptar]                       [ Cancelar ]|
Fr+--------------------------------------------------------------------------+
attempt to shoot bubbles into groups of the same color to cause them to pop. It
features 100 single-player levels, a two-player mode, music and striking
graphics.

This game is widely rumored to be responsible for delaying the Woody release.

URL: http://www.frozen-bubble.org/

Como puede ver en la imagen anterior, una búsqueda de froz encuentra el paquete
frozen-bubble. Es posible encontrar paquetes con criterios complejos usando el
poderoso lenguaje de búsqueda de aptitude, descrito en &#8220;Patrones de
búsqueda&#8221;.


 [Sugerencia]  Sugerencia

               Puede buscar hacia atrás en la lista de paquetes si pulsa \, y
               puede repetir la ultima búsqueda si pulsa n tras cerrar la
               ventana de búsqueda.


A veces es práctico ocultar todos los paquetes excepto aquellos que se
corresponden con un criterio en particular. Para ello, pulse l:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
aptitude 0.2.14.1
--- Paquetes instalados
--- Paquetes no instalados
--- Paquetes obsoletos y creados localmente
--- Paquetes virtuales
--- Tareas


  +--------------------------------------------------------------------------+
  |Introduzca el nuevo límite de árbol de paquetes                           |
  |apti                                                                      |
  |                             [ Aceptar ]                      [ Cancelar ]|
Es+--------------------------------------------------------------------------+








Este dialogo funciona exactamente igual que el dialogo de búsqueda, sólo que
en vez de realzar el siguiente paquete que coincide con lo que ha introducido en
el cuadro de dialogo, oculta todos los paquetes que no lo hacen. Por ejemplo, si
teclea apti y pulsa Intro, ocultará todos los paquetes excepto aquellos cuyo
nombre contiene &#8220;apti&#8221;:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
aptitude 0.2.14.1
--\ Paquetes instalados

  --\ admin - Utilidades de administración (instalación de programas, gestión
de usuarios, etc)
    --\ principal................................................
i     aptitude                                             0.2.14.1-2 0.2.14.1-2
i A   synaptic                                             0.51-1     0.51-1
  --\ x11 - El sistema de ventanas X y programas relacionados
    --\ principal......................
i     xfree86-driver-synaptics                             0.13.3-1   0.13.3-1
--- Paquetes no instalados
--- Paquetes virtuales

Estos paquetes están instalados en su ordenador









Gestionar paquetes

Ahora que sabe navegar a través de la lista de paquetes, es hora de que empiece
a usar aptitude para instalar y eliminar paquetes. En esta sección, aprenderá
como marcar los paquetes para su instalación, eliminación o actualización.


 [Sugerencia]  Sugerencia

               Sólo puede cambiar la configuración del sistema como el usuario
               root. Si quiere experimentar con aptitude, puede iniciarlo de
               manera segura como cualquier otro usuario aparte de como root sin
               dañar el sistema de ninguna manera. aptitude le avisará cuando
               esté intentando hacer algo que sólo el usuario root puede
               hacer, y si desea continuar tendrá que introducir la contraseña
               de root.


Todos los cambios a un paquete se realizan primero, resaltándolo en la lista de
paquetes, y después pulsando la tecla correspondiente a la acción que se
debería realizar. Las teclas de acción básicas [2] son +, para instalar o
actualizar un paquete, - para eliminarlo y = para evitar que un paquete se
actualice automáticamente (esto se conoce como retener el paquete). Estas
acciones no se ejecutan inmediatamente; aptitude simplemente actualiza la lista
de paquetes para mostrar los cambios solicitados.

For instance, in the screen shot below, the kaffeine-mozilla package was
selected and + was pushed. The package is now highlighted in green and the
letter &#8220;i&#8221; has appeared to the left of its name, to indicate that it
will be installed; in addition, an estimate of the amount of space that the
package will use is displayed.

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
aptitude 0.2.14.1                  Se usará 2925kB del TamDes: 1375kB
  --\ kde - El sistema de escritorio KDE
    --\ principal
p     bibletime-i18n                                        <none>     1.4.1-1
p     education-desktop-kde                                 <none>     0.771
p     junior-kde                                            <none>     1.4
piA   kaffeine                                      +2843kB <none>     0.4.3-1
pi    kaffeine-mozilla                              +81.9kB <none>     0.4.3-1
p     karamba                                               <none>     0.17-5
p     kde-devel                                             <none>     4:3.1.2

p     kde-devel-extras                                      <none>     4:3.1.2
El sistema de escritorio K(utilidades para desarrollo de programas)
A metapackage containing dependencies for the core development suite of KDE
including kdesdk, qt3-designer, and all core KDE -dev packages.








 [Sugerencia]  Sugerencia

               En cualquier momento puede usar Deshacer ->; Deshacer
               (Control+u) para &#8220;deshacer&#8221; cualquier cambio
               realizado a uno o más paquetes. Esto es bastante útil en caso
               de que una acción tenga consecuencias inesperadas y desee
               &#8220;revertir&#8221; los paquetes a su estado anterior.


Aparte de las acciones que afectan a los paquetes de manera individual, hay
disponible otra acción importante: pulsar U actualiza cualquier paquete que
tenga una nueva versión. Debería utilizar esta orden de manera regular para
mantener su sistema siempre actualizado.


Gestionar paquetes rotos

A veces, cambiar el estado de un paquete puede causar que ciertos requisitos
entre dependencias queden incumplidas; los paquetes con dependencias no
resueltas se denominan rotos. aptitude le avisará cuando esto ocurra y
describirá lo ocurrido. Por ejemplo, esto es lo que pasa si intento eliminar
sound-juicer:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
aptitude 0.3.3       #Roto: 1   Se liberará 48.6MB de espacio del TamDesc
i A   nautilus                                             2.10.1-4   2.10.1-4
i     nautilus-cd-burner                                   2.10.2-1.1 2.10.2-1.1
i A   nautilus-data                                        2.10.1-4   2.10.1-4
i     netspeed                                             0.12.1-1   0.12.1-1
i A   oaf                                                  0.6.10-3   0.6.10-3
i     pybliographer                                        1.2.6.2-1  1.2.6.2-1
i     rhythmbox                                            0.8.8-13   0.8.8-13
i     shermans-aquarium                                    3.0.1-1    3.0.1-1
idA   sound-juicer                                 -1733kB 2.10.1-3   2.10.1-3
GNOME 2 CD Ripper
sound-juicer se eliminará.


Los siguientes dependen de sound-juicer y se romperán debido a su eliminación:


  * gnome-desktop-environment depende de sound-juicer

[1(1)/...] Sugiere 1 instalación
e: Examinar  !: Aplicar  .: Siguiente  ,: Anterior

Como puede ver, aptitude muestra tres indicadores de que algo ha ido mal:
primero, el número de paquetes rotos se muestra en el área azul superior;
segundo, la mitad inferior de la pantalla cambia para mostrar los paquetes rotos
relacionados con el paquete seleccionado en ese momento; tercero, en la base de
la pantalla aparece una barra con una sugerencia de cómo solucionar el
problema. Para encontrar con rapidez paquetes rotos en la lista de paquetes
puede pulsar b o realizar una búsqueda de ?broken.


 [Nota]  Nota

         El texto [1(1)/...] indica el progreso del solucionador de dependencias
         de aptitude. El primer número es la solución que está seleccionada
         en ese momento, y el segundo es el numero de soluciones que aptitude ha
         generado. La presencia del texto &#8220;...&#8221; indica que pueden
         existir algunas soluciones adicionales más allá de las generadas; si
         aptitude estuviese seguro de haber generado la única solución
         posible, este indicador mostraría [1/1].


Para ver más información de cómo aptitude piensa que puede solucionar este
problema, pulse e. Aparecería una pantalla similar a la siguiente:

  Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
                Paquetes                          Resolver las dependencias
  --\ Mantener los paquetes siguientes en la versión actual:
    gstreamer0.8-cdparanoia                           [0.8.10-1 (unstable, now)]
    sound-juicer                                                [2.10.1-2 (now)]
















[1(1)/...] Sugiere 2 mantenidos
e: Examinar  !: Aplicar  .: Siguiente  ,: Anterior

A partir de aquí puede ver más soluciones si pulsa «.», o volver a las
soluciones previamente examinadas si pulsa «,». Para aplicar la solución
seleccionada en ese momento y volver a la lista de paquetes, pulse !. Por
ejemplo, si pulsase «.» en la pantalla anterior, se le presentaría la
siguiente solución:

  Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
                Paquetes                          Resolver dependencias
  --\ Mantener los paquetes siguientes en la versión actual::
    sound-juicer                                      [2.10.1-3 (unstable, now)]
  --\ Desactualizar los paquetes siguientes:
    gstreamer0.8-cdparanoia          [0.8.11-1 unstable, now -> 0.8.8-3 testing]















[2(2)/...] Sugiere 1 mantenido,1 desactualización
e: Examine  !: Apply  .: Next  ,: Previous

Además de las órdenes básicas disponibles cuando examina las soluciones,
puede pulsar r para &#8220;rechazar&#8221; las acciones que desapruebe. Por
ejemplo, la primera solución cancelaría la eliminación de sound-juicer
¡precisamente la acción que intentaba ejecutar! Si pulsa r sobre el espacio
correspondiente a esta acción, le diría a aptitude que no debería cancelar la
eliminación de sound-juicer de esta manera.

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
                Paquetes                          Resolver dependencias
  --\ Mantener los paquetes siguientes en la versión actual:
    gstreamer0.8-cdparanoia                           [0.8.11-1 (unstable, now)]
R   sound-juicer                                      [2.10.1-3 (unstable, now)]






GNOME 2 CD Ripper
gnome-desktop-environment depende de sound-juicer
--\ Las acciones siguientes resolverán estas dependencias:
  -> Eliminar gnome-desktop-environment [1:2.10.2.3 (unstable, testing, now)]
R -> Cancelar la eliminación de sound-juicer
  -> Desactualizar sound-juicer [2.10.1-3 (unstable, now) -> 0.6.1-2 (testing)]




[1(1)/...] Sugiere 2 mantenidos
e: Examine  !: Apply  .: Next  ,: Previous

Como puede ver, el elemento de la lista correspondiente a la acción de mantener
la misma versión de sound-juicer se ha vuelto roja y marcada con una
&#8220;R&#8221;, indicando que se ha rechazado. Las soluciones que pudiese
generar en el futuro (esto es, cualquier solución que no haya examinado aún)
no incluirían esta acción, aunque seguirían disponibles las soluciones
previamente generadas y que contienen esta solución.


 [Nota]  Nota

         En la captura de pantalla anterior, se puede ver una descripción de
         sound-juicer, el cual se muestra en el centro de la pantalla; bajo esta
         descripción puede ver la dependencia que causó que sound-juicer se
         haya mantenido en su versión actual, además de todas las maneras que
         aptitude conoce para resolver esta dependencia.


Por ejemplo, si este rechazo (a una solución) se impone inmediatamente después
de intentar eliminar sound-juicer, pulsar . nos llevaría a la siguiente
solución, omitiendo la solución que cancela la instalación de sound-juicer y
que desactualiza gstreamer0.8-cdparanoia.

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
                Paquetes                          Resolver las dependencias
  --\ Eliminar los paquetes siguientes:
    gnome-desktop-environment              [1:2.10.2.3 (unstable, testing, now)]

















[2(2)/...] Sugiere 1 eliminación
e: Examinar  !: Aplicar  .: Siguiente  ,: Anterior

Los rechazos solo se aplican a las soluciones generadas en el momento: esto es,
las soluciones generadas al pulsar «.» mientras visiona la última solución
generada. Las soluciones generadas anteriormente pueden aún contener rechazos a
ciertas acciones. Puede cancelar un rechazo en cualquier momento si selecciona
una vez más la acción rechazada y pulsa r; esto permitiría que se generen
otra vez las soluciones que contienen la acción rechazada, incluyendo cualquier
solución que haya &#8220;omitido&#8221; con anterioridad.

La contrario a rechazar una acción es aprobarla. Para aprobar una acción
simplemente seleccione la acción y presione a; esto forzaría al solucionador
de problemas a escoger esta acción cuando sea posible[3]. Las acciones
aprobadas se volverán verdes y se marcarán con &#8220;A&#8221;, como puede ver
en la siguiente imagen:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
                Paquetes                          Resolver las dependencias
  --\ Eliminar los paquetes siguientes:
    gnome-desktop-environment              [1:2.10.2.3 (unstable, testing, now)]

















[2(2)/...] Sugiere 1 eliminación
e: Examinar  !: Aplicar  .: Siguiente  ,: Anterior


 [Importante]  Importante

               Si no resuelve ninguna dependencia rota, aptitude llevará a cabo
               su sugerencia actual automáticamente cuando confirme al pulsar g
               las selecciones que haya hecho. Por otro lado, es difícil
               resolver automáticamente los problemas de dependencias, y puede
               que no le guste el resultado final. Por ello, es siempre mejor
               observar lo que aptitude ha planeado hacer antes de llevar a cabo
               los cambios.



Actualizar la lista de paquetes e instalar paquetes.

En este momento, ya sabe lo suficiente acerca de aptitude como para llevar a
cabo modificaciones en el sistema.

Debería actualizar periódicamente su lista de paquetes disponibles desde los
servidores de Debian para estar al tanto de paquetes nuevos y de versiones
nuevas de paquetes. Para ello, pulse u. Puede interrumpir la descarga en
cualquier momento pulsando q.

Una vez que tenga una lista actualizada de los paquetes, puede elegir qué
paquetes se actualizarán, instalarán o eliminarán, como se ha descrito en
sección anterior. Al instalar el paquete kaffeine-mozilla (del ejemplo
anterior), se nos presenta la siguiente pantalla:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
aptitude 0.2.14.1                  Se usará 2925kB de espacio TamDesc: 1375kB
--\ Paquetes automáticamente instalados para satisfacer las dependencias

piA kaffeine                                        +2843kB <none>     0.4.3-1
--\ Paquetes a instalar
pi  kaffeine-mozilla                                +81.9kB <none>     0.4.3-1







Estos paquetes se instalarán porque algún paquete seleccionado para
instalar los necesita.

Si selecciona un paquete, en este espacio aparecerá una explicación de su
estado actual.




Como puede ver, aptitude decidió de manera automática instalar kaffeine en mi
sistema porque kaffeine-mozilla lo necesita. En este momento, puedo escoger
entre continuar con la instalación, pulsando g, o cancelarla, pulsando q.


Usar aptitude en la línea de órdenes

Además de la interfaz &#8220;gráfica&#8221; descrita en la sección anterior,
también puede usar aptitude desde la línea de órdenes de la misma manera que
usaría apt-get. Esta sección cubre las órdenes en línea de órdenes más
comunes; para más información, véase la guia de referencia en la línea de
órdenes de aptitude.

En general, invocar una orden de aptitude en la línea de órdenes presenta este
aspecto:

aptitude acción [argumentos...]

La acción indica a aptitude qué acción realizar; los argumentos restantes se
emplean de una manera específica dependiendo de la opción deseada. En líneas
generales, consisten de nombres de paquetes y de diferentes opciones en la
línea de órdenes[4].

Las acciones más importantes son:



  aptitude update

      Esta orden actualiza la lista de paquetes, al igual que si el usuario
      ejecuta la interfaz gráfica y pulsa u.


  aptitude safe-upgrade

      Esta orden actualiza tantos paquetes como sea posible sin eliminar
      paquetes ya existentes en el sistema.

      Algunas veces es necesario eliminar un paquete para poder actualizar otro;
      esta orden no es capaz de actualizar paquetes en tales situaciones. Use la
      orden full-upgrade para actualizar también esos paquetes.


  aptitude full-upgrade

      Al igual que safe-upgrade, esta orden llevaría a cabo una actualización
      de paquetes, pero es más agresiva a la hora de resolver los problemas de
      dependencias: instalará y eliminará paquetes hasta que todas las
      dependencias estén resueltas. Debido a la naturaleza de esta orden es
      probable que realice acciones no deseadas, y por lo tanto debería ser
      cuidadoso a la hora de emplearlo.


       [Nota]  Nota

               Por razones históricas, esta orden se llamaba originalmente
               dist-upgrade, y aptitude aún reconoce este nombre.



  aptitude [ install | remove | purge ] paq1 [paq2...]

      Estas órdenes instalan, eliminan o purgan [5] los paquetes especificados.
      &#8220;Instalar&#8221; un paquete que ya lo está pero susceptible de ser
      actualizado hará que éste se actualice.


  aptitude search patrón1 [patrón2...]

      Esta orden busca paquetes cuyo nombre contenga cualquiera de los
      patrónes, mostrando el resultado en la terminal. Además de ser una
      cadena de texto, cada patrón puede ser un patrón de búsqueda tal y como
      se describe en &#8220;Patrones de búsqueda&#8221;. [6]Por ejemplo,
      &#8220;aptitude search gnome kde&#8221; mostraría todos los paquetes cuyo
      nombre contenga &#8220;gnome&#8221; o &#8220;kde&#8221;.


  aptitude show paq1 [paq2...]

      Mostrar información sobre cada paq (paquete) en la terminal.


Todas las órdenes que instalan, actualizan o eliminan paquetes aceptan el
parámetro -s, que simboliza &#8220;simular&#8221;. Cuando se introduce -s en la
línea de órdenes el programa realiza todas las acciones que haría
normalmente, pero en la práctica no descarga, instala o elimina ningún
archivo.

A veces, aptitude nos presentará un dialogo como este:

Se instalarán automáticamente los siguientes paquetes NUEVOS:
  space-orbit-common
Se instalarán los siguiente paquetes NUEVOS:
  space-orbit space-orbit-common
0 paquetes actualizados, 2 nuevos instalados, 0 para eliminar y 0 sin
actualizar.
Necesito descargar 3200kB de ficheros. Después de desempaquetar se usarán
8413kB
¿Quiere continuar? [Y/n/?]

Además de las obvias opciones &#8220;Yes&#8221; y &#8220;No&#8221;, dispone de
un número de órdenes que puede usar para cambiar la información mostrada, o
para especificar futuras acciones. Por ejemplo, pulsar s muestra u oculta
información acerca del espacio que cada paquete usará:

¿Quiere continuar? [Y/n/?] s

Se mostrarán los tamaños de los cambios.

Se instalarán automáticamente los siguientes paquetes NUEVOS:
  space-orbit-common <+8020kB>
Se instalarán los siguiente paquetes NUEVOS:
  space-orbit <+393kB> space-orbit-common <+8020kB>
0 paquetes actualizados, 2 nuevos instalados, 0 para eliminar y 0 sin
actualizar.
Necesito descargar 3200kB de ficheros. Después de desempaquetar se usarán
8413kB
¿Quiere continuar? [Y/n/?]

De manera similar, pulsar d mostrará información acerca de paquetes
automáticamente instalados o eliminados:

Se instalarán automáticamente los siguientes paquetes NUEVOS:
  space-orbit-common (D: space-orbit)
Se instalarán los siguiente paquetes NUEVOS:
  space-orbit space-orbit-common
0 paquetes actualizados, 2 nuevos instalados, 0 para eliminar y 0 sin
actualizar.
Necesito descargar 3200kB de ficheros. Después de desempaquetar se usarán
8413kB

Esto muestra que space-orbit-common se instalará porque space-orbit depende de
él. Puede ver la lista entera de posibles entradas pulsando ? en el diálogo.

aptitude le preguntará qué hacer si su petición rompe dependencias de una
manera que no se pueda resolver de una forma sencilla:

Los siguientes paquetes están ROTOS:
  libsdl1.2debian
Se ELIMINARÁN los siguientes paquetes:
  libsdl1.2debian-alsa
.
.
.
Las acciones siguientes resolverán estas dependencias:

Instalar los paquetes siguientes:
libsdl1.2debian-all [1.2.12-1 (unstable)]

La puntuación es 41

¿Acepta esta solución? [Y/n/q/?]

Pulsar y (o simplemente Intro) aceptará la solución propuesta. Si pulsa n
verá la &#8220;siguiente mejor&#8221; solución:

¿Acepta esta solución? [Y/n/q/?] n
Las acciones siguientes resolverán estas dependencias:

Instalar los paquetes siguientes:
libsdl1.2debian-esd [1.2.12-1 (unstable)]

Score is 19

¿Acepta esta solución? [Y/n/q/?]

Al igual que en la línea de órdenes, puede realizar un número de acciones
adicionales incluyendo alterar manualmente el estado de los paquetes desde, el
dialogo de resolución de conflictos. Pulse ? para ver una lista completa.

Si pulsa q, cancelaría el solucionador automático y le permitiría resolver
las dependencias manualmente:

¿Acepta esta solución? [Y/n/q/?] q
aptitude no pudo encontrar una solución a estas dependencias. Puede solucionar
estas dependencias manualmente o pulsar «n» para salir
No se satisfacen las dependencias de los siguientes paquetes:
  libsdl1.2debian: Depende de: libsdl1.2debian-alsa (= 1.2.12-1) pero no es
instalable o
                            libsdl1.2debian-all (= 1.2.12-1) pero no es
instalable o
                            libsdl1.2debian-esd (= 1.2.12-1) pero no es
instalable o
                            libsdl1.2debian-arts (= 1.2.12-1) pero no es
instalable o
                            libsdl1.2debian-oss (= 1.2.12-1) pero no es
instalable o
                            libsdl1.2debian-nas (= 1.2.12-1) pero no es
instalable o
                            libsdl1.2debian-pulseaudio (= 1.2.12-1) pero no es
instalable
¿Desea resolver las dependencias manualmente? [N/+/-/_/:/?]

Puede usar cualquiera de las órdenes de gestión de paquetes para resolver las
dependencias rotas (pulse ? para una lista completa de las órdenes
disponibles). Pulse n o Intro para salir de aptitude:

¿Desea resolver las dependencias manualmente? [N/+/-/_/:/?] n
Cancela.

Para una completa documentación acerca de las características de aptitude en
la línea de órdenes, véase Referencia de la línea de órdenes.



--------------------------------------------------------------------------------
[2] También puede cambiar el estado de los paquetes usando el menú Paquete;
véase &#8220;El menú Paquete&#8221; para más detalles.

[3] Aprobar una acción es ligeramente distinto a requerir que todas las
soluciones contengan esa acción; lo que esto significa es que si se da una
elección entre una acción aprobada y una no aprobada, el solucionador siempre
escogerá la acción aprobada. Si se pueden aplicar varias acciones aprobadas,
todas ellas serán candidatas a ser presentadas en la solución.

[4]Una &#8220;opción&#8221; es una letra precedida de un guión: por ejemplo,
&#8220;-a&#8221;, &#8220;-v&#8221;, etc.

[5]Purgar un paquete elimina el paquete, así como también sus archivos de
configuración.

[6] De hecho, lo mismo sirve para las órdenes que toman paquetes como
argumentos, tales como install o show.


Capítulo 2. Guía de referencia de aptitude

Tabla de contenidos



  La interfaz de usuario de aptitude en la terminal


        Usar los menús.

        Órdenes del menú.

        Trabajar con varias vistas.

        Convertirse en root.


  Gestionar paquetes


        Gestionar la lista de paquetes.

        Acceso a la información de los paquetes.

        Modificar los estados de los paquete.

        Descargar, instalar y eliminar paquetes.

        Llaves GPG: Entender y gestionar la confianza de los paquetes.

        Gestionar paquetes automáticamente instalados.


  Resolver las dependencias de los paquetes


        Resolución de dependencias de aptitude.

        Resolución inmediata de dependencias.

        Resolver dependencias de manera interactiva.

        Costs in the interactive dependency resolver

        Configurar el solucionador interactivo de dependencias.


  Patrones de búsqueda


        Buscar cadenas de caracteres.

        Abreviaturas de términos de búsqueda.

        Búsquedas y versiones.

        Objetivos explícitos de búsqueda.

        Referencia de los términos de búsqueda.


  Personalizar aptitude


        Personalizar la lista de paquetes.

        Personalizar teclas rápidas.

        Personalizar los colores del texto y estilos.

        Personalizar el diseño de la interfaz.

        Referencia del archivo de configuración.

        Temas.


  Jugar al Buscaminas


�  El Conejo Blanco se puso las gafas. 'Por favor, ¿por donde podría yo     � 
   empezar, Su Majestad? preguntó.

   'Empieza por el principio' dijo el Rey con gravedad, 'y continua hasta que
   llegues al final: entonces, para.'

�                          -- Lewis Carrol, Alicia en el país de las Maravillas


aptitude es un programa extenso con varias características, y algunas veces es
difícil recordar como hacer alguna operación, o incluso si es posible. De
hecho, muchas de las peticiones que llegan al autor acerca de la implementación
de más características describen características ya presentes, pero
difíciles de encontrar.[7]

En un intento de combatir esta oscuridad, esta guía de referencia describe
todas las capacidades y parámetros de configuración de aptitude, véase
Capítulo� 1, Empezar.


 [Nota]  Nota

         Puede configurar el comportamiento y la apariencia de aptitude de
         varias maneras. Este manual describe el funcionamiento del programa con
         las opciones predeterminadas; las descripciones de las múltiples
         opciones que afectan al comportamiento se detallan en
         &#8220;Personalizar aptitude&#8221;.



La interfaz de usuario de aptitude en la terminal

Esta sección describe las partes que componen la interfaz de usuario de
aptitude en la terminal no relacionadas con gestionar paquetes.


Usar los menús.

La barra de menú en la parte superior de la pantalla contiene las órdenes mas
importantes de aptitude. Para activar la barra de menú, pulse Control+t; ahora
puede navegar a través de él seleccionando cualquier elemento del menú usando
Intro.

Algunos elementos del menú son accesibles a través de &#8220;teclas de acceso
directo&#8221;: números o letras que se pueden emplear para seleccionar la
entrada mientras el menú está activo. Estos atajos se muestran en un color mas
claro que el del resto del menú.

Además, algunos elementos del menú poseen &#8220;atajos&#8221;: combinaciones
de teclas que ejecutan la misma acción que la entrada de menú mientras no
está activo. Dispone de una lista de estos atajos en el lado derecho del menú.

De aquí en adelante, las órdenes de menú se escribirán así:Menú ->;
Entrada (tecla). Esto indica que debería escoger la Entrada del Menú menú, y
esa tecla/s es el atajo para esa orden.


Órdenes del menú.


El menú Acciones.

Figura 2.1. Órdenes disponibles en el menú Acciones.

 ______________________________________________________________________________
|Orden                                 |Descripción                           |
|______________________________________|_______________________________________|
|                                      |Si no hay una previsualización        |
|                                      |disponible, muestra una; de no ser     |
|Acciones ->; Instalar/eliminar    |así, ejecuta un proceso de            |
|paquetes (g)                          |instalación tal y como se describe en |
|                                      |&#8220;Descargar, instalar y eliminar  |
|                                      |paquetes.&#8221;.                      |
|______________________________________|_______________________________________|
|Acciones ->; Actualizar la lista  |Actualizar la lista de paquetes.       |
|de paquetes (u)                       |                                       |
|______________________________________|_______________________________________|
|                                      |Marcar todos los paquetes              |
|Acciones ->; Marcar actualizable  |actualizables, excepto aquellos que    |
|(U)                                   |estén prohibidos o bloqueados para su |
|                                      |actualización.                        |
|______________________________________|_______________________________________|
|                                      |Descartar toda la información         |
|Acciones ->; Olvidar paquetes     |referente a qué paquetes son          |
|nuevos (f)                            |&#8220;nuevos&#8221; (vacía el árbol |
|                                      |&#8220;Paquetes nuevos&#8221;).        |
|______________________________________|_______________________________________|
|                                      |Cancelar toda instalación,            |
|                                      |eliminación, actualización y         |
|Acciones ->; Cancelar acciones    |retención pendiente. Es el equivalente|
|pendientes                            |a ejecutar la orden Keep sobre cada    |
|                                      |paquete en la base de datos de         |
|                                      |paquetes.                              |
|______________________________________|_______________________________________|
|Actions ->; Limpiar el almacén de|Eliminar todos los paquetes comprimidos|
|paquetes                              |que aptitude ha descargado [a].        |
|______________________________________|_______________________________________|
|                                      |Eliminar cualquier paquete comprimido  |
|                                      |que aptitude descargó [a] y que ya no |
|Acciones ->; Limpiar ficheros     |están disponibles. Se asume que estos |
|obsoletos                             |paquetes ya están obsoletos, y se     |
|                                      |pueden eliminar del disco duro sin     |
|                                      |precisar de una descarga que por otro  |
|                                      |lado sería inútil.                   |
|______________________________________|_______________________________________|
|                                      |Jugar al Buscaminas, tal y como se     |
|Acciones ->; Jugar al buscaminas  |describe en &#8220;Jugar al            |
|                                      |Buscaminas&#8221;.                     |
|______________________________________|_______________________________________|
|Acciones ->; Convertirse en       |Continuar trabajando como el usuario   |
|administrador                         |root, véase &#8220;Convertirse en     |
|                                      |root.&#8221;.                          |
|______________________________________|_______________________________________|
|Acciones ->; Salir (Q)            |Cerrar aptitude guardando cualquier    |
|                                      |cambio hecho al estado de los paquetes.|
|______________________________________|_______________________________________|
|[a] O cualquier otra herramienta de apt.                                      |
|______________________________________________________________________________|




El menú Deshacer

Figura 2.2. Órdenes disponibles en el menú Deshacer.

 ______________________________________________________________________________
|Orden                                |Descripción                            |
|_____________________________________|________________________________________|
|                                     |Cancelar el efecto del ultimo cambio    |
|                                     |realizado al estado de un paquete hasta |
|Deshacer ->; Deshacer (Control+u)|el punto en que aptitude se inició, la |
|                                     |lista de paquetes se ha actualizado o en|
|                                     |el que un proceso de instalación se    |
|                                     |llevó a cabo.                          |
|_____________________________________|________________________________________|




El menú Paquete

Figura 2.3. Órdenes disponibles en el menú Paquete.

 ______________________________________________________________________________
|Orden                                 |Descripción                           |
|______________________________________|_______________________________________|
|Paquete ->; Instalar (+)          |Marcar el paquete seleccionado para su |
|                                      |instalación.                          |
|______________________________________|_______________________________________|
|Paquete ->; Eliminar (-)          |Marcar el paquete seleccionado para su |
|                                      |eliminación.                          |
|______________________________________|_______________________________________|
|Paquete ->; Purgar (_)            |Marcar el paquete seleccionado para que|
|                                      |sea purgado.                           |
|______________________________________|_______________________________________|
|                                      |Cancelar toda instalación,            |
|                                      |actualización o eliminación pendiente|
|Paquete ->; Mantener (:)          |de ejecución sobre el paquete         |
|                                      |seleccionado, y eliminar cualquier     |
|                                      |retención impuesta al paquete.        |
|______________________________________|_______________________________________|
|Paquete ->; Retener (=)           |Retener el paquete seleccionado.       |
|______________________________________|_______________________________________|
|                                      |Marcar al paquete instalado como       |
|                                      |&#8220;automáticamente                |
|Paquete ->; Marcar automático (M)|instalado&#8221;. Para más            |
|                                      |información, véase &#8220;Gestionar  |
|                                      |paquetes automáticamente              |
|                                      |instalados.&#8221;.                    |
|______________________________________|_______________________________________|
|                                      |Marcar el paquete seleccionado como    |
|                                      |&#8220;manualmente instalado&#8221;.   |
|                                      |Para más información referente a     |
|Paquete ->; Marcar manual (m)     |paquetes manual y automáticamente     |
|                                      |instalados, véase &#8220;Gestionar    |
|                                      |paquetes automáticamente              |
|                                      |instalados.&#8221;.                    |
|______________________________________|_______________________________________|
|                                      |Si se selecciona un paquete susceptible|
|                                      |de ser actualizado, prohíbe que se    |
|Paquete ->; Prohibir versiones (F)|actualice a la versión disponible en  |
|                                      |el servidor. Si selecciona la versión |
|                                      |de un paquete, prohíbe que el paquete |
|                                      |se actualice a esa versión.           |
|______________________________________|_______________________________________|
|                                      |Mostrar una pantalla que contiene      |
|                                      |información acerca del paquete        |
|Paquete ->; Información (enter)  |seleccionado, tales como de qué       |
|                                      |paquetes depende, así como qué       |
|                                      |paquetes dependen de él, y las        |
|                                      |diferentes versiones disponibles.      |
|______________________________________|_______________________________________|
|                                      |Cuando explora la lista de paquetes,   |
|                                      |varía la información que puede ver en|
|                                      |el área de información (la mitad     |
|                                      |inferior de la pantalla). El área de  |
|Paquete ->; Recorrer información |información puede mostrar una larga   |
|de paquetes (i)                       |descripción del paquete seleccionado  |
|                                      |(predeterminado), un resumen de las    |
|                                      |dependencias relacionadas con ese      |
|                                      |paquete o un análisis de qué otros   |
|                                      |paquetes requieren o sugieren el       |
|                                      |paquete seleccionado.                  |
|______________________________________|_______________________________________|
|                                      |Mostrar el registro de cambios de      |
|Paquete ->; Registro de cambios   |Debian del paquete seleccionado. Para  |
|(C)                                   |ver el registro de cambios de una      |
|                                      |versión en particular, seleccione la  |
|                                      |versión y ejecute esta orden.         |
|______________________________________|_______________________________________|




El menú Solucionador

Figura 2.4. Órdenes disponibles en el menú Solucionador.

 ______________________________________________________________________________
|Orden                                 |Descripción                           |
|______________________________________|_______________________________________|
|                                      |Mostrar una detallada descripción de  |
|Solucionador ->; Examinar         |la acción sugerida por el solucionador|
|solución (e)                         |(véase &#8220;Resolver dependencias de|
|                                      |manera interactiva.&#8221;).           |
|______________________________________|_______________________________________|
|Solucionador ->; Aplicar Solución|Llevar a cabo las acciones sugeridas   |
|(!)                                   |por el solucionador.                   |
|______________________________________|_______________________________________|
|Solucionador ->; Solución        |Seleccionar la siguiente sugerencia del|
|siguiente (.)                         |solucionador.                          |
|______________________________________|_______________________________________|
|Solucionador ->; Solución        |Seleccionar la anterior sugerencia del |
|anterior (,)                          |solucionador.                          |
|______________________________________|_______________________________________|
|Solucionador ->; Primera solución|Seleccionar la primera sugerencia del  |
|(<)                                   |solucionador.                          |
|______________________________________|_______________________________________|
|                                      |Seleccionar la última solución       |
|Solucionador ->; Última solución|generada por el solucionador (véase   |
|(>)                                   |&#8220;Resolver dependencias de manera |
|                                      |interactiva.&#8221;).                  |
|______________________________________|_______________________________________|
|                                      |Cuando examina una solución, conmuta  |
|                                      |si rechaza o no la acción             |
|Solucionador ->; Conmutar         |seleccionada, pasando después a la    |
|Rechazados (r)                        |siguiente acción (véase              |
|                                      |&#8220;Resolver dependencias de manera |
|                                      |interactiva.&#8221;). Si la acción ya |
|                                      |se aprobó, queda cancelada.           |
|______________________________________|_______________________________________|
|                                      |Cuando examina una solución, conmuta  |
|                                      |si la acción seleccionada se aprueba o|
|Solucionador ->; Conmutar Aceptada|no, y pasa a la siguiente acción      |
|(a)                                   |(véase &#8220;Resolver dependencias de|
|                                      |manera interactiva.&#8221;). Si la     |
|                                      |acción ya se rechazó, esta queda     |
|                                      |cancelada.                             |
|______________________________________|_______________________________________|
|                                      |Cuando examina una solución, muestra  |
|                                      |información detallada acerca del      |
|Solucionador ->; Ver objetivo     |paquete afectado por la acción        |
|(enter)                               |seleccionada (véase &#8220;Resolver   |
|                                      |dependencias de manera                 |
|                                      |interactiva.&#8221;).                  |
|______________________________________|_______________________________________|
|                                      |Rechazar (al igual que con Solucionador|
|                                      |->; Conmutar Rechazados (r)) todas |
|                                      |las acciones que rompen una retención |
|Solucionador ->; Rechazar romper  |o que instalan una versión prohibida. |
|bloqueos                              |De manera predeterminada, estas        |
|                                      |acciones se rechazan a menos que defina|
|                                      |Aptitude::ProblemResolver::Allow-Break-|
|                                      |Holds como true.                       |
|______________________________________|_______________________________________|




El menú Buscar

Figura 2.5. Órdenes disponibles en el menú Buscar.

 ______________________________________________________________________________
|Orden                                 |Descripción                           |
|______________________________________|_______________________________________|
|                                      |Buscar el siguiente paquete en la lista|
|Buscar ->; Buscar (/)             |de paquetes que coincida con el patrón|
|                                      |de búsqueda (véase &#8220;Patrones de|
|                                      |búsqueda&#8221;).                     |
|______________________________________|_______________________________________|
|                                      |Buscar el paquete anterior en la lista |
|Buscar ->; Buscar hacia atrás (\)|de paquetes que coincida con el patrón|
|                                      |de búsqueda (véase &#8220;Patrones de|
|                                      |búsqueda&#8221;).                     |
|______________________________________|_______________________________________|
|Buscar ->; Buscar otra vez (n)    |Repetir la última búsqueda.          |
|______________________________________|_______________________________________|
|                                      |Repetir la última búsqueda, pero en  |
|                                      |dirección opuesta. Si la última orden|
|Buscar ->; Buscar de nuevo hacia  |de búsqueda empleada fue «Buscar     |
|atrás (N)                            |hacia atrás», esta orden ejecutaría |
|                                      |una búsqueda hacia delante, y         |
|                                      |viceversa.                             |
|______________________________________|_______________________________________|
|                                      |Filtrar la lista de paquetes eliminando|
|Buscar ->; Limitar vista (l)      |cualquier paquete que no coincida con  |
|                                      |el patrón de búsqueda (véase        |
|                                      |&#8220;Patrones de búsqueda&#8221;).  |
|______________________________________|_______________________________________|
|Buscar ->; No limitar vista       |Eliminar el filtro del paquete actual  |
|                                      |(todos los paquetes serán visibles).  |
|______________________________________|_______________________________________|
|Buscar ->; Buscar Roto (b)        |Buscar el siguiente paquete roto. Ésto|
|                                      |equivale a buscar ?broken.             |
|______________________________________|_______________________________________|




El menú Opciones

Figura 2.6. Órdenes disponibles en el menú Opciones.

 ______________________________________________________________________________
|Orden                             |Descripción                               |
|__________________________________|___________________________________________|
|                                  |Abrir una vista de nivel superior en la    |
|                                  |cual puede modificar los parámetros de    |
|                                  |aptitude. Las opciones de configuración se|
|                                  |organizan en árbol, similar al árbol de  |
|Opciones ->; Preferencias     |paquetes; para activar o desactivar una    |
|                                  |opción, selecciónela y pulse Espacio o   |
|                                  |Intro. Las opciones de configuración se   |
|                                  |guardan en ~/.aptitude/config en el mismo  |
|                                  |momento de su selección.                  |
|__________________________________|___________________________________________|
|Opciones ->; Deshacer opciones|Devolver todas las opciones a sus valores  |
|                                  |predeterminados.                           |
|__________________________________|___________________________________________|




El menú Vistas


 [Nota]  Nota

         Para una introducción al funcionamiento de las vistas, véase
         &#8220;Trabajar con varias vistas.&#8221;.


Figura 2.7. Órdenes disponibles en el menú Vistas.

 ______________________________________________________________________________
|Orden                                 |Descripción                           |
|______________________________________|_______________________________________|
|Vistas ->; Siguiente (F6)         |Pasar a la siguiente vista activa.     |
|______________________________________|_______________________________________|
|Vistas ->; Prev (F7)              |Pasar a la anterior vista activa.      |
|______________________________________|_______________________________________|
|Vistas ->; Cierra (q)             |Cerrar la vista actual.                |
|______________________________________|_______________________________________|
|Vistas ->; Nueva vista de paquetes|Crear una nueva vista de la lista de   |
|                                      |paquetes.                              |
|______________________________________|_______________________________________|
|                                      |Crear una vista que muestra paquetes no|
|Vistas ->; Auditar Recomendaciones|instalados, recomendados por algún    |
|                                      |paquete instalado en su sistema.       |
|______________________________________|_______________________________________|
|Vistas ->; Nueva vista de paquetes|Crear una nueva vista de paquetes en la|
|plana                                 |cual los paquetes no están            |
|                                      |categorizados.                         |
|______________________________________|_______________________________________|
|                                      |Crear una nueva vista de paquetes en la|
|Vistas ->; Nuevo navegador debtags|cual los paquetes están categorizados |
|                                      |según sus entradas de debtags.        |
|______________________________________|_______________________________________|
|Vistas ->; Nuevo navegador de     |Ver la lista de paquetes, agrupados por|
|categorías                           |categoría.                            |
|______________________________________|_______________________________________|
|                                      |Pueden aparecer un número de elementos|
|                                      |adicionales del menú correspondientes |
|Elementos adicionales                 |a la vista activa actual. Para cambiar |
|                                      |a otra vista, selecciónela desde el   |
|                                      |menú.                                 |
|______________________________________|_______________________________________|




El menú Ayuda

Figura 2.8. Órdenes disponibles en el menú Ayuda.

 _____________________________________________________________________________
|Orden                            |Descripción                               |
|_________________________________|___________________________________________|
|Ayuda ->; Acerca de          |Mostrar la información de copyright.      |
|_________________________________|___________________________________________|
|Ayuda ->; Ayuda (?)          |Mostrar la página de ayuda en línea.     |
|_________________________________|___________________________________________|
|Ayuda ->; Manual de usuario  |Mostrar el Manual de usuario (este         |
|                                 |documento).                                |
|_________________________________|___________________________________________|
|Ayuda ->; PUF                |Mostrar el PUF de aptitude.                |
|_________________________________|___________________________________________|
|Ayuda ->; Registro de cambios|Mostrar un historial de los cambios más   |
|                                 |significativos hechos a aptitude.          |
|_________________________________|___________________________________________|
|Ayuda ->; Licencia           |Mostrar los términos bajo los cuales puede|
|                                 |copiar, modificar y distribuir aptitude.   |
|_________________________________|___________________________________________|




Trabajar con varias vistas.

aptitude permite trabajar con varias &#8220;vistas&#8221; a la vez. Una
&#8220;vista&#8221; (a veces llamada &#8220;pantalla&#8221;) es simplemente algo
que puede aparecer en el área de la pantalla por debajo de la barra de menú.
La vista más común es la lista de paquetes, aunque vistas de descargas
también son habituales.

Cuando hay varias vistas abiertas a la vez, aparecerá una barra en la parte
superior de la pantalla listando todas las vistas. Por ejemplo, si examino apt
pulsando Intro, y después examino libc6, el resultado sería una pantalla
parecida a esta:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
         Paquetes                  apt info                  libc6 info
aptitude 0.3.1
i A  --\ libc6                                             2.3.2.ds1- 2.3.2.ds1-
  Descripción: Biblioteca de C de GNU: Bibliotecas compatidas
    Contiene las bibliotecas estándar que utiliza casi cualquier programa en
    el sistema. Esta biblioteca incluye las bibliotecas compartidas de la
biblioteca
    estándar de C y de la biblioteca de matemáticas, así como muchas otras
bibliotecas.
  Prioridad: requiere
  Sección: base
  Desarrollador: GNU Libc Maintainers <debian-glibc@lists.debian.org>
  Tamaño comprimido: 4901k
  Tamaño sin comprimir: 15.9M
  Paquete fuente: glibc
  --\ Depende
    --- libdb1-compat
  --\ Sugiere
    --- locales
    --- glibc-doc
  --\ Conflicts
Biblioteca de C de GNU: Bibliotecas compatidas

Puede cerrar la vista actual usando Vistas ->; Cierra (q). Para cambiar a la
vista anterior o a la siguiente, use Vistas ->; Siguiente (F6) y Vistas
->; Prev (F7), o pulse sobre el nombre de la vista en la parte superior de
la pantalla; también puede ver una lista de todas las vistas activas en el
menú Vistas.

Como se ha visto con anterioridad, algunas órdenes (como por ejemplo, visionar
información acerca de un paquete) crearán nuevas vistas automáticamente;
también puede crear una nueva vista usando Vistas ->; Nueva vista de
paquetes o Vistas ->; Nuevo navegador de categorías.


Convertirse en root.

Algunas acciones, tales como actualizar la lista de paquetes, tan solo se pueden
llevar a cabo como superusuario (root). Si no es root e intenta actualizar la
lista de paquetes, se le preguntará si quiere convertirse en root:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
aptitude 0.2.14.1
--- Paquetes instalados
--- Paquetes no instalados
--- Paquetes obsoletos y creados localmente
--- Paquetes virtuales
--- Tareas

  +-------------------------------------------------------------------------+
  |La actualización de la lista de paquetes disponibles requiere privilegios |
  |de administración, que actualmente no tiene. ¿Desearía cambiar a la |
  |cuenta de administrador?
|
  | [ Convertirse en administrador] [ No convertirse en administrador ]
|
Th+-------------------------------------------------------------------------+








Si selecciona &#8220;Convertirse en administrador&#8221;, aptitude le
solicitará la contraseña de administrador; una vez que la haya introducido
aptitude realizará la acción que requiere privilegios de root. Aun será root
después de que la acción finalice.

Puede identificarse como root en cualquier momento usando la orden Acciones
->; Convertirse en administrador. Cualquier cambio realizado al estado de
los paquetes será preservado (pero no se guardarán hasta que quite aptitude).

By default, aptitude will use the command su to gain root privileges. If you
would like it to use some other command (such as sudo), set the configuration
option Aptitude::Get-Root-Command.


Gestionar paquetes

Esta sección describe como manipular la lista de paquetes, como instalar
paquetes nuevos en el sistema y como eliminar paquetes viejos.


Gestionar la lista de paquetes.

Es recomendable actualizar periódicamente la lista de paquetes para mantenerla
al día. Puede hacer esto usando la orden Acciones ->; Actualizar la lista
de paquetes (u).


Acceso a la información de los paquetes.

La información relativa a los paquetes se presenta en diferentes áreas en
aptitude: la lista de paquetes ofrece una lista preliminar del estado de cada
paquete; también hay vistas adicionales que proporcionan información detallada
acerca de un paquete.


La lista de paquetes

La lista de paquetes muestra una sinopsis &#8220;superficial&#8221; del estado
de un paquete. Por ejemplo, el paquete webmin podría mostrar una sinopsis
cercana a ésta:

piAU  webmin                                        +5837kB <none>     1.160-2

Los cuatro caracteres en el lado izquierdo de la sinopsis muestran que el
paquete no está instalado (&#8220;p&#8221;), que va a ser instalado
(&#8220;i&#8221;), que ha sido automáticamente seleccionado para su
instalación (&#8220;A&#8221;), y también que no va firmado (&#8220;U&#8221;).
Puede ver en el lado derecho de la sinopsis la versión actualmente instalada y
la última versión disponible, así como una indicación de cuanto espacio se
va a usar al actualizar el paquete.


 [Sugerencia]  Sugerencia

               Puede configurar cómo se muestran las sinopsis de los paquetes;
               véase &#8220;Personalizar la presentación de los
               paquetes&#8221; para más detalles.


Las cuatro marcas (caracteres) en el lado izquierdo de la pantalla ofrecen
información básica acerca del estado de un paquete. El primer carácter es el
estado actual. El segundo carácter simboliza la acción que se ejecutará sobre
el paquete. El tercer carácter indica si el paquete ha sido automáticamente
instalado (véase &#8220;Gestionar paquetes automáticamente
instalados.&#8221;), y el cuarto carácter indica si el paquete está firmado
(véase &#8220;Llaves GPG: Entender y gestionar la confianza de los
paquetes.&#8221;).

Los cuatro posibles valores de la marca de &#8220;estado actual&#8221; se tratan
en Figura� 2.9, &#8220;Valores de la marca de &#8220;estado
actual&#8221;&#8221;, y los posibles valores de &#8220;acción&#8221; se tratan
en Figura� 2.10, &#8220;Valores de la marca de &#8220;acción&#8221;&#8221;.

Figura 2.9. Valores de la marca de &#8220;estado actual&#8221;


i - el paquete está instalado y todas sus dependencias satisfechas.

c - el paquete se eliminó, pero sus archivos de configuración siguen
    presentes.

p - el paquete y todos sus archivos de configuración se eliminaron, o el
    paquete nunca se instaló.

v - el paquete es virtual.

B - el paquete tiene dependencias rotas.

u - el paquete se ha desempaquetado, pero no configurado.

C - medio-configurado: la configuración del paquete se interrumpió.

H - medio-instalado: la instalación del paquete se interrumpió.




Figura 2.10. Valores de la marca de &#8220;acción&#8221;


i - el paquete se va a instala.

u - el paquete se va a actualizar.

d - el paquete se va a eliminar: se desinstalará, pero sus archivos de
    configuración permanecerán en el sistema.

p - el paquete se va a purgar; se eliminarán él y sus archivos de
    configuración.

h - el paquete se va a retener: permanecerá en su versión actual, aunque haya
    una nueva versión disponible, hasta que se cancele la retención .

F - Se prohibió la actualización del paquete.

r - el paquete se va a reinstalar.

    el paquete está &#8220;roto&#8221;: algunas de sus dependencias no serán
B - satisfechas. aptitude no le permitirá instalar, eliminar o actualizar nada
    mientras tenga paquetes rotos.




Además, aptitude usará colores para indicar el estado de los paquetes si su
terminal lo permite. Las distinciones relativas al estado se muestran usando el
color de fondo:



  Negro
      El paquete no se puede actualizar (o no se va a instalar), y no tiene
      problemas de dependencias. Si se instala el paquete, su nombre aparecerá
      resaltado.


  Verde
      El paquete se va instalar.


  Azul
      El paquete está instalado, y se va a actualizar.


  Magenta
      El paquete está instalado, pero se va a eliminar.


  Blanco
      El paquete está instalado, y &#8220;retenido&#8221; en su versión
      actual: las actualizaciones automáticas ignorarán este paquete.


  Rojo
      Este paquete esta roto: algunas de sus dependencias no serán satisfechas.


Por último, la mitad inferior de la pantalla muestra la descripción completa.
aptitude intentará detectar si el paquete está envuelto en un problema de
dependencias; de ser así se mostraría aquí información referente al problema
de dependencias. Para pasar de la información de dependencias a la descripción
del paquete, pulse i.


Información detallada del paquete

Si pulsa Intro mientras resalta un paquete verá la siguiente pantalla
informativa:

  Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
aptitude 0.2.14.1
i A --\ apt                                                0.5.25     0.5.25
  Descripción: Interfaz avanzada para dpkg
    Esta es la interfaz de nueva generación de Debian para el gestor de
paquetes.
    Proporciona la herramienta apt-get y ún metodo dselect que ofrece una
manera más
    simple y segura de instalar y actualizar paquetes

    APT permite hacer ordenación de la instalación, acceder a múltiples
fuentes
    y también otras funcionalidades únicas. Para más información consulte
    la Guía del Usuario en el paquete apt-doc
  Esencial: sí
  Prioridad: importante
  Sección: base
  Desarrollador: APT Development Team <deity@lists.debian.org>
  Tamaño comprimido: 970k
  Tamaño sin comprimir: 2961k
  Paquete fuente: apt
  --\ Depende
    --- libc6 (>= 2.3.2.ds1-4)
    --- libgcc1 (>= 1:3.3.3-1)
    --- libstdc++5 (>= 1:3.3.3-1)
  --\ Sugiere
    --- aptitude | synaptic | gnome-apt | wajig
    --- dpkg-dev
    --\ apt-doc (INSATISFECHO)

p     0.6.25
p     0.5.25
  --\ Reemplaza
    --- libapt-pkg-doc (< 0.3.7)
    --- libapt-pkg-dev (< 0.3.7)
  --- Nombres del paquete proporcionado por apt
  --- Paquetes que dependen de apt
  --\ Versiones
p A 0.6.25
i A 0.5.25

Puede moverse por esta pantalla de una manera similar a la lista de paquetes:
por ejemplo, en la captura de pantalla superior, expandí la dependencia de apt-
doc mostrando las versiones disponibles de apt-doc que pueden satisfacer la
dependencia. Estas versiones se pueden manipular de la misma manera que un
paquete: por ejemplo, para instalar la versión 0.5.25 de apt-doc, debería
resaltarlo y pulsar +.


 [Sugerencia]  Sugerencia

               Para satisfacer rápidamente una dependencia, seleccione la
               dependencia y presione +; aptitude intentará satisfacerlas
               automáticamente por usted.


Además de las dependencias de un paquete, también puede ver los nombres de
paquetes que «Provee», los paquetes sobre los que «Depende», y las versiones
disponibles del paquete (incluyendo cualquier paquete que lo «Provea»).

Como es normal, puede cerrar esta pantalla y volver a la vista principal
pulsando q. Para su conveniencia, dispone de otras pantallas informativas (que
sólo muestran la información más usada, ocultando el resto): pulse v para ver
las versiones de un paquete, d para ver las dependencias de un paquete, y r para
ver las dependencias inversas de un paquete (paquetes que dependen de él).


Modificar los estados de los paquete.

Dispone de las siguientes órdenes para modificar el estado de los paquetes. Las
órdenes se ejecutarán la siguiente vez que realice un proceso de instalación;
hasta entonces, puede revertir estas órdenes con Deshacer ->; Deshacer
(Control+u).

Para aplicar una orden a un paquete, simplemente seleccione el paquete en la
lista de paquetes y ejecute la orden. Estas órdenes se pueden aplicar también
a grupos de paquetes, seleccionando la cabecera del grupo (por ejemplo,
&#8220;Paquetes actualizables&#8221;), y ejecutando la orden.

 ______________________________________________________________________________
|Orden                                 |Descripción                           |
|______________________________________|_______________________________________|
|                                      |Marcar el paquete para su instalación.|
|                                      |                                       |
|                                      |Si el paquete no está instalado, se   |
|Instalar: Paquete ->; Instalar (+)|instalará. Si ya lo está, se         |
|                                      |actualizará, de ser posible, y        |
|                                      |cualquier retención en efecto se      |
|                                      |cancelará.                            |
|______________________________________|_______________________________________|
|                                      |Marcar el paquete seleccionado para su |
|                                      |eliminación.                          |
|Eliminar: Paquete ->; Eliminar (-)|                                       |
|                                      |Si el paquete está instalado, se      |
|                                      |eliminará.                            |
|______________________________________|_______________________________________|
|                                      |Marcar el paquete para ser purgado     |
|                                      |                                       |
|                                      |If the package is installed, it will be|
|Purgar: Paquete ->; Purgar (_)    |removed. Furthermore, even if it is    |
|                                      |removed, any remaining files (such as  |
|                                      |configuration files) related to the    |
|                                      |package will be removed from the       |
|                                      |system.                                |
|______________________________________|_______________________________________|
|                                      |Marcar el paquete para que se mantenga |
|                                      |en su versión actual.                 |
|                                      |                                       |
|                                      |Cualquier acción que se fuese a llevar|
|Mantener: Paquete ->; Mantener (:)|a cabo sobre el paquete -              |
|                                      |- instalación, eliminación o         |
|                                      |actualización -- se cancela, y        |
|                                      |cualquier retención impuesta al       |
|                                      |paquete se elimina.                    |
|______________________________________|_______________________________________|
|                                      |Imponer una retención al paquete.     |
|                                      |                                       |
|                                      |Al igual que con «Mantener», se      |
|                                      |cancela cualquier acción programada   |
|Retener: Paquete ->; Retener (=)  |para el paquete. Además, el paquete no|
|                                      |se actualizará automáticamente [a]   |
|                                      |hasta que elimine esta acción. Puede  |
|                                      |cancelar «Mantener» ejecutando la    |
|                                      |siguiente orden.                       |
|______________________________________|_______________________________________|
|                                      |El paquete no se actualizará          |
|                                      |automáticamente [a] a la versión a la|
|                                      |que lo iba a ser. Si se iba a          |
|                                      |actualizar, la actualización se       |
|                                      |cancela.                               |
|                                      |                                       |
|                                      |Si ejecuta esta orden sobre una        |
|                                      |versión en particular de un paquete,  |
|                                      |el paquete no se actualizará a la     |
|Paquete ->; Prohibir versiones (F)|versión escogida. Observe que sólo   |
|                                      |puede prohibir una versión al mismo   |
|                                      |tiempo.                                |
|                                      |                                       |
|                                      |Esta funcionalidad se ha implementado  |
|                                      |en gran medida para la conveniencia de |
|                                      |la distribución &#8220;unstable       |
|                                      |(sid)&#8221;, para que así se puedan  |
|                                      |evitar versiones de programas ya       |
|                                      |conocidas como malas.                  |
|______________________________________|_______________________________________|
|                                      |Reinstalar el paquete.                 |
|                                      |                                       |
|                                      |Note that the reinstallation will not  |
|                                      |be saved when you quit aptitude or     |
|Reinstalar: pulse L                   |perform an install run, for technical  |
|                                      |reasons (essentially, the underlying   |
|                                      |software layers (dpkg and apt) do not  |
|                                      |provide any way to find out whether a  |
|                                      |reinstallation was successful or not). |
|______________________________________|_______________________________________|
|                                      |Define si un paquete se toma como      |
|                                      |automáticamente instalado; los        |
|                                      |paquetes automáticamente instalados se|
|Paquete ->; Marcar automático    |eliminarán cuando ningún otro paquete|
|(M), Paquete ->; Marcar manual (m)|dependa de ellos. Para más            |
|                                      |información, véase &#8220;Gestionar  |
|                                      |paquetes automáticamente              |
|                                      |instalados.&#8221;.                    |
|______________________________________|_______________________________________|
|[a] Ésto es, que no se verá afectado por Acciones ->; Marcar            |
|actualizable (U) o por las órdenes en línea de órdenes full-upgrade o safe-|
|upgrade                                                                       |
|______________________________________________________________________________|

Además de estas órdenes que afectan al paquete seleccionado, hay dos órdenes
que afectan a un gran número de paquetes en una sola acción independientemente
de lo que haya seleccionado. Acciones ->; Olvidar paquetes nuevos (f)
elimina el estado &#8220;nuevo&#8221; de todos los paquetes de la lista de
paquetes, y Acciones ->; Marcar actualizable (U) marca todos los paquetes
actualizables para su actualización, excepto aquellos que están retenidos o
prohibidos de actualización.


 [Nota]  Nota

         Todos los cambios efectuados al estado de los paquetes se guardan
         cuando cierre aptitude, actualice la lista de paquetes o realice un
         proceso de instalación. Si no desea guardar los cambios, siempre puede
         interrumpir aptitude pulsando Ctrl-C.



Descargar, instalar y eliminar paquetes.

Cambiar el estado de los paquetes tal y como se describe en la sección anterior
no afecta de manera directa a lo que está instalado en el sistema. Por ello,
puede ajustar el estado de los paquetes sin afectar al sistema hasta que esté
satisfecho con lo que ve; una vez que lo esté, puede &#8220;confirmar&#8221;
los cambios de verdad, instalando y eliminando paquetes.[8]

Para confirmar los cambios, use la orden Acciones ->; Instalar/eliminar
paquetes (g). Seleccionar esta orden muestra una previsualización que describe
los cambios que se llevarán a cabo. Esta imagen es una simple lista de paquetes
por lo que puede manipular los paquetes (por ejemplo, cancelando eliminaciones
no deseadas) de la misma manera en que lo puede hacer en el lista principal.

Una vez que haya finalizado, use Vistas ->; Cierra (q) para cancelar la
instalación, o use Acciones ->; Instalar/eliminar paquetes (g) para
proceder con las selecciones. aptitude descargará en ese momento cualquier
paquete necesario para después continuar con la instalación.

Los paquetes descargados por aptitude se guardan en el directorio almacén (por
omisión /var/cache/apt/archives). Normalmente, los paquetes son guardados ad
infinitum. Para eliminar todos los archivos de este directorio, use Actions
->; Limpiar el almacén de paquetes; para eliminar sólo aquellos paquetes
que ya no se pueden descargar (p. ej., paquetes obsoletos), use Acciones ->;
Limpiar ficheros obsoletos.


Llaves GPG: Entender y gestionar la confianza de los paquetes.

La habilidad de apt de acceder a múltiples fuentes de paquetes conduce a una
potencial vulnerabilidad de seguridad. Supongamos que intenta añadir un archivo
de paquetes de José Hacker Aleatorio a su archivo sources.list para poder
instalar el paquete gargleblast de Pepe. Por otro lado, es posible que (fuera de
su conocimiento) el archivo de Pepe contenga versiones de paquetes como libc6 y
ssh...¡versiones que roban su información privada o que abren puertas traseras
en el sistema! Si estos paquetes tuviesen unos números de versión más
elevados que los que se encuentran el archivo de Debian, apt los instalaría sin
dudar en la siguiente actualización, permitiendo a Pepe realizar su sucia labor
sin ser detectado. Pepe podría incluso entrar en los servidores réplica de
Debian y reemplazar el software legítimo con su versión medicada.

Afortunadamente, las versiones más recientes de apt y de aptitude, tales como
la versión documentada en este manual, tienen defensas incorporadas para
repeler este tipo de ataques. apt usa unos fuertes mecanismos de seguridad
basados en el conocido software de cifrado GPG para verificar que los paquetes
distribuidos por los servidores réplica de Debian son los mismos que los que
subieron desarrolladores de Debian. De esta manera, aptitude le avisará si
intenta instalar un paquete desde una fuente que no pertenece a Debian, o si
intenta actualizar un paquete de Debian a una versión que viene de una fuente
que no es de Debian.


 [Aviso]  Aviso

          Los mecanismos de seguridad de apt proporcionan una garantía casi
          perfecta de que los contenidos de su servidor réplica son idénticos
          o los del servidor central de Debian. Aun así, no son perfectos.
          Teóricamente, hay varias maneras en las que un paquete modificado se
          pueda introducir en el archivo central de Debian.

          Asegurando que solo pueda instalar desde una fuente firmada le dará
          un alto grado de protección frente a los paquetes maliciosos, pero no
          puede eliminar todos los riesgos inherentes a instalar software.



Entender la confianza

apt permite al administrador de un archivo dotar de una firma al índice del
archivo. Esta firma, que (por razones prácticas) no se puede falsificar, indica
que los paquetes del archivo listados en el índice son los mismos que el
administrador puso en el archivo en primer lugar: p. ej., que los contenidos de
un paquete no se han manipulado desde su creación.[9] La firma se puede validar
cerciorándose de que se corresponde con la llave pública del administrador. La
llave pública del archivo de Debian se distribuye con apt, generalmente a
través de su CD de Debian.

Cuando aptitude descarga el índice de un archivo, comprobará si el índice
está apropiadamente firmado. Si no está firmado aptitude no confiara en los
paquetes provenientes de ese archivo (más adelante se explicará lo que esto
significa). Si tiene una firma pero es incorrecta o no se puede verificar, verá
un aviso y aptitude se negará a confiar en paquetes procedentes de ese archivo.

Más adelante, cuando lleve a cabo un proceso de instalación, aptitude revisara
si los paquetes son de una fuente firmada. Entonces verá un mensaje de aviso si
se va a instalar un paquete sin firmar, o si un paquete se actualizará de una
versión firmada a otra que no lo es, dándole la oportunidad de interrumpir la
instalación.

  Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
aptitude 0.3.0                    Esto usará 831kB de espacio del disco
TamDesc: 30.4MB
--\ Paquetes a actualizar
iu U wesnoth                                       -98.3kB 0.8.7-1    0.8.8-1.0w
iuAU wesnoth-data                                  +930kB  0.8.7-1    0.8.8-1.0w
+------------------------------------------------------------------------------+
|AVISO: ¡se instalarán versiones sin firmar de los siguientes paquetes     #|
|                                                                             #|
|Los paquetes sin firmar pueden comprometer la seguridad del sistema.#|
|Sólo debe continuar con la instalación si está completamente seguro de que
#|
|es lo que quiere                                                         #|
|                                                                             #|
|  * wesnoth [version 0.8.8-1.0wesnoth.org]                                   #|
|  * wesnoth-data [version 0.8.8-1.0wesnoth.org]                              #|
|  * wesnoth-music [version 0.8.8-1.0wesnoth.org]                             #|
|   [ Continúa de todas formas ]             [ Aborta la instalación ]
|
+------------------------------------------------------------------------------+
                                                                               #
                                                                               #
                                                                               #
                                                                               #
                                                                               #
                                                                               #


Confiar en llaves adicionales

Puede encontrar útil que apt confié en archivos externos aparte de los
archivos de Debian. Para cada paquete en el que quiera confiar, tendrá que
adquirir la llave pública que se usa para firmar el índice del archivo de
paquetes. Éste es por lo general un archivo de texto cuyo nombre finaliza en
.asc; puede ser suministrado por el administrador del sitio web o descargado
desde un servidor de llaves públicas. Para más información acerca de llaves
públicas y de como conseguirlas, véase la página web de GPG.

La lista de llaves en las que apt confía se guarda en el archivo del anillo de
llaves /etc/apt/trusted.gpg. Una vez que tenga la llave GPG, puede añadirla a
este archivo ejecutando esta orden, gpg --no-default-keyring --keyring /etc/apt/
trusted.gpg --import nueva_llave.asc. aptitude confiará entonces en cualquier
archivo firmado con la llave contenida en nueva_llave.asc.


 [Aviso]  Aviso

          Una vez que se añade un archivo de una llave al anillo de llaves de
          APT, !se le otorgara la misma confianza que a los propios servidores
          réplica de Debian¡ Haga esto sólo si está muy seguro de que la
          llave que está añadiendo es la correcta y si la persona que posee la
          llave es competente y de toda confianza.



Gestionar paquetes automáticamente instalados.

Para instalar un paquete es a veces necesario instalar muchos otros (para
satisfacer sus dependencias). Por ejemplo, si desea instalar el paquete
clanbomber, debe también instalar el paquete libclanlib2. Si elimina
clanbomber, probablemente no necesite más libclanlib2; aptitude intentará
detectar esto y eliminar el paquete libclanlib2.

Funciona de la siguiente manera: cuando instala un paquete, aptitude instalará
automáticamente cualquier otro paquete sobre el cual éste dependa. Estos
paquetes se marcan como &#8220;automáticamente instalados&#8221;; aptitude los
registrará y eliminará cuando ya no sean dependencia de cualquier paquete
manualmente instalado [10] . Aparecerán en la previsualización como
&#8220;paquetes que se eliminarán porque ya no se usan.&#8221;

Al igual que con cualquier proceso automático, hay posibilidades de que las
cosas se compliquen. Por ejemplo, aunque de inicio un paquete se instaló
automáticamente, puede resultar útil por si mismo. Puede cancelar la marca de
&#8220;automático&#8221; en cualquier momento pulsando m; si ya se eliminó el
paquete, puede usar Paquete ->; Instalar (+) para cancelar la eliminación y
borrar la marca de &#8220;automático&#8221;.


Resolver las dependencias de los paquetes


Resolución de dependencias de aptitude.

Hay dos algoritmos principales en la resolución de dependencias de aptitude

El primero es un algoritmo que se emplea también en programas tales como apt-
get y synaptic; Me referiré a el como &#8220;resolución inmediata&#8221;. Se
invoca cuando marca un paquete para su instalación de forma interactiva, e
inmediatamente después de que uno o más paquetes son marcados en la línea de
órdenes. La resolución inmediata es rápida y solucionará la mayoría de
problemas de dependencias, aunque a veces no pueda encontrar ninguna.

El segundo algoritmo, que llamaré &#8220;resolución interactiva&#8221;, se
invoca cuando hay paquetes con dependencias rotas incluso después de la
resolución inmediata[11]. Puede resolver más dependencias, le permite
previsualizar la solución antes de aplicarla, y le permitiría también
introducir respuestas al solucionador, para así guiarle a una solución más
adecuada.


Resolución inmediata de dependencias.

En el momento que elija instalar o actualizar un paquete, aptitude hará un
intento inmediato de resolver cualquier dependencia no satisfecha. Por cada
dependencia insatisfecha (sea un &#8220;Depende&#8221;,
&#8220;Recomienda&#8221;, o con un &#8220;Conflicto&#8221;), realizará los
siguientes pasos:


  1. Si la dependencia es una recomendación, aptitude intentará ver si es una
     recomendación &#8220;nueva&#8221; o una &#8220;recomendación&#8221; ya
     &#8220;satisfecha&#8221;. aptitude considera una recomendación como
     &#8220;nueva&#8221; si el paquete manifestando la recomendación no está
     instalado, o si la versión instalada no recomienda un paquete del mismo
     nombre. Por otro lado, una recomendación está &#8220;satisfecha&#8221; si
     el paquete ya instalado recomienda un paquete del mismo nombre, estando ya
     satisfecho.

     Por ejemplo: imagine que la versión 1.0 de prog recomienda la versión 4.0
     de libcool1, pero la versión 2.0 de prog recomienda la versión 5.0 de
     libcool1, y también recomienda apache. Si escogiese actualizar prog de la
     versión 1.0 a la versión 2.0, la recomendación de apache se considerará
     &#8220;nueva&#8221; porque la versión 1.0 de prog no recomendaba apache.
     Por otro lado, la recomendación de libcool1 no es &#8220;nueva&#8221;,
     porque la versión1.0 de prog recomienda libcool1, aunque recomiende una
     versión diferente. De todas formas, si libcool1 está instalado, entonces
     la recomendación se tratará como &#8220;ya satisfecha&#8221;.

     Si la opción de configuración Apt::Install-Recommends es true, aptitude
     siempre intentará satisfacer las recomendaciones nuevas y ya satisfechas;
     todas las demás se ignorarán en la siguiente resolución. Si la opción
     es false, la resolución inmediata de dependencias ignorará todas las
     recomendaciones.

  2. Si la dependencia se da en varios paquetes en combinación con «OR»,
     examine cada una de las alternativas en el orden dado. Por ejemplo, si un
     paquete depende de &#8220;exim | mail-transport-agent&#8221;, aptitude
     procesará primero exim, y después mail-transport-agent.

  3. Intente resolver cada alternativa dada. Si la dependencia es un conflicto,
     elimine la alternativa actual si ya está instalada (y por cada conflicto
     no de versiones, elimine también cualquier paquete que provoca el núcleo
     del conflicto). También puede instalar la versión candidata de la
     alternativa actual si satisface la dependencia. Si no, o si no hay otra
     versión candidata (p. ej., porque la alternativa actual es un paquete
     virtual), y si la dependencia no tiene versión, intente instalar el
     paquete de más alta prioridad[12] cuya versión candidata provea el
     objetivo de la alternativa actual.

     Por ejemplo, imagine que estamos intentando resolver &#8220;Depende: exim |
     mail-transport-agent&#8221;. En primer lugar, aptitude intentará instalar
     el paquete exim. Si exim no está disponible, aptitude intentará entonces
     instalar el paquete con la prioridad más alta cuya versión candidata
     provee exim. Si no encuentra tal paquete, aptitude instalará el paquete
     con la prioridad más alta cuya versión candidata provee el paquete
     virtual mail-transport-agent. Por otro lado, imagine que la dependencia es
     &#8220;Depende: exim (>= 2.0.0) | mail-transport-agent&#8221;, pero cuya
     única versión de exim disponible es 1.0. En este caso, aptitude no
     instalará exim (porque la versión no corresponde a la dependencia), ni
     intentará instalar paquetes que provean exim (porque los paquetes
     virtuales no pueden satisfacer una dependencia con una restricción en
     cuanto a la versión). Por ello, aptitude le instalaría el paquete con la
     prioridad más alta cuya versión candidata provea mail-transport-agent.

  4. Si el paquete se instaló siguiendo el paso anterior, resuelve sus
     dependencias empleando este algoritmo, y finaliza entonces.


Mientras que esta técnica resuelve a menudo las dependencias más notorias,
también puede fallar bajo ciertas circunstancias.


* La manera de resolver un conflicto es desinstalando el paquete que es el
  núcleo del conflicto, dejando otros paquetes que dependen de él con
  dependencias no resueltas; el solucionador inmediato no realiza ninguna
  acción para arreglarlo.

* Puede que nunca se satisfaga una dependencia por razones de restricciones de
  versiones y debido a la limitación de que se consideran solo las versiones
  candidatas. Por ejemplo, imagine que las versiones 1.0 y 2.0 de fileutils
  están disponibles, que la versión candidata es 1.0 y que el paquete octopus
  declara una dependencia &#8220;Depende: fileutils (>= 2.0)&#8221;. El
  solucionador inmediato es incapaz de resolver esta dependencia pues nunca
  considerará la versión 2.0 del mismo paquete puesto que no es la versión
  candidata.


El solucionador de dependencias interactivo puede solucionar estos problemas y
más. Cuando quedan atrás dependencias rotas, o cuando se desactiva el
solucionador de dependencias inmediato, el solucionador interactivo buscará
automáticamente una solución. La siguiente sección muestra cómo usar el
solucionador interactivo de dependencias.


Resolver dependencias de manera interactiva.

aptitude le asistirá a la hora de resolver si surge un problema de dependencias
que el solucionador inmediato no puede resolver. Una barra roja aparecerá en la
base de la pantalla en el momento en que aparezca un problema mostrando un
resumen de la sugerencia de aptitude acerca del modo de solucionar el problema.
Por ejemplo, en la siguiente imagen aptitude indica que puede solucionar el
problema manteniendo dos paquetes en sus versiones presentes.

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
aptitude 0.3.3       #Roto: 1   Se liberará 48.6MB de espacio del TamDesc
i A   nautilus                                             2.10.1-4   2.10.1-4
i     nautilus-cd-burner                                   2.10.2-1.1 2.10.2-1.1
i A   nautilus-data                                        2.10.1-4   2.10.1-4
i     netspeed                                             0.12.1-1   0.12.1-1
i A   oaf                                                  0.6.10-3   0.6.10-3
i     pybliographer                                        1.2.6.2-1  1.2.6.2-1
i     rhythmbox                                            0.8.8-13   0.8.8-13
i     shermans-aquarium                                    3.0.1-1    3.0.1-1
idA   sound-juicer                                 -1733kB 2.10.1-3   2.10.1-3
GNOME 2 CD Ripper
sound-juicer se eliminará.


Los siguientes dependen de sound-juicer y se romperán debido a su eliminación:


  * gnome-desktop-environment depende de sound-juicer

[1(1)/...] Sugiere 1 instalación
e: Examinar  !: Aplicar  .: Siguiente  ,: Anterior

Como se indica en la base de la pantalla, puede ver soluciones adicionales si
pulsa . y ,, aplicar la solución en pantalla pulsando !, y examinar la
solución más detenidamente pulsando e. Ud. vería una pantalla similar a la
siguiente si examinase este mismo problema.

  Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
                Paquetes                          Resolver las dependencias
  --\ Mantener los paquetes siguientes en la versión actual:
    gstreamer0.8-cdparanoia                           [0.8.10-1 (unstable, now)]
    sound-juicer                                                [2.10.1-2 (now)]
















[1(1)/...] Sugiere 2 mantenidos
e: Examinar  !: Aplicar  .: Siguiente  ,: Anterior

Puede acceder a la información del paquete afectado pulsando Intro mientras el
paquete está seleccionado. Para una explicación más detallada acerca de una
decisión en particular de aptitude, puede resaltar el elemento en lista. Cuando
lo haga, la mitad inferior de la pantalla mostrará la dependencia solucionada
por la elección de aptitude, así como cada manera en que se pudo resolver la
dependencia.

  Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
                Paquetes                        Resolver dependencias
  --\ Mantener los paquetes siguientes en la versión actual:
    gstreamer0.8-cdparanoia                           [0.8.11-1 (unstable, now)]
    sound-juicer                                      [2.10.1-3 (unstable, now)]






cdparanoia plugin for GStreamer
sound-juicer depende de   gstreamer0.8-cdparanoia
--\ Las acciones siguientes resolverán estas dependencias:
  -> Descatualizar sound-juicer [2.10.1-3 (unstable, now) -> 0.6.1-2 (testing)]
  -> Eliminar sound-juicer [2.10.1-3 (unstable, now)]
  -> Cancelar la eliminación de gstreamer0.8-cdparanoia
  -> Descatualizar gstreamer0.8-cdparanoia [0.8.11-1 (unstable, now) -> 0.8.8-3
(tes



[1(1)/...] Sugiere 2 mantenidos
e: Examinar  !: Aplicar  .: Siguiente  ,: Anterior

Puede guiar al solucionador de dependencias a una solución que usted crea
conveniente aprobando o rechazando las diferentes acciones de una solución. Si
aprueba una acción, el solucionador la tomará siempre que sea posible,
ignorando otras alternativas (cuando hay más de una acción aprobada entre las
alternativas, cualquiera se puede seleccionar). Por otro lado, si rechaza una
acción el solucionador nunca la elegirá en el caso de que se presente.

Para rechazar una acción, seleccione la misma y pulse r; el rechazo se puede
cancelar pulsando r otra vez. De manera parecida, seleccione una acción y pulse
a para aprobarla; pulse a otra vez para devolverla a su estado original. Puede
deshacer esta acción empleando Deshacer ->; Deshacer (Control+u) a la vez
que la pantalla del solucionador está activa. Si cancela un rechazo o una
desinstalación, cualquier solución que se ignoró estará disponible la
siguiente vez que genere una solución nueva.


 [Nota]  Nota

         Por omisión el solucionador rechaza acciones que puedan cambiar el
         estado de paquetes retenidos, o que instalan versiones prohibidas de
         ciertos paquetes. Puede invalidar estos rechazos, y por ello anular el
         estado configurado, de la misma forma que puede invalidar cualquier
         otro rechazo. Si configura la opción Aptitude::ProblemResolver::Allow-
         Break-Holds como true desactivaría estas acciones, lo cual quiere
         decir que el solucionador siempre romperá retenciones (aunque con una
         penalización, véase Aptitude::ProblemResolver::BreakHoldScore).


Las acciones rechazadas se muestran de color rojo y marcadas con una
&#8220;R&#8221;, mientras que las acciones aprobadas son verdes y se marcan con
una &#8220;A&#8221;. Puede ver esto en la siguiente imagen, donde la acción
&#8220;mantener gstreamer0.8-cdparanoia en su versión presente&#8221; se ha
rechazado, y que la acción &#8220;mantener sound-juicer en su versión
presente&#8221; se aprobó.

  Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
                Paquetes                         Resolver dependencias
  --\ Mantener los paquetes siguientes en la versión actual:
R   gstreamer0.8-cdparanoia                           [0.8.11-1 (unstable, now)]
A   sound-juicer                                      [2.10.1-3 (unstable, now)]
















[1(1)/...] Sugiere 2 mantenidos
e: Examinar  !: Aplicar  .: Siguiente  ,: Anterior

Las aprobaciones o rechazos solo afectan a las soluciones generadas
recientemente. Puede ver cuando se ha generado una solución nueva examinando el
indicador en la esquina inferior izquierda de la pantalla: si hay un número
entre paréntesis, muestra el número de soluciones generadas. Siendo esto así,
cuando el numero que se encuentra frente al paréntesis y el que está dentro
son idénticos (como aparece arriba), pulsar «.» genera una nueva solución.
Si no hay ningún número entre paréntesis, (por ejemplo, si el indicador
muestra [1/5]), entonces no quedan más soluciones por generar. En cualquier
momento, puede seleccionar la última solución generada pulsando >, o < para
ver la primera solución generada.


 [Importante]  Importante

               El estado del solucionador de problemas cambia cuando modifica el
               estado de cualquier paquete. Si marca un paquete para instalar,
               actualizar o eliminar, etc... el solucionador desecha todos los
               rechazos y aprobaciones, así como las soluciones que haya
               generado hasta el momento.


Además de las acciones que puede seleccionar de la lista en la parte superior
de la pantalla, también puede seleccionarlas usando la lista en la parte
inferior de la pantalla. Para acceder a ella use el ratón o pulse Tab. Por
último, para ver las decisiones que el solucionador tomó por orden, pulse o.
Esto dará un lista de las dependencias que se resolvieron y la acción tomada
para ello, como puede ver en la siguiente captura de pantalla.

  Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
                Paquetes                         Resolver dependencias
  --\ gnome-desktop-environment depende de sound-juicer
    -> Cancelar la eliminación de sound-juicer
  --\ sound-juicer depende de gstreamer0.8-cdparanoia
    -> Cancelar la eliminación de gstreamer0.8-cdparanoia





GNOME 2 CD Ripper
gnome-desktop-environment depende de sound-juicer
--\ Las acciones siguientes resolverán estas dependencias:
  -> Eliminar gnome-desktop-environment [1:2.10.2.3 (unstable, testing, now)]
  -> Cancelar la eliminación de sound-juicer
  -> Desactualizar sound-juicer [2.10.1-3 (unstable, now) -> 0.6.1-2 (testing)]




[1(1)/...] Sugiere 2 mantenidos
e: Examinar  !: Aplicar  .: Siguiente  ,: Anterior

Puede abandonar esta vista pulsando o otra vez.


Costs in the interactive dependency resolver


Costs and cost components

The cost of a solution produced by the interactive dependency resolver is a
value that aptitude uses to determine how &#8220;bad&#8221; that solution is.
Solutions that are &#8220;better&#8221; are always displayed before solutions
that are &#8220;worse&#8221;. The cost of solutions is defined in the
configuration option Aptitude::ProblemResolver::SolutionCost.

Some typical costs are shown in Ejemplo� 2.1, &#8220;Sample resolver
costs&#8221;.

Ejemplo 2.1. Sample resolver costs

The default cost, sorting solutions by their safety cost, then by their apt pin
priority:

safety, priority

Remove as few packages as possible, then cancel as few actions as possible:

removals, canceled-actions

Sort solutions by the number of packages they remove plus twice the number of
actions they cancel.

removals + 2 * canceled-actions



As can be seen from the above examples, a cost is not necessarily a single
number. In fact, a cost consists of one or more cost components, each of which
is a number associated with the solution. When sorting solutions, the resolver
examines cost components in order, proceeding to later components only if the
earlier ones are equal. For instance, in the cost &#8220;removals, canceled-
actions&#8221;, solutions with fewer removals always appear before solutions
with more removals, regardless of how many canceled actions they have. However,
solutions with the same number of removals are sorted so that solutions with
fewer canceled actions appear first.

Cost components come in two flavors: basic cost components and compound cost
components.

Basic components simply name some property of the solution, such as
&#8220;upgrades&#8221; or &#8220;removals&#8221;. A list of built-in basic
components provided by aptitude can be found in Tabla� 2.1, &#8220;Basic cost
components&#8221;. You can also create your own cost components using the add-
to-cost-component and raise-cost-component hints; see &#8220;Configurar
indicaciones del solucionador&#8221; for details.

Each basic component is either a counter or a level. Counters count how many of
a solution's actions meet some condition (such as removing packages or
installing new packages), while levels associate a number with each action and
compute the highest number associated with any action in the solution.

Tabla 2.1. Basic cost components

 ______________________________________________________________________________
|Nombre              |Type   |Descripción                                     |
|____________________|_______|_________________________________________________|
|                    |       |Counts the number of holds that the solution     |
|broken-holds        |Counter|breaks, if the resolver is allowed to break holds|
|                    |       |(Aptitude::ProblemResolver::Allow-Break-Holds).  |
|____________________|_______|_________________________________________________|
|                    |       |Counts the number of pending actions that the    |
|canceled-actions    |Counter|solution cancels (keeping packages at their      |
|                    |       |current version).                                |
|____________________|_______|_________________________________________________|
|installs            |Counter|Counts the number of packages that the solution  |
|                    |       |installs.                                        |
|____________________|_______|_________________________________________________|
|non-default-versions|Counter|Counts the number of versions that the solution  |
|                    |       |installs or upgrades from non-default sources.   |
|____________________|_______|_________________________________________________|
|                    |       |A value that increases as the apt pin priority of|
|                    |       |a version decreases. Specifically, this is       |
|priority            |Level  |computed by negating the pin priority (so, e.g., |
|                    |       |if the pin priority is 500, this component will  |
|                    |       |compute -500).                                   |
|____________________|_______|_________________________________________________|
|removals            |Counter|Counts the number of packages that the solution  |
|                    |       |removes.                                         |
|____________________|_______|_________________________________________________|
|removals-of-manual  |Counter|Counts the number of manually installed packages |
|                    |       |that the solution removes.                       |
|____________________|_______|_________________________________________________|
|                    |       |A broad heuristic that increases as actions      |
|safety              |Level  |become less &#8220;safe&#8221;; see &#8220;Safety|
|                    |       |costs&#8221; for details.                        |
|____________________|_______|_________________________________________________|
|upgrades            |Counter|Counts the number of packages that the solution  |
|                    |       |upgrades.                                        |
|____________________|_______|_________________________________________________|



Compound components are built by combining the values of basic components. For
instance, removals + canceled-actions adds the components removal and canceled-
actions, resulting in a component that counts the number of removals and
canceled actions. Compound components combine counters by adding them together
and levels by taking their maximum value, as shown in Figura� 2.11,
&#8220;Syntax of compound cost components&#8221;.


 [Nota]  Nota

         It is an error to add two levels, or to take the maximum of two
         counters, or to combine levels and counters in any way. For instance,
         the costs removals + safety and max(upgrades, installs) will be treated
         as errors and ignored by the resolver.[13]


Figura 2.11. Syntax of compound cost components

Add two or more basic costs:

                [scale1]*cost1 + [scale2]*cost2 + ...

Take the maximum value of two or more basic costs:

                max([scale1]*cost1, [scale2]*cost2, ...)



Note that each individual basic component can be multiplied by a scaling factor
before it is combined with other components. This can be used to control the
trade-offs that the resolver makes between costs. For instance, a cost of
2*removals + 3*upgrades says that two removals are exactly as &#8220;bad&#8221;
as three upgrades. Solutions that contain four removals and one upgrade will be
considered equivalent to solutions containing one removal and three upgrades,
since both have a cost of eleven.


Safety costs

Figura 2.12. Safety cost levels

 Safety cost levels



The safety cost component is a heuristic estimate of how &#8220;safe&#8221; or
&#8220;unsafe&#8221; a solution is. Safety costs can be thought of as a way of
dividing solutions into several numbered &#8220;levels&#8221;, where &#8220;less
safe&#8221; levels are given higher numbers. Figura� 2.12, &#8220;Safety cost
levels&#8221; shows how this works with aptitude's default settings.


 [Sugerencia]  Sugerencia

               Safety cost levels are just one way to control the order in which
               dependency solutions are returned. See &#8220;Costs in the
               interactive dependency resolver&#8221; for a full description of
               how to change the order in which aptitude sorts solutions.


By default, aptitude initializes the resolver with a &#8220;reasonable&#8221;
set of safety cost levels. They are:

Tabla 2.2. Default safety cost levels

 ______________________________________________________________________________
|Cost level|Descripción                     |Opción de configuración        |
|__________|_________________________________|_________________________________|
|          |Solutions that include only      |                                 |
|          |&#8220;safe&#8221; actions       |Aptitude::ProblemResolver::Safe- |
|10,000    |(installing the default target   |Level, Aptitude::                |
|          |for a package or keeping a       |ProblemResolver::Remove-Level    |
|          |package at its current version)  |                                 |
|          |and package removals.            |                                 |
|__________|_________________________________|_________________________________|
|20,000    |La solución que cancela todas   |Aptitude::ProblemResolver::Keep- |
|          |las acciones del usuario.        |All-Level                        |
|__________|_________________________________|_________________________________|
|          |Soluciones que rompen retenciones|Aptitude::ProblemResolver::Break-|
|40,000    |definidas por el usuario o que   |Hold-Level                       |
|          |instalan versiones prohibidas.   |                                 |
|__________|_________________________________|_________________________________|
|          |Soluciones que instalan paquetes |                                 |
|          |con versiones no predeterminadas |Aptitude::ProblemResolver::Non-  |
|50,000    |(tales como                      |Default-Level                    |
|          |&#8220;experimental&#8221;, por  |                                 |
|          |ejemplo).                        |                                 |
|__________|_________________________________|_________________________________|
|60,000    |Soluciones que desinstalan       |Aptitude::ProblemResolver::      |
|          |paquetes Esenciales.             |Remove-Essential-Level           |
|__________|_________________________________|_________________________________|



If a solution qualifies for several safety cost levels, it will be placed in the
highest one, that is, the one that appears last. For example, a solution that
upgrades one package to its default version and breaks a hold on a second
package will be placed at level 40,000. You can adjust the levels of individual
versions using resolver hints; see &#8220;Configurar indicaciones del
solucionador&#8221; for details. The default levels are illustrated in
Figura� 2.12, &#8220;Safety cost levels&#8221;.


Configurar el solucionador interactivo de dependencias.


Configurar indicaciones del solucionador

Puede proporcionar indicaciones al solucionador interactivo de dependencias para
mejorar la calidad de las soluciones de dependencias que recibe. Estas
indicaciones pueden alterar las prioridades del solucionador, inclinándolo más
fuertemente hacia otra versión o paquete, o se pueden usar para &#8220;pre-
cargar&#8221; el solucionador con rechazos y aprobaciones, al igual que si
hubiese entrado en el solucionador y rechazado o aprobado varias versiones
manualmente.

Las indicaciones se guardan en el archivo de configuración de apt, /etc/apt/
apt.conf, dentro del grupo de configuración.&#8220;Aptitude::ProblemResolver::
Hints&#8221; (véase &#8220;Referencia del archivo de configuración.&#8221;
para más detalles acerca del archivo de configuración).

Cada indicación del solucionador consiste de una acción, un objetivo, y una
versión, opcional. Una indicación se escribe de la siguiente manera:"acción
objetivo [versión]". Para aplicar una indicación del solucionador, aptitude
ubica uno o más paquetes usando el valor del objetivo, elije una o más
versiones de esos paquetes usando el valor de la versión y, por último,
ejecuta la acción.

El campo correspondiente a la acción de una indicación del solucionador puede
ser uno de los siguientes:


  1. &#8220;approve&#8221;: Aprobar la versión, al igual que si ejecuta la
     orden Solucionador ->; Conmutar Aceptada (a).

  2. &#8220;reject&#8221;: Rechazar la versión, al igual que si ejecuta la
     orden Solucionador ->; Conmutar Rechazados (r).

  3.  &#8220;discard&#8221;: Discard every solution containing the version.
     Differs from &#8220;reject&#8221; in that it is not visible to the user and
     cannot be modified interactively.

  4. &#8220;increase-safety-cost-to number&#8221;: increase the safety cost of
     any solution that contains the version to number; if its safety cost is
     already higher than number, this hint has no effect. The safety cost can be
     used (and is used by default) to control the order in which solutions
     appear; see &#8220;Costs and cost components&#8221; and &#8220;Safety
     costs&#8221; for details.

     Several special cost levels can be chosen by name:


       a. conflict, discard: instead of changing the safety cost, discard
          solutions containing the version as if the &#8220;discard&#8221; hint
          had been applied.

       b. maximum: the highest safety cost.

       c. minimum: the lowest safety cost. All searches start at this cost, so
          &#8220;increasing&#8221; a version to this cost has no effect.
          However, this value can also be used when adjusting the predefined
          cost levels: for instance, setting Aptitude::ProblemResolver::Remove-
          Level to &#8220;minimum&#8221; will cause removed packages to have no
          effect on the safety cost of a solution.



      [Nota]  Nota

              The increase-safety-cost-to hint is applied in addition to any
              default safety cost that is due to the selected action. For
              instance, a hint that increases the safety cost of &#8220;install
              hal from experimental&#8221; to 15,000 will have no effect,
              because that action already has a safety cost of 50,000 (assuming
              that this version of hal is not the default candidate version).


  5. &#8220;número&#8221;: añadir el número a la puntuación de la versión,
     inclinando al solucionador a favor del mismo o (con un número negativo) en
     contra. Por ejemplo, la indicación 200 emacs añade 200 a la puntuación
     de emacs, mientras que la indicación -10 emacs sustrae 10 a su
     puntuación.


Si el campo de objetivo de una indicación del solucionador contiene un signo de
interrogación (&#8220;?&#8221;) o tilde (&#8220;~&#8221;), se toma como un
patrón de búsqueda y se consideran todas las versiones de paquetes que encajen
. De otra manera, se toma como el nombre de un paquete a seleccionar. Así que
el objetivo &#8220;g++&#8221; sólo seleccionaría el paquete g++, pero el
objetivo &#8220;?section(non-free)&#8221; seleccionaría cualquier paquete
dentro de la sección non-free. Para más información acerca de patrones de
búsqueda, véase &#8220;Patrones de búsqueda&#8221;.

Si el campo de versión no está presente, todas las versiones del paquete se
verán afectadas por la indicación. De no ser así, puede tener cualquiera de
las siguientes formas:


  1. &#8220;/archivo&#8221;: la indicación afecta sólo a las versiones
     disponibles del archivo dado.

  2. &#8220;<versión&#8221;: la indicación afecta sólo a las versiones cuyo
     número de versión es menor que versión.

  3. &#8220;<=versión&#8221;: la indicación solo afecta a las versiones cuyo
     número de versión es menor o igual a versión.

  4. &#8220;=versión&#8221;: la indicación afecta solo a las versiones cuyo
     número de versión es versión.

  5. &#8220;<>versión&#8221;: la indicación afecta sólo a las versiones cuyo
     número de versión no es versión.

  6. &#8220;>=versión&#8221;: la indicación afecta sólo a las versiones cuyo
     número de versión es mayor o igual a versión.

  7. &#8220;>versión&#8221;: la indicación afecta sólo a las versiones cuyo
     número de versión es mayor que versión.

  8. &#8220;:UNINST&#8221;: en lugar de afectar a cualquier otra versión del
     objetivo, la indicación afecta a la decisión de desinstalar el objetivo.
     Por ejemplo, &#8220;reject aptitude :UNINST&#8221; impide al solucionador
     intentar desinstalar aptitude.

  9. &#8220;versión&#8221;: la indicación afecta solo a las versiones cuyo
     número de versión es versión.



Patrones de búsqueda

La palabra que introduce cuando busca un paquete o crea una vista limitada de la
lista en aptitude se conoce como &#8220;patrón de búsqueda&#8221;. Mientras
que el uso más básico de los patrones de búsqueda es el de emparejar por
nombre de paquete, aptitude le permite realizar búsquedas mucho más complejas.
Además de la interfaz gráfica, algunas operaciones en la línea de órdenes
pueden emplear patrones de búsqueda; véase Referencia de la línea de órdenes
para más detalles.

Un patrón de búsqueda consiste de una o más condiciones (también conocidas
como &#8220;términos&#8221;); los paquetes se corresponden con el patrón si se
corresponden con todos sus términos. Por lo general, los términos empiezan con
un signo de interrogación (&#8220;?&#8221;), seguido del nombre del término,
el cual describe la búsqueda que el término realiza: por ejemplo, el término
?name se corresponde con los nombres de los paquetes, mientras que el término
?version busca entre las versiones de los paquetes. Por último, cualquier
parámetro adicional al término de búsqueda se escribe entre paréntesis,
(véase la documentación de términos individuales para ver los detalles de lo
que significa cada parámetro de los diferentes términos).


 [Nota]  Nota

         Un texto que no venga precedido de &#8220;?&#8221; forma también un
         patrón de búsqueda: aptitude trata cada palabra (o palabra
         entrecomillada) como un argumento para el patrón ?name, el cual busca
         un paquete cuyo nombre encaja con el texto cuando éste se interpreta
         como una expresión regular.



 [Aviso]  Aviso

          The behavior of aptitude when given a search pattern without a leading
          &#8220;?&#8221; (or &#8220;~&#8221;) is provided as a convenience for
          interactive use and will change in future releases; scripts that
          invoke aptitude should explicitly name the search strategy they want
          to use. That is, scripts should search for &#8220;?name(coq)&#8221;
          rather than &#8220;coq&#8221;).



Buscar cadenas de caracteres.

Muchos términos de búsqueda toman una cadena de caracteres como parámetro,
comparándolo con un campo de información de uno más paquetes. Se pueden
introducir cadenas entrecomilladas (&#8220;"&#8221;), con lo cual &#8220;?name
(scorch)&#8221; y &#8220;?name("scorch")&#8221; realizarían la misma búsqueda.
Si introduce una cadena de búsqueda empleando comillas dobles puede también
incluir comillas dobles literales poniendo un barra invertida (&#8220;\&#8221;)
justo delante: por ejemplo, &#8220;?description("\"easy\"")&#8221; encajaría
con todo paquete cuya descripción contenga la cadena en cuestión.

En caso de introducir una cadena &#8220;simple&#8221;, una que no va
entrecomillada, aptitude considerará que la cadena ha &#8220;finalizado&#8221;
cuando encuentra el paréntesis de cierre o la coma antes del segundo argumento
del término de búsqueda.[14] Para que estos caracteres pierdan su significado
especial, ponga una tilde (&#8220;~&#8221;) delante de ellos. Por ejemplo,
&#8220;?description(etc))&#8221; contiene un error de sintaxis, porque el primer
&#8220;)&#8221; cierra el término ?description, y el segundo &#8220;)&#8221; no
se corresponde con ningún &#8220;(&#8221;. En contraste, &#8220;?description
(etc~))&#8221; sí muestra cualquier paquete cuyo texto contiene
&#8220;etc)&#8221;. Hay también consideraciones adicionales si está empleando
la abreviatura de un término; véase &#8220;Abreviaturas de términos de
búsqueda.&#8221; para más detalles.

Most textual searches (for package names, descriptions, etc) are performed using
case-insensitive regular expressions. A regular expression will match against a
field if any portion of the field matches the expression; for instance,
&#8220;ogg[0-9]&#8221; will match &#8220;libogg5&#8221;, &#8220;ogg123&#8221;,
and &#8220;theogg4u&#8221;. Some characters have a special meaning within
regular expressions [15] , so if you want to match them in searches you need to
backslash-escape them: for instance, to find &#8220;g++&#8221;, you should use
the pattern &#8220;g\+\+&#8221;.

Los caracteres &#8220;!&#8221; y &#8220;|&#8221; tienen un significado especial
dentro de un patrón de búsqueda. Para poder incluir estos caracteres en una
cadena no entrecomillada, puede precederlos de una tilde (&#8220;~&#8221;). Por
ejemplo, para encontrar paquetes cuya descripción contiene &#8220;grand&#8221;
u &#8220;oblique&#8221;, use el patrón &#8220;?description
(grand~|oblique)&#8221;. De todas formas, en estos casos posiblemente encuentre
más sencillo usar una cadena entrecomillada: &#8220;?description
("grand|oblique")&#8221;.


Abreviaturas de términos de búsqueda.

Algunos términos de búsqueda se pueden escribir usando formas
&#8220;cortas&#8221;, las cuales consisten de una tilde (&#8220;~&#8221;)
seguida de un único carácter que identifica el término y por último, los
argumentos (en caso de haberlos) para el término. Por ejemplo, la forma corta
de ?name(aptitude) es ~n aptitude.

Cuando escribe un término empleando su forma corta los caracteres de tilde y
&#8220;espacios en blanco&#8221;, espacios, tabulados y similares dividirían el
término e iniciarían un nuevo término. Por ejemplo, &#8220;~mDaniel
Burrows&#8221; buscaría cualquier paquete cuyo campo de desarrollador contenga
&#8220;Daniel&#8221; y cuyo nombre contenga &#8220;Burrows&#8221;, mientras que
&#8220;~i~napt&#8221; busca paquetes instalados cuyo nombre contiene apt. Para
incluir espacios en blanco en la expresión de búsqueda, puede poner una tilde
delante del mismo (como en Daniel~ Burrows) o introducir unas comillas (como en
"Debian Project", o incluso Debian" "Project). Dentro de una cadena
entrecomillada, puede emplear la barra invertida (&#8220;\&#8221;) para cancelar
el significado especial de unas comillas: por ejemplo, ~d"\"email" mostraría
todo paquete cuya descripción contiene unas comillas inmediatamente seguidas de
email. [16]


 [Nota]  Nota

         Los signos de interrogación (&#8220;?&#8221;) no pueden cerrar la
         forma corta de un término, aunque vayan seguidos por el nombre de un
         término de búsqueda. Por ejemplo, &#8220;~napt?priority
         (required)&#8221; busca cualquier paquete cuyo nombre se corresponde
         con la expresión regular &#8220;apt?priority(required)&#8221;. Añada
         uno o más espacios entre los términos si desea combinar un término
         corto de consulta con un término de búsqueda especificado por el
         nombre, como por ejemplo &#8220;~napt� ?priority(required)&#8221;, o
         introduzca signos de interrogación en torno al texto (de haberlo)
         siguiendo la forma corta del término, como puede ver en
         &#8220;~n"apt"?priority(required)&#8221;.


Tabla� 2.3, &#8220;Guía rápida de términos de búsqueda&#8221; presenta en
una lista la forma corta de cada término de búsqueda.


Búsquedas y versiones.

De manera predeterminada, un patrón se corresponde con un paquete si cualquier
versión del paquete encaja con el patrón. De todas formas, algunos patrones
restringen sus sub-patrones para emparejarse solo con algunas versiones de un
paquete. Por ejemplo, el término de búsqueda ?depends(patrón) selecciona
cualquier paquete que dependa de un paquete que encaja con patrón. De todas
formas, patrón solo encaja con las versiones de un paquete que satisfacen la
dependencia. Esto significa que si foo depende de bar (>= 3.0), estando
disponibles 2.0, 3.0, y 4.0, en el patrón de búsqueda ?depends(?version(2\.0))
sólo las versiones 3.0 y 4.0 se compararían con ?version(2\.0), conduciendo a
que no se encontraría foo en esta búsqueda.

Importa qué versiones se revisan porque, al igual que en el ejemplo anterior,
algunos patrones encajarían con una versión pero no con la otra. Por ejemplo,
el patrón ?installed solo muestra la versión del paquete que está instalado.
De manera similar, el patrón ?maintainer(desarrollador) solo encontraría
versiones que contengan el desarrollador dado. Normalmente, todas las versiones
de un paquete tienen el mismo desarrollador, pero éste no es siempre el caso;
de hecho, cualquier patrón de búsqueda que examina los campos de un paquete
(aparte de su nombre, por supuesto) actúa de esta manera, pues todos los campos
de un paquete pueden variar de una versión a otra.

Para revisar un patrón con todas las versiones de un paquete, aunque el patrón
generalmente se compara sólo con algunas versiones, use el término ?widen. Por
ejemplo, ?depends(?widen(?version(2\.0))) muestra cualquier paquete A que
depende de un paquete B, donde B encaja con la versión 2.0, independientemente
de si la versión satisface la dependencia de A. Por otro lado, el término
?narrow restringe las versiones con las cuales se compara el sub-patrón:
?narrow(?installed, ?depends(?version(ubuntu))) encontraría cualquier paquete
cuya versión instalada tiene una dependencia que se puede satisfacer con un
paquete cuya cadena de versión contenga &#8220;ubuntu&#8221;.


 [Nota]  Nota

         Hay una sutil pero importante distinción entre emparejar un patrón
         con un paquete, y emparejarlo con todas las versiones de ese paquete.
         Cuando un patrón se compara con un paquete cada uno de sus términos
         se compara con el paquete, y por lo tanto cada término encajaría si
         cualquier versión del paquete encaja. En contraste, cuando un patrón
         se compara con cada versión de un paquete, encajaría con éxito al
         emparejarse cuando todos sus términos encajan con la misma versión
         del paquete.

         Por ejemplo: suponga que la versión 3.0-1 del paquete aardvark está
         instalado, pero está disponible la versión 4.0-1. La expresión de
         búsqueda ?version(4\.0-1)?installed muestra aardvark, porque ?version
         (4\.0-1) encaja con la versión 4.0-1 de aardvark, mientras que
         ?installed encaja con la versión 3.0-1. Por otra parte, esta
         expresión no se emparejaría con todas las versiones de aardvark,
         porque no hay ninguna versión instalada y porque también tiene el
         numero de versión 4.0-1.



Objetivos explícitos de búsqueda.

Algunas búsquedas particularmente complejas se pueden expresar en aptitude
usando objetivos explícitos. En una expresión normal de búsqueda no hay
ninguna manera de referirse al paquete o a la versión que se revisa en el
momento. Por ejemplo, suponga que desea realizar una búsqueda de todo paquete P
que depende de un segundo paquete Q de manera que Q recomienda P. Obviamente,
necesita comenzar con el término ?depends(...). Pero el término introducido en
... necesita seleccionar paquetes idénticos a aquel emparejado con ?depends.
Cuando he descrito esta meta traté con este tema dando los nombres de los
paquetes, denominándolos P y Q; términos con objetivos explícitos harían
exactamente lo mismo. [17]

Un objetivo explicito se introduce con el término ?for.

Figura 2.13. Sintaxis del término ?for

?for variable: patrón



Funciona de la misma manera que patrón, pero puede emplear la variable dentro
de patrón para referirse al paquete o versión con el cual se empareja patrón.
Puede usar variable de dos maneras:


  1. El término ?= encajaría de manera exacta con el paquete o la versión
     indicada por la variable dada. De manera específica, si el termino ?for
     correspondiente se limita a una sola versión, ?= encajaría o bien con la
     versión (si ?= se ha limitado) o con el paquete completo; de otra forma,
     encaja con cualquier versión del paquete.

     Véase Ejemplo� 2.2, &#8220; Uso del término ?=. &#8221; para ver un
     ejemplo de uso de ?=.

  2. El término ?bind(variable, patrón) encaja con cualquier paquete o
     versión si el valor de variable encaja con patrón.

     Hay una forma abreviada para términos de tipo ?. La expresión ?bind
     (variable, ?término[(argumentos)]) se puede sustituir por ?variable:
     término(argumentos).

     Véase Ejemplo� 2.3, &#8220;Uso del término ?bind.&#8221; para un ejemplo
     de uso de ?bind.



Referencia de los términos de búsqueda.

Tabla� 2.3, &#8220;Guía rápida de términos de búsqueda&#8221; provides a
brief summary of all the search terms provided by aptitude. A full description
of each term can be found below.

Tabla 2.3. Guía rápida de términos de búsqueda

 ______________________________________________________________________________
|Forma larga                |Forma corta         |Descripción                 |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar el paquete ligado|
|?=variable                 |�                   |a variable; véase           |
|                           |                    |&#8220;Objetivos explícitos |
|                           |                    |de búsqueda.&#8221;.        |
|___________________________|____________________|_____________________________|
|?not(patrón)              |!patrón            |Seleccionar el paquete que no|
|                           |                    |encaja con patrón.          |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes que se  |
|                           |                    |han marcado para la acción  |
|?action(acción)           |~aacción           |dada (p. ej.,                |
|                           |                    |&#8220;install&#8221; o      |
|                           |                    |&#8220;upgrade&#8221;).      |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes cuyas   |
|?all-versions(patrón)     |�                   |versiones encajan con        |
|                           |                    |patrón.                     |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar todo paquete que |
|?and(patrón1, patrón2)   |patrón1 patrón2   |encaja con patrón1 y        |
|                           |                    |patrón2.                    |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes con al  |
|?any-version(patrón)      |�                   |menos una versión que encaje|
|                           |                    |con patrón.                 |
|___________________________|____________________|_____________________________|
|                           |                    |Select packages for the given|
|                           |                    |architecture (such as        |
|?architecture(architecture)|~rarchitecture      |&#8220;amd64&#8221;, or      |
|                           |                    |&#8220;all&#8221;). Special  |
|                           |                    |values: native and foreign.  |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes del     |
|?archive(archivo)          |~Aarchivo           |archivo dado (tales como     |
|                           |                    |&#8220;unstable&#8221;).     |
|___________________________|____________________|_____________________________|
|?automatic                 |~M                  |Seleccionar paquetes         |
|                           |                    |automáticamente instalados. |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar cualquier        |
|                           |?variable:          |variable que encaja con      |
|?bind(variable, patrón)   |nombre_del_término[|patrón; véase              |
|                           |(argumentos)]       |&#8220;Objetivos explícitos |
|                           |                    |de búsqueda.&#8221;.        |
|___________________________|____________________|_____________________________|
|?broken                    |~b                  |Seleccionar paquetes con una |
|                           |                    |dependencia rota.            |
|___________________________|____________________|_____________________________|
|                           |~Btipodep (tipo de  |Seleccionar cualquier paquete|
|?broken-tipodep            |dependencia)        |con una dependencia rota del |
|                           |                    |tipodep dado.                |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar cualquier paquete|
|?broken-tipodep(patrón)   |~DB[tipodep:]patrón|con una dependencia rota del |
|                           |                    |tipodep dado que encaje con  |
|                           |                    |patrón.                     |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes sobre   |
|?broken-reverse-tipodep    |                    |los que un paquete que encaja|
|(patrón)                  |~RB[tipodep:]patrón|con él patrón declara una  |
|                           |                    |dependencia rota del tipo    |
|                           |                    |tipodep.                     |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes que     |
|?conflicts(patrón)        |~Cpatrón           |entran en conflicto con un   |
|                           |                    |paquete que encaja con       |
|                           |                    |patrón.                     |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes         |
|?config-files              |~c                  |desinstalados pero no        |
|                           |                    |purgados.                    |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes que     |
|?tipodep(patrón)          |~D[tipodep:]patrón |declaran una dependencia de  |
|                           |                    |tipo tipodep sobre un paquete|
|                           |                    |que encaja con patrón.      |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes cuya    |
|?description(descripción) |~ddescripción      |descripción encaja con      |
|                           |                    |descripción.                |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes         |
|?essential                 |~E                  |esenciales, aquellos con     |
|                           |                    |Essential: yes en sus        |
|                           |                    |archivos de control.         |
|___________________________|____________________|_____________________________|
|?exact-name(nombre)        |�                   |Seleccionar paquetes llamados|
|                           |                    |nombre.                      |
|___________________________|____________________|_____________________________|
|?false                     |~F                  |No seleccionar paquetes.     |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes que     |
|                           |                    |encajan el patrón con la    |
|?for variable: patrón     |�                   |variable ligada al paquete   |
|                           |                    |con que se empareja; véase  |
|                           |                    |&#8220;Objetivos explícitos |
|                           |                    |de búsqueda.&#8221;.        |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes que     |
|?garbage                   |~g                  |ningún paquete instalado    |
|                           |                    |manualmente requiere.        |
|___________________________|____________________|_____________________________|
|?installed                 |~i                  |Seleccionar paquetes         |
|                           |                    |instalados.                  |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes cuyo    |
|?maintainer(desarrollador) |~mdesarrollador     |responsable es el            |
|                           |                    |desarrollador.               |
|___________________________|____________________|_____________________________|
|                           |                    |Select packages with a multi-|
|                           |                    |arch capability of multiarch |
|                           |                    |(that is, either             |
|?multiarch(multiarch)      |�                   |&#8220;foreign&#8221;,       |
|                           |                    |&#8220;same&#8221;,          |
|                           |                    |&#8220;allowed&#8221;, or    |
|                           |                    |&#8220;none&#8221;).         |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes que     |
|?narrow(filtro, patrón)   |~S filtro patrón   |encajan con ambos filtro y   |
|                           |                    |patrón en una sola versión.|
|___________________________|____________________|_____________________________|
|?name(nombre)              |~nnombre, nombre    |Seleccionar paquetes con el  |
|                           |                    |nombre dado.                 |
|___________________________|____________________|_____________________________|
|?new                       |~N                  |Seleccionar paquetes nuevos. |
|___________________________|____________________|_____________________________|
|?obsolete                  |~o                  |Buscar paquetes instalados   |
|                           |                    |que no se pueden descargar.  |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes que     |
|?or(patrón1, patrón2)    |patrón1 | patrón2 |encajan con patrón1,        |
|                           |                    |patrón2, o ambos.           |
|___________________________|____________________|_____________________________|
|?origin(origen)            |~Oorigen            |Seleccionar paquetes con el  |
|                           |                    |origen dado.                 |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes que     |
|?provides(patrón)         |~Ppatrón           |proveen un paquete que encaja|
|                           |                    |con el patrón.              |
|___________________________|____________________|_____________________________|
|?priority(prioridad)       |~pprioridad         |Seleccionar paquetes con la  |
|                           |                    |prioridad dada.              |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes que son |
|                           |                    |objetivo de una dependencia  |
|?reverse-tipodep(patrón)  |~R[tipodep:]patrón |de tipo tipodep declarado por|
|                           |                    |un paquete que encaja con    |
|                           |                    |patrón.                     |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes que son |
|                           |                    |el objetivo de una           |
|?reverse-broken-tipodep    |~RB[tipodep:]patrón|dependencia rota de tipo     |
|(patrón)                  |                    |tipodep declarado por un     |
|                           |                    |paquete que encaja con       |
|                           |                    |patrón.                     |
|___________________________|____________________|_____________________________|
|?section(sección)         |~ssección          |Seleccionar paquetes en la   |
|                           |                    |sección dada.               |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes cuyo    |
|?source-package(nombre)    |�                   |nombre de paquete fuente     |
|                           |                    |encaja con la expresión     |
|                           |                    |regular nombre.              |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes cuya    |
|?source-version(versión)  |�                   |versión de paquete fuente   |
|                           |                    |encaja con la expresión     |
|                           |                    |regular versión.            |
|___________________________|____________________|_____________________________|
|?tag(etiqueta)             |~Getiqueta          |Seleccionar paquetes con la  |
|                           |                    |etiqueta debtags dada.       |
|___________________________|____________________|_____________________________|
|                           |                    |Búsqueda completa de texto  |
|?term(palabra_clave)       |�                   |para paquetes que contienen  |
|                           |                    |la palabra_clave dada.       |
|___________________________|____________________|_____________________________|
|                           |                    |Búsqueda completa de texto  |
|?term-prefix(palabra_clave)|�                   |de paquetes que contienen una|
|                           |                    |palabra clave que comienza   |
|                           |                    |con la palabra_clave.        |
|___________________________|____________________|_____________________________|
|?true                      |~T                  |Seleccionar todos los        |
|                           |                    |paquetes.                    |
|___________________________|____________________|_____________________________|
|?task(tarea)               |~ttarea             |Seleccionar paquetes dentro  |
|                           |                    |de la tarea especificada.    |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes         |
|?upgradable                |~U                  |instalados susceptibles de   |
|                           |                    |actualización.              |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes marcados|
|                           |                    |con una etiqueta de usuario  |
|?user-tag                  |�                   |que encaje con la expresión |
|                           |                    |regular user-tag (etiqueta de|
|                           |                    |usuario).                    |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar paquetes cuya    |
|?version(versión)         |~Vversión          |versión encaja con versión |
|                           |                    |(valores especiales: CURRENT,|
|                           |                    |CANDIDATE, y TARGET).        |
|___________________________|____________________|_____________________________|
|?virtual                   |~v                  |Seleccionar paquetes         |
|                           |                    |virtuales.                   |
|___________________________|____________________|_____________________________|
|                           |                    |Seleccionar versiones para   |
|                           |                    |los cuales el patrón encaja |
|?widen(patrón)            |~Wpatrón           |con cualquier versión del   |
|                           |                    |paquete correspondiente,     |
|                           |                    |descartando las restricciones|
|                           |                    |locales de versiones.        |
|___________________________|____________________|_____________________________|





  nombre
      Emparejar paquetes cuyos nombres encajan con la expresión regular nombre.
      Éste es el modo de búsqueda &#8220;predeterminado&#8221; y se emplea con
      patrones que no comienzan con ~.


       [Nota]  Nota

               Use el término ?name (descrito abajo) para encontrar paquetes
               cuyos nombres contengan diferentes sub-cadenas; por ejemplo,
               &#8220;?name(apti)?name(tude)&#8221; busca cualquier paquete cuyo
               nombre contiene ambos &#8220;apti&#8221; y &#8220;tude&#8221;.



  ?=variable
      Buscar paquetes que se corresponden con el valor de variable, que se debe
      cerrar con ?for. Por ejemplo, ?for x: ?depends( ?recommends( ?=x ) ) busca
      todo paquete x que dependa de un paquete que recomienda x.

      Por ejemplo, la siguiente expresión de búsqueda reúne paquetes que
      entran en conflicto con ellos mismos:

      Ejemplo 2.2. Uso del término ?=.

      ?for x: ?conflicts(?=x)


      Para más información, véase &#8220;Objetivos explícitos de
      búsqueda.&#8221;.


  ?not(patrón), !patrón
      Buscar paquetes que no encajan con el patrón patrón. Por ejemplo,
      &#8220;?not(?broken)&#8221; selecciona paquetes que no están
      &#8220;rotos&#8221;.


       [Nota]  Nota

               Para poder incluir &#8220;!&#8221; en una cadena de búsqueda,
               debe tener un &#8220;escape&#8221; introduciendo una tilde
               (&#8220;~&#8221;) delante de el; de no ser así, aptitude lo
               considerará como parte de un término ?not. Por ejemplo, para
               seleccionar paquetes cuya descripción contenga
               &#8220;extra!&#8221;, use &#8220;?description(extra~!)&#8221;.



  ?and(patrón1, patrón2), patrón1 patrón2
      Buscar paquetes que encajan con ambos patrón1 y patrón2.


  ?or(patrón1, patrón2), patrón1 | patrón2
      Buscar paquetes que encajan con el patrón1 o el patrón2.


       [Nota]  Nota

               Para poder emplear el carácter &#8220;|&#8221; en una expresión
               regular, debe tener un &#8220;escape&#8221; para impedir que
               aptitude genere un término OR de el: &#8220;~|&#8221;.



  (patrón)
      Buscar patrón. Por ejemplo, &#8220;opengl (perl|python)&#8221; busca
      cualquier paquete cuyo nombre contenga opengl, así como también perl o
      python.


  ?action(acción), ~aacción
      Buscar paquetes marcados para la acción introducida. La acción puede ser
      &#8220;install&#8221; (instalar), &#8220;upgrade&#8221; (actualizar),
      &#8220;downgrade&#8221; (desactualizar), &#8220;remove&#8221; (eliminar),
      &#8220;purge (purgar)&#8221;, &#8220;hold&#8221; (retener, revisa si
      algún paquete se ha retenido), o &#8220;keep&#8221; (mantener, revisa si
      algún paquete permanecerá sin cambios).

      Observe que ésto solo revisa si hay alguna acción por realizar sobre un
      paquete, no si se podría llevar a cabo. Por ello, por ejemplo, ?action
      (upgrade) busca aquellos paquetes que haya decidido actualizar, no los
      paquetes que se podrían actualizar en el futuro (para ello, use
      ?upgradable).


  ?all-versions(patrón)
      Buscar todo paquete cuya versión se corresponde con la expresión dada.
      Cada versión de un paquete se comparará separadamente con el patrón, y
      el paquete encajará si todas sus versiones también lo hacen. Siempre se
      buscarán los paquetes sin versiones, tales como los paquetes virtuales,
      con este término de búsqueda.

      Este término no se puede ser usar en un contexto en el cual las versiones
      a comparar ya se han restringido, tales como dentro de ?depends o ?narrow.
      De todas formas, siempre se puede usar dentro de ?widen.


  ?any-version(patrón)
      Mostrar un paquete si cualquiera de sus versiones encajan con el patrón
      dado. Esta es la versión dual de ?all-versions.

      Este término no se puede ser usar en un contexto en el cual las versiones
      a comparar ya se han restringido, tales como dentro de ?depends o ?narrow.
      De todas formas, siempre se puede usar dentro de ?widen.


       [Nota]  Nota

               Este término tiene una estrecha relación con ?narrow. De hecho,
               ?any-version(patrón1 patrón2) es exactamente lo mismo que
               ?narrow(patrón1, patrón2).



  ?architecture(architecture), ~rarchitecture
      Matches package versions for the given architecture. For instance,
      &#8220;?architecture(amd64)&#8221; matches amd64 packages, while
      &#8220;?architecture(all)&#8221; matches arch-independent packages. Also
      accepts the special values native and foreign.


  ?archive(archivo), ~Aarchivo
      Buscar las versiones de paquetes disponibles desde un archivo que encaja
      con la expresión regular archivo. Por ejemplo, &#8220;?archive
      (testing)&#8221; encaja con cualquier paquete disponible en el archivo
      testing.


  ?automatic, ~M
      Buscar paquetes instalados automáticamente.


   ?bind(variable, patrón), ?variable:término[(argumentos)]
      Buscar cualquier paquete o versión si el patrón dado encaja con el
      paquete o versión ligado a la variable, que debe definir en un ?for de
      cierre.

      Ejemplo 2.3. Uso del término ?bind.

      ?for x: ?depends(?depends(?for z: ?bind(x, ?depends(?=z))))

      ?for x: ?depends(?depends(?for z: ?x:depends(?=z)))


      Los dos patrones de búsqueda en el ejemplo anterior encajan con cualquier
      paquete x de manera que x depende de un paquete y, el cual depende a su
      vez de un paquete z, de manera que x depende también de manera directa de
      z. El primer patrón emplea ?bind directamente, mientras que el segundo
      usa una sintaxis abreviada equivalente al primero.

      Para más información, véase &#8220;Objetivos explícitos de
      búsqueda.&#8221;.


  ?broken, ~b
      Buscar paquetes que están &#8220;rotos&#8221;: tienen dependencias
      insatisfechas, una pre-dependencia, rompen, o entran en conflicto.


  ?broken-tipodep, ~Btipodep
      Buscar paquetes con una dependencia no satisfecha (&#8220;roto&#8221;) del
      tipodep dado. El tipodep puede ser &#8220;depends&#8221; (depende),
      &#8220;predepends&#8221;(pre-depende), &#8220;recommends&#8221;
      (recomienda), &#8220;suggests&#8221; (sugiere), &#8220;breaks&#8221;
      (rompe), &#8220;conflicts&#8221; (entra en conflicto), o
      &#8220;replaces&#8221; (reemplaza).


  ?broken-tipodep(patrón), ~DB[tipodep:]patrón
      Buscar paquetes con una dependencia no satisfecha del tipo tipodep en un
      paquete que encaja con patrón. El tipodep puede ser cualquiera de los
      tipos de dependencias listados en la documentación de ?broken-tipodep.


  ?conflicts(patrón), ~Cpatrón
      Buscar paquetes que entran en conflicto con un paquete que encaja con el
      patrón dado. Por ejemplo, &#8220;?conflicts(?maintainer
      (dburrows@debian.org))&#8221; busca cualquier paquete que entra en
      conflicto con el paquete del que soy responsable.


  ?config-files, ~c
      Buscar paquetes desinstalados, pero cuyos archivos de configuración
      permanecen en el sistema (p. ej., se eliminaron pero no purgaron).


  ?tipodep(patrón), ~D[tipodep:]patrón
      El tipodep puede ser cualquiera de los tipos dependencia que se muestran
      en la documentación de ?broken-tipodep, así como provides: por ejemplo,
      ?depends(libpng3) muestra todo paquete que depende de libpng3. Si emplea
      la forma corta (~D) pero sin introducir tipodep,buscará depends de manera
      predeterminada.

      Si el tipodep es &#8220;provides&#8221;, muestra paquetes que proveen un
      paquete que encaja con patrón (el equivalente a ?provides). De no ser
      así, busca paquetes que declaran una dependencia de tipo tipodep sobre
      una versión de paquete que encaja con patrón.


  ?description(descripción), ~ddescripción
      Buscar paquetes cuya descripción se corresponde con la expresión regular
      descripción.


  ?essential, ~E
      Buscar paquetes Esenciales.


  ?exact-name(nombre)
      Buscar paquetes nombrados nombre. Funciona de manera similar a ?name, pero
      el nombre debe ser exacto. Por ejemplo, el siguiente patrón solo
      emparejaría el paquete apt; con ?name, también mostraría aptitude,
      uvcapture, etc.

      Ejemplo 2.4. Uso del término ?exact-name.

      ?exact-name(apt)



  ?false, ~F
      Este término no encaja con ningún paquete. [18]


  ?for variable: patrón
      Buscar patrón, pero puede emplear la variable dentro del patrón para
      referirse al paquete o versión del paquete.

      Puede emplear variable de dos maneras. Para usar un término del tipo ?,
      escriba ?variable:nombre_término(argumentos); por ejemplo, ?x:depends
      (apt). Además, el término ?=variable selecciona todo paquete o versión
      que se corresponde con el valor de la variable.

      Por ejemplo, el siguiente término busca cualquier paquete x que
      recomienda y depende de un segundo paquete y.

      Ejemplo 2.5. Uso del término ?for.

      ?for x: ?depends( ?for y: ?x:recommends( ?=y ) )


      Para más información, véase &#8220;Objetivos explícitos de
      búsqueda.&#8221;.


  ?garbage, ~g
      Buscar paquetes que no están instalados, o que se instalaron
      automáticamente y que no son dependencia de ningún paquete instalado.


  ?installed, ~i
      Buscar versiones de paquetes instalados.

      Debido a que de manera predeterminada se revisan todas las versiones,
      ésto generalmente muestra paquetes que están instalados.


  ?maintainer(desarrollador), ~mdesarrollador
      Buscar paquetes cuyo campo de desarrollador se corresponde con la
      expresión regular desarrollador. Por ejemplo, &#8220;?maintainer
      (joeyh)&#8221; mostraría todos los paquetes mantenidos por Joey Hess.


  ?multiarch(multiarch)
      Matches packages with the multi-arch capability specified by multiarch.
      For instance, &#8220;?multiarch(foreign)&#8221; will find all packages
      which can satisfy dependencies of packages for another architecture.
      &#8220;?multiarch(none)&#8221; will select packages with no multi-arch
      capability.


   ?narrow(filtro, patrón), ~S filtro patrón
      Este término &#8220;restringe&#8221; la búsqueda a las versiones de
      paquetes que se corresponden con filtro. En particular, muestra cualquier
      versión del paquete que encaja con ambos filtro y patrón. El valor de la
      cadena de la correspondencia es el valor de patrón.


  ?name(nombre), ~nnombre
      Buscar paquetes cuyo nombre encaja con la expresión regular nombre. Por
      ejemplo, la mayoría de los paquetes que encajan con &#8220;?name
      (^lib)&#8221; son bibliotecas de un tipo u otro.


  ?new, ~N
      Buscar paquetes &#8220;nuevos&#8221;: ésto es, que se han añadido al
      archivo desde la última vez que limpió la lista de paquetes usando
      Acciones ->; Olvidar paquetes nuevos (f) o la acción en línea de
      órdenes forget-new.


   ?obsolete, ~o
      Este término busca todo paquete instalado no disponible en ninguna de sus
      versiones desde cualquier archivo. Estos paquetes aparecen en la interfaz
      gráfica como &#8220;Paquetes obsoletos o creados localmente&#8221;.


  ?origin(origen), ~Oorigen
      Buscar versiones de un paquete cuyo origen encaja con la expresión
      regular origen. Por ejemplo, &#8220;!?origin(debian)&#8221; muestra
      cualquier paquete no oficial en su sistema (paquetes que no provienen del
      archivo de Debian).


  ?provides(patrón), ~Ppatrón
      Buscar versiones de un paquete que proveen otro que encaja con patrón.
      Por ejemplo, &#8220;?provides(mail-transport-agent)&#8221; muestra todos
      los paquetes que proveen &#8220;mail-transport-agent&#8221;.


  ?priority(prioridad), ~pprioridad
      Buscar paquetes cuya prioridad es prioridad; La prioridad puede ser extra,
      important, optional, required, o standard. Por ejemplo, &#8220;?priority
      (required)&#8221; muestra aquellos paquetes con una prioridad
      &#8220;required&#8221;.


  ?reverse-tipodep(patrón), ~R[tipodep:]patrón
      tipodep puede ser &#8220;provides&#8221; o uno de los tipos de
      dependencias ilustrados en la documentación de ?broken-tipodep. Si
      tipodep no está presente, depends es el argumento predeterminado.

      Si tipodep es &#8220;provides&#8221;, muestra los paquetes cuyo nombre es
      provisto por una versión de un paquete que se corresponde con patrón. De
      no ser así, muestra paquetes con una versión de paquete que se
      corresponde con patrón y sobre la cual declara un dependencia tipodep.


  ?reverse-broken-tipodep(patrón), ?broken-reverse-tipodep(patrón), ~RB
  [tipodep:]patrón
      tipodep puede ser &#8220;provides&#8221; o uno de los tipos de
      dependencias ilustrados en la documentación de ?broken-tipodep. Si
      tipodep no está presente, depends es el argumento predeterminado.

      Buscar paquetes con una versión de paquete que encaja con patrón sobre
      la que declara una dependencia insatisfecha de tipodep.


   ?section(sección), ~ssección
      Buscar paquetes cuya sección coincide con la expresión regular sección.


   ?source-package(nombre)
      Buscar paquetes cuyo nombre de paquete fuente coincide con la expresión
      regular nombre.


   ?source-version(versión)
      Buscar paquetes cuya versión de paquete fuente coincide con la expresión
      regular versión.


  ?tag(etiqueta), ~Getiqueta
      Buscar paquetes cuyo campo de «Tag» (etiqueta) coincide con la
      expresión regular etiqueta. Por ejemplo, el patrón ?tag(game::strategy)
      mostraría juegos de estrategia.

      Para más información acerca de etiquetas y debtags, véase http://
      debtags.alioth.debian.org.


   ?task(tarea), ~ttarea
      Buscar paquetes agrupados bajo una tarea cuyo nombre coincide con la
      expresión regular tarea.


   ?term(palabra_clave)
      Este término ejecuta una búsqueda completa de texto de palabra_clave en
      el almacén de paquetes de apt. Cuando se usa con &#8220;aptitude
      search&#8221;, Buscar ->; Limitar vista (l) en la interfaz de curses,
      o introducido en el espacio de la ventana de búsqueda de la interfaz de
      usuario GTK+, este término permite a aptitude acelerar la búsqueda
      usando un índice Xapian.


   ?term-prefix(palabra_clave)
      Este término ejecuta una búsqueda completa de texto de cualquier palabra
      clave que comienza con la palabra_clave en el almacén de paquetes de apt.
      Cuando se usa con &#8220;aptitude search&#8221;, Buscar ->; Limitar
      vista (l) en la interfaz de curses, o introducido en el espacio de la
      ventana de búsqueda de la interfaz de usuario GTK+, este término permite
      a aptitude acelerar la búsqueda usando un índice Xapian.

      Ésto es similar a ?term, pero empareja las extensiones de palabraclave.
      Por ejemplo, el siguiente patrón de búsqueda muestra todo paquete
      indexado bajo las palabras clave hour, hourglass, hourly, y así en
      adelante.

      Ejemplo 2.6. Uso del término ?term-prefix.

      ?term-prefix(hour)



   ?true, ~T
      Este término empareja todo paquete. Por ejemplo
      &#8220;?installed?provides(?true)&#8221; muestra los paquetes instalados
      que cualquier otro provee.


   ?upgradable, ~U
      Este término busca cualquier paquete instalado susceptible de
      actualización.


   ?user-tag(etiqueta)
      Este término busca todo paquete marcado con un «user-tag» que se
      corresponde con la expresión regular etiqueta.


   ?version(versión), ~Vversión
      Buscar cualquier versión de paquete cuyo número de versión se
      corresponde con la expresión regular versión, con las excepciones
      mencionadas posteriormente. Por ejemplo, &#8220;?version(debian)&#8221;
      muestra paquetes cuya versión contiene &#8220;debian&#8221;.

      Los siguientes valores de versión se tratan de manera específica. Para
      buscar un número de versión que contiene estos valores, preceda el valor
      con una barra inversa; por ejemplo, para encontrar versiones de paquetes
      cuyo número contiene CURRENT, busque con \CURRENT.


      * CURRENT busca la versión instalada del paquete, de existir.

      * CANDIDATE busca la versión, de existir, del paquete que se instalaría
        si pulsa + sobre el paquete o ejecuta aptitude install sobre el paquete.

      * TARGET busca la versión de un paquete marcado para su instalación, de
        existir.



   ?virtual, ~v
      Buscar cualquier paquete puramente virtual; esto es, que un paquete provee
      su nombre o que se menciona como dependencia, sin que exista ningún
      paquete con tal nombre. Por ejemplo &#8220;?virtual!?provides
      (?true)&#8221; muestra paquetes que son virtuales y que ningún otro
      paquete provee: declarados como dependencia pero que no existen.


   ?widen(patrón), ~Wpatrón
      &#8220;Extender&#8221; la búsqueda: si se ha usado un término de cierre
      (tales como ?depends) en la búsqueda de versiones, estos límites
      desaparecen. Por ello, ?widen(patrón) muestra la versión de un paquete
      si el patrón se corresponde con cualquier versión de ese paquete.



Personalizar aptitude


Personalizar la lista de paquetes.

Puede personalizar la lista de paquetes de varias maneras: la presentación de
los paquetes, como se crea la jerarquía de paquetes, como se agrupan los
paquetes e incluso configurar la pantalla principal.


Personalizar la presentación de los paquetes

Esta sección describe como configurar los contenidos y el formato de la lista
de paquetes, la línea de estado y la de cabecera, así como la salida de
aptitude search.

Puede definir el formato de cada uno de estos espacios con una &#8220;cadena
formato&#8221;. Una cadena formato es una cadena de texto que contiene escapes
tales como % %p, %S, y más. La salida resultante se crea tomando el texto para
reemplazar los escapes % de acuerdo a su significado (explicados a
continuación).

Un escape % puede tener un tamaño definido, en cuyo caso siempre se
reemplazaría con la misma cantidad de texto (con espacios añadidos para
rellenar si es necesario), o puede ser &#8220;ampliable&#8221;, tomando el
espacio que las columnas de tamaño fijo no requieren. De existir varias
columnas ampliables, el espacio se distribuye de manera equitativa.

Todos los escapes % tienen un tamaño y/o capacidad de ampliación. Puede
cambiar el tamaño de un escape % insertándolo entre % y el carácter que
identifica el escape; por ejemplo, %20V genera la versión candidata del
paquete, 20 caracteres de ancho. El ancho &#8220;básico&#8221; de la columna
puede variar dependiendo del contenido si inserta un signo de interrogación (?)
entre % y el carácter que identifica el escape. Cabe que las columnas
resultantes no se puedan alinear verticalmente.

Si desea poder ampliar un escape % en particular, a pesar de tener un ancho
definido, inserte una celdilla (p. ej., &#8220;#&#8221;) a su derecha. Por
ejemplo, para mostrar la versión candidata de un paquete sin importar su
longitud, use la cadena formato %V#. Puede también insertar # después de algo
que no es un escape %; aptitude &#8220;ampliará&#8221; el texto que precede a #
añadiendo espacios tras él.

En resumen, la sintaxis de un escape % es:

%[ancho][?]código[#]

Las variables de configuración Aptitude::UI::Package-Display-Format, Aptitude::
UI::Package-Status-Format, y Aptitude::UI::Package-Header-Format definen la
forma predeterminada de la lista de paquetes, la cabecera en lo alto de la lista
de paquetes, y la línea de estado debajo de la lista de paquetes,
respectivamente. Para cambiar la manera en que se muestran los resultados de una
orden aptitude search, use la opción -F.

Los siguientes escapes % están disponibles en cadenas formato:


 [Nota]  Nota

         Algunas de las descripciones a continuación se refieren al
         &#8220;paquete&#8221;. En la interfaz gráfica de usuario (GUI), esto
         es el paquete que está visionando o el seleccionado; en la busca en
         línea de órdenes, esto es el paquete que está visionando



Escape    Nombre        Tamaño              Ampliable Descripción
                        predeterminado

                                                       Ésto no es realmente un
%%        Literal %     1                    No        escape; sólo inserta un
                                                       signo porcentual en la salida
                                                       en el momento en que aparece.

                                                       En algunas circunstancias,
                                                       una cadena formato de
                                                       presentación puede tener
                                                       &#8220;parámetros&#8221;:
                                                       por ejemplo, en el search de
          Reemplazo de                                 línea de órdenes, los
%#número parámetro    Variable             No        grupos encontrados en la
                                                       búsqueda se usan como
                                                       parámetros al presentar el
                                                       resultado. El parámetro, que
                                                       se indica con número,
                                                       reemplaza al código del
                                                       formato.

                                                       Una marca de un solo
                                                       carácter que resume
                                                       cualquier acción que se va a
%a        Marca de      1                    No        ejecutar sobre el paquete,
          acción                                      tal y como se describe en
                                                       Figura� 2.10, &#8220;Valores
                                                       de la marca de
                                                       &#8220;acción&#8221;&#8221;.

                                                       Una descripción algo más
%A        Acción       10                   No        detallada de la acción que
                                                       se va a ejecutar sobre el
                                                       paquete.

                                                       Si no hay paquetes rotos, no
                                                       produce nada. De otra forma,
%B        Total rotos   12                   No        genera una cadena como por
                                                       ejemplo &#8220;Broken:
                                                       10&#8221;, que describe el
                                                       número de paquetes rotos.

                                                       Una marca de un solo
                                                       carácter que resume el
          Marca de                                     estado actual del paquete,
%c        estado actual 1                    No        tal y como se describe en
                                                       Figura� 2.9, &#8220;Valores
                                                       de la marca de &#8220;estado
                                                       actual&#8221;&#8221;.

                                                       Una descripción más
%C        Estado actual 11                   No        detallada del estado actual
                                                       del paquete.

%d        Descripción  40                   Si        La descripción corta del
                                                       paquete.

          El tamaño                                   El tamaño del archivo del
%D        del paquete   8                    No        paquete que contiene el
                                                       paquete.

          Nombre del                                   El nombre del ordenador en el
%H        anfitrión    15                   No        que ejecuta aptitude.
          («host»)

                                                       Mostrar la prioridad más
                                                       alta asignada a la versión
                                                       de un paquete; para paquetes,
%i        Prioridad pin 4                    No        muestra la prioridad de la
                                                       versión que se va a instalar
                                                       de forma predeterminada (de
                                                       existir).

          Tamaño                                      El espacio aproximado que el
%I        instalado     8                    No        paquete ocupará en el disco
                                                       duro.

%m        Desarrollador 30                   Si        El desarrollador del paquete.

                                                       Si el paquete esta
          Marca de                                     automáticamente instalado,
%M        automático   1                    No        da como salida
                                                       &#8220;A&#8221;; si no, no
                                                       devuelve nada.

                                                       Mostrar la versión de
%n        Versión del  La longitud de       No        aptitude que está
          programa      &#8220;0.6.6&#8221;.           ejecutando, actualmente
                                                       &#8220;0.6.6&#8221;.

          Nombre del    La longitud del                Mostrar el nombre del
%N        programa      nombre.              No        programa; generalmente,
                                                       &#8220;aptitude&#8221;.

                                                       Si no se va a instalar
                                                       ningún paquete, no muestra
                                                       nada. De otra forma, muestra
                                                       una cadena que describe el
%o        TamDescarga   17                   No        tamaño total de todos los
                                                       paquetes que va a instalar
                                                       (una estimación de cuanto
                                                       necesita descargar); por
                                                       ejemplo &#8220;TamDesc:
                                                       1000B&#8221;.

                                                       Mostrar el nombre del
                                                       paquete. Cuando vea un
          Nombre del                                   paquete en un contexto de
%p        paquete       30                   Si        árbol, su nombre estará en
                                                       negrita, de ser posible, de
                                                       acuerdo a su profundidad en
                                                       el árbol.

%P        Prioridad     9                    No        Mostrar la prioridad de un
                                                       paquete.

          Total de                                     Mostrar el número aproximado
%r        dependencias  2                    No        de paquetes instalados que
          inversas                                     dependen del paquete.

                                                       Mostrar una descripción
          Prioridad                                    abreviada de la prioridad de
%R        abreviada     3                    No        un paquete: por ejemplo
                                                       &#8220;Important&#8221; pasa
                                                       a ser &#8220;Imp&#8221;.

%s        Sección      10                   No        Mostrar la sección del
                                                       paquete

%S        Estado de     1                    No        Mostrar la letra «U» si el
          confianza                                    paquete no está firmado.

%t        Archivo       10                   Si        El archivo en el que se
                                                       encuentra el paquete.

                                                       Mostrar &#8220;*&#8221; si el
%T        Etiqueta      1                    No        paquete está etiquetado, de
                                                       no ser así, no devuelve
                                                       nada.[19]

                                                       Si las acciones seleccionadas
                                                       van a alterar la cantidad de
                                                       espacio usado en el disco,
%u        Cambio de uso 30                   No        muestra la descripción del
          de disco                                     cambio en el espacio del
                                                       disco duro; por ejemplo
                                                       &#8220;Se usará 100MB de
                                                       espacio en disco.&#8221;

          Versión                                     Mostrar la versión instalada
%v        actual        14                   No        del paquete, o <none> si el
                                                       paquete no está instalado.

                                                       Mostrar la versión del
                                                       paquete que puede instalar si
%V        Versión      14                   No        ejecuta Paquete ->;
          candidata                                    Instalar (+) sobre el
                                                       paquete, o <none> si el
                                                       paquete no está disponible.

                                                       Mostrar cuanto espacio
                                                       adicional se va a usar, o
%Z        Cambio de     9                    No        cuanto espacio se va a
          espacio                                      liberar al instalar,
                                                       actualizar o eliminar un
                                                       paquete.



Personalizar la jerarquía de paquetes

La jerarquía de paquetes se genera a través de una directriz de agrupación:
reglas que describen como se debe construir la jerarquía. Una directriz de
agrupación describe una &#8220;segmentación&#8221; de reglas; cada regla puede
descartar paquetes, crear sub-jerarquías en los cuales los paquetes residen, o
manipular el árbol. Los elementos de configuración Aptitude::UI::Default-
Grouping y Aptitude::UI::Default-Preview-Grouping definen las directrices de
agrupación para listas de paquetes recién creadas y pantallas de
previsualización, respectivamente. Puede configurar la directriz de agrupación
para la lista de paquetes actual pulsando G.

Una directriz de agrupación se describe con una lista separada por comas de
reglas: regla1,regla2,.... Cada regla consiste de su nombre, posiblemente
seguido de argumentos: por ejemplo, versions o section(subdir). El tipo de regla
determina si se necesitan argumentos, y cuantos.

Una regla puede ser no-terminal o terminal. Una regla no-terminal procesa un
paquete generando parte de la jerarquía, para después filtrar el paquete con
otra regla. Una regla terminal, por otra parte, también genera parte del árbol
(por lo general, elementos correspondientes al paquete), pero no filtra el
paquete con otra regla posterior. Si no especifica una regla terminal, aptitude
usará la regla predeterminada, que es crear los &#8220;elementos de
paquete&#8221; estándar.



  action

      Agrupar paquetes de acuerdo a la acción que se va a realizar sobre ellos;
      se ignorarán paquetes sin cambios y no actualizables. Éste es el
      agrupamiento que se emplea en los árboles de previsualización.


  architecture

      Groups packages according to their architecture.


  deps

      Ésta es una regla terminal.

      Creación de elementos de paquete estándar que puede expandir para
      mostrar las dependencias del paquete.


  filter(patrón)

      Incluir sólo paquetes con al menos una versión que coincide con patrón.

      No descartar ningún paquete si &#8220;no hay&#8221; un patrón. Ésta es
      una característica de compatibilidad inversa y puede quedar obsoleta en
      el futuro.


  firstchar

      Agrupar paquetes en base al primer carácter del nombre.


  hier

      Agrupar paquetes de acuerdo a un archivo de datos adicional que describe
      una &#8220;jerarquía&#8221; de paquetes.


  pattern(patrón [=> título] [{ directriz }] [, ...])

      Una directriz de agrupación que puede personalizar. Cada versión de cada
      paquete se compara con el patrón dado. La primera correspondencia se
      emplea para asignar un título al paquete; entonces, los paquetes se
      agrupan según su título. Las cadenas con forma \N que aparecen en
      título se reemplazan por el enésimo resultado de la búsqueda. Si
      título no está presente, se toma como \1. Observe que los paquetes que
      no se corresponden con ningún patrón no aparecen en el árbol.

      Ejemplo 2.7. Uso de pattern (patrón) para agrupar paquetes en base a su
      desarrollador.

      pattern(?maintainer() => \1)


      El ejemplo anterior agrupa paquetes de acuerdo al campo de desarrollador.
      La directriz pattern(?maintainer()) realiza la misma función, al igual
      que un título ausente pasa a ser \1 de manera predeterminada.

      Cabe que una entrada finalice en ||, en lugar de => título. Esto indica
      que los paquetes que se corresponden con patrón se insertaran en el
      árbol al mismo nivel que el agrupación patrón, en lugar de insertarlos
      en sub-árboles.

      Ejemplo 2.8. Uso de pattern con algunos paquetes del nivel superior.

      pattern(?action(remove) => Packages Being Removed, ?true ||)


      El ejemplo anterior muestra las paquetes que se van a eliminar en un sub-
      árbol, y muestra todos los demás paquetes en el nivel actual, agrupados
      de acuerdo a las directrices que sigue pattern (patrón).

      De manera predeterminada, todos los paquetes que se corresponden con cada
      patrón se agrupan de acuerdo a las reglas que sigue la directriz del
      pattern. Para especificar una directriz diferente para algunos paquetes,
      describa la directriz entre llaves ({}) a continuación del titulo del
      grupo, después de ||, o después del patrón, en caso de que ninguno este
      presente. Por ejemplo:

      Ejemplo 2.9. Uso de la directriz de agrupación pattern con sub-
      directrices.

      pattern(?action(remove) => Packages Being Removed {}, ?action(install) =>
      Packages Being Installed, ?true || {status})


      La directriz del ejemplo anterior tiene los siguientes efectos:


      * Los paquetes que se van a eliminar se muestran en un sub-árbol
        etiquetado &#8220;Paquetes que se eliminarán&#8221;; la directriz de
        agrupación para este sub-árbol esta vacío, con lo cual se muestran
        los paquetes en una lista plana.

      * Los paquetes que se van a instalar se muestran en un árbol etiquetado
        Paquetes que se instalarán y agrupados de acuerdo a las directrices que
        sigue pattern.

      * Todos los paquetes restantes se ubican en el nivel mas alto del árbol,
        agrupados de acuerdo a su estado.


      Véase &#8220;Patrones de búsqueda&#8221; para más información acerca
      del formato de patrón.


  prioridad

      Agrupar paquetes de acuerdo a su prioridad.


  section[(modo[,passthrough])]

      Agrupar paquetes de acuerdo a su campo de Sección.

      modo puede ser uno de los siguientes:



        none
            Agrupar en base a todo el campo de la sección, con lo cual se crean
            categorías tales como &#8220;non-free/games&#8221;. Ésta es la
            manera predeterminada si no se especifica el modo.


        topdir
            Agrupar en base a la parte del campo de la sección antes del primer
            signo /; si esta parte de la sección no se reconoce, o si no hay un
            / se usará la primera entrada en la lista Aptitude::Sections::Top-
            Sections.


        subdir
            Agrupar en base a la parte del campo de sección después del primer
            signo /, de estar en la lista Aptitude::Sections::Top-Sections. En
            caso contrario, o en ausencia de /, agrupa en base a todo el campo
            de la sección.


        subdirs
            Agrupar en base a la parte del campo de la Sección después del
            primer signo /, si la porción del campo que lo antecede está
            dentro de la lista Aptitude::Sections::Top-Sections; si no, o en
            ausencia de /, se usará todo el campo. Si hay varios signos / en la
            porción del campo que esta en uso, se formará una jerarquía de
            grupos. Por ejemplo, si &#8220;games&#8221; no es un miembro de
            Aptitude::Sections::Top-Sections, entonces un paquete con una
            sección de &#8220;games/arcade&#8221; se colocará debajo de la
            cabecera de nivel superior &#8220;games&#8221;, en un sub-árbol
            llamado &#8220;arcade&#8221;.


      En presencia de passthrough, aquellos paquetes que por una razón u otra
      no tienen una sección real (por ejemplo, paquetes virtuales) pasarán
      directamente al siguiente nivel de agrupación sin ser primero colocados
      en sub-categorías.


  status

      Agrupar paquetes en las siguientes categorías:


      * Actualizaciones de seguridad

      * Actualizables

      * New

      * Instalados

      * No instalados

      * Obsolete and Locally Created

      * Virtuales



  source

      Groups packages according to their source package name.


  tag[(faceta)]

      Agrupar paquetes de acuerdo a la información «Tag» (etiqueta) guardado
      en los archivos de paquetes Debian. Si introduce faceta solo se mostrarán
      las marcas correspondientes a esta faceta, y se ocultarán los paquetes
      que no poseen esta faceta; de otra forma, se muestran todos los paquetes
      al menos una vez (con paquetes sin etiquetar listados separadamente de los
      paquetes etiquetados).

      Para más información acerca de debtags, véase http://
      debtags.alioth.debian.org.


  task

      Crear un árbol llamado &#8220;Tareas&#8221; que contiene las tareas
      disponibles (la información acerca de las tareas es extraída de debian-
      tasks.desc, en el paquete tasksel). La regla que sigue a tarea creará sus
      categorías como hermanos de Tareas.


  versions

      Ésta es una regla terminal.

      Crear elementos estándar de paquete que se pueden expandir para mostrar
      las versiones del paquete.



Personalizar cómo se ordenan los paquetes

Por omisión, los paquetes en la lista de paquetes o en la salida de aptitude
search se ordenan por nombre. De todas formas, a menudo es bastante útil
ordenarlos de acuerdo a otros criterios (por ejemplo, por tamaño de paquete), y
aptitude le permite hacer precisamente esto modificando la directriz de
ordenación.

Al igual que la directriz de agrupación descrita en la sección anterior, la
directriz de ordenación es una lista separada por comas. Cada elemento de la
lista es el nombre de una regla de ordenación; si hay paquetes
&#8220;iguales&#8221; de acuerdo a la primera regla, se emplea la segunda regla
para ordenarlos, y así en adelante. Insertar un signo de tilde (~) delante de
una regla revierte el significado normal de esa regla. Por ejemplo,
priority,~name ordena paquetes por prioridad, pero los paquetes con la misma
prioridad se colocarán en orden inverso de acuerdo a su nombre.

Para modificar la directriz de ordenación en una lista de paquetes activa,
pulse S. Para modificar la ordenación predeterminada de todas las listas de
paquetes, configure la opción de configuración Aptitude::UI::Default-Sorting.
Para modificar la directriz de ordenación de búsqueda en aptitude, use la
opción de línea de órdenes --sort.

Las reglas disponibles son:



  installsize
      Ordenar paquetes según la cantidad estimada de espacio que necesitan
      cuando se instalan.


  name
      Ordenar paquetes por nombre.


  priority
      Ordenar paquetes por prioridad.


  version
      Ordenar paquetes de acuerdo a su número de versión.



Personalizar teclas rápidas.

Puede personalizar las teclas empleadas para activar órdenes en aptitude en el
archivo de configuración. Cada orden tiene una variable de configuración
asociada en Aptitude::UI::Keybindings; para cambiar la tecla ligada a una orden,
simplemente configure la variable correspondiente a la tecla. Por ejemplo, para
hacer que la tecla s realice una búsqueda, cambie Aptitude::UI::Keybindings::
Search a &#8220;s&#8221;. Puede precisar que la tecla se debe pulsar «Control»
introduciendo &#8220;C-&#8221; delante de la tecla: por ejemplo, introducir
&#8220;C-s&#8221; en vez de &#8220;s&#8221; ligaría la búsqueda a Control+s en
vez de a s. Por último, puede ligar la misma orden a diferentes teclas de una
sola vez usando una lista separada por comas: por ejemplo, introducir
&#8220;s,C-s&#8221; causaría que ambos s y Control+s ejecutasen una búsqueda.

Las siguientes órdenes pueden ligarse a teclas configurando la variable
Aptitude::UI::Keybindings::orden, donde orden es el nombre de la orden que se va
ligar:

 ______________________________________________________________________________
|Orden                 |Predeterminado |Descripción                           |
|______________________|_______________|_______________________________________|
|                      |               |Si hay paquetes rotos y aptitude ha    |
|ApplySolution         |!              |sugerido una solución al problema,    |
|                      |               |aplicar inmediatamente la solución.   |
|______________________|_______________|_______________________________________|
|                      |               |Desplazarse al inicio de la pantalla   |
|Begin                 |home,C-a       |actual: a lo alto de una lista, o a la |
|                      |               |izquierda de una entrada de texto en un|
|                      |               |campo.                                 |
|______________________|_______________|_______________________________________|
|                      |               |Informar de un fallo en el paquete     |
|BugReport             |B              |seleccionado actualmente, empleando    |
|                      |               |reportbug.                             |
|______________________|_______________|_______________________________________|
|                      |               |Cancelar la interacción actual: por   |
|Cancel                |C-g,escape,C-[ |ejemplo, descarta una ventana de       |
|                      |               |dialogo o desactiva el menú.          |
|______________________|_______________|_______________________________________|
|                      |               |Mostrar el changelog.Debian (registro  |
|Changelog             |C              |de cambios Debian) del paquete         |
|                      |               |seleccionado o de la versión del      |
|                      |               |paquete.                               |
|______________________|_______________|_______________________________________|
|                      |               |Modificar la directriz de agrupación  |
|ChangePkgTreeGrouping |G              |de la lista de paquetes activa en ese  |
|                      |               |momento.                               |
|______________________|_______________|_______________________________________|
|ChangePkgTreeLimit    |l              |Modificar el limite de la lista de     |
|                      |               |paquetes actualmente activa.           |
|______________________|_______________|_______________________________________|
|ChangePkgTreeSorting  |S              |Modificar la directriz de ordenación  |
|                      |               |de la lista de paquetes activa.        |
|______________________|_______________|_______________________________________|
|ClearAuto             |m              |Marcar el paquete seleccionado como    |
|                      |               |manualmente instalado.                 |
|______________________|_______________|_______________________________________|
|CollapseAll           |]              |Cerrar el árbol seleccionado y todas  |
|                      |               |sus ramas en una lista jerárquica.    |
|______________________|_______________|_______________________________________|
|CollapseTree          |Sin ligar      |Cerrar el árbol seleccionado en una   |
|                      |               |lista jerárquica.                     |
|______________________|_______________|_______________________________________|
|                      |               |En el editor de jerarquías, almacena  |
|Commit                |N              |la posición del paquete actual en la  |
|                      |               |jerarquía y procede al siguiente      |
|                      |               |paquete.                               |
|______________________|_______________|_______________________________________|
|                      |               |Esto equivale a pulsar &#8220;Ok&#8221;|
|                      |               |en los cuadros de dialogo; si está    |
|Confirm               |enter          |interactuando con una pregunta de      |
|                      |               |elección múltiple de la línea de    |
|                      |               |estado, elige la opción               |
|                      |               |predeterminada.                        |
|______________________|_______________|_______________________________________|
|Cycle                 |tab            |Cambiar el foco del teclado al         |
|                      |               |siguiente &#8220;componente&#8221;.    |
|______________________|_______________|_______________________________________|
|CycleNext             |f6             |Pasar a la siguiente vista activa.     |
|______________________|_______________|_______________________________________|
|CycleOrder            |o              |Pasar por organizaciones               |
|                      |               |predeterminadas de la pantalla.        |
|______________________|_______________|_______________________________________|
|CyclePrev             |f7             |Pasar a la anterior vista activa.      |
|______________________|_______________|_______________________________________|
|DelBOL                |C-u            |Eliminar todo el texto entre el cursor |
|                      |               |y el inicio de la línea.              |
|______________________|_______________|_______________________________________|
|DelBack               |backspace,C-h  |Eliminar el carácter precedente al    |
|                      |               |insertar texto.                        |
|______________________|_______________|_______________________________________|
|DelEOL                |C-k            |Eliminar todo el texto desde el cursor |
|                      |               |al final de la línea.                 |
|______________________|_______________|_______________________________________|
|DelForward            |delete,C-d     |Eliminar el carácter bajo el cursor al|
|                      |               |insertar texto.                        |
|______________________|_______________|_______________________________________|
|Dependencies          |d              |Mostrar las dependencias del paquete   |
|                      |               |seleccionado.                          |
|______________________|_______________|_______________________________________|
|                      |               |Cuando examina la lista de paquetes,   |
|DescriptionCycle      |i              |realiza un ciclo de las vistas         |
|                      |               |disponibles en el área de             |
|                      |               |información.                          |
|______________________|_______________|_______________________________________|
|                      |               |Cuando examina la lista de paquetes,   |
|DescriptionDown       |z              |desplaza el área de información una  |
|                      |               |línea más abajo.                     |
|______________________|_______________|_______________________________________|
|                      |               |Cuando examina la lista de paquetes,   |
|DescriptionUp         |a              |desplaza el área de información una  |
|                      |               |línea hacia arriba.                   |
|______________________|_______________|_______________________________________|
|                      |               |Si no está en la pantalla de          |
|                      |               |previsualización, muestra una pantalla|
|DoInstallRun          |g              |de previsualización[a]; de estar      |
|                      |               |viendo esta pantalla, ejecuta un       |
|                      |               |proceso de instalación.               |
|______________________|_______________|_______________________________________|
|                      |               |Desplazarse hacia abajo: por ejemplo,  |
|Down                  |down,j         |desplaza el texto hacia abajo o        |
|                      |               |selecciona el siguiente elemento de la |
|                      |               |lista.                                 |
|______________________|_______________|_______________________________________|
|DpkgReconfigure       |R              |Ejecutar &#8220;dpkg-reconfigure&#8221;|
|                      |               |sobre el paquete seleccionado.         |
|______________________|_______________|_______________________________________|
|                      |               |De haber paquetes rotos, registra el   |
|DumpResolver          |*              |estado actual del solucionador de      |
|                      |               |problemas en un archivo (para corregir |
|                      |               |errores).                              |
|______________________|_______________|_______________________________________|
|EditHier              |E              |Abrir el editor de jerarquías.        |
|______________________|_______________|_______________________________________|
|                      |               |Desplazarse al final de la pantalla    |
|End                   |end,C-e        |actual: al final de la lista, o a la   |
|                      |               |derecha de un campo de entrada de      |
|                      |               |texto.                                 |
|______________________|_______________|_______________________________________|
|                      |               |Si hay paquetes rotos y aptitude ha    |
|ExamineSolution       |e              |sugerido una solución, muestra una    |
|                      |               |ventana de dialogo con una descripción|
|                      |               |detallada de la solución propuesta.   |
|______________________|_______________|_______________________________________|
|ExpandAll             |[              |Expandir el árbol seleccionado y todas|
|                      |               |sus ramas en una lista jerárquica.    |
|______________________|_______________|_______________________________________|
|ExpandTree            |Sin ligar      |Expandir el árbol seleccionado en una |
|                      |               |lista jerárquica.                     |
|______________________|_______________|_______________________________________|
|                      |               |Seleccionar la primera solución       |
|FirstSolution         |<              |generada por el solucionador de        |
|                      |               |problemas.                             |
|______________________|_______________|_______________________________________|
|                      |               |Prohibir que un paquete se actualice a |
|ForbidUpgrade         |F              |la versión disponible (o a una        |
|                      |               |versión en particular).               |
|______________________|_______________|_______________________________________|
|                      |               |Descartar toda información relativa a |
|ForgetNewPackages     |f              |qué paquetes son &#8220;nuevos&#8221; |
|                      |               |(vacía la lista de paquetes           |
|                      |               |&#8220;Paquetes nuevos&#8221;).        |
|______________________|_______________|_______________________________________|
|Help                  |?              |Mostrar la pantalla de ayuda en línea.|
|______________________|_______________|_______________________________________|
|                      |               |Desplazarse hacia delante en la        |
|HistoryNext           |down,C-n       |historia, en un editor de línea con   |
|                      |               |historia.                              |
|______________________|_______________|_______________________________________|
|                      |               |Desplazarse hacia atrás en la         |
|HistoryPrev           |up,C-p         |historia, en un editor de línea con   |
|                      |               |historia.                              |
|______________________|_______________|_______________________________________|
|Hold                  |=              |Retener un paquete.                    |
|______________________|_______________|_______________________________________|
|Install               |+              |Marcar un paquete para su instalación.|
|______________________|_______________|_______________________________________|
|                      |               |Marcar un solo paquete para su         |
|InstallSingle         |I              |instalación; todos los otros paquetes |
|                      |               |se mantendrán en su versión actual.  |
|______________________|_______________|_______________________________________|
|                      |               |Cancelar cualquier petición de        |
|Keep                  |:              |instalación o eliminación así como  |
|                      |               |todas las retenciones en un paquete.   |
|______________________|_______________|_______________________________________|
|                      |               |Seleccionar la última solución       |
|LastSolution          |<              |generada por el solucionador de        |
|                      |               |problemas.                             |
|______________________|_______________|_______________________________________|
|                      |               |Desplazarse a la izquierda: por        |
|Left                  |left,h         |ejemplo, mueve un menú a la izquierda |
|                      |               |de la barra de menú, o desplaza el    |
|                      |               |cursor a la izquierda si edita texto.  |
|______________________|_______________|_______________________________________|
|                      |               |En una lista jerárquica, selecciona el|
|                      |               |siguiente hermano del elemento         |
|LevelDown             |J              |actualmente seleccionado (el siguiente |
|                      |               |elemento del mismo nivel con la misma  |
|                      |               |rama padre).                           |
|______________________|_______________|_______________________________________|
|                      |               |En una lista jerárquica, selecciona el|
|LevelUp               |K              |hermano anterior al elemento           |
|                      |               |seleccionado (el elemento anterior del |
|                      |               |mismo nivel con la misma rama padre).  |
|______________________|_______________|_______________________________________|
|                      |               |Intenta actualizar todos los paquetes  |
|MarkUpgradable        |U              |que no están retenidos o prohibidos de|
|                      |               |actualización.                        |
|______________________|_______________|_______________________________________|
|MineFlagSquare        |f              |En el Buscaminas, pone o quita una     |
|                      |               |marca en el cuadrado.                  |
|______________________|_______________|_______________________________________|
|MineLoadGame          |L              |Cargar una partida del Buscaminas.     |
|______________________|_______________|_______________________________________|
|MineSaveGame          |S              |Guardar una partida del Buscaminas.    |
|______________________|_______________|_______________________________________|
|MineSweepSquare       |Sin ligar      |Buscar en torno a la casilla actual en |
|                      |               |el Buscaminas.                         |
|______________________|_______________|_______________________________________|
|MineUncoverSquare     |Sin ligar      |Descubrir la casilla presente en el    |
|                      |               |Buscaminas.                            |
|______________________|_______________|_______________________________________|
|                      |               |Descubrir la casilla presente en el    |
|MineUncoverSweepSquare|enter          |Buscaminas en caso de estar oculta; de |
|                      |               |no estarlo, busca en torno suyo.       |
|______________________|_______________|_______________________________________|
|NextPage              |pagedown,C-f   |Desplazar la pantalla actual a la      |
|                      |               |siguiente página.                     |
|______________________|_______________|_______________________________________|
|NextSolution          |.              |Conducir al solucionador de            |
|                      |               |dependencias a la siguiente solución. |
|______________________|_______________|_______________________________________|
|                      |               |Esta tecla seleccionará el botón     |
|No                    |n[b]           |&#8220;no&#8221; en los cuadros de     |
|                      |               |dialogo si/no.                         |
|______________________|_______________|_______________________________________|
|Parent                |^              |Seleccionar la rama padre del elemento |
|                      |               |seleccionado en la lista jerárquica.  |
|______________________|_______________|_______________________________________|
|PrevPage              |pageup,C-b     |Desplazar la pantalla actual a la      |
|                      |               |página anterior.                      |
|______________________|_______________|_______________________________________|
|PrevSolution          |,              |Devolver el solucionador de            |
|                      |               |dependencias a la solución anterior.  |
|______________________|_______________|_______________________________________|
|Purge                 |_              |Marcar el paquete seleccionado para ser|
|                      |               |purgado.                               |
|______________________|_______________|_______________________________________|
|PushButton            |space,enter    |Activar el botón seleccionado         |
|                      |               |actualmente, o conmuta una casilla.    |
|______________________|_______________|_______________________________________|
|Quit                  |q              |Cerrar la vista actual.                |
|______________________|_______________|_______________________________________|
|QuitProgram           |Q              |Salir del programa.                    |
|______________________|_______________|_______________________________________|
|                      |               |Rechazar toda acción del solucionador |
|RejectBreakHolds      |�              |que rompe una retención; equivale a   |
|                      |               |Solucionador ->; Rechazar romper   |
|                      |               |bloqueos.                              |
|______________________|_______________|_______________________________________|
|Refresh               |C-l            |Redibujar la pantalla desde cero.      |
|______________________|_______________|_______________________________________|
|Remove                |-              |Marcar un paquete para su eliminación.|
|______________________|_______________|_______________________________________|
|ReInstall             |L              |Marcar el paquete seleccionado para su |
|                      |               |reinstalación.                        |
|______________________|_______________|_______________________________________|
|RepeatSearchBack      |N              |Repitir la ultima búsqueda, en        |
|                      |               |dirección inversa.                    |
|______________________|_______________|_______________________________________|
|ReSearch              |n              |Repitir la ultima búsqueda.           |
|______________________|_______________|_______________________________________|
|ReverseDependencies   |r              |Mostrar paquetes qué dependen del     |
|                      |               |paquete actualmente seleccionado.      |
|______________________|_______________|_______________________________________|
|                      |               |Desplazarse a la derecha: por ejemplo, |
|Right                 |right,l        |desplazarse a un menú a la derecha, en|
|                      |               |la barra de menú, o desplazar el      |
|                      |               |cursor a la derecha la editar texto.   |
|______________________|_______________|_______________________________________|
|SaveHier              |S              |Guardar la jerarquía actual en el     |
|                      |               |editor de jerarquías.                 |
|______________________|_______________|_______________________________________|
|                      |               |Activar la función de                 |
|Search                |/              |&#8220;búsqueda&#8221; del elemento de|
|                      |               |interfaz actualmente activo.           |
|______________________|_______________|_______________________________________|
|                      |               |Activar la función de &#8220;búsqueda|
|SearchBack            |\              |inversa&#8221; del elemento de interfaz|
|                      |               |actualmente activo.                    |
|______________________|_______________|_______________________________________|
|SearchBroken          |b              |En un árbol de paquetes, busca el     |
|                      |               |siguiente paquete roto.                |
|______________________|_______________|_______________________________________|
|SetAuto               |M              |Marcar el paquete seleccionado como    |
|                      |               |instalado automáticamente.            |
|______________________|_______________|_______________________________________|
|ShowHideDescription   |D              |En un lista de paquetes, conmuta si el |
|                      |               |área de información es visible o no. |
|______________________|_______________|_______________________________________|
|                      |               |Cuando examina una solución, marca la |
|SolutionActionApprove |a              |acción actualmente seleccionada como  |
|                      |               |«aprobada» (se incluirá en          |
|                      |               |soluciones futuras, de ser posible).   |
|______________________|_______________|_______________________________________|
|                      |               |Cuando examina una solución, marca la |
|SolutionActionReject  |r              |solución actualmente seleccionado como|
|                      |               |«rechazada» (descartada en soluciones|
|                      |               |futuras).                              |
|______________________|_______________|_______________________________________|
|ToggleExpanded        |enter          |Expandir o cerrar el árbol            |
|                      |               |seleccionado en una lista jerárquica. |
|______________________|_______________|_______________________________________|
|ToggleMenuActive      |C-m,f10,C-space|Activar o desactivar el menú          |
|                      |               |principal.                             |
|______________________|_______________|_______________________________________|
|                      |               |Cancelar la última acción, hasta el  |
|Undo                  |C-_,C-u        |punto en que inició aptitude, o hasta |
|                      |               |la última vez que actualizó la lista |
|                      |               |de paquetes o instaló paquetes.       |
|______________________|_______________|_______________________________________|
|                      |               |Desplazarse hacia arriba: por ejemplo, |
|Up                    |up,k           |desplaza un texto arriba o selecciona  |
|                      |               |el elemento anterior en una lista.     |
|______________________|_______________|_______________________________________|
|                      |               |Actualizar la lista de paquetes        |
|UpdatePackageList     |u              |mediante la obtención de listas nuevas|
|                      |               |a través de Internet si es necesario. |
|______________________|_______________|_______________________________________|
|Versions              |v              |Mostrar las versiones disponibles del  |
|                      |               |paquete seleccionado.                  |
|______________________|_______________|_______________________________________|
|                      |               |Esta tecla selecciona el botón        |
|Yes                   |y [b]          |&#8220;Si&#8221; en los cuadros de     |
|                      |               |dialogo Si/No.                         |
|______________________|_______________|_______________________________________|
|[a] a menos que Aptitude::Display-Planned-Action tiene valor de «false».    |
|                                                                              |
|[b] Esta configuración predeterminada puede variar con diferentes locales.   |
|______________________________________________________________________________|

Además de las teclas de letras, números y puntuación, puede ligar las
siguientes teclas &#8220;especiales&#8221;:

 ____________________________________________________________________________
|Nombre de la tecla|Descripción                                             |
|__________________|_________________________________________________________|
|a1                |La tecla A1.                                             |
|__________________|_________________________________________________________|
|a3                |La tecla A3.                                             |
|__________________|_________________________________________________________|
|b2                |La tecla B2.                                             |
|__________________|_________________________________________________________|
|backspace         |La tecla de retroceso.                                   |
|__________________|_________________________________________________________|
|backtab           |La tecla tabulado de retroceso.                          |
|__________________|_________________________________________________________|
|begin             |La tecla Comenzar (no Inicio)                            |
|__________________|_________________________________________________________|
|break             |La tecla de &#8220;pausa&#8221;.                         |
|__________________|_________________________________________________________|
|c1                |La tecla C1.                                             |
|__________________|_________________________________________________________|
|c3                |La tecla C3.                                             |
|__________________|_________________________________________________________|
|cancel            |La tecla Cancelar.                                       |
|__________________|_________________________________________________________|
|create            |La tecla Crear.                                          |
|__________________|_________________________________________________________|
|                  |Coma (,) -- observe que debido a que las comas se emplean|
|comma             |para listar teclas, esta es la única manera de ligar una|
|                  |coma a una acción.                                      |
|__________________|_________________________________________________________|
|command           |La tecla de Orden.                                       |
|__________________|_________________________________________________________|
|copy              |La tecla Copiar.                                         |
|__________________|_________________________________________________________|
|delete            |La tecla Suprimir.                                       |
|__________________|_________________________________________________________|
|delete_line       |La tecla &#8220;borrar línea&#8221;.                    |
|__________________|_________________________________________________________|
|down              |La tecla de dirección &#8220;abajo&#8221;.              |
|__________________|_________________________________________________________|
|end               |La tecla Fin.                                            |
|__________________|_________________________________________________________|
|entry             |La tecla Intro.                                          |
|__________________|_________________________________________________________|
|exit              |La tecla Salir.                                          |
|__________________|_________________________________________________________|
|f1, f2, ..., f10  |Las teclas desde F1 a F10.                               |
|__________________|_________________________________________________________|
|find              |La tecla Buscar.                                         |
|__________________|_________________________________________________________|
|home              |La tecla Inicio.                                         |
|__________________|_________________________________________________________|
|insert            |La tecla Insertar.                                       |
|__________________|_________________________________________________________|
|insert_exit       |La tecla &#8220;insertar salir&#8221;.                   |
|__________________|_________________________________________________________|
|clear             |La tecla &#8220;borrar&#8221;.                           |
|__________________|_________________________________________________________|
|clear_eol         |La tecla &#8220;borrar hasta final de línea&#8221;.     |
|__________________|_________________________________________________________|
|clear_eos         |La tecla &#8220;borrar hasta final de pantalla&#8221;.   |
|__________________|_________________________________________________________|
|insert_line       |La tecla &#8220;insertar línea&#8221;.                  |
|__________________|_________________________________________________________|
|left              |La tecla de dirección &#8220;izquierda&#8221;.          |
|__________________|_________________________________________________________|
|mark              |La tecla Marcar.                                         |
|__________________|_________________________________________________________|
|message           |La tecla Mensaje.                                        |
|__________________|_________________________________________________________|
|move              |La tecla Mover.                                          |
|__________________|_________________________________________________________|
|next              |La tecla Siguiente.                                      |
|__________________|_________________________________________________________|
|open              |La tecla Abrir.                                          |
|__________________|_________________________________________________________|
|previous          |La tecla Anterior.                                       |
|__________________|_________________________________________________________|
|print             |La tecla Imprimir.                                       |
|__________________|_________________________________________________________|
|redo              |La tecla Rehacer.                                        |
|__________________|_________________________________________________________|
|reference         |La tecla Referencia.                                     |
|__________________|_________________________________________________________|
|refresh           |La tecla Refrescar.                                      |
|__________________|_________________________________________________________|
|replace           |La tecla Reemplazar.                                     |
|__________________|_________________________________________________________|
|restart           |La tecla Reiniciar.                                      |
|__________________|_________________________________________________________|
|resume            |La tecla Continuar.                                      |
|__________________|_________________________________________________________|
|return            |La tecla de Retorno.                                     |
|__________________|_________________________________________________________|
|right             |La tecla de dirección &#8220;derecha&#8221;.            |
|__________________|_________________________________________________________|
|save              |La tecla Guardar.                                        |
|__________________|_________________________________________________________|
|scrollf           |La tecla &#8220;desplazarse hacia delante&#8221;.        |
|__________________|_________________________________________________________|
|scrollr           |La tecla &#8220;desplazarse hacia atrás&#8221;.         |
|__________________|_________________________________________________________|
|select            |La tecla Seleccionar.                                    |
|__________________|_________________________________________________________|
|suspend           |La tecla Suspender.                                      |
|__________________|_________________________________________________________|
|pagedown          |La tecla &#8220;Avpág&#8221;.                           |
|__________________|_________________________________________________________|
|pageup            |La tecla &#8220;Repág&#8221;.                           |
|__________________|_________________________________________________________|
|space             |La tecla Espacio.                                        |
|__________________|_________________________________________________________|
|tab               |La tecla Tabulador.                                      |
|__________________|_________________________________________________________|
|undo              |La tecla Deshacer.                                       |
|__________________|_________________________________________________________|
|up                |La tecla de dirección &#8220;arriba&#8221;.             |
|__________________|_________________________________________________________|

Además de poder ligar las teclas de manera global, también es posible cambiar
teclas ligadas para una parte en particular (o dominio) de aptitude: por
ejemplo, para hacer que el tabulador sea el equivalente a la tecla de dirección
derecha en la barra de menú, defina Aptitude::UI::Keybindings::Menubar::Right
como &#8220;tab,right&#8221;. Los siguientes dominios están disponibles:

 ______________________________________________________________________________
|Dominio      |Descripción                                                    |
|_____________|________________________________________________________________|
|EditLine     |Empleado por elementos de edición de línea, tales como el     |
|             |campo de entrada en un dialogo de &#8220;búsqueda&#8221;.      |
|_____________|________________________________________________________________|
|Menu         |Empleado por los menús que se abren hacia abajo.               |
|_____________|________________________________________________________________|
|Menubar      |Empleado por la barra de menú en la parte alta de la pantalla. |
|_____________|________________________________________________________________|
|Minesweeper  |Empleado por el modo Buscaminas.                                |
|_____________|________________________________________________________________|
|             |Empleado por las preguntas de elección múltiple que aparecen  |
|MinibufChoice|si escoge que ciertas preguntas aparezcan en la línea de       |
|             |estado.                                                         |
|_____________|________________________________________________________________|
|Pager        |Empleado cuando se muestra un archivo del disco (por ejemplo, el|
|             |texto de ayuda).                                                |
|_____________|________________________________________________________________|
|             |Empleado por paquetes, árboles de paquetes, versiones de       |
|PkgNode      |paquetes y dependencias de paquetes cuando aparecen en listas de|
|             |paquetes.                                                       |
|_____________|________________________________________________________________|
|PkgTree      |Empleado por listas de paquetes.                                |
|_____________|________________________________________________________________|
|Table        |Empleado por tablas de componentes (por ejemplo, cuadros de     |
|             |dialogo).                                                       |
|_____________|________________________________________________________________|
|TextLayout   |Empleado por presentaciones de texto formateados, tales como las|
|             |descripciones de paquetes.                                      |
|_____________|________________________________________________________________|
|Tree         |Empleado por todas las presentaciones de árbol (incluyendo     |
|             |listas de paquetes, se puede anular mediante PkgTree).          |
|_____________|________________________________________________________________|


Personalizar los colores del texto y estilos.

Puede personalizar extensivamente los colores y estilos visuales empleados por
aptitude para mostrar el texto. Cada elemento visual tiene un
&#8220;estilo&#8221; asociado, que describe los colores y atributos visuales que
se emplean para mostrar tal elemento. Los estilos tienen la forma de una lista
de configuraciones para el color y los atributos. Esta lista no es
necesariamente exhaustiva; si no se especifica algún color o atributo sus
valores se toman del contexto visual circundante. De hecho, la mayoría de los
elementos visuales tiene un estilo &#8220;vacío&#8221; de manera
predeterminada.

Puede modificar los contenidos de un estilo, creando un grupo de configuración
del mismo nombre en el archivo de configuración de apt o de aptitude. Por
ejemplo, el estilo de &#8220;MenuBorder&#8221; se usa para dibujar el borde en
torno a los menús desplegables. Por omisión este borde se dibuja resaltado y
en blanco sobre azul. Insertar el siguiente texto en el archivo de
configuración lo dibuja en blanco sobre azul:

Aptitude::UI::Styles {
  MenuBorder {fg white; bg cyan; set bold;};
};

Como puede ver, un grupo de configuración de estilo consiste de una serie de
instrucciones. Las clases generales de instrucciones son:



  fg color
      Mostrar el texto en primer plano con el color dado. Véase más abajo para
      una lista de los colores conocidos por aptitude.


  bg color
      Mostrar el texto de fondo con el color dado. Véase más abajo para una
      lista de colores conocidos por aptitude.


  set atributo
      Activar el atributo de texto dado. Véase más abajo para una lista de
      atributos de texto conocidos por aptitude.


  clear atributo
      Desactivar el atributo de texto dado. Véase más abajo para una lista de
      los atributos de texto conocidos por aptitude.


  flip atributo
      Conmutar el atributo de texto: si está activo en el elemento circundante,
      se desactivará, y viceversa. Véase más abajo para una lista de los
      atributos de texto conocidos por aptitude.


Los colores que aptitude reconoce son el negro, azul, cían, verde, magenta,
rojo, blanco y amarillo [20]. Además, puede especificar default en lugar de un
color de fondo para usar el fondo predeterminado de la terminal (esto puede ser
el color predeterminado, un archivo de imagen, o incluso
&#8220;transparente&#8221;). Los estilos que aptitude reconoce son:



  blink
      Activar texto parpadeante.


  bold
      Dar más brillo al color en primer plano del texto (o el fondo, si ha
      activado el vídeo inverso).


  dim
      Esto puede causar que el texto sea más oscuro en algunos terminales. No
      se ha observado este efecto en terminales comunes de Linux.


  reverse
      Intercambiar los colores en primer plano y de fondo. Muchos elementos
      visuales emplean este atributo para realizar tareas comunes de resaltado.


  standout
      Esto activa &#8220;el mejor modo de resaltado de la terminal&#8221;. Es
      similar en xterms, pero no idéntico al vídeo inverso; el comportamiento
      de esto en otros terminales puede variar.


  underline
      Activar el subrayado de texto.


Puede seleccionar varios atributos a la vez si los separa con comas; por ejemplo
set bold,standout;.


 [Nota]  Nota

         Como se indica arriba, la interpretación del estilo y de los atributos
         de texto depende en gran medida de la terminal. Puede que necesite
         experimentar un poco para encontrar exactamente qué configuraciones
         son posibles en su terminal.


Puede personalizar los siguientes estilos en aptitude:

Figura 2.14. Estilos personalizables en aptitude

 ______________________________________________________________________________
|Estilo                    |Predeterminado           |Descripción             |
|__________________________|_________________________|_________________________|
|Bullet                    |fg yellow; set bold;     |El estilo de los puntos  |
|                          |                         |en las listas por puntos.|
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de las nuevas  |
|                          |                         |versiones de un paquete  |
|                          |                         |en la vista de registro  |
|                          |                         |de cambios. Observe que  |
|ChangelogNewerVersion     |set bold;                |aptitude solo resalta las|
|                          |                         |nuevas versiones de      |
|                          |                         |paquetes si el paquete   |
|                          |                         |«libparse-              |
|                          |                         |debianchangelog-perl»   |
|                          |                         |está instalado.         |
|__________________________|_________________________|_________________________|
|Default                   |fg white; bg black;      |El estilo básico de la  |
|                          |                         |pantalla.                |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo para las       |
|DepBroken                 |fg black; bg red;        |dependencias no          |
|                          |                         |satisfechas.             |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo para las       |
|DisabledMenuEntry         |fg black; bg blue; set   |entradas de menú que    |
|                          |dim;                     |están desactivadas y que|
|                          |                         |no se pueden emplear.    |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo empleado para  |
|                          |                         |indicar que un archivo ha|
|DownloadHit               |fg black; bg green;      |sido &#8220;hit&#8221;:  |
|                          |                         |p.ej., no ha cambiado    |
|                          |                         |desde la última vez que |
|                          |                         |se descargó.            |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo del indicador  |
|DownloadProgress          |fg blue; bg yellow;      |de progreso de una       |
|                          |                         |descarga.                |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de editores de |
|                          |fg white; bg black; clear|línea (por ejemplo, la  |
|EditLine                  |reverse;                 |entrada en el cuadro de  |
|                          |                         |dialogo                  |
|                          |                         |&#8220;Buscar&#8221;).   |
|__________________________|_________________________|_________________________|
|Error                     |fg white; bg red; set    |El estilo de los mensajes|
|                          |bold;                    |de error.                |
|__________________________|_________________________|_________________________|
|Header                    |fg white; bg blue; set   |El estilo de las         |
|                          |bold;                    |cabeceras de pantalla.   |
|__________________________|_________________________|_________________________|
|                          |fg white; bg blue; set   |El estilo del nombre de  |
|HighlightedMenuBar        |bold,reverse;            |menú seleccionado en la |
|                          |                         |barra de menú.          |
|__________________________|_________________________|_________________________|
|                          |fg white; bg blue; set   |El estilo de la elección|
|HighlightedMenuEntry      |bold,reverse;            |seleccionada actualmente |
|                          |                         |en un menú .            |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo del cuadro de  |
|                          |fg yellow; bg red; set   |dialogo empleado para    |
|MediaChange               |bold;                    |informar al usuario de   |
|                          |                         |que debe insertar un     |
|                          |                         |disco compacto nuevo.    |
|__________________________|_________________________|_________________________|
|MenuBar                   |fg white; bg blue; set   |El estilo de la barra de |
|                          |bold;                    |menú.                   |
|__________________________|_________________________|_________________________|
|                          |fg white; bg blue; set   |El estilo de los bordes  |
|MenuBorder                |bold;                    |que rodean a un menú    |
|                          |                         |desplegable.             |
|__________________________|_________________________|_________________________|
|MenuEntry                 |fg white; bg blue;       |El estilo de cada entrada|
|                          |                         |en un menú desplegable. |
|__________________________|_________________________|_________________________|
|MineBomb                  |fg red; set bold;        |El estilo de las bombas  |
|                          |                         |en el Buscaminas.        |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo del borde que  |
|MineBorder                |set bold;                |se dibuja en torno al    |
|                          |                         |tablero del Buscaminas.  |
|__________________________|_________________________|_________________________|
|MineFlag                  |fg red; set bold;        |El estilo de las marcas  |
|                          |                         |en el Buscaminas.        |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo del número N  |
|MineNumberN               |Varios                   |en el Buscaminas; N puede|
|                          |                         |variar de 0 a 8.         |
|__________________________|_________________________|_________________________|
|                          |                         |El color empleado para   |
|                          |                         |mostrar                  |
|MultiplexTab              |fg white; bg blue;       |&#8220;pestañas&#8221;  |
|                          |                         |además de la            |
|                          |                         |seleccionada.            |
|__________________________|_________________________|_________________________|
|                          |                         |El color empleado para   |
|MultiplexTabHighlighted   |fg blue; bg white;       |mostrar la               |
|                          |                         |&#8220;pestaña&#8221;   |
|                          |                         |seleccionada.            |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los paquetes|
|PkgBroken                 |fg red; flip reverse;    |en la lista de paquetes  |
|                          |                         |que tienen dependencias  |
|                          |                         |no satisfechas.          |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los paquetes|
|                          |                         |resaltados en la lista de|
|PkgBrokenHighlighted      |fg red;                  |paquetes que tienen      |
|                          |                         |dependencias no          |
|                          |                         |satisfechas.             |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los paquetes|
|PkgNotInstalled           |�                        |que no están instalados |
|                          |                         |y que no se van a        |
|                          |                         |instalar.                |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los paquetes|
|PkgNotInstalledHighlighted|�                        |resaltados que no están |
|                          |                         |instalados y que no se   |
|                          |                         |van a instalar.          |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los paquetes|
|                          |                         |instalados en la         |
|PkgIsInstalled            |set bold;                |actualidad pero para los |
|                          |                         |cuales no hay ninguna    |
|                          |                         |acción programada.      |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los paquetes|
|                          |                         |resaltados instalados en |
|PkgIsInstalledHighlighted |set bold; flip reverse;  |la actualidad pero para  |
|                          |                         |los cuales no hay ninguna|
|                          |                         |acción programada.      |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los paquetes|
|PkgToDowngrade            |set bold;                |en la lista de paquetes  |
|                          |                         |que se van a             |
|                          |                         |desactualizar.           |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los paquetes|
|PkgToDowngradeHighlighted |set bold; flip reverse   |resaltados en la lista de|
|                          |                         |paquetes que se van a    |
|                          |                         |desactualizar.           |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los paquetes|
|PkgToHold                 |fg white; flip reverse;  |retenidos en la lista de |
|                          |                         |paquetes.                |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los paquetes|
|PkgToHoldHighlighted      |fg white;                |retenidos, y resaltados, |
|                          |                         |en la lista de paquetes. |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los paquetes|
|PkgToInstall              |fg green; flip reverse;  |en la lista de paquetes  |
|                          |                         |que se van a instalar (no|
|                          |                         |actualizar) o reinstalar.|
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los paquetes|
|                          |                         |resaltados en la lista de|
|PkgToInstallHighlighted   |fg green;                |paquetes que se van a    |
|                          |                         |instalar (no actualizar) |
|                          |                         |o reinstalar.            |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los paquetes|
|PkgToRemove               |fg magenta; flip reverse;|en la lista de paquetes  |
|                          |                         |que se van a eliminar o  |
|                          |                         |purgar.                  |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los paquetes|
|PkgToRemoveHighlighted    |fg magenta;              |resaltados en la lista de|
|                          |                         |paquetes que se van a    |
|                          |                         |eliminar o purgar.       |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los paquetes|
|PkgToUpgrade              |fg cyan; flip reverse;   |en la lista de paquetes  |
|                          |                         |que se van a actualizar. |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los paquetes|
|PkgToUpgradeHighlighted   |fg cyan;                 |resaltados en la lista de|
|                          |                         |paquetes que se van a    |
|                          |                         |actualizar.              |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de las barras  |
|                          |                         |de progreso tales como el|
|Progress                  |fg blue; bg yellow;      |que aparece cuando se    |
|                          |                         |carga el almacén de     |
|                          |                         |paquetes.                |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de las acciones|
|SolutionActionApproved    |bg green;                |aprobadas en una         |
|                          |                         |solución.               |
|__________________________|_________________________|_________________________|
|                          |                         |El estilo de los acciones|
|SolutionActionRejected    |bg red;                  |rechazadas en una        |
|                          |                         |solución.               |
|__________________________|_________________________|_________________________|
|                          |fg white; bg blue; set   |El estilo de las líneas |
|Status                    |bold;                    |de estado en la base de  |
|                          |                         |la pantalla.             |
|__________________________|_________________________|_________________________|
|TreeBackground            |�                        |El color básico de todas|
|                          |                         |las listas y árboles.   |
|__________________________|_________________________|_________________________|
|                          |                         |El color empleado para   |
|TrustWarning              |fg red; bg black; set    |mostrar los avisos       |
|                          |bold;                    |referentes a la confianza|
|                          |                         |de los paquetes.         |
|__________________________|_________________________|_________________________|




Personalizar el diseño de la interfaz.

Es posible configurar el diseño de la lista de paquetes de aptitude modificando
el archivo de configuración.


Elementos de pantalla

El diseño de pantalla se guarda en el grupo de configuración Aptitude::UI::
Default-Package-View, y consiste de una lista de los elementos de pantalla:

Nombre Tipo {
  Row fila;
  Column columna;
  Width ancho;
  Height altura;

  opciones adicionales...
};

Esto crea un elemento de pantalla denominado Nombre; el tipo de elemento creado
se determina por el Tipo. Las opciones Row, Column, Width y Height deben estar
presentes; determinan la posición del elemento de pantalla (véase más abajo
para una explicación detallada acerca de la disposición de los elementos de
pantalla)

Para ver ejemplos de cómo cambiar el diseño de pantalla, véase las
definiciones de tema en el archivo /usr/share/aptitude/aptitude-defaults.

Los siguientes tipos de elementos de pantalla están disponibles:



  Description
      Este elemento de pantalla contiene el &#8220;área de información&#8221;
      (generalmente una descripción del paquete seleccionado).

      La opción PopUpDownKey proporciona el nombre de una orden de teclado que
      oculta o muestra el elemento de pantalla. Por ejemplo, si configura esto
      como ShowHideDescription, el elemento de pantalla actual tendría las
      mismas características que el área de información predeterminado. La
      opción PopUpDownLinked proporciona el nombre de otro elemento de
      pantalla; el elemento se mostrará u ocultará dependiendo de si el otro
      elemento lo está también.


  MainWidget
      Este es un espacio para el elemento de pantalla &#8220;principal&#8221;:
      esto es, generalmente, la lista de paquetes. Un diseño de interfaz debe
      contener exactamente un elemento MainWidget: ni más, ni menos.


  Static
      Un espacio de la pantalla que muestra algún texto, que posiblemente
      contiene códigos de formato tal y como se describe en &#8220;Personalizar
      la presentación de los paquetes&#8221;. El texto a mostrar se puede
      configurar en la opción Columns, o se puede guardar en otra variable de
      configuración especificada en la opción ColumnsCfg. El color del texto
      se determina por el color nombrado en la opción Color.

      Los elementos Static (estáticos) se pueden mostrar u ocultar de la misma
      manera que elementos de Description, empleando las opciones PopUpDownKey y
      PopUpDownLinked.



Ubicación de los elementos de pantalla

Los elementos de pantalla aparecen en un &#8220;tablero&#8221;. La esquina
superior izquierda de un elemento está en la célula dada por las opciones Row
y Column (comenzando generalmente por la fila 0, columna 0; esto no es
obligatorio). El ancho de un elemento en células aparece en la opción Width, y
su altura, en la opción Height.

Una vez que los elementos de pantalla están dispuestos y se les ha dado una
cantidad inicial de espacio en la pantalla, puede que aún quede espacio
sobrante. Si hay espacio vertical sobrante, a cada fila que contiene un elemento
de pantalla cuya opción RowExpand es true se le dará una parte de ese espacio
sobrante; de manera similar, si hay espacio horizontal sobrante, cada columna
que contiene un elemento de pantalla cuya opción ColExpand es true se le dará
una parte de ese espacio sobrante.

En la situación de que no haya suficiente espacio, cada fila y columna cuyos
componentes tienen todas sus opciones RowShrink o ColShrink definidos como true,
son encogidos. Si esto no es suficiente, todas las filas y columnas se encojen
para encajar en el espacio disponible.

Si no se expande un elemento de pantalla, pero sí su fila o columna, su
alineamiento se determina por las opciones RowAlign (alineamiento de la fila) y
ColAlign (alineamiento de la columna). Configurarlos con Left (izq.), Right
(der.), Top (inicio), Bottom (final) o Center (centro), indica a aptitude donde
ubicar el elemento dentro de la fila o columna.

Por ejemplo, el siguiente grupo de configuración crea un elemento estático
llamado &#8220;Header&#8221;, con un ancho de tres células y que se expande
horizontalmente, pero no en vertical. Posee el mismo color que otras líneas de
cabecera y emplea el formato de presentación estándar para las líneas de
cabecera:

Header Static {
  Row 0;
  Column 0;
  Width 3;
  Height 1;

  ColExpand true;
  ColAlign Center;

  RowAlign Center;

  Color ScreenHeaderColor;
  ColumnsCfg HEADER;
};


Referencia de las opciones de diseño de la interfaz

Las siguientes opciones están disponibles para los elementos de pantalla:



  ColAlign alineamiento;
      El alineamiento debe ser Left, Right, o Center. Si la fila que contiene el
      elemento de pantalla actual es más ancho que el mismo elemento y
      ColExpand es false, el elemento se posicionará en la fila de acuerdo al
      valor de alineamiento.

      Si está opción no está presente, activa Left de manera predeterminada.


  ColExpand true|false;
      Si esta opción se configura como true la columna que contiene este
      elemento de pantalla recibe una parte de cualquier espacio horizontal
      sobrante disponible.

      Si esta opción no esta presente, false es la opción predeterminada.


  Color nombre_de_color;
      Esta opción afecta a los elementos Static. nombre_de_color es el nombre
      de un color (por ejemplo, ScreenStatusColor) que se debe usar como el
      color &#8220;predeterminado&#8221; para este elemento de pantalla.

      Si esta opción no esta presente, la opción predeterminada es
      DefaultWidgetBackground.


  ColShrink true|false;
      Si cada elemento de una columna tiene esta opción como true y no hay
      suficiente espacio horizontal, la columna encogerá en la medida de lo
      necesario. Observe que la columna puede variar de tamaño aunque ColShrink
      sea false; simplemente indica que aptitude debería intentar encoger una
      columna en particular antes de encoger las demás.

      Si esta opción no esta presente, false es la opción predeterminada.


  Column columna;
      Definir la columna más a la izquierda que contiene este elemento de
      interfaz.


  Columns formato;
      Esta opción afecta a los elementos de pantalla Static que no tienen
      especificada la opción en ColumnsCfg. Configura los contenidos mostrados
      del elemento de estado; es una cadena formato tal y como se describe en
      &#8220;Personalizar la presentación de los paquetes&#8221;.


  ColumnsCfg HEADER|STATUS|nombre;
      Esta opción afecta a los elementos de pantalla Static. Cambia el formato
      de pantalla del elemento seleccionado a una valor de otra variable de
      configuración: si es HEADER o STATUS, las opciones Aptitude::UI::Package-
      Header-Format y Aptitude::UI::Package-Status-Format se emplean,
      respectivamente; de no ser así, se emplea la opción nombre.

      Si esta opción no está presente, se usa el valor de la opción Columns
      para gestionar los contenidos del elemento estático.


  Height altura;
      Definir la altura del elemento de interfaz actual.


  PopUpDownKey orden;
      Esta opción afecta a los elementos de pantalla Description y Static.

      orden es el nombre de una orden de teclado (por ejemplo,
      ShowHideDescription). Si pulsa esta tecla, el elemento de pantalla se
      ocultará en caso de estar visible, y visible si está oculto.


  PopUpDownLinked elemento;
      Esta opción afecta a los elementos de pantalla Description y Static.

      elemento es el nombre de un elemento de pantalla. Cuando elemento es
      visible, el elemento actual también es visible; cuando elemento está
      oculto, el elemento actual también está oculto.


  Row fila;
      Definir la fila más alta que contiene este elemento.


  RowAlign alineamiento;
      alineamiento debe ser Top, Bottom, o Center. Si la fila que contiene el
      elemento de pantalla actual es más alto que el elemento mismo y si
      RowExpand vale false, el elemento aparecerá en la fila de acuerdo al
      valor de alineamiento.

      Si esta opción no está presente, Top es la opción predeterminada.


  RowExpand true|false;
      Si esta opción tiene valor de true, la fila que contiene el elemento de
      pantalla dispondrá de un espacio adicional si hay espacio vertical libre.

      Si esta opción no esta presente, false es la opción predeterminada.


  RowShrink true|false;
      Si da valor de true a esta opción para cada elemento de la fila y no hay
      suficiente espacio vertical, la fila encogerá en la medida de lo
      necesario. Observe que una fila puede encoger aunque RowShrink sea false;
      sólo indica a aptitude que ha de intentar encoger un fila en particular
      antes de encoger otras.

      Si esta opción no esta presente, false es la opción predeterminada.


  Visible true|false;
      Si da valor de false este elemento de pantalla estará oculto de inicio.
      Supuestamente, esto sólo es útil en conjunción con PopUpDownKey y/
      o PopUpDownLinked.

      Si no configura esta opción, true es la forma predeterminada.


  Width ancho;
      Definir el ancho del elemento de interfaz actual.



Referencia del archivo de configuración.


Formato del archivo de configuración

En su forma básica, el archivo de configuración de aptitude es una lista de
opciones seguidas de sus valores. Cada línea debe tener la forma &#8220;Opción
Valor;&#8221;: por ejemplo, la siguiente línea en el archivo de configuración
configura la opción Aptitude::Theme como &#8220;Dselect&#8221;.

Aptitude::Theme "Dselect";

Una opción puede &#8220;contener&#8221; otras opciones si se escriben entre
corchetes entre la opción y el semi-colon que le sigue,como por ejemplo:

Aptitude::UI {
  Package-Status-Format "";
  Package-Display-Format "";
};

Una opción que contiene otras opciones se denomina grupo. De hecho, los doble-
colon que aparecen en los nombres de opciones son la forma corta de indicar
contenido: la opción Aptitude::UI::Default-Grouping se encuentra dentro del
grupo Aptitude::UI, el cual a su vez se encuentra dentro del grupo Aptitude. Por
ello, si lo desea, podría activar esta opción como "" de la siguiente manera:

Aptitude {
  UI {
    Default-Grouping "";
  };
};

Para más información referente al formato del archivo de configuración,
véase la página de manual apt.conf(5).


Ubicaciones de los archivos de configuración

La configuración de aptitude se lee desde las siguientes fuentes, en orden:


  1. Configuration file options specified on the command-line.

  2. El archivo de configuración de usuario, ~/.aptitude/config. Este archivo
     se sobreescribe cuando el usuario modifica la configuración en el menú
     Opciones.

  3. El archivo de configuración del sistema, /etc/apt/apt.conf.

  4. The system configuration fragment files, /etc/apt/apt.conf.d/*.

  5. The file specified by the APT_CONFIG environment variable (if any).

  6. Valores predeterminados guardados en /usr/share/aptitude/aptitude-defaults.

  7. Valores predeterminados integrados en aptitude


Cuando se activa una opción, estas fuentes se examinan por orden, y se emplea
el primero que provee el valor para la opción usada. Por ejemplo, si configura
una opción en /etc/apt/apt.conf, esto sobreescribe los valores predeterminados
de aptitude para esa opción, pero no sobreescribe las configuraciones de
usuario en ~/.aptitude/config.


Opciones de configuración disponibles

aptitude emplea las siguientes opciones de configuración. Observe que éstas no
son todas las opciones de configuración disponibles; aquellas empleadas por el
sistema subyacente apt no se encuentran en esta lista. Véase las páginas de
manual apt(8) y apt.conf(5) para información referente a las opciones de apt.

Opción:Apt::AutoRemove::RecommendsImportant

Predeterminado:true

Descripción: Si esta opción tiene valor de true, aptitude no considerará en
desuso ningún paquete (y por ello no se eliminarán automáticamente) siempre y
cuando algún paquete instalado los recomiende, aunque Apt::Install-Recommends
valga false. Para más información, véase &#8220;Gestionar paquetes
automáticamente instalados.&#8221;.

Opción:Apt::AutoRemove::SuggestsImportant

Predeterminado:false

Descripción: Si esta opción tiene valor de true, aptitude considerará que
ningún paquete está en desuso (y por ello no los eliminará automáticamente)
siempre y cuando algún paquete los sugiera. Para más información, véase
&#8220;Gestionar paquetes automáticamente instalados.&#8221;.

Opción:Apt::Get::List-Cleanup

Predeterminado:true

Descripción: Un sinónimo de Apt::List-Cleanup. Si define cualquiera de estas
opciones como false, aptitude no borrará los archivos antiguos de listas de
paquetes después de descargar un nuevo conjunto de listas de paquetes.

Opción:Apt::List-Cleanup

Predeterminado:true

Descripción: Un sinónimo de Apt::Get::List-Cleanup. Si define cualquiera de
estas opciones como false, aptitude no borrará los archivos antiguos de listas
de paquetes después de descargar un nuevo conjunto de listas de paquetes.

Opción:Apt::Install-Recommends

Predeterminado:true

Descripción: Si esta opción vale true y Aptitude::Auto-Install vale true
también, cuando marque un paquete para su instalación aptitude marcará
también todos los paquetes recomendados. Más aún, si esta opción es true,
aptitude considerará que ninguna paquete está en desuso mientras otro lo
recomiende. Para más información, véase &#8220;Gestionar paquetes
automáticamente instalados.&#8221; y &#8220;Resolución inmediata de
dependencias.&#8221;.

Opción:Aptitude::Allow-Null-Upgrade

Predeterminado:false

Descripción: Por lo general, si intenta iniciar un proceso de instalación sin
que haya marcado ningún paquete para una acción aptitude mostrará un aviso y
volverá a la lista de paquetes. Si esta opción vale true, aptitude mostrará
la pantalla de previsualización si hay paquetes actualizables, en lugar de
mostrar un recordatorio relativo a la orden Acciones ->; Marcar actualizable
(U).

Opción:Aptitude::Always-Use-Safe-Resolver

Predeterminado:false

Descripción: Si esta opción es true, las acciones en línea de órdenes de
aptitude siempre emplearán un solucionador de dependencias
&#8220;seguro&#8221;, al igual que si hubiese introducido el argumento --safe-
resolver en la línea de órdenes.

Opción:Aptitude::Autoclean-After-Update

Predeterminado:false

Descripción: Si esta opción tiene valor de true, aptitude borrará los
paquetes obsoletos (véase Acciones ->; Limpiar ficheros obsoletos) cada vez
que actualice la lista de paquetes.

Opción:Aptitude::Auto-Fix-Broken

Predeterminado:true

Descripción: Si esta opción vale false, aptitude le pedirá permiso antes de
intentar arreglar cualquier paquete roto.

Opción:Aptitude::Auto-Install

Predeterminado:true

Descripción: Si esta opción es true, aptitude intentará automáticamente
cumplir con las dependencias de un paquete cuando lo marque para su instalación
o actualización.

Opción:Aptitude::Auto-Install-Remove-Ok

Predeterminado:false

Descripción: Si esta opción vale true, aptitude eliminará automáticamente
aquellos paquetes que entran en conflicto al marcar un paquete para su
instalación o actualización, Generalmente se marcan estos conflictos, y
tendrá que gestionarlos manualmente.

Opción:Aptitude::Auto-Upgrade

Predeterminado:false

Descripción: Si esta opción es true, aptitude marcará automáticamente todos
los paquetes actualizables cuando inicie el programa, al igual que si ejecuta la
orden Acciones ->; Marcar actualizable (U).

Opción:Aptitude::CmdLine::Always-Prompt

Predeterminado:false

Descripción: En la interfaz en línea de órdenes, si esto se activa, aptitude
siempre le preguntará antes de empezar a instalar o eliminar paquetes, incluso
si la pregunta se obviaría en situaciones normales. Esto equivale a la opción
en línea de órdenes -P.

Opción:Aptitude::CmdLine::Assume-Yes

Predeterminado:false

Descripción: En modo de línea de órdenes, si esta opción vale true, aptitude
actuará como si el usuario hubiese respondido &#8220;si&#8221; a cada pregunta,
haciendo que la mayoría de ellos se obvien. Esto equivale a la orden en línea
de órdenes -y.

Opción:Aptitude::CmdLine::Disable-Columns

Predeterminado:false

Descripción: Si activa esta opción, los resultados de una búsqueda en la
línea de órdenes (ejecutados con aptitude search) no se formatearán en
columnas de tamaño fijo o cortados al ancho de la pantalla. Esto equivale a la
opción en la línea de órdenes --disable-columns.

Opción:Aptitude::CmdLine::Download-Only

Predeterminado:false

Descripción: En el modo de línea de órdenes, si esta opción vale true,
aptitude descargará los paquetes pero no los instalará. Esto equivale a la
opción de línea de órdenes -d.

Opción:Aptitude::CmdLine::Fix-Broken

Predeterminado:false

Descripción: En el modo de línea de órdenes, si esta opción vale true,
aptitude será más agresivo en sus intentos de arreglar las dependencias de un
paquete roto. Esto equivale a la opción en la línea de órdenes -f.

Opción:Aptitude::CmdLine::Versions-Group-By

Predeterminado: Set to auto, none, package, or source-package to control whether
and how the output of aptitude versions is grouped. Equivalent to the command-
line option --group-by (see its documentation for more description of what the
values mean).

Opción:Aptitude::CmdLine::Ignore-Trust-Violations

Predeterminado:false

Descripción: En el modo de línea de órdenes, hace que aptitude ignore la
instalación de paquetes no de confianza. Esto es sinónimo de Apt::Get::
AllowUnauthenticated.

Opción:Aptitude::CmdLine::Package-Display-Format

Predeterminado:%c%a%M %p# - %d#

Descripción: Esta es una cadena formato, tal y como se describe en
&#8220;Personalizar la presentación de los paquetes&#8221;, que se emplea para
mostrar los resultados de una búsqueda en la línea de órdenes. Esto equivale
a la opción de línea en órdenes -F.

Opción:Aptitude::CmdLine::Package-Display-Width

Predeterminado:

Descripción: Esta opción proporciona el ancho de los caracteres que aparecen
en una búsqueda en línea de órdenes. De estar vacía (predeterminado; p.ej.,
""), los resultados de búsqueda se formatearán en relación al tamaño de la
terminal, o para una exposición de 80 columnas si no se puede determinar el
tamaño de la terminal.

Opción:Aptitude::CmdLine::Progress::Percent-On-Right

Predeterminado:false

Descripción: This option controls whether command-line progress indicators
display the percentage on the left-hand side of the screen, in the same style as
apt-get, or on the right-hand side (the default). This option does not affect
download progress indicators.

Opción:Aptitude::CmdLine::Progress::Retain-Completed

Predeterminado:false

Descripción: If this value is false, then command-line progress indicators will
be deleted and overwritten once the task they represent is completed. If it is
true, then they will be left on the terminal. This option does not affect
download progress indicators.

Opción:Aptitude::CmdLine::Request-Strictness

Predeterminado:10000

Descripción: Si encuentra problemas de dependencias en el modo de línea de
órdenes, aptitude añadirá este valor a la puntuación del solucionador de
problemas para cada acción que usted requiera de manera explícita.

Opción:Aptitude::CmdLine::Resolver-Debug

Predeterminado:false

Descripción: En el modo de línea de órdenes, si esta opción es true,
aptitude mostrará información extremadamente detallada cuando intente resolver
dependencias rotas. Como su propio nombre sugiere, esta opción está pensada
para ayudar en el proceso de eliminar los fallos del solucionador.

Opción:Aptitude::CmdLine::Resolver-Dump

Predeterminado:

Descripción: En el modo de línea de órdenes, en caso de ser necesario
solucionar dependencias rotas y si esta opción se configura con el nombre de un
archivo con permisos de escritura, el estado del solucionador se guardará en
este archivo antes de realizar cualquier calculo.

Opción:Aptitude::CmdLine::Resolver-Show-Steps

Predeterminado:false

Descripción: Si esta opción vale true, se mostrará una solución de
dependencias como una secuencia de las resoluciones de las dependencias
individuales; por ejemplo &#8220;wesnoth depende de wesnoth-data (= 1.2.4-1) -
> instalar wesnoth-data 1.2.4-1 (unstable)&#8221;. Para conmutar el modo de
vista, pulse o cuando se le pregunte &#8220;¿Acepta esta solución?&#8221;.

Opción:Aptitude::CmdLine::Show-Deps

Predeterminado:false

Descripción: En el modo de línea de órdenes, si esta opción vale true,
aptitude mostrará un resumen de las dependencias (de haberlas) relacionadas con
el estado de un paquete. Esto equivale a -D en la línea de órdenes.

Opción:Aptitude::CmdLine::Show-Size-Changes

Predeterminado:false

Descripción: En modo de línea de órdenes, si esta opción vale true, aptitude
mostrará una estimación del espacio que usará cada paquete. Esto equivale a
la opción de línea de órdenes -Z.

Opción:Aptitude::CmdLine::Why-Display-Mode

Predeterminado:no-summary

Descripción: Esta opción define el valor predeterminado del argumento en
línea de órdenes --show-summary. Véase la documentación de --show-summary
para una lista de los valores permitidos con esta opción, así como su
significado.

Opción:Aptitude::CmdLine::Show-Versions

Predeterminado:false

Descripción: En modo de línea de órdenes, si esta opción vale true, aptitude
mostrará la versión del paquete que se va a instalar o eliminar. Esto equivale
a la opción en línea de órdenes -V.

Opción:Aptitude::CmdLine::Show-Why

Predeterminado:false

Descripción: En modo de línea de órdenes, si esta opción vale true, aptitude
mostrará cada paquete instalado automáticamente que paquetes instalados
manualmente requieren, o los paquetes manualmente instalados que generan un
conflicto con cada paquete eliminado de manera automática. Esto equivale a la
opción en línea de órdenes -W, y muestra la misma información accesible a
través de aptitude why, o pulsando i en la lista de paquetes.

Opción:Aptitude::CmdLine::Version-Display-Format

Predeterminado:%c%a%M %p# %t %i

Descripción: This is a format string, as described in &#8220;Personalizar la
presentación de los paquetes&#8221;, which is used to display the output of
aptitude versions. This is equivalent to the -F command-line option.

Opción:Aptitude::CmdLine::Versions-Show-Package-Names

Predeterminado: Set to always, auto, or never to control when package names are
displayed in the output of aptitude versions. Equivalent to the command-line
option --show-package-names (see its documentation for more description of what
the values mean).

Opción:Aptitude::Safe-Resolver::Show-Resolver-Actions

Predeterminado:false

Descripción: If this option is enabled, then when the &#8220;safe&#8221;
dependency resolver has been activated via --safe-resolver or because the
command-line action is safe-upgrade, it will display a summary of the actions
taken by the resolver before showing the installation preview. Equivalent to the
command-line option --show-resolver-actions.

Opción:Aptitude::Screenshot::IncrementalLoadLimit

Predeterminado:16384

Descripción: The minimum size in bytes at which aptitude will begin to display
screenshots incrementally. Below this size, screenshots will not appear until
they are fully downloaded.

Opción:Aptitude::Screenshot::Cache-Max

Predeterminado:4194304

Descripción: The maximum number of bytes of screenshot data that aptitude will
store in memory for screenshots that are not currently being displayed. The
default is four megabytes.

Opción:Aptitude::CmdLine::Simulate

Predeterminado:false

Descripción: Recomendamos no usar esta opción; use Aptitude::Simulate. En la
línea de órdenes, hace que aptitude muestre las acciones que tomaría (a
diferencia de tomarlas en el momento); en la interfaz gráfica, aptitude se
iniciaría en modo de sólo lectura independientemente de si Ud. es root o no.
Equivale a la opción -s.

Opción:Aptitude::CmdLine::Verbose

Predeterminado:0

Descripción: Controlar cuanta información recibe en modo de línea de órdenes
de aptitude. Cada aparición de la opción -v añade 1 a este valor.

Opción:Aptitude::CmdLine::Visual-Preview

Predeterminado:false

Descripción: Si esta opción vale true, aptitude entrará en modo gráfico para
poder previsualizar el proceso de instalación, y descargar paquetes.

Opción:Aptitude::Debtags-Binary

Predeterminado:/usr/bin/debtags

Descripción: La ruta absoluta de la orden debtags. Si se configura con
compatibilidad para libept, aptitude ejecutará este programa siempre que
actualice la lista de paquetes, dirigiendo a este los argumentos listados en
Aptitude::Debtags-Update-Options.

Opción:Aptitude::Debtags-Update-Options

Predeterminado:--local

Descripción: Puede introducir opciones adicionales a debtags update al
invocarlo después de actualizar la lista de paquetes. Estos se dividen por
espacios; reconoce también las cadenas entre comillas así que configurar esto
como &#8220;--vocabulary='/file with a space&#8221; guarda el vocabulario de
debtags en &#8220;/file with a space&#8221;.

Opción:Aptitude::Delete-Unused

Predeterminado:true

Descripción: Si activa esta opción, se eliminarán los paquetes instalados
automáticamente que ya no se requieran. Para más información, véase
&#8220;Gestionar paquetes automáticamente instalados.&#8221;.

Opción:Aptitude::Delete-Unused-Pattern

Predeterminado:

Descripción: Alias obsoleto para Aptitude::Keep-Unused-Pattern. Si configura
Aptitude::Keep-Unused-Pattern con una cadena vacía el valor de esta opción de
configuración lo sobreescribirá. De otra manera, se ignora Aptitude::Delete-
Unused-Pattern.

Opción:Aptitude::Display-Planned-Action

Predeterminado:true

Descripción: Si esta opción vale true, aptitude mostrará una
previsualización antes de ejecutar las acciones que desea llevar a cabo.

Opción:Aptitude::Forget-New-On-Install

Predeterminado:false

Descripción: Si esta opción vale true, aptitude vaciará la lista de paquetes
nuevos en el momento que instale, actualice o elimine paquetes, al igual que si
ejecuta Acciones ->; Olvidar paquetes nuevos (f).

Opción:Aptitude::Forget-New-On-Update

Predeterminado:false

Descripción: Si esta opción vale true, aptitude vaciará la lista de paquetes
nuevos en el momento que actualice la lista de paquetes, al igual que si ejecuta
Acciones ->; Olvidar paquetes nuevos (f).

Opción:Aptitude::Get-Root-Command

Predeterminado:su:/bin/su

Descripción: This option sets the external command that aptitude will use to
switch to the root user (see &#8220;Convertirse en root.&#8221;). It has the
form protocol:command. protocol must be either su or sudo; it determines how
aptitude invokes the program when it wants to gain root privileges. If protocol
is su, then &#8220;command -c arguments&#8221; is used to become root;
otherwise, aptitude uses &#8220;command arguments&#8221;. The first word in
command is the name of the program that should be invoked; remaining words are
treated as arguments to that program.

Opción:Aptitude::Ignore-Old-Tmp

Predeterminado:false

Descripción: Versiones anteriores de aptitude creaban una carpeta
~/.aptitude/.tmp, ya obsoleto. Si la carpeta existe y Aptitude::Ignore-Old-Tmp
vale true, aptitude le preguntará si desea eliminar esta carpeta. La opción
será true automáticamente tras su respuesta. Por otro lado, si la carpeta no
existe, esta opción hará que aptitude tome esto como false para así
notificarle en caso de que reaparezca.

Opción:Aptitude::Ignore-Recommends-Important

Predeterminado:false

Descripción: In previous versions of aptitude, the setting Aptitude::
Recommends-Important caused recommendations to be installed automatically, the
same way that Apt::Install-Recommends does today. If this option is set to false
and Aptitude::Recommends-Important is also set to false, aptitude will set Apt::
Install-Recommends to false and set Aptitude::Ignore-Recommends-Important to
true on startup.

Opción:Aptitude::Keep-Recommends

Predeterminado:false

Descripción: Esta opción está obsoleta; utilice Apt::AutoRemove::Recommends-
Important en lugar de ello. Definir esta opción como true tiene el mismo efecto
que definir Apt::AutoRemove::Recommends-Important como true.

Opción:Aptitude::Keep-Suggests

Predeterminado:false

Descripción: Esta opción está obsoleta; utilice Apt::AutoRemove::Suggests-
Important en lugar de ello. Definir esta opción como true tiene el mismo efecto
que definir Apt::AutoRemove::Suggests-Important como true.

Opción:Aptitude::Keep-Unused-Pattern

Predeterminado:

Descripción: Si Aptitude::Delete-Unused vale true, solo se eliminarán aquellos
paquetes que no se correspondan con el patrón (véase &#8220;Patrones de
búsqueda&#8221;). Si define esta opción como una cadena vacía (opción
predeterminada), se eliminan todos aquellos paquetes no usados.

Opción:Aptitude::LockFile

Predeterminado:/var/lock/aptitude

Descripción: Un archivo que estará «fcntl-locked» para asegurar que sólo un
proceso de aptitude pueda modificar el almacén en cada momento. Nunca tendrá
la necesidad de modificar esto en circunstancias normales; aunque puede ser
útil para depurar fallos. Nota: si aptitude informa que no puede conseguir el
permiso único sobre el archivo, esto no significa que necesite destruir el
archivo. Los «fcntl locks» (cerrojos) se gestionan por el kernel y son
destruidos cuando el programa que los emplea finaliza; un fallo en el momento de
adquirir el permiso significa que otro programa lo está usando.

Opción:Aptitude::Log

Predeterminado:/var/log/aptitude

Descripción: Si define esto como una cadena vacía, aptitude registrará las
instalaciones de paquetes, eliminaciones y actualizaciones que lleve a cabo. Si
el valor de Aptitude::Log empieza con un carácter de segmentación (p.ej.,
&#8220;|&#8221;), el resto de su valor se emplea como el nombre de una orden al
cual se redirigirá el registro: por ejemplo, |mail -s 'Aptitude install run'
root permite mandar el registro al root por correo electrónico. Puede definir
esta opción como una lista de objetivos de archivos de registro para registrar
varios archivos u órdenes,.

Opción:Aptitude::Logging::File

Predeterminado:

Descripción: If this is set to a nonempty string, aptitude will write logging
messages to it; setting it to &#8220;-&#8221; causes logging messages to be
printed to standard output. This differs from the setting Aptitude::Log: that
file is used to log installations and removals, whereas this file is used to log
program events, errors, and debugging messages (if enabled). This option is
equivalent to the command-line argument --log-file. See also Aptitude::Logging::
Levels.

Opción:Aptitude::Logging::Levels

Predeterminado:(empty)

Descripción: Esta opción es un grupo en el que sus miembros controlan qué
mensajes del registro se escriben. Cada entrada es, o bien &#8220;nivel&#8221;,
para definir el nivel de registro global (el nivel de registro del registrador
del administrador) con el &#8220;nivel&#8221; insertado, o bien
&#8220;categoría:nivel&#8221;, donde categoría es la categoría de los
mensajes que modificar (tales como aptitude.resolver.hints.match), y nivel es el
nivel más bajo de registro de mensajes en esa categoría que se deberían ver.
Los niveles de registro válidos son &#8220;fatal&#8221;, &#8220;error&#8221;,
&#8220;warn&#8221; (aviso), &#8220;info&#8221; (información),
&#8220;debug&#8221; (depuración de fallos), y &#8220;trace&#8221; (rastro).
Puede emplear la opción en línea de órdenes --log-level para definir o
invalidar cualquier nivel de registro.

Opción:Aptitude::Parse-Description-Bullets

Predeterminado:true

Descripción: Si activa esta opción, aptitude intentará detectar
automáticamente listas por puntos en las descripciones de paquete. En líneas
generales, esto mejorará como se muestran las descripciones, pero no tiene una
compatibilidad inversa total; algunas descripciones recibirán un formato menos
atractivo cuando ésta opción sea true a cuando sea false.

Opción:Aptitude::Pkg-Display-Limit

Predeterminado:

Descripción: El filtro predeterminado que se aplica a la lista de paquetes;
véase &#8220;Patrones de búsqueda&#8221; para ver los detalles acerca de su
formato.

Opción:Aptitude::ProblemResolver::Allow-Break-Holds

Predeterminado:false

Descripción: Si da a esta opción valor de true, el solucionador de problemas
considerará romper la retención de cualquier paquete o instalar versiones
prohibidas si con ello puede resolver una dependencia. Si lo define como false,
se rechazarán estas acciones de forma predeterminada, aunque siempre puede
activarlas manualmente (véase &#8220;Resolver dependencias de manera
interactiva.&#8221;).

Opción:Aptitude::ProblemResolver::BreakHoldScore

Predeterminado:-300

Descripción: Cuánto premiar o penalizar soluciones que modifican el estado de
un paquete retenido o que instalan versiones prohibidas. Observe que a menos que
Aptitude::ProblemResolver::Allow-Break-Holds tenga valor de true, el
solucionador nunca romperá una retención o instalará una versión prohibida a
menos que tenga el permiso explicito del usuario.

Opción:Aptitude::ProblemResolver::Break-Hold-Level

Predeterminado:50000

Descripción: The safety cost assigned to actions that break a hold set by the
user (by upgrading a held package or by installing a forbidden version of a
package). See &#8220;Safety costs&#8221; for a description of safety costs.

Opción:Aptitude::ProblemResolver::BrokenScore

Predeterminado:-100

Descripción: Cuánto premiar o penalizar soluciones potenciales en base al
número de dependencias que rompen. Este número se añadirá a la puntuación
de cada solución por cada dependencia rota que genere; por lo general, éste
tiene un valor negativo.

Opción:Aptitude::ProblemResolver::DefaultResolutionScore

Predeterminado:400

Descripción: Cuánto premiar o penalizar una solución potencial en base a
cuantas resoluciones &#8220;predeterminadas&#8221; instalan por dependencias
actualmente insatisfechas. La resolución predeterminada es la que tomaría
&#8220;apt-get install&#8221; o el &#8220;solucionador de dependencias
inmediato&#8221;. La puntuación sólo se aplica a las dependencias y
recomendaciones cuyos objetivos no están instalados actualmente en el sistema.

Opción:Aptitude::ProblemResolver::Discard-Null-Solution

Predeterminado:true

Descripción: Si esta opción tiene valor de true, aptitude nunca sugerirá
cancelar todas las acciones propuestas para poder resolver un problema de
dependencias.

Opción:Aptitude::ProblemResolver::EssentialRemoveScore

Predeterminado:-100000

Descripción: Cuánto premiar o penalizar soluciones que eliminan un paquete
Esencial.

Opción:Aptitude::ProblemResolver::Remove-Essential-Level

Predeterminado:60000

Descripción: The safety cost assigned to actions that remove an Essential
package. See &#8220;Safety costs&#8221; for a description of safety costs.

Opción:Aptitude::ProblemResolver::ExtraScore

Predeterminado:-1

Descripción: Este número se añadirá a la puntuación de cualquier paquete
con prioridad &#8220;extra&#8221;.

Opción:Aptitude::ProblemResolver::FullReplacementScore

Predeterminado:500

Descripción: Este número se añade al puntuación de una solución que elimina
un paquete e instala otro que lo reemplaza por completo (p. ej., tiene un
conflicto, lo reemplaza, y lo provee).

Opción:Aptitude::ProblemResolver::FutureHorizon

Predeterminado:50

Descripción: Cuántos &#8220;pasos&#8221; debe tomar el solucionador antes de
encontrar la primera solución. Aunque aptitude intenta generar las mejores
soluciones antes que las peores es a veces incapaz de ello; esta configuración
permite al solucionador buscar brevemente una solución mejor antes de mostrar
los resultados, a diferencia de detenerse inmediatamente tras encontrar la
primera solución.

Opción:Aptitude::ProblemResolver::Hints

Predeterminado:(empty)

Descripción: Esta opción es un grupo en el cual sus miembros se utilizan para
configurar el solucionador de problemas. Cada elemento del grupo es una cadena
que describe la acción que se debería aplicar a uno o más paquetes. La
sintaxis para cada indicación y el efecto que tiene se pueden ver en
&#8220;Configurar indicaciones del solucionador&#8221;.

Opción:Aptitude::ProblemResolver::ImportantScore

Predeterminado:5

Descripción: Este número se añade a la puntuación de cualquier versión de
un paquete con una prioridad &#8220;importante&#8221;.

Opción:Aptitude::ProblemResolver::Infinity

Predeterminado:1000000

Descripción: La puntuación &#8220;máxima&#8221; para soluciones en potencia.
Si un conjunto de acciones tiene una puntuación peor que -Infinity, se
descartará inmediatamente.

Opción:Aptitude::ProblemResolver::InstallScore

Predeterminado:-20

Descripción: Cuánta importancia otorga el solucionador de paquetes a la
instalación de un paquete si éste no se va a instalar a petición del usuario.

Opción:Aptitude::ProblemResolver::Keep-All-Level

Predeterminado:20000

Descripción: The safety cost assigned to the single solution that cancels all
of the actions selected by the user. See &#8220;Safety costs&#8221; for a
description of safety costs.

Opción:Aptitude::ProblemResolver::KeepScore

Predeterminado:0

Descripción: Cuánta importancia otorga el solucionador de problemas a mantener
un paquete en su estado actual, si éste no se va mantener en su estado actual a
petición del usuario.

Opción:Aptitude::ProblemResolver::NonDefaultScore

Predeterminado:-40

Descripción: Cuánta importancia otorga el solucionador de problemas a instalar
una versión no predeterminada de un paquete (una que no es la versión presente
y tampoco la &#8220;versión candidata&#8221;).

Opción:Aptitude::ProblemResolver::Non-Default-Level

Predeterminado:50000

Descripción: The safety cost assigned to actions that install non-default
versions of a package. For instance, if version 5 of a package is installed,
versions 6, 7, and 8 are available, and version 7 is the default version, then
versions 6 and 8 will be given a safety cost that is at least this high. See
&#8220;Safety costs&#8221; for a description of safety costs.

Opción:Aptitude::ProblemResolver::OptionalScore

Predeterminado:1

Descripción: Este número se añade a la puntuación de toda versión de un
paquete con prioridad &#8220;opcional&#8221;

Opción:Aptitude::ProblemResolver::PreserveAutoScore

Predeterminado:0

Descripción: Cuánta importancia otorga el solucionador de problemas a
conservar las instalaciones automáticas o eliminaciones.

Opción:Aptitude::ProblemResolver::PreserveManualScore

Predeterminado:60

Descripción: Cuanta importancia otorga el solucionador a conservar selecciones
explícitas del usuario.

Opción:Aptitude::ProblemResolver::RemoveScore

Predeterminado:-300

Descripción: Cuánta importancia otorga el solucionador de problemas a eliminar
un paquete (si no está ya marcado para su eliminación).

Opción:Aptitude::ProblemResolver::Remove-Level

Predeterminado:10000

Descripción: The safety cost assigned to actions that remove a package. See
&#8220;Safety costs&#8221; for a description of safety costs.

Opción:Aptitude::ProblemResolver::RequiredScore

Predeterminado:4

Descripción: Este número se añade a la puntuación de toda versión de un
paquete con prioridad de &#8220;requiere&#8221;.

Opción:Aptitude::ProblemResolver::ResolutionScore

Predeterminado:50

Descripción: Además de todos los otros factores de puntuación, las soluciones
propuestas que resuelven todas las dependencias insatisfechas reciben esta
cantidad de puntos adicionales.

Opción:Aptitude::ProblemResolver::Safe-Level

Predeterminado:10000

Descripción: The safety cost assigned to actions that install the default
version of a package, upgrade a package to its default version, or cancel
installing or upgrading a package. Solutions assigned this cost could be
generated by aptitude safe-upgrade. See &#8220;Safety costs&#8221; for a
description of safety costs.

Opción:Aptitude::ProblemResolver::SolutionCost

Predeterminado:safety,priority

Descripción: Describes how to determine the cost of a solution. See
&#8220;Costs in the interactive dependency resolver&#8221; for a description of
what solution costs are, what they do, and the syntax used to specify them. If
the cost cannot be parsed, an error is issued and the default cost is used
instead.

Opción:Aptitude::ProblemResolver::StandardScore

Predeterminado:3

Descripción: Este número se añade a la puntuación de toda versión de un
paquete con prioridad &#8220;estándar&#8221;.

Opción:Aptitude::ProblemResolver::StepLimit

Predeterminado:5000

Descripción: El número máximo de &#8220;pasos&#8221; que debería tomar el
solucionador de problemas a cada intento de encontrar una solución a un
problema de dependencias. Si reduce este número, aptitude se dará antes
&#8220;por vencido&#8221;; si lo aumenta, permitirá que la búsqueda de una
solución pueda tomar más tiempo y memoria antes de interrumpirse. Si define el
valor de StepLimit como 0, desactivaría totalmente el solucionador de
problemas. El valor predeterminado es suficientemente alto para gestionar
cómodamente las situaciones más comunes, a la vez que impide que aptitude
&#8220;explote&#8221; en caso de encontrarse con un problema más complicado.
(Nota: ésto sólo afecta a las búsquedas en línea de órdenes; en la interfaz
gráfica el solucionador continuará hasta encontrar una solución)

Opción:Aptitude::ProblemResolver::StepScore

Predeterminado:70

Descripción: Cuánto premiar o castigar soluciones potenciales en base a su
longitud. Este número de puntos se añade por cada acción realizada por la
solución. Cuanto más alto sea este valor, más tenderá el solucionador a
conservarlo en lugar de considerar otras alternativas; esto causará que la
solución se genere más rápidamente, pero ésta puede ser de menor calidad que
en situaciones normales.

Opción:Aptitude::ProblemResolver::Trace-Directory

Predeterminado:

Descripción: Si define este valor, cada vez que el solucionador de problemas
genere una solución guardará una versión simplificada del estado del paquete,
que se puede emplear para reproducir la misma solución. Si define también
Aptitude::ProblemResolver::Trace-File, se escribirá la misma información en el
archivo de seguimiento («trace-file»). Los directorios de seguimiento son más
transparentes que los archivos de seguimiento, y más adecuados para, por
ejemplo, incluir arboles de fuentes como casos de prueba.

Opción:Aptitude::ProblemResolver::Trace-File

Predeterminado:

Descripción: Si define este valor, cada vez que el solucionador de problemas
genere una solución guardará una versión simplificada del estado del paquete,
que se puede emplear para reproducir la misma solución. Si define también
Aptitude::ProblemResolver::Trace-Directory, se escribirá la misma información
en el directorio de seguimiento («trace-directory»). Un archivo de seguimiento
es simplemente un directorio de seguimiento comprimido en un archivo; ocupa
menos espacio que el directorio de seguimiento y es más apropiado para su
transmisión a través de una red.

Opción:Aptitude::ProblemResolver::UndoFullReplacementScore

Predeterminado:-500

Descripción: Esta puntuación se asigna a la acción de instalar un paquete y
eliminar otro que lo reemplaza totalmente (p. ej., conflicto de dependencias,
reemplaza y provee).

Opción:Aptitude::ProblemResolver::UnfixedSoftScore

Predeterminado:-200

Descripción: Cuánto premiar o penalizar el no resolver una relación de
«Recomienda». Generalmente, este número es menor que «RemoveScore», o
aptitude tenderá a eliminar paquetes antes que dejar sus recomendaciones sin
resolver. Para más detalles, véase &#8220;Resolver dependencias de manera
interactiva.&#8221;.

Opción:Aptitude::ProblemResolver::UpgradeScore

Predeterminado:0

Descripción: Cuánta importancia otorga el solucionador de problemas a
actualizar (o desactualizar) un paquete a su versión candidata, en caso de que
el paquete no estuviese marcado para actualizar.

Opción:Aptitude::Purge-Unused

Predeterminado:false

Descripción: Si define esta opción con valor de true y si Aptitude::Delete-
Unused es también true, se purgarán del sistema los paquetes no usados,
eliminando sus datos de configuración así como quizás otros datos
importantes. Para más información relativa a qué paquetes se consideran
&#8220;no usados&#8221;, véase &#8220;Gestionar paquetes automáticamente
instalados.&#8221;. ¡ÉSTA OPCIÓN PUEDE CAUSAR PÉRDIDA DE DATOS! ¡NO LA
HABILITE A MENOS QUE SEPA LO QUE ESTÁ HACIENDO!

Opción:Aptitude::Recommends-Important

Predeterminado:true

Descripción: Esta es una opción de configuración obsoleta y que Apt::Install-
Recommends ha reemplazado. Al inicio, aptitude copiará Aptitude::Recommends-
Important (si existe) a Apt::Install-Recommends y después vaciará Aptitude::
Recommends-Important en su archivo de configuración de usuario.

Opción:Aptitude::Safe-Resolver::No-New-Installs

Predeterminado:false

Descripción: If this option is true, then when the &#8220;safe&#8221;
dependency resolver has been activated via --safe-resolver or by using the safe-
upgrade command-line action, the resolver will not be allowed to install
packages that are not currently installed.

Opción:Aptitude::Safe-Resolver::No-New-Upgrades

Predeterminado:false

Descripción: If this option is enabled, then when the &#8220;safe&#8221;
dependency resolver has been activated via --safe-resolver or by using the safe-
upgrade command-line action, the resolver will not be allowed to resolve
dependencies by upgrading packages.

Opción:Aptitude::Sections::Descriptions

Predeterminado:Véase $prefix/share/aptitude/section-descriptions

Descripción: Esta opción es un grupo cuyos miembros definen las descripciones
mostradas para cada sección cuando emplea la directriz de agrupación
&#8220;section&#8221; para la jerarquía de paquetes. Las descripciones se
asignan a árboles de sección en base al último componente del nombre: por
ejemplo, un miembro del grupo llamado &#8220;games&#8221; se utilizará para
describir las secciones &#8220;games&#8221;, &#8220;non-free/games&#8221;, y
&#8220;non-free/desktop/games&#8221;. En el texto comprendido en las
descripciones de sección, se reemplaza la cadena &#8220;\n&#8221; por un corte
de líneas, y la cadena &#8220;''&#8221;, por una comilla doble.

Opción:Aptitude::Sections::Top-Sections

Predeterminado:"main"; "contrib"; "non-free"; "non-US";

Descripción: A configuration group whose elements are the names of the top-
level archive sections. The &#8220;topdir&#8221;, &#8220;subdir&#8221;, and
&#8220;subdirs&#8221; grouping policies use this list to interpret Section
fields: if the first path element of a package's Section is not contained in
this list, or if its Section has only one element, then the package will be
grouped using the first member of this list as its first path element. For
example, if the first member of Top-Sections is &#8220;main&#8221;, then a
package whose Section is &#8220;games/arcade&#8221; will be treated as if its
Section field were &#8220;main/games/arcade&#8221;.

Opción:Aptitude::Simulate

Predeterminado:false

Descripción: En modo de línea de órdenes, hace que aptitude solo muestre las
acciones que se van a llevar a cabo (en lugar de llevarlas a cabo directamente);
en la interfaz gráfica, hace que aptitude se inicie en modo de solo lectura
independientemente de si usted es root (administrador), o no. Ésto equivale a
la opción en línea de órdenes -s.

Opción:Aptitude::Spin-Interval

Predeterminado:500

Descripción: El número de segundos que dejar entre actualizar la
&#8220;rueda&#8221; que aparece cuando el solucionador de problemas está en
ejecución.

Opción:Aptitude::Suggests-Important

Predeterminado:false

Descripción: Esta opción está obsoleta; utilice Apt::AutoRemove::Suggests-
Important en lugar de ello. Definir esta opción como true tiene el mismo efecto
que definir Apt::AutoRemove::Suggests-Important como true.

Opción:Aptitude::Suppress-Read-Only-Warning

Predeterminado:false

Descripción: Si define esto como false, aptitude mostrará un aviso la primera
vez que intente modificar el estado de los paquetes cuando aptitude está en
modo de sólo lectura.

Opción:Aptitude::Theme

Predeterminado:

Descripción: El tema que aptitude debe utilizar; para más información, véase
&#8220;Temas.&#8221;.

Opción:Aptitude::Track-Dselect-State

Predeterminado:true

Descripción: Si define esta opción como true, aptitude intentará detectar si
se ha modificado el estado de un paquete con dselect o con la orden dpkg: por
ejemplo, si elimina un paquete utilizando dpkg, aptitude no intentará
reinstalarlo. Observe que este comportamiento puede ser errático.

Opción:Aptitude::UI::Advance-On-Action

Predeterminado:false

Descripción: Si define esta opción como true, aptitude resaltará el siguiente
elemento del grupo tras modificar el estado de un paquete.

Opción:Aptitude::UI::Auto-Show-Reasons

Predeterminado:true

Descripción: Si define esta opción como true, al seleccionar un paquete roto o
que parece causar que otros paquetes estén rotos el área de información
mostrará algunas de las razones de porqué la ruptura tiene lugar.

Opción:Aptitude::UI::Default-Grouping

Predeterminado:filter(missing),status,section(subdirs,passthrough),section
(topdir)

Descripción: Definir la directriz de agrupación predeterminada utilizada en
las listas de paquetes. Para información adicional acerca de las directrices de
agrupación, véase &#8220;Personalizar la jerarquía de paquetes&#8221;.

Opción:Aptitude::UI::Default-Package-View

Predeterminado:

Descripción: Esta opción es un grupo cuyos miembros definen la presentación
predeterminada de la interfaz de aptitude. Para más información, véase
&#8220;Personalizar el diseño de la interfaz.&#8221;.

Opción:Aptitude::UI::Default-Preview-Grouping

Predeterminado:action

Descripción: Definir la directriz de agrupación predeterminada para las
pantallas de previsualización. Para información adicional acerca de las
directrices de agrupación, véase &#8220;Personalizar la jerarquía de
paquetes&#8221;.

Opción:Aptitude::UI::Default-Sorting

Predeterminado:name

Descripción: La directriz de ordenación predeterminada para la vista de
paquetes. Para más información, véase &#8220;Personalizar cómo se ordenan
los paquetes&#8221;.

Opción:Aptitude::UI::Description-Visible-By-Default

Predeterminado:true

Descripción: Cuando se muestra una lista de paquetes, el área de información
(que generalmente contiene la descripción completa del paquete seleccionado)
será visible si la opción tiene valor de true, y estará oculta si el valor es
false.

Opción:Aptitude::UI::Exit-On-Last-Close

Predeterminado:true

Descripción: Si define esta opción como true, cerrar todas las vistas activas
cierra aptitude; de no ser así aptitude no se cerrará hasta que invoque la
orden Acciones ->; Salir (Q). Para más información, véase &#8220;Trabajar
con varias vistas.&#8221;.

Opción:Aptitude::UI::Fill-Text

Predeterminado:false

Descripción: Si define esta opción como true, aptitude le dará un formato a
las descripciones de manera que cada línea ocupe exactamente el ancho de la
pantalla.

Opción:Aptitude::UI::Flat-View-As-First-View

Predeterminado:false

Descripción: Si define esta opción como true, aptitude mostrará una vista
plana al inicio, en lugar de la vista predeterminada.

Opción:Aptitude::UI::HelpBar

Predeterminado:true

Descripción: Si define esta opción como true, verá una línea con los atajos
de teclado más importantes en la parte superior de la pantalla.

Opción:Aptitude::UI::Incremental-Search

Predeterminado:true

Descripción: Si define esta opción como true, aptitude realizará búsquedas
&#8220;incrementales&#8221;: a medida que introduce el patrón de búsqueda,
buscará el siguiente paquete que se corresponda con lo que ha introducido hasta
el momento.

Opción:Aptitude::UI::InfoAreaTabs

Predeterminado:false

Descripción: Si define esta opción como true, aptitude mostrará pestañas
justo encima del área de información (el panel en el fondo de la pantalla),
describiendo los diferentes modos en los que puede configurar esta área.

Opción:Aptitude::UI::Keybindings

Predeterminado:

Descripción: Éste es un grupo cuyos miembros definen las conexiones entre
atajos de teclado y órdenes dentro de aptitude. Para más información, véase
&#8220;Personalizar teclas rápidas.&#8221;.

Opción:Aptitude::UI::Menubar-Autohide

Predeterminado:false

Descripción: Si define esta opción como true, la barra de menú estará oculta
mientras no esté en uso.

Opción:Aptitude::UI::Minibuf-Download-Bar

Predeterminado:false

Descripción: Si define esta opción como true, aptitude empleará un mecanismo
menos visible para mostrar el progreso de las descargas: verá una barra en la
base de la pantalla mostrando el estado actual de la descarga. Puede abortar una
descarga activa presionando q.

Opción:Aptitude::UI::Minibuf-Prompts

Predeterminado:false

Descripción: Si define esta opción como true, algunas preguntas (tales como
preguntas yes/no o preguntas de elección múltiple) se mostrarán en la base de
la pantalla, y no en ventanas de dialogo.

Opción:Aptitude::UI::New-Package-Commands

Predeterminado:true

Descripción: Si define esta opción como false, las órdenes tales como Paquete
->; Instalar (+) tendrán el mismo comportamiento, ya obsoleto, que tenían
en versiones anteriores de aptitude.

Opción:Aptitude::UI::Package-Display-Format

Predeterminado:%c%a%M %p %Z %v %V

Descripción: Esta opción controla la cadena formato utilizada para mostrar los
paquetes en la lista de paquetes. Para más información, véase
&#8220;Personalizar la presentación de los paquetes&#8221;.

Opción:Aptitude::UI::Package-Header-Format

Predeterminado:%N %n #%B %u %o

Descripción: Esta opción controla la cadena formato utilizada para mostrar la
cabecera de las listas de paquetes (p. ej., la línea que aparece entre la lista
de paquetes y la barra de menú). Para más información acerca de las cadenas
formato, véase &#8220;Personalizar la presentación de los paquetes&#8221;.

Opción:Aptitude::UI::Package-Status-Format

Predeterminado:%d

Descripción: Esta opción controla la cadena formato utilizada para mostrar la
línea de estado de las listas de paquetes (p. ej., la línea que aparece entre
la lista de paquetes y el área de información). Para más información
relativa a las cadenas formato, véase &#8220;Personalizar la presentación de
los paquetes&#8221;.

Opción:Aptitude::UI::Pause-After-Download

Predeterminado:OnlyIfError

Descripción: Si define esta opción como true, aptitude le preguntará si
quiere continuar con la instalación una vez finalizada la descarga. Si el valor
es OnlyIfError, el mensaje solo aparecerá en caso de que la descarga haya
fallado. De otra manera, si la opción tiene valor de false aptitude procederá
inmediatamente a la siguiente pantalla una vez finalizada la descarga.

Opción:Aptitude::UI::Preview-Limit

Predeterminado:

Descripción: El filtro predeterminado que se aplica a la pantalla de
previsualización. Para más detalles acerca de su formato, véase
&#8220;Patrones de búsqueda&#8221;.

Opción:Aptitude::UI::Prompt-On-Exit

Predeterminado:true

Descripción: Si define esta opción con valor de true, aptitude le pedirá una
confirmación cuando desee salir del programa.

Opción:Aptitude::UI::Styles

Predeterminado:

Descripción: Éste es un grupo de configuración cuyos miembros definen el
estilo de texto que aptitude emplea para mostrar información. Para más
información, véase &#8220;Personalizar los colores del texto y
estilos.&#8221;.

Opción:Aptitude::UI::ViewTabs

Predeterminado:true

Descripción: Si define esta opción con valor de false, aptitude no mostrará
&#8220;pestañas&#8221; describiendo las vistas activas presentes en el margen
superior de la pantalla.

Opción:Aptitude::Warn-Not-Root

Predeterminado:true

Descripción: Si define esta opción con valor de true, aptitude detectará
cuando precise privilegios de root (administrador), y le preguntará si desea
cambiar a la cuenta de root si aún no lo es. Para más información, véase
&#8220;Convertirse en root.&#8221;.

Opción:DebTags::Vocabulary

Predeterminado:/usr/share/debtags/vocabulary

Descripción: La ubicación del archivo de vocabulario de debtags, utilizado
para cargar los meta-datos de marcas de paquetes.

Opción:Dir::Aptitude::state

Predeterminado:/var/lib/aptitude

Descripción: El directorio en el que se guarda la información persistente de
estado de aptitude.

Opción:Quiet

Predeterminado:0

Descripción: Controlar el grado de verbosidad en el modo de línea de órdenes.
Definirlo con un valor más alto desactiva los indicadores de progreso.


Temas.

En aptitude un tema es simplemente un conjunto de configuraciones que
&#8220;están agrupados&#8221;. Los temas funcionan invalidando los valores
predeterminados de las opciones: si una opción no está definida en el archivo
de configuración del sistema, o en su propio archivo personal de
configuración, aptitude utilizará la configuración del tema presente de haber
uno disponible, antes de utilizar el valor estándar predeterminado.

Un tema es simplemente un grupo nombrado bajo Aptitude::Themes; cada opción de
configuración contenida en el grupo invalidará la correspondiente opción en
la configuración global. Por ejemplo, si selecciona el tema Dselect, la opción
Aptitude::Themes::Dselect::Aptitude::UI::Package-Display-Format invalidará el
valor predeterminado de la opción Aptitude::UI::Package-Display-Format.

Para seleccionar un tema, defina la opción de configuración Aptitude::Theme
con el nombre del tema; por ejemplo,

Aptitude::Theme Vertical-Split;

aptitude tiene integrados los siguientes temas en /usr/share/aptitude/aptitude-
defaults:



  Dselect
      Este tema hace que aptitude se parezca más en estética y funcionamiento
      al gestor de paquetes «legacy» (legado) dselect.

       Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
      f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina
      Paqs
      --\ Paquetes instalados
        --\ admin
          --\ principal - The Debian base system
      c   base  base-file 3.0.16      3.0.16      Debian base system
      miscellaneous fil
      c   base  base-pass 3.5.7       3.5.7       Debian base system master
      password a
      c   base  bash      2.05b-15    2.05b-15    The GNU Bourne Again SHell
      c   base  bsdutils  1:2.12-7    1:2.12-7    Basic utilities from 4.4BSD-
      Lite
      c   base  coreutils 5.0.91-2    5.0.91-2    The GNU core utilities
      c   base  debianuti 2.8.3       2.8.3       Miscellaneous utilities
      specific to
      c   base  diff      2.8.1-6     2.8.1-6     File comparison utilities
      base-files                      installed ; none
      required
      This package contains the basic filesystem hierarchy of a Debian system,
      and
      several important miscellaneous files, such as /etc/debian_version,
      /etc/host.conf, /etc/issue, /etc/motd, /etc/profile, /etc/nsswitch.conf,
      and
      others, and the text of several common licenses in use on Debian systems.







  Vertical-Split
      Este tema reorganiza la pantalla: la descripción del paquete seleccionado
      aparecería a la derecha de la lista de paquetes, en lugar de debajo de la
      misma. Este tema es útil en terminales muy anchas, y quizás también a
      la hora de editar la jerarquía de paquetes integrada.

       Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
      f10: Menú ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina
      Paqs
      aptitude 0.2.14.1
      --\ Paquetes instalados               Modern computers support the
      Advanced  #
        --\ admin - Utilidades de adminstración
          --\ principal - The main Debian archive  (ACPI) to allow intelligent
      power
      i   acpid         1.0.3-19   1.0.3-19   management on your system and to
      query
      i   alien         8.44       8.44       battery and configuration status.
      i   anacron       2.3-9      2.3-9
      i   apt-show-vers 0.07       0.07       ACPID is a completely flexible,
      totally
      i A apt-utils     0.5.25     0.5.25     extensible daemon for delivering
      ACPI
      i   apt-watch     0.3.2-2    0.3.2-2    events. It listens on a file
      i   aptitude      0.2.14.1-2 0.2.14.1-2 (/proc/acpi/event) and when an
      event
      i   at            3.1.8-11   3.1.8-11   occurs, executes programs to
      handle the
      i   auto-apt      0.3.20     0.3.20     event. The programs it executes
      are
      i   cron          3.0pl1-83  3.0pl1-83  configured through a set of
      i   debconf       1.4.29     1.4.29     configuration files, which can be
      i   debconf-i18n  1.4.29     1.4.29     dropped into place by packages or
      by
      i A debootstrap   0.2.39     0.2.39     the admin.
      i A deborphan     1.7.3      1.7.3
      i   debtags       0.16       0.16       In order to use this package you
      need a
      i A defoma        0.11.8     0.11.8     recent Kernel (=>2.4.7). This can
      be
      i   discover      2.0.4-5    2.0.4-5    one including the patches on
      Utilities for using ACPI power management



Jugar al Buscaminas

En el caso de que esté cansado de instalar y eliminar paquetes, aptitude
incluye una versión del clásico juego &#8220;Buscaminas&#8221;. Seleccione
Acciones ->; Jugar al buscaminas para iniciarlo; verá entonces el tablero
inicial del Buscaminas:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú  ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
Buscaminas                                              10/10 minas  13 segundos





                                   +--------+
                                   |        |
                                   |        |
                                   |        |
                                   |        |
                                   |        |
                                   |        |
                                   |        |
                                   |        |
                                   +--------+





Comprendidos en el rectángulo que aparece en la pantalla hay diez minas
ocultas. Su meta es determinar a través de la intuición, lógica y suerte,
donde están esas minas sin detonar ninguna de ellas. Para hacer ésto, ha de
descubrir todos los cuadrados que no contienen minas; al hacerlo, aprenderá
información valiosa relativa a qué cuadrados contienen minas. Cuidado:
descubrir un cuadrado que contiene una mina la detonará, finalizando la partida
inmediatamente.

Para descubrir un cuadrado (y así descubrir si hay una mina ahí escondida),
seleccione el cuadrado con las flechas de dirección y pulse Intro:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú  ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
Buscaminas                                             10/10 minas  387 segundos





                                   +--------+
                                   | 2......|
                                   | 2111...|
                                   |    1...|
                                   | 1111...|
                                   |11...111|
                                   |...113  |
                                   |1122    |
                                   |        |
                                   +--------+





Como puede ver en la imagen, algunas partes ocultas (vacías) del tablero han
quedado descubiertas. Los cuadrados que contengan un . son aquellos que no
están contiguos a una mina; los números que aparecen en los cuadrados
restantes indican la distancia a la que están de las minas.

Si cree saber donde está una mina, puede &#8220;marcar&#8221; el cuadrado. Para
hacer esto, seleccione el cuadrado sospechoso y pulse f. Por ejemplo, en la
imagen inferior, decidí que el cuadrado en el lado izquierdo del tablero
parecía sospechoso...

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú  ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
Buscaminas                                              9/10 minas  961 segundos





                                   +--------+
                                   | 2......|
                                   | 2111...|
                                   |    1...|
                                   |F1111...|
                                   |11...111|
                                   |...113  |
                                   |1122    |
                                   |        |
                                   +--------+





Como puede ver, hay una F en el cuadrado seleccionado. Ya no puede descubrir
este cuadrado, incluso por accidente, hasta que elimine la marca (pulsando f
otra vez). Una vez que haya marcado todas las minas contiguas a un cuadrado (por
ejemplo, aquellos cuadrados etiquetados con 1 contiguas a la marca) puede hacer
un &#8220;barrido&#8221; en torno al cuadrado. Este es solo un conveniente atajo
para descubrir todos los cuadrados cerca de él (exceptuando aquellos
marcados,por supuesto). Por ejemplo, haciendo un barrido en torno al 1 de la
imagen superior:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú  ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
Buscaminas                                              9/10 minas  2290
segundos





                                   +--------+
                                   | 2......|
                                   | 2111...|
                                   |221 1...|
                                   |F1111...|
                                   |11...111|
                                   |...113  |
                                   |1122    |
                                   |        |
                                   +--------+





Afortunadamente (¿o ha sido suerte?), mi suposición acerca de la ubicación de
la mina era correcta. De haber errado, habría perdido inmediatamente:

 Acciones  Deshacer  Paquete  Buscar  Opciones  Vistas  Ayuda
f10: Menú  ?: Ayuda q: Salir u: Actualizar g: Descarga/Instala/Elimina Paqs
Buscaminas                              Buscaminas    Perdió en 2388 segundos





                                   +--------+
                                   |^2......|
                                   |^2111...|
                                   |221^1...|
                                   |^1111...|
                                   |11...111|
                                   |...113^ |
                                   |1122* ^ |
                                   | ^ ^   ^|
                                   +--------+





Cuando pierda se revelará la ubicación de todas las minas: aquellas que no han
explotado están marcadas con un símbolo de intercalación (^), y se indica la
que ha &#8220;pisado&#8221; con un asterisco (*).



--------------------------------------------------------------------------------
[7]Me complace decir que el número de peticiones de esta índole cayeron
dramáticamente a continuación de la primera publicación de esta guía. Sería
una agradable coincidencia de haber una conexión entre ambos eventos.

[8]A esto se le denomina a veces como un &#8220;proceso de instalación&#8221;,
aunque lo que en realidad esté haciendo sea eliminar o actualizar paquetes,
además de instalarlos.

[9]Como se ha mencionado antes, esto no índica que los paquetes del archivo
sean seguros, o incluso no maliciosos; simplemente muestra que son genuinos.

[10] Más exactamente: se desinstalarán cuando nada conduzca a ellos a través
de «Depende», «Predepende» o «Recomienda» desde un paquete instalado
manualmente. Si Aptitude::Keep-Suggests es «true», una relación de
«Sugiere» es también suficiente para mantener un paquete instalado.

[11]O cuando la resolución inmediata se desactiva.

[12]El paquete con la más alta prioridad en dpkg, no el paquete con la más
alta prioridad apt pin.

[13]This limit was imposed because more complex cost structures could make it
difficult to optimize the resolver. Future versions of the program might remove
some of the restrictions if they turn out to be unnecessary.

[14] aptitude trata la coma de manera única si hay un segundo argumento, con lo
cual &#8220;?name(apt,itude)&#8221; busca la cadena &#8220;apt,itude&#8221; en
el campo de Name de los paquetes.

Aunque este comportamiento está bien definido, puede dar lugar a sorpresas.
Recomiendo usar las comillas dobles para todo patrón que contenga caracteres
que puedan tener algún significado particular.

[15] Los caracteres con un significado especial incluyen: &#8220;+&#8221;,
&#8220;-&#8221;, &#8220;.&#8221;, &#8220;(&#8221;, &#8220;)&#8221;,
&#8220;|&#8221;, &#8220;[&#8221;, &#8220;]&#8221;, &#8220;^&#8221;,
&#8220;$&#8221; y &#8220;?&#8221;. Observe que algunos de estos son también
meta-caracteres de aptitude, así que si quiere introducir, por ejemplo, un
&#8220;|&#8221; literal, debe usar una barra invertida: &#8220;?description
(\~|)&#8221; muestra paquetes cuya descripción contiene un carácter de barra
vertical (&#8220;|&#8221;).

[16] También están disponibles las secuencias de escape \\, \n, y \t

[17] El lector astuto habrá notado que, esencialmente, ésta es una manera de
nombrar de manera explicita la variable en los lambda; - términos
correspondientes al término. Generalmente, un término tiene la forma
&#8220;lambda; x, el nombre es igual a (x, patrón)&#8221;; dando lugar a que un
objetivo explicito x sea visible en el lenguaje de búsqueda.

[18] Esto se ha implementado principalmente por simetría con ?true.

[19]Etiquetar no es posible por el momento; este escape existe para un uso
futuro.

[20] En algunas terminales, un fondo &#8220;amarillo&#8221; aparecerá marrón.


Capítulo 3. Preguntas más frecuentes de aptitude


�  &#8220;¿Cual .... es su nombre?&#8221;                                 � 

   &#8220;Yo soy Arturo, rey de los Bretones.&#8221;

   &#8220;¿Cual ... es su cruzada?&#8221;

   &#8220;¡Busco el Santo Grial!&#8221;

   &#8220;¿Cual ... es la velocidad de vuelo de una golondrina sin
   cargamento?&#8221;

   &#8220;¿A que se refiere? A una golondrina africana, o europea?&#8221;

   &#8220;¿Hmmm? Yo ... no lo sé---AAAAAAAAGGGHH!&#8221;

�                                            -- Monty Python y el Santo Grial




  3.1. ¿Como puedo encontrar sólo un paquete en base al nombre?

  3.2. ¿Como puedo encontrar paquetes rotos?

  3.3. I want to select text, why doesn't aptitude let me disable the mouse?


3.1. ¿Como puedo encontrar sólo un paquete en base al nombre?

     Como se menciona en &#8220;Patrones de búsqueda&#8221;, cuando realiza una
     búsqueda de un paquete en base al nombre, el texto que introduce es en
     realidad una expresión regular. Por ello, el patrón de búsqueda
     &#8220;^nombre$&#8221; sólo coincidiría con un paquete llamado nombre.

     Por ejemplo, puede buscar apt (pero no aptitude o synaptic) introduciendo
     ^apt$; puede buscar g++ (pero no g++-2.95 o g++-3.0) introduciendo ^g\+\+$.

3.2. ¿Como puedo encontrar paquetes rotos?

     Utilice la orden Buscar ->; Buscar Roto (b).

3.3. I want to select text, why doesn't aptitude let me disable the mouse?

     Normalmente, no puede seleccionar texto empleando el ratón en una terminal
     xterm mientras haya un programa ejecutándose en esa terminal (tal como
     aptitude). Puede, no obstante, invalidar este comportamiento y llevar a
     cabo una selección presionando continuadamente Shift mientras pulsa sobre
     la terminal.



Capítulo 4. Créditos


�  Nadie recuerda al cantante. La canción permanece. � 

�                      -- Terry Pratchett, The Last Hero


Esta sección es un homenaje a algunas de las personas que han contribuido a
aptitude a lo largo de su vida.


 [Nota]  Nota

         Esta sección está más bien incompleta, y es probable que se
         actualice y que crezca a medida que pase el tiempo (en particular,
         muchos de ellos son créditos de las traducciones debido al alto
         número de fuentes de traducciones[21]). Si piensa que debería
         aparecer en esta lista, escríbame a la dirección
         <dburrows@debian.org> con una explicación de porqué piensa que debe
         estar.


Traducciones e internacionalización



  Traducción al portugués de Brasil
      Andre Luis Lopes, Gustavo Silva


  Traducción al chino
      Carlos Z.F. Liu


  Traducción al checo
      Miroslav Kure


  Traducción al danés
      Morten Brix Pedersen, Morten Bo Johansen


  Traducción al neerlandés
      Luk Claes


  Traducción al finlandés
      Jaakko Kangasharju


  Traducción al francés
      Martin Quinson, Jean-Luc Coulon


  Traducción al alemán
      Sebastian Schaffert, Erich Schubert, Sebastian Kapfer, Jens Seidel


  Traducción al italiano
      Danilo Piazzalunga


  Traducción al japonés
      Yasuo Eto, Noritada Kobayashi


  Traducción al lituano
      Darius ?itkevicius


  Traducción al polaco
      Michal Politowski


  Traducción al portugués
      Nuno Sénica, Miguel Figueiredo


  Traducción al noruego
      Håvard Korsvoll


  Traducción al español
      Jordi Malloch, Rubén Porras, Javier Fernández-Sanguino, Omar Campagne
      Polaino


  Traducción al sueco
      Daniel Nylander


  Parche inical de i18n
      Masato Taruishi


  Mantenimiento y gestión de la i18n
      Christian Perrier


Documentación



  Manual de usuario
      Daniel Burrows


Programación



  Diseño del programa e implementación
      Daniel Burrows


  Compatibilidad con el campo de «Breaks» (rompe) de dpkg
      Ian Jackson, Michael Vogt




--------------------------------------------------------------------------------
[21] Debería ser posible reunir una lista relativamente completa de aquellos
contribuidores de i18n en base al registro de cambios, sus referencias en el
sistema de seguimiento de fallos de Debian, y el histórico de revisiones de
aptitude, pero llevar esto a cabo requiere una alta inversión en tiempo que no
está disponible en este momento.



Referencia de la línea de órdenes

--------------------------------------------------------------------------------
Tabla de contenidos



  aptitude --; interfaz de alto nivel para la gestión de paquetes

  aptitude-create-state-bundle --; empaquetar el estado actual de aptitude

  aptitude-run-state-bundle --; desempaquetar un archivo de estado de
  aptitude e invocar aptitude sobre éste


Nombre

aptitude --; interfaz de alto nivel para la gestión de paquetes


Sinopsis

aptitude [opciones...] { autoclean | clean | forget-new | keep-all | update }

aptitude [opciones...] { full-upgrade | safe-upgrade } [paquetes...]

aptitude [options...] { build-dep | build-depends | changelog | download |
forbid-version | hold | install | markauto | purge | reinstall | remove | show |
unhold | unmarkauto | versions } packages...

aptitude extract-cache-subset directorio_de_salida paquetes...

aptitude [opciones...] search patrones...

aptitude [opciones...] { add-user-tag | remove-user-tag } etiqueta paquetes...

aptitude [opciones...] { why | why-not } [patrones...] paquete

aptitude [-S nombre_de_archivo] [ --autoclean-on-startup | --clean-on-startup |
-i | -u ]

aptitude help


Descripción

aptitude es una interfaz de texto para el sistema de paquetes de Debian GNU/
Linux.

Permite al usuario ver la lista de paquetes y realizar tareas de gestión tales
como instalar, actualizar o eliminar paquetes. Puede llevar a cabo las acciones
con una interfaz gráfica o en la línea de órdenes.


Acciones en la línea de órdenes

El primer argumento que no va precedido de un guión (&#8220;-&#8221;) se toma
como una acción que el programa ha de llevar a cabo. Si no se especifica
ninguna opción en la línea de órdenes, aptitude iniciará el modo gráfico.

Dispone de las siguientes acciones:



  install
      Instalar uno o más paquetes. Los paquetes deben aparecer después de la
      orden &#8220;install&#8221;; si un nombre de paquete contiene una tilde
      (&#8220;~&#8221;) o un signo de interrogación (&#8220;?&#8221;), se toma
      como un patrón de búsqueda y se instalará cada paquete que se
      corresponda con el patrón (véase la sección &#8220;Patrones de
      búsqueda&#8221; en el manual de referencia de aptitude)

      To select a particular version of the package, append
      &#8220;=version&#8221; to the package name: for instance, &#8220;aptitude
      install apt=0.3.1&#8221;. Similarly, to select a package from a particular
      archive, append &#8220;/archive&#8221; to the package name: for instance,
      &#8220;aptitude install apt/experimental&#8221;. You cannot specify both
      an archive and a version for a package.

       No tiene que instalar todos los paquetes enumerados en la línea de
      órdenes; puede decirle a aptitude que haga una acción diferente con cada
      paquete si añade un &#8220;especificador de invalidación&#8221; al
      nombre del paquete. Por ejemplo, aptitude remove wesnoth+ instalaría
      wesnoth, no lo eliminaría. Están disponibles los siguientes
      &#8220;especificadores de invalidación&#8221;:



        paquete+
            Instalar paquete.


        paquete+M
            Instalar el paquete, y marcarlo inmediatamente como instalado
            automáticamente (observe que si nada depende del paquete, éste se
            eliminaría inmediatamente).


        paquete-
            Eliminar paquete.


        paquete_
            Purgar el paquete: eliminarlo así como todos sus archivos de
            configuración y de datos asociados a él.


        paquete=
            Retener el paquete: impide instalar, actualizar o eliminar, así
            como cualquier futura actualización automática.


        paquete:
            Mantener el paquete en su versión actual: cancela instalar,
            eliminar o actualizar. Al contrario que &#8220;retener&#8221;
            (véase arriba) esto no impide actualizaciones automáticas en el
            futuro.


        paquete&M
            Marcar el paquete como automáticamente instalado.


        paquete&m
            Marcar el paquete como manualmente instalado.


      Como caso especial, &#8220;install&#8221; sin argumentos procesaría
      cualquier acción guardada o pendiente de ejecución.


       [Nota]  Nota

               Una vez que introduce Y en la petición final de confirmación,
               la orden &#8220;install&#8221; modificará la información
               guardada en aptitude relativa a qué acciones ejecutar. Por ello,
               si ejecuta la orden, por ejemplo, &#8220;aptitude install foo
               bar&#8221; y después interrumpe la instalación durante la
               descarga e instalación de paquetes, necesitará ejecutar
               &#8220;aptitude remove foo bar&#8221; para cancelar esa orden.



  remove, purge, hold, unhold, keep, reinstall
      Estas órdenes realizan lo mismo que &#8220;install&#8221;, pero en este
      caso la acción nombrada afectaría a todos aquellos paquetes en la línea
      de órdenes que no la invaliden. La diferencia entre hold (retener) y keep
      (mantener), es que el primero causaría que un paquete se ignorase en
      futuras órdenes safe-upgrade o full-upgrade, mientras que keep sólo
      cancela toda acción programada para ese paquete. unhold (anular
      retención) permitiría actualizar un paquete en un futuro con las
      órdenes safe-upgrade o full-upgrade, que de otra forma no alterarían su
      estado.

      Por ejemplo, &#8220;aptitude remove '~ndeity'&#8221; eliminaría todos los
      paquetes cuyo nombre contiene &#8220;deity&#8221;.


  markauto, unmarkauto
      Marcar paquetes como automática o manualmente instalado, respectivamente.
      Los paquetes se especifican al igual que con la orden
      &#8220;install&#8221;. Por ejemplo, &#8220;aptitude markauto
      '~slibs'&#8221; marcaría todos los paquetes de la sección
      &#8220;libs&#8221; como automáticamente instalados.

      Para más información acerca de paquetes automáticamente instalados,
      véase la sección &#8220;Gestionar paquetes automáticamente
      instalados&#8221; del manual de referencia de aptitude.


  build-depends, build-dep
      Satisfacer las dependencias de construcción («build-dependencies») de
      un paquete. Cada nombre de paquete puede ser un paquete fuente, en cuyo
      caso se instalarán las dependencias de compilación de ese paquete
      fuente; por otro lado, los paquetes binarios se encuentran de la misma
      manera que con la orden &#8220;install&#8221;, y así satisfacer las
      dependencias de compilación de los paquetes fuente que compilan esos
      paquetes binarios.

      De estar presente el parámetro de línea de órdenes --arch-only, sólo
      obedecería aquellas dependencias de compilación independientes de
      arquitectura (p. ej., no Build-Depends-Indep o Build-Conflicts-Indep).


  forbid-version
      Forbid a package from being upgraded to a particular version. This will
      prevent aptitude from automatically upgrading to this version, but will
      allow automatic upgrades to future versions. By default, aptitude will
      select the version to which the package would normally be upgraded; you
      may override this selection by appending &#8220;=version&#8221; to the
      package name: for instance, &#8220;aptitude forbid-version
      vim=1.2.3.broken-4&#8221;.

      This command is useful for avoiding broken versions of packages without
      having to set and clear manual holds. If you decide you really want the
      forbidden version after all, &#8220;aptitude install package&#8221; will
      remove the ban.


  update
      Actualizar la lista de paquetes disponibles desde las fuentes de apt
      (equivale a &#8220;apt-get update&#8221;)


  safe-upgrade
      Upgrades installed packages to their most recent version. Installed
      packages will not be removed unless they are unused (see the section
      &#8220;Managing Automatically Installed Packages&#8221; in the aptitude
      reference manual). Packages which are not currently installed may be
      installed to resolve dependencies unless the --no-new-installs command-
      line option is supplied.

      Si no introduce ningún paquete en la línea de órdenes, aptitude
      intentará actualizar todos los paquetes susceptibles de ello. De no ser
      así, aptitude intentará actualizar sólo aquellos paquetes que se deben
      actualizar. Puede extender paquete con sufijos de la misma manera que da
      argumentos a aptitude install, lo que le permite dar a aptitude
      instrucciones adicionales. Por ejemplo, aptitude safe-upgrade bash dash-
      intentaría actualizar el paquete bash y eliminar el paquete dash.

      A veces es necesario eliminar un paquete para poder actualizar otro; en
      tales situaciones esta orden no es capaz de actualizar paquetes. Utilice
      la orden full-upgrade para actualizar tantos paquetes como sea posible.


  full-upgrade
      Actualizar paquetes instalados a su versión más reciente, instalando o
      eliminando paquetes si es necesario. Esta orden es menos conservadora que
      safe-upgrade, y por ello más proclive a ejecutar acciones no deseadas.
      Sin embargo, es capaz de actualizar paquetes que safe-upgrade es incapaz
      de actualizar.

      If no packages are listed on the command line, aptitude will attempt to
      upgrade every package that can be upgraded. Otherwise, aptitude will
      attempt to upgrade only the packages which it is instructed to upgrade.
      The packages can be extended with suffixes in the same manner as arguments
      to aptitude install, so you can also give additional instructions to
      aptitude here; for instance, aptitude full-upgrade bash dash- will attempt
      to upgrade the bash package and remove the dash package.


       [Nota]  Nota

               Por razones históricas, la orden se llamaba originalmente dist-
               upgrade, y aptitude aún reconoce dist-upgrade como sinónimo de
               full-upgrade.



  keep-all
      Cancelar todas las acciones programadas para cualquier paquete; se
      volverá al estado original cualquier paquete cuyo estado virtual indique
      instalar, actualizar o eliminar el paquete.


  forget-new
      Olvidar toda información interna relativa a qué paquetes son
      &#8220;nuevos&#8221; (equivale a pulsar &#8220;f&#8221; en el modo
      gráfico).


  search
      Buscar paquetes que coincidan con uno de los patrones introducidos en la
      línea de órdenes. Se mostrarían todos los paquetes que coincidan con
      cualquier patrón introducido; por ejemplo &#8220;aptitude search '~N'
      edit&#8221; listaría todos los paquetes &#8220;nuevos&#8221; y todos
      aquellos paquetes cuyo nombre contenga &#8220;edit&#8221;. Para más
      información acerca de patrones de búsqueda, véase la siguiente sección
      en la guía de referencia de aptitude &#8220;Patrones de búsqueda&#8221;.


       [Nota]  Nota

               In the example above, &#8220;aptitude search '~N' edit&#8221; has
               two arguments after search and thus is searching for two
               patterns: &#8220;~N&#8221; and &#8220;edit&#8221;. As described
               in the search pattern reference, a single pattern composed of two
               sub-patterns separated by a space (such as &#8220;~N edit&#8221;)
               matches only if both patterns match. Thus, the command
               &#8220;aptitude search '~N edit'&#8221; will only show
               &#8220;new&#8221; packages whose name contains
               &#8220;edit&#8221;.


      A menos que introduzca la opción -F, la salida de aptitude search tendrá
      este aspecto:

      i   apt                             - Advanced front-end for dpkg
      pi  apt-build                       - frontend to apt to build, optimize
      and in
      cp  apt-file                        - APT package searching utility -
      - command-
      ihA raptor-utils                    - Raptor RDF Parser utilities

      Cada resultado de la búsqueda aparece en una línea distinta. El primer
      carácter de cada línea indica el estado actual del paquete: los estados
      más comunes son p, no se encontró ninguna señal de que tal paquete
      exista en el sistema, c, el paquete se eliminó pero sus archivos de
      configuración permanecen en el sistema, i, el paquete está instalado, y
      v, que significa que el paquete es virtual. El segundo carácter indica la
      acción programada (de existir, si no, verá un espacio en blanco) para el
      paquete. Las acciones principales son i, el paquete se va a instalar, d,
      el paquete se va a eliminar, y p, que significa que el paquete y sus
      archivos de configuración se van a eliminar completamente (purgar). Si el
      carácter es A, es que el paquete se instaló automáticamente.

      Para una lista completa de las marcas de estado y de acción posibles,
      véase la sección &#8220;Acceder a la información de los paquetes&#8221;
      en la guía de referencia de aptitude. Para personalizar la salida de
      search, véase las opciones de línea de órdenes -F y --sort.


  show
      Mostrar información detallada relativa a uno o más paquetes, listados de
      acuerdo a la orden «search». Si el nombre de un paquete contiene un
      carácter de tilde (&#8220;~&#8221;) o un signo de interrogación
      (&#8220;?&#8221;), se tomará como un patrón de búsqueda y verá todos
      aquellos paquetes coincidentes (véase la sección &#8220;Patrones de
      búsqueda&#8221; en el manual de referencia de aptitude).

      Si el nivel de verbosidad es 1 o mayor (p. ej., al menos hay un -v en la
      línea de órdenes), aparecerá información acerca de todas las versiones
      de los paquetes. De no ser así, se muestra la información acerca de la
      &#8220;versión candidata&#8221; (la versión que &#8220;aptitude
      install&#8221; descargaría).

      Puede ver información relativa a una versión diferente del paquete
      añadiendo =versión al nombre del paquete; puede ver la versión de un
      archivo o distribución en particular añadiendo /archivo o /
      distribuciónal nombre del paquete. De introducirse uno, solo se mostrará
      la versión que Ud. requirió, independientemente del nivel de verbosidad.

      Si el nivel de verbosidad es 1 o mayor, se mostrará la arquitectura del
      paquete, tamaño comprimido, nombre de archivo y la suma de control md5.
      Si el nivel de verbosidad es 2 o mayor, la versión o versiones
      seleccionadas se mostrarán una vez por cada archivo en el que se
      encontraron.


  versions
      Displays the versions of the packages listed on the command-line.

      $ aptitude versions wesnoth
      p   1:1.4.5-
      1                                                             100
      p   1:1.6.5-1                                    unstable
      500
      p   1:1.7.14-1                                   experimental
      1

      Each version is listed on a separate line. The leftmost three characters
      indicate the current state, planned state (if any), and whether the
      package was automatically installed; for more information on their
      meanings, see the documentation of aptitude search. To the right of the
      version number you can find the releases from which the version is
      available, and the pin priority of the version.

      If a package name contains a tilde character (&#8220;~&#8221;) or a
      question mark (&#8220;?&#8221;), it will be treated as a search pattern
      and all matching versions will be displayed (see the section &#8220;Search
      Patterns&#8221; in the aptitude reference manual). This means that, for
      instance, aptitude versions '~i' will display all the versions that are
      currently installed on the system and nothing else, not even other
      versions of the same packages.

      $ aptitude versions '~nexim4-daemon-light'
      Package exim4-daemon-light:
      i   4.71-
      3                                                                100
      p   4.71-4                                       unstable
      500

      Package exim4-daemon-light-dbg:
      p   4.71-4                                       unstable
      500

      If the input is a search pattern, or if more than one package's versions
      are to be displayed, aptitude will automatically group the output by
      package, as shown above. You can disable this via --group-by=none, in
      which case aptitude will display a single list of all the versions that
      were found and automatically include the package name in each output line:

      $ aptitude versions --group-by=none '~nexim4-daemon-light'
      i   exim4-daemon-light 4.71-
      3                                             100
      p   exim4-daemon-light 4.71-4                    unstable
      500
      p   exim4-daemon-light-dbg 4.71-4                unstable
      500

      To disable the package name, pass --show-package-names=never:

      $ aptitude versions --show-package-names=never --group-by=none '~nexim4-
      daemon-light'
      i   4.71-
      3                                                                100
      p   4.71-4                                       unstable
      500
      p   4.71-4                                       unstable
      500

      In addition to the above options, the information printed for each version
      can be controlled by the command-line option -F. The order in which
      versions are displayed can be controlled by the command-line option --
      sort. To prevent aptitude from formatting the output into columns, use --
      disable-columns.


  add-user-tag, remove-user-tag
      Añadir una etiqueta de usuario o quitar una etiqueta de usuario del grupo
      de paquetes seleccionado. Si el nombre de un paquete contiene una tilde
      (&#8220;~&#8221;) o un signo de interrogación (&#8220;?&#8221;), se
      tomará como un patrón de búsqueda y la etiqueta se añadirá o quitará
      a todos los paquetes que coinciden con el patrón (véase la sección
      &#8220;Patrones de búsqueda&#8221; en el manual de referencia de
      aptitude).

      Las etiquetas de usuario son cadenas arbitrarias asociadas a un paquete.
      Pueden utilizarse en conjunción con el término de búsqueda ?user-tag
      (etiqueta), el cual selecciona todos los paquetes con una etiqueta de
      usuario que coincide con etiqueta.


  why, why-not
      Explicar la razón de que un paquete en particular no se debería, o deba,
      instalar en el sistema.

      Esta orden busca paquetes que requieren o entran en conflicto con el
      paquete dado. Muestra una secuencia de dependencias que llevan al paquete
      objetivo, acompañado de una nota que indica el estado de instalación de
      cada paquete en la cadena de dependencias.

      $ aptitude why kdepim
      i   nautilus-data Recomienda nautilus
      i A nautilus      Recomienda desktop-base (>= 0.2)
      i A desktop-base  Sugiere   gnome | kde | xfce4 | wmaker
      p   kde           Depende de   kdepim (>= 4:3.4.3)

      The command why finds a dependency chain that installs the package named
      on the command line, as above. Note that the dependency that aptitude
      produced in this case is only a suggestion. This is because no package
      currently installed on this computer depends on or recommends the kdepim
      package; if a stronger dependency were available, aptitude would have
      displayed it.

      Al contrario, why-not encuentra una cadena de dependencias que lleva a un
      conflicto con el paquete objetivo.

      $ aptitude why-not textopo
      i   ocaml-core          Depende de   ocamlweb
      i A ocamlweb            Depende de   tetex-extra | texlive-latex-extra
      i A texlive-latex-extra tiene conflictos con textopo

      If one or more patterns are present, then aptitude will begin its search
      at these patterns; that is, the first package in the chain it prints will
      be a package matching the pattern in question. The patterns are considered
      to be package names unless they contain a tilde character
      (&#8220;~&#8221;) or a question mark (&#8220;?&#8221;), in which case they
      are treated as search patterns (see the section &#8220;Search
      Patterns&#8221; in the aptitude reference manual).

      Si no introduce ningún patrón, aptitude busca cadenas de dependencias
      qué se inician en paquetes manualmente instalados. Esto muestra con
      efectividad los paquetes que han causado o causarían que se instalase un
      paquete en particular.


       [Nota]  Nota

               aptitude why no ejecuta una resolución completa de dependencias,
               solo muestra relaciones directas entre paquetes. Por ejemplo, si
               A depende de B, C depende de D, y B y C entran en conflicto,
               &#8220;aptitude why-not D&#8221; no devolvería la respuesta
               &#8220;A depende de B, B entra en conflicto con C, y D depende de
               C&#8221;.


      By default aptitude outputs only the &#8220;most installed, strongest,
      tightest, shortest&#8221; dependency chain. That is, it looks for a chain
      that only contains packages which are installed or will be installed; it
      looks for the strongest possible dependencies under that restriction; it
      looks for chains that avoid ORed dependencies and Provides; and it looks
      for the shortest dependency chain meeting those criteria. These rules are
      progressively weakened until a match is found.

      If the verbosity level is 1 or more, then all the explanations aptitude
      can find will be displayed, in inverse order of relevance. If the
      verbosity level is 2 or more, a truly excessive amount of debugging
      information will be printed to standard output.

      This command returns 0 if successful, 1 if no explanation could be
      constructed, and -1 if an error occurred.


  clean
      Eliminar todos los paquetes .deb del directorio almacén de paquetes
      (generalmente /var/cache/apt/archives).


  autoclean
      Eliminar todos los paquetes del almacén que ya no se pueden descargar.
      Esto le permite evitar que un almacén crezca sin control a lo largo del
      tiempo, sin tener que vaciarlo en su totalidad.


  changelog
      Descargar y mostrar el registro de cambios de Debian para cada paquete
      binario o fuente dado.

      De manera predeterminada, se descarga el registro de cambios de la
      versión que se va a instalar con &#8220;aptitude install&#8221;. Puede
      seleccionar una versión en particular de un paquete añadiendo =versión
      al nombre del paquete; puede seleccionar una versión de un archivo o
      distribución en particular añadiendo /archivo o /distribuciónal nombre
      del paquete (por ejemplo, /unstable o /sid).


  download
      Descargar el archivo .deb del paquete dado al directorio actual. Si el
      nombre de un paquete contiene un signo de tilde (&#8220;~&#8221;) o un
      signo de interrogación (&#8220;?&#8221;), se tomará como un patrón de
      búsqueda y se descargarán todos los paquetes correspondientes (véase la
      sección &#8220;Patrones de búsqueda&#8221; del manual de referencia de
      aptitude).

      De manera predeterminada, se descarga la versión que se instalaría con
      &#8220;aptitude install&#8221;. Puede seleccionar una versión en
      particular de un paquete añadiendo =versión al nombre del paquete; puede
      seleccionar una versión de un archivo o distribución en particular
      añadiendo /archivo o /release al nombre del paquete (por ejemplo, /
      unstable o /sid).


  extract-cache-subset
      Copy the apt configuration directory (/etc/apt) and a subset of the
      package database to the specified directory. If no packages are listed,
      the entire package database is copied; otherwise only the entries
      corresponding to the named packages are copied. Each package name may be a
      search pattern, and all the packages matching that pattern will be
      selected (see the section &#8220;Search Patterns&#8221; in the aptitude
      reference manual). Any existing package database files in the output
      directory will be overwritten.

      Las dependencias en estancias de paquete binarias se reescribirán para
      eliminar referencias a paquetes que no se encuentren en el conjunto
      seleccionado.


  help
      Mostrar un breve resumen de las órdenes disponibles y sus opciones.



Opciones

Puede utilizar las siguientes opciones para modificar el comportamiento de las
acciones descritas anteriormente. Observe que mientras que todas las órdenes
aceptan todas las opciones, algunas opciones no afectan a ciertas órdenes y
estas órdenes las ignorarán.



  --add-user-tag etiqueta
      Para full-upgrade, safe-upgrade, forbid-version, hold, install, keep-all,
      markauto, unmarkauto, purge, reinstall, remove, unhold, y unmarkauto:
      añadir la etiqueta de usuario etiqueta a todos los paquetes instalados,
      eliminados o actualizados mediante esta orden, al igual que con la orden
      add-user-tag.


  --add-user-tag-to etiqueta,patrón
      Para full-upgrade, safe-upgrade forbid-version, hold, install, keep-all,
      markauto, unmarkauto, purge, reinstall, remove, unhold, and unmarkauto:
      añadir la etiqueta de usuario etiqueta a todos los paquetes que coinciden
      con patrón al igual que con la orden add-user-tag. El patrón es un
      patrón de búsqueda tal y como se describe en la sección &#8220;Patrones
      de búsqueda&#8221; en el manual de referencia de aptitude.

      Por ejemplo, aptitude safe-upgrade --add-user-tag-to "new-installs,?action
      (install)" añadiría la etiqueta new-installs a todos los paquetes
      instalados mediante la orden safe-upgrade.


  --allow-new-upgrades
      When the safe resolver is being used (i.e., --safe-resolver was passed,
      the action is safe-upgrade, or Aptitude::Always-Use-Safe-Resolver is set
      to true), allow the dependency resolver to install upgrades for packages
      regardless of the value of Aptitude::Safe-Resolver::No-New-Upgrades.


  --allow-new-installs
      Allow the safe-upgrade command to install new packages; when the safe
      resolver is being used (i.e., --safe-resolver was passed, the action is
      safe-upgrade, or Aptitude::Always-Use-Safe-Resolver is set to true), allow
      the dependency resolver to install new packages. This option takes effect
      regardless of the value of Aptitude::Safe-Resolver::No-New-Installs.


  --allow-untrusted
      Instalar paquetes de fuentes sin firmar sin pedir confirmación. Debería
      utilizar esto sólo si sabe lo que está haciendo, ya que podría
      comprometer fácilmente la seguridad de su sistema.


  --disable-columns
      This option causes aptitude search and aptitude version to output their
      results without any special formatting. In particular: normally aptitude
      will add whitespace or truncate search results in an attempt to fit its
      results into vertical &#8220;columns&#8221;. With this flag, each line
      will be formed by replacing any format escapes in the format string with
      the corresponding text; column widths will be ignored.

      Por ejemplo, las primeras líneas de la salida de &#8220;aptitude search -
      F '%p %V' --disable-columns libedataserver&#8221; pueden ser:

      disksearch 1.2.1-3
      hp-search-mac 0.1.3
      libbsearch-ruby 1.5-5
      libbsearch-ruby1.8 1.5-5
      libclass-dbi-abstractsearch-perl 0.07-2
      libdbix-fulltextsearch-perl 0.73-10

      Como se aprecia en el ejemplo anterior, --disable-columns es a menudo
      útil en combinación con un formato de diseño personalizado usando la
      opción en línea de órdenes -F.

      Esto se corresponde con la opción de configuración Aptitude::CmdLine::
      Disable-Columns.


  -D, --show-deps
      Mostrar explicaciones breves de las instalaciones y eliminaciones
      automáticas de las órdenes que instalarán o eliminarán paquetes
      (install, full-upgrade, etc)

      Esto se corresponde con la opción de configuración Aptitude::CmdLine::
      Show-Deps.


  -d, --download-only
      Descargar cuántos paquetes se necesitan al almacén de paquetes, pero no
      instalar o eliminar nada. De manera predeterminada, el almacén de
      paquetes se guarda en /var/cache/apt/archives.

      Esto se corresponde con la opción de configuración Aptitude::CmdLine::
      Download-Only.


   -F formato, --display-format formato
      Specify the format which should be used to display output from the search
      and version commands. For instance, passing &#8220;%p %V %v&#8221; for
      format will display a package's name, followed by its currently installed
      version and its available version (see the section &#8220;Customizing how
      packages are displayed&#8221; in the aptitude reference manual for more
      information).

      La opción en línea de órdenes --disable-columns es a veces útil
      combinado con -F.

      For search, this corresponds to the configuration option Aptitude::
      CmdLine::Package-Display-Format; for versions, this corresponds to the
      configuration option Aptitude::CmdLine::Version-Display-Format.


  -f
      Intentar arreglar agresivamente las dependencias de paquetes rotos,
      incluso si ello significa ignorar las acciones introducidas en la línea
      de órdenes.

      Esto se corresponde con el elemento de configuración Aptitude::CmdLine::
      Fix-Broken.


  --full-resolver
      Cuando se encuentren problemas de dependencias de paquetes, utilizar el
      solucionador predeterminado &#8220;full&#8221; (completo). A diferencia
      del solucionador &#8220;seguro&#8221; (el cual se ejecuta mediante --safe-
      resolver), el solucionador completo eliminará con alegría cualquier
      paquete para así cumplir con las dependencias. Puede solucionar más
      situaciones que el algoritmo seguro, pero puede que sus soluciones sean
      indeseables.

      Esta opción se puede utilizar para forzar el uso del solucionador
      completo aunque Aptitude::Always-Use-Safe-Resolver tenga valor de
      «true». La orden safe-upgrade nunca utiliza el solucionador completo, y
      no acepta la opción --full-resolver.


   --group-by grouping-mode
      Control how the versions command groups its output. The following values
      are recognized:


      * archive to group packages by the archive they occur in
        (&#8220;stable&#8221;, &#8220;unstable&#8221;, etc). If a package occurs
        in several archives, it will be displayed in each of them.

      * auto to group versions by their package unless there is exactly one
        argument and it is not a search pattern.

      * none to display all the versions in a single list without any grouping.

      * package to group versions by their package.

      * source-package to group versions by their source package.

      * source-version to group versions by their source package and source
        version.


      This corresponds to the configuration option Aptitude::CmdLine::Versions-
      Group-By.


  -h, --help
      Muestra un breve mensaje de ayuda. Idéntica a la acción help.


   --log-file=archivo
      Si el archivo es una cadena que no esta vacía, en él se escribirán los
      mensajes del registro. Pero si archivo es &#8220;-&#8221; los mensajes
      saldrán por la salida convencional. Si introduce esta opción varias
      veces, la última aparición es la que tiene efecto.

      This does not affect the log of installations that aptitude has performed
      (/var/log/aptitude); the log messages written using this configuration
      include internal program events, errors, and debugging messages. See the
      command-line option --log-level to get more control over what gets logged.

      Esto se corresponde con la opción de configuración Aptitude::Logging::
      File.


   --log-level=nivel, --log-level=categoría:nivel
      --log-level=nivel provoca que aptitude registre mensajes cuyo nivel es
      nivel, o superior. Por ejemplo, si define el nivel de registro como error,
      solo los mensajes al nivel de error y fatal se mostrarían; todos los
      otros se ocultarían. Los niveles de registro (en orden descendente) son
      off, fatal, error, warn, info, debug, y trace. El nivel de registro
      predeterminado es warn.

      --log-level=categoría:nivel hace que los mensajes pertenecientes a
      categoría se registren solo si su nivel es nivel o superior.

      --log-level puede aparecer varias veces en la línea de órdenes; la
      configuración más específica es la que tiene efecto. Si introduce --
      log-level=aptitude.resolver:fatal y --log-
      level=aptitude.resolver.hints.match:trace, los mensajes en
      aptitude.resolver.hints.parse se imprimirán sólo si su nivel es fatal,
      pero aquellos mensajes en aptitude.resolver.hints.match se mostrarán. Si
      configura el nivel de la misma categoría dos o más veces, la última
      configuración es la que tiene efecto.

      This does not affect the log of installations that aptitude has performed
      (/var/log/aptitude); the log messages written using this configuration
      include internal program events, errors, and debugging messages. See the
      command-line option --log-file to change where log messages go.

      Esto se corresponde con el grupo de configuración Aptitude::Logging::
      Levels.


   --log-resolver
      Definir algunos niveles estándar del registro relativos al solucionador,
      para producir una salida del registro apropiada para su procesamiento con
      herramientas automáticas. Esto equivale a las opciones en línea de
      órdenes --log-level=aptitude.resolver.search:trace --log-
      level=aptitude.resolver.search.tiers:warn.


   --no-new-installs
      Evitar que safe-upgrade instale cualquier paquete nuevo; cuando se utiliza
      el solucionador seguro (p. ej., introdujo --safe-resolver, o Aptitude::
      Always-Use-Safe-Resolver tiene valor de «true»), impide que el
      solucionador de dependencias instale paquetes nuevos. Esta opción tiene
      efecto independientemente del valor de Aptitude::Safe-Resolver::No-New-
      Installs.

      Esto imita el comportamiento histórico de apt-get upgrade.


  --no-new-upgrades
      When the safe resolver is being used (i.e., --safe-resolver was passed or
      Aptitude::Always-Use-Safe-Resolver is set to true), forbid the dependency
      resolver from installing upgrades for packages regardless of the value of
      Aptitude::Safe-Resolver::No-New-Upgrades.


  --no-show-resolver-actions
      No mostrar las acciones ejecutadas por el solucionador
      &#8220;seguro&#8221;, invalidando toda opción de configuración o una
      orden anterior --show-resolver-actions.


  -O orden, --sort orden
      Specify the order in which output from the search and versions commands
      should be displayed. For instance, passing &#8220;installsize&#8221; for
      order will list packages in order according to their size when installed
      (see the section &#8220;Customizing how packages are sorted&#8221; in the
      aptitude reference manual for more information).

      The default sort order is name,version.


  -o llave=valor
      Definir directamente una opción del archivo de configuración; por
      ejemplo, use -o Aptitude::Log=/tmp/my-log para registrar las acciones de
      aptitude a /tmp/my-log. Para más información acerca de las opciones del
      archivo de configuración, véase la sección &#8220;Referencia del
      archivo de configuración&#8221; en el manual de referencia de aptitude.


  -P, --prompt
      Siempre pedir una confirmación antes de descargar, instalar o eliminar
      paquetes, aunque no haya otras acciones programadas más que las que Ud.
      requirió.

      Esto se corresponde con la opción de configuración Aptitude::CmdLine::
      Always-Prompt.


  --purge-unused
      Si define Aptitude::Delete-Unused como &#8220;true&#8221; (su valor
      predeterminado), además de eliminar cada paquete que ya no necesite
      ningún otro paquete instalado, aptitude los purgará, borrando sus
      archivos de configuración y puede que otros datos importantes. Para más
      información relativa a qué paquetes se consideran &#8220;en
      desuso&#8221;, véase la sección &#8220;Gestionar paquetes
      automáticamente instalados&#8221;. ¡ESTA OPCIÓN PUEDE OCASIONAR
      PÉRDIDA DE DATOS! ¡NO LA USE A MENOS QUE SEPA LO QUE ESTÁ HACIENDO!

      Esto se corresponde con la opción de configuración Aptitude::Purge-
      Unused.


  -q[=n], --quiet[=n]
      Eliminar todos los indicadores de progreso incrementales, permitiéndole
      registrar la salida. Puede introducirlo varias veces para disminuir los
      mensajes del programa, pero al contrario que apt-get, aptitude no activa -
      y cuando introduce q.

      Se puede utilizar la orden opcional =número para configurar directamente
      la cuantía de silencio (por ejemplo, para invalidar una configuración en
      /etc/apt/apt.conf); causa que el programa responda como si se hubiese
      introducido -q número veces.


  -R, --without-recommends
      No toma recomendaciones como dependencias a la hora de instalar paquetes
      (esto invalida las configuraciones en /etc/apt/apt.conf y ~/.aptitude/
      config)

      Esto se corresponde con las dos opciones de configuración Apt::Install-
      Recommends y Apt::AutoRemove::InstallRecommends.


  -r, --with-recommends
      Tratar las recomendaciones como dependencias a la hora de instalar
      paquetes nuevos (esto invalida las configuraciones en /etc/apt/apt.conf y
      ~/.aptitude/config).

      Esto se corresponde con la opción de configuración Apt::Install-
      Recommends


  --remove-user-tag etiqueta
      Para full-upgrade, safe-upgrade forbid-version, hold, install, keep-all,
      markauto, unmarkauto, purge, reinstall, remove, unhold, y unmarkauto:
      eliminar la etiqueta de usuario etiqueta de todos los paquetes que se van
      a instalar, eliminar o actualizar con esta orden, al igual que con la
      orden add-user-tag.


  --remove-user-tag-from etiqueta,patrón
      Para full-upgrade, safe-upgrade forbid-version, hold, install, keep-all,
      markauto, unmarkauto, purge, reinstall, remove, unhold, y unmarkauto:
      eliminar la etiqueta de usuario etiqueta de todos los paquetes que
      coinciden con patrón al igual que con la orden remove-user-tag. El
      patrón es un patrón de búsqueda tal y como se describe en la sección
      &#8220;Patrones de búsqueda&#8221; en el manual de referencia de
      aptitude.

      Por ejemplo, aptitude safe-upgrade --remove-user-tag-from "not-
      upgraded,?action(upgrade)" borraría toda etiqueta not-upgraded de
      cualquier paquete que la orden safe-upgrade pueda actualizar.


  -s, --simulate
      En modo de línea de órdenes, imprime las acciones que se tomarían, pero
      no las ejecuta, sino que las simula. Esto no precisa de privilegios de
      administrador (root). En la interfaz gráfica, abre el almacén con
      privilegios de sólo lectura independientemente de si es, o no, el
      administrador.

      Esto se corresponde con la opción de configuración Aptitude::Simulate.


  --safe-resolver
      Cuando se encuentre un problema de dependencias, usar un algoritmo
      &#8220;safe&#8221; (seguro) para resolverlos. Este solucionador intenta
      preservar tantas elecciones suyas como sea posible; nunca eliminará un
      paquete o instalará una versión que no sea la versión candidata del
      paquete. Es el mismo algoritmo usado con safe-upgrade; efectivamente,
      aptitude --safe-resolver full-upgrade equivale aaptitude safe-upgrade.
      Debido a que safe-upgrade siempre usa el solucionador seguro, no acepta la
      marca --safe-resolver.

      Esta opción equivale a definir la variable de configuración Aptitude::
      Always-Use-Safe-Resolver como true.


  --schedule-only
      Programa las operaciones de las órdenes que modifican el estado de los
      paquetes, sin ejecutarlos realmente. Puede ejecutar acciones programadas
      ejecutando aptitude install sin introducir argumentos. Esto equivale a
      realizar las selecciones correspondientes en la interfaz gráfica, y
      cerrar el programa tras ello.

      Por ejemplo. aptitude --schedule-only install evolution programa una
      instalación ulterior para el paquete evolution.


  --show-package-names when
      Controls when the versions command shows package names. The following
      settings are allowed:


      * always: display package names every time that aptitude versions runs.

      * auto: display package names when aptitude versions runs if the output is
        not grouped by package, and either there is a pattern-matching argument
        or there is more than one argument.

      * never: never display package names in the output of aptitude versions.


      This option corresponds to the configuration item Aptitude::CmdLine::
      Versions-Show-Package-Names.


  --show-resolver-actions
      Display the actions performed by the &#8220;safe&#8221; resolver and by
      safe-upgrade.

      When executing the command safe-upgrade or when the option --safe-resolver
      is present, aptitude will display a summary of the actions performed by
      the resolver before printing the installation preview. This is equivalent
      to the configuration option Aptitude::Safe-Resolver::Show-Resolver-
      Actions.


  --show-summary[=MODO]
      Modificar el comportamiento de &#8220;aptitude why&#8221; para que la
      salida sea un resumen de la cadena de dependencias, mas que mostrar la
      forma completa. Si esta opción está presente y el MODO no es &#8220;no-
      summary&#8221;, las cadenas que contengan dependencias del tipo
      «Sugiere» no se mostrarán: combine --show-summary con -v para ver un
      resumen de todas las razones por las que el paquete objetivo se va a
      instalar.

      El MODO puede ser cualquiera de los siguientes:


        1. no-summary: no mostrar el resumen (el comportamiento predeterminado
           si no se ha introducido --show-summary).

        2. first-package: mostrar el primer paquete de cada cadena. Este es el
           valor predeterminado de MODO si no está presente.

        3. first-package-and-type: mostrar el primer paquete de cada cadena,
           acompañado de la fuerza de la dependencia más débil de la cadena.

        4. all-packages: mostrar un resumen de cada cadena de dependencias que
           lleva al paquete objetivo.

        5. all-packages-with-dep-versions: mostrar un resumen de cada cadena de
           dependencias que conduce al paquete objetivo, incluyendo la versión
           objetivo de cada dependencia.


      Esta opción se corresponde con el elemento de configuración Aptitude::
      CmdLine::Show-Summary; de estar presente --show-summary en la línea de
      órdenes, invalidaría Aptitude::CmdLine::Show-Summary.

      Ejemplo 10. Uso de --show-summary.

      --show-summary en conjunción con -v muestra las razones de porqué un
      paquete está instalado:

      $ aptitude -v --show-summary why foomatic-db
      Paquetes que dependen de foomatic-db:
        cupsys-driver-gutenprint
        foomatic-db-engine
        foomatic-db-gutenprint
        foomatic-db-hpijs
        foomatic-filters-ppds
        foomatic-gui
        kde
        printconf
        wine

      $ aptitude -v --show-summary=first-package-and-type why foomatic-db
      Paquetes que dependen de foomatic-db:
        [Depende] cupsys-driver-gutenprint
        [Depende] foomatic-db-engine
        [Depende] foomatic-db-gutenprint
        [Depende] foomatic-db-hpijs
        [Depende] foomatic-filters-ppds
        [Depende] foomatic-gui
        [Depende] kde
        [Depende] printconf
        [Depende] wine

      $ aptitude -v --show-summary=all-packages why foomatic-db
      Paquetes que dependen de foomatic-db:
        cupsys-driver-gutenprint D: cups-driver-gutenprint D: cups R: foomatic-
      filters R: foomatic-db-engine D: foomatic-db
        foomatic-filters-ppds D: foomatic-filters R: foomatic-db-engine D:
      foomatic-db
        kde D: kdeadmin R: system-config-printer-kde D: system-config-printer R:
      hal-cups-utils D: cups R: foomatic-filters R: foomatic-db-engine D:
      foomatic-db
        wine D: libwine-print D: cups-bsd R: cups R: foomatic-filters R:
      foomatic-db-engine D: foomatic-db
        foomatic-db-engine D: foomatic-db
        foomatic-db-gutenprint D: foomatic-db
        foomatic-db-hpijs D: foomatic-db
        foomatic-gui D: python-foomatic D: foomatic-db-engine D: foomatic-db
        printconf D: foomatic-db

      $ aptitude -v --show-summary=all-packages-with-dep-versions why foomatic-
      db
      Paquetes que dependen de foomatic-db:
        cupsys-driver-gutenprint D: cups-driver-gutenprint (>= 5.0.2-4) D: cups
      (>= 1.3.0) R: foomatic-filters (>= 4.0) R: foomatic-db-engine (>= 4.0) D:
      foomatic-db (>= 20090301)
        foomatic-filters-ppds D: foomatic-filters R: foomatic-db-engine (>= 4.0)
      D: foomatic-db (>= 20090301)
        kde D: kdeadmin (>= 4:3.5.5) R: system-config-printer-kde (>= 4:4.2.2-1)
      D: system-config-printer (>= 1.0.0) R: hal-cups-utils D: cups R: foomatic-
      filters (>= 4.0) R: foomatic-db-engine (>= 4.0) D: foomatic-db (>=
      20090301)
        wine D: libwine-print (= 1.1.15-1) D: cups-bsd R: cups R: foomatic-
      filters (>= 4.0) R: foomatic-db-engine (>= 4.0) D: foomatic-db (>=
      20090301)
        foomatic-db-engine D: foomatic-db
        foomatic-db-gutenprint D: foomatic-db
        foomatic-db-hpijs D: foomatic-db
        foomatic-gui D: python-foomatic (>= 0.7.9.2) D: foomatic-db-engine D:
      foomatic-db (>= 20090301)
        printconf D: foomatic-db
      	

      --show-summary se emplea para mostrar la cadena en una línea:

      $ aptitude --show-summary=all-packages why aptitude-gtk libglib2.0-data
      Paquetes que dependen de libglib2.0-data:
        aptitude-gtk D: libglib2.0-0 R: libglib2.0-data



  -t distribución, --target-release distribución
      Definir la rama de la que se deberían instalar los paquetes. Por ejemplo,
      &#8220;aptitude -t experimental ...&#8221; instalaría paquetes de la
      distribución «experimental» a menos que especifique lo contrario. Para
      las acciones en línea de órdenes &#8220;changelog&#8221;,
      &#8220;download&#8221;, y &#8220;show&#8221;, esto equivale a añadir /
      rama al final de cada paquete nombrado en la línea de órdenes; para
      otras órdenes, esto afecta a la versión candidata de los paquetes de
      acuerdo a las reglas descritas en apt_preferences(5).

      Esto se corresponde con el elemento de configuración APT::Default-
      Release.


  -V, --show-versions
      Mostrar qué versiones de paquetes se van a instalar.

      Esto se corresponde con la opción de configuración Aptitude::CmdLine::
      Show-Versions.


  -v, --verbose
      Causar que algunas órdenes, (tales como show) muestren información
      adicional. Esto se puede introducir varias veces para así obtener más y
      más información.

      Esto se corresponde con la opción de configuración Aptitude::CmdLine::
      Verbose.


  --version
      Mostrar la versión de aptitude y cierta información acerca de como se
      compiló.


  --visual-preview
      Mostrar la pantalla de previsualización de la interfaz gráfica al
      eliminar o instalar paquetes desde la línea de órdenes, en lugar de la
      pantalla normal.


  -W, --show-why
      En la pantalla de previsualización que se muestra antes de instalar o
      eliminar paquetes, mostrar las dependencias de paquetes manualmente
      instalados sobre cada paquete automáticamente instalado. Por ejemplo:

      $ aptitude --show-why install mediawiki
      ...
      Se van a instalar los siguientes paquetes NUEVOS:
        libapache2-mod-php5{a} (for mediawiki)  mediawiki  php5{a} (for
      mediawiki)
        php5-cli{a} (for mediawiki)  php5-common{a} (for mediawiki)
        php5-mysql{a} (for mediawiki)

      En combinación con -v o un valor que no equivalga a 0 para Aptitude::
      CmdLine::Verbose, mostrar la cadena de dependencias completa que conducen
      a cada paquete que se va a instalar. Por ejemplo:

      $ aptitude -v --show-why install libdb4.2-dev
      Se instalarán los siguiente paquetes NUEVOS:
        libdb4.2{a} (libdb4.2-dev D: libdb4.2)  libdb4.2-dev
      Se ELIMINARÁN los siguientes paquetes:
        libdb4.4-dev{a} (libdb4.2-dev C: libdb-dev P<- libdb-dev)

      Esta opción también describiría porqué los paquetes se van a eliminar,
      como puede observar en el texto anterior. En este ejemplo, libdb4.2-dev
      entra en conflicto con libdb-dev, que provee libdb-dev.

      Este argumento se corresponde con la opción de configuración Aptitude::
      CmdLine::Show-Why, y muestra la misma información computada por aptitude
      why y aptitude why-not.


  -w ancho, --width ancho
      Especificar el ancho de pantalla que se debería emplear en la salida de
      la orden search (el ancho de la terminal se usa de manera predeterminada).

      Esto se corresponde con la opción de configuración Aptitude::CmdLine::
      Package-Display-Width


  -y, --assume-yes
      Cuando se presente una pregunta si/no, se asumirá que el usuario
      introdujo &#8220;si&#8221;. En particular, suprime la previsualización
      final cuando instala, actualizar o elimina paquetes. Aún así, verá
      preguntas acerca de acciones &#8220;peligrosas&#8221; tales como eliminar
      paquetes esenciales. Esta opción invalida -P.

      Esto se corresponde con la opción de configuración Aptitude::CmdLine::
      Assume-Yes.


  -Z
      Mostrar cuanto espacio del disco se va usar o liberar por cada paquete
      individual que se va a instalar, actualizar, o eliminar.

      Esto se corresponde con la opción de configuración Aptitude::CmdLine::
      Show-Size-Changes.


Las siguientes opciones afectan a la interfaz gráfica del programa, pero se han
diseñado para un uso interno; generalmente, no tendrá que utilizarlas.



  --autoclean-on-startup
      Eliminar los archivos descargados y antiguos al inicio (equivale a iniciar
      el programa y seleccionar inmediatamente Acciones ->; Limpiar el
      almacén de paquetes). No puede usar esta opción y &#8220;--autoclean-on-
      startup&#8221;, &#8220;-i&#8221;, o &#8220;-u&#8221; a la vez.


  --clean-on-startup
      Vaciar el almacén de paquetes cuando el programa se inicia (equivale a
      iniciar el programa y seleccionar inmediatamente Acciones ->; Limpiar
      el almacén de paquetes). No puede usar esta opción y &#8220;--autoclean-
      on-startup&#8221;, &#8220;-i&#8221;, o &#8220;-u&#8221; a la vez.


  -i
      Mostrar una previsualización de la descarga cuando se inicia el programa
      (equivale a iniciar el programa y pulsar &#8220;g&#8221; inmediatamente).
      No puede utilizar esta opción y &#8220;--autoclean-on-startup&#8221;,
      &#8220;--clean-on-startup&#8221;, o &#8220;-u&#8221; a la vez.


  -S nombre_de_archivo
      Cargar la información de estado extendida desde nombre_de_archivo en
      lugar del archivo estándar de estado.


  -u
      Actualizar la lista de paquetes en cuanto se inicia el programa. No puede
      usar esta opción y &#8220;--autoclean-on-startup&#8221;, &#8220;--clean-
      on-startup&#8221;, o &#8220;-i&#8221; a la vez.



Entorno



  HOME
      If $HOME/.aptitude exists, aptitude will store its configuration file in
      $HOME/.aptitude/config. Otherwise, it will look up the current user's home
      directory using getpwuid(2) and place its configuration file there.


  PAGER
      Si define esta variable de entorno aptitude la usará para mostrar los
      registros de cambios cuando invoque &#8220;aptitude changelog&#8221;. De
      no ser así, su valor predeterminado es more.


  TMP
      Si no define TMPDIR, aptitude guardará sus archivos temporales en TMP si
      se ha definido esa variable. De no ser así, los guardará en /tmp.


  TMPDIR
      aptitude guardará sus archivos temporales en el directorio indicado en
      esta varible de entorno. Si no define TMPDIR, se usará TMP; si tampoco ha
      definido TMP, aptitude usará /tmp.



Archivos



  /var/lib/aptitude/pkgstates
      El archivo en el que se guardan los estados de los paquetes y algunas
      marcas de acción.




  /etc/apt/apt.conf, /etc/apt/apt.conf.d/*, ~/.aptitude/config
      Los archivos de configuración de aptitude. ~/.aptitude/config invalida /
      etc/apt/apt.conf. Véase apt.conf(5) para la documentación relativa al
      formato y contenido de estos archivos.



Véase también

apt-get(8), apt(8), /usr/share/doc/aptitude/html/es/index.html disponible en el
paquete aptitude-doc-es

--------------------------------------------------------------------------------

Nombre

aptitude-create-state-bundle --; empaquetar el estado actual de aptitude


Sinopsis

aptitude-create-state-bundle [opciones...] archivo_de_salida


Descripción

La orden aptitude-create-state-bundle genera un archivo comprimido que guarda
los archivos necesarios para mimetizar el estado actual del archivo de paquetes.
Se incluyen en el archivo generado los siguientes archivos y directorios:


* $HOME/.aptitude

* /var/lib/aptitude

* /var/lib/apt

* /var/cache/apt/*.bin

* /etc/apt

* /var/lib/dpkg/status


La salida de este programa se puede usar como un argumento de aptitude-run-
state-bundle(1).


Opciones



  --force-bzip2
      Invalidar la detección de qué algoritmo de compresión usar. De manera
      predeterminada, aptitude-create-state-bundle utiliza bzip2(1), de estar
      disponible, o gzip(1) de no ser así. Introducir esta opción fuerza el
      uso de bzip2 aunque no parezca estar disponible.


  --force-gzip
      Invalidar la detección de qué algoritmo de compresión usar. De manera
      predeterminada, aptitude-create-state-bundle utiliza bzip2(1), de estar
      disponible, o gzip(1) de no ser así. Introducir esta opción fuerza el
      uso de gzip aunque bzip2 esté disponible.


  --help
      Mostrar un breve resumen del uso, después cierra.


  --print-inputs
      En lugar de crear un archivo, muestra una lista de los archivos y
      directorios que el programa incluiría de generar un archivo de estado.



El formato del archivo

El archivo de estado es simplemente un archivo tar(1) comprimido con bzip2(1) o
gzip(1). La raíz de cada uno de los árboles de directorios de entrada es
&#8220;.&#8221;.


Véase también

aptitude-run-state-bundle(1), aptitude(8), apt(8)

--------------------------------------------------------------------------------

Nombre

aptitude-run-state-bundle --; desempaquetar un archivo de estado de aptitude
e invocar aptitude sobre éste


Sinopsis

aptitude-run-state-bundle [opciones...] archivo_de_entrada [ programa
[argumentos...]]


Descripción

aptitude-run-state-bundle desempaqueta el archivo de estado de aptitude creado
por aptitude-create-state-bundle(1) en un directorio temporal, invoca programa
sobre él con los argumentos proporcionados, y elimina el directorio temporal a
continuación. Si no se introduce programa, su valor por omisión es aptitude
(8).


Opciones

The following options may occur on the command-line before the input file.
Options following the input file are presumed to be arguments to aptitude.



  --append-args
      Introducir al final de la línea de órdenes las opciones que dan la
      ubicación del archivo de estado al invocar programa, en lugar de al
      principio de éste (comportamiento predeterminado).


  --help
      Mostrar un breve resumen del uso.


  --prepend-args
      Introducir al inicio de la línea de órdenes las opciones que dan la
      ubicación del paquete de estado al invocar programa, invalidando
      cualquier otro --append-args (el valor predeterminado es ubicar las
      opciones al inicio).


  --no-clean
      Do not remove the unpacked state directory after running aptitude. You
      might want to use this if, for instance, you are debugging a problem that
      appears when aptitude's state file is modified. When aptitude finishes
      running, the name of the state directory will be printed so that you can
      access it in the future.

      Esta opción se activa automáticamente por --statedir.


  --really-clean
      Eliminar el directorio de estado tras ejecutar aptitude, incluso si
      introduce --no-clean o --statedir.


  --statedir
      En lugar de tratar el archivo de entrada como un archivo de estado, lo
      trata como un archivo de estado desempaquetado. Por ejemplo, puede usar
      esto para acceder al directorio de estado que se creó al ejecutar --no-
      clean con anterioridad.


  --unpack
      Desempaquetar el archivo de entrada en un directorio temporal, pero no
      ejecutar la orden aptitude.



Véase también

aptitude-create-state-bundle(1), aptitude(8), apt(8)

