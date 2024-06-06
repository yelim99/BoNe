package com.find.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.find.model.IntroduceVO;
import com.find.model.WishVO;
import com.find.service.WishService;
import com.user.model.UserVO;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
public class WishController {
	
	@Resource(name="wishService")
	private WishService wishService;
	
	@ResponseBody
	@GetMapping(value="/shop/heart.do", produces="application/json")
	public ModelMap wishAdd(@RequestParam int ino, HttpSession session, Model m) {
		ModelMap map=new ModelMap();
		
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		if(loginUser==null) {
			map.put("result", -2);
			return map;
		}
		String unickname_fk ="";
		if(loginUser!=null) {
			unickname_fk=loginUser.getNickname();
		}
		IntroduceVO wishSitterInfo = wishService.wishSitterInfo(ino);
		
		WishVO wish = new WishVO();
		wish.setIno(ino);
		wish.setUnickname(unickname_fk);
		wish.setSnickname(wishSitterInfo.getNickname());
		wish.setSaddr(wishSitterInfo.getAddr());
		wish.setTitle(wishSitterInfo.getTitle());

		log.info("wish: "+wish);
		
		int check = wishService.wishCheck(wish);
		int n = 0;
		
		if (check == 0) {
			n = wishService.addWish(wish);
			log.info("n: "+n);
		}
		
		
		map.put("result", n);
		
		
		return map;
	}
	
	
	@ResponseBody
	@GetMapping(value="/shop/removeHeart.do", produces="application/json")
	public ModelMap wishDel(@RequestParam int ino, HttpSession session) {
		
		UserVO loginUser = (UserVO)session.getAttribute("loginUser");
		String unickname_fk = loginUser.getNickname();
		
		WishVO wish = new WishVO();
		wish.setIno(ino);
		wish.setUnickname(unickname_fk);
		log.info("vo: "+wish);
		
		int n = wishService.delWish(wish);
		log.info("n: "+n);
		
		ModelMap map = new ModelMap();
		map.put("result", n);
		
		return map;
	}
	

}
