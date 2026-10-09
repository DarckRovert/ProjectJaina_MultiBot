# 🤖 Project Jaina — MultiBot (Control Táctico de Playerbots)

[![WoW Version](https://img.shields.io/badge/WoW-3.3.5a%20(12340)-blue.svg)](https://darckrovert.github.io/ProjectJaina_Web/)
[![Core Compatibility](https://img.shields.io/badge/Core-AzerothCore%20%7C%20mod--playerbots-red.svg)](https://github.com/azerothcore/mod-playerbots)
[![License](https://img.shields.io/badge/License-GPL--3.0-green.svg)](LICENSE)
[![GitHub](https://img.shields.io/badge/GitHub-DarckRovert%2FProjectJaina__MultiBot-black?logo=github)](https://github.com/DarckRovert/ProjectJaina_MultiBot)
[![Ecosistema](https://img.shields.io/badge/Ecosistema-WoW%20Per%C3%BA%20(M%C3%B3dulo%20%2321)-gold.svg)](https://darckrovert.github.io/ProjectJaina_Web/)

Suite de interfaz gráfica integral y control de escuadrón de **Playerbots** (`mod-playerbots`) para **World of Warcraft: Wrath of the Lich King 3.3.5a (Build 12340)**, adaptada e integrada oficialmente en el ecosistema de **Project Jaina — Project Jaina** como el **Módulo Oficial #21**.

MultiBot permite comandar, equipar, inspeccionar y dirigir estratégicamente a compañeros controlados por inteligencia artificial sin requerir comandos de texto manuales y minimizando el spam en el chat gracias a su arquitectura **Bridge-First**.

---

## 📑 Tabla de Contenidos

- [Características Principales](#-características-principales)
- [Arquitectura Bridge-First (Sin Spam en Chat)](#-arquitectura-bridge-first-sin-spam-en-chat)
- [Módulos de la Interfaz](#-módulos-de-la-interfaz)
- [Estrategias por Clase y Roles](#-estrategias-por-clase-y-roles)
- [Comandos de Consola (Slash Commands)](#-comandos-de-consola-slash-commands)
- [Instalación y Requisitos](#-instalación-y-requisitos)
- [Integración con el Ecosistema Project Jaina](#-integración-con-el-ecosistema-wow-perú)
- [Atribución, Créditos y Licencia](#-atribución-créditos-y-licencia)

---

## ✨ Características Principales

- **Barra de Control Rápido Flotante:** Acceso con un solo clic a órdenes tácticas inmediatas (`Atacar`, `Huir`, `Detenerse`, `Dispersarse`).
- **Selector de Formaciones:** Posicionamiento dinámico de los bots alrededor del líder (`Seguir`, `Cerca`, `Escudo`, `Flecha`, `Círculo`, `Línea`, `Caos`).
- **Asignación de Roles Inmediata:** Conmutación rápida entre roles de combate: **Tanque**, **Sanador** y **DPS** (Cuerpo a cuerpo / A distancia).
- **Inspección e Inventario Remoto:** Examina el equipo, las gemas, los encantamientos y el contenido de las bolsas de cualquier bot del grupo.
- **Gestor de Árboles de Talentos:** Asigna puntos y plantillas de talentos personalizadas a tus bots directamente desde la interfaz.
- **Control Específico de Clase:**
  - Panel rápido de mascotas de Cazador y selección de familias (`Data/HunterPetFamily.lua`).
  - Gestión de tótems de Chamán (`MultiBotShamanQuickFrame.lua`).
- **Administración de Botín (Loot Master):** Reglas configurables de despojo automático y reparto de recompensas (`MultiBotLootMasterUI`).
- **Soporte Multilingüe Completo:** Localizado en español (`esES`), inglés, francés, alemán, ruso, chino y coreano.

---

## ⚡ Arquitectura Bridge-First (Sin Spam en Chat)

A diferencia de los addons tradicionales de playerbots que envían cientos de comandos por susurros o canales de grupo, MultiBot implementa un flujo estructurado de mensajería:

```text
Interacción en UI de MultiBot
   │
   ▼
Mensaje de Addon Estructurado (MB_REQ)
   │
   ▼
Módulo de Servidor (mod-multibot-bridge en C++)
   │
   ▼
Validación de Autoridad y Ejecución en Core
   │
   ▼
Respuesta Estructurada (MB_RES) -> Actualización Silenciosa de UI
```

> [!NOTE]  
> **Modo Híbrido Resiliente:** Si el servidor no tiene instalado `mod-multibot-bridge`, MultiBot conmuta de forma automática y transparente al modo de compatibilidad clásica mediante susurros al bot.

---

## 🗂️ Módulos de la Interfaz

| Módulo | Elemento | Función Principal |
|---|---|---|
| **`MultiBotMainUI`** | Barra Principal | Barra flotante configurable con botones de acción rápida, filtros de lista y estado general. |
| **`MultiBotFormationUI`** | Menú de Formación | Control geométrico del escuadrón para posicionamiento en pulls y jefes de mazmorra. |
| **`MultiBotAttackUI`** | Panel de Ataque | Selección de objetivos prioritarios, enfoque de foco (`Focus`) y orden de inicio de combate. |
| **`MultiBotFleeUI`** | Panel de Retirada | Orden de repliegue de emergencia hacia la posición del líder evitando aggro adicional. |
| **`MultiBotUnitsRosterUI`** | Lista de Escuadrón | Visualización de salud, maná, rol activo y estado de combate de todos los bots vinculados. |
| **`MultiBotInspectUI`** | Inspección Remota | Vista detallada del equipo 3.3.5a del bot con cálculo de estadísticas. |
| **`MultiBotTalentFrame`** | Editor de Talentos | Interfaz visual para consultar y gastar puntos de talentos en bots remotos. |
| **`MultiBotLootUI`** | Distribución de Botín | Configuración de reglas de despojo, venta automática de basura y asignación de ítems. |
| **`MultiBotGmUI`** | Herramientas GM | Panel de depuración, gestión de bots de prueba y comandos avanzados para administradores. |

---

## 🛡️ Estrategias por Clase y Roles

MultiBot cuenta con módulos de estrategia dedicados y optimizados para cada una de las 10 clases de World of Warcraft 3.3.5a:

| Clase | Archivo de Estrategia | Capacidades Destacadas |
|---|---|---|
| **Caballero de la Muerte** | `MultiBotDeathKnight.lua` | Presencias (Sangre, Escarcha, Profano), gestión de runas y cuerno de invierno. |
| **Druida** | `MultiBotDruid.lua` | Formas (Oso, Felino, Lechúcico, Árbol de vida), sanación periódica y provocar. |
| **Cazador** | `MultiBotHunter.lua` | Aspectos, trampas, control de mascotas y disparos de rotación. |
| **Mago** | `MultiBotMage.lua` | Armaduras, refrigerio, polimorfia táctica y daño en área/foco. |
| **Paladín** | `MultiBotPaladin.lua` | Bendiciones, auras, sellos, sentencia, pompa y mitigación de daño. |
| **Sacerdote** | `MultiBotPriest.lua` | Rezos, escudos, disipación en masa, Forma de las Sombras y penitencia. |
| **Pícaro** | `MultiBotRogue.lua` | Sigilo, venenos, porrazo antes de pull, interrupciones y evasión. |
| **Chamán** | `MultiBotShaman.lua` | Conjunto de 4 tótems, armas imbuidas, Ansia de Sangre / Heroísmo y cortes de viento. |
| **Brujo** | `MultiBotWarlock.lua` | Demonios invocados, piedras de salud/alma, maldiciones y drenado. |
| **Guerrero** | `MultiBotWarrior.lua` | Actitudes (Batalla, Defensiva, Rabiosa), gritos, provocar y control de ira. |

---

## ⌨️ Comandos de Consola (Slash Commands)

MultiBot responde a los siguientes comandos de barra en el cliente:

```text
/mb           - Alterna la barra principal de control de MultiBot.
/wpmb         - Alias oficial de Project Jaina (Project Jaina).
/wpbot        - Alias alternativo de Project Jaina.
/multibot     - Comando largo canónico.
/mbot         - Alias estándar corto.
/mbopt        - Abre el panel de opciones y preferencias de interfaz.
/wpmbopt      - Alias de opciones oficial de Project Jaina.
/mbfakegm     - Alterna la simulación de interfaz de Game Master.
/mbdebug      - Herramienta de telemetría interna (/mbdebug <subsistema> <on|off|toggle>).
```

---

## 📦 Instalación y Requisitos

1. **Ruta de Instalación:**  
   Clona o extrae el contenido en tu directorio de addons:  
   `World of Warcraft\Interface\AddOns\MultiBot\`
2. **Requisitos de Servidor:**  
   - Servidor **AzerothCore** con el módulo [mod-playerbots](https://github.com/azerothcore/mod-playerbots) habilitado.
   - Opcional: Módulo de servidor [mod-multibot-bridge](https://github.com/Wishmaster117/mod-multibot-bridge) para despacho silencioso sin mensajes de chat.
3. Para una guía paso a paso completa, consulta [INSTALL.md](INSTALL.md).

---

## 🌐 Integración con el Ecosistema Project Jaina

Como el **Módulo Oficial #21**, MultiBot interactúa armónicamente con la suite completa de Project Jaina:
- **`ProjectJaina_RaidSuite`:** Asignación coordinada de marcas de banda y roles tácticos.
- **`ProjectJaina_AdminTools`:** Complementación entre herramientas de GM y control de bots de prueba.
- **`ProjectJaina_Companion`:** Coexistencia limpia en red P2P sin colisión de prefijos ni canales de chat.
- **`ProjectJaina_Graphics`:** Interfaz visual nítida en resoluciones panorámicas Full HD y 4K.

Para más detalles técnicos, consulta [ECOSYSTEM_REGISTRY.md](ECOSYSTEM_REGISTRY.md) y [API.md](API.md).

---

## 📜 Atribución, Créditos y Licencia

- **Autor Original de MultiBot:** `Nico Löbbert`
- **Desarrollador & Maintainer de MultiBot Chatless:** `Wishmaster117 aka TheWarlock` (Alex Plex)
- **Contribuidores Comunitarios:** `Macx-Lio`, `ike3` y la comunidad de AzerothCore.
- **Adaptación Oficial y Estandarización:** Project Jaina Dev Team (`DarckRovert` / `Elnazzareno`).
- **Licencia:** Distribuido bajo la **GNU General Public License v3 (GPL-3.0)**. Consulta [LICENSE](LICENSE) y [NOTICE.md](NOTICE.md) para los avisos legales completos.
