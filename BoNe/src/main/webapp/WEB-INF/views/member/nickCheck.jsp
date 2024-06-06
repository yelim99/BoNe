<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<script type="text/javascript" src="${myctx}/js/memberCheck.js"></script>


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
		padding-top: 70px;
		font-family: 'omyu_pretty';
		font-size: 1.3em;
	}
	
	#text {
		margin-bottom: 10px;
	}
	
	#nickname {
		margin-bottom: 15px;
	}
</style>

<div id="box" class="text-center">
	<form name="nickf" action="nickCheck" method="post">
		<label for="nickname" id="text">닉네임 입력</label> 
		<input type="text" name="nickname" id="nickname" class="form-control" 
				placeholder="User nickname" autofocus="autofocus">
		<button type="button" class="btn btn-info" onclick="nick_check()">확인</button>
	</form>
</div>