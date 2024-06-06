<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- jquery datepicker> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<script>

</script>

<style>
	
</style>

<div class="row">
	<div align="center" class="col-md-8 offset-md-2 my-4" >
		<h2 style="font-weight: bold">돌봄 일정</h2>
	</div>
		<div class="container" style="background-color: #EBFFE3; border-radius:20px; margin-bottom:20px; width:80%;" >
			<!-- <form name="schedule" action="" onsubmit=""> -->
				<table style="width:100%">
					<tr>
						<td style="font-weight:bold; padding:8px; width:15%;">
							돌봄 일정
						</td>
						<td style="width:75%;">
							<input type="date" id="sdate" style="margin-top:5px;"> ~ 
							<input type="date" id="edate">
							<button class="btn btn-outline-success btn-sm" 
									style="padding:4px 7px; margin-bottom:6px; margin-left:5px;">조회</button>
						</td>
						<td style="text-align:right; padding:8px; width:10%;">등록</td>
					</tr>
				</table>
			<!-- </form> -->
			
			<table class="table table-borderless" style="width: 100%;">
				<tr>
					<td rowspan="4" style="vertical-align:middle; text-align:center; width: 40%">
						달력
					</td>
					<td style="font-weight:bold; width:20%; padding:7px;">6월 2일 ~ 3일</td>
					<td style="width:40%; padding:7px; font-size:0.9em;">'닉네임'님 - '반려동물 이름'</td>
				</tr>
				<tr>
					<td style="font-weight:bold; padding:7px;">6월 8일 ~ 9일</td>
					<td style="padding: 7px;">'닉네임'님 - '반려동물 이름'</td>
				</tr>
				<tr>
					<td style="font-weight:bold; padding:7px;">6월 8일 ~ 9일</td>
					<td style="padding:7px; font-size:0.9em;">'닉네임'님 - '반려동물 이름'</td>
				</tr>
				<tr>
					<td style="font-weight:bold; padding: 7px;">6월 8일 ~ 9일</td>
					<td style="padding: 7px; font-size:0.9em;">'닉네임'님 - '반려동물 이름'</td>
				</tr>
				
			</table>
		
		</div>
		
		<div class="container" style="background-color: #E2F6FF; border-radius:20px; width:80%;">
			<table class="table table-borderless" style="width: 100%;">
				<tr>
					<td colspan="2" style="font-weight:bold; padding:8px;">돌봄 기록</td>
					<td style="text-align:right; font-size:0.9em; padding:8px;">더보기</td>
				</tr>
				<tr>
					<td style="width:7%; padding:7px; font-weight:bold;">6/3</td>
					<td style="width:33%; padding:7px; font-weight:bold;">이용자 닉네임 - 반려동물 이름</td>
					<td style="width:60%; padding:7px; font-size:0.9em;">돌봄 기록 내용 (뭐 했는지, 특이사항 등등)</td>
				</tr>
				<tr>
					<td style="padding:7px; font-weight:bold;">6/2</td>
					<td style="padding:7px; font-weight:bold;">이용자 닉네임 - 반려동물 이름</td>
					<td style="padding:7px; font-size:0.9em;">돌봄 기록 내용 (뭐 했는지, 특이사항 등등)</td>
				</tr>
				<tr>
					<td style="padding:7px; font-weight:bold;">5/29</td>
					<td style="padding:7px; font-weight:bold;">이용자 닉네임 - 반려동물 이름</td>
					<td style="padding:7px; font-size:0.9em;">돌봄 기록 내용 (뭐 했는지, 특이사항 등등)</td>
				</tr>
			</table>
		</div>
		
</div>