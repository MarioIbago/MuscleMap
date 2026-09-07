# Primeros pasos con MuscleMap

Añade MuscleMap a tu proyecto y muestra un cuerpo humano interactivo en pocos minutos.

## Descripción general

MuscleMap es un paquete nativo de SwiftUI sin dependencias externas. Es compatible con iOS 17+ y macOS 14+.

## Añadir MuscleMap a tu proyecto

Añade MuscleMap como dependencia de Swift Package desde Xcode:

1. Abre tu proyecto en Xcode.
2. Ve a **File → Add Package Dependencies**.
3. Introduce la URL del repositorio: `https://github.com/MarioIbago/MuscleMap`.
4. Selecciona la versión más reciente y añádela al target correspondiente.

También puedes agregarlo a tu `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/MarioIbago/MuscleMap.git", from: "1.6.4")
]
```

Después añade `MuscleMap` como dependencia de tu target:

```swift
.target(name: "TuApp", dependencies: ["MuscleMap"])
```

## Mostrar un cuerpo

Importa el módulo y usa ``BodyView``:

```swift
import MuscleMap

struct ContentView: View {
    var body: some View {
        BodyView(gender: .male, side: .front)
            .frame(width: 200, height: 400)
    }
}
```

Puedes elegir modelos ``BodyGender/male`` o ``BodyGender/female`` y vistas ``BodySide/front`` o ``BodySide/back``. Aunque los identificadores de la API permanecen en inglés para conservar compatibilidad, los nombres mostrados al usuario se localizan al español.

## Resaltar músculos

Usa el modificador `highlight` para colorear regiones musculares:

```swift
BodyView()
    .highlight(.chest, color: .red)
    .highlight(.biceps, color: .orange, opacity: 0.8)
    .highlight(.abs, color: .yellow, opacity: 0.6)
```

Puedes resaltar varios músculos a la vez:

```swift
BodyView()
    .highlight([.chest, .deltoids, .triceps], color: .blue)
```

En español, `displayName` usa nomenclatura anatómica revisada: `.chest` se muestra como **Pectoral mayor**, `.biceps` como **Bíceps braquial** y `.triceps` como **Tríceps braquial**.

## Gestionar toques

Responde a los toques sobre una región con ``BodyView/onMuscleSelected(_:)``:

```swift
BodyView()
    .onMuscleSelected { muscle, side in
        print("Se tocó \(muscle.displayName) en \(side.displayName)")
    }
```

## Color según intensidad

Usa el modificador `intensities` con una escala de 0 a 4, habitual en registros de entrenamiento:

```swift
BodyView()
    .intensities([
        .chest: 4,
        .biceps: 2,
        .abs: 1,
        .quadriceps: 3
    ])
```

## Siguientes pasos

- Aprende a usar mapas de calor y escalas cromáticas en <doc:HeatmapGuide>.
- Integra MuscleMap en UIKit con <doc:UIKitIntegration>.
