//
//  ApiManager.swift
//  Swift-Offers
//
//  Created by Chris Allinson on 2018-07-15.
//  Copyright © 2018 Chris Allinson. All rights reserved.
//

import Foundation
import Alamofire


protocol ApiManagerInput {
    func get(_ url: String, completion: @escaping (_ jsonObj: Any?) -> Void)
}


// MARK: -

class ApiManager: ApiManagerInput {
    
    func get(_ url: String, completion: @escaping (_ jsonObj: Any?) -> Void) {
        Alamofire.request(url).responseJSON { response in
            if let json = response.result.value {
                completion(json)
                return
            }
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                completion(data)
                return
            }
            
            completion(nil)
        }
    }
}
