import SwiftUI

struct SummaryView: View {
    @Binding var holes: Holes
    @State private var isPresentingResetConfirm: Bool = false

    var body: some View {
        List {
            ForEach($holes.holes) {
                $hole in NavigationLink(destination: CountersView(holes: $holes, currIndex: hole.index)) {
                    SummaryRowView(hole: hole)
                }
            }
            TotalRowView(total: holes.total)
        }
        .toolbar {
            Button(action: {
                isPresentingResetConfirm = true
            }) {
                Image(systemName: "trash.fill")
            }
            .confirmationDialog("Reset all holes?",
                isPresented: $isPresentingResetConfirm) {
                Button("Reset", role: .destructive) {
                    holes.reset()
                }
            }
        }
    }
}

struct SummaryRowView: View {
    let hole: Hole
    var body: some View {
        HStack {
            Text("Hole \(hole.index)")
            Spacer()
            Image(systemName: "figure.golf")
            Text("\(hole.count)")
        }
    }
}

struct TotalRowView: View {
    let total: Int
    var body: some View {
        HStack {
            Text("Total").bold()
            Spacer()
            Image(systemName: "figure.golf")
            Text("\(total)").bold()
        }
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SummaryView(holes: .constant(Holes.sampleData))
        }
    }
}
