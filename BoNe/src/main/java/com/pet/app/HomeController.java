package com.pet.app;

import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.find.model.IntroduceVO;
import com.find.service.FindService;
import com.reviewboard.model.ReviewBoardVO;
import com.reviewboard.service.ReviewBoardService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	@Resource(name="reviewBoardService")
	private ReviewBoardService rbService;
	
	@Autowired
	@Resource(name = "FindService")
	private FindService fService;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		List<ReviewBoardVO> rbData = rbService.selectReviewBoard();
		model.addAttribute("reviewBoard", rbData);
	
		List<IntroduceVO> infoData = rbService.selectIntroduce();
		model.addAttribute("introduce", infoData);
		
		System.out.println(infoData.size());
		
		int[] sumStar = new int[4];
		int[] cntStar = new int[4];
		double[] avg = new double[4];
		
		for(int i=0; i<infoData.size(); i++) {
			
			if(i==4) {
				break;
			}
			
			sumStar[i] = this.fService.getSumStar(infoData.get(i).getIno());
			cntStar[i] = this.fService.getCntStar(infoData.get(i).getIno());
			avg[i] = sumStar[i]/(double)cntStar[i];
		}
		
		model.addAttribute("avg", avg);
		
		return "main";
	}
	
}
