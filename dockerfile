FROM ruby:1.9.3

# Reparar error con la clave pública de Jessie
RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://archive.debian.org/debian-security/ jessie/updates main\ndeb-src http://archive.debian.org/debian-security/ jessie/updates main" > /etc/apt/sources.list

# Actualizar y descargar dependencias necesarias
RUN apt-get update -qq && apt-get install -y --force-yes \
  build-essential \
  libpq-dev \
  nodejs \
  webp \
  xfonts-75dpi \
  xfonts-base \
  xvfb \
  libfontconfig \
  libjpeg-dev \
  libjpeg62-turbo-dev \
  locales  # Añadido locales

# Configurar locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

# Establecer variables de entorno para locales
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Forzar a Ruby a usar UTF-8
ENV RUBYOPT="-Eutf-8"

# Definir el directorio de trabajo de la aplicación
ENV APP_HOME /code
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Copiar el Gemfile y el Gemfile.lock al contenedor
COPY Gemfile Gemfile.lock ./

# Instalar las gems necesarias
RUN gem install bundler -v 1.17.3
RUN bundle install

# Copiar el resto del código de la aplicación
COPY . .

# Exponer el puerto 3000
EXPOSE 3000

# Comando para iniciar el servidor
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
