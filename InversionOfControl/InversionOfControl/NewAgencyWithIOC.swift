//
//  NewAgencyWithIOC.swift
//  InversionOfControl
//
//  Created by Toheed Jahan Khan on 27/12/22.
//

import Foundation

/*
 After you appointed a news agency
 */

/*
 Now you have modified the structure of your house accepting a newspaper agency, here Gotham Publications. The newspaper agency has many agents, Alfred can be one of them. So you now ask the agency to get a newspaper agent who in turn delivers the newspaper when you start your morning activities. Thus you removed the tight coupling or dependency that you had with your agent directly.
 */
class House1 {
    let newspaperAgency: NewsAgentProvidable
    let houseOwnerDetails: HouseOwnerDetails

    init(houseOwnerDetails: HouseOwnerDetails, newspaperAgency: NewsAgentProvidable) {
        self.houseOwnerDetails = houseOwnerDetails
        self.newspaperAgency = newspaperAgency
    }
    
    func startMorningActivities() {
        let newspaper = newspaperAgency.getNewsAgent(for: houseOwnerDetails).giveNewspaper()
    }
}

protocol NewsAgentProvidable {
    func getNewsAgent(for ownerDetails: HouseOwnerDetails) -> NewspaperAgent1
}
class NewspaperAgent1 {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func giveNewspaper() -> Newspaper {
        return Newspaper()
    }
}

class NewsAgency: NewsAgentProvidable {
    let name: String
    var agents: [NewspaperAgent1] = []
    
    init(name: String) {
        self.name = name
    }
    
    func getNewsAgent(for ownerDetails: HouseOwnerDetails) -> NewspaperAgent1 {
        // Get a news agent
        return NewspaperAgent1(name: "")
    }
}

let houseOwnerDetail = HouseOwnerDetails(name: "Batman")
let agency = NewsAgency(name: "Gotham Publications")
let wayneManor = House1(houseOwnerDetails: houseOwnerDetail, newspaperAgency: agency)
