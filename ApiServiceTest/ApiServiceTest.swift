//
//  ApiServiceTest.swift
//  ApiServiceTest
//
//  Created by Adrien PEREA on 14/12/2021.
//

@testable import MGL
import XCTest

class ApiServiceTest: XCTestCase {

    // MARK: - TEST getHotGame

    func testGetHotGameGivenDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().top50Data

        ApiURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.getHotGame(Constantes.urlTop50, URLSession(configuration: configuration)) { result in
            if case .success(let top50) = result {
                XCTAssertNotNil(top50)
                XCTAssert((top50 as Any) is [GameData])
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetHotGameGivenBadReponseAndData() {
        //given
        let response = FakeResponseData().reponseKO
        let data = FakeResponseData().top50Data

        ApiURLProtocol.loadingHandler = { request in
            return (data, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.getHotGame(Constantes.urlTop50, URLSession(configuration: configuration)) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .badResponse)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetHotGameGivenBadURL() {
        //given
        let badURL = "ezifjef zioejf o"

        let expectation = XCTestExpectation(description: "changing queue")

        let ApiService = ApiService()

        ApiService.getHotGame(badURL, URLSession.shared) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .badURL)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetHotGameGivenBadDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().incorrectData

        ApiURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.getHotGame(Constantes.urlTop50, URLSession(configuration: configuration)) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .undecodableData)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetHotGameGivenNoDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let error = FakeResponseData().error

        ApiURLProtocol.loadingHandler = { request in
            return (nil, response, error)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.getHotGame(Constantes.urlTop50, URLSession(configuration: configuration)) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .noData)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: - TEST getGameByID

    func testGetGameByIDGivenDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().searchByIDData

        ApiURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.getGameByID(id: "99999", URLSession(configuration: configuration)) { result in
            if case .success(let game) = result {
                XCTAssertNotNil(game)
                XCTAssert((game as Any) is ItemInfo)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetGameByIDGivenBadResponseAndGoodData() {
        //given
        let response = FakeResponseData().reponseKO
        let data = FakeResponseData().searchByIDData

        ApiURLProtocol.loadingHandler = { request in
            return (data, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.getGameByID(id: "99999", URLSession(configuration: configuration)) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .badResponse)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetGameByIDGivenBadURL() {
        //given
        let expectation = XCTestExpectation(description: "changing queue")

        let ApiService = ApiService()

        ApiService.getGameByID(id: "99 999", URLSession.shared) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .badURL)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetGameByIDGivenBadDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().incorrectData

        ApiURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.getGameByID(id: "99999", URLSession(configuration: configuration)) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .undecodableData)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetGameByIDGivenNoDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let error = FakeResponseData().error

        ApiURLProtocol.loadingHandler = { request in
            return (nil, response, error)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.getGameByID(id: "99999", URLSession(configuration: configuration)) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .noData)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    // MARK: - TEST getGameByName

    func testGetGameByNameGivenDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().searchByNameData

        ApiURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.searchGameName(name: "Catan", URLSession(configuration: configuration)) { result in
            if case .success(let games) = result {
                XCTAssertNotNil(games)
                XCTAssert((games as Any) is [ItemResult])
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetGameByNameGivenDataWithNoResultAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().searchByNameNoResultData

        ApiURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.searchGameName(name: "Catannanananana", URLSession(configuration: configuration)) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .noResult)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetGameByNameGivenBadResponseAndGoodData() {
        //given
        let response = FakeResponseData().reponseKO
        let data = FakeResponseData().searchByNameData

        ApiURLProtocol.loadingHandler = { request in
            return (data, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.searchGameName(name: "Catan", URLSession(configuration: configuration)) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .badResponse)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetGameByNameGivenBadURL() {
        //given
        let expectation = XCTestExpectation(description: "changing queue")

        let ApiService = ApiService()

        ApiService.searchGameName(name: "&àéç;da doa;", URLSession.shared) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .badURL)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetGameByNameGivenBadDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().incorrectData

        ApiURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.searchGameName(name: "Catan", URLSession(configuration: configuration)) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .undecodableData)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetGameByNameGivenNoDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let error = FakeResponseData().error

        ApiURLProtocol.loadingHandler = { request in
            return (nil, response, error)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.searchGameName(name: "Catan", URLSession(configuration: configuration)) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .noData)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    
    // MARK: - TEST getGames

    func testGetGamesGivenDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().searchByIDData

        ApiURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.getGames(arrayID: ["99999"], URLSession(configuration: configuration)) { result in
            if case .success(let game) = result {
                XCTAssertNotNil(game)
                XCTAssert((game as Any) is [GameData])
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetGamesGivenDataWithNilValueAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().searchByIDWithNilValueData

        ApiURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.getGames(arrayID: ["99999"], URLSession(configuration: configuration)) { result in
            if case .success(let game) = result {
                XCTAssertNotNil(game)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetGamesGivenBadResponseAndGoodData() {
        //given
        let response = FakeResponseData().reponseKO
        let data = FakeResponseData().searchByIDData

        ApiURLProtocol.loadingHandler = { request in
            return (data, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.getGames(arrayID: ["99999"], URLSession(configuration: configuration)) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .badResponse)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetGamesGivenBadURL() {
        //given
        let expectation = XCTestExpectation(description: "changing queue")

        let ApiService = ApiService()

        ApiService.getGames(arrayID: ["99  999"], URLSession.shared) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .badURL)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }

    func testGetGamesGivenBadDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let jsonData = FakeResponseData().incorrectData

        ApiURLProtocol.loadingHandler = { request in
            return (jsonData, response, nil)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.getGames(arrayID: ["99999"], URLSession(configuration: configuration)) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .undecodableData)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetGamesGivenNoDataAndGoodResponseAndNoError() {
        //given
        let response = FakeResponseData().reponseOK
        let error = FakeResponseData().error

        ApiURLProtocol.loadingHandler = { request in
            return (nil, response, error)
        }

        let expectation = XCTestExpectation(description: "changing queue")

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [ApiURLProtocol.self]

        let ApiService = ApiService()

        ApiService.getGames(arrayID: ["99999"], URLSession(configuration: configuration)) { result in
            if case .failure(let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .noData)
                expectation.fulfill()
            }
        }
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
