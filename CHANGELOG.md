# 📝 Registro de Cambios — MultiBot

Todas las modificaciones notables a este proyecto se documentan en este archivo.  
El formato se basa en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/) y sigue [SemVer](https://semver.org/).

---

## [4.0.0-WP] — 2026-10-07

### 🌐 Integración con el Ecosistema Project Jaina (Project Jaina)
- **Módulo Oficial #21:** Adopción formal de MultiBot como el Módulo Oficial #21 de la infraestructura de cliente de Project Jaina.
- **Nuevos Slash Commands Oficiales:** Añadidos los alias oficiales del servidor:
  - `/wpmb` y `/wpbot` (para alternar la barra de control).
  - `/wpmbopt` (para abrir directamente el panel de opciones y ajustes).
- **Metadatos y TOC Estandarizados:** Actualización del fichero `MultiBot.toc` con la versión oficial `4.0.0-WP`, etiquetas `X-Ecosystem-Module: #21`, `X-Website` y enlaces a la organización oficial.
- **Suite Documental Golden Standard:** Creación del conjunto normativo de documentación técnica:
  - `README.md`: Documentación completa con identidad visual andina, badges de compatibilidad y tablas de comandos.
  - `NOTICE.md`: Atribución legal a Nico Löbbert, Wishmaster117, Macx-Lio y la comunidad de AzerothCore.
  - `ECOSYSTEM_REGISTRY.md`: Ficha técnica de arquitectura, sinergias y compatibilidad.
  - `AGENTS.md`: Directrices y restricciones de motor 3.3.5a para desarrollo asistido por agentes.
  - `API.md`, `INSTALL.md`, `SECURITY.md`: Especificación técnica profunda, guía de despliegue y modelo de seguridad.
- **Suite de Pruebas Automatizadas:** Implementación de `Tests/test_sanity.py` con validaciones de TOC, sintaxis de scripts Lua, comandos slash y restricciones de motor WotLK 3.3.5a.
- **Normalización de Repositorio:** Adición de `.gitattributes` para protección de texturas y fuentes binarias (BLP, TGA, PNG).

---

## [4.0.0-Chatless] — 2026-04-18

### 🚀 Arquitectura Bridge-First (Por Wishmaster117)
- **Eliminación del Spam de Chat Automático:** Migración de consultas de bots y órdenes frecuentes a mensajes de addon estructurados canalizados a través del módulo de servidor `mod-multibot-bridge`.
- **Throttling y Manejo Asíncrono:** Introducción de `MultiBotThrottle.lua` y `MultiBotAsync.lua` para evitar congelamientos de la interfaz gráfica al consultar inventarios o talentos de hasta 40 bots.
- **Localización Multilingüe Completa:** Soporte de 9 idiomas con traducciones especializadas (`esES`, `enUS`, `frFR`, `deDE`, `enGB`, `ruRU`, `zhCN`, `koKR`).
- **Gestión Avanzada de Botín y Recompensas:** Nuevos módulos `MultiBotLootMasterUI`, `MultiBotRewardFrame` y `MultiBotLootUI`.
- **Especializaciones y Talentos:** Panel de asignación de árboles de talentos remotos para bots de todas las clases (`MultiBotTalentFrame`).

---

## [3.0.0] — 2024-11-12

### ✨ Mejoras por Nico Löbbert & Comunidad
- Interfaz gráfica flotante rediseñada con soporte para todas las 10 clases de WotLK (incluyendo Caballeros de la Muerte).
- Menú de formación táctica (`Follow`, `Stay`, `Near`, `Arrow`, `Shield`, `Circle`, `Line`, `Chaos`).
- Soporte para mascotas de Cazador y selección de familias (`Data/HunterPetFamily.lua`).
- Integración de inspección remota de equipo y gemas (`MultiBotInspectUI`).

---

## [1.0.0] — 2022-03-05

### 🌟 Lanzamiento Inicial de MultiBot
- Primera versión pública del addon de control de Playerbots para servidores World of Warcraft 3.3.5a.
- Despacho de comandos de combate por susurro básico (`tank`, `dps`, `heal`).
