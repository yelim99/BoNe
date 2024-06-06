<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<script>
	function del(uno){
		var message="삭제하시겠습니까?"
		var result=confirm(message);
		if(result==true){
			let f = document.createElement('form');
			let obj;
		    obj = document.createElement('input');
		    obj.setAttribute('type', 'hidden');
		    obj.setAttribute('name', 'uno');
		    obj.setAttribute('value', uno);
		    
		    f.appendChild(obj);			
		    f.setAttribute('method', 'post');
		    f.setAttribute('action', 'delUsed');
		    document.body.appendChild(f);
		    f.submit();
		}
	}
</script>


<style>
	.v{	
		text-align:center;	
		width:500px;
		margin:auto;
	}
	
	#v1 {
		background-color: #EBFFE3; 
		border-radius:20px; 
		margin-bottom:20px; 
		width:75%;
		padding: 10px;
		text-align: center;
	}
	
	a{ color:inherit; font-size: 1.2em; }
	
	#menu { font-family: 'KOTRAHOPE'; font-size:2.2em; }
	
	.row {
		font-family: 'omyu_pretty';
		font-size: 1.2em;
	}
	
	#t { width: 80%; margin: 0 auto;}
	
</style>

<div class="row">
	<div align="center" class="col-md-8 offset-md-2 my-4" >
		<h2 id="menu">돌봄 일정</h2>
	</div>
		<div class="container" id="v1">
		
			<table class="table table-border" id="t">
				<tr>
					<td width="20%"><b>시작일</b></td>
					<td width="20%"><b>종료일</b></td>
					<td width="20%"><b>유저 닉네임</b></td>
					<td width="20%"><b>펫 닉네임</b></td>
					<td width="20%"><b>수정 | 삭제</b></td>
				</tr>
				<c:if test="${uvo eq null or empty uvo}">
					<tr>
						<td colspan="5">돌봄 일정이 없습니다</td>
					</tr>
				</c:if>
				<c:if test="${uvo ne null and not empty uvo}">
					<c:forEach var="uvo" items="${uvo}">
						<tr>
							<td><fmt:formatDate value="${uvo.sdate}" pattern="yyyy-MM-dd"/></td>
							<td><fmt:formatDate value="${uvo.fdate}" pattern="yyyy-MM-dd"/></td>
							<td>${uvo.unickname}</td>
							<td>${uvo.pname}</td>
							<td>
								<a href="usedEdit?uno=${uvo.uno}">수정</a> |
								<a href="javascript:del('${uvo.uno}')">삭제</a>
							</td>
						</tr>
					</c:forEach>
				</c:if>
				<tr>
					<td colspan="5">
					<p style="text-align:center">
						[<a href="usedAdd">돌봄 일정 추가</a>]
					</p>
					</td>
				</tr>
			</table>
	</div>
</div>