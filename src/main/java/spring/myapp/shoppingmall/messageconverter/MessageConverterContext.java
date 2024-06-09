package spring.myapp.shoppingmall.messageconverter;

import java.nio.charset.StandardCharsets;
import java.util.List;
import javax.annotation.PostConstruct;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.http.converter.json.GsonHttpMessageConverter;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerAdapter;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Configuration
public class MessageConverterContext {
	@Autowired
	private RequestMappingHandlerAdapter adapter;

	private static final Gson GSON = new GsonBuilder().disableHtmlEscaping().create();

	@PostConstruct
	public void initStuff() 
	{
		List<HttpMessageConverter<?>> messageConverters = this.adapter.getMessageConverters();
		messageConverters.clear();

		GsonHttpMessageConverter gsonHttpMessageConverter = new GsonHttpMessageConverter();
		gsonHttpMessageConverter.setGson(GSON);
		messageConverters.add(gsonHttpMessageConverter);

		StringHttpMessageConverter stringHttpMessageConverter = new StringHttpMessageConverter();
		stringHttpMessageConverter.setDefaultCharset(StandardCharsets.UTF_8);
		messageConverters.add(stringHttpMessageConverter);

		this.adapter.setMessageConverters(messageConverters);
	}
}
