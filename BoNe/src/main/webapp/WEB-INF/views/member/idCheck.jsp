<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript" src="./js/memberCheck.js"></script>

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
		font-size: 1.2em;
	}
	
	#text {
		font-size: 1.2em;
		margin-bottom: 10px;
	}
	
	#userid {
		margin-bottom: 15px;
	}
</style>

<div id="box" class="text-center">
	<form name="idf" action="idCheck" method="post">
		<label for="mid" id="text"> 아이디 입력</label>
		<input type="text" name="mid" id="userid" class="form-control" 
			placeholder="User ID" autofocus="autofocus">
		<button type="button" class="btn btn-info" onclick="id_check()">확 인</button>
	</form>
</div>


<!-- <div class="container m2" style="margin-top:2em">
	<form name="idf" action="idCheck" method="post">
		<label for="mid"> 아이디 입력</label>
		<input type="text" name="mid" id="userid" class="form-control" 
		placeholder="User ID" autofocus="autofocus">
		<button type="button" class="btn btn-success" onclick="id_check()">확 인</button>
	</form>
</div> -->


