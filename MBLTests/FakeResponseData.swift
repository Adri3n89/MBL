//
//  FakeResponseData.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 14/12/2021.
//

import Foundation

class FakeResponseData {

    var top50Data: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "top50", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    var searchByNameData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "searchName", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    var searchByNameNoResultData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "searchNameNoResult", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    var searchByIDData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "searchID", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    var searchByIDWithNilValueData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "searchIDwithNilValue", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }

    let incorrectData = "erreur".data(using: .utf8)!

}
