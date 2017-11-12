package search;

import java.io.*;
import java.net.*;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.PriorityBlockingQueue;
import java.util.regex.*;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextPane;
import javax.swing.text.BadLocationException;
import javax.swing.text.SimpleAttributeSet;
import javax.swing.text.StyleConstants;

import java.util.Calendar; 

public class Crawler
{
	private Calendar now; //= Calendar.getInstance();//now.getTimeInMillis()
	private long elapsed=0;
	private long current;
	private int status=0;
	private int jobcreat=0;
	private String title;
	private volatile static int threadNum = 0;
	private int urlCount = 1000;
	private volatile int visitedURL = 0;// 表示目前已经访问的网页个数
	private int threadCount = 5;// 表示最多同时允许运行多少个线程
	private double threshold = 0.90;
	private String startURL;
	// 采用hashtable，使其支持同步
	private Hashtable<String, Integer> keyWords = new Hashtable<String, Integer>();
	// 等待处理的网页
	private PriorityBlockingQueue<PriorityURL> waitforHandling = new PriorityBlockingQueue<PriorityURL>();
	// 用来表示我们已经访问过的网页
	private HashSet<String> isWaiting = new HashSet<String>();
	// 表示符合要求，最终要剩下显示的网页
	private Hashtable<String, String> wanted = new Hashtable<String, String>();
	// 我们保存的不相关的网页
	private HashSet<String> noneRelevant = new HashSet<String>();

	private boolean stop = false;
	
	
//	private boolean finished = false;

	//private JTextPane textpane;
	//private JLabel label;
	//private JButton button;
	
	ExecutorService threadPool = Executors.newCachedThreadPool();
	
	public int getjobcreat(){
		return jobcreat;
	}
	public void setjobcreat(int sc){
		this.jobcreat=sc;
	}
	
	public int getstatus(){
		return status;
	}
	public void setstatus(int st){
		this.status=st;
	}
	public long getelapsed(){
		return elapsed;
	}
	public void changeelapsed(){
		if(this.status == 1){
			now = Calendar.getInstance();
			this.elapsed = this.elapsed + now.getTimeInMillis() - current ;
		}
		
	}
	public long getcurrent(){
		return current;
	}
	public void changecurrent(){
		now = Calendar.getInstance();
		this.current = now.getTimeInMillis();
	}
	public String getTitle()
	{
		return title;
	}

	public void setTitle(String title)
	{
		this.title = title;
	}

	public int getUrlCount()
	{
		return urlCount;
	}

	public void setUrlCount(int urlCount)
	{
		this.urlCount = urlCount;
	}

	public int getThreadCount()
	{
		return threadCount;
	}

	public Enumeration<String> getKeyWords()
	{
		return keyWords.keys();
	}

	public void setThreshold(double threshold)
	{
		this.threshold = threshold;
	}

	public String getStartURL()
	{
		return startURL;
	}

	public void setStartURL(String startURL)
	{
		this.startURL = startURL;
	}

	public double getThreshold()
	{
		return threshold;
	}

	public void setThreadCount(int threadCount)
	{
		this.threadCount = threadCount;
	}

	public void addKeyWord(String word, int count)
	{
		keyWords.put(word, count);
	}

	public void removeKeyWord(String word)
	{
		if (word != null)
		{
			if (keyWords.containsKey(word))
			{
				keyWords.remove(word);
			}
		}
	}

	public void removeAllKeyWords()
	{
		keyWords.clear();
	}    
	/*public Crawler(String title, String start, JTextPane textpane, JLabel label,JButton button)
	{
		this.title = title;
		this.startURL = start;
		this.textpane = textpane;
		this.label = label;
		this.button=button;
	}*/
	private Crawler(String title, String start)
	{
		this.title = title;
		this.startURL = start;
		System.out.println(start);
		//this.textpane = null;
		//this.label = null;
		//this.button=null;
		this.elapsed=0;
		now = Calendar.getInstance();
		this.current=now.getTimeInMillis();
		//this.status=0;
		//this.urlCount = 10;
		//this.threadCount = 5;// 表示最多同时允许运行多少个线程
		//this.threshold = 0.90;
	}
    private static Crawler single=null;  
    //静态工厂方法   
    public static Crawler getInstance(String title, String start) {  
         if (single == null) {    
             single = new Crawler(title,start);  
         }    
        return single;  
    }
    public boolean createDir(String destDirName) {  
        File dir = new File(destDirName);  
        if (dir.exists()) {  
            System.out.println("创建目录" + destDirName + "失败，目标目录已经存在");  
            return false;  
        }  
        if (!destDirName.endsWith(File.separator)) {  
            destDirName = destDirName + File.separator;  
        }  
        //创建目录  
        if (dir.mkdirs()) {  
            System.out.println("创建目录" + destDirName + "成功！");  
            return true;  
        } else {  
            System.out.println("创建目录" + destDirName + "失败！");  
            return false;  
        }  
    } 	
	public void initialize()
	{
		stop = false;
		status=1;
		//label.setText("访问总数：0");
		String destDirName="D:\\data";
		createDir(destDirName);
		Download download = new Download();
		try
		{
			String content = download.downloadHttp(new URL(startURL));
			if(content==""){
				System.out.println("black");
				return;
			}
			String title = "";
			String regex = "<title>([^<]+)</title>";
			Pattern p = Pattern.compile(regex);
			Matcher m = p.matcher(content);
			if (m.find())
				title = m.group(1);
			System.out.println("title is " + title);
			int count;
			// 统计关键词的词频
			for (String key : keyWords.keySet())
			{
				count = content.split(key).length - 1;
				keyWords.put(key, count);
			}
			for (String key : keyWords.keySet())
			{
				System.out.println(key + "1:" + keyWords.get(key));
			}
			// 计算相关度
			double cos = calRelavancy(keyWords);
			// 提取网页中的链接
			ArrayList<String> urls = getLink(content, new URL(startURL));
			int length = urls.size();
			// 加入优先队列
			for (String s : urls)
			{
				waitforHandling.add(new PriorityURL(s, cos / length));
				if (!isWaiting.contains(s))
					isWaiting.add(s);
				// System.out.println(s);
			}

			wanted.put(startURL, title);
			visitedURL = 1;
			insertWeb(title + "----" + startURL);
			//label.setText("访问总数：" + visitedURL);
		}
		catch (MalformedURLException e)
		{
			e.printStackTrace();
		}
	}

	public void search(int threadNumber) throws IOException
	{
		String url, content, title = "";
		Download d = new Download();
		while (visitedURL < urlCount && status == 1) //!stop
		{
			if (waitforHandling.size() > 0)
			{
				url = waitforHandling.remove().getUrl();
				// isWaiting.remove(url);
			}
			else
				break;

			try
			{
				content = d.downloadHttp(new URL(url));
				if (content != null && content.length()>=350)  //超过字符容量的判断值，则认为相关的存储信息的是有价值的文本，否则删除
				{
					Hashtable<String, Integer> destination = new Hashtable<String, Integer>();

					int count;
					// 统计关键词的词频
					for (String key : keyWords.keySet())
					{
						count = content.split(key).length - 1;
						destination.put(key, count);
					}

					// 计算相关度
					double cos = calRelavancy(destination);
					synchronized (this)
					{
						if (cos < threshold || !content.contains(this.title) )  //|| !content.contains(this.title)包含主题
						{
							noneRelevant.add(url);
							continue;// 如果相关度小于阈值，则忽略该网页
						}
					}
					// 提取网页中的链接
					ArrayList<String> urls = getLink(content, new URL(url));
					int length = urls.size();
					if (length/url.length()> 80){    //链接数量（LinkNum）和链接长度（LinkLength）的比值进行综合判断,大于80，则代表无用信息
						noneRelevant.add(url);
						continue;
					}  
					// 获取title
					String regex = "<title>([^<]+)</title>";
					Pattern p = Pattern.compile(regex);
					Matcher m = p.matcher(content);
					if (m.find())
						title = m.group(1);
					// 加入优先队列
					for (String s : urls)
					{
						// 访问不会修改，无需同步
						if (wanted.containsKey(s))
						{
							continue;
						}
						if (noneRelevant.contains(s))
						{
							continue;
						}
						synchronized (this)
						{
							if (!isWaiting.contains(s))
							{
								int numberofslash = url.split("/").length - 1;

								waitforHandling.add(new PriorityURL(s, cos
										/ length / numberofslash));
								isWaiting.add(s);
							}
						}
					}
					wanted.put(url, title);
					System.out.println(url);
					//System.out.println(content);
					content=d.getContent(content);
					d.writeToFile(content);
					insertWeb(title + "----" + url);
					synchronized (this)
					{
						// 当我们处理完一个网页之后，该网页要么是我们想要的，要么是低于阈值的，将其从等待队列中删除
						isWaiting.remove(url);
						visitedURL++;
						System.out.println(visitedURL);
						//label.setText("访问总数：" + visitedURL);
						// System.out.println("Thread " + threadNumber
						// /*+ ":cos is " + cos */+ ",size is " + visitedURL
						// + ",waiting size is " + waitforHandling.size()
						// + ",add " + url);
					}
				}
			}
			catch (MalformedURLException e)
			{
				// e.printStackTrace();
				continue;
			}
		}
		System.out.println("current thread num is " + --threadNum+",waiting size is "+waitforHandling.size());
		synchronized (this)
		{
			wanted.clear();
			waitforHandling.clear();
			noneRelevant.clear();
			isWaiting.clear();
		}
	}

	private void insertWeb(String web)
	{
		SimpleAttributeSet set = new SimpleAttributeSet();
		StyleConstants.setUnderline(set, true);
		/*try
		{
			textpane.getDocument().insertString(
					textpane.getDocument().getLength(), web + "\n", set);
		}
		catch (BadLocationException e)
		{
			e.printStackTrace();
		}*/
	}
    public boolean getstop(){
    	return stop;
    }
    public int getvisitedURL(){
    	return visitedURL;
    }
    public int getwanted(){
    	return wanted.size();
    }
	public void stopSearch()
	{
		stop = true;
		status=2;
		//this.changeelapsed();
	//	changecurrent();
		synchronized (this)
		{
			wanted.clear();
			waitforHandling.clear();
			noneRelevant.clear();
			isWaiting.clear();
		}
	}

	/**
	 * 计算相关度
	 * 
	 * @param destination
	 *            ：目标网页与初始的主题网页计算相关度
	 * @return
	 */
	public double calRelavancy(Hashtable<String, Integer> destination)
	{
		long sum1 = 0, sum2 = 0, sum3 = 0;
		for (String key : keyWords.keySet())
		{
			sum1 += keyWords.get(key).intValue()
					* destination.get(key).intValue();
			sum2 += keyWords.get(key).intValue() * keyWords.get(key).intValue();
			sum3 += destination.get(key).intValue()
					* destination.get(key).intValue();
		}
		if (sum3 == 0 || sum2 == 0)
			return 0;// 如果一个网页和我们的主题没有关系，有可能会计算出0，不能用在分母中
		return sum1 * 1.0 / (Math.sqrt(sum2) * Math.sqrt(sum3));
	}

	/**
	 * 获取一个网页的链接
	 * 
	 * @param content
	 *            ：从字符串中提取链接
	 * @param url
	 *            ：有些链接有默认的host，所以我们需要给出content对应的网页
	 * @return
	 */
	public ArrayList<String> getLink(String content, URL url)
	{
		ArrayList<String> urls = new ArrayList<String>();
		String regex = "<a\\s*href=\"([^>\"]*)\"[^>]*>";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(content);
		String s;
		while (m.find())
		{
			s = m.group(1);
			if (s.length() == 1)
				continue;
			if (s.startsWith("/"))
				s = "http://" + url.getHost() + s;
			// System.out.println(s);
			if (s.startsWith("http"))
				urls.add(s);
		}
		return urls;
	}

	public void writeToFile()
	{
		try
		{
			PrintWriter writer = new PrintWriter(new FileOutputStream("result"));
			// System.out.println("wanted size is " + wanted.size());
			Enumeration<String> want = wanted.keys();
			while (want.hasMoreElements())
			{
				writer.println((String) want.nextElement());
			}
			writer.close();
		}
		catch (FileNotFoundException e)
		{
			e.printStackTrace();
		}
	}

	public void parallelhandle()
	{
		for (int i = 0; i < threadCount; i++)
		{
			new Task(i).start();
		}
		try
		{
			Thread.sleep(1);
		}
		catch (InterruptedException e)
		{
				e.printStackTrace();
		}
		//不启动一个线程来判断，则界面会死掉
		Runnable task = new Runnable() {
			public void run() {
				while (threadNum > 0)
					;
				//button.setEnabled(true);
				System.out.print("Finish searching the pages!");
			//	JOptionPane.showMessageDialog(null, "Finish searching the pages!",
						//"Done", JOptionPane.INFORMATION_MESSAGE);
				//status=2;
			}
		};
		threadPool.execute(task);// 通过启动一个新的线程来执行解释程序
		
		
	}

	/**
	 * 表示一个任务的内部类，用来执行网页搜索
	 * 
	 * @author ygch
	 * 
	 */
	class Task extends Thread
	{
		int number;

		Task(int number)
		{
			this.number = number;
			threadNum++;
		}

		public void run()
		{
			try {
				search(number);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	/**
	 * @param args
	 */
	/*public static void main(String[] args)
	{
		Crawler crawler = new Crawler("云计算", "http://cloud.csdn.net/",
				new JTextPane(), new JLabel(),new JButton());
		crawler.addKeyWord("云计算", 0);
		crawler.addKeyWord("数据中心", 0);
		crawler.addKeyWord("平台", 0);
		crawler.addKeyWord("架构", 0);
		crawler.addKeyWord("数据库", 0);
		crawler.addKeyWord("安全", 0);
		crawler.addKeyWord("Hadoop", 0);
		crawler.addKeyWord("存储", 0);
		crawler.addKeyWord("虚拟化", 0);
		crawler.addKeyWord("隐私", 0);
		crawler.addKeyWord("黑客", 0);
		crawler.addKeyWord("分布式", 0);
		crawler.addKeyWord("MapReduce", 0);
		crawler.addKeyWord("cloud", 0);
		// crawler.addKeyWord("大数据", 0);
		crawler.initialize();
		crawler.parallelhandle();
		while (threadNum > 0)
			;
		crawler.writeToFile();
	}*/
}
