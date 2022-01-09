//
//  ApiServiceTest.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 14/12/2021.
//

import Combine
@testable import MBL
import XCTest

class ApiServiceTest: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()
      
      override func tearDown() {
          subscriptions = []
      }
    
    // MARK: - TEST getHotGame
    
    func testGetHotGameGivenGoodData() {
        let data = FakeResponseData().top50Data
        let mock = APIMockResources(result: .success(data))
        let apiService = ApiService(apiResources: mock)
        
        let expectation = expectation(description: "receiving data")
        
        apiService.getHotGame()
            .sink { completion in
    
            } receiveValue: { top50 in
                XCTAssertEqual(top50.count , 50)
                expectation.fulfill()
            }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func testGetHotGameGivenBadURL() {
            //given
            let badURL = "ezifjef zioejf o"
            let expectation = XCTestExpectation(description: "changing queue")
            let apiService = ApiService()
    
        apiService.getHotGame(badURL)
            .sink { completion in
                switch completion {
                case .failure(let error) :
                    XCTAssertEqual(error.localizedDescription, "Bad URL.")
                case .finished:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { top50 in
                
            }.store(in: &subscriptions)
        
            wait(for: [expectation], timeout: 1)
        }
    
    func testGetHotGameGivenBadData() {
        let data = FakeResponseData().incorrectData
        let mock = APIMockResources(result: .success(data))
        let apiService = ApiService(apiResources: mock)
        
        let expectation = expectation(description: "receiving data")
        
        apiService.getHotGame()
            .sink { completion in
                switch completion {
                case .failure(let error) :
                    XCTAssertEqual(error.localizedDescription, "Undecodable Datas, try again")
                case .finished:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { top50 in
               XCTFail()
            }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func testGetHotGameGivenBadResponse() {
        let mock = APIMockResources(result: .failure(.badResponse))
        let apiService = ApiService(apiResources: mock)
        
        let expectation = expectation(description: "receiving bad response")
        
        apiService.getHotGame()
            .sink { completion in
                switch completion {
                case .failure(let error) :
                    XCTAssertEqual(error.localizedDescription, "Bad response from API.")
                case .finished:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { top50 in
               XCTFail()
            }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
        
    }

    // MARK: - TEST getGames
    
    func testGetGamesGivenGoodData() {
        let data = FakeResponseData().searchByIDData
        let mock = APIMockResources(result: .success(data))
        let apiService = ApiService(apiResources: mock)
        
        let expectation = expectation(description: "receiving data")
        
        apiService.getGames(gameID: "99999")
            .sink { completion in
    
            } receiveValue: { game in
                XCTAssertEqual(game.id , "99999")
                expectation.fulfill()
            }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func testGetGamesGivenGoodDatawithNilImage() {
        let data = FakeResponseData().searchByIDWithNilValueData
        let mock = APIMockResources(result: .success(data))
        let apiService = ApiService(apiResources: mock)
        
        let expectation = expectation(description: "receiving data")
        
        apiService.getGames(gameID: "99999")
            .sink { completion in
    
            } receiveValue: { game in
                XCTAssertEqual(game.id , "99999")
                XCTAssertEqual(game.image, Constantes.defaultGamePicture)
                expectation.fulfill()
            }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func testGetGamesGivenBadURL() {
            //given
            let badURL = "ezifjef zioejf o"
            let expectation = XCTestExpectation(description: "changing queue")
            let apiService = ApiService()
    
        apiService.getGames(gameID: badURL)
            .sink { completion in
                switch completion {
                case .failure(let error) :
                    XCTAssertEqual(error.localizedDescription, "Bad URL.")
                case .finished:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { game in
                
            }.store(in: &subscriptions)
        
            wait(for: [expectation], timeout: 1)
        }
    
    func testGetGamesGivenBadData() {
        let data = FakeResponseData().incorrectData
        let mock = APIMockResources(result: .success(data))
        let apiService = ApiService(apiResources: mock)
        
        let expectation = expectation(description: "receiving data")
        
        apiService.getGames(gameID: "99999")
            .sink { completion in
                switch completion {
                case .failure(let error) :
                    XCTAssertEqual(error.localizedDescription, "Undecodable Datas, try again")
                case .finished:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { game in
               XCTFail()
            }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func testGetGamesGivenBadResponse() {
        let mock = APIMockResources(result: .failure(.badResponse))
        let apiService = ApiService(apiResources: mock)
        
        let expectation = expectation(description: "receiving bad response")
        
        apiService.getGames(gameID: "9779")
            .sink { completion in
                switch completion {
                case .failure(let error) :
                    XCTAssertEqual(error.localizedDescription, "Bad response from API.")
                case .finished:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { game in
               XCTFail()
            }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
        
    }

    // MARK: - TEST getGameByName
    
    func testGetGameByNameGivenGoodData() {
        let data = FakeResponseData().searchByNameData
        let mock = APIMockResources(result: .success(data))
        let apiService = ApiService(apiResources: mock)
        
        let expectation = expectation(description: "receiving data")
        
        apiService.searchGameName(name: "Catan")
            .sink { completion in
    
            } receiveValue: { games in
                XCTAssert(games[0].name.value.lowercased().contains("catan"))
                expectation.fulfill()
            }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func testGetGameByNameGivenGoodDataAndOneResult() {
        let data = FakeResponseData().searchByNameOneResultData
        let mock = APIMockResources(result: .success(data))
        let apiService = ApiService(apiResources: mock)
        
        let expectation = expectation(description: "receiving data")
        
        apiService.searchGameName(name: "Papayoo")
            .sink { completion in
    
            } receiveValue: { games in
                XCTAssert(games[0].name.value.lowercased().contains("papayoo"))
                expectation.fulfill()
            }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func testGetGameByNameGivenGoodDatawithZeroResult() {
        let data = FakeResponseData().searchByNameNoResultData
        let mock = APIMockResources(result: .success(data))
        let apiService = ApiService(apiResources: mock)
        
        let expectation = expectation(description: "receiving data")
        
        apiService.searchGameName(name: "zdkzdakkdzak")
            .sink { completion in
               
            } receiveValue: { games in
                XCTAssertEqual(games.count , 0)
                expectation.fulfill()
            }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func testGetGameByNameGivenBadURL() {
            //given
            let badURL = "ezifjef zioejf o"
            let expectation = XCTestExpectation(description: "changing queue")
            let apiService = ApiService()
    
        apiService.searchGameName(name: badURL)
            .sink { completion in
                switch completion {
                case .failure(let error) :
                    XCTAssertEqual(error.localizedDescription, "Bad URL.")
                case .finished:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { game in
                
            }.store(in: &subscriptions)
        
            wait(for: [expectation], timeout: 1)
        }
    
    func testGetGameByNameGivenBadData() {
        let data = FakeResponseData().incorrectData
        let mock = APIMockResources(result: .success(data))
        let apiService = ApiService(apiResources: mock)
        
        let expectation = expectation(description: "receiving data")
        
        apiService.searchGameName(name: "Catan")
            .sink { completion in
                switch completion {
                case .failure(let error) :
                    XCTAssertEqual(error.localizedDescription, "Undecodable Datas, try again")
                case .finished:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { game in
               XCTFail()
            }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    func testGetGameByNameGivenBadResponse() {
        let mock = APIMockResources(result: .failure(.badResponse))
        let apiService = ApiService(apiResources: mock)
        
        let expectation = expectation(description: "receiving bad response")
        
        apiService.searchGameName(name: "Catan")
            .sink { completion in
                switch completion {
                case .failure(let error) :
                    XCTAssertEqual(error.localizedDescription, "Bad response from API.")
                case .finished:
                    XCTFail()
                }
                expectation.fulfill()
            } receiveValue: { game in
               XCTFail()
            }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 1)
        
    }
    
    
    
}


// MARK: - Fake URLProtocol
final class ApiURLProtocol: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    static var loadingHandler: ((URLRequest) -> (Data?, HTTPURLResponse, Error?))?

    override func startLoading() {
        guard let handler = ApiURLProtocol.loadingHandler else {
            XCTFail("Loading handler is not set.")
            return
        }
        let (data, response, error) = handler(request)
        if let data = data {
            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocolDidFinishLoading(self)
        }
        else {
            client?.urlProtocol(self, didFailWithError: error!)
        }
    }

    override func stopLoading() {}
}
