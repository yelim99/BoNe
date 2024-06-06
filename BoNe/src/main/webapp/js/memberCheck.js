
//----아이디 중복체크-----
// let win = null;
function open_idcheck() {
	win = window.open("idCheck", "idCheck", "width=400, height=300, left=200, top=200");
		
} //------------------------------


function set_id(uid) {
	opener.document.form.mid.value = uid;
	self.close();
	
}	//----------------------------


function id_check() {
	if (!idf.mid.value) {
		alert('아이디를 입력해야 해요!');
		idf.mid.focus();
		return;
	}
	if (!isUserid(idf.mid)) {
		alert('아이디는 영문자, 숫자, _, !로 4~8자 까지 가능해요');
		idf.mid.select();
		return;
	}
	idf.submit();
}	//----------------------------


//----------닉네임 중복체크-----

function open_nickcheck() {
	win = window.open("nickCheck", "nickCheck", "width=400, height=300, left=200, top=200");
		
} //------------------------------


function set_nickname(unick) {	
	// window > document > forms
	opener.document.form.nickname.value = unick;
	
	self.close();
	
}	//----------------------------


function nick_check() {
	if (!nickf.nickname.value) {
		alert('닉네임 입력해야 해요!');
		nickf.nickname.focus();
		return;
	}
	if (!isNick(nickf.nickname)) {
		alert('닉네임은 2자 이상으로, 특수문자 사용은 불가해요!');
		nickf.nickname.select();
		return;
	}
	nickf.submit();
}	//----------------------------


 function member_check() {
	 
	 // *아이디는 영문자, 숫자, _, !만 사용 가능해요.
	 if (!isUserid(form.mid)) {
		alert('*아이디는 영문자로 시작하고, 숫자, _, !만 4~8자까지 가능해요!');
		form.mid.select();
		return; 
	 }
	 
	 
	 // *비밀번호는 문자, 숫자, !, . 포함해서 4~8자리 이내
	 if (!isPasswd(form.pwd)) {
		 alert('*비밀번호는 문자, 숫자, !, _, . 포함해서 4~8자리 이내이어야 해요!');
		 form.pwd.select();
		 return;
	 }
	 
	 // 비번, 비번확인 값 일치 여부 체크 (form.mode.value != 9 &&)
	 if (form.pwd.value != form.confirmPwd.value) {
		 alert('비밀번호와 비밀번호 확인 값이 달라요!');
		 form.confirmPwd.select();
		 return;
	 }
	 
	 
	 // 닉네임
	 if (!isNick(form.nickname)) {
		 alert('닉네임은 2자 이상으로, 특수문자 사용은 불가해요!');
		 form.nickname.select();
		 return;
	 }
	 
	 
	  // 이메일 체크 (.com / co.kr / .net 등등)
	 if (!isEmail(form.email)){
		 alert('이메일 형식에 맞지 않아요!');
		 form.email.select();
		 return;
	 }
	 
	 // 이름
	 if (!isKor(form.name)) {
		 alert('이름은 한글로 2자 이상 가능해요!');
		 form.name.select();
		 return;
	 }
	 
	 if (!isMobile(form.tel1, form.tel2, form.tel3)){
		 alert('잘못된 전화번호 형식이에요!')
		 form.tel1.select();
		 return;
	 }
	 
	 
	 form.submit();
 }	// member_check() --------------------


function isEmail(input) {
	let val = input.value;
	let pattern = /^[\w-]+(\.[\w]+)*@([a-zA-Z]+\.)+[a-z]{2,3}$/
	let b = pattern.test(val);
	return b;
}
 

 function isMobile(input1, input2, input3) {
	 let val = input1.value+"-"+input2.value+"-"+input3.value;
	 let pattern = /\b(010|011)[-][\d]{3,4}[-][\d]{4}\b/;
	 let b = pattern.test(val);
	 return b;
 }	// isMobile() -------------------------
 

// *비밀번호는 문자, 숫자, !, _, . 포함해서 4~8자리 이내
 function isPasswd(input) {
	 let val = input.value;
	 let pattern = /^[\w!\.]{4,8}$/;
	 let b = pattern.test(val);
	 return b;
 }	// isPasswd() -------------------------
 

 function isUserid(input) {
	 let val = input.value;
	 let pattern = /^([A-Za-z])[A-Za-z0-9_!]{3,7}$/;
	 let b = pattern.test(val);
	 return b;
	 
 }	// isUserid() ---------------------
 
 
 function isNick(input){
 	let val = input.value;
 	let pattern = /^[A-Za-z가-힣0-9_!]{2,7}$/;
 	let b = pattern.test(val);
 	return b;
 }
 

 function isKor(input) {
	 // alert(input.value);
	 let val = input.value;
	 let pattern=/^[가-힣]{2,}$/;	
	 let b = pattern.test(val);
	 return b;
 }
 
 
 
 
 