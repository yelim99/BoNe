<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.row {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 0 auto;
	margin-top: 100px;
	margin-bottom: 200px;
}
#d {
	height: 250px;
}

#sitter, #general {
	margin-right: 20px;
	float: left;
	height: 90%;
	width: 40%;
	text-align: center;
	padding: 70px 0;
	font-weight: bold;
	font-size: 1.8em;
	cursor: pointer;
	font-family: 'omyu_pretty';
}
#general {
	background-color: #E2F6FF;
	border-radius: 100px;
}

#general:hover {
	background-color: #FFF0F5;
	box-shadow : 0 0 10px #FFF0F5;
}
#sitter {
	background-color: #EBFFE3;
	border-radius: 100px;
}

#sitter:hover {
	background-color: #FFF0F5;
	box-shadow : 0 0 10px #FFF0F5;
}

</style>

<div class="row">
	<div class="col-8 offset-2" id="d">
		<div id="general" onclick="location.href='${myctx}/joinG';">
			<span>일반회원으로 <br> 가입하기
			</span>
		</div>
		<div id="sitter" onclick="location.href='${myctx}/joinS';">
			<span>펫시터로 <br> 가입하기
			</span>
		</div>
	</div>
</div>