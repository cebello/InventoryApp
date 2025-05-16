# 📦 InventoryApp

Aplicación móvil desarrollada con **Flutter** para el control de inventarios, que permite autenticación de usuarios, consulta de productos, registro de entradas y salidas de mercancía, y funcionamiento offline mediante almacenamiento local con SQLite.

## 🚀 Características principales

- 🔐 **Autenticación** con email y contraseña (API externa `/auth/login`).
- 📋 **Consulta de Inventario** con sincronización desde API y respaldo local.
- ➕ **Registro de productos** y movimientos (entradas/salidas).
- 📡 **Sincronización online/offline** con SQLite y API.
- ⚙️ **Configuración externa** mediante archivo `.env`.

## 🧱 Arquitectura

El proyecto sigue el patrón **Screaming Architecture**, y está dividido en capas:

lib/
├── config/ # Configuraciones de entorno (.env)
├── core/ # Constantes, utilidades generales
├── data/ # Modelos, fuentes locales y remotas
├── domain/ # Entidades, repositorios y casos de uso
├── infrastructure/ # Implementaciones concretas
├── presentation/ # UI y lógica de estado (pantallas, providers)
└── main.dart


Usamos **Riverpod** para el manejo del estado y **flutter_dotenv** para variables de entorno.

## ⚙️ Requisitos

- Flutter SDK >= 3.7.2
- Dart SDK >= 3.0
- Emulador o dispositivo físico
- NodeJS (si vas a desarrollar el backend opcional)

## 📥 Instalación

1. Clona el repositorio:
   ```bash
   git clone https://github.com/cebello/InventoryApp.git
   cd InventoryApp
   ```
2. Instala las dependencias:
   ```bash
   flutter pub get
   ```
3. Crea un archivo `.env` en la raíz del proyecto con el siguiente contenido (ajusta los valores según tu configuración):
   ```
   URL_BASE_APP=http://localhost:3000
   API_KEY=supersecreto123
   ```
4. Corre la aplicación:
   ```bash
   flutter run
   ```
5. Corre el backend de la aplicación:
   * **https://github.com/cebello/InventoryBackend.git** *

## 📄 Licencia
Este proyecto es de uso privado para propósitos técnicos y educativos.