//
//  PandaNetworkTests.swift
//  FuzeTests
//
//  Created by Giuliano Accorsi on 06/11/22.
//

import XCTest
@testable import Fuze

final class PandaNetworkTests: XCTestCase {
    var sut: PandaNetwork!

    override func setUp() {
        super.setUp()
        sut = PandaNetwork(getRequest: <#T##GetRequestable#>)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func test_testMethod(){
    }
}
