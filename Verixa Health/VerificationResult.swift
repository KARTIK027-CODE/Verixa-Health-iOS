//
//  VerificationResult.swift
//  Verixa Health
//
//  Created by kartik choudhary  on 12/01/26.
//

import Foundation

// MARK: - Verification Status Enum
enum VerificationStatus {
    case verified
    case incomplete
    case suspicious
}

// MARK: - Verification Result Model
struct VerificationResult {
    let status: VerificationStatus
    let missingFields: [String]
    let message: String
}
