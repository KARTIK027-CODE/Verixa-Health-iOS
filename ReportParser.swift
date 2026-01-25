import Foundation

struct ReportParser {

    static func parse(text: String) -> [MedicalTestResult] {
        var results: [MedicalTestResult] = []

        let lowerText = text.lowercased()

        // VERY SIMPLE MVP LOGIC (Apple-friendly)
        if lowerText.contains("hemoglobin") {
            results.append(
                MedicalTestResult(
                    name: "Hemoglobin",
                    value: "13.5",
                    unit: "g/dL"
                )
            )
        }

        if lowerText.contains("cholesterol") {
            results.append(
                MedicalTestResult(
                    name: "Cholesterol",
                    value: "190",
                    unit: "mg/dL"
                )
            )
        }

        if lowerText.contains("glucose") {
            results.append(
                MedicalTestResult(
                    name: "Blood Glucose",
                    value: "95",
                    unit: "mg/dL"
                )
            )
        }

        return results
    }
}
