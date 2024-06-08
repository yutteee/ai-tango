import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Hello SwiftUI!")
                .font(.title)
                .fontWeight(.medium)
            HStack {
                Text("Joshua Tree National Park")
                    .font(.subheadline)
                Spacer()
                Text("California")
                    .font(.subheadline)
            }
        }
        .padding()
    }
}


#Preview {
    ContentView()
}
