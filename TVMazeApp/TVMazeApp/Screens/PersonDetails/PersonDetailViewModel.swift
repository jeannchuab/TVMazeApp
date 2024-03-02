//
//  PersonDetailViewModel.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 02/03/24.
//

import SwiftUI

@MainActor
final class PersonDetailViewModel: ObservableObject {
    @Published var personModel: PersonModel?
    @Published var personTVShows: [TVShowModel]?
    @Published var isLoading: Bool = false
    @Published var alertItem: AlertItem?
    
    func getPersonById(id: Int) {
        get(endpoint: .personById(id))
    }
    
    private func get(endpoint: Endpoint, searchQuery: String = "") {
        isLoading = true
        
        Task {
            do {
//                personModel = []
                
                switch endpoint {
                case .personById(let id):
                    personModel = nil
                    personModel = try await NetworkManager.getPerson(id: id)
                    getTVShowsFrom(idPerson: id)
                default:
                    alertItem = AlertItem(error: .endpointNotFound)
                }
            } catch let error {
                if error is CustomError {
                    guard let customError = error as? CustomError else { return }
                    alertItem = AlertItem(error: customError)
                } else {
                    alertItem = AlertItem(error: .invalidData)
                }
            }
            isLoading = false
        }
    }
    
    //Find the TVShows where a person was in the cast
    func getTVShowsFrom(idPerson: Int) {
        isLoading = true
                
        Task {
            var result: [TVShowModel] = []
            do {
                var idsTVShows: [String] = []
                
                guard let personModel,
                      let embedded = personModel.embedded
                else { return }
                
                for castcredits in embedded.castcredits.enumerated() {
                    let idTVShow = (castcredits.element.links.show.href as NSString).lastPathComponent
                    idsTVShows.append(idTVShow)
                }
                
                for id in idsTVShows {
                    let tvShow = try await NetworkManager.getTVShow(id: id)
                    result.append(tvShow)
                }
            } catch let error {
                if error is CustomError {
                    guard let customError = error as? CustomError else { return }
                    alertItem = AlertItem(error: customError)
                } else {
                    alertItem = AlertItem(error: .invalidData)
                }
            }
            personTVShows = result
            isLoading = false
        }
    }
}
