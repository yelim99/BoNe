<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
body {
	/* font-family: Arial, sans-serif; */
	/* background-color: #FFCD4A; */
	margin: 0;
	padding: 0;
}

.container {
	max-width: 470px;
	margin: 0 auto;
	padding: 62px;
	padding-left: 70px;
	background-color: #fff;
	border-radius: 30px;
	margin-top: 100px;
	border: 2px solid #FFD6A5;
}

h2 {
	text-align: center;
	margin-bottom: 20px;
}

.form-group {
	margin-bottom: 15px;
	font-family: 'omyu_pretty';
	font-size: 1.2em;
}

label {
	display: block;
	margin-bottom: 5px;
}

input[type="text"], input[type="password"] {
	width: 95%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

input[type="submit"] {
	width: 95%;
	padding: 7px;
	background-color: #FFB600;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
}

input[type="submit"]:hover {
	background-color: #FFCD4A;
}

.error-message {
	color: #ff0000;
	margin-top: 10px;
}
a {
	color: black;
}
a:hover {
	text-decoration: none;
}

.small-font {
	font-family: 'omyu_pretty';
	font-size: 1.1em;
	font-weight: normal;
	padding-left: 30px;
}

.logo {
	margin-top: 20px;
	margin-bottom: 80px;
	padding-left: 50px;
}

.or {
	padding-left: 150px;
	margin-bottom: 15px;
	font-family: 'omyu_pretty';
	font-size: 1.2em;
}
</style>
</head>
<body>
	<div class="container">
		<div id="menu" class="logo"><img src="${myctx}/images/logo_b2.png" style="width: 250px;"></div>
		<form action="${myctx}/login" method="POST"
			onsubmit="return logincheck()">
			<div class="form-group">
				<input type="text" id="username"
					name="mid" value="${cookie['mid'].value}" placeholder="ID" required>
			</div>
			<div class="form-group">
				<input type="password"
					id="password" name="pwd" placeholder="PASSWORD" required>
			</div>
			<div class="form-group">
				<label for="saveId"> <input type="checkbox" name="saveId"
					id="saveId" ${cookie['mid'] ne null ? 'checked' : ''}  style="font-size: 1.0em;"> 아이디
					저장
				</label>
			</div>
			<div class="form-group">
				<input type="submit" style="height: 43px;" value="로그인">
			</div>

			<div class="or">or</div>

			<div class="button-login">
				<a href="javascript:kakaoLogin();"> 
					<img id="kakaoLogin" src="${myctx}/images/kakao.PNG" style="width: 95%; height: 43px;" class="rounded">
				</a>
			</div>
			<div style="margin-top: 13px;" class="small-font">
				<a href="${myctx}/check" id="regi">회원가입</a>&nbsp;&nbsp;|&nbsp;&nbsp; 
				<a href="${myctx}/findId">아이디 찾기</a>&nbsp;&nbsp;|&nbsp;&nbsp;
				<a href="${myctx}/findPw">비밀번호 찾기</a>
				
			</div>

		</form>

	</div>


	<script>
	
	var myctx = "${myctx}";
	
	// 사용할 앱의 JavaScript 키
	window.Kakao.init('95783301fd03fa983b31d7af57a434b2');

	function kakaoLogin() {
	    window.Kakao.Auth.login({
	        scope: 'profile_nickname, account_email',
	        success: function(response) {
	            console.log(response) // 로그인 성공하면 받아오는 데이터
	            window.Kakao.API.request({ // 사용자 정보 가져오기 
	                url: '/v2/user/me',
	                success : function(res) {
	                    const kakao_account = res.kakao_account;
	                    const user_email = kakao_account.email;
	                    
	                 	// POST 요청을 보낼 데이터
	                    var data = {"email": user_email};
	           
	                	 // AJAX 요청 보내기
	                    $.ajax({
	                        url: 'kakaoLogin',
	                        type: 'POST',
	                        contentType: 'application/json',
	                        dataType:'json',
	                        data: JSON.stringify(data),
	                        cache:false,
	                        success: function(response) {
	                        	// 서버로부터 받은 응답 처리
	                            if (response.msg) {
	                                alert(response.msg);
	                            }
	                            if (response.loc) {
	                                window.location.href = myctx + response.loc;
	                            }
	                        },
	                        error: function(jqXHR, textStatus, errorThrown) {
	                        	
	                            console.error('Error:', textStatus, errorThrown);
	                        }
	                    });
	            
	                }
	            });
	        },
	        fail: function(error) {
	            console.log(error);
	        }
	    });
	}

	function kakaoLogout() {
		if (!Kakao.Auth.getAccessToken()) {
			alert('로그아웃 하였습니다.');
			window.location.href = '${myctx}/logout';
		}
	  	Kakao.Auth.logout(function (response) {
			alert('로그아웃 하였습니다.');
			window.location.href = '${myctx}/logout';
		});
	};
	
	
	</script>
</body>