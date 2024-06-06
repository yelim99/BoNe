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
		/* box-shadow: 0 0 10px #8EDBA3 /* rgba(0, 0, 0, 0.1) */; */
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
		margin-bottom: 10px;
	}
	
	#btnNick {
		padding: 7px;
		font-size: 0.9em;
		margin-bottom: 10px;
	}
	
	table { margin-top: 25px; }
	
	#onChat:hover { cursor: pointer; font-weight:bold; }
	
	#tt { font-weight: bold; font-size: 1.1em;}
	
</style>


<body>

	<div id="chatBox">
		<h3  class="text-center" id="title" style="font-family: 'omyu_pretty';">
			<b>${croom.nickname}</b> 님의 채팅방
		</h3>
		
		<form name="findNick" id="findNick" method="get" action="room/find" onsubmit="return check()"
				class="form-inline">
			<input type="text" name="findNick" id="nick" class="form-control" 
					placeholder="검색할 닉네임을 입력하세요.">
			<button id="btnNick" class="btn btn-outline-success">검색</button>
		</form>
		
		<table class="table table-border text-center">
			<tr>
				<td colspan="3" id="tt">채팅 목록</td>
			</tr>
		
			<c:if test="${empty croomList && empty croomList2}">
				<tr>
					<td> 채팅 내역이 없습니다.</td>
				</tr>
			</c:if>
			
			<c:if test="${not empty croomList}">
				<c:forEach var="item" items="${croomList}">
					<tr>
						<td width=10%>🤍</td>
						<td width=40%>${item.nick2}</td>
						<td onclick="chat('${item.nick2}')" id="onChat">채팅하기</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${not empty croomList2}">
				<c:forEach var="item" items="${croomList2}">
					<tr>
						<td width=10%>🤍</td>
						<td width=40%>${item.nickname}</td>
						<td onclick="chat('${item.nickname}')" id="onChat">채팅하기</td>
					</tr>
				</c:forEach>
			</c:if>
		</table>

	</div>

</body>