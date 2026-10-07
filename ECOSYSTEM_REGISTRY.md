# 🌐 Registro de Ecosistema — WoWPeru_MultiBot

Ficha técnica oficial de registro en la infraestructura multi-addon de **WoW Perú - Reino Andino**.

---

## 1. Identidad del Addon en el Ecosistema

| Campo | Valor |
|---|---|
| **Nombre Técnico** | `WoWPeru_MultiBot` |
| **Carpeta Local** | `MultiBot` |
| **Versión Actual** | `4.0.0-WP` |
| **Clasificación** | Control de Bots / Inteligencia Artificial / Escuadrón / Gestión de Grupo |
| **Módulo Oficial** | Módulo Oficial #21 |
| **Licencia Formal** | GNU General Public License v3 (GPL-3.0) |
| **Repositorio GitHub** | [WoWPeru_MultiBot](https://github.com/DarckRovert/WoWPeru_MultiBot) |
| **Repositorio Upstream** | [Wishmaster117/MultiBot-Chatless](https://github.com/Wishmaster117/MultiBot-Chatless) |
| **Entorno de Juego** | World of Warcraft 3.3.5a (Build 12340) / WotLK |
| **Compatibilidad del Servidor** | AzerothCore con módulo `mod-playerbots` (y `mod-multibot-bridge` opcional) |
| **Persistencia** | `MultiBotSave`, `MultiBotDB`, `MultiBotSaved` (por PJ) / `MultiBotGlobalSave` (por cuenta) |

---

## 2. Garantías de Rendimiento y Arquitectura

- **Arquitectura Bridge-First:** Prioriza el intercambio de datos mediante mensajes de addon estructurados (`SendAddonMessage`) procesados por el backend en C++ (`mod-multibot-bridge`), eliminando el spam masivo de susurros y comandos de chat automáticos.
- **Modo Híbrido Resiliente:** Si el puente en C++ no está instalado o no responde, el addon conmuta automáticamente a despacho mediante comandos de susurro directos al bot, garantizando operatividad 100% en cualquier servidor AzerothCore estándar.
- **Rendimiento de Cuadro:** Menos de 0.05 ms por frame en reposo; actualizaciones escalonadas asíncronas (`MultiBotAsync.lua`) que evitan congelamientos de la interfaz gráfica al consultar grupos o raids con hasta 25 bots.
- **Inmunidad a Taint de Combate:** Toda la barra de acciones flotante y menús de control operan en espacio de usuario sin intervenir en botones de acción seguros de Blizzard (`SecureActionButtonTemplate`) de forma que bloquee las macros del jugador.

---

## 3. Matriz de Integración del Ecosistema WoW Perú

| Módulo Coexistente | Modo de Interacción | Sinergia y Flujo de Datos |
|---|---|---|
| **`WoWPeru_RaidSuite`** | Coordinación Táctica de Banda | `RaidSuite` maneja las alertas de jefes, marcas y asignaciones; `MultiBot` ejecuta los roles (Tank/DPS/Heal) y las posiciones de los Playerbots en la estancia. |
| **`WoWPeru_AdminTools`** | Soporte para Game Masters | `AdminTools` provee teletransporte y utilidades de GM; `MultiBot` provee la barra GM (`MultiBotGmUI`) y comandos FakeGM para depuración de bots en entornos de prueba. |
| **`WoWPeru_Companion`** | Sinergia Social & Cross-Faction | Coexistencia armónica en grupo y hermandad sin conflictos de mensajes de addon ni colisión de canales de comunicación. |
| **`WoWPeru_Graphics`** | Calidad Visual HD | Los marcos flotantes, iconos de clases e inventario se renderizan con pixel-perfect alignment en resoluciones Full HD y 4K. |
| **`ACP` (Addon Control Panel)** | Control de Carga Dinámico | Admite carga y descarga en caliente mediante `/acp` sin necesidad de reiniciar el cliente ejecutable `Wow.exe`. |
