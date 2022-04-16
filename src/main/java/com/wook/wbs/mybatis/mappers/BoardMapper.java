package com.wook.wbs.mybatis.mappers;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.dao.DataAccessException;

@Mapper
public interface BoardMapper {

	public List<HashMap<String, Object>> selectBoardList(HashMap<String, Object> param) throws DataAccessException;
}
