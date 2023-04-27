package com.billi.frontcontroller;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.billi.model.InsuranceService;
import com.billi.vo.InsuranceVO;

public class InsurancechargeController implements CommonControllerInterface {

	@Override
	public String excute(Map<String, Object> data) throws Exception {
		String page="";
		String method = (String)data.get("method");
		HttpServletRequest request = (HttpServletRequest)data.get("request");
		
		if(method.equals("GET")) {
			page = "myrentallist.jsp";
		}else {
			InsuranceVO insurance = makeInsurance(request);
			InsuranceService service = new InsuranceService();
			String result = service.InsuranceCharge(insurance);
			String path = request.getContextPath();
			
			page = "redirect:"+ path + "/user/myrental.do";
		}
		
		return page;
	}
	private InsuranceVO makeInsurance(HttpServletRequest request) {
		InsuranceVO insurance = new InsuranceVO();
		
		// aws s3 연결
		String accesskey = "AKIA4IJQX4ZU6A3PDOXA";
		String secretKey = "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";

		AWSCredentials credentials = new BasicAWSCredentials(accesskey, secretKey);

		// aws에 요청할 client 객체 생성
		AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
				.withCredentials(new AWSStaticCredentialsProvider(credentials)).withRegion(Regions.AP_NORTHEAST_2)
				.build();
		
		//이미지 경로
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
					
					if(colName.equals("charge_type")) insurance.setCharge_type(colValue);
					if(colName.equals("charge_content")) insurance.setCharge_content(colValue);
					if(colName.equals("rental_code")) insurance.setRental_code(Integer.parseInt(colValue));
				} else {
					if (fileItem.getSize() > 0) {
						int idx = fileItem.getName().lastIndexOf("\\");
						if (idx == -1) {
							idx = fileItem.getName().lastIndexOf("/");
						}
						
						String fileName = fileItem.getName().substring(idx + 1);
						File uploadFile = new File(currentDirPath + "\\" + fileName);
						fileItem.write(uploadFile);
						
						//aws에 이미지 저장
						String imgPath = "i_"+insurance.getRental_code()+".jpg"; //DB에 저장할 이미지 경로
						s3Client.putObject("billi-boards-img", "insurance/"+imgPath, uploadFile);
						
						//이미지이름을 DB에 저장
						insurance.setPicture(imgPath);
						
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return insurance;
	}
}
