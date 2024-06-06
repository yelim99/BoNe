<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js">
</script>

<style>
.y1{
	margin-bottom:70px;
	text-align:center;
	padding:30px;
	font-family: 'omyu_pretty';
	font-size: 1.2em;
}

.y2{
	background-color: #EBFFE3;
	padding:20px;
	text-align:left;
	height:320px;
	margin-bottom:15px;
	border-radius:20px;

}

.y3{
	background-color: #E2F6FF;
	padding:20px;
	text-align:left;
	height:320px;
	margin-bottom:30px;
	border-radius:20px;
}

.i{
	height:220px;
	width:250px;
	float:left;
	margin-right:40px;
	clear:both;
	background-color:gray;
}

#petImage {
	height:220px;
	width:250px;
}

a{
	float:right;
	color:inherit;
}

.info p { line-height: 2; }

#ebtn {
	padding: 3px 10px;
	float: right;
	margin-right:0;
	font-size:1em;
}

#eform {
	padding: 1px;
	width: 10%;
	display: flex;
	float: right;
	text-align:right;
}

#menu { font-family: 'KOTRAHOPE'; font-size:2.2em; }

</style>

<div class="y1">
	<div align="center" class="col-md-10 offset-md-1" >
		<h2 id="menu">내 반려동물 정보</h2>
	
		<a href="${myctx}/general/user/petregi" style="float:right;">정보 등록</a>
	</div>
	<br><br>

	
	<c:forEach var="item" items="${mypet}">
		<div align="center" class="col-md-10 offset-md-1" >
			<div class="y2">
				<div style="margin-bottom: 5px;">
					<form name="form" action="${myctx}/general/user/editPet" id="eform" method="POST">
						<input type="hidden" name="pno" value="${item.pno}">
						<button type="submit" class="btn" id="ebtn">수정</button>
					</form>
					
				</div>
				<div class="i">
					<img src="${myctx}/resources/pet_upload/${item.image}" id="petImage">
				</div>
				<div class="info">
					<p>
						<b>이름 :</b>   <b>${item.pname}</b>
						<br>
						<b>종류  :</b>   <b>  ${item.species1}</b>
						<br>
						<b>세부종 : </b>   <b> ${item.species2}</b>
						<br>
						<b>성별  :</b>   <b>  ${item.gender}</b>
						<br>
						<b>생년월일 :</b>   <b> ${item.bday}</b>
						<br>
						<b>몸무게 :</b>   <b> ${item.weight}</b>
						<br>
						<b>특이사항 :</b>   <b> ${item.particulars}</b>
					</p>
				</div>
			</div>
		</div>
		<br><br>
	</c:forEach>
</div>