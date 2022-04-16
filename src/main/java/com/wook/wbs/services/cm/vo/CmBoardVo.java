package com.wook.wbs.services.cm.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CmBoardVo extends CommVo {

	private int boardSn;
	private String boardSe;
	private String boardSj;
	private String boardCn;
	private String boardfixYn;
}
