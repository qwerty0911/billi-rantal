package com.billi.frontcontroller;

import java.io.UnsupportedEncodingException;
import java.util.Map;

//모든 컨트롤러의 규격서
public interface CommonControllerInterface  {
	public String excute(Map<String, Object> data) throws Exception;
	
	
}
