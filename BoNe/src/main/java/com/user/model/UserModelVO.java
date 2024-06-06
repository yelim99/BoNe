package com.user.model;

import java.sql.Date;

import lombok.Data;

/* 펫 정보 관련 vo */

@Data
public class UserModelVO {
	private String nickname; 
	
    private String pname;
    
    private String species1; 
    
    private String species2;
    
    private String bday;
    
    private String weight;
    
    private String particulars;
    
    private String image;	
    
    private int pno;

	public String gender;
	
	
		// TODO Auto-generated method stub
		
	}


