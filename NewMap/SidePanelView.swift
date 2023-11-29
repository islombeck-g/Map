
import SwiftUI

struct SidePanelView: View {
    
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var viewModel:ViewModelo
    
    var body: some View {
        VStack(spacing: 10) {
            Group {
                Button {
                    if self.viewModel.addPointMode == false {
                        self.viewModel.selectedCoordinatesToAddLocation = nil
                    }
                    
                    self.viewModel.addPointMode.toggle()
                    self.viewModel.routeMode = false
                } label: {
                    Image(systemName: "plus.viewfinder")
                        .font(.system(size: 23))
                        .padding(.all, 10)
                        .foregroundStyle(self.viewModel.addPointMode == true ? .white : .blue)
                        .background(self.viewModel.addPointMode == true ? .orange : .white.opacity(0.7))
                        .clipShape(.rect(cornerRadius: 8))
                }
                
                
                
                
                if self.viewModel.addPointMode == true {
                    
                    Button {
                        self.viewModel.showPointSheetView.toggle()
                    }label: {
                        Image(systemName: "plus.app")
                            .font(.system(size: 23))
                            .padding(.all, 10)
                            .foregroundStyle(.blue)
                            .background(.white.opacity(0.7))
                            .clipShape(.rect(cornerRadius: 8))
                    }
                }
                Button {
                    
                    do {
                        try modelContext.delete(model: LocalItems.self)
                        //            insertSampleData(modelContext: modelContext)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                    
                } label: {
                    Image(systemName: "trash.circle")
                        .font(.system(size: 23))
                        .padding(.all, 10)
                        .foregroundStyle(.blue)
                }
                .background(.white.opacity(0.7))
                .clipShape(.rect(cornerRadius: 8))
                
            }
            
            Button {
                
                self.viewModel.changeMapStyle1()
                
            } label: {
                Image(systemName: "map.fill")
                    .font(.system(size: 23))
                    .padding(.all, 10)
            }
            .background(.white.opacity(0.7))
            .clipShape(.rect(cornerRadius: 8))
            
            
            Button {
                
                self.viewModel.changeMapStyle0()
                
            } label: {
                Image(systemName: "map")
                    .font(.system(size: 23))
                    .padding(.all, 10)
            }
            .background(.white.opacity(0.7))
            .clipShape(.rect(cornerRadius: 8))
            
            
            
            Button {
                
                self.viewModel.routeMode.toggle()
                self.viewModel.addPointMode = false
                
            } label: {
                Image(systemName: "mappin.circle.fill")
                    .font(.system(size: 23))
                    .padding(.all, 10)
            }
            .background(.white.opacity(0.7))
            .clipShape(.rect(cornerRadius: 8))
            
            
            Button {
                
                self.viewModel.settingsShetViewShow = true
                
            } label: {
                Image(systemName: "square.and.arrow.up.fill")
                    .font(.system(size: 23))
                    .padding(.all, 10)
            }
            .background(.white.opacity(0.7))
            .clipShape(.rect(cornerRadius: 8))
            
            .padding(.bottom, 30)
            
            
        }
        
    }
}

#Preview {
    SidePanelView()
        .environmentObject(ViewModelo())
}
