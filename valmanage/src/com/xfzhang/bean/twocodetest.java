package com.xfzhang.bean;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
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
  
public class twocodetest  
{  
	public static void main(String[] args) throws Exception, InterruptedException, IOException  
	{  
    OpenCVFrameGrabber grabber = new OpenCVFrameGrabber(0);    
    grabber.start();   //开始获取摄像头数据  
    CanvasFrame canvas = new CanvasFrame("摄像头");//新建一个窗口  
    canvas.setCanvasSize(400, 400);
    canvas.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);  
    canvas.setAlwaysOnTop(true);  
    
    String imgPath = "/Users/apple/Desktop/2017年毕设/twocode.png";
    String imgPath1 = "/Users/apple/Desktop/2017年毕设/test1.png";
    while(true)  
    {  
        if(!canvas.isDisplayable())  
        {//窗口是否关闭  
            grabber.stop();//停止抓取  
            System.exit(2);//退出  
        } 
        
        Java2DFrameConverter java2dFrameConverter = new Java2DFrameConverter();
         
        Frame img;
        img=grabber.grab();
        TwoDimensionCode handler = new TwoDimensionCode();
        canvas.showImage(grabber.grab());
       // grabbedImage = converter.convert(img); 
        BufferedImage bufferedImage= java2dFrameConverter.convert(img);
        ImageIO.write(bufferedImage, "PNG", new File(imgPath));
        
       /* decoderContent = handler.decoderQRCode(imgPath1);
        System.out.println(decoderContent);*/
        Thread.sleep(50);
        new Thread() {
            public void run() {
                while (true) {
                	String decoderContent="";
					decoderContent = handler.decoderQRCode(imgPath);
					System.out.println(decoderContent);
                }
            }
        }.start();
    }
        //获取摄像头图像并放到窗口上显示， 这里的Frame frame=grabber.grab(); frame是一帧视频图像  
        //50毫秒刷新一次图像  
        }
    }  

