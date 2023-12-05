//
//  SignUpViewModelTests.swift
//  MovieLogTests
//
//  Created by KangMingyo on 12/2/23.
//

import XCTest
import Combine
@testable import MovieLog

final class SignUpViewModelTests: XCTestCase {
    
    var sut: SignUpViewModel!
    var subscriptions = Set<AnyCancellable>()

    // 각각의 test case가 실행되기 전마다 호출되어 각 테스트가 모두 같은 상태와 조건에서 실행될 수 있도록 만들어주는 메서드
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SignUpViewModel()
    }

    // 각각의 test 실행이 끝난 후마다 호출되는 메서드, 보통 setUpWithError()에서 설정한 값들을 해제할 때 사용
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }

    func test_유효한_이메일을_입력했을때_isValid_한지() {
        //Given
        let expectation = XCTestExpectation(description: "Valid email expectation")
        var isValidEmail = false
        
        //When
        sut.isValidEmailPublisher
            .sink { isValid in
                isValidEmail = isValid
                if isValid {
                    expectation.fulfill()
                }
            }.store(in: &subscriptions)
        
        sut.email = "kang15567@gmail.com"
        
        //then
        XCTAssertTrue(isValidEmail, "Valid email expectation")
    }
    
    func test_유효하지않은_이메일을_입력했을때_isValid_하지_않는지() {
        // Given
        let expectation = XCTestExpectation(description: "Invalid email expectation")
        var isValidEmail = false
        
        // When
        sut.isValidEmailPublisher
            .sink { isValid in
                isValidEmail = isValid
                if !isValid {
                    expectation.fulfill()
                }
            }.store(in: &subscriptions)
        
        sut.email = "test.com" // 유효하지 않은 이메일 입력
        
        // Then
        XCTAssertFalse(isValidEmail, "Invalid email expectation")
    }
}
