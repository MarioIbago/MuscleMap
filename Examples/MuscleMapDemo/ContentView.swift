import SwiftUI
import MuscleMap

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HighlightDemo()
                .tabItem { Label("Resaltado", systemImage: "figure.stand") }
                .tag(0)

            HeatmapDemo()
                .tabItem { Label("Mapa de calor", systemImage: "flame") }
                .tag(1)

            InteractiveDemo()
                .tabItem { Label("Interactivo", systemImage: "hand.tap") }
                .tag(2)

            StyleDemo()
                .tabItem { Label("Estilos", systemImage: "paintbrush") }
                .tag(3)

            GradientDemo()
                .tabItem { Label("Degradado", systemImage: "paintpalette") }
                .tag(4)

            AnimationDemo()
                .tabItem { Label("Animación", systemImage: "wand.and.stars") }
                .tag(5)

            InteractiveV2Demo()
                .tabItem { Label("Interactivo V2", systemImage: "hand.draw") }
                .tag(6)

            HeatmapV2Demo()
                .tabItem { Label("Mapa V2", systemImage: "chart.bar.fill") }
                .tag(7)

            SubGroupsDemo()
                .tabItem { Label("Subgrupos", systemImage: "rectangle.split.3x3") }
                .tag(8)
        }
    }
}

// MARK: - Demostración de resaltado

struct HighlightDemo: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    Text("Masculino - Anterior y posterior")
                        .font(.headline)

                    HStack(spacing: 16) {
                        BodyView(gender: .male, side: .front)
                            .highlight(.chest, color: .red)
                            .highlight(.biceps, color: .orange, opacity: 0.8)
                            .highlight(.abs, color: .yellow, opacity: 0.6)
                            .highlight(.quadriceps, color: .red)
                            .highlight(.deltoids, color: .orange)
                            .frame(height: 350)

                        BodyView(gender: .male, side: .back)
                            .highlight(.trapezius, color: .orange)
                            .highlight(.upperBack, color: .red)
                            .highlight(.lowerBack, color: .yellow)
                            .highlight(.hamstring, color: .red)
                            .highlight(.gluteal, color: .orange)
                            .frame(height: 350)
                    }
                    .padding(.horizontal)

                    Text("Femenino - Anterior y posterior")
                        .font(.headline)

                    HStack(spacing: 16) {
                        BodyView(gender: .female, side: .front)
                            .highlight(.chest, color: .pink)
                            .highlight(.abs, color: .orange)
                            .highlight(.quadriceps, color: .red)
                            .highlight(.calves, color: .yellow)
                            .frame(height: 350)

                        BodyView(gender: .female, side: .back)
                            .highlight(.gluteal, color: .pink)
                            .highlight(.hamstring, color: .red)
                            .highlight(.upperBack, color: .orange)
                            .frame(height: 350)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Resaltado")
        }
    }
}

// MARK: - Demostración de mapa de calor

struct HeatmapDemo: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    Text("Intensidad de entrenamiento (0-4)")
                        .font(.headline)

                    BodyView(gender: .male, side: .front)
                        .intensities([
                            .chest: 4,
                            .biceps: 3,
                            .abs: 2,
                            .quadriceps: 4,
                            .deltoids: 3,
                            .forearm: 1,
                            .obliques: 2,
                            .triceps: 2
                        ])
                        .frame(height: 400)
                        .padding(.horizontal)

                    Text("Escala térmica")
                        .font(.headline)

                    BodyView(gender: .male, side: .back)
                        .intensities([
                            .trapezius: 3,
                            .upperBack: 4,
                            .lowerBack: 2,
                            .hamstring: 3,
                            .gluteal: 4,
                            .calves: 1,
                            .triceps: 2
                        ], colorScale: .thermal)
                        .frame(height: 400)
                        .padding(.horizontal)

                    Text("Escala médica")
                        .font(.headline)

                    let data: [MuscleIntensity] = [
                        .init(muscle: .chest, intensity: 0.9),
                        .init(muscle: .deltoids, intensity: 0.7),
                        .init(muscle: .biceps, intensity: 0.5),
                        .init(muscle: .abs, intensity: 0.3),
                        .init(muscle: .quadriceps, intensity: 0.6)
                    ]

                    BodyView(gender: .female, side: .front)
                        .heatmap(data, colorScale: .medical)
                        .frame(height: 400)
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Mapa de calor")
        }
    }
}

// MARK: - Demostración interactiva

struct InteractiveDemo: View {
    @State private var selectedMuscle: Muscle?
    @State private var selectedSide: MuscleSide = .both
    @State private var gender: BodyGender = .male
    @State private var bodySide: BodySide = .front

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                HStack {
                    Picker("Sexo", selection: $gender) {
                        Text("Masculino").tag(BodyGender.male)
                        Text("Femenino").tag(BodyGender.female)
                    }
                    .pickerStyle(.segmented)

                    Picker("Vista", selection: $bodySide) {
                        Text("Anterior").tag(BodySide.front)
                        Text("Posterior").tag(BodySide.back)
                    }
                    .pickerStyle(.segmented)
                }
                .padding(.horizontal)

                if let muscle = selectedMuscle {
                    HStack {
                        Image(systemName: "figure.stand")
                        Text("\(muscle.displayName) (\(selectedSide.displayName))")
                            .font(.title3.bold())
                    }
                    .padding(8)
                    .background(.green.opacity(0.15), in: RoundedRectangle(cornerRadius: 8))
                } else {
                    Text("Toca una región muscular")
                        .foregroundStyle(.secondary)
                }

                BodyView(gender: gender, side: bodySide)
                    .selected(selectedMuscle)
                    .pulseSelected()
                    .onMuscleSelected { muscle, side in
                        selectedMuscle = muscle
                        selectedSide = side
                    }
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal)
            }
            .padding(.vertical)
            .navigationTitle("Interactivo")
        }
    }
}

// MARK: - Demostración de estilos

struct StyleDemo: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    styleCard("Predeterminado", style: .default)
                    styleCard("Minimalista", style: .minimal)
                    styleCard("Neón", style: .neon, background: .black)
                    styleCard("Médico", style: .medical)
                }
                .padding()
            }
            .navigationTitle("Estilos")
        }
    }

    @ViewBuilder
    func styleCard(_ name: String, style: BodyViewStyle, background: Color = .clear) -> some View {
        VStack {
            Text(name)
                .font(.headline)

            BodyView(gender: .male, side: .front)
                .highlight(.chest, color: .red)
                .highlight(.biceps, color: .orange)
                .highlight(.quadriceps, color: .red)
                .bodyStyle(style)
                .frame(height: 300)
                .padding()
                .background(background, in: RoundedRectangle(cornerRadius: 12))
        }
    }
}

// MARK: - Demostración de degradados

struct GradientDemo: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    Text("Degradado lineal")
                        .font(.headline)

                    BodyView(gender: .male, side: .front)
                        .highlight(.chest, linearGradient: [.red, .orange], startPoint: .top, endPoint: .bottom)
                        .highlight(.biceps, linearGradient: [.blue, .cyan], startPoint: .leading, endPoint: .trailing)
                        .highlight(.abs, linearGradient: [.yellow, .orange, .red], startPoint: .top, endPoint: .bottom)
                        .highlight(.quadriceps, linearGradient: [.purple, .pink])
                        .frame(height: 400)
                        .padding(.horizontal)

                    Text("Degradado radial")
                        .font(.headline)

                    BodyView(gender: .male, side: .front)
                        .highlight(.chest, radialGradient: [.white, .red], center: .center, endRadius: 40)
                        .highlight(.biceps, radialGradient: [.white, .blue], center: .center, endRadius: 30)
                        .highlight(.deltoids, radialGradient: [.yellow, .orange], center: .center, endRadius: 25)
                        .frame(height: 400)
                        .padding(.horizontal)

                    Text("Rellenos combinados")
                        .font(.headline)

                    BodyView(gender: .female, side: .front)
                        .highlight(.chest, linearGradient: [.pink, .red])
                        .highlight(.abs, color: .orange, opacity: 0.7)
                        .highlight(.quadriceps, radialGradient: [.white, .purple], center: .center, endRadius: 50)
                        .frame(height: 400)
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Degradado")
        }
    }
}

// MARK: - Demostración de animaciones

struct AnimationDemo: View {
    @State private var showUpperBody = true
    @State private var selectedMuscle: Muscle?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    Text("Transiciones animadas")
                        .font(.headline)

                    Button(showUpperBody ? "Mostrar tren inferior" : "Mostrar tren superior") {
                        showUpperBody.toggle()
                    }
                    .buttonStyle(.borderedProminent)

                    animatedBodyView
                        .frame(height: 400)
                        .padding(.horizontal)

                    Text("Animación de pulso")
                        .font(.headline)

                    Text("Toca una región muscular para ver el efecto de pulso")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    BodyView(gender: .male, side: .front)
                        .highlight(.chest, linearGradient: [.red, .orange])
                        .highlight(.biceps, color: .blue)
                        .highlight(.quadriceps, color: .purple)
                        .selected(selectedMuscle)
                        .pulseSelected(speed: 1.5, range: 0.6...1.0)
                        .onMuscleSelected { muscle, _ in
                            selectedMuscle = muscle
                        }
                        .frame(height: 400)
                        .padding(.horizontal)

                    Text("Sombra + estilo neón")
                        .font(.headline)

                    BodyView(gender: .male, side: .front)
                        .highlight(.chest, linearGradient: [.cyan, .blue])
                        .highlight(.biceps, color: .cyan)
                        .highlight(.quadriceps, linearGradient: [.cyan, .teal])
                        .bodyStyle(.neon)
                        .frame(height: 400)
                        .padding(.horizontal)
                        .background(.black, in: RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Animación")
        }
    }

    @ViewBuilder
    private var animatedBodyView: some View {
        if showUpperBody {
            BodyView(gender: .male, side: .front)
                .highlight(.chest, color: .red)
                .highlight(.biceps, color: .orange)
                .highlight(.deltoids, color: .yellow)
                .highlight(.abs, color: .red, opacity: 0.6)
                .animated(duration: 0.5)
        } else {
            BodyView(gender: .male, side: .front)
                .highlight(.quadriceps, color: .blue)
                .highlight(.calves, color: .cyan)
                .highlight(.hamstring, color: .purple)
                .animated(duration: 0.5)
        }
    }
}

// MARK: - Demostración interactiva V2

struct InteractiveV2Demo: View {
    @State private var selectedMuscles: Set<Muscle> = []
    @State private var lastSide: MuscleSide = .both
    @State private var longPressedMuscle: String = ""
    @State private var history = SelectionHistory()

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {
                HStack {
                    if selectedMuscles.isEmpty {
                        Text("Toca para seleccionar, mantén presionado para información y arrastra para pintar")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    } else {
                        Text(selectedMuscles.map(\.displayName).sorted().joined(separator: ", "))
                            .font(.caption.bold())
                            .lineLimit(2)
                    }
                    Spacer()
                    Button("Deshacer") {
                        if let state = history.undo() {
                            selectedMuscles = state
                        }
                    }
                    .disabled(!history.canUndo)

                    Button("Rehacer") {
                        if let state = history.redo() {
                            selectedMuscles = state
                        }
                    }
                    .disabled(!history.canRedo)
                }
                .padding(.horizontal)

                if !longPressedMuscle.isEmpty {
                    Text(longPressedMuscle)
                        .font(.footnote)
                        .padding(6)
                        .background(.blue.opacity(0.15), in: RoundedRectangle(cornerRadius: 6))
                        .transition(.opacity)
                }

                BodyView(gender: .male, side: .front)
                    .highlight(Array(selectedMuscles), color: .orange)
                    .selected(selectedMuscles)
                    .pulseSelected(speed: 1.5, range: 0.7...1.0)
                    .onMuscleSelected { muscle, side in
                        var newSelection = selectedMuscles
                        if newSelection.contains(muscle) {
                            newSelection.remove(muscle)
                        } else {
                            newSelection.insert(muscle)
                        }
                        selectedMuscles = newSelection
                        lastSide = side
                        history.push(newSelection)
                    }
                    .onMuscleLongPressed(duration: 0.5) { muscle, side in
                        withAnimation {
                            longPressedMuscle = "Pulsación prolongada: \(muscle.displayName) (\(side.displayName))"
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation { longPressedMuscle = "" }
                        }
                    }
                    .onMuscleDragged({ muscle, side in
                        if !selectedMuscles.contains(muscle) {
                            selectedMuscles.insert(muscle)
                            history.push(selectedMuscles)
                        }
                    }, onEnded: {})
                    .zoomable(minScale: 1.0, maxScale: 3.0)
                    .tooltip { muscle, _ in
                        Text(muscle.displayName)
                            .font(.caption2.bold())
                            .padding(4)
                            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 4))
                    }
                    .undoable(history)
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal)

                Button("Limpiar selección") {
                    selectedMuscles.removeAll()
                    history.push(selectedMuscles)
                }
                .buttonStyle(.bordered)
                .disabled(selectedMuscles.isEmpty)
            }
            .padding(.vertical)
            .navigationTitle("Interactivo V2")
        }
    }
}

// MARK: - Demostración de mapa de calor V2

struct HeatmapV2Demo: View {
    @State private var threshold: Double = 0.0
    @State private var useGradientFill = false
    @State private var showAnimated = false
    @State private var interpolation: InterpolationChoice = .linear

    enum InterpolationChoice: String, CaseIterable {
        case linear = "Lineal"
        case easeIn = "Entrada suave"
        case easeOut = "Salida suave"
        case easeInOut = "Entrada y salida"
        case stepped = "Por niveles"

        var value: ColorInterpolation {
            switch self {
            case .linear: return .linear
            case .easeIn: return .easeIn
            case .easeOut: return .easeOut
            case .easeInOut: return .easeInOut
            case .stepped: return .step(count: 5)
            }
        }
    }

    private var upperBodyData: [MuscleIntensity] {
        [
            .init(muscle: .chest, intensity: 0.9),
            .init(muscle: .deltoids, intensity: 0.7),
            .init(muscle: .biceps, intensity: 0.5),
            .init(muscle: .abs, intensity: 0.3),
            .init(muscle: .obliques, intensity: 0.15),
            .init(muscle: .forearm, intensity: 0.4),
            .init(muscle: .quadriceps, intensity: 0.6),
            .init(muscle: .triceps, intensity: 0.2)
        ]
    }

    private var lowerBodyData: [MuscleIntensity] {
        [
            .init(muscle: .quadriceps, intensity: 0.9),
            .init(muscle: .calves, intensity: 0.7),
            .init(muscle: .abs, intensity: 0.2),
            .init(muscle: .chest, intensity: 0.1),
            .init(muscle: .obliques, intensity: 0.4),
            .init(muscle: .adductors, intensity: 0.6)
        ]
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    GroupBox("Configuración") {
                        VStack(spacing: 12) {
                            Picker("Interpolación", selection: $interpolation) {
                                ForEach(InterpolationChoice.allCases, id: \.self) { choice in
                                    Text(choice.rawValue).tag(choice)
                                }
                            }
                            .pickerStyle(.segmented)

                            HStack {
                                Text("Umbral: \(threshold, specifier: "%.2f")")
                                Slider(value: $threshold, in: 0...0.5, step: 0.05)
                            }

                            Toggle("Relleno con degradado", isOn: $useGradientFill)
                        }
                    }
                    .padding(.horizontal)

                    Button(showAnimated ? "Mostrar tren superior" : "Mostrar tren inferior") {
                        showAnimated.toggle()
                    }
                    .buttonStyle(.borderedProminent)

                    HStack(alignment: .top, spacing: 8) {
                        bodyView
                            .frame(height: 420)

                        HeatmapLegendView(
                            colorScale: .thermal,
                            interpolation: interpolation.value,
                            orientation: .vertical,
                            barThickness: 14,
                            labelMin: "Reposo",
                            labelMax: "Máx."
                        )
                        .frame(width: 50, height: 200)
                        .padding(.top, 100)
                    }
                    .padding(.horizontal)

                    HeatmapLegendView(
                        colorScale: .thermal,
                        interpolation: interpolation.value,
                        labelMin: "Baja",
                        labelMax: "Alta"
                    )
                    .frame(width: 250)
                    .padding(.horizontal)

                    GroupBox("Preajuste por niveles") {
                        BodyView(gender: .female, side: .front)
                            .heatmap(upperBodyData, colorScale: .workoutStepped)
                            .frame(height: 350)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Mapa de calor V2")
        }
    }

    @ViewBuilder
    private var bodyView: some View {
        let data = showAnimated ? lowerBodyData : upperBodyData
        let config = HeatmapConfiguration(
            colorScale: .thermal,
            interpolation: interpolation.value,
            threshold: threshold > 0 ? threshold : nil,
            isGradientFillEnabled: useGradientFill,
            gradientDirection: .topToBottom,
            gradientLowIntensityFactor: 0.3
        )

        BodyView(gender: .male, side: .front)
            .heatmap(data, configuration: config)
            .animated(duration: 0.5)
    }
}

// MARK: - Demostración de subgrupos

struct SubGroupsDemo: View {
    @State private var selectedMuscle: Muscle?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    Text("Subgrupos musculares")
                        .font(.headline)

                    Text("Los subgrupos heredan el resaltado del grupo padre. Toca una región para comprobar la prioridad de selección.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)

                    HStack(spacing: 16) {
                        BodyView(gender: .male, side: .front)
                            .highlight(.chest, color: .red, opacity: 0.4)
                            .highlight(.upperChest, color: .red, opacity: 0.9)
                            .highlight(.quadriceps, color: .blue, opacity: 0.4)
                            .highlight(.innerQuad, color: .blue, opacity: 0.9)
                            .highlight(.abs, color: .orange, opacity: 0.4)
                            .highlight(.upperAbs, color: .orange, opacity: 0.9)
                            .highlight(.deltoids, color: .purple, opacity: 0.4)
                            .highlight(.frontDeltoid, color: .purple, opacity: 0.9)
                            .selected(selectedMuscle)
                            .onMuscleSelected { muscle, _ in
                                selectedMuscle = muscle
                            }
                            .frame(height: 350)

                        BodyView(gender: .male, side: .back)
                            .highlight(.trapezius, color: .green, opacity: 0.4)
                            .highlight(.upperTrapezius, color: .green, opacity: 0.9)
                            .highlight(.lowerTrapezius, color: .teal, opacity: 0.9)
                            .highlight(.deltoids, color: .purple, opacity: 0.4)
                            .highlight(.rearDeltoid, color: .purple, opacity: 0.9)
                            .highlight(.rhomboids, color: .orange)
                            .highlight(.rotatorCuff, color: .cyan)
                            .selected(selectedMuscle)
                            .onMuscleSelected { muscle, _ in
                                selectedMuscle = muscle
                            }
                            .frame(height: 350)
                    }
                    .padding(.horizontal)

                    if let muscle = selectedMuscle {
                        VStack(spacing: 4) {
                            Text(muscle.displayName)
                                .font(.title3.bold())
                            if muscle.isSubGroup, let parent = muscle.parentGroup {
                                Text("Subgrupo de \(parent.displayName)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            if !muscle.subGroups.isEmpty {
                                Text("Subgrupos: \(muscle.subGroups.map(\.displayName).joined(separator: ", "))")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
            .navigationTitle("Subgrupos")
        }
    }
}

#Preview {
    ContentView()
}
