# Análisis del Proyecto: ProyectoU3GameMaker

## 📋 Resumen General

Este es un **videojuego de rol (RPG) en 2D** desarrollado con **GameMaker Studio 2022**, que presenta un sistema de combate, diálogos, misiones y un sistema de historia con múltiples rutas y decisiones.

---

## 🎮 Tipo de Juego

- **Género**: RPG de acción top-down
- **Motor**: GameMaker Studio 2022.0.3.85
- **Perspectiva**: Top-down (vista aérea)
- **Estilo**: Fantasía medieval con elementos mágicos

---

## 🏗️ Arquitectura del Proyecto

### Estructura de Carpetas

El proyecto está bien organizado en las siguientes categorías:

1. **Objects** (Objetos del juego)
   - Control (o_game_start, o_camera, etc.)
   - Enemigos (o_slime, o_goblin, o_skeleton, o_dragon_red, etc.)
   - NPCs (o_npc_base y múltiples NPCs específicos)
   - Player (o_player y armas)
   - Story (sistema de historia y cinemáticas)
   - Level (estructuras, terreno, transiciones)

2. **Rooms** (Salas/Niveles)
   - rm_menu (menú principal)
   - rm_pradera (pradera)
   - rm_mundo_abierto (mundo abierto)
   - rm_cueva1, rm_mina (dungeons)
   - rm_Pueblo_Roll (pueblo principal)
   - rm_gremioP (gremio)
   - rm_salon_duque (palacio)
   - Y más...

3. **Scripts** (Funciones reutilizables)
   - Sistema de diálogos
   - Sistema de historia/misiones
   - Control del jugador
   - Combate

---

## 🎯 Sistemas Principales

### 1. Sistema de Jugador (o_player)

#### Características:
- **Estadísticas base**:
  - HP: 100 (máximo 100)
  - Stamina: 100 (máximo 100)
  - Mana: 50 (máximo 50)
  - Nivel: 1
  - XP: 0

- **Atributos**:
  - Inteligencia (Int): 5
  - Fuerza (Str): 5
  - Velocidad (Spd): 5
  - Vitalidad (Vit): 5

- **Movimiento**:
  - Velocidad base: 3
  - Velocidad de carrera: 5
  - Sistema de salto 3D (z-axis)
  - Control top-down con WASD

- **Combate**:
  - Ataque físico (J o click izquierdo)
  - Ataque mágico (M) - consume 10 de mana
  - Bloqueo (K) - consume stamina
  - Sistema de invulnerabilidad temporal

- **Elementos mágicos**:
  - Fuego (tecla 1)
  - Hielo (tecla 2)
  - Rayo (tecla 3)
  - Oscuridad (tecla 4)

- **Sistema de nivel**:
  - Subida de nivel automática al alcanzar XP requerido
  - Puntos de atributo asignables (menú con C)
  - Curva de experiencia: `xp_next * 1.5`

#### Estados del Jugador:
- `idle` - Inactivo
- `walk` - Caminando
- `attack` - Atacando
- `block` - Bloqueando
- `cast` - Lanzando magia
- `dead` - Muerto

### 2. Sistema de Combate

#### Mecánicas:
- **Ataque físico**: Crea hitbox (`o_attack_hitbox`) delante del jugador según dirección
- **Ataque mágico**: Proyectiles (`o_magic_projectile`) direccionales
- **Sistema de daño**: Script `scr_enemy_take_damage()` que:
  - Aplica daño al enemigo
  - Muestra número de daño flotante (`o_damage_number`)
  - Efecto visual de flash rojo
  - Verifica muerte del enemigo

#### Enemigos Implementados:
- `o_slime` - Enemigo básico (HP: 30, Daño: 5)
- `o_goblin` - Goblin
- `o_skeleton` - Esqueleto (con flechas)
- `o_wolf` - Lobo
- `o_dragon_red` - Dragón rojo
- `o_demon_minor` - Demonio menor
- `o_demon_medium` - Demonio mediano
- `o_guardian_corrupt` - Guardián corrupto
- `o_guardian_echo` - Guardián eco

### 3. Sistema de Diálogos

#### Componentes:
- **o_chat**: Objeto que muestra el diálogo en pantalla
- **o_chat_decision**: Sistema de decisiones en diálogos
- **o_dialog_box**: Caja de diálogo visual
- **Script `scr_dialogo()`**: Función principal para iniciar diálogos

#### Funcionamiento:
```gml
scr_dialogo(_speaker, _text)
```
- Crea una cola de diálogos (`ds_queue`)
- Gestiona el estado global `dialogue_active`
- Formatea líneas con nombre del hablante
- Crea instancia de `o_chat` en la capa GUI

### 4. Sistema de Historia y Misiones

#### Arquitectura:
El sistema está basado en **estructuras de datos** (ds_map, ds_list, ds_queue):

1. **Variables Globales**:
   - `global.story_phase` - Fase actual de la historia
   - `global.story_flags` - Flags booleanos (ej: "prologo_completado")
   - `global.story_routes` - Rutas del jugador:
     - `moral` (neutral/guardian/rebelde)
     - `karma` (equilibrio/luz/caos)
     - `element` (fuego/tiempo/viento)
     - `world` (ciudad/salvaje)
     - `companion` (mika/eomer/ninguno)
     - `skill` (tecnologica/arcana/ninguna)
   - `global.quest` - Mapa de misiones con estados:
     - "no_iniciada"
     - "en_progreso"
     - "completada"
     - "fallada"

2. **Misiones Principales**:
   - `M_prologo`
   - `M_roll_mazmorra`
   - `M_ciudad_costera`
   - `M_reino_enano`
   - `M_palacio_pesadillas`
   - `M_runa_sagrada`

3. **Misiones Secundarias**:
   - `S_mika_nucleo_1`
   - `S_eomer_hermana`
   - `S_ruta_luz`
   - `S_ruta_caos`

4. **Sistema de Decisiones**:
   - `global.story_decisions` - Mapa de decisiones registradas
   - `global.story_auto_triggers` - Triggers automáticos
   - `scr_story_show_decision()` - Muestra decisiones al jugador

5. **Cinemáticas**:
   - `global.story_cinematic_queue` - Cola de cinemáticas
   - `scr_cinematic_prologo()` - Cinemática del prólogo

### 5. Sistema de NPCs

#### Base: `o_npc_base`
- Sistema de interacción con radio de 64 píxeles
- Indicador visual (sprite `s_keyboard_E`)
- Sistema de diálogos por ID
- Referencia al jugador

#### NPCs Específicos:
- `o_npc_eomer` - Eomer
- `o_npc_mika` - Mika
- `o_npc_Nina` - Nina
- `o_npc_DuqueArkan` - Duque Arkan
- `o_npc_AncianoBosque` - Anciano del Bosque
- `o_npc_ComercianteAmbulante` - Comerciante
- `o_npc_HerreroElfico` - Herrero Élfico
- `o_npc_guardia` - Guardia
- `o_npc_guardian` - Guardián
- `o_npc_recepcionista` - Recepcionista

### 6. Sistema de Interacción

- **o_interactable**: Objeto base para elementos interactuables
- **o_inter_mask**: Máscara de interacción direccional
- **Script `scr_interact()`**: Maneja interacciones
- Tecla de interacción: **E**

### 7. Sistema de Checkpoints y Respawn

- **o_checkpoint**: Objetos checkpoint
- Variables globales:
  - `global.checkpoint` - Sala de checkpoint
  - `global.player_respawn` - Flag de respawn
  - `global.player_dead` - Estado de muerte
- Sistema de spawn temporal (`temp_spawn_x`, `temp_spawn_y`)

### 8. Sistema de Cámara

- **o_camera**: Objeto de cámara personalizado
- Probablemente sigue al jugador con suavizado

### 9. Sistema de Transiciones

- **o_tran**: Transición general
- **o_tran_l**: Transición izquierda
- **o_tran_r**: Transición derecha
- **o_portal**: Portales de teletransporte

### 10. Sistema de Inventario/Items

- **o_chest**: Cofres
- Varios sprites de items (comida, medallones, etc.)
- Sistema de tiendas (`o_tienda1`, `o_tienda2`, `o_tienda3`, `o_tienda4`)

---

## 🎨 Recursos Visuales

### Sprites:
- **Player**: Múltiples sprites para animaciones (idle, walk, attack, arriba, abajo)
- **Enemigos**: Sprites individuales para cada tipo
- **NPCs**: Sprites específicos
- **Ambiente**: Tilesets, decoraciones, estructuras
- **UI**: HUD, menús, botones

### Tilesets:
- 17 tilesets diferentes (TileSet1 a TileSet17)
- Tilesets específicos para diferentes áreas (muros, pradera, pueblo, etc.)

### Fuentes:
- `f_espanol` - Fuente en español

### Sonidos:
- `snd_click` - Sonido de click
- `snd_hover` - Sonido de hover

---

## 🔧 Scripts Importantes

1. **scr_player_topdown()** - Control del jugador en vista top-down
2. **scr_player_lateral()** - Control lateral (comentado/removido)
3. **scr_dialogo()** - Sistema de diálogos
4. **scr_enemy_take_damage()** - Sistema de daño a enemigos
5. **scr_interact()** - Sistema de interacción
6. **scr_story_init_globals()** - Inicialización del sistema de historia
7. **scr_story_register_main_quests()** - Registro de misiones principales
8. **scr_story_register_core_decisions()** - Registro de decisiones
9. **scr_story_show_decision()** - Mostrar decisiones al jugador
10. **scr_story_set_route()** - Cambiar rutas de la historia
11. **scr_player_die()** - Manejo de muerte del jugador
12. **scr_start_npc_dialogo()** - Iniciar diálogo con NPC
13. **scr_npc_get_dialogue()** - Obtener diálogo de NPC
14. **PlaceMeeting3D()** - Colisiones 3D (para sistema de salto)

---

## 🎯 Características Destacadas

### ✅ Puntos Fuertes:

1. **Sistema de Historia Complejo**:
   - Múltiples rutas y decisiones
   - Sistema de flags y triggers
   - Misiones principales y secundarias

2. **Sistema de Combate Funcional**:
   - Ataques físicos y mágicos
   - Sistema de elementos
   - Feedback visual (números de daño)

3. **Sistema de Progresión**:
   - Niveles y experiencia
   - Atributos asignables
   - Sistema de stats que afectan gameplay

4. **Organización del Código**:
   - Scripts modulares
   - Objetos bien estructurados
   - Sistema de herencia (o_npc_base)

5. **Sistema de Diálogos**:
   - Sistema de colas
   - Soporte para decisiones
   - Integración con NPCs

6. **Sistema 3D para Saltos**:
   - Implementación de eje Z
   - Colisiones 3D
   - Sistema de gravedad

### ⚠️ Áreas de Mejora Potenciales:

1. **Código Duplicado**:
   - Algunos scripts podrían consolidarse
   - Lógica de sprites repetida en varios lugares

2. **Documentación**:
   - Falta documentación en algunos scripts
   - Algunos comentarios podrían ser más descriptivos

3. **Manejo de Errores**:
   - Algunas verificaciones de existencia de variables podrían mejorarse
   - Validación de parámetros en funciones

4. **Optimización**:
   - Algunas operaciones podrían optimizarse (ej: búsquedas en ds_map)
   - Sistema de pooling para proyectiles/enemigos

5. **Sistema de Guardado**:
   - Variable `save_slot` definida pero no se ve implementación completa

6. **Sistema de Menú**:
   - Menú de atributos funcional pero podría tener mejor UI
   - Menú principal básico

---

## 📊 Estadísticas del Proyecto

- **Objetos**: ~70+ objetos
- **Salas**: ~17 salas
- **Scripts**: ~20 scripts
- **Sprites**: 500+ sprites
- **Tilesets**: 17 tilesets
- **NPCs**: ~12 NPCs únicos
- **Enemigos**: ~9 tipos de enemigos

---

## 🎮 Mecánicas de Juego

### Controles:
- **WASD**: Movimiento
- **Shift/Q**: Correr (consume stamina)
- **J / Click Izquierdo**: Ataque físico
- **M**: Ataque mágico
- **K**: Bloquear
- **E**: Interactuar
- **Espacio**: Saltar
- **1-4**: Cambiar elemento mágico
- **C**: Menú de atributos
- **Escape**: Cerrar menú

### Progresión:
- Derrotar enemigos otorga XP
- Al subir de nivel se obtienen puntos de atributo
- Los atributos afectan directamente las estadísticas:
  - Vitalidad → HP máximo
  - Inteligencia → Mana máximo
  - Fuerza → Daño
  - Velocidad → Velocidad de movimiento

---

## 🔮 Sistema de Dioses/Panteón

El proyecto incluye un sistema de dioses:
- `scr_gods_data()` - Datos de dioses
- `scr_god_interaction()` - Interacción con dioses
- `global.ActivePantheonBonus` - Bonus activo del panteón

---

## 📝 Notas Técnicas

1. **Versión de GameMaker**: 2022.0.3.85
2. **Lenguaje**: GML (GameMaker Language)
3. **Estructuras de Datos**: Uso extensivo de ds_map, ds_list, ds_queue
4. **Sistema de Capas**: Uso de capas ("Instances", "GUI", etc.)
5. **Sistema de Eventos**: Eventos estándar de GameMaker (Create, Step, Draw, etc.)

---

## 🎯 Conclusión

Este es un **proyecto RPG ambicioso y bien estructurado** con múltiples sistemas interconectados. El código muestra una buena organización y un enfoque modular. El sistema de historia con múltiples rutas es particularmente impresionante, y el combate está bien implementado con feedback visual.

El proyecto parece estar en un estado de desarrollo avanzado, con muchos sistemas funcionales y una base sólida para expandir el contenido del juego.

---

*Análisis generado el: $(date)*

