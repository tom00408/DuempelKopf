//
//  DuempelKopfTests.swift
//  DuempelKopfTests
//
//  Created by Tom Tiedtke on 07.04.25.
//
@testable import DuempelKopf
import Testing

struct DuempelKopfTests {

    @Test func testBocke() throws {
            let myList = List(name: "BOCKTESTLISTE", players: ["Tom", "Anna"], info: "Test Info")
            let viewModel = SingleListViewModel(list: myList)

            #expect(viewModel.list.name == "BOCKTESTLISTE")
            #expect(viewModel.list.name == "BOCKTESTLISTE")
    }
    
    @Test func testeBocke2() throws {
        let i = 10
        #expect(i == 10)
        #expect(i == 5)
    }

}
