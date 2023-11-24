import SwiftUI

struct SheetView: View {
    @EnvironmentObject var viewModel:ViewModelo
    
    var body: some View {
        VStack {
            Spacer()
            Button {
                self.viewModel.pickMode.toggle()
            } label: {
                Text("Point Mode")
                    .foregroundStyle(Color(self.viewModel.pickMode == true ? .blue: .red))
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    SheetView()
        .environmentObject(ViewModelo())
}
