package search;
import java.io.*;
import java.net.*;
import java.text.DecimalFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.lang.String;

public class Download
{
	private static long count = 1;

	private boolean checkURL(URL url)
	{
		String s = url.toString();
		if (s.endsWith(".zip") || s.endsWith(".gz") || s.endsWith(".rar")
				|| s.endsWith(".exe") || s.endsWith(".exe")
				|| s.endsWith(".jpg") || s.endsWith(".png")
				|| s.endsWith(".tar") || s.endsWith(".chm")
				|| s.endsWith(".iso") || s.endsWith(".gif")
				|| s.endsWith(".csv") || s.endsWith(".pdf")
				|| s.endsWith(".doc"))
			return false;
		else
			return true;
	}

	public String downloadHttp(URL url)
	{
		boolean isOK = checkURL(url);
		if (!isOK)
			return null;
		StringBuffer content = new StringBuffer();
		try
		{
			HttpURLConnection connection = (HttpURLConnection) url
					.openConnection();
			int responseCode = connection.getResponseCode();
			// System.out.println("return code is :"
			// + responseCode);
			if (responseCode == HttpConstants.HTTP_NOTFOUND
					|| responseCode == HttpConstants.HTTP_FORBIDDEN)
				return null;
			int i = 1;
			String value, key;
			boolean hascharset = false;
			// while (true)
			// {
			// if ((key = connection.getHeaderFieldKey(i)) == null)
			// break;
			// if ((value = connection.getHeaderField(i++)) == null)
			// break;
			// System.out.println(key + ":" + value);
			// }
			value = connection.getHeaderField("Content-Type");
			// System.out.println("value is :" + value);
			if (value != null)
			{
				int index = value.indexOf("charset=");
				if (index >= 0)// 如果在Content-Type中指定charset，我们就用该编码，否则在读完之后查找编码
				{
					value = value.substring(index + 8);
					hascharset = true;
					// System.out.println("charsetttttttttttttt is :" + value);
				}
			}

			BufferedReader reader = null;
			if (hascharset)
			{
				reader = new BufferedReader(new InputStreamReader(
						connection.getInputStream(), value));
			}
			else
			// 如果找不到编码，我们默认将其设置为ISO-8859-1
			{
				reader = new BufferedReader(new InputStreamReader(
						connection.getInputStream(), "ISO-8859-1"));
			}
			String line;
			while ((line = reader.readLine()) != null)
			{
				// System.out.println(line);
				content.append(line + "\n");
			}
			if (!hascharset)// 在文件中查找编码，然后将读取的内容转换成该编码
			{
				int index = content.indexOf("charset=");
				if (index >= 0)
				{
					String charset = content.substring(index + 8, index + 18)
							.split("\"")[0];
					// System.out.println("charset is " + charset);
					byte[] b;
					b = content.toString().getBytes("ISO-8859-1");
					// System.out.println(new String(b, charset));
					return new String(b, charset);
				}
			}
			return content.toString();
		}
		catch (IOException e)
		{
			// e.printStackTrace();
			return null;
		}
	}
	public String html2Text(String inputString) 
	{    
		System.out.println("html2Text");
		String htmlStr = inputString; //含html标签的字符串    
		String textStr ="";    
		Pattern p_script,p_style,p_html,p_filter;    
		Matcher m_script,m_style,m_html,m_filter;      
	          
	    try { 
	    	//定义script正则式{或<script[^>]*?>[\s\S]*?<\/script> } 
	    	String regEx_script = "<script[^>]*?>[\\s\\S]*?</script>";    
	    	//定义style正则式{或<style[^>]*?>[\s\S]*?<\/style> }    
	    	String regEx_style = "<style[^>]*?>[\\s\\S]*?</style>"; 
	    	//定义HTML标签的正则表达式 
	    	String regEx_html = "<[^>]+>";
	        String[] filter = {"&quot;", "&nbsp;"};
	    	
	        p_script = Pattern.compile(regEx_script,Pattern.CASE_INSENSITIVE);    
	        m_script = p_script.matcher(htmlStr);    
	        htmlStr = m_script.replaceAll(""); //过滤script标签    
	   
	        p_style = Pattern.compile(regEx_style,Pattern.CASE_INSENSITIVE);    
	        m_style = p_style.matcher(htmlStr);    
	        htmlStr = m_style.replaceAll(""); //过滤style标签    
	           
	        p_html = Pattern.compile(regEx_html,Pattern.CASE_INSENSITIVE);    
	        m_html = p_html.matcher(htmlStr);    
	        htmlStr = m_html.replaceAll(""); //过滤html标签    
	           
	        //过滤style标签    &quot; &nbsp;
	        for(int i = 0; i < filter.length; i++)
	        {
	        	p_filter = Pattern.compile(filter[i],Pattern.CASE_INSENSITIVE);    
	        	m_filter = p_filter.matcher(htmlStr);    
		        htmlStr = m_filter.replaceAll(""); 
	        }
	        
	        textStr = htmlStr;    
	           
	    }catch(Exception e) {    
	       System.err.println("Html2Text: " + e.getMessage());    
	    }    
	          
	    return textStr;//返回文本字符串    
	}

	public String getContent(String content)
	{
		content=html2Text(content);
		//System.out.println(content);
		Pattern p = Pattern.compile("<.+>");
		Matcher m = p.matcher(content);
		content = m.replaceAll("");
		//System.out.println(content);
		
		p = Pattern.compile("\\s+");
		m = p.matcher(content);
		content = m.replaceAll("");
		//System.out.println(content);
		
		p = Pattern.compile("\\{.+\\}");
		m = p.matcher(content);
		content = m.replaceAll("");
		//System.out.println(content);
		return content;
	}

	public void writeToFile(String content) throws IOException 
	{
		try
		{
			//File directory = new File("data");//设定为当前文件夹
			DecimalFormat format = new DecimalFormat("00000000");
			String name = format.format(count++);
			PrintWriter writer = new PrintWriter(new FileOutputStream("D:\\data\\"+name+".txt"));
			//String newStr = URLEncoder.encode(content, "UTF-8");
			//String newStr = new String(content.getBytes("UTF-8")); 
			//String s = new String(content.getBytes("iso-8859-1"),"utf-8");
			writer.print(content);
			writer.close();
		}
		catch (FileNotFoundException e)
		{
			e.printStackTrace();
		}
	}

	/**
	 * @param args
	 */
	/*public static void main(String[] args)
	{

		try
		{
			URL url = new URL(" http://toolbarqueries.google.com.hk/search?client=navclient-auto" +
					"&hl=en&ch=63152358434&ie=UTF-8&oe=UTF-8&features=Rank&q=info:www.baidu.com");
			Download d = new Download();
			String content = d.downloadHttp(url);
			d.getContent(content);
			d.writeToFile(content);

			String s = "<gdf dfgdf" +
					">";
			Pattern p = Pattern.compile("<(.*|\\s*)*>");
			Matcher m = p.matcher(s);
			if (m.matches())
				s = m.replaceAll("");
			// s=s.replace("<(.*|\\s*)*>", "");
			System.out.println("fgf"+s);
			// content=content.replaceAll("[^\u4e00-\u9fa5]", "");
			// System.out.println(content);
			// StringTokenizer st=new StringTokenizer(content,"正则表达式");
			// System.out.println(st.countTokens());

			// String[] ss=content.split("正则表达式");
			// System.out.println(ss.length);
			// for(int i=0;i<ss.length;i++)
			// {
			// //System.out.println(ss[i]);
			// }
		}
		catch (MalformedURLException e)
		{
			e.printStackTrace();
		}
	}*/
}
