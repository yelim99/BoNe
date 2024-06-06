<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.List"%>
<%@page import="com.sitter.model.SitterVO"%>

<script type="text/javascript">
	window.onload = function() {
		today = new Date();		
		today = today.toISOString().slice(0, 10);
		sd = document.getElementById("sdate");
		sd.value = today;
		fd = document.getElementById("fdate");
		fd.value = today;
	}
	
	
	
	function check(){
		if(mf.sdate.value==""){
			alert('시작일을 입력하세요');
			mf.sdate.focus();
			return;
		}
		if(mf.fdate.value==""){
			alert('종료일을 입력하세요');
			mf.fdate.focus();
			return;
		}
		
		if(mf.sdate.value>mf.fdate.value){
			alert('시작일이 종료일보다 후일일 수 없습니다 수정해주세요');
			mf.sdate.focus();
			return;
		}		
		
		if(mf.unickname.value==""){
			alert('유저 닉네임을 입력하세요');
			mf.unickname.focus();
			return;
		}
		
		if(mf.pname.value==""){
			alert('펫 닉네임을 입력하세요');
			mf.pname.focus();
			return;
		}
		
		mf.submit();
	}
</script>

<style>
	#v1 {
		background-color: #EBFFE3; 
		border-radius:20px; 
		margin-bottom:20px; 
		width:50%;
		padding: 10px;
	}
	table td:first-child { text-align: right; padding-right: 30px;}
	
	#menu { font-family: 'KOTRAHOPE'; font-size:2.7em; }
	
	.row {
		font-family: 'omyu_pretty';
		font-size: 1.2em;
	}
	.btn { font-size: 1em; }
</style>

	<div class="row">
		<div align="center" class="col-md-8 offset-md-2 my-4" >
			<h2 id="menu">돌봄 일정 추가</h2>
		</div>
		<div class="container" id="v1">
	
		<form name="mf" action="usedAdd" method="post">
			<table class="table table-borderless">
				<tr>
					<td width="50%">
						<b>시작일</b>
					</td>
					<td width="50%">
						<input type="date" name="sdate" id="sdate" value="">						
					</td>
				</tr>
				
				<tr>
					<td>
						<b>종료일</b>
					</td>
					<td>
						<input type="date" name="fdate" id="fdate" value="">
					</td>
				</tr>
				
				<tr>
					<td>
						<b>이용자 닉네임</b>
					</td>
					<td>
						<input type="text" name="unickname" value="" placeholder="이용자 닉네임">
					</td>
				</tr>
				
				<tr>
					<td>
						<b>펫 이름</b>
					</td>
					<td>
						<input type="text" name="pname" value="" placeholder="펫 이름">
					</td>
				</tr>
				
				<tr>
					<td colspan="2" style="text-align: center; padding-right: 0;">
						<button type="button" class="btn btn-outline-primary" onclick="check()">돌봄 일정 저장하기</button>
						<button type="reset" class="btn btn-outline-warning">다시 쓰기</button>
					</td>
				</tr>
			</table>	
		</form>
	</div>
</div>
