import SwiftUI

struct RouteSheetView: View {
    
    @EnvironmentObject var viewModel: ViewModelo
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
            
        
        }
        .frame(maxWidth: .infinity)
        .frame(height: 400)
    }
}

#Preview {
    RouteSheetView()
        .environmentObject(ViewModelo())
}
