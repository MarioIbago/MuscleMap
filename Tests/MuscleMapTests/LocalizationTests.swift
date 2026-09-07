import XCTest
@testable import MuscleMap

final class LocalizationTests: XCTestCase {

    func testTodosLosNombresMuscularesNoEstanVacios() {
        for muscle in Muscle.allCases {
            XCTAssertFalse(muscle.displayName.isEmpty, "\(muscle) tiene displayName vacío")
        }
    }

    func testDisplayNameNoDevuelveLaClaveCruda() {
        for muscle in Muscle.allCases {
            XCTAssertFalse(
                muscle.displayName.hasPrefix("muscle."),
                "\(muscle) devolvió la clave sin localizar: \(muscle.displayName)"
            )
        }
    }

    func testNombresAnatomicosPredeterminadosEnEspanol() {
        XCTAssertEqual(Muscle.abs.displayName, "Recto del abdomen")
        XCTAssertEqual(Muscle.chest.displayName, "Pectoral mayor")
        XCTAssertEqual(Muscle.biceps.displayName, "Bíceps braquial")
        XCTAssertEqual(Muscle.triceps.displayName, "Tríceps braquial")
        XCTAssertEqual(Muscle.lowerBack.displayName, "Región lumbar")
        XCTAssertEqual(Muscle.upperBack.displayName, "Región dorsal superior")
        XCTAssertEqual(Muscle.quadriceps.displayName, "Cuádriceps femoral")
        XCTAssertEqual(Muscle.tibialis.displayName, "Tibial anterior")
        XCTAssertEqual(Muscle.rotatorCuff.displayName, "Manguito rotador")
        XCTAssertEqual(Muscle.hipFlexors.displayName, "Flexores de la cadera")
        XCTAssertEqual(Muscle.serratus.displayName, "Serrato anterior")
        XCTAssertEqual(Muscle.rhomboids.displayName, "Romboides mayor y menor")
        XCTAssertEqual(Muscle.upperChest.displayName, "Cabeza clavicular del pectoral mayor")
        XCTAssertEqual(Muscle.lowerChest.displayName, "Cabeza esternocostal del pectoral mayor")
        XCTAssertEqual(Muscle.innerQuad.displayName, "Vasto medial")
        XCTAssertEqual(Muscle.outerQuad.displayName, "Vasto lateral")
        XCTAssertEqual(Muscle.frontDeltoid.displayName, "Porción anterior del deltoides")
    }

    func testNombreDeLadoMuscular() {
        XCTAssertEqual(MuscleSide.left.displayName, "Izquierda")
        XCTAssertEqual(MuscleSide.right.displayName, "Derecha")
        XCTAssertEqual(MuscleSide.both.displayName, "Ambos lados")
    }

    func testNombreDeVistaCorporal() {
        XCTAssertEqual(BodySide.front.displayName, "Anterior")
        XCTAssertEqual(BodySide.back.displayName, "Posterior")
    }

    func testNombreDeSexoCorporal() {
        XCTAssertEqual(BodyGender.male.displayName, "Masculino")
        XCTAssertEqual(BodyGender.female.displayName, "Femenino")
    }
}
