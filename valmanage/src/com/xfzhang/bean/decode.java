package com.xfzhang.bean;

import java.util.concurrent.Callable;

public class decode implements Callable<String>{
	public String call() throws java.lang.Exception {
		TwoDimensionCode handler = new TwoDimensionCode();
		String imgPath = "/Users/apple/Desktop/2017年毕设/twocode.png";
        while (true) {
        	String decoderContent="";
        	decoderContent = handler.decoderQRCode(imgPath);
        	if(!decoderContent.equals("")){
        		return decoderContent;
        		}
        	System.out.println("hi "+decoderContent);
        	}
	}
}
