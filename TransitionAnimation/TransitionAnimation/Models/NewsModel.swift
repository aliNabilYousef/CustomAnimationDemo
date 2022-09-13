//
//  NewsModel.swift
//  TransitionAnimation
//
//  Created by Ali Youssef on 4/26/22.
//

import Foundation

//no need to have this as a class, and structs provide us with the initializers we need automatically 
struct NewsModel: BasicDataModel {
    var image: String
    var title: String
    var description: String
}
