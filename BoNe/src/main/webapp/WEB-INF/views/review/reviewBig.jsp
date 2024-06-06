<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>
.container {
	display: grid;
	place-items: center;
}

.big-box {
	margin-top: 100px;
	display: grid;
	place-items: center;
	width: 800px;
	background-color: #ECF8F9;
	border-radius: 30px;
	border: 3px solid #B8DFD8;
}

.review {
	font-size: 50px;
	font-style: italic;
	font-weight: bold;
	margin-top: 80px;
	margin-bottom: 80px;
	color: #64CCC5;
	text-shadow: 2px 2px 4px #C9EEFF;
	font-weight: bold;
}

.who {
	font-size: 35px;
	font-weight: bold;
	margin-bottom: 60px;
	color: #FF577F;
}

.big {
	width: 500px;
	height: auto;
	background-color: #FFFAF4;
	border-radius: 20px;
	border: 2px solid #F2BED1;
	box-shadow: 0 0 15px #F2BED1;
	margin-bottom: 150px;
}

.stars {
	width: 40px;
	margin-top: 5px;
	margin-bottom: 20px;
}

.row {
	padding: 20px 20px 15px 15px;
	width: 500px;
	height: auto;
}

.row1 {
	margin-top: 20px;
	font-weight: bold;
	display: flex;
	justify-content: center;
	font-size: 17px;
	color: #FF577F;
}

.rounded {
	max-width: 210px;
	max-height: 200px;
	height: auto;
	display: block;
	margin: -3px auto 0;
	margin-bottom: 30px;
}

.row3 {
	width: 430px;
	border-radius: 10px;
	border: 2px solid #FCAEAE;
	background-color: white;
}

.row4 {
	padding-left: 340px;
	font-size: 14px;
	font-weight: bold;
	color: #EB6440;
}

.st_who {
	font-size: 18px;
	font-weight: bold;
	margin-top: 40px;
	background-color: white;
	padding: 13px 8px 10px 8px;
	border-radius: 30px;
	color: #FF8989;
	border: 1px solid #FCAEAE;
}

.st_who:hover {
	background-color: #F8E8EE;
}

.re-box {
	margin-top: 50px;
	margin-bottom: 100px;
}

.white-box {
	background-color: white;
	width: 575px;
	height: 230px;
	border: 2px solid #B8DFD8;
	padding: 10px 10px 10px 10px;
	border-radius: 10px;
	margin-top: 15px;
}

textarea {
	width: 550px;
	height: 100px;
	border: 1px solid white;
	border-radius: 10px;
	padding: 5px 5px 5px 5px;
}

.re-submit {
	margin-top: 5px;
	margin-left: 490px;
	font-size: 14px;
}

.re-submit:hover {
	text-decoration: none;
	color: black;
}

.re-after {
	background-color: white;
	margin-bottom: 20px;
	width: 575px;
	min-height: 100px;
	height: auto;
	border: 2px solid #B8DFD8;
	padding: 10px 10px 10px 10px;
	border-radius: 10px;
}

.re-name {
	font-size: 15px;
	font-weight: bold;
	margin: 3px 0px 5px 5px;
	color: #3A98B9;
}

.re-content {
	font-size: 14px;
	margin: 3px 0px 5px 5px;
}

.re-date {
	display: flex;
	font-size: 13px;
	font-weight: bold;
	margin: 3px 0px 5px 5px;
	color: #7B8FA1;
	justify-content: space-between; 
	align-items: center;
}

#nickname {
	font-weight: bold;
	margin-top: 3px;
	margin-left: 5px;
}

.btns {
	display: flex;
	margin-bottom: 100px;
}
.lil {
	display: flex;
	font-size: 12px;
	margin-right: 5px;
}
.lil-1 {
	background-color: white;
	border: 1px solid #64CCC5;
	border-radius: 20px;
	color: #545B77;
	padding-left: 10px;
	padding-right: 10px;
	padding-top: 5px;
	padding-bottom: 5px;
}
.lil-1:hover {
	background-color: #B8DFD8;
}
.toInfo {
	text-decoration: none;
	color: #FF8989;
}
.toInfo:hover {
	text-decoration: none;
	color: #FF8989;
}
</style>

<body>
	<div class="container">
		<div class="big-box">
			<div class="review">Review</div>
			<div class="who">'${reviewBoard.nickname}' 님의 후기 ♥</div>

			<%
			int rno = Integer.parseInt(request.getParameter("rno"));
			%>

			<div class="big">
				<div class="container">
					<div class="st_who">&nbsp;&nbsp; 
						<a href="${myctx}/shop/info/${ino}" class="toInfo"> '${st_nickname}' 님과 함께하셨어요</a>
						♬&nbsp;&nbsp;</div>
					<div class="row row1">
						<div>${reviewBoard.title}</div>
					</div>
					<div>
						<c:set var="starCount" value="${reviewBoard.star}" />
						<c:forEach var="i" begin="1" end="${starCount}">
							<img src="${myctx}/images/star3.png" class="stars">
						</c:forEach>
					</div>
					<div class="row row2">
						<img src="resources/board_upload/${reviewBoard.rfile}"
							alt="리뷰 이미지" class="rounded">
					</div>
					<div class="row row3">${reviewBoard.content}</div>
					<div class="row row4">작성일 : ${reviewBoard.wdate}</div>

				</div>
			</div>


			<div class="re">
				<div style="font-size: 14px; font-weight: bold; color: #245953;">댓글</div>
				<hr>
				<div style="height: 20px;"></div>
				<c:if test="${reply ne null and not empty reply}">
					<c:forEach var="i" begin="0" end="${total-1}">
						<div class="re-after">
							<div class="re-name">${reply[i].nickname}</div>
							<div class="re-content">${reply[i].content}</div>
							<div class="re-date">
								${reply[i].wdate}
								<c:if test="${sessionScope.writer eq reply[i].nickname}">
									<div class="lil">
										<button type="button" class="lil-1 editBtn" style="margin-right: 5px;" onclick="editReply('${reply[i].content}','${reply[i].rrno}','${reply[i].rno}')">수정</button>
										<form action="${myctx}/deleteReply" name="delete_re" id="delete_re" method="post">
											<input type="hidden" name="rrno" value="${reply[i].rrno}" />
  											<input type="hidden" name="rno" value="${rno}" />
											<button type="submit" onclick="return deleteReply()" class="lil-1">삭제</button>
										</form>										
									</div>
								</c:if>
							</div>
						</div>
					</c:forEach>
				</c:if>
			</div>

			<c:if test="${sessionScope.writer ne null}">
			<form action="${myctx}/insertReply" name="rp" id="rp" method="post">
				<div class="re-box">
					<input type="hidden" name="rno" value="${rno}" />
					<!-- rno 값을 숨겨진 필드(hidden field)로 전달 -->
					<%-- <input type="hidden" name="nickname" value="${sessionScope.nickname}" /> 닉네임 전송해야해여--%>
					<hr>
					<div style="font-size: 14px; font-weight: bold; color: #245953;">댓글
						쓰기</div>
					<div class="white-box">
						<div id="nickname">
							${sessionScope.writer}
						</div>
						<hr>
						<textarea id="content" name="content" placeholder="훈훈한 댓글 부탁드립니다 ♥" required></textarea>
						<div class="re-submit-box"><a href="#" id="submitBtn" class="re-submit">등록</a></div>
					</div>
				</div>
			</form>
			</c:if>
			
			<c:if test="${sessionScope.writer eq null}">
				<div style="height: 150px;">&nbsp;</div>
			</c:if>
			
			<!-- 로그인 정보와 글 쓴 사람 똑같을 때, 편집&삭제 버튼 보이기 -->
			<c:if test="${sessionScope.writer eq reviewBoard.nickname}">
				<div class="btns">
				<form action="${myctx}/editReview" name="edit_rv" id="edit_rv" method="post">
					<input type="hidden" name="rno" value="${rno}" />
					<input type="hidden" name="snickname" value="${st_nickname}" />
					<button type="submit" class="btn btn-info" style="width: 70px;">편집</button>
				</form>
				
				<div class="container">
					<!-- 삭제 모달 -->
					<button type="button" class="btn btn-info" data-toggle="modal"
						data-target="#myModal" style="width: 70px;">삭제</button>

					<div class="modal fade" id="myModal">
						<div class="modal-dialog modal-dialog-centered">
							<div class="modal-content">
								<div class="modal-header">
									<h4 class="modal-title">알림</h4>
								</div>
								<div class="modal-body">글을 삭제하시겠습니까?</div>
								<div class="modal-footer">
									<form action="${myctx}/deleteReview" name="delete_rv" id="delete_rv" method="post">
										<input type="hidden" name="rno" value="${rno}" />
										<button type="submit" class="btn btn-danger" onclick="deleteConfirmation()">삭제</button>
									</form>
									<button type="button" class="btn btn-success" data-dismiss="modal">취소</button>
								</div>

							</div>
						</div>
					</div>
					<!--  삭제 모달 끝 -->
				</div>
				
				</div>
			</c:if>

		</div>
	</div>
	<!-- 컨테이너 -->

</body>

<script>
$(document).ready(function() {
	$("#submitBtn").click(function(event) {
		event.preventDefault(); // 기본 동작(링크로의 이동)을 중지

		var content = $("#content").val();
		
		// 댓글 내용이 비어있을 경우 등록되지 않음
		if (content.trim() === "") {
			alert('내용을 입력해주세요.');
			return;
		}
		
		// 폼 전송
		$("#rp").submit();
	});
});

function deleteConfirmation() {
	alert("삭제되었습니다.");
}

function deleteReply() {
	var result = confirm("댓글을 삭제하시겠습니까?");

	if (result) {
	// 사용자가 "확인" 버튼을 선택한 경우
	document.getElementById("delete_re").submit(); // form을 submit 하기
	} else {
	// 사용자가 "취소" 버튼을 선택한 경우
	return false; // form submit 막기
	}
	
}

function editReply(content, rrno, rno) {
	$("#content").val(content); // 댓글 내용 설정
	$("#content").focus(); // 텍스트 영역에 포커스 설정
    $("#submitBtn").hide(); // 등록 버튼 숨기기
	
 	// 이미 생성된 수정 완료 버튼이 있는지 확인
    var existingUpdateButton = $(".updateBtn");
    if (existingUpdateButton.length > 0) {
        existingUpdateButton.data("rrno", rrno); // 버튼마다 고유한 rrno가 있으니까
        return; // 새로운 수정 완료 버튼을 생성하지 않고 종료
    } else {
    	// 수정 버튼 동적 생성
    	var updateButton = $("<a>").text("수정").addClass("re-submit updateBtn").attr("href", "#");
    	updateButton.data("rrno", rrno);
    	
    	// 취소 버튼 동적 생성
    	var cancelButton = $("<a>").text("취소").addClass("re-submit cancelBtn").attr("href", "#");
    }

	// 수정 버튼 클릭 이벤트 처리
	updateButton.click(function(event) {
		event.preventDefault(); // 기본 동작(링크로의 이동)을 중지

		var modifiedContent = $("#content").val();
		var rrno = $(this).data("rrno");
		
		// textarea 내용이 비어있으면 등록하지 않음
		if (modifiedContent.trim() === "") {
			alert('내용을 입력해주세요.');
			return;
		}
		
		var data = {"content": modifiedContent};
		
		// 수정된 댓글을 서버로 전송
		$.ajax({
			url: 'updateReply/' + rrno,
			type: 'put',
			contentType: 'application/json',
			dataType:'json',
			data: JSON.stringify(data),
			cache:false,
			success: function(response) {
				console.log('데이터 전송 성공');
				$("#content").val(""); // 댓글 내용 초기화
			    updateButton.remove(); // 수정 완료 버튼 제거
			    cancelButton.remove(); // 취소 버튼 제거
			    $("#submitBtn").text("등록").show();  // 등록 버튼 보이도록 설정
				
			    window.location.href = "${myctx}/reviewBig?rno="+rno;
			},
			error: function(xhr, status, error) {
				console.error('데이터 전송 실패:', error);
			}
		});
	});

	// 취소 버튼 클릭 이벤트 처리
	cancelButton.click(function(event) {
		event.preventDefault(); // 기본 동작(링크로의 이동)을 중지

		$("#content").val(""); // 댓글 내용 초기화
		updateButton.remove(); // 수정 버튼 제거
		cancelButton.remove(); // 취소 버튼 제거
		$("#submitBtn").text("등록").show();  // 등록 버튼 보이도록 설정
	});
	
	
	// 수정 완료 버튼과 취소 버튼을 삽입할 위치 지정
	$("#submitBtn").after(updateButton, cancelButton);
}


</script>