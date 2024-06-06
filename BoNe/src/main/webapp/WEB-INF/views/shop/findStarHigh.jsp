<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript">
	$(function() {

		// 빈 하트 누르면 빨간하트로, 빨간하트 한번 더 누르면 빈 하트로 바뀜
		// 찜 목록에 반영해야 함
		$('.heart').click(function() {

			let ino = $(this).attr('id');
			// 로그인 체크 해서 unickname 넘겨줘야 할 듯.

			console.log("heart-click");

			if ($(this).attr('src') == "${myctx}/images/heart.png") {
				console.log("빈 하트 클릭" + ino);

				$.ajax({
					url : 'heart.do',
					type : 'get',
					data : {
						ino : ino
					},
					success : function(res) {
						// alert(JSON.stringify(res));
						if (res.result > 0) {
							console.log("찜 추가 성공");
						} else if (res.result == -2) {
							alert('로그인을 해야 해요');
						}

					},
					error : function(err) {
						alert('error: ' + err.status);
					}

				});
				// 꽉 찬 하트로 이미지 변경
				$(this).attr("src", "${myctx}/images/full_heart.png");

			} else {
				console.log("꽉 찬 하트 클릭" + ino);

				$.ajax({
					url : 'removeHeart.do',
					type : 'get',
					data : {
						ino : ino
					},
					success : function(res) {
						// alert(JSON.stringify(res));
						if (res.result > 0) {
							console.log("찜 삭제 성공");
						}
						/* let heart = res.heart; (?? vo.heart)
						console.log("찜 삭제 성공"); */
					},
					error : function(err) {
						alert('error: ' + err.status);
					}
				});
				// 빈 하트로 이미지 변경
				$(this).attr("src", "${myctx}/images/heart.png");

			}

		})

	})

	function check() {
		if (!$('#addr').val()) {
			alert('검색할 동 이름을 입력하세요.');
			$('#addr').focus();
			return false;
		}
		return true;
	}
</script>

<style>
.sitter {
	border: 1px solid #ddddee;
	margin-bottom: 20px;
}

.sitter td {
	padding: 5px;
}

.sitter a {
	color: inherit;
}

#search {
	margin-bottom: 30px;
}

#searchT {
	width: 90%;
	margin-top: 20px;
	text-align: center;
	font-family: 'omyu_pretty';
	font-size: 1.4em;
}

#addr {
	padding: 4px 10px;
	font-size: 0.8em;
}

#btnfindSitter {
	padding: 4px 10px;
	font-size: 0.9em;
}

#menu {
	font-family: 'KOTRAHOPE';
	font-size: 2.7em;
}

#tbody {
	font-family: 'omyu_pretty';
	margin-top: 7px;
}
</style>

<div class="row">
	<div align="center" class="col-md-8 offset-md-2 my-4">
		<h2 id="menu">펫시터 찾기</h2>
	</div>
	<div align="center" class="col-md-8 offset-md-2" id="search">
		<form name="findAddr" id="findAddr" method="get" action="find"
			onsubmit="return check()">
			<table class="table table-borderless" id="searchT">
				<tr>
					<td style="width: 20%; vertical-align: middle;" >
						<div class="dropdown">
							<button type="button" class="btn btn-info dropdown-toggle"
								data-toggle="dropdown">평점 높은 순</button>
							<div class="dropdown-menu">
								<a class="dropdown-item" href="${myctx}/shop/findReviewHigh">리뷰 많은 순</a>
								<a class="dropdown-item" href="${myctx}/shop/find">최신순</a> 
							</div>
						</div>
					</td>
					<td style="width: 20%;">지역 검색</td>
					<td style="width: 45%;"><input type="text" name="findAddr"
						id="addr" class="form-control" placeholder="주소를 입력하세요. (반포동)">
					</td>
					<td style="width: 15%;">
						<button id="btnfindSitter" class="btn btn-success">검색</button>
					</td>
				</tr>
			</table>
		</form>
		<!-- ---------- -->
		<input type="hidden" name="findAddr" value="${paging.findAddr}">

	</div>
	<div class="col-md-8 offset-2">
		<c:forEach var="item" items="${introduce}">
			<div class="sitter">
				<table class="table table-borderless" id="tbody">
					<tr>
						<td rowspan="6"
							style="vertical-align: middle; text-align: center; width: 30%;">
							<img src="${myctx}/resources/upload/${item.ifile}"
							style="width: 200px" class="rounded">
						</td>
						<td
							style="font-size: 1.3em; font-weight: bold; padding: 5px; width: 60%; vertical-align: middle; color: #5D5D5D">
							<c:out value="${item.nickname}" /> <!-- 전문가 인증이 되었다면 인증마크 -->
						</td>
						<td style="text-align: right; width: 10%;">
							<!-- 로그인 체크 + 시터인지도 체크 해서 시터일 때는 안보이게(?) 아님 걍 로그인 안하면 안보이게,, -->
							<c:if test="${loginUser eq null}">
								<a href="${myctx}/login"> <img
									src="${myctx}/images/heart.png" class="heart" id="${item.ino}"
									style="width: 25px">
								</a>
							</c:if> <c:if test="${loginUser ne null}">
								<c:if test="${loginUser.ucheck eq 'S'}">
									<!-- 시터 회원이면 하트 안보이게 -->
								</c:if>
								<c:if test="${loginUser.ucheck eq 'G'}">
									<c:if
										test="${wish.ino eq item.ino or item.wishNick eq loginUser.nickname}">
										<img src="${myctx}/images/full_heart.png" class="heart"
											id="${item.ino}" style="width: 25px">
									</c:if>
									<c:if
										test="${wish.ino ne item.ino and item.wishNick ne loginUser.nickname}">
										<img src="${myctx}/images/heart.png" class="heart"
											id="${item.ino}" style="width: 25px">
									</c:if>
								</c:if>
							</c:if>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="font-size: 1.4em; font-weight: bold;">
							<a href="${myctx}/shop/info/<c:out value="${item.ino}" />"><c:out
									value="${item.title}" /></a>
						</td>
					</tr>
					<tr>
						<td colspan="2" style="font-size: 1.2em;"><c:out
								value="${item.short_content}" /></td>
					</tr>
					<tr>
						<td style="font-size: 1.3em; font-weight: bold;"><c:out
								value="${item.addr}" /></td>
					</tr>
				</table>
			</div>
			<input type="hidden" name="ino" id="ino" value="${item.ino}">
		</c:forEach>
		<table class="table table-borderless">
			<tr>
				<td colspan="3" style="text-align: center">${pageNavi}</td>
			</tr>
		</table>
	</div>
</div>
