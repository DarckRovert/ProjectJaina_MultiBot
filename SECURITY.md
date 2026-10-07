# 🛡️ Política de Seguridad y Mitigación de Vulnerabilidades — MultiBot

**Proyecto:** Ecosistema WoW Perú — Reino Andino  
**Módulo Oficial:** #21 (`WoWPeru_MultiBot`)  
**Repositorio Oficial:** [https://github.com/DarckRovert/WoWPeru_MultiBot](https://github.com/DarckRovert/WoWPeru_MultiBot)

---

## 🔒 Modelo de Seguridad y Validación de Datos

### 1. Autoridad Servidor y Prevención de Explotación
`MultiBot` opera como una capa de interfaz de usuario (UI) para el control de Playerbots. No ejecuta lógica privilegiada directamente en el servidor ni altera la memoria del cliente:
- Toda orden enviada hacia `mod-multibot-bridge` o vía chat es validada en el backend en C++ del servidor (`mod-playerbots`).
- Si un jugador intenta ordenar acciones sobre un bot que no le pertenece o sobre el cual no posee autoridad de grupo, el core de AzerothCore rechaza la instrucción inmediatamente.

### 2. Mitigación de Inundación de Red (Anti-Flood & Rate Limiting)
Para prevenir desconexiones masivas del cliente por exceso de paquetes o penalizaciones por spam:
- **Throttling Inteligente:** `MultiBotThrottle.lua` agrupa y temporiza las ráfagas de solicitudes hacia los bots, evitando el colapso del socket de red al interactuar con bandas completas de 25 o 40 bots.
- **Asincronía Escalonada:** `MultiBotAsync.lua` procesa las respuestas de estado e inventario en pequeñas colas divididas por cuadros de animación (`OnUpdate`), imposibilitando el congelamiento del hilo principal de renderizado.

### 3. Aislamiento de Taint y Seguridad en Combate
- La barra de herramientas y los marcos de inspección de bots están diseñados en espacio de usuario sin contaminar marcos de acción protegidos (`SecureTemplates`).
- Durante estados de combate del jugador (`InCombatLockdown()`), las llamadas a funciones protegidas son enrutadas a través de colas diferidas para evitar errores de interrupción de acción de interfaz (`Action blocked by an AddOn`).

---

## 🚨 Reporte de Vulnerabilidades

Si identificas cualquier anomalía, riesgo de seguridad o exploit en la comunicación cliente-servidor:
- Comunícate directamente con el equipo de infraestructura de **WoW Perú** mediante el canal privado de soporte del Discord oficial.
- Abre un reporte confidencial en el repositorio de GitHub: [GitHub Security Advisories / Issues](https://github.com/DarckRovert/WoWPeru_MultiBot/issues).
