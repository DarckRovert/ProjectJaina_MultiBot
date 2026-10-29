# 📋 Registro de Cambios — ProjectJaina_MultiBot

Todos los cambios notables de este proyecto están documentados en este archivo siguiendo el estándar [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/).

---

## [4.0.0-WP] — 2026-10-27
### Integración Nativa MultiBot Bridge v4.0, Protocolo C++ Sin Chat Spam & Resiliencia Táctica
- **Protocolo de Red MultiBot Bridge v4.0 (`97_MultiBot_Bridge.lua`):**
  - Despacho de comandos y mutaciones de estrategia mediante tramas nativas `SendAddonMessage` bajo los prefijos `MBOT` y `MB_REQ` / `MB_RES`.
  - Erradicación total del chat spam: las órdenes ya no saturan los susurros del jugador, dirigiéndose directamente a la API C++ de `mod-playerbots` (`PlayerbotAI::ChangeStrategy` y `PlayerbotAI::HandleCommand`).
  - Implementación de `Split` literal plano para preservar intactos los campos vacíos de scope de grupo (`GROUP~~token~cmd`).
- **Adquisición de Objetivos y Concentración de Fuego (RTI):**
  - Soporte de adquisición inmediata de objetivos marcados con Raid Target Icons (`attack rti`, `pull rti`).
  - Sincronización en tiempo real del foco táctico de banda hacia el objetivo del tanque o líder.
- **Filtrado Dinámico de Barras Rápidas:**
  - Corrección de barras rápidas contextuales por clase y especialización activa del bot.
  - Arrastre suave de marcos de bot (`BotFrame`) con anclaje magnético y persistencia en `MultiBotGlobalSave`.
- **Inspección de Equipamiento y Estado en Vivo:**
  - Monitorización en rejilla de salud, maná, estado de combate y estrategias activas de todos los bots del escuadrón.

---

## [3.0.0] — 2026-10-20
### Panel Táctico de Estrategias y Formaciones en Rejilla
- **Gestión Avanzada de Estrategias:** Control granular de estrategias de combate (`tank`, `dps`, `heal`, `threat`, `aoe`, `behind`) y no combate (`follow`, `stay`, `buff`) por clase.
- **Control de Formaciones de Escuadrón:** Despliegue de formaciones militares (línea, triángulo, círculo, enjambre, flecha) con comando directo `.formation`.
- **Optimización de Memoria:** Recolección de basura calibrada para prevenir desbordamientos de heap en sesiones prolongadas con múltiples bots.

---

## [2.0.0] — 2026-10-15
### Rediseño de UI Glassmorphism y Sistema de Reclutamiento de Alts
- **Interfaz Moderna Project Jaina:** Rediseño integral de ventanas con paleta de colores arcana y compatibilidad con monitores FHD / Ultrawide.
- **Reclutamiento de Personajes Alternativos (Alts):** Invocación y gestión de personajes de la misma cuenta como bots autónomos con guardas de autorización RBAC.

---

## [1.0.1] — 2026-10-10
### Estabilización de Ecosistema y Gobernanza Oficial (Project Jaina)
- **Normalización de UI y Gráficos:** Purga de clones huérfanos en cliente, corrección sintáctica al comando canónico `.playerbots bot add Jaina` y actualización de interfaz táctica de grupo.
- **Homologación Documental:** Incorporación y actualización formal de `GOVERNANCE.md`, `LICENSE`, `NOTICE.md` y `SECURITY.md`.
- **Licencia Canónica:** Consolidación de licencia MIT 2026 bajo titularidad de DarckRovert & Project Jaina Team.
- **Validación de Runtime:** Verificado al 100% con compilador sintáctico `lua52_compiler.exe -p` con 0 errores y 0 warnings.

---

## [1.0.0] — 2026-10-04
### Lanzamiento Inicial — Ecosistema Project Jaina WotLK 3.3.5a
- Implementación de la arquitectura base para Project Jaina MultiBot.
- Registro de comandos slash: `/multibot, /mb`.
- Persistencia de configuración en `MultiBotDB`.
- Compatibilidad certificada con cliente WotLK 3.3.5a (Build 12340) y directiva `Interface: 30300`.
