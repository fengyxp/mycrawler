package search;

import java.awt.Desktop;
import java.io.File;
import java.net.*;


public class openfile {
	public openfile(){
		
	}
	public void open(String path) {    
		final Runtime runtime = Runtime.getRuntime();    
	    Process process = null;//    
	    final String cmd = "rundll32 url.dll FileProtocolHandler file://"+path;     //C:\\Users\\miss\\Desktop\\1.txt
	    try {    
	        process = runtime.exec(cmd);    
	    } catch (final Exception e) {    
	        System.out.println("Error exec!");    
	    }
		
	}
	public void opensystem(){
		File file = new File("D:/data");
		if(!file.exists()){
		    file.mkdirs();
		}
		// import java.awt.desktop
		if(Desktop.isDesktopSupported()){
		    Desktop desktop = Desktop.getDesktop();
		    //desktop.open(file);
		
		    try {  
	           desktop.open(file);  
	        } catch (Exception e) {  
	           e.printStackTrace();  
	        }
		 }
	}
	
}
