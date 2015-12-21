## Introducción

Este repositorio contiene el proyecto web 'Atlas de Depósitos Relaves'. Mediante él un usuario podrá efectuar una búsqueda basada en región/comuna o dueño/faena, la que entregará como resultado la posición en el mapa y la información de cada depósito.

El proyecto está escrito en Ruby y Javascript. El servidor Ruby on Rails, se encarga de servir los assets necesarios para el cliente y funciona como API. Por el lado del cliente, la app web está construida en AngulajJS.  

Esta documentación asume que se instalará la aplicación en una máquina CentOS.

## Prerquisitos
  
Se debe tener instalado git

```sh
$ sudo yum update
$ sudo yum install git
```

Además, hay que instalar RVM, que se encargará de instalar Ruby.

```sh
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ sudo yum install curl
$ curl -L get.rvm.io | bash -s stable

# Si corriste el instalador como sudo, ejecuta:
$ source /usr/local/rvm/rvm.sh
# Si lo instalaste mediante una cuenta de usuario con acceso sudo:
$ source ~/.rvm/rvm.sh
```
Para la verificación de las dependencias de RVM, ejecuta:
```sh
$ rvm requirements
```
Este comando identificará qué dependencias necesitas instalar y te mostrará cómo hacerlo.

Ya con RVM listo, hay que instalar Ruby. La versión que se está usando es la 2.0.0-p643, por lo que hay que correr lo siguiente:
```sh
$ rvm install ruby-2.0.0-p643
# y luego dejar esta versión como por defecto
$ rvm use ruby-2.0.0-p643 --default
```

Para la instalación de las gemas que utiliza el proyecto utilizamos Bundler. Pa su instalación:
```sh
# Dependencias
$ yum install gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison iconv-devel ruby-devel libxml2 libxml2-devel libxslt libxslt-devel
# Luego se instala la gema
$ gem install bundler
```

## Instalación

Ahora que tenemos los prerequisitos instalados, debemos clonar el proyecto en el servidor de producción, en la carpeta que se estime conveniente. Para esto:

```sh
$ git clone https://github.com/jimibustamante/atlas.git
# Se pedirán credenciales de la cuenta git que ya debiese estar creada.
```

El proyecto utiliza una seria de gemas para su funcionamiento. Estas se encuentran listadas el archivo Gemfile. Para su instalación utilizamos Bundler corriendo lo siguiente:

```sh
$ bundle install
```

Luego de tener todas las gemas necesarias instaladas, pasamos a la configuración de la base de datos. La configuración de esta se encuentra en config/database.yml. Ahí se deben ingresar los datos de la base de datos que se utiliará en la sección 'production:'. Es importante que el usuario que se use tenga permisos para crear/editar/eliminar.
Cuando se ingresen los datos de la base de datos, volvemos a la carpeta root del proyecto (/atlas) y corremos los siguientes comandos con el fin de crear, migrar y problar la base de datos:

```sh
# Para crear base de datos
$ RAILS_ENV=production rake db:create
# Para crear estructura y tablas
$ RAILS_ENV=production rake db:migrate
# Para crear poblar los datos de las regiones de Chile
$ RAILS_ENV=production rake db:seed
# Para importar los datos a bartir de archivo CSV
$ RAILS_ENV=production rake import:all
```

Los siguiente es instalar lo necesario para obtener las librerias utiliadas en el front. Para ello se utliza Bower:
```sh
# Primero instalamos NodeJS y NPM
$ sudo yum install nodejs npm
# Ahora vamos por Bower
$ npm install -g bower
```
Ya que tenemos Bower en nuestro sistema podremos instalar las dependencias del Front-end. Estas se encuentran listadas 'bower.json'. Para esto:
```sh
$ bower install
```

Para compilar los assets que utilizara la web app, desde la carpeta root del proyecto corremos los siguiente:
```sh
$ RAILS_ENV=production rake assets:precompile
```

Luego, tenemos que conectar nuestra aplicación con apache/nginx. Para esto utilizamos Phusion Passenger.

```sh
$ gem install passenger 
```

Si se va a usar Apache:
```sh
$ yum install curl-devel httpd-devel   
$ passenger-install-apache2-module
```
Al ejecutar el último comando se debe seguir una guia paso a paso para completar la instalación. Si se requieren más dependencias se indicará cómo instalarlas.
Luego de terminado el proceso, se han agregado lineas de código para crear el servidor virtual para el atlas en el archivo httpd.conf de Apache. En él se deben modificar los valores del server_name y la ruta hacia la carpeta 'public' del proyecto Rails, según corresponda.
Al finalizar esto, reiniciamos el Apache:
```sh
service httpd restart 
```

Al terminar con éxito, debes reiniciar el servidor Rails. Desde la carpeta root del proyecto:
```sh
$ touch tmp/restart.txt
```

Para validad que esté todo bien, ingresamos a la url asociada a la aplicación y debiese estar en funcionamiento el Atlas.

## Actualizaciones

Cada vez que se efectue un cambio en la aplicación se deberá traer lo nuevo desde github:
```sh
# Desde carpeta root del proyecto
$ git pull origin master
# Se solicitarán credenciales de git

#Precomplicar assets del proyecto, migrar base de datos, importar datos desde CSV y reiniciar servicio:
$ RAILS_ENV=production rake assets:precompile
$ RAILS_ENV=production rake dm:migrate
$ RAILS_ENV=production rake import:all
$ touch tmp/restart.txt
```

