//
//  TreatmentTypeView.swift
//  Verixa Health
//
//  Created by kartik choudhary on 09/01/26.
//

import SwiftUI

struct TreatmentTypeView: View {
    var body: some View {
        VStack(spacing: 24) {

            Text("What do you want to verify?")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)

            VStack(spacing: 16) {

                // ✅ Navigation added here
                NavigationLink {
                    MedicalTestView()
                } label: {
                    optionRow(title: "Medical Test", icon: "testtube.2")
                }

                optionRow(title: "Medicine / Prescription", icon: "pills.fill")
                optionRow(title: "Hospital Admission", icon: "bed.double.fill")
                optionRow(title: "Surgery / Procedure", icon: "cross.case.fill")
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Select Treatment")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Reusable row
    func optionRow(title: String, icon: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)

            Text(title)
                .font(.headline)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(14)
    }
}

#Preview {
    NavigationStack {
        TreatmentTypeView()
    }
}
