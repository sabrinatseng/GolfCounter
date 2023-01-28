import SwiftUI

struct CountersView: View {
    @Binding var holes: Holes
    
    @State var currIndex: Int
    
    var body: some View {
        VStack {
            TabView(selection: $currIndex) {
                ForEach($holes.holes) {
                    $hole in CounterView(hole: $hole).tag(hole.index)
                }
                CounterView(hole: $holes.pending).tag(holes.pending.index)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            // Once the user swipes into a pending hole, it is no longer pending
            // Create a new pending hole to replace it so that the user
            // can always swipe right
            .onChange(of: currIndex, perform: { index in
                if currIndex == holes.pending.index {
                    holes.appendNew()
                }
            })
            Text("Total: \(holes.total)")
        }
    }
}

struct CounterView: View {
    @Binding var hole: Hole
    
    var body: some View {
        VStack {
            Text("Hole \(hole.index)")
            Text("\(hole.count)")
                .font(.system(size: 500))
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.01)
                .scaledToFit()
                .onTapGesture {
                    hole.inc()
                }
                .simultaneousGesture(DragGesture().onEnded({
                    if $0.translation.height > 40 {
                        hole.dec()
                    }
                }))
        }
        .padding()
    }
}

struct CountersView_Previews: PreviewProvider {
    static var previews: some View {
        CountersView(holes: .constant(Holes.sampleData), currIndex: 1)
    }
}
