<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.List"%>
<%@page import="com.sitter.model.SitterVO"%>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.*" %>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.css">

<script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>

<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/locales-all.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!-- 웹소켓 -->
<script src="http://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/sockjs.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/stomp.min.js"></script>

<script type="text/javascript">
	let win = null;
	function open_chat() {
		win = window.open("${myctx}/room", "room", "width=450, height=500, left=200, top=200");
		// var url='${myctx}/chat?unickname='+value;
		// win = window.open(url, "chat", "width=400, height=440, left=300, top=200");
	} 
</script>


<style>
.v{
	margin-bottom:100px;
	text-align:center;
	padding:30px;
	font-family: 'omyu_pretty';
	font-size: 1.2em;
}
.v2{
	background-color:rgb(255, 251, 224);
	padding:20px;
	text-align:left;
	line-height:1.7;
	height:295px;
	margin-bottom:30px;
	border-radius:20px;
	
	overflow: auto;
	-ms-overflow-style: none; /* 인터넷 익스플로러 */
	scrollbar-width: none; /* 파이어폭스 */
}

.v2::-webkit-scrollbar {
	display: none; /* 크롬, 사파리, 오페라, 엣지 */
}

.v3{
	background-color:rgb(243, 232, 166);
	padding:20px;
	text-align:left;
	height:460px;
	float: left;
	border-radius:20px;
	width: 100%;
}
.v4{
	background-color:rgb(255, 251, 224);
	padding:20px;
	text-align:left;
	height:300px;
	width:49%;
	float:left;
	border-radius:20px;
	margin-bottom:30px;
}
.v5{
	background-color:rgb(243, 232, 166);
	padding:20px;
	text-align:left;
	height:300px;
	width:49%;
	float:right;
	border-radius:20px;
	margin-bottom:30px;
}

a{
	float:right;
	color:inherit;
}

#infoE {
	float:right;
}


.i{
	height:150px;
	width:150px;
	float:left;
	margin-top:10px;
	margin-right:20px;
	clear:both;
	background-color:gray;
}
.i2{
	height: 90%;
	width:50%;
	float:left;
	margin-top:10px;
	margin-right:20px;
	clear:both;
	background-color:white;
	font-size: 11px;
	
}
.i3{
	width:100%;
	height:200px;
}

.i3 {
		overflow: auto;
		-ms-overflow-style: none; /* 인터넷 익스플로러 */
		scrollbar-width: none; /* 파이어폭스 */
	}
.i3::-webkit-scrollbar {
	    display: none; /* 크롬, 사파리, 오페라, 엣지 */
	}

.i3 td {
	padding: 5px;
}

.v4 .t td, .v3 table td {
	padding: 5px;
}

#usedT { text-align: center;  }

#usedT tr:first-child { font-size: 1em; color: #5D5D5D; }

#onPet:hover { cursor: pointer; font-weight:bold; }
#open_c:hover { cursor: pointer; font-weight:bold; }
#open_c { float: left; }

.t { margin: 0 auto; text-align: center; width: 100%;}

.small { font-size: 1.1em; }
.medium { font-size: 1.2em; }
.large { font-size: 1.3em; }

#menu { font-family: 'KOTRAHOPE'; font-size:2.2em; }

.btn-1 {
	background-color: pink;
	border: 2px solid white;
	border-radius: 4px;
	width: 100px;
	height: 40px;
}
.btn2 {
	margin-top: 5px;
	background-color: #DBDFEA;
}

.btn-1:hover {
	border: 3px solid white;
	color: white;
}

#sbar { font-weight: bold; font-size: 1em; color: #5D5D5D; }

.nick a { width: 100%; margin: 0 auto; }

#iimg { width: 100%; height: 100%;}
#introT .rr { padding-left: 5px; text-align: center; color: #5D5D5D; height: 95%;}

.v2 {
		overflow: auto;
		-ms-overflow-style: none; /* 인터넷 익스플로러 */
		scrollbar-width: none; /* 파이어폭스 */
	}
.v2::-webkit-scrollbar {
	    display: none; /* 크롬, 사파리, 오페라, 엣지 */
	}

</style>

<script>
	/* 달력 */	
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');
		var calendar = new FullCalendar.Calendar(calendarEl, {
			height : 370,
			contentHeight : 500,

			initialView : 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
			headerToolbar : { // 헤더에 표시할 툴 바
				start : 'prev next today',
				center : 'title',
				end : 'dayGridMonth,dayGridWeek,dayGridDay'
			},
			titleFormat : function(date) {
				return date.date.year + '년 ' + (parseInt(date.date.month) + 1)
						+ '월';
			},
			//initialDate: '2021-07-15', // 초기 날짜 설정 (설정하지 않으면 오늘 날짜가 보인다.)
			selectable : true, // 달력 일자 드래그 설정가능
			droppable : true,
			editable : true,
			nowIndicator : true, // 현재 시간 마크
			locale : 'ko', // 한국어 설정
			navLinks : true, // can click day/week names to navigate views
			editable : true,
			eventLimit : true, // allow "more" link when too many events
			events : [ 
				<%List<SitterVO> sitterList= (List<SitterVO>) request.getAttribute("sittervo");%>
				<%if (sitterList != null) {%>
					<%for (SitterVO vo : sitterList) {%>
						<%Date oldDate = vo.getSdate();%>
						<%Date newDate = vo.getFdate();%>
						<%long diff = Math.abs(newDate.getTime() - oldDate.getTime());%>
						<%double x = Math.floor(diff / (1000 * 60 * 60 * 24));%>
						<%int y=(int)x;%>
						<%int z=y;%>
						<%if(y>0){ z=y+1; }%>
						<%if(y<1){ z++; }%>
						
						<%SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");%>
						
						
						<%Calendar cal = Calendar.getInstance();%>
						<%cal.setTime(oldDate);%>
						
						
						<%long col=Math.round(Math.random() * 0xffffff);%>
						<%String co=Long.toString(col,16);%>
						<%int q=1;%>
						
						<%for (int i=0; i<z; i++){%>
						{	
							<%int w=i;%>
							<%if(i>=2){
								w=i-q;
								q++;
							}%>

							<%cal.add(Calendar.DATE,w);%>						
							<%String test = simpleDateFormat.format(cal.getTime()); %>
							
			            	title : '<%=vo.getUnickname()%>',
			                start : '<%=test%>',
			                color : '#' + '<%=co%>'
			             },
					<%}
					 }  
				}%>
			]
		});
		calendar.render();
		calendar.updateSize();
	});
	/* 달력 끝 */
	
</script>

<script>
	function userAlert(value){
		var url='${myctx}/sitter/user/userAlert?pno='+value;
		win = window.open(url, "userAlert", "width=600, height=570, left=400, top=150");
	} 
</script>

<div class="v">
	<div align="center" class="col-md-8 offset-md-2 my-4" >
		<h2 id="menu">'${loginUser.nickname}' 시터님 마이페이지 </h2>
	</div>
	
<!-- 	 <div class="nick" onclick="open_chat()" id="open_c">
	 	채팅하기
	 </div> -->
	
	<a id="infoE" href="${myctx}/sitter/user/editS">회원정보수정</a>
	<br><br>
	
	<div class="v2">
		<b style="font-size:1.1em;">내 소개</b>
		<a href="${myctx}/sitter/user/introDetail">등록/수정</a>
		<br>
		<c:set var="sv" value="${svo}"/>
		<table id="introT">
			<c:if test="${not empty sv}">
				<c:forEach var="introduce" items="${svo}">
					<tr>
						<td rowspan="5" width="25%">
							<div>
								<img src="../../resources/upload/${introduce.ifile}" id="iimg">
							</div>
						</td>
						<td width="20%" class="rr">
							<b>닉네임</b>
						</td>
						<td width="55%">
							<b>${nickname} 님</b>
						</td>
					</tr>
					<tr>
						<td class="rr"><b>지역</b></td>
						<td>
							<b>${introduce.addr}</b>
						</td>
					</tr>
					<tr>
						<td class="rr"><b>소개 제목</b></td>
						<td><b>${introduce.title}</b></td>
					</tr>
					<tr>
						<td class="rr"><b>간단한 소개 (2~3줄)</b></td>
						<td><b>${introduce.short_content}</b></td>
					</tr>
					<tr>
						<td class="rr"><b>태그</b></td>
						<td><b>${introduce.tag}</b></td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty sv}">
				<tr>
					<td><b>등록된 내 소개가 없습니다 등록해주세요</b></td>
				</tr>
			</c:if>
		</table>
	</div>
	
	<div class="v4">
		<b style="font-size:1.1em;">이용 요금 설정</b>
		<a href="${myctx}/sitter/user/price">등록 | 수정</a>
		<br><br>
		<table class="t">
			<c:if test="${price.spetall eq null}">
				<tr>
					<td> 등록된 가격 정보가 없습니다.
				</tr>
			</c:if>
			<c:if test="${price.spetall ne null}">
				<tr>
					<td></td>
					<td></td>
					<td></td>
					<td style="font-size: 0.9em; color: darkgray;">1박케어 | 데이케어</td>
				</tr>
				<tr>
					<td width="15%"><span class="small">🐕</span></td>
					<td width="20%"><span class="small">소형견</span></td>
					<td width="25%"><span class="small" style="color: gray;">7kg 미만</span></td>
					<td width="40%">
						<span class="small">${price.spetall}원 | ${price.spetday}원</span>
					</td>
				</tr>
				<tr>
					<td width="15%"><span class="medium">🐕</span></td>
					<td width="20%"><span class="medium">중형견</span></td>
					<td width="25%"><span class="medium" style="color: gray;">7~14.9kg</span></td>
					<td width="40%">
						<span class="medium">${price.mpetall}원 | ${price.mpetday}원</span>
					</td>
				</tr>
				<tr>
					<td width="15%"><span class="large">🐕</span></td>
					<td width="20%"><span class="large">대형견</span></td>
					<td width="25%"><span class="large" style="color: gray;">15kg 이상</span></td>
					<td width="40%">
						<span class="large">${price.lpetall}원 | ${price.lpetday}원</span>
					</td>
				</tr>
			</c:if>
		</table>
		
	</div>
	<div class="v5">
		<b>돌봄 신청 내역</b>
			<br><br>
			<div class="i3">
				<table class="text-center">
					<c:if test="${reserve eq null or empty reserve}">
						<tr>
							<td>예약 신청 내역이 없습니다.</td>
						</tr>
					</c:if>
				
					<c:if test="${reserve ne null and not empty reserve}">
						<tr id="sbar">
							<td width="20%">이용자 닉네임</td>
							<td width="25%">전화번호</td>
							<td width="40%">날짜</td>
							<td></td>
						</tr>
						<c:forEach var="i" begin="0" end="${total-1}">
							<tr>
								<td width="20%">&nbsp;-&nbsp; ${reserve[i].unickname} 님</td>
								<td width="25%"><%-- ${reserve[i].email} --%>${reserve[i].tel1}-${reserve[i].tel2}-${reserve[i].tel3}</td>
								<td width="40%">${reserve[i].sdate} ~ ${reserve[i].fdate}</td>
								<td width="15%">
									<div class="btns">
										<form action="${myctx}/accept" name="accept" id="accept" method="post">
											<input type="hidden" name="tno" value="${reserve[i].tno}" />
											<input type="hidden" name="unickname" value="${reserve[i].unickname}" />
											<input type="hidden" name="snickname" value="${reserve[i].snickname}" />
											<input type="hidden" name="sdate" value="${reserve[i].sdate}" />
											<input type="hidden" name="fdate" value="${reserve[i].fdate}" />
											<button type="submit" class="btn-1">수락</button>
										</form>	
										<form action="${myctx}/reject" name="reject" id="reject" method="post">
											<input type="hidden" name="tno" value="${reserve[i].tno}" />
											<button type="submit" class="btn-1 btn2">거절</button>
										</form>		
									</div>
								</td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</div>			
	</div>
	
	<div class="v3">
		<b style="font-size:1.1em;">돌봄 일정</b>
		<a href="${myctx}/sitter/user/used">등록/수정</a>
		<br>
		<div class="i2">
			<div id='calendar'></div>
			
		</div>
		<table id="usedT">		
			<tr>
				<td width="35%" style="height: 15px;">
					<b>날짜</b>
				</td>
				<td width="25%"><b>이용자 닉네임</b></td>
				<td width="25%"><b>펫 이름</b></td>
			</tr>
			<tr><td></td></tr>
		<c:forEach var="schedule" items="${svo2}">
			<tr>
				<td width="35%"><b>
					<fmt:formatDate value="${schedule.sdate}" pattern="MM월 dd일"/>				
					 ~ <fmt:formatDate value="${schedule.fdate}" pattern="MM월 dd일"/>
				 </b></td>
				<td width="25%">
					<div>
						'${schedule.unickname}'님
					</div>
				</td>
				<td width="25%" onclick="userAlert(${schedule.pno})" id="onPet">'${schedule.pname}'</td>
			</tr>			
		</c:forEach>
		</table>
	</div>

</div>

<div style="clear:both; margin-bottom:50px"></div>	

	<c:if test="${loginUser.kakao eq null}">
		<div style="margin-right: 30px;">
			 <a href="javascript:kakaoPlus();">
			 	<img id="kakaoPlus" src="${myctx}/images/kakaoPlus.png" style="width: 200px;" class="rounded">
			 </a>
		</div>
	</c:if>
	
<script>
var myctx = "${myctx}";

// 사용할 앱의 JavaScript 키
window.Kakao.init('95783301fd03fa983b31d7af57a434b2');

function kakaoPlus() {
    window.Kakao.Auth.login({
        scope: 'profile_nickname, account_email',
        success: function(response) {
            console.log(response) // 로그인 성공하면 받아오는 데이터
            window.Kakao.API.request({ // 사용자 정보 가져오기 
                url: '/v2/user/me',
                success : function(res) {
                    const kakao_account = res.kakao_account;
                    const user_email = kakao_account.email;
                    
                 	// POST 요청을 보낼 데이터
                    var data = {"email": user_email};
           
                 // AJAX 요청 보내기
                    $.ajax({
                        url: 'kakaoPlus',
                        type: 'POST',
                        contentType: 'application/json',
                        dataType:'json',
                        data: JSON.stringify(data),
                        cache:false,
                        success: function(response) {
                        	// 서버로부터 받은 응답 처리
                            if (response.msg) {
                                alert(response.msg);
                            }
                            if (response.loc) {
                                window.location.href = myctx + response.loc;
                            }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                        	
                            console.error('Error:', textStatus, errorThrown);
                        }
                    });
            
                }
            });
        },
        fail: function(error) {
            console.log(error);
        }
    });
}

</script>