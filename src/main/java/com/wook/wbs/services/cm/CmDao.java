package com.wook.wbs.services.cm;

import java.util.HashMap;
import java.util.List;

public interface CmDao {

	public List<HashMap<String, Object>> selectBoardList(HashMap<String, Object> param);
}
