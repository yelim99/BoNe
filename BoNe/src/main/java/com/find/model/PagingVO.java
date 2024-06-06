package com.find.model;

import javax.servlet.http.HttpSession;

import lombok.Data;

@Data
public class PagingVO {

	private int cpage;	// 현재 페이지
	private int pageSize = 5;	// 한 페이지 당 글 수
	private int totalCount;	// 총 게시글 수
	private int pageCount;	// 페이지 수
	
	private int start;	// 시작 값
	private int end;	// 끝 값
	
	private int pagingBlock = 5;	// 한 블럭 당 페이지 수
	private int prev;		// 이전
	private int next;		// 다음
	
	private String findAddr;	// 지역 검색
	
	public void paging(HttpSession session) {
		if(session != null) {
			session.setAttribute("pageSize", pageSize);
		}
		
		// 페이지 수
		pageCount = (totalCount-1)/pageSize + 1;
		
		if (cpage < 1) {
			cpage = 1;		// 1 페이지가 디폴트
		}
		if (cpage > pageCount) {
			cpage = pageCount;	// 마지막 페이지로 지정
		}
		
		start = (cpage-1)*pageSize;
		end = cpage*pageSize;
		
		prev = (cpage-1)/pagingBlock*pagingBlock;
		next = prev+(pagingBlock+1);
	}
	
	
	public String pageNavi(String myctx, String loc) {
		
		if (findAddr == null) {
			findAddr="";
		}
		
		String link = myctx+"/"+loc;
		String qStr = "?findAddr="+findAddr;
		link+=qStr;
		
		StringBuilder buf = new StringBuilder();
		buf.append("<ul class=\"pagination justify-content-center\">");
		if (prev > 0) {
			buf.append("<li class=\"page-item\">")
				.append("<a class='page-link' href='"+link+"&cpage="+prev+"'>")
				.append("<")
				.append("</a>")
				.append("</li>");
		}
		
		for (int i=prev+1; i<=next-1 && i<=pageCount; i++) {
			String css = (i==cpage)?"active":"";
			
			buf.append("<li class='page-item "+css+"'>")
				.append("<a class='page-link' href='"+link+"&cpage="+i+"'>")
				.append(i)
				.append("</a>")
				.append("</li>");
		}
		
		if (next <= pageCount) {
			buf.append("<li class=\"page-item\">")
				.append("<a class='page-link' href='"+link+"&cpage="+next+"'>")
				.append(">")
				.append("</a>")
				.append("</li>");
		}
			buf.append("</ul>");
			
		return buf.toString();
		
	}
	
}
