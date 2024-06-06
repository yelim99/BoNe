<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<style>
	.jumbotron, .navbar, footer {
		display: none;
	}
</style>

<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/sockjs.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/stomp.min.js"></script>
	
<%-- <script type="text/javascript" src="${myctx}/js/chat.js"></script> --%>

<script type="text/javascript">
	
	function check(){
		if(!$('#nick').val()){
			alert('닉네임을 입력하세요.');
			$('#nick').focus();
			return false;
		}
		return true;
	}
	
	function chat(value){
		location.href='${myctx}/chat?nickname='+value;
		console.log(value);
	} 

</script>

<style>

	body { background-color: #E3F4F4  }
	
	#chatBox {
		width: 95%;
		height: 95%;
		margin: 0 auto;
		border-radius: 5px;
		padding: 20px;
		font-family: 'omyu_pretty';
	}
	
	#title {
		margin-bottom: 30px;
	}
	
	#nick {
		width: 85%;
		margin-right: 10px;
	}
	
	#btnNick {
		padding: 7px;
		font-size: 0.9em;
	}
	
	#onChat:hover { cursor: pointer; font-weight:bold; }
</style>


<body>

	<div id="chatBox">
		<h3  class="text-center" id="title" style="font-family: 'omyu_pretty';">
			<b>${croom.nickname}</b> 님의 채팅방
		</h3>
		
		<form name="findNick" id="findNick" method="get" action="find" onsubmit="return check()"
				class="form-inline">
			<input type="text" name="findNick" id="nick" class="form-control" 
					placeholder="검색할 닉네임을 입력하세요.">
			<button id="btnNick" class="btn btn-outline-success">검색</button>
		</form>
		
		<table class="table table-border text-center">
			<c:forEach var="item" items="${userList}">
				<tr>
					<td>${item.nickname}</td>
					<td onclick="chat('${item.nickname}')" id="onChat">채팅하기</td>
				</tr>
			</c:forEach>
		</table>

	</div>

</body>