//
//  NetworkHelper.swift
//  PromoList
//
//  Created by Naratama on 10/08/23.
//

import Foundation
import Alamofire

class NetworkHelper {
    static var shared = NetworkHelper()
    
    func requestPromoList(completion: @escaping (Bool, [PromoListResponseEntity], _ error: String?) -> Void) {
        let url = "https://content.digi46.id/promos"
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNjc1OTE0MTUwLCJleHAiOjE2Nzg1MDYxNTB9.TcIgL5CDZYg9o8CUsSjUbbUdsYSaLutOWni88ZBs9S8"
        ]
        
        AF.request(url, method: .get, parameters: nil)
            .validate(statusCode: 200..<600)
            .responseDecodable(of: [PromoListResponseEntity].self, completionHandler: { response in
                
                switch response.result {
                case .success(let promoResponse):
                    guard !promoResponse.isEmpty else  {
                        completion(true, [], nil)
                        return
                    }
                    completion(true, promoResponse, nil)
                    
                case .failure(let error):
                    let promoListViewEntity = PromoListViewEntity(promoList: [PromoListEntity](), errors: error.localizedDescription)
                    completion(false, [], error.localizedDescription)
                }
                
            })
    }
}
