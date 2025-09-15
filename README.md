# Gym Docker Project

Este proyecto contiene el **frontend** en React/Vite y el **backend** en Laravel, ambos corriendo en contenedores Docker.
El Makefile incluido facilita la configuración, construcción y administración del proyecto.

---

## Requisitos

- Docker y Docker Compose v2
- Git
- Node.js y npm (para desarrollo local si se desea)
- Composer (opcional, si quieres ejecutar localmente)

---

## Clonación del proyecto

Clona este repositorio y los repositorios del frontend y backend automáticamente usando el Makefile:

```bash
# Clonar frontend y backend
make clone-all
```

---

## Configuración de entorno

Copia el archivo `.env.example` del backend a `.env`:

```bash
make create-env
```

Luego edita `backend/.env` con tus credenciales de base de datos y configuración deseada.

---

## Construcción de imágenes Docker

Construye los contenedores Docker:

```bash
# Construcción normal
make build

# Construcción sin usar cache
make build-no-cache
```

---

## Arrancar el proyecto

Levanta todos los contenedores:

```bash
make up
```

Para detener los contenedores:

```bash
make down
```

Para reiniciar:

```bash
make restart
```

---

## Backend (Laravel)

Instala dependencias de Composer:

```bash
make composer-install
```

Corre migraciones y seeders:

```bash
make migrate
make seed
```

Accede a un bash dentro del contenedor:

```bash
make bash
```

Ejecuta cualquier comando de Artisan:

```bash
make artisan-<comando>
# Ejemplo: make artisan-route:list
```

---

## Frontend (React/Vite)

Instala dependencias de npm:

```bash
make npm-install
```

Construye la versión de producción:

```bash
make npm-build
```

Levanta el modo de desarrollo:

```bash
make npm-dev
```

---

## Logs y administración

Ver logs de los contenedores:

```bash
make logs
```

Ver contenedores corriendo:

```bash
make ps
```

Limpiar contenedores, volúmenes y recursos de Docker:

```bash
make clean
```

---

## Notas

- Evita usar `sudo` para npm o Composer dentro del contenedor, para no generar problemas de permisos.
- Si Composer lanza advertencias de “dubious ownership”, se configura automáticamente en el Makefile con:

```bash
git config --global --add safe.directory /var/www
```