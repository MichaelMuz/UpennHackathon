//
//  DefListDecoder.swift
//  FuckTest4
//
//  Created by Max Pintchouk on 2/5/23.
//

import Foundation

    
    func defListSplitter(string: String) -> [[String]] {
        let rows = LocalStorage.deflist.components(separatedBy: "_")
        let twoDimensionalArray = rows.map{ row in
            return row.components(separatedBy: ":")
        }
        return twoDimensionalArray
    }

/*public var refinedDList = defListSplitter(string: LocalStorage.deflist )

class DefListDecoder {
    public static var rDList = refinedDList
}*/
