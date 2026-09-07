# MuscleMap

SDK nativo de SwiftUI para renderizar mapas musculares interactivos del cuerpo humano con resaltado, mapas de calor, selección múltiple, zoom, gestos e integración con UIKit.

Admite modelos corporales **masculino y femenino**, con vistas **anterior y posterior**, y funciona tanto con **SwiftUI** como con **UIKit**.

> **Español como idioma predeterminado.** Los identificadores de la API (`.chest`, `.biceps`, `.quadriceps`, etc.) permanecen en inglés para conservar compatibilidad con proyectos existentes. Los nombres que se muestran al usuario mediante `displayName` están localizados al español y utilizan nomenclatura anatómica revisada con *Moore, Anatomía con orientación clínica, 9.ª edición*.

<p align="center">
  <img src="https://raw.githubusercontent.com/MarioIbago/MuscleMap/main/Screenshots/male_front_highlight.png" width="180" alt="Modelo masculino, vista anterior">
  <img src="https://raw.githubusercontent.com/MarioIbago/MuscleMap/main/Screenshots/male_back_highlight.png" width="180" alt="Modelo masculino, vista posterior">
  <img src="https://raw.githubusercontent.com/MarioIbago/MuscleMap/main/Screenshots/female_front_highlight.png" width="180" alt="Modelo femenino, vista anterior">
  <img src="https://raw.githubusercontent.com/MarioIbago/MuscleMap/main/Screenshots/female_back_highlight.png" width="180" alt="Modelo femenino, vista posterior">
</p>

## Características

- Renderizado corporal basado en SVG mediante `Canvas` de SwiftUI.
- **36 regiones musculares**: 22 grupos base y 14 subgrupos.
- Detección de lado izquierdo, derecho o ambos.
- Subgrupos musculares con relación padre/hijo y prioridad en la detección de toques.
- Subgrupos siempre visibles para regiones como tobillos, aductores y cuello.
- Mapas de calor con escalas de color configurables.
- Selección por toque y detección precisa de regiones.
- **Selección múltiple** de músculos.
- **Pulsación prolongada** con duración configurable.
- **Selección por arrastre**, como si se pintaran las regiones.
- **Zoom con gesto de pellizco y desplazamiento**, con doble toque para restablecer.
- **Tooltips** personalizados sobre músculos seleccionados.
- **Deshacer/rehacer** mediante historial de selección.
- Cuatro estilos incluidos: predeterminado, minimalista, neón y médico.
- Rellenos con degradado lineal y radial.
- Animaciones de transición al cambiar los resaltados.
- Animación de pulso/brillo para la selección.
- Sombras y sombras proyectadas.
- Contenedores para UIKit: `MuscleMapView` y `HeatmapLegendUIView`.
- Accesibilidad con VoiceOver y nombres musculares localizados.
- Localización para 11 idiomas; **español como idioma predeterminado**.
- Catálogo de documentación DocC en español.
- Sin dependencias externas.
- iOS 17+ y macOS 14+.

## Instalación

### Swift Package Manager

Añade el paquete a tu `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/MarioIbago/MuscleMap.git", from: "1.6.4")
]
```

O en Xcode usa **File → Add Package Dependencies** y pega:

```text
https://github.com/MarioIbago/MuscleMap
```

### CocoaPods

Añade al `Podfile`:

```ruby
pod 'MuscleMap', '~> 1.6.4'
```

Después ejecuta:

```bash
pod install
```

## Inicio rápido

```swift
import SwiftUI
import MuscleMap

struct ContentView: View {
    var body: some View {
        BodyView(gender: .male, side: .front)
            .highlight(.chest, color: .red)
            .highlight(.biceps, color: .orange, opacity: 0.8)
            .frame(height: 400)
    }
}
```

Aunque el código usa `.chest` y `.biceps`, la interfaz en español muestra **Pectoral mayor** y **Bíceps braquial**.

## Uso

### Resaltado básico

```swift
BodyView(gender: .male, side: .front)
    .highlight(.chest, color: .red)
    .highlight(.abs, color: .yellow, opacity: 0.6)
    .highlight([.quadriceps, .calves], color: .orange)
```

### Resaltado con degradado

<p align="center">
  <img src="https://raw.githubusercontent.com/MarioIbago/MuscleMap/main/Screenshots/gradient_linear.png" width="180" alt="Degradado lineal">
  <img src="https://raw.githubusercontent.com/MarioIbago/MuscleMap/main/Screenshots/gradient_radial.png" width="180" alt="Degradado radial">
  <img src="https://raw.githubusercontent.com/MarioIbago/MuscleMap/main/Screenshots/gradient_neon.png" width="180" alt="Degradado neón">
</p>

```swift
// Degradado lineal, de arriba hacia abajo
BodyView(gender: .male, side: .front)
    .highlight(
        .chest,
        linearGradient: [.red, .orange],
        startPoint: .top,
        endPoint: .bottom
    )

// Degradado radial, desde el centro
    .highlight(
        .biceps,
        radialGradient: [.white, .blue],
        center: .center,
        endRadius: 40
    )

// Se pueden combinar degradados y colores sólidos
    .highlight(.quadriceps, color: .purple)
```

### Detectar toques

```swift
BodyView(gender: .female, side: .front)
    .onMuscleSelected { muscle, side in
        print("\(muscle.displayName) — \(side.displayName)")
    }
```

### Mapa de calor

<p align="center">
  <img src="https://raw.githubusercontent.com/MarioIbago/MuscleMap/main/Screenshots/heatmap_workout.png" width="200" alt="Mapa de calor de entrenamiento">
  <img src="https://raw.githubusercontent.com/MarioIbago/MuscleMap/main/Screenshots/heatmap_thermal.png" width="200" alt="Mapa de calor térmico">
</p>

Escala entera de 0 a 4:

```swift
BodyView(gender: .male, side: .front)
    .intensities([
        .chest: 3,
        .biceps: 2,
        .quadriceps: 4,
        .abs: 1
    ])
```

Datos normalizados de 0.0 a 1.0:

```swift
let data = [
    MuscleIntensity(muscle: .chest, intensity: 0.8),
    MuscleIntensity(muscle: .biceps, intensity: 0.5, side: .left),
    MuscleIntensity(muscle: .abs, intensity: 0.3, color: .purple)
]

BodyView(gender: .male, side: .front)
    .heatmap(data, colorScale: .thermal)
```

### Escalas de color

| Escala | Colores |
|---|---|
| `.workout` | gris → amarillo → naranja → rojo |
| `.thermal` | azul → verde → amarillo → rojo |
| `.medical` | verde → amarillo → rojo |
| `.monochrome` | gris claro → oscuro |
| `.workoutStepped` | entrenamiento en 5 niveles discretos |
| `.thermalSmooth` | térmica con curva suave |

Escala personalizada:

```swift
let custom = HeatmapColorScale(colors: [.blue, .purple, .pink])
```

### Interpolación del color

```swift
BodyView(gender: .male, side: .front)
    .heatmap(data, colorScale: .thermal)
    .heatmapInterpolation(.easeInOut)
```

Modos disponibles: `.linear`, `.easeIn`, `.easeOut`, `.easeInOut`, `.step(count:)` y `.custom()`.

### Umbral del mapa de calor

```swift
BodyView(gender: .male, side: .front)
    .heatmap(data)
    .heatmapThreshold(0.2) // oculta regiones con intensidad < 0.2
```

### Degradado dentro del mapa de calor

```swift
BodyView(gender: .male, side: .front)
    .heatmap(data, colorScale: .thermal)
    .heatmapGradient(direction: .topToBottom, lowFactor: 0.3)
```

Direcciones: `.topToBottom`, `.bottomToTop`, `.leftToRight`, `.rightToLeft`.

### Configuración completa del mapa de calor

```swift
let config = HeatmapConfiguration(
    colorScale: .thermal,
    interpolation: .easeInOut,
    threshold: 0.2,
    isGradientFillEnabled: true,
    gradientDirection: .topToBottom,
    gradientLowIntensityFactor: 0.3
)

BodyView(gender: .male, side: .front)
    .heatmap(data, configuration: config)
```

### Leyenda

```swift
HeatmapLegendView(
    colorScale: .thermal,
    interpolation: .easeInOut,
    orientation: .vertical,
    barThickness: 20,
    labelMin: "Reposo",
    labelMax: "Máxima"
)
.frame(width: 60, height: 200)
```

### Animación de transiciones

```swift
BodyView(gender: .male, side: .front)
    .heatmap(currentData, colorScale: .thermal)
    .animated(duration: 0.5)
```

### Estilos

<p align="center">
  <img src="https://raw.githubusercontent.com/MarioIbago/MuscleMap/main/Screenshots/style_neon.png" width="200" alt="Estilo neón">
  <img src="https://raw.githubusercontent.com/MarioIbago/MuscleMap/main/Screenshots/style_medical.png" width="200" alt="Estilo médico">
</p>

```swift
BodyView(gender: .male, side: .front)
    .bodyStyle(.neon)
```

| Estilo | Descripción |
|---|---|
| `.default` | relleno gris y selección verde |
| `.minimal` | relleno sutil y trazos finos |
| `.neon` | fondo oscuro, selección cian y brillo |
| `.medical` | tonos clínicos azul-gris |

También puedes crear un `BodyViewStyle` personalizado.

### Animación de pulso

```swift
@State private var selected: Muscle?

BodyView(gender: .male, side: .front)
    .highlight(.chest, color: .red)
    .selected(selected)
    .pulseSelected(speed: 1.5, range: 0.6...1.0)
    .onMuscleSelected { muscle, _ in
        selected = muscle
    }
```

### Selección múltiple

```swift
@State private var selectedMuscles: Set<Muscle> = []

BodyView(gender: .male, side: .front)
    .selected(selectedMuscles)
    .onMuscleSelected { muscle, _ in
        if selectedMuscles.contains(muscle) {
            selectedMuscles.remove(muscle)
        } else {
            selectedMuscles.insert(muscle)
        }
    }
```

### Pulsación prolongada

```swift
BodyView(gender: .male, side: .front)
    .onMuscleLongPressed(duration: 0.5) { muscle, side in
        print("Pulsación prolongada: \(muscle.displayName)")
    }
```

### Selección por arrastre

```swift
BodyView(gender: .male, side: .front)
    .onMuscleDragged({ muscle, side in
        selectedMuscles.insert(muscle)
    }, onEnded: {
        print("Arrastre terminado")
    })
```

### Zoom

```swift
BodyView(gender: .male, side: .front)
    .zoomable(minScale: 1.0, maxScale: 4.0)
```

### Tooltips

```swift
BodyView(gender: .male, side: .front)
    .selected(selectedMuscles)
    .tooltip { muscle, side in
        Text(muscle.displayName)
            .font(.caption)
            .padding(4)
            .background(.ultraThinMaterial)
    }
```

### Deshacer y rehacer

```swift
@State private var history = SelectionHistory()

BodyView(gender: .male, side: .front)
    .undoable(history)

Button("Deshacer") {
    if let state = history.undo() { selectedMuscles = state }
}

Button("Rehacer") {
    if let state = history.redo() { selectedMuscles = state }
}
```

## Subgrupos musculares

Los subgrupos permiten trabajar con regiones más específicas. Heredan el resaltado del grupo padre cuando no tienen uno propio y tienen prioridad en la detección de toques.

```swift
BodyView(gender: .male, side: .front)
    .highlight(.chest, color: .red, opacity: 0.4)
    .highlight(.upperChest, color: .red, opacity: 0.9)
    .highlight(.quadriceps, color: .blue, opacity: 0.4)
    .highlight(.innerQuad, color: .blue, opacity: 0.9)
```

Relaciones entre grupos:

```swift
Muscle.chest.subGroups
Muscle.upperChest.parentGroup
Muscle.upperChest.isSubGroup
Muscle.ankles.isAlwaysVisibleSubGroup
```

## Sexo y orientación corporal

```swift
BodyView(gender: .male, side: .front)   // Masculino, anterior
BodyView(gender: .male, side: .back)    // Masculino, posterior
BodyView(gender: .female, side: .front) // Femenino, anterior
BodyView(gender: .female, side: .back)  // Femenino, posterior
```

## Nomenclatura anatómica en español

La siguiente tabla muestra la etiqueta visible en español. Las claves de la API no se renombraron para evitar cambios incompatibles.

| Clave Swift | Nombre visible en español |
|---|---|
| `.abs` | Recto del abdomen |
| `.biceps` | Bíceps braquial |
| `.calves` | Gastrocnemio y sóleo |
| `.chest` | Pectoral mayor |
| `.deltoids` | Deltoides |
| `.feet` | Pies |
| `.forearm` | Músculos del antebrazo |
| `.gluteal` | Músculos glúteos |
| `.hamstring` | Músculos isquiotibiales |
| `.hands` | Manos |
| `.head` | Cabeza |
| `.knees` | Rodillas |
| `.lowerBack` | Región lumbar |
| `.obliques` | Oblicuos del abdomen |
| `.quadriceps` | Cuádriceps femoral |
| `.rhomboids` | Romboides mayor y menor |
| `.rotatorCuff` | Manguito rotador |
| `.serratus` | Serrato anterior |
| `.tibialis` | Tibial anterior |
| `.trapezius` | Trapecio |
| `.triceps` | Tríceps braquial |
| `.upperBack` | Región dorsal superior |
| `.adductors` | Músculos aductores del muslo |
| `.ankles` | Tobillos |
| `.neck` | Cuello |
| `.hipFlexors` | Flexores de la cadera |
| `.upperChest` | Cabeza clavicular del pectoral mayor |
| `.lowerChest` | Cabeza esternocostal del pectoral mayor |
| `.innerQuad` | Vasto medial |
| `.outerQuad` | Vasto lateral |
| `.upperAbs` | Porción superior del recto del abdomen |
| `.lowerAbs` | Porción inferior del recto del abdomen |
| `.frontDeltoid` | Porción anterior del deltoides |
| `.rearDeltoid` | Porción posterior del deltoides |
| `.upperTrapezius` | Fibras superiores del trapecio |
| `.lowerTrapezius` | Fibras inferiores del trapecio |

> Algunas claves representan **regiones de la ilustración** y no músculos anatómicos independientes. Por ejemplo, `upperAbs` y `lowerAbs` son subdivisiones gráficas del recto del abdomen; no se presentan como músculos distintos.

## Localización

MuscleMap incluye recursos para español, inglés, turco, alemán, francés, japonés, chino simplificado, coreano, árabe, portugués de Brasil y ruso.

El español es la localización predeterminada del paquete. Para mostrar un nombre nunca construyas la etiqueta a partir del `rawValue`; usa:

```swift
Text(muscle.displayName)
```

## UIKit

```swift
let muscleMap = MuscleMapView(gender: .male, side: .front)
muscleMap.highlight(.chest, color: .systemRed)

muscleMap.onMuscleSelected = { muscle, side in
    print("Seleccionado: \(muscle.displayName)")
}
```

También está disponible `HeatmapLegendUIView`.

## Compatibilidad

- Swift 5.9+
- iOS 17+
- macOS 14+
- SwiftUI
- UIKit mediante contenedores incluidos
- Swift Package Manager
- CocoaPods

## Fuente anatómica de la nomenclatura española

La nomenclatura visible en español se revisó utilizando como referencia *Moore, Anatomía con orientación clínica, 9.ª edición*. Se usa como referencia terminológica; el SDK no reproduce contenido del libro.

## Licencia

MuscleMap se distribuye bajo la licencia MIT. Consulta `LICENSE` para el texto legal original.
