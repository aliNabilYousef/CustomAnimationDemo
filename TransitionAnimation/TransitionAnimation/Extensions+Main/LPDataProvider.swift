//
//  LPDataProvider.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/27/22.
//

import Foundation

class LPDataProvider: NSObject {
    static let sharedInstance = LPDataProvider()
    
    lazy var dataSetStrings1: CarouselProtocol = CarouselModel(dataSet: ["1", "2", "3", "4", "5", "6"])
    lazy var dataSetStrings2: CarouselProtocol = CarouselModel(dataSet: ["6", "7", "8", "9", "10", "11"])
    lazy var dataStringsArray = [dataSetStrings1, dataSetStrings2]
    
    let randomDescription = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    lazy var dataSet: [NewsModel] =
    [NewsModel(image: "1", title: "Title 1", description: randomDescription),
     NewsModel(image: "2", title: "Title 2", description: randomDescription),
     NewsModel(image: "3", title: "Title 3", description: randomDescription),
     NewsModel(image: "4", title: "Title 4", description: randomDescription),
     NewsModel(image: "5", title: "Title 5", description: randomDescription),
     NewsModel(image: "6", title: "Title 6", description: randomDescription),
     NewsModel(image: "7", title: "Title 7", description: randomDescription),
     NewsModel(image: "8", title: "Title 8", description: randomDescription),
     NewsModel(image: "9", title: "Title 9", description: randomDescription),
     NewsModel(image: "10", title: "Title 10", description: randomDescription),
     NewsModel(image: "11", title: "Title 11", description: randomDescription)]
}
