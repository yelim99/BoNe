<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!--  ------------------------------------ -->
<script type="text/javascript" src="${myctx}/js/memberCheck.js"></script>
<!--  ------------------------------------ -->



<style>
	.jumbotron, .navbar, footer {
		display: none;
	}
	
	#box {
		width: 95%;
		height: 270px;
		margin: 0 auto;
		box-shadow: 0 0 10px #8EDBA3 /* rgba(0, 0, 0, 0.1) */;
		border-radius: 5px;
		padding: 20px;
		padding-top: 10px;
		font-family: 'omyu_pretty';
		font-size: 1.2em;
	}
	
	.text {
		font-size: 1.1em;
		margin-bottom: 10px;
	}
	
	#nickname {
		margin-bottom: 15px;
	}
</style>

<div id="box" class="text-center">
	<c:if test="${result eq 'fail'}">
		<div class="container m2" style="margin-top: 2em">
			<h3 class="text">
				닉네임 [<span class="text-danger">${nickname}</span>]은 이미 사용 중입니다.
			</h3>
			<br>
			<form name="nickf" action="nickCheck" method="post">
				<label for="nickname" class="text">닉네임 입력</label> 
				<input type="text" name="nickname" id="nickname" class="form-control" 
						placeholder="User nickname" autofocus="autofocus">
				<button type="button" class="btn btn-warning" onclick="nick_check()">확인</button>
			</form>
		</div>
	</c:if>
	
	<c:if test="${result eq 'success'}">
		<div class="container m2" style="margin-top:2em; padding-top: 30px;">
			<h3 class="text">
				닉네임 [<span class="text-primary">${nickname}</span>]은 사용할 수 있습니다.
			</h3>
			<br>
			<button class="btn btn-success" onclick="set_nickname('${nickname}')">닫기</button>
		</div>
	</c:if>
</div>

