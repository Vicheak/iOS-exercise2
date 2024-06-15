//
//  TestHttp .swift
//  exercise002
//
//  Created by @suonvicheakdev on 25/5/24.
//

import Foundation
import Alamofire

class TestHttp {
    
    init() async {
        let response = await AF.request("https://api.escuelajs.co/api/v1/categories/")
                    .response
        debugPrint(response!)
    }
    
}
