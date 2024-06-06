<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
#intro {
	margin-top: 80px;
}

.main-img {
	width: 300px;
}

.table {
	margin-bottom: 150px;
}

a {
	color: inherit;
}

.box1 {
	border: 1px solid #FFD9C0;
	background-color: #FAF0E4;
	border-radius: 20px;
	width: 230px;
	height: 440px;
	display: flex;
	justify-content: center;
	align-items: center;
	box-shadow: 0 0 5px #FFD9C0;
}

.box {
	border: 1px solid #F2BED1;
	background-color: #F8E8EE;
	border-radius: 20px;
	width: 230px;
	height: 440px;
	display: flex;
	justify-content: center;
	align-items: center;
	box-shadow: 0 0 5px #F2BED1;
}

a:hover {
	text-decoration: none;
}

.more:hover, .st:hover {
	font-weight: bold;
}

.rounded {
	max-width: 210px;
	max-height: 200px;
	height: auto;
	display: block;
	margin: -3px auto 0;
}

.col1 {
	display: flex;
	justify-content: center;
	align-items: center;
	margin: 0 auto;
}

.row1 {
	height: 210px;
}

.row-2 {
	height: 65px;
	margin-top: 7px;
	margin-bottom: 10px;
	background-color: white;
	padding: 5px 8px 5px 0px;
	border-radius: 10px;
	color: #643843;
	box-shadow: 0 0 5px #FFD9C0;
	border: 1px solid #FFD9C0;
}

.row2 {
	height: 65px;
	margin-top: 7px;
	margin-bottom: 10px;
	background-color: white;
	padding: 5px 8px 5px 0px;
	border-radius: 10px;
	color: #643843;
	box-shadow: 0 0 5px #F2BED1;
	border: 1px solid #F2BED1;
}

.row-3 {
	height: 115px;
	background-color: #FFFAF4;
	padding-top: 10px;
	border-radius: 10px;
	box-shadow: 0 0 5px #FFD9C0;
	border: 1px solid #FFD9C0;
}

.row3 {
	height: 125px;
	background-color: #FFFAF4;
	box-shadow: 0 0 5px #F2BED1;
	border: 1px solid #F2BED1;
	padding-top: 10px;
	padding-bottom: 10px;
	border-radius: 10px;
}

.who {
	margin-top: 4px;
	font-size: 13px;
	font-weight: bold;
}

.stars {
	width: 20px;
}

.col3 {
	font-size: 13px;
	width: 100%;
	max-height: 100px;
	overflow: hidden;
	text-overflow: ellipsis;
}

.tb-title {
	font-size: 30px;
	font-weight: bold;
	font-style: italic;
	color: #64CCC5;
	text-shadow: 2px 2px 4px #C9EEFF;
}

#menu {
	font-family: 'KOTRAHOPE';
	font-size: 2.5em;
}

#homeT {
	width: 80%;
}

.point {
	font-weight: bold;
	color: #EDD200;
}

#exp {
	font-family: 'omyu_pretty';
	font-size: 1.3em;
}
</style>

<div class="row">
	<div class="col-md-10 offset-2 " id="intro">
		<table class="table table-borderless" id="homeT">
			<tr>
				<td style="vertical-align: bottom; width: 50%;" id="menu">BONE
					란?</td>
				<td rowspan="2" style="width: 50%;"><img
					src="${myctx}/images/logo_b2.png" class="main-img"></td>
			</tr>
			<tr>
				<td id="exp">혼자 지낼 반려동물, 많이 걱정되시죠?<br> 이젠 걱정하지 말고 <span
					class="point">'BONE'</span>에서<br> 믿고 맡길 수 있는 펫시터에게 <span
					class="point">'보내'</span>보세요!
				</td>
			</tr>
		</table>

		<table style="width: 80%;">
			<tr>
				<td style="font-size: 1.3em;" colspan="3"><div class="tb-title">Pet
						sitter</div></td>
				<td style="text-align: right;"><a href="${myctx}/shop/find"
					class="more">더보기 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></td>
			</tr>
			<tr style="height: 20px;"></tr>

			<tr>
				<c:if test="${introduce ne null and not empty introduce}">
					<c:forEach var="i" begin="0" end="3">
						<td>

							<div class="box1">
								<div>
									<div class="container" style="width: 210px;">
										<div class="row row1">
											<div class="col col1">
												<a href="${myctx}/shop/info/${introduce[i].ino}"><img
													src="resources/upload/${introduce[i].ifile}" alt="리뷰 이미지"
													class="rounded"></a>
											</div>
										</div>
										<div class="row row-2">
											<div class="col">
												<div class="who">
													<a href="${myctx}/shop/info/${introduce[i].ino}" class="st">&nbsp;${introduce[i].nickname}
														시터님 ♥</a>
												</div>

												<div
													style="margin-top: 4px; font-size: 13px; font-weight: bold;">
													<c:set var="avgStar" value="${avg[i]}" />
													<c:forEach var="k" begin="1" end="${avgStar}">
														<img src="${myctx}/images/star3.png" class="stars">
													</c:forEach>
													<c:if test="${avgStar % 1 >= 0.5}">
														<img src="${myctx}/images/star2.png" class="stars">
													</c:if>
													(<fmt:formatNumber value="${avg[i]}" maxFractionDigits="2" />)
												</div>

											</div>
										</div>
										<div class="row row-3">
											<div class="col col3">
												<div>
													<a href="${myctx}/shop/info/${introduce[i].ino}">${introduce[i].content}</a>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</td>
					</c:forEach>
				</c:if>
			</tr>
		</table>
		<br> <br>
		<table style="width: 80%;">
			<tr>
				<td style="font-size: 1.3em;" colspan="4"><div class="tb-title">Review</div></td>
			</tr>

			<tr style="height: 20px;"></tr>

			<tr>
				<c:if test="${reviewBoard ne null and not empty reviewBoard}">
					<c:forEach var="i" begin="0" end="3">
						<td>

							<div class="box">
								<div>
									<div class="container" style="width: 210px;">
										<!-- 1행 -->
										<div class="row row1">
											<div class="col col1">
												<a href="${myctx}/reviewBig?rno=${reviewBoard[i].rno}"><img
													src="resources/board_upload/${reviewBoard[i].rfile}"
													alt="리뷰 이미지" class="rounded"></a>
											</div>
										</div>
										<!-- 2행 -->
										<div class="row row2">
											<div class="col">
												<div class="who">
													<a href="${myctx}/reviewBig?rno=${reviewBoard[i].rno}"
														class="st">&nbsp;${reviewBoard[i].nickname} 님의 후기 ♥</a>
												</div>
												<div>
													<c:set var="starCount" value="${reviewBoard[i].star}" />
													<c:forEach var="j" begin="1" end="${starCount}">
														<img src="${myctx}/images/star3.png" class="stars">
													</c:forEach>
												</div>
											</div>
										</div>
										<!-- 3행 -->
										<div class="row row3">
											<div class="col col3">
												<a href="${myctx}/reviewBig?rno=${reviewBoard[i].rno}">${reviewBoard[i].content}</a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</td>
					</c:forEach>
				</c:if>
			</tr>
		</table>

	</div>
</div>

