<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.box {
	margin-top: 30px;
	margin-bottom: 40px;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}
.top {
	font-size: 18px;
	font-weight: bold;
	color: #445069;
	margin-top: 70px;
	margin-bottom: 70px;
}
.info {
	font-size: 14px;
	font-weight: bold;
	color: #445069;
	margin-top: 100px;
	margin-left: 10px;
	margin-right: 10px;
	margin-bottom: 20px;
}
#email {
	width: 260px;
	height: 45px;
	font-size: 15px;
	padding-left: 15px;
	border: 3px solid #F0B86E;
	border-radius: 15px;
}
.search {
	width: 100px;
	height: 40px;
	font-size: 15px;
	color: white;
	background-color: #F0B86E;
	border-radius: 18px;
	border : none;
	margin-bottom: 40px;
}
.search:hover {
	box-shadow: 0 0 10px #F0B86E;
}
#result {
	font-size: 16px;
	font-weight: bold;
	color: #6C3428;
	margin-left: 10px;
	margin-right: 10px;
	margin-bottom: 100px;
}

</style>

<body>

	<!-- 가입할 때 입력하신 이메일 정보를 입력해주세요. -->
	<div class="box">
		<div class="top">아이디 찾기 ✔ </div>
		<div class="title">
			<img src="${myctx}/images/logo_b2.png" style="width: 250px;">
		</div>
		<div class="info">* 가입할 때 입력하신 이메일 정보를 입력해주세요.</div>
			<form name="emailForm" id="emailForm" method="post">
				<div class="form-group">
					<input type="text" id="email" name="email" placeholder=" email" required>
				</div>
			</form>
		<button class="search" onclick="checkEmail()">확인</button>
		
		<!-- 아이디 표시 영역 -->
    	<div id="result"></div>
	</div>
	
</body>

<script>
function checkEmail() {
    const email = $("#email").val();

    $.ajax({
        url: "checkEmailFindId",
        type: "POST",
        contentType: 'application/json',
        dataType:'json',
        data: JSON.stringify({ email: email }),
        cache:false,
        success: function(response) {
            if (response.userid) {
                $("#result").show().text("📌 "+ email + "님의 아이디는 " + response.userid + " 입니다.");
            } else {
                $("#result").show().text("일치하는 이메일 정보가 없습니다.");
            }
        },
        error: function(xhr, status, error) {
            console.error("서버와의 통신 오류 발생");
        }
    });
}
</script>

