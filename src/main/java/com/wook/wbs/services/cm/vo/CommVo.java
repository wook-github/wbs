package com.wook.wbs.services.cm.vo;

import java.sql.Timestamp;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CommVo {

	private String useYn;
	private Timestamp mdfcnYmd;
	private String mdfrId;
	private String mdfrIp;
	private String rm;

	private int rownum;
	private int page;
	private int totalCount;
}
