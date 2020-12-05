//
//  TipsModel.swift
//  Trashure
//
//  Created by Gus Adi on 26/10/20.
//

import Foundation
import UIKit

class TipsModel {
    var tipsImage: String = ""
    var title: String = ""
    var isi: String = ""
    var date: String = ""
    
    init(tipsImage: String, title: String, isi: String, date: String) {
        self.tipsImage = tipsImage
        self.title = title
        self.isi = isi
        self.date = date
    }
}
