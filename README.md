## Synopsis

Este repositorio contiene el proyecto web 'Atlas de Depósitos Relaves'. Mediante él un usuario podrá efectuar una búsqueda basada en región/comuna o dueño/faena, la que entregará como resultado la posición en el mapa y la información de cada depósito.

El proyecto está escrito en Ruby y Javascript. El servidor Ruby on Rails, se encarga de servir los assets necesarios para el cliente y funciona como API. Por el lado del cliente, la app web está construida en AngulajJS.  


## Prerquisitos
  
Se debe tener instalado git

```sh
$ sudo yum update
$ sudo yum install git
```

Además, hay que instalar [rvm], que se encargará de instalar Ruby.

```sh
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ sudo yum install curl
$ curl -L get.rvm.io | bash -s stable

# Si corriste el instalador como sudo, ejecuta:
$ source /usr/local/rvm/rvm.sh
# Si lo instalaste mediante una cuenta de usuario con acceso sudo:
$ source ~/.rvm/rvm.sh
```
Para la verificación de las dependencias de [rvm], ejecuta:
```sh
$ rvm requirements
```
Este comando identificará qué dependencias necesitas instalar y te mostrará cómo hacerlo.

Ya con [rvm] listo, hay que instalar Ruby. La versión que se está usando es la 2.0.0-p643, por lo que hay que correr lo siguiente:
```sh
$ rvm install ruby-2.0.0-p643
# y luego dejar esta versión como por defecto
$ rvm use ruby-2.0.0-p643 --default
```

Para la instalación de las gemas que utiliza el proyecto utilizamos [bundler]. Pa su instalación:
```sh
# Dependencias
$ yum install gcc-c++ patch readline readline-devel zlib zlib-devel libyaml-devel libffi-devel openssl-devel make bzip2 autoconf automake libtool bison iconv-devel ruby-devel libxml2 libxml2-devel libxslt libxslt-devel
# Luego se instala la gema
$ gem install bundler
```


## Instalación

El proyecto utiliza una seria de gemas para su funcionamiento. Estas se encuentran listadas el archivo Gemfile. Para su instalación utilizamos [bundler] corriendo lo siguiente:
```sh
$ bundle install
```



```sh
$ git clone [git-repo-url] dillinger
$ cd dillinger
$ npm i -d
$ mkdir -p downloads/files/{md,html,pdf}
$ gulp build --prod
$ NODE_ENV=production node app
```

## API Reference

Depending on the size of the project, if it is small and simple enough the reference docs can be added to the README. For medium size to larger projects it is important to at least provide a link to where the API reference docs live.

## Tests

Describe and show how to run the tests with code examples.

## Contributors

Let people know how they can dive into the project, include important links to things like issue trackers, irc, twitter accounts if applicable.

## License

A short snippet describing the license (MIT, Apache, etc.)