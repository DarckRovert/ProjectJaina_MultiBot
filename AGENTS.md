# 🤖 Directrices de Ingeniería y Restricciones para Agentes IA — MultiBot

**Addon:** `MultiBot` (`Wanos_MultiBot`)  
**Ecosistema:** Project Jaina — Project Jaina (Módulo Oficial #21)  
**Repositorio Oficial:** [https://github.com/DarckRovert/Wanos_MultiBot](https://github.com/DarckRovert/Wanos_MultiBot)  
**Motor Gráfico y Runtime:** WoW 3.3.5a WotLK (Build 12340) / Lua 5.1 (Blizzard VM)

---

## ⚠️ Reglas Inquebrantables del Motor 3.3.5a

Al inspeccionar, mantener, extender o refactorizar este addon, cualquier ingeniero o agente de IA debe cumplir obligatoriamente las siguientes restricciones técnicas:

### 1. APIs Prohibidas de Retail (Inexistentes en 3.3.5a)
- ❌ **`SetColorTexture(r, g, b, a)`:** NO existe en 3.3.5a. Usar `texture:SetTexture("Interface\\Buttons\\WHITE8X8")` y `SetVertexColor`.
- ❌ **`C_Timer.After(sec, func)` sin guardia:** En 3.3.5a nativo `C_Timer` no existe. `MultiBot` incluye un wrapper en `Core/MultiBotAsync.lua` y `AceTimer-3.0`; utilizar siempre esos módulos o marcos con `OnUpdate`.
- ❌ **`IsInRaid()` / `IsInGroup()`:** NO existen en 3.3.5a. Usar `GetNumRaidMembers() > 0` o `GetNumPartyMembers() > 0`.
- ❌ **`GROUP_ROSTER_UPDATE`:** NO existe en WotLK. Usar `RAID_ROSTER_UPDATE` y `PARTY_MEMBERS_CHANGED`.
- ❌ **`EJ_GetEncounterInfo()` / Encounter Journal:** Inexistente antes de Cataclysm/MoP.

### 2. Normas Tipográficas y de Glifos (Cero Errores `?`)
- ❌ **Prohibido el uso de caracteres Unicode > U+024F:** La fuente tipográfica estándar `FRIZQT__.TTF` del cliente WoW 3.3.5a carece de glifos modernos (tales como flechas `▼`, rayas largas `—`, iconos `✨`, etc.).
- ✅ **Solución:** Utilizar caracteres alfanuméricos ASCII o símbolos del bloque Latin-1 estándar (`v`, `-`, `·`).

### 3. Protocolo de Comunicación y Red
- **Longitud Máxima de Comandos:** Todo payload transmitido vía `SendChatMessage` o `SendAddonMessage` no debe superar los **255 bytes**.
- **Canal de Addon:** El prefijo registrado es `MultiBot` o `MB`. No enviar mensajes con prefijos no registrados.
- **Throttling y Asincronía:** Toda consulta masiva al grupo o raid de bots debe canalizarse mediante `MultiBotThrottle.lua` y `MultiBotAsync.lua` para evitar saturación de frames o desconexiones por flood.

### 4. Estándar de Validación de Código
- Tras modificar cualquier archivo `.lua`, es mandatorio verificar la sintaxis de Lua 5.1 con `luac -p` o la suite de pruebas `python Tests/test_sanity.py`.
- No alterar las bibliotecas incrustadas en `Libs/` salvo corrección de compatibilidad probada y documentada.
- Mantener los diffs limpios, quirúrgicos y con indentación homogénea.