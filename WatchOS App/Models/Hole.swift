import Foundation

struct Hole: Identifiable {
    var index: Int
    var count: Int = 0
    
    var id: Int {
        index
    }
    
    mutating func inc() {
        self.count += 1
    }
    
    mutating func dec() {
        if self.count > 0 {
            self.count -= 1
        }
    }
}

struct Holes {
    // Holes are 1-indexed
    var holes: [Hole]
    
    // Hole that is waiting to be added
    // Will appear in tabview but not in summary view
    // until it is moved from pending into holes
    var pending: Hole
    
    var count: Int {
        holes.count
    }
    
    var total: Int {
        holes.map{$0.count}.reduce(0, +)
    }
    
    init() {
        self.holes = [Hole(index: 1)]
        self.pending = Hole(index: 2)
    }
    
    init(holes: [Hole]) {
        self.holes = holes
        self.pending = Hole(index: holes.count + 1)
    }
    
    mutating func reset() {
        self = Holes()
    }
    
    mutating func appendNew() {
        self.holes.append(self.pending)
        self.pending = Hole(index: holes.count + 1)
    }
}

extension Holes {
    static let sampleData: Holes = Holes(holes:
        [
            Hole(index: 1, count: 3),
            Hole(index: 2, count: 5),
            Hole(index: 3, count: 3),
            Hole(index: 4, count: 6),
            Hole(index: 5, count: 4),
            Hole(index: 6, count: 4),
        ]
    )
}
