<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- js파일 참조-------------------------------- -->
<script type="text/javascript" src="${myctx}/js/memberCheck.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="${myctx}/js/post.js"></script>
<!-- ------------------------------------------ -->

<style>
body {
	margin: 0;
	padding: 0;
}

.container {
	max-width: 600px;
	margin: 0 auto;
	padding: 50px;
	background-color: #fff;
	border-radius: 30px;
	margin-top: 100px;
	border: 2px solid #FFD6A5;
	padding-top: 100px;
}


.form-group {
	margin-bottom: 15px;
	font-family: 'omyu_pretty';
	font-size: 1.2em;
}

.form-group2 {
	margin-bottom: 15px;
	display: flex;
	justify-content: center;
	font-family: 'omyu_pretty';
	font-size: 1.3em;
}

label {
	display: block;
	margin-bottom: 5px;
}

input[type="text"], input[type="password"], input[type="address"],input[type="date"] {
	width: 60%;
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

input[type="email"] {
	width: 35%;
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

input[type="tel"] {
	width: 25%;
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

select {
	width: 20%;
	padding: 5px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

textarea {
	width: 100%;
	padding: 10px;
	border: 1px solid #ccc;
	border-radius: 4px;
}

#btn {
	width: 90%;
	padding: 10px;
	background-color: #FFB600;
	color: #fff;
	border: none;
	border-radius: 30px;
	cursor: pointer;
	margin-top: 50px;
}

#btn:hover {
	background-color: #FFCD4A;
}

.error-message {
	color: #ff0000;
	margin-top: 10px;
}

.btn {
	padding: 5px;
	font-size: 0.9em;
	margin-left: 5px;
}
#menu { 
	font-family: 'KOTRAHOPE'; 
	font-size:2.7em; 
	padding-left: 150px;
}


</style>
</head>
<body></body>
<div class="container">
	<div id="menu" style="margin-bottom: 100px;">
		회 원 정 보 수 정
	</div>
	<form name="form" action="${myctx}/general/user/editG" method="POST">
		<input type="hidden" name="idx" value="${user.idx }">
		<div class="form-group">
			<label for="id">아 이 디 :</label> 
			<input type="text" id="id" name="mid" value ="${user.mid}" readonly required>
		</div>
		<div class="form-group">
			<label for="password">비 밀 번 호 :</label> 
			<input type="password" id="password" name="pwd" required
					placeholder="8~16자 대,소,특수문자 모두 포함">
		</div>
		<div class="form-group">
			<label for="confirmPassword">비 밀 번 호 확 인 :</label> <input
				type="password" id="confirmPassword" name="confirmPwd" required>
		</div>
		<div class="form-group">
			<label for="nickname">닉 네 임 :</label> 
			<input type="text" id="nickname" name="nickname" required value="${user.nickname}" readonly>
			<button type="button" onclick="open_nickcheck()"
				class="btn btn-outline-info">중복체크</button>
		</div>
		<div class="form-group">
			<label for="email">이메일:</label>
			<input type="text" id="email" name="email" required value="${user.email}" >
		</div>
		<div class="form-group">
			<label for="name">이 름 :</label> 
			<input type="text" id="name" name="uname" value="${user.uname}" required>
		</div>
		<div class="form-group">
			<label for="phone"> 휴 대 폰 번 호 :</label> 
			<input type="tel" id="ph1" name="tel1" value="${user.tel1}" required> 
			<input type="tel" id="ph2" name="tel2" value="${user.tel2}" required> 
			<input type="tel" id="ph3" name="tel3" value="${user.tel3}" required>
			
		</div>
		<div class="form-group">
			<label for="dob">생 년 월 일 :</label> 
			<input type="date" id="dob" name="birthday" value="${user.birthday}" readonly required>
		</div>
		<div class="form-group">
			<label for="address"> 주 소 :</label> 
			
			<input type="text" id="sample6_postcode" name="post" placeholder="우편번호" value="${user.post}"
					style="width: 40%; margin-bottom: 5px;" readonly> 
			<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"
					class="btn btn-outline-info"><br> 
			<input type="text" id="sample6_address" name="addr1" placeholder="주소" value="${user.addr1}"
					style="width: 70%; margin-bottom: 5px;" readonly><br> 
			<input type="text" id="sample6_detailAddress" name="addr2" placeholder="상세주소"
					value="${user.addr2}" style="width: 70%; margin-bottom: 5px;">
			<input type="text" id="sample6_extraAddress" name="detail" placeholder="참고항목"
					value="${user.addr3}" style="width: 70%" readonly>
		</div>

		<div class="form-group2">
		
			<button type="button" id="btn" onclick="member_check()" style="width: 300px; margin-top: 40px;">회원정보 수정</button>
		</div>
		<div class="error-message">
			<!-- error message  -->
		</div>
	</form>

</div>
<div class="d-flex justify-content-center" style="margin-top: 100px;">
		<!-- 탈퇴 모달 -->

		<div class="btns">
			<button type="button" class="btn btn-secondary" data-toggle="modal"
				data-target="#myModal" style="width: 90px;">탈퇴하기</button>
		</div>
		<div class="modal fade" id="myModal">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">알림</h4>
					</div>
					<div class="modal-body">정말 탈퇴하시겠습니까?</div>
					<div class="modal-footer">
						<form action="${myctx}/deleteMb" name="delete_mb" id="delete_mb" method="post">
							<input type="hidden" name="idx" value="${loginUser.idx}">
							<button type="submit" class="btn btn-danger"
								onclick="deleteConfirmation()">탈퇴</button>
						</form>
						<button type="button" class="btn btn-success" data-dismiss="modal">취소</button>
					</div>

				</div>
			</div>
		</div>
		<!--  삭제 모달 끝 -->
	</div>
