package com.wook.wbs.services.cm;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;

@Service
public class CmServiceImpl implements CmService {

	@Autowired CmDao cmDao;

	@Override
	public List<HashMap<String, Object>> selectBoardList(HashMap<String, Object> param) {
		try {
			return cmDao.selectBoardList(param);
		} catch(DataAccessException e) {
			return new ArrayList<HashMap<String, Object>>();
		}
	}


}
