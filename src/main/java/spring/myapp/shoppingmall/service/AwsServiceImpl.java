package spring.myapp.shoppingmall.service;

import java.io.File;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.SdkClientException;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.PutObjectRequest;

@Service
@Transactional
public class AwsServiceImpl implements AwsService {
		private static final Logger logger = LoggerFactory.getLogger(AwsServiceImpl.class);
	 	private static final String BUCKET_NAME = "shoppingmallbucket";
	    private static final String ACCESS_KEY = "AwsAcessKey";
	    private static final String SECRET_KEY = "AwsSecretKey";
	    private AmazonS3 amazonS3;

	    public AwsServiceImpl() {
	        AWSCredentials awsCredentials = new BasicAWSCredentials(ACCESS_KEY, SECRET_KEY);
	        amazonS3 = AmazonS3ClientBuilder
	                .standard()
	                .withRegion(Regions.AP_NORTHEAST_2)
	                .withCredentials(new AWSStaticCredentialsProvider(awsCredentials))
	                .build();
	    }

	    @Override
	    public void s3FileUpload(File file,String whatupload) {
	    	if(whatupload.equals("book")) {
	    		PutObjectRequest putObjectRequest = new PutObjectRequest(BUCKET_NAME + "/bookimage",file.getName(),file);
	    		logger.info("filename : {}",file.getName());
	    		putObjectRequest.setCannedAcl(CannedAccessControlList.PublicRead);
	    		amazonS3.putObject(putObjectRequest);
	    	} else {
	    		PutObjectRequest putObjectRequest = new PutObjectRequest(BUCKET_NAME + "/reviewimage",file.getName(),file);
	    		logger.info("filename : {}",file.getName());
	    		putObjectRequest.setCannedAcl(CannedAccessControlList.PublicRead);
	    		amazonS3.putObject(putObjectRequest);
	    	}
	    }
	    
	    @Override
	    public void s3FileDelete(String filename) {
	    	try {
	    		logger.info("filename : {}",filename);
	    		amazonS3.deleteObject(BUCKET_NAME,"reviewimage/" + filename);
	        } catch (AmazonServiceException e) {
	            e.printStackTrace();
	        } catch (SdkClientException e) {
	            e.printStackTrace();
	        }
	    }
}