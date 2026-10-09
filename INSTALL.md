# 📦 Guía de Instalación y Despliegue — MultiBot

[![WoW Version](https://img.shields.io/badge/WoW-3.3.5a%20(12340)-blue.svg)](https://darckrovert.github.io/ProjectJaina_Web/)
[![Core Compatibility](https://img.shields.io/badge/Core-AzerothCore%20%7C%20mod--playerbots-red.svg)](https://github.com/azerothcore/mod-playerbots)
[![Repositorio](https://img.shields.io/badge/GitHub-DarckRovert%2FProjectJaina__MultiBot-black?logo=github)](https://github.com/DarckRovert/ProjectJaina_MultiBot)
[![Ecosistema](https://img.shields.io/badge/Ecosistema-WoW%20Per%C3%BA%20(M%C3%B3dulo%20%2321)-gold.svg)](https://darckrovert.github.io/ProjectJaina_Web/)

---

## 📋 Requisitos Previos

### 1. Cliente de Juego
- **Versión:** World of Warcraft: Wrath of the Lich King 3.3.5a (Build 12340).
- **Idioma Soportado:** Español (`esES`), Inglés (`enUS`, `enGB`), Francés (`frFR`), Alemán (`deDE`), Ruso (`ruRU`), Chino (`zhCN`), Coreano (`koKR`).

### 2. Servidor Emulador
- **Emulador:** AzerothCore rev. WotLK 3.3.5a.
- **Módulos del Servidor:**
  - `mod-playerbots`: **Obligatorio** para la generación y control de bots autónomos.
  - `mod-multibot-bridge`: **Recomendado** para la comunicación sin spam en chat (*Bridge-First*). Si no está instalado, MultiBot funcionará en modo de compatibilidad clásica vía susurros.

---

## 🚀 Instalación en el Cliente

1. **Ubicación de la Carpeta de AddOns:**  
   Dirígete a tu directorio de instalación del cliente WoW:
   ```text
   <Directorio_WoW>\Interface\AddOns\
   ```

2. **Clonar o Copiar el Repositorio:**  
   Descarga o clona este repositorio directamente dentro de la carpeta:
   ```bash
   git clone https://github.com/DarckRovert/ProjectJaina_MultiBot.git MultiBot
   ```

3. **Verificación de la Ruta:**  
   Es **crítico** que la carpeta se llame exactamente `MultiBot` para que el archivo de índice del cliente coincida:
   ```text
   World of Warcraft\Interface\AddOns\MultiBot\MultiBot.toc
   ```

4. **Habilitación en el Cliente:**  
   - Abre el cliente `Wow.exe`.
   - En la pantalla de selección de personajes, haz clic en el botón **Accesorios** (AddOns) en la esquina inferior izquierda.
   - Asegúrate de marcar la casilla **Cargar accesorios antiguos** (Load out of date AddOns).
   - Verifica que **MultiBot** esté marcado con una casilla de verificación activa.

---

## 🎮 Comprobación y Primeros Pasos In-Game

1. **Abrir la Interfaz de MultiBot:**  
   Escribe cualquiera de los siguientes comandos en el chat:
   ```text
   /mb
   /wpmb
   /multibot
   ```
   Aparecerá la barra flotante de control rápido en pantalla.

2. **Acceder a la Configuración y Opciones:**  
   ```text
   /mbopt
   /wpmbopt
   ```
   O abre el menú principal del juego (**ESC**) -> **Interfaz** -> Pestaña **Accesorios** -> **MultiBot**.

3. **Invocar o Asignar Bots al Grupo:**  
   - Forma un grupo con bots creados con tu servidor (`.bot add <nombre>` o usando el panel de creador de MultiBot `/mb`).
   - Usa los botones de rol para asignar rápidamente: Tanque, DPS o Sanador.
   - Observa las estrategias adaptadas a la clase de cada bot en tiempo real.

---

## 🛠️ Resolución de Problemas Comunes

| Síntoma | Causa Probable | Solución |
|---|---|---|
| El addon no aparece en la lista de Accesorios | Carpeta anidada doblemente (ej: `MultiBot/MultiBot/...`) | Extrae los archivos para que `MultiBot.toc` quede directamente en `Interface/AddOns/MultiBot/MultiBot.toc`. |
| Los bots no responden a las órdenes de la interfaz | `mod-playerbots` no está activo en el servidor | Verifica que el módulo de playerbots esté compilado y activo en tu `worldserver`. |
| Mensajes repetitivos de chat al dar órdenes | Falta `mod-multibot-bridge` en el servidor | Instala `mod-multibot-bridge` en tu AzerothCore para activar la comunicación silenciosa nativa. |
