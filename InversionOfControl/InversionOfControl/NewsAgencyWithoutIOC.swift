//
//  NewsAgencyWithoutIOC.swift
//  InversionOfControl
//
//  Created by Toheed Jahan Khan on 27/12/22.
//

import Foundation

/*
 Before you appointed news agency
 */

struct Newspaper {
}

class NewspaperAgent {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func giveNewspaper(for houseOwnerDetails: HouseOwnerDetails) -> Newspaper {
        return Newspaper()
    }
}

struct HouseOwnerDetails {
    let name: String
}

class House {
    let newsPaperAgent: NewspaperAgent
    let houseOwnerDetails: HouseOwnerDetails

    init(houseOwnerDetails: HouseOwnerDetails, newsPaperAgent: NewspaperAgent) {
        self.houseOwnerDetails = houseOwnerDetails
        self.newsPaperAgent = newsPaperAgent
    }

    func startMorningActivities() {
        let newsPaper = newsPaperAgent.giveNewspaper(for: self.houseOwnerDetails)
    }
}
/*
let houseOwnerDetail = HouseOwnerDetails(name: "Batman")
let newsPaperAgent = NewspaperAgent(name: "Alfred")
let wayneManor = House(houseOwnerDetails: houseOwnerDetail, newsPaperAgent: newsPaperAgent)
*/
