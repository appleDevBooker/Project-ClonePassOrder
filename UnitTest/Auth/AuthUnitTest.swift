//
//  UnitTest.swift
//  UnitTest
//
//  Created by 정덕호 on 2022/05/30.
//

import XCTest
@testable import Project_ClonePassOrder

class AuthUnitTest: XCTestCase {
    
    var sut: AuthViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = AuthViewModel()
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    func test_textFieldEmptyVaild를_호출시_email_password_파라미터에_둘중_하나라도빈문자열을_전달했을때_email변수와_password변수가_모두_nil인지() {
        //given
        let emailText = ""
        let paswordText = "123123"
        
        //when
        sut.userLogin(email: emailText, password: paswordText)
        
        //then
        XCTAssertNil(sut.email, "이메일이 Nil이 아닙니다.")
        XCTAssertNil(sut.password, "패스워드가 Nil이 아닙니다")
    }
    func test_textFiledEmptyVaild를_호출시_email_password_파라미터에_둘모두_비어있지않은_문자열을_전달했을때_전달받은값과_변수가_모두일치하는지() {
        //given
        let emailText = "qwer@naver.com"
        let passwordText = "123456"

        //when
        sut.userLogin(email: emailText, password: passwordText)
        
        //then
        XCTAssertEqual(sut.email, emailText, "이메일이 일치하지않습니다")
        XCTAssertEqual(sut.password, passwordText, "패스워드가 일치하지않습니다")
    }
    func test_textFieldEmptyString을_호출시_textfieldEmptyValue값이_emailEmpty인경우_아이디를입력해주세요를_리턴하는지() {
        //given
        sut.textfildEmpty.value = .emailEmpty
        
        //when
        let vaild = sut.textFieldEmptyString()
        
        //then
        XCTAssertEqual(vaild,"아이디를 입력해주세요!", "리턴하지않습니다")
    }
    func test_textFieldEmptyString을_호출시_textfieldEmptyValue값이_passwordEmpty인경우_비밀번호를입력해주세요를_리턴하는지() {
        //given
        sut.textfildEmpty.value = .passwordEmpty
        
        //when
        let vaild = sut.textFieldEmptyString()
        
        //then
        XCTAssertEqual(vaild,"비빌번호를 입력해주세요!", "리턴하지않습니다")
    }
    func test_loginUser를_호출후_로그인에_실패하는경우_loginFaildError가_전달되는지() {
        //given
        let mockAuthService = MockAuthService(loginResult: .failure(.loginFaildError))
        sut.service = mockAuthService
        
        sut.email = "qwer@naver.com"
        sut.password = "123456"
        
        //when
        sut.login()
        
        //then
        XCTAssertEqual(sut.authError.value, .loginFaildError, "loginFaildError가 아닙니다")
    }
    func test_loginUser를_호출후_authResult를_받는것에_실패한경우_authResultNilError가_전달되는지() {
        //given
        let mockAuthService = MockAuthService(loginResult: .failure(.authResultNilError))
        sut.service = mockAuthService
        
        sut.email = "qwer@naver.com"
        sut.password = "123456"
        
        //when
        sut.login()
        
        //then
        XCTAssertEqual(sut.authError.value, .authResultNilError, "authResultNilError가 아닙니다")
    }
    func test_loginUser를_호출후_로그인에_성공해서_전달된uid가_viewModel의_uid와_동일한지() {
        //given
        let userID = "awqmeklqwrklwerjlk"
        let mockAuthService = MockAuthService(loginResult: .success(userID))
        sut.service = mockAuthService
        
        sut.email = "qwer@naver.com"
        sut.password = "123456"
        
        //when
        sut.login()
        
        //then
        XCTAssertEqual(sut.uid.value, userID, "uid가 동일하지않습니다")
    }
    func test_logoutUser를_호출후_로그아웃에_실패하는경우_logoutFaildError를_전달하는지() {
        //given
        var mockAuthservice = MockAuthService()
        mockAuthservice.logoutResult = .failure(.logoutFaildError)
        sut.service = mockAuthservice
        
        //when
        sut.logout()
        
        //then
        XCTAssertEqual(sut.authError.value, .logoutFaildError, "logoutFaildError가 아닙니다")
    }
    func test_logoutUser를_호출후_로그아웃에_성공하는경우_logoutSuccess_value에_true를_전달하는지() {
        //given
        var mockAuthservice = MockAuthService()
        mockAuthservice.logoutResult = .success(())
        sut.service = mockAuthservice
        
        //when
        sut.logout()
        
        //then
        XCTAssertEqual(sut.logoutSuccess.value, true, "logoutSuccess.value가 true가 아닙니다")
    }
    func test_authError가_loginFaildError_인경우_아이디와비밀번호를확인후다시시도해주세요라는_문자열이_바인딩되는지() {
        //given
        sut.authError.bind { error in
            
            //then
            XCTAssertEqual(error.errorMessage, "아이디와 비밀번호를 확인후 다시 시도해주세요")
        }
        
        //when
        sut.authError.value = .loginFaildError
    }
    func test_authError가_authResultNilError_인경우_회원정보를불러오는것에실패했습니다다시시도해주세요_문자열이_바인딩되는지() {
        //given
        sut.authError.bind { error in
            
            //then
            XCTAssertEqual(error.errorMessage, "회원정보를 불러오는것에 실패했습니다 다시 시도해주세요")
        }
        
        //when
        sut.authError.value = .authResultNilError
    }
    func test_authError가_logoutFaildError_인경우_로그아웃에실패했습니다다시시도해주세요라는_문자열이_바인딩되는지() {
        //given
        sut.authError.bind { error in
            
            //then
            XCTAssertEqual(error.errorMessage, "로그아웃에 실패했습니다 다시 시도해주세요")
        }
        
        //when
        sut.authError.value = .logoutFaildError
    }
}
