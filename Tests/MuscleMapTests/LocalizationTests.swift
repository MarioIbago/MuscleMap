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

    func testNomenclaturaAnatomicaEspanola() throws {
        let resourceURL = try XCTUnwrap(Bundle.module.url(forResource: "es", withExtension: "lproj"))
        let spanishBundle = try XCTUnwrap(Bundle(url: resourceURL))

        func es(_ key: String) -> String {
            spanishBundle.localizedString(forKey: key, value: nil, table: "Localizable")
        }

        XCTAssertEqual(es("muscle.abs"), "Recto del abdomen")
        XCTAssertEqual(es("muscle.chest"), "Pectoral mayor")
        XCTAssertEqual(es("muscle.biceps"), "Bíceps braquial")
        XCTAssertEqual(es("muscle.triceps"), "Tríceps braquial")
        XCTAssertEqual(es("muscle.lowerBack"), "Región lumbar")
        XCTAssertEqual(es("muscle.upperBack"), "Región dorsal superior")
        XCTAssertEqual(es("muscle.quadriceps"), "Cuádriceps femoral")
        XCTAssertEqual(es("muscle.tibialis"), "Tibial anterior")
        XCTAssertEqual(es("muscle.rotatorCuff"), "Manguito rotador")
        XCTAssertEqual(es("muscle.hipFlexors"), "Flexores de la cadera")
        XCTAssertEqual(es("muscle.serratus"), "Serrato anterior")
        XCTAssertEqual(es("muscle.rhomboids"), "Romboides mayor y menor")
        XCTAssertEqual(es("muscle.upperChest"), "Cabeza clavicular del pectoral mayor")
        XCTAssertEqual(es("muscle.lowerChest"), "Cabeza esternocostal del pectoral mayor")
        XCTAssertEqual(es("muscle.innerQuad"), "Vasto medial")
        XCTAssertEqual(es("muscle.outerQuad"), "Vasto lateral")
        XCTAssertEqual(es("muscle.frontDeltoid"), "Porción anterior del deltoides")
        XCTAssertEqual(es("muscle.rearDeltoid"), "Porción posterior del deltoides")
    }

    func testEtiquetasEspanolasDeOrientacionYLado() throws {
        let resourceURL = try XCTUnwrap(Bundle.module.url(forResource: "es", withExtension: "lproj"))
        let spanishBundle = try XCTUnwrap(Bundle(url: resourceURL))

        func es(_ key: String) -> String {
            spanishBundle.localizedString(forKey: key, value: nil, table: "Localizable")
        }

        XCTAssertEqual(es("side.left"), "Izquierda")
        XCTAssertEqual(es("side.right"), "Derecha")
        XCTAssertEqual(es("side.both"), "Ambos lados")
        XCTAssertEqual(es("bodySide.front"), "Anterior")
        XCTAssertEqual(es("bodySide.back"), "Posterior")
        XCTAssertEqual(es("gender.male"), "Masculino")
        XCTAssertEqual(es("gender.female"), "Femenino")
    }
}
