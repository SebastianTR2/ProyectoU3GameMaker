# Sprites del Esqueleto con Espada - Información

## 📋 Sprites Creados

Se han creado los siguientes 4 sprites para el enemigo esqueleto:

### 1. `s_skeleton_idle`
- **Ubicación**: `sprites/s_skeleton_idle/s_skeleton_idle.yy`
- **Uso**: Estado idle (reposo) del esqueleto
- **Dimensiones**: 32x48 píxeles
- **Frames**: 1 frame (puedes agregar más para animación)
- **Origen**: Centro (16, 24)
- **Velocidad de animación**: 10 FPS

**Archivos necesarios:**
- `sprites/s_skeleton_idle/skeleton_idle_frame_0.png` (imagen del esqueleto en reposo)

---

### 2. `s_skeleton_walk`
- **Ubicación**: `sprites/s_skeleton_walk/s_skeleton_walk.yy`
- **Uso**: Estado walk (caminando) del esqueleto
- **Dimensiones**: 32x48 píxeles
- **Frames**: 4 frames (animación de caminata)
- **Origen**: Centro (16, 24)
- **Velocidad de animación**: 8 FPS

**Archivos necesarios:**
- `sprites/s_skeleton_walk/skeleton_walk_frame_0.png` (frame 1 de caminata)
- `sprites/s_skeleton_walk/skeleton_walk_frame_1.png` (frame 2 de caminata)
- `sprites/s_skeleton_walk/skeleton_walk_frame_2.png` (frame 3 de caminata)
- `sprites/s_skeleton_walk/skeleton_walk_frame_3.png` (frame 4 de caminata)

---

### 3. `s_skeleton_attack`
- **Ubicación**: `sprites/s_skeleton_attack/s_skeleton_attack.yy`
- **Uso**: Estado attack (atacando) del esqueleto
- **Dimensiones**: 48x48 píxeles (más ancho para mostrar la espada)
- **Frames**: 3 frames (animación de ataque)
- **Origen**: Centro (24, 24)
- **Velocidad de animación**: 10 FPS

**Archivos necesarios:**
- `sprites/s_skeleton_attack/skeleton_attack_frame_0.png` (frame 1 de ataque - preparación)
- `sprites/s_skeleton_attack/skeleton_attack_frame_1.png` (frame 2 de ataque - golpe)
- `sprites/s_skeleton_attack/skeleton_attack_frame_2.png` (frame 3 de ataque - recuperación)

---

### 4. `s_skeleton_dead`
- **Ubicación**: `sprites/s_skeleton_dead/s_skeleton_dead.yy`
- **Uso**: Estado dead (muerto) del esqueleto
- **Dimensiones**: 32x48 píxeles
- **Frames**: 1 frame (puedes agregar más para animación de muerte)
- **Origen**: Centro (16, 24)
- **Velocidad de animación**: 5 FPS (no se reproduce automáticamente)

**Archivos necesarios:**
- `sprites/s_skeleton_dead/skeleton_dead_frame_0.png` (imagen del esqueleto muerto)

---

## 📁 Estructura de Carpetas

```
sprites/
├── s_skeleton_idle/
│   ├── s_skeleton_idle.yy
│   ├── skeleton_idle_frame_0.png (AGREGAR IMAGEN)
│   └── layers/
│       └── skeleton_idle_frame_0/
│           └── skeleton_idle_layer_0.png (se crea automáticamente)
│
├── s_skeleton_walk/
│   ├── s_skeleton_walk.yy
│   ├── skeleton_walk_frame_0.png (AGREGAR IMAGEN)
│   ├── skeleton_walk_frame_1.png (AGREGAR IMAGEN)
│   ├── skeleton_walk_frame_2.png (AGREGAR IMAGEN)
│   ├── skeleton_walk_frame_3.png (AGREGAR IMAGEN)
│   └── layers/
│       └── [carpetas de frames se crean automáticamente]
│
├── s_skeleton_attack/
│   ├── s_skeleton_attack.yy
│   ├── skeleton_attack_frame_0.png (AGREGAR IMAGEN)
│   ├── skeleton_attack_frame_1.png (AGREGAR IMAGEN)
│   ├── skeleton_attack_frame_2.png (AGREGAR IMAGEN)
│   └── layers/
│       └── [carpetas de frames se crean automáticamente]
│
└── s_skeleton_dead/
    ├── s_skeleton_dead.yy
    ├── skeleton_dead_frame_0.png (AGREGAR IMAGEN)
    └── layers/
        └── skeleton_dead_frame_0/
            └── skeleton_dead_layer_0.png (se crea automáticamente)
```

---

## 🎨 Recomendaciones de Diseño

### `s_skeleton_idle`
- Esqueleto de pie, sosteniendo espada
- Puede tener una ligera animación de respiración (opcional)
- Espada apuntando hacia abajo o al lado

### `s_skeleton_walk`
- 4 frames de animación de caminata
- Movimiento de piernas alternado
- Espada puede balancearse ligeramente
- Frame 1: pierna izquierda adelante
- Frame 2: posición neutral
- Frame 3: pierna derecha adelante
- Frame 4: posición neutral (o repetir frame 2)

### `s_skeleton_attack`
- Frame 1: Esqueleto preparando el ataque (espada levantada)
- Frame 2: Esqueleto golpeando (espada en movimiento, este es el frame de impacto)
- Frame 3: Esqueleto recuperándose (espada bajando)
- El frame 2 debe mostrar la espada extendida hacia el jugador

### `s_skeleton_dead`
- Esqueleto caído o desintegrándose
- Puede ser una sola imagen estática o una animación corta

---

## ✅ Pasos para Agregar las Imágenes

1. **Abre GameMaker Studio**
2. **Navega a cada sprite** en el Resource Tree
3. **Haz clic derecho en cada frame** → "Edit Image"
4. **Importa tu imagen PNG** en cada frame
5. **Ajusta el origen** si es necesario (ya está configurado en el centro)
6. **Verifica las dimensiones**:
   - `s_skeleton_idle`: 32x48
   - `s_skeleton_walk`: 32x48
   - `s_skeleton_attack`: 48x48
   - `s_skeleton_dead`: 32x48

---

## 🔗 Relación con el Código

Estos sprites se usan en `objects/o_enemy_skeleton/Step_0.gml`:

```gml
case "idle":
    sprite_index = s_skeleton_idle;
    break;

case "chase":
    sprite_index = s_skeleton_walk;
    break;

case "attack":
    sprite_index = s_skeleton_attack;
    break;

case "dead":
    sprite_index = s_skeleton_dead;
    break;
```

---

## 📝 Notas

- Los archivos `.yy` ya están creados y configurados
- Solo necesitas agregar las imágenes PNG en cada frame
- GameMaker creará automáticamente las carpetas `layers` cuando importes las imágenes
- El origen (punto de anclaje) está configurado en el centro de cada sprite
- Las dimensiones pueden ajustarse según tus imágenes, pero mantén las proporciones

---

*Archivos creados y listos para recibir las imágenes*


