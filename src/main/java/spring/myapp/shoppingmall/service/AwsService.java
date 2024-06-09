package spring.myapp.shoppingmall.service;

import java.io.File;

public interface AwsService { 
	public void s3FileUpload(File file,String whatupload);
	public void s3FileDelete(String fileurl);
}
