import SwiftUI

struct SheetView: View {
    @EnvironmentObject var viewModel:ViewModelo
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            
            Group {
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            self.viewModel.pickMode.toggle()
                        }
                        
                    } label: {
                        Text("Point Mode")
                            .foregroundStyle(Color(self.viewModel.pickMode == true ? .blue: .red))
                        
                    }
                    .buttonStyle(.bordered)
                    .padding(.trailing, 16)
                }
                
                if self.viewModel.pickMode {
                    HStack {
                        Button {
                            self.viewModel.isFirstPoint = true
                            dismiss()
                        } label: {
                            
                            Text("Выбрать ОТ")
                            
                        }
                        .buttonStyle(.bordered)
                        .padding(.leading, 16)
                        
                        if let pl = self.viewModel.firstPoint {
                            Text("От: (\(pl.latitude), \(pl.longitude))")
                        }
                        Spacer()
                        
                        
                        
                    }
                    HStack {
                        Button {
                            self.viewModel.isFirstPoint = false
                            dismiss()
                        } label: {
                            
                            Text("Выбрать ДО")
                            
                        }
                        .buttonStyle(.bordered)
                        .padding(.leading, 16)
                        if let pl = self.viewModel.secondPoint {
                            Text("До: (\(pl.latitude), \(pl.longitude))")
                        }
                        
                        Spacer()
                        
                    }
                    HStack {
                        Button {
                            self.viewModel.getRoute()
                        } label: {
                            Text("Car")
                        }
                        .buttonStyle(.bordered)
                    }
                    HStack {
                        Spacer()
                        Button {
                            withAnimation {
                                self.viewModel.clean()
                            }
                            
                        } label: {
                            Text("Clean")
                                .foregroundStyle(.red)
                        }
                        .buttonStyle(.bordered)
                        .padding(.trailing, 16)
                    }
                }
            }
            
            Group {
                HStack {
                    
                    Text("Масштабный коэффициент")
                        .padding(.leading, 16)
                    Spacer()
                }
                
                TextField("", text:self.$viewModel.scaleString)
                    .font(.subheadline)
                    .padding(12)
                    .background(.white)
                    .clipShape(.rect(cornerRadius: 10))
                    .padding(.horizontal)
                    .shadow(radius: 10)
                HStack {
                    Button {
                        withAnimation {
                            self.viewModel.resetData()
                        }
                  
                    } label: {
                        Text("Сбросить")
                            .foregroundStyle(.blue)
                    }
                    .buttonStyle(.bordered)
                    .padding(.leading, 16)
                    Spacer()
                    
                    Button {
                        withAnimation {
                            self.viewModel.updateData()
                        }
                  
                    } label: {
                        Text("Применить")
                            .foregroundStyle(.green)
                    }
                    .buttonStyle(.bordered)
                    .padding(.trailing, 16)
                    
                }
            }
            
            
            
        }
    }
}

#Preview {
    SheetView()
        .environmentObject(ViewModelo())
}
