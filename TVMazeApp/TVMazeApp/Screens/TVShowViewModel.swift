//
//  TVShowViewModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 28/02/24.
//

import SwiftUI

@MainActor
final class TVShowViewModel: ObservableObject {
    @Published var tvShowsModel: [TVShowModel] = []
    @Published var alertItem: AlertItem?
    @Published var isLoading: Bool = false
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible())]
//    @Published var isShowingDetail = false
    
//    func getAppetizers() {
//        
//        isLoading = true
//        
//        NetworkManager.shared.getAppetizers { [weak self] result in
//            DispatchQueue.main.async {
//                
//                self?.isLoading = false
//                
//                switch result {
//                case .success(let appetizers):
//                    self?.appetizers = appetizers
//                    
//                case .failure(let error):
//                    switch error {
//                    case .invalidUrl:
//                        self?.alertItem = AlertContext.invalidUrl
//                        
//                    case .invalidResponse:
//                        self?.alertItem = AlertContext.invalidResponse
//                        
//                    case .invalidData:
//                        self?.alertItem = AlertContext.invalidData
//                        
//                    case .unableToComplete:
//                        self?.alertItem = AlertContext.unableToComplete
//                    }
//                }
//            }
//        }
//    }
    
    func getTVShows() {
        
        isLoading = true
        
        Task {
            do {
                tvShowsModel = try await NetworkManager.shared.getTVShowsAsync()
                isLoading = false
            } catch CustomError.invalidUrl {
                alertItem = AlertContext.invalidUrl
            } catch CustomError.invalidResponse {
                alertItem = AlertContext.invalidResponse
            } catch CustomError.invalidData {
                alertItem = AlertContext.invalidData
            } catch CustomError.unableToComplete {
                alertItem = AlertContext.unableToComplete
            } catch {
                alertItem = AlertContext.unableToComplete
            }
        }
    }
}

