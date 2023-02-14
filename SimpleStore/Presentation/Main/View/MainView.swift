//
//  MainView.swift
//  SimpleStore
//
//  Created by Dmitry Lipuntsov on 23.12.2022.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            AppColors.mainBackground.ignoresSafeArea()
            
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    //header
                    HStack {
                        Spacer()
                        
                        HStack {
                            Image("pinMark")
                                .resizable()
                                .frame(width: 12, height: 15.31)
                            
                            Text("Zihuatanejo, Gro")
                                .font(.custom(AppFonts.markProBold, size: 15))
                                .foregroundColor(AppColors.titleText)
                                .tracking(-0.33)
                                .multilineTextAlignment(.center)
                                .padding(.leading, 11)
                            
                            Image(systemName: "chevron.down")
                                .resizable()
                                .frame(width: 10, height: 5)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 5.5)
                        
                        Spacer()
                        
                        Button {
                            viewModel.filterViewIsShow.toggle()
                        } label: {
                            Image("barButtonImage")
                                .resizable()
                                .frame(width: 11, height: 13, alignment: .trailing)
                        }
                    }
                    .padding(.horizontal, 36)
                    
                    //category
                    VStack {
                        HStack {
                            Text("Select Category")
                                .font(.custom(AppFonts.markProBold, size: 25))
                                .foregroundColor(AppColors.titleText)
                                .tracking(-0.33)
                                .multilineTextAlignment(.center)
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Text("view all")
                                    .font(.custom(AppFonts.markProRegular, size: 15))
                                    .foregroundColor(AppColors.orange)
                                    .tracking(-0.33)
                                    .multilineTextAlignment(.center)
                            }
                        }
                        .padding(.top, 18)
                        .padding(.horizontal, 17)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: [GridItem()], spacing: 23) {
                                ForEach(0..<viewModel.categories.count, id: \.self) { index in
                                    let category = viewModel.categories[index]
                                    CategoryCellView(category: category)
                                        .onTapGesture {
                                            viewModel.categoryPressed(index: index)
                                        }
                                }
                                
                            }
                            .padding(.horizontal, 10)
                        }
                        .frame(height: 100)
                    }
                    
                    //search
                    HStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .resizable()
                                .frame(width: 16, height: 16)
                                .foregroundColor(AppColors.orange)
                            
                            TextField("Search", text: $viewModel.searchText)
                                .padding(.leading, 10)
                        }
                        .padding(.leading, 24)
                        .frame(height: 34)
                        .background(Color.white)
                        .cornerRadius(20)
                        
                        ZStack {
                            Circle()
                                .frame(width: 34, height: 34)
                                .foregroundColor(AppColors.orange)
                            Image("squarGreed")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.top, 15)
                    
                    //hot sales
                    VStack {
                        HStack {
                            Text("Hot sales")
                                .font(.custom(AppFonts.markProBold, size: 25))
                                .foregroundColor(AppColors.titleText)
                                .multilineTextAlignment(.center)
                            
                            Spacer()
                            
                            Text("see more")
                                .font(.custom(AppFonts.markProRegular, size: 15))
                                .foregroundColor(AppColors.orange)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, 17)
                        
                        if viewModel.hotSells.isEmpty {
                            ProgressView()
                                .frame(height: 182)
                        } else {
                            TabView {
                                ForEach(0..<viewModel.hotSells.count, id: \.self) { index in
                                    let item = viewModel.hotSells[index]
                                    HotCellView(
                                        model: item,
                                        byButtonAction: {
                                            viewModel.byButtonPressed(index: index)
                                        }
                                    )
                                    .onTapGesture {
                                        
                                    }
                                }
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never))
                            .frame(height: 182)
                        }
                    }
                    
                    //best sellers
                    VStack {
                        HStack {
                            Text("Best Seller")
                                .font(.custom(AppFonts.markProBold, size: 25))
                                .foregroundColor(AppColors.titleText)
                                .multilineTextAlignment(.center)
                            
                            Spacer()
                            
                            Text("see more")
                                .font(.custom(AppFonts.markProRegular, size: 15))
                                .foregroundColor(AppColors.orange)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, 17)
                        
                        if viewModel.hotSells.isEmpty {
                            ProgressView()
                                .frame(height: 182)
                        } else {
                            LazyVGrid(columns: [GridItem(), GridItem()], spacing: 20) {
                                ForEach(0..<viewModel.bestSells.count, id: \.self) { index in
                                    let item = viewModel.bestSells[index]
                                    BestCellView(model: item)
                                        .onTapGesture {
                                            viewModel.showDetail(item: item)
                                        }
                                }
                            }
                            .padding(.horizontal, 17)
                            
                            Spacer()
                        }
                    }
                    .frame(minHeight: .screenHeight / 2)
                    
                    BottomBarView()
                        .frame(width: .screenWidth - 10, height: 72)
                        .padding(.top)
                    
                }
                .scrollDisabled(viewModel.filterViewIsShow)
            }
        }
        .toolbar(.hidden)
        .popup(isPresented: $viewModel.filterViewIsShow) {
            VStack {
                Rectangle()
                    .frame(width: .screenWidth, height: .screenHeight / 2)
                    .foregroundColor(.white.opacity(0.01))
                    .onTapGesture {
                        viewModel.filterViewIsShow = false
                    }
                    .gesture(DragGesture().onChanged({ _ in
                        viewModel.filterViewIsShow = false
                    }))
                
                FilterView(viewModel: viewModel)
            }
        }
        
    }
}

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel(coordinator: Coordinator(), repository: ProductsRepository()))
    }
}
#endif
