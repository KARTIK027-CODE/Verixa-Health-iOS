import Foundation

struct MedicalTestResult: Identifiable {
    let id = UUID()
    let name: String
    let value: String
    let unit: String
}
