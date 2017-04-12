package com.xfzhang.bean;
import java.applet.Applet;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.FutureTask;

import javax.imageio.ImageIO;
import javax.swing.JFrame;

import org.bytedeco.javacv.CanvasFrame;
import org.bytedeco.javacv.Frame;
import org.bytedeco.javacv.FrameGrabber.Exception;

import org.bytedeco.javacv.Java2DFrameConverter;
import org.bytedeco.javacv.OpenCVFrameGrabber;  
  
/** 
 * 调用本地摄像头窗口视频 
 * @author eguid   
 * @version 2016年6月13日   
 * @see javavcCameraTest   
 * @since  javacv1.3 
 */  
  
@SuppressWarnings("serial")
public class TwoDimensionCodeApplet extends Applet 
{  
	OpenCVFrameGrabber grabber= new OpenCVFrameGrabber(0);
	CanvasFrame canvas = new CanvasFrame("摄像头");//新建一个窗口 ;
	TwoDimensionCode handler = new TwoDimensionCode();
	
	public String imgPath = "/Users/apple/Desktop/2017年毕设/twocode.png";
    public String imgPath1 = "/Users/apple/Desktop/2017年毕设/test1.png";
	protected Throwable thrown;
	public void init(){ 
		try {
			grabber.start();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}   //开始获取摄像头数据  
		canvas.setSize(400, 400);
		canvas.setCanvasSize(400, 400);
		canvas.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);  
		canvas.setAlwaysOnTop(true); 
		while(true)  
		{  
			if(!canvas.isDisplayable()){//窗口是否关闭  
				try {
					grabber.stop();
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.exit(2);//退出  
        } 
        
        Java2DFrameConverter java2dFrameConverter = new Java2DFrameConverter();  
        Frame img = null;
   
			try {
				img=grabber.grab();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}   
			try {
				canvas.showImage(grabber.grab());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
       // grabbedImage = converter.convert(img); 
        BufferedImage bufferedImage= java2dFrameConverter.convert(img); 
			try {
				ImageIO.write(bufferedImage, "PNG", new File(imgPath));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				Thread.sleep(50);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
			new Thread() {
	            public void run() { 
	            	try{
	            		String decoderContent="";
						decoderContent = handler.decoderQRCode(imgPath);
						System.out.println(decoderContent);	  
	            	}catch(Throwable e){
	            		 thrown = e;
	                } finally {
	                    threadDeal(this, thrown);
	            	}
	                	              
	            }
	            public void threadDeal(Runnable r, Throwable t) {
	               // System.out.println("==Exception: " + t.getMessage());
	            } 
	        }.start();
			
			
	}
		
	}

	
	
	
}


	
	


