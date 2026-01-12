//
//  ReportVerifier.swift
//  Verixa Health
//
//  Created by kartik choudhary  on 12/01/26.
//

struct ReportVerifier {

    static func verify(report: MedicalReport) -> VerificationResult {
        var missingFields: [String] = []

        if report.patientName?.isEmpty ?? true {
            missingFields.append("Patient Name")
        }

        if report.doctorName?.isEmpty ?? true {
            missingFields.append("Doctor Name")
        }

        if report.hospitalName?.isEmpty ?? true {
            missingFields.append("Hospital / Lab Name")
        }

        if report.reportDate == nil {
            missingFields.append("Report Date")
        }

        // CASE 1: Everything present
        if missingFields.isEmpty {
            return VerificationResult(
                status: .verified,
                missingFields: [],
                message: "Report verified successfully."
            )
        }

        // CASE 2: Missing critical fields
        if missingFields.count <= 2 {
            return VerificationResult(
                status: .incomplete,
                missingFields: missingFields,
                message: "Report is incomplete. Some information is missing."
            )
        }

        // CASE 3: Too many missing fields → suspicious
        return VerificationResult(
            status: .suspicious,
            missingFields: missingFields,
            message: "Report appears suspicious due to missing critical details."
        )
    }
}
