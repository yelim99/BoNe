<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- jquery datepicker> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" integrity="sha512-uto9mlQzrs59VwILcLiRYeLKPPbS/bT71da/OEBYEwcdNUk8jYIy+D176RYoop1Da+f9mvkYrmj5MCLZWEtQuA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" integrity="sha512-aOG0c6nPNzGk+5zjwyJaoRUgCdOrfSDhmMID2u4+OIslr0GjpLKo7Xm0Ao3xmpM4T8AmIouRkqwj1nrdVsLKEQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<script>

</script>

<style>
	#v1 {
		background-color: #EBFFE3; 
		border-radius:20px; 
		margin-bottom:20px; 
		width:70%;
		padding: 10px;
		font-family: 'omyu_pretty';
		font-size: 1.2em;
	}
	
	#t {
		text-align: center;
		width: 80%;
		margin: 0 auto;
	}
	
	#t td { vertical-align: middle; padding: 5px; }
	
	#t td:first-child { text-align: right; }
	
	.small { font-size: 1.1em; }
	.medium { font-size: 1.2em; }
	.large { font-size: 1.3em; }
	
	#sall, #mall, #lall { margin-bottom: 5px; }
	
	#menu { font-family: 'KOTRAHOPE'; font-size:2.2em; }
</style>

<div class="row">
	<div align="center" class="col-md-8 offset-md-2 my-4" >
		<h2 id="menu">이용 요금 설정</h2>
	</div>
		<div class="container" id="v1">
			<form class="form-inline" name="pricef" id="pricef" action="${myctx}/sitter/user/price" method="post">
				<table class="table table-border" id="t">
					<tr>
						<td width="15%"><span class="small">🐕</span></td>
						<td width="20%"><span class="small">소형견</span></td>
						<td width="25%"><span class="small" style="color: gray;">7kg 미만</span></td>
						<td width="40%"><span class="small">
							<input type="number" class="form-control" id="sall" name="spetall" placeholder="1박케어"> 원<br>
							<input type="number" class="form-control" id="sday" name="spetday" placeholder="데이케어"> 원
						</td>
					</tr>
					<tr>
						<td width="15%"><span class="medium">🐕</span></td>
						<td width="20%"><span class="medium">중형견</span></td>
						<td width="25%"><span class="medium" style="color: gray;">7~14.9kg</span></td>
						<td width="40%"><span class="medium">
							<input type="number" class="form-control" id="mall" name="mpetall" placeholder="1박케어"> 원<br>
							<input type="number" class="form-control" id="mday" name="mpetday" placeholder="데이케어"> 원
						</td>
					</tr>
					<tr>
						<td width="15%"><span class="large">🐕</span></td>
						<td width="20%"><span class="large">대형견</span></td>
						<td width="25%"><span class="large" style="color: gray;">15kg 이상</span></td>
						<td width="40%"><span class="large">
							<input type="number" class="form-control" id="lall" name="lpetall" placeholder="1박케어"> 원<br>
							<input type="number" class="form-control" id="lday" name="lpetday" placeholder="데이케어"> 원
						</td>
					</tr>
					<tr>
						<td colspan="4" style="text-align: center;">
							<button class="btn btn-primary">확인</button>
						</td>
					</tr>
					
				</table>
			</form>
		</div>
			
		
</div>