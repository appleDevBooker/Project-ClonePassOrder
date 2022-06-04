//
//  SignUpUnitTest.swift
//  UnitTest
//
//  Created by 정덕호 on 2022/05/31.
//

import XCTest
@testable import Project_ClonePassOrder

class SignUpUnitTest: XCTestCase {
    
    var sut: SignUpViewModel!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SignUpViewModel()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
    }
    
    func test_profileImageConrvertData를_호출시_이미지가_데이터로변환되어_profileImageData변수에_담기는지() {
        //gvien
        let image = UIImage(systemName: "star")
        
        //when
        sut.profileImageConrvertData(image: image!)
        
        //then
        XCTAssertNotNil(sut.profileImageData, "profileImageData가 nil입니다")
    }
    func test_textFieldEmptyVaild를_호출시_문자열을_전달한다면_ture를_리턴하는지() {
        //given
        let textfieldText = "wqdkljqwkdlj"
        
        //when
        let valid = sut.textFieldEmptyVaild(text: textfieldText)
        
        //then
        XCTAssertTrue(valid, "true가 아닙니다")
    }
    func test_textFieldEmptyVaild를_호출시_빈문자열을_전달한다면_textFieldEmpty변수가_false인지() {
        //given
        let textfieldText = ""
        
        //when
        let valid = sut.textFieldEmptyVaild(text: textfieldText)
        
        //then
        XCTAssertFalse(valid, "false가 아닙니다")
    }
    func test_userName이_8글자이하인경우_true를리턴하고_userName에_담기는지() {
        //give
        let userName = "한별이"
        
        //when
        let valid = sut.userNameToLongValid(userName: userName)
        
        //then
        XCTAssertTrue(valid, "userName이 8글자를 넘깁니다")
        XCTAssertEqual(sut.userName, userName, "userName이 담기지않았습니다")
    }
    func test_userName이_8글자이하인경우_false를리턴하고_userName이_빈문자열인지() {
        //given
        let userName = "한별이한별이한별이"
        
        //when
        let valid = sut.userNameToLongValid(userName: userName)
        
        //then
        XCTAssertFalse(valid, "userName이 8글자를 넘깁니다")
        XCTAssertEqual(sut.userName, "", "userName이 빈문자열이아닙니다")
    }
    func test_email이_이메일형식인경우_true리턴하고_email에_담기는지() {
        //given
        let email = "aoao1216@naver.com"
        
        //when
        let valid = sut.emailValidCheck(email: email)
        
        //then
        XCTAssertTrue(valid, "이메일 형식이 아닙니다")
        XCTAssertEqual(sut.email, email, "email에 담기지않았습니다")
    }
    func test_email이_이메일형식이아닌경우_false를리턴하고_email이_빈문자열인지() {
        //given
        let email = "gdlfknglkdfgklfkgdljfgjldfg"
        
        //when
        let vaild = sut.emailValidCheck(email: email)
        
        //then
        XCTAssertFalse(vaild, "이메일형식입니다")
        XCTAssertEqual(sut.email, "", "email이 빈문자열이 아닙니다")
    }
    func test_password가_8글자이상인경우_true를리턴하고_password에담기는지() {
        //given
        let password = "12345678"
        
        //when
        let valid = sut.passwordToShortValid(password: password)
        
        //then
        XCTAssertTrue(valid, "password가 8글자 미만입니다")
        XCTAssertEqual(sut.password, password, "password에 담기지않았습니다")
    }
    func test_password가_8글자미만인경우_false리턴하고_password가_빈문자열인지() {
        //given
        let password = "1234"
        
        //when
        let valid = sut.passwordToShortValid(password: password)
        
        //then
        XCTAssertFalse(valid, "password가 8글자 이상입니다")
        XCTAssertEqual(sut.password, "", "password가 빈문자열이 아닙니다")
    }
    func test_confirmPassword가_password와_같은경우_true를리턴하고_confirmPassword에_담기는지() {
        //given
        let confirmPassword = "12345678"
        sut.password = "12345678"
        
        //when
        let valid = sut.confirmPasswordValid(confirmPassword: confirmPassword)
        
        //then
        XCTAssertTrue(valid, "비밀번호가 일치하지않아 true를 리턴하지않습니다")
        XCTAssertEqual(sut.confirmPassword, confirmPassword, "비밀번호가 담기지않았습니다")
    }
    func test_confirmPassword가_password와_다른경우_false를리턴하고_confirmPassword가_빈문자열인지() {
        //given
        let confirmPassword = "12345678"
        sut.password = "qwertyyu"
        
        //when
        let valid = sut.confirmPasswordValid(confirmPassword: confirmPassword)
        
        //then
        XCTAssertFalse(valid, "비밀번호가 일치하여 false를 리턴하지않습니다")
        XCTAssertEqual(sut.confirmPassword, "", "비밀번호가 빈문자열이 아닙니다")
    }
    func test_phoneNumberConverting를_호출시_휴대폰번호가_82_01_xxxx_xxxx_형식으로_바뀌는지() {
        //given
        let phoneNumber = "01012341234"
        
    
        //when
         sut.phoneNumberConverting(phoneNumber: phoneNumber)
        
        //then
        XCTAssertEqual(sut.phoneNumber, "+82 10-1234-1234")
    }
    func test_필수약관을_모두동의한경우_true를리턴() {
        //given
        sut.is14YearsOld.value = true
        sut.isAgreeService.value = true
        sut.isAgreeLocationService.value = true
        sut.isAgreePrivacyInformation.value = true
        sut.isAgreePrivacyThirdPartyInformation.value = true
        
        //when
        let vaild = sut.requiredAgreedValid()
        
        //then
        XCTAssertTrue(vaild, "필수약관이 모두 동의되지않았습니다")
    }
    func test_필수약관중_하나라도동의하지않은경우_false를리턴() {
        //given
        sut.is14YearsOld.value = true
        sut.isAgreeService.value = false
        sut.isAgreeLocationService.value = true
        sut.isAgreePrivacyInformation.value = true
        sut.isAgreePrivacyThirdPartyInformation.value = true
        
        //when
        let vaild = sut.requiredAgreedValid()
        
        //then
        XCTAssertFalse(vaild, "필수약관이 모두 동의되지않았지만 false를 리턴하지않습니다")
    }
    func test_profileImageUpload호출시_이미지업로드에실패하는경우_uploadImageFaildError를_전달하는지() {
        //given
        var mockImageUploader = MockImageUploaderService()
        mockImageUploader.result = .failure(.uploadImageFaildError)
        sut.imageUploaderService = mockImageUploader
        sut.profileImageData = Data()
        
        //when
        sut.profileImageUpload()
        
        //then
        XCTAssertEqual(sut.imageUploadError.value, .uploadImageFaildError,"에러가 일치하지않습니다")
    }
    func test_profileImageUpload를호출시_이미지업로드에성공후_imageURL을_다운로드하는것에_실패한경우_downLoadImageFaildError_를전달하는지() {
        //given
        var mockImageUploader = MockImageUploaderService()
        mockImageUploader.result = .failure(.downLoadImageFaildError)
        sut.imageUploaderService = mockImageUploader
        sut.profileImageData = Data()
        
        //when
        sut.profileImageUpload()
        
        //then
        XCTAssertEqual(sut.imageUploadError.value, .downLoadImageFaildError,"에러가 일치하지않습니다")
    }
    func test_profileImageUpload를호출시_이미지업로드에성공_그리고_imageURL을_다운로드하는것에성공한후_String으로변환하는것에_실패한경우_URLError를_전달하는지() {
        //given
        var mockImageUploader = MockImageUploaderService()
        mockImageUploader.result = .failure(.URLError)
        sut.imageUploaderService = mockImageUploader
        sut.profileImageData = Data()
        
        //when
        sut.profileImageUpload()
        
        //then
        XCTAssertEqual(sut.imageUploadError.value, .URLError,"에러가 일치하지않습니다")
    }
    
    func test_profileImageUpload를호출시_이미지업로드에성공하는경우_전달된imageURL이_viewModel의imageURL로_성공적으로_전달하는지() {
        var mockImageUploader = MockImageUploaderService()
        //given
        mockImageUploader.result = .success("imageURL")
        sut.imageUploaderService = mockImageUploader
        sut.profileImageData = Data()
        
        //when
        sut.profileImageUpload()
        
        //then
        XCTAssertEqual(sut.imageURL.value, "imageURL","URL이 일치하지않습니다")
    }
    func test_SignUpUser를호출시_회원가입에실패하는경우_signUpFaildError를_전달하는지() {
        //given
        var mockSignupService = MockSignUpService()
        mockSignupService.result = .failure(.signUpFaildError)
        sut.signUpService = mockSignupService
        
        //when
        sut.signUpUser()
        
        //then
        XCTAssertEqual(sut.signUpError.value, .signUpFaildError,"에러가 일치하지않습니다.")
    }
    func test_SignUpUser를호출시_회원가입성공후_회원정보결과값이없는경우_resultNillError를_전달하는지() {
        //given
        var mockSignupService = MockSignUpService()
        mockSignupService.result = .failure(.resultNillError)
        sut.signUpService = mockSignupService
        
        //when
        sut.signUpUser()
        
        //then
        XCTAssertEqual(sut.signUpError.value, .resultNillError,"에러가 일치하지않습니다.")
    }
    
    func test_SignUpUser를호출시_회원가입에성공후_회원정보를Model로만들어_firestore에업로드하는것에실패한경우_upLoadFireStoreError를_전달하는지() {
        //given
        var mockSignupService = MockSignUpService()
        mockSignupService.result = .failure(.upLoadFireStoreError)
        sut.signUpService = mockSignupService
        
        //when
        sut.signUpUser()
        
        //then
        XCTAssertEqual(sut.signUpError.value, .upLoadFireStoreError,"에러가 일치하지않습니다.")
    }
    func test_SignUpUser를호출시_회원가입에성공후_회원정보를_firestore에업로드하는것까지_성공하는경우_signUpEnd변수가_ture인지() {
        //given
        var mockSignupService = MockSignUpService()
        mockSignupService.result = .success(())
        sut.signUpService = mockSignupService
        
        //when
        sut.signUpUser()
        
        //then
        XCTAssertTrue(sut.signUpEnd.value)
    }
    func test_phoneNumberAuth를호출시_유효하지않은전화번호일경우에_phoneNumberAuthError를_전달하는지() {
        //given
        var mockSignupService = MockSignUpService()
        mockSignupService.phoneAuthResult = .failure(.phoneNumberAuthError)
        sut.signUpService = mockSignupService
        
        //when
        sut.phoneNumberAuth()
        
        //then
        XCTAssertEqual(sut.signUpError.value, .phoneNumberAuthError, "에러형식이 다릅니다")
    }
    func test_phoneNumberAuth를호출시_verificationID가_nil인경우_verificationResultNillError를_전달하는지() {
        //given
        var mockSignupService = MockSignUpService()
        mockSignupService.phoneAuthResult = .failure(.verificationCodeAuthError)
        sut.signUpService = mockSignupService
        
        //when
        sut.phoneNumberAuth()
        
        //then
        XCTAssertEqual(sut.signUpError.value, .verificationCodeAuthError, "에러형식이 다릅니다")
    }
    func test_phoneNumberAuth를호출시_인증번호전송에성공한경우_verificationID에_id가전달되는지() {
        //given
        var mockSignupService = MockSignUpService()
        mockSignupService.phoneAuthResult = .success("id")
        sut.signUpService = mockSignupService
        
        //when
        sut.phoneNumberAuth()
        
        //then
        XCTAssertEqual(sut.verificationID.value, "id", "id가 전달되지않았습니다")
    }
    func test_phoneNumberAuthValid호출시_전송된인증번호와_입력한인증번호가_다른경우에_verificationCodeAuthError를전달하는지() {
        //given
        var mockSignupService = MockSignUpService()
        mockSignupService.credentialAuthResult = .failure(.verificationCodeAuthError)
        sut.signUpService = mockSignupService
        
        //when
        sut.phoneNumberAuthValid()
        
        //then
        XCTAssertEqual(sut.signUpError.value, .verificationCodeAuthError, "에러형식이 다릅니다")
    }
    func test_phoneNumberAuthValid호출시_인증결과값이Nil인경우에_verificationResultNillError를전달하는지() {
        //given
        var mockSignupService = MockSignUpService()
        mockSignupService.credentialAuthResult = .failure(.verificationResultNillError)
        sut.signUpService = mockSignupService
        
        //when
        sut.phoneNumberAuthValid()
        
        //then
        XCTAssertEqual(sut.signUpError.value, .verificationResultNillError, "에러형식이 다릅니다")
    }
    func test_phoneNumberAuthValid호출시_인증에성곤한경우_phoneNumberAuthSuccess에_true가전달되는지() {
        //given
        var mockSignupService = MockSignUpService()
        mockSignupService.credentialAuthResult = .success(true)
        sut.signUpService = mockSignupService
        
        //when
        sut.phoneNumberAuthValid()
        
        //then
        XCTAssertTrue(sut.phoneNumberAuthSuccess.value, "true가 전달되지않았습니다")
    }
    func test_signUpError가_signUpFaildError_인경우_회원가입에실패했습니다라는_문자열이_바인딩되는지() {
        //gvien
        sut.signUpError.bind { error in
            
            //then
            XCTAssertEqual(error.errorMessage, "회원가입에 실패했습니다")
        }
        
        //when
        sut.signUpError.value = .signUpFaildError
    }
    func test_signUpError가_resultNillError_인경우_결과값이nil입니다라는_문자열이_바인딩되는지() {
        //gvien
        sut.signUpError.bind { error in
            
            //then
            XCTAssertEqual(error.errorMessage, "결과값이 nil입니다")
        }
        
        //when
        sut.signUpError.value = .resultNillError
    }
    func test_signUpError가_upLoadFireStoreError_인경우_파이어스토어에러입니다라는_문자열이_바인딩되는지() {
        //gvien
        sut.signUpError.bind { error in
            
            //then
            XCTAssertEqual(error.errorMessage, "파이어스토어 에러입니다")
        }
        
        //when
        sut.signUpError.value = .upLoadFireStoreError
    }
    func test_signUpError가_phoneNumberAuthError_인경우_전화번호를다시입력해주세요라는_문자열이_바인딩되는지() {
        //gvien
        sut.signUpError.bind { error in
            
            //then
            XCTAssertEqual(error.errorMessage, "전화번호를 다시 입력해주세요")
        }
        
        //when
        sut.signUpError.value = .phoneNumberAuthError
    }
    func test_signUpError가_verificationCodeAuthError_인경우_인증번호가맞지않습니다라는_문자열이_바인딩되는지() {
        //gvien
        sut.signUpError.bind { error in
            
            //then
            XCTAssertEqual(error.errorMessage, "인증번호가 맞지 않습니다")
        }
        
        //when
        sut.signUpError.value = .verificationCodeAuthError
    }
    func test_signUpError가_verificationResultNillError_인경우_인증값이nil입니다라는_문자열이_바인딩되는지() {
        //gvien
        sut.signUpError.bind { error in
            
            //then
            XCTAssertEqual(error.errorMessage, "인증값이 nil입니다")
        }
        
        //when
        sut.signUpError.value = .verificationResultNillError
    }
    func test_imageUploadError가_uploadImageFaildError_인경우_이미지업로드실패다시시도해주세요_문자열이_바인딩되는지() {
        //given
        sut.imageUploadError.bind { error in
            //then
            XCTAssertEqual(error.errorMessage, "이미지 업로드 실패 다시시도해주세요")
        }
        //when
        sut.imageUploadError.value = .uploadImageFaildError
    }
    func test_imageUploadError가_downLoadImageFaildError_인경우_이미지다운로드실패다시시도해주세요_문자열이_바인딩되는지() {
        //given
        sut.imageUploadError.bind { error in
            //then
            XCTAssertEqual(error.errorMessage, "이미지 다운로드 실패 다시시도해주세요")
        }
        //when
        sut.imageUploadError.value = .downLoadImageFaildError
    }
    func test_imageUploadError가_URLError_인경우_URL변환에실패했습니다다시시도해주세요_문자열이_바인딩되는지() {
        
        //given
        sut.imageUploadError.bind { error in
            //then
            XCTAssertEqual(error.errorMessage, "URL 변환에 실패했습니다 다시시도해주세요")
        }
        //when
        sut.imageUploadError.value = .URLError
    }
    
    
}
