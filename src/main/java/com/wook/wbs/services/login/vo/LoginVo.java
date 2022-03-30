package com.wook.wbs.services.login.vo;

import java.sql.Timestamp;

import com.wook.wbs.services.cm.vo.CommVo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LoginVo extends CommVo {

	private String userId;
	private String userPw;
	private String userNm;
	private Timestamp regDt;
	private String aprvYn;
	private String autzrId;
}
