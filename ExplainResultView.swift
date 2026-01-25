import SwiftUI

struct ExplainResultView: View {

    let results: [MedicalTestResult]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                Text("Understanding Your Report")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom)

                ForEach(results) { result in
                    VStack(alignment: .leading, spacing: 10) {

                        HStack {
                            Text(result.name)
                                .font(.headline)

                            Spacer()

                            Text("\(result.value) \(result.unit)")
                                .foregroundColor(.secondary)
                        }

                        Divider()

                        // Explanation
                        Text(ExplanationEngine.explain(testName: result.name))
                            .font(.footnote)

                        // Questions
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Questions you can ask your doctor:")
                                .font(.subheadline)
                                .fontWeight(.medium)

                            ForEach(
                                ExplanationEngine.questions(for: result.name),
                                id: \.self
                            ) { question in
                                Text("• \(question)")
                                    .font(.footnote)
                            }
                        }
                        .padding(.top, 6)

                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(14)
                }
            }
            .padding()
        }
        .navigationTitle("Explanation")
        .navigationBarTitleDisplayMode(.inline)
    }
}
