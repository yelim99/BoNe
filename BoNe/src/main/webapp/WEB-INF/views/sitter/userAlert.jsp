<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	.jumbotron, .navbar, footer {
		display: none;
	}
	
	#box {
		width: 95%;
		height: 80%;
		margin: 0 auto;
		box-shadow: 0 0 10px #8EDBA3 /* rgba(0, 0, 0, 0.1) */;
		border-radius: 5px;
		padding: 20px;
		padding-top: 30px;
		font-family: 'omyu_pretty';
		font-size: 1.25em;
		
	}
	#pimg { width: 100%; height: 90%;}
	
	#nicksp { color: #50AF49; }
	
	#menu { font-family: 'KOTRAHOPE'; font-size:2em; }
	
</style>

<div id="box" class="text-center">
	<h3 id="menu"><span id="nicksp">${pet.nickname}</span> 님의 펫 정보</h3><br>
	<table class="table table-borderless">
		<tr>
			<td></td>
			<td><b>이름</b></td>
			<td>${pet.pname}</td>
		</tr>
		<tr>
			<td></td>
			<td><b>종</b></td>
			<td>${pet.species1}</td>
		</tr>
		<tr>
			<td rowspan="3" style="width: 40%;">
				<img id="pimg" src="${myctx}/resources/pet_upload/${pet.image}">
			</td>
			<td><b>세부 종</b></td>
			<td>${pet.species2}</td>
		</tr>
		<tr>
			<td><b>성별</b></td>
			<td>${pet.gender}</td>
		</tr>
		<tr>
			<td><b>몸무게</b></td>
			<td>${pet.weight} kg</td>
		</tr>
		<tr>
			<td></td>
			<td><b>생일</b></td>
			<td>${pet.bday}</td>
		</tr>
		<tr>
			<td></td>
			<td><b>특이사항</b></td>
			<td>${pet.particulars}</td>
		</tr>
	</table>
	
</div>


