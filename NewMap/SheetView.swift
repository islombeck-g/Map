import SwiftUI

struct SheetView: View {
    @EnvironmentObject var viewModel:ViewModelo
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            //            MARK: mapScale (buttons)
            Group {
                HStack {
                    Text("Масштабный коэффициент")
                        .padding(.leading, 16)
                    Spacer()
                }
                
                HStack {
                    Text("\(self.viewModel.scale.formatted())")
                        .padding(.horizontal, 50)
                        .font(.subheadline)
                        .padding(12)
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.horizontal)
                        .shadow(radius: 10)
                    
                    Image(systemName: "arrow.forward")
                    
                    TextField("", text:self.$viewModel.scaleString)
                        .font(.subheadline)
                        .padding(12)
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding(.horizontal)
                        .shadow(radius: 10)
                }
                .padding(.bottom, 10)
                
                
                HStack {
                    Button {
                        withAnimation {
                            self.viewModel.resetData()
                        }
                    } label: {
                        Text("Сбросить")
                            .foregroundStyle(.blue)
                    }
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
                    .padding(.trailing, 16)
                }
                .buttonStyle(.bordered)
            }
            
            Divider()
            //            MARK: draw route mode (buttons)
            Group {
                HStack {
                    Spacer()
                    Button {
                        withAnimation {
                            self.viewModel.routeMode.toggle()
                        }
                    } label: {
                        Text("Point Mode")
                            .foregroundStyle(Color(self.viewModel.routeMode == true ? .blue: .red))
                    }
                    .padding(.trailing, 16)
                }
                
                if self.viewModel.routeMode {
                    
                    VStack(alignment: .leading) {
                        Text("Маршрут:")
                        HStack {
                            Button {
                                self.viewModel.isFirstPoint = true
                                dismiss()
                            } label: {
                                
                                Text("Выбрать ОТ")
                                
                            }
                            
                            Spacer()
                            
                            if let pl = self.viewModel.firstPoint {
                                Text("\(pl.latitude), \(pl.longitude)")
                                
                                    .font(.subheadline)
                                    .padding(12)
                                    .background(.white)
                                    .clipShape(.rect(cornerRadius: 10))
//                                    .padding(.horizontal)
                                    .shadow(radius: 10)
                            }
                            
                        }
                        
                        HStack {
                            Button {
                                self.viewModel.isFirstPoint = false
                                dismiss()
                            } label: {
                                Text("Выбрать ДО")
                            }
                            
                            Spacer()
                            
                            if let pl = self.viewModel.secondPoint {
                                Text("\(pl.latitude), \(pl.longitude)")
                                
                                    .font(.subheadline)
                                    .padding(12)
                                    .background(.white)
                                    .clipShape(.rect(cornerRadius: 10))
//                                    .padding(.horizontal)
                                    .shadow(radius: 10)
                            }
                        }
                        Text("Способ проложения пути:")
                        HStack {
                            Button {
                                self.viewModel.getRoute("automobile")
                            } label: {
                                Image(systemName: "car")
                            }
                            
                            Button {
                                self.viewModel.getRoute("walk")
                            } label: {
                                Image(systemName: "figure.walk.circle")
                            }
                        }
                        .disabled( self.viewModel.firstPoint == nil || self.viewModel.secondPoint == nil )
                       
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
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .buttonStyle(.bordered)
            Divider()
        }
    }
}

#Preview {
    SheetView()
        .environmentObject(ViewModelo())
}
