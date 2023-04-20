package com.billi.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.AccessControlList;
import com.amazonaws.services.s3.model.CreateBucketRequest;
import com.billi.frontcontroller.CommonControllerInterface;
import com.billi.model.BoardsService;
import com.billi.vo.BoardsVO;

public class BoradwriteController implements CommonControllerInterface {
	
	@Override
	public String excute(Map<String, Object> data) throws Exception {
		String method = (String)data.get("method");
		String page="";
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		HttpSession session = request.getSession();
		if(method.equals("GET")) { //글 작성 입력 폼
			page = "boardwrite.jsp";
			
			BoardsService service = new BoardsService();
			request.setAttribute("clist", service.selectCategory());
		}else { //글 작성 후 저장
			BoardsVO board=makeBoard(request);
			
			BoardsService service = new BoardsService();
			int result = service.boardInsert(board);
			page="redirect:boardlist.do?pageNum=1&category=all";
		}
		return page;
	}
	
	private BoardsVO makeBoard(HttpServletRequest request) throws UnsupportedEncodingException {
		BoardsVO board = new BoardsVO(0);
		
		//aws s3 연결
		String accesskey="AKIA4IJQX4ZU6A3PDOXA";
		String secretKey="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";
		
		AWSCredentials credentials= new BasicAWSCredentials(accesskey, secretKey);
		
		//aws에 요청할 client 객체 생성
		AmazonS3 s3Client = AmazonS3ClientBuilder
				.standard()
				.withCredentials(new AWSStaticCredentialsProvider(credentials))
				.withRegion(Regions.AP_NORTHEAST_2)
				.build();
		
		String encoding = "utf-8";
		String currentPath = request.getServletContext().getRealPath("/uploadImg");
		System.out.println(currentPath);
		
		File currentDirPath = new File(currentPath);
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(currentDirPath);
		factory.setSizeThreshold(1024 * 1024);

		ServletFileUpload upload = new ServletFileUpload(factory);
		try {
			List items = upload.parseRequest(request);
			for (int i = 0; i < items.size(); i++) {
				FileItem fileItem = (FileItem) items.get(i);

				if (fileItem.isFormField()) {
					System.out.println(fileItem.getFieldName() + "=" + fileItem.getString(encoding));
					String colName=fileItem.getFieldName();
					String colValue=fileItem.getString(encoding);
					if(colName.equals("board_title")) board.setBoard_title(colValue);
					if(colName.equals("board_contents")) board.setBoard_contents(colValue);
					if(colName.equals("board_writer")) board.setBoard_writer(colValue);
					if(colName.equals("price")) board.setPrice(Integer.parseInt(colValue));
					if(colName.equals("address")) board.setAddress(colValue);
					if(colName.equals("category_id")) board.setCategory(colValue);
				} else {
					if (fileItem.getSize() > 0) {
						int idx = fileItem.getName().lastIndexOf("\\");
						if (idx == -1) {
							idx = fileItem.getName().lastIndexOf("/");
						}
						
						String fileName = fileItem.getName().substring(idx + 1);
						File uploadFile = new File(currentDirPath + "\\" + fileName);
						//File newFile = new File(currentDirPath+"\\b_"+board.getBoard_id()+".jpg");
						//uploadFile.renameTo(newFile);
						//fileItem.write(uploadFile);
						
						
						//aws에 이미지 저장
						s3Client.putObject("billi-boards-img", "board/b_"+board.getBoard_id()+".jpg", uploadFile);
						String imgPath = s3Client.getUrl("billi-boards-img","board/b_"+board.getBoard_id()+".jpg").toString();
//				        log.info(imgPath);
//				        Assertions.assertThat(imgPath).isNotNull();
						
						//이미지이름이 DB에 저장되어야 한다.
						board.setPictures(imgPath);
						
					} // end if
				} // end if
			} // end for
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("board: " +board);
		return board;
	}
}