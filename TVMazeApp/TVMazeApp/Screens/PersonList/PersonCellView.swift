//
//  PersonCellView.swift
//  TVMazeApp
//
//  Created by Jeann Luiz on 02/03/24.
//

import SwiftUI

struct PersonCellView: View {
    
    var personModel: PersonModel
//    @State var isShowingDetail: Bool 
//    = false {
//        didSet {
//            if isShowingDetail {
//                personViewModel.removeSelectedPerson()
//            }
//        }
//    }
    
    @EnvironmentObject var personViewModel: PersonListViewModel
    
    var body: some View {
        NavigationLink(destination: PersonDetailView(personId: personModel.id)) {
            
            VStack {                
                Spacer()
                
                ZStack {
                    CustomRemoteImage(urlString: personModel.image?.medium ?? "")
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                }
                
                Text(personModel.name)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.label))
                    .multilineTextAlignment(.center)
                    .frame(height: 50)
                    .minimumScaleFactor(0.7)
                    .padding([.trailing, .leading])
                    .padding(.top, 4)
                
                Spacer()
                
                
            }
            .padding(.bottom)
        }
        .onTapGesture {
//            personViewModel.selectedPersonModel = nil
        }
    }
}

#Preview {
    PersonCellView(personModel: MockData.person1)
}
