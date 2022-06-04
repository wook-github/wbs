package com.wook.wbs.services.cm;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.wook.wbs.mybatis.mappers.BoardMapper;

@Repository
public class CmDaoImpl implements CmDao {

	@Resource(name="boardMapper")
	private BoardMapper boardMapper;

	@Override
	public List<HashMap<String, Object>> selectBoardList(HashMap<String, Object> param) {
		return boardMapper.selectBoardList(param);
	}


}
