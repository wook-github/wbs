package com.wook.wbs.controller;

import java.util.HashMap;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.json.MappingJackson2JsonView;

import com.wook.wbs.services.cm.CmService;

@Controller
@RequestMapping("/board")
public class BoardController {

	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired private CmService cmService;

	@Resource MappingJackson2JsonView	jsonView;

	@RequestMapping(value = "/boardMa", method = RequestMethod.GET)
	public ModelAndView boardMa(@RequestParam HashMap<String, Object> param, ModelAndView model) throws Exception {
		model.addObject("info", param);
		model.setViewName("board/boardMa");
		return model;
	}

	@RequestMapping(value="/selectBoardList", method=RequestMethod.POST)
	public ModelAndView selectBoardList(@RequestParam HashMap<String, Object> param) throws Exception {
		HashMap<String, Object> result = new HashMap<String, Object>();

		result.put("result", cmService.selectBoardList(param));
		return new ModelAndView(jsonView, result);
	}

}
