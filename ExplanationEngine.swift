//
//  ExplanationEngine.swift
//  Verixa Health
//
//  Created by kartik choudhary  on 25/01/26.
//

import Foundation

struct ExplanationEngine {

    // MARK: - Plain English Explanation

    static func explain(testName: String) -> String {
        switch testName.lowercased() {

        case "hemoglobin":
            return "Hemoglobin measures how well your blood carries oxygen. Low levels may indicate anemia, while high levels can occur due to dehydration or other conditions."

        case "vitamin d":
            return "Vitamin D helps with bone strength and immunity. Low levels are common and may be linked to limited sunlight exposure."

        case "cholesterol":
            return "Cholesterol tests assess heart health. High values may increase the risk of cardiovascular disease over time."

        case "blood sugar", "glucose":
            return "Blood sugar levels help assess how your body processes glucose. Abnormal levels may suggest diabetes or prediabetes."

        default:
            return "This test helps doctors understand your overall health. Ask your doctor how this result fits into your current treatment plan."
        }
    }

    // MARK: - Questions for Doctor (Patient Empowerment)

    static func questions(for testName: String) -> [String] {
        switch testName.lowercased() {

        case "vitamin d":
            return [
                "Do I have symptoms that justify this test?",
                "Would lifestyle changes help improve this value?",
                "How often should this test be repeated?"
            ]

        case "cholesterol":
            return [
                "Does this level require medication or lifestyle changes?",
                "What is my long-term heart risk based on this result?",
                "Should this test be repeated fasting or non-fasting?"
            ]

        case "blood sugar", "glucose":
            return [
                "Is this result affected by my recent meals?",
                "Do I need further testing like HbA1c?",
                "What changes can improve this value naturally?"
            ]

        default:
            return [
                "Why was this test recommended?",
                "How does this result affect my treatment?",
                "Is follow-up testing required?"
            ]
        }
    }
}
