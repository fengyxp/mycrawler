package search;
import java.util.regex.*;


public class RegularTest
{

	/**
	 * @param args
	 */
	public static void main(String[] args)
	{
		// TODO Auto-generated method stub
		String s="(((m)";
		Pattern p=Pattern.compile("(?m)");
		Matcher m=p.matcher(s);
		if(m.find())
		{
			String a[]=p.split(s);
			for(int i=0;i<a.length;i++)
			{
				System.out.println(i+":"+a[i]);
			}
			s=m.replaceAll("ds");
			System.out.println("find:"+s);
		}
		else
		{
			String a[]=p.split(s);
			for(int i=0;i<a.length;i++)
			{
				System.out.println(i+":"+a[i]);
			}
			s=m.replaceAll("ds");
			System.out.println("find:"+s);
		}
	}

}
