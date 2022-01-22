﻿<%
''' SDCMS 图片水印
''' ==================================================================
''' 版权所有 http://www.sdcms.cn
''' ------------------------------------------------------------------
''' 这不是一个自由软件！您只能在不用于商业目的的前提下对程序代码进行修改和使用；
''' 未经授权不允许对程序代码以任何形式任何目的的再发布。
''' ==================================================================
''' 编写: IT平民
''' 修改：IT平民 in 2014.04

class sdcms_draw
	private jpeg_name,jpeg_type,jpeg_text,jpeg_textcolor,jpeg_textfont,jpeg_fontsize,jpeg_bold
	private jpeg_photo,jpeg_bgcolor
	private jpeg_minwidth,jpeg_minheight,jpeg_transparent,jpeg_quality,jpeg_position
	private aspjpeg,logobox,draw_x,draw_y
	
	private sub class_initialize()
		jpeg_name=sdcms.getsys("jpeg_name")
		jpeg_type=sdcms.getsys("jpeg_type")
		jpeg_text=sdcms.getsys("jpeg_text")
		jpeg_textcolor=sdcms.getsys("jpeg_textcolor")
		jpeg_textcolor="&H"&replace(jpeg_textcolor,"#","")
		jpeg_textfont=sdcms.getsys("jpeg_textfont")
		jpeg_fontsize=sdcms.getsys("jpeg_fontsize")
		jpeg_bold=sdcms.iif(sdcms.getsys("jpeg_bold")="true",true,false)
		
		jpeg_photo=sdcms.getsys("jpeg_photo")
		jpeg_bgcolor=sdcms.getsys("jpeg_bgcolor")
		jpeg_bgcolor="&H"&replace(jpeg_bgcolor,"#","")
		
		jpeg_minwidth=sdcms.getsys("jpeg_minwidth")
		jpeg_minheight=sdcms.getsys("jpeg_minheight")
		jpeg_transparent=sdcms.getsys("jpeg_transparent")
		jpeg_quality=sdcms.getsys("jpeg_quality")
		jpeg_position=getrndnum(sdcms.getsys("jpeg_position"))		
	end sub
	
	private sub class_terminate
		set aspjpeg=nothing
		set logobox=nothing
	end sub
	
	public sub add(byval t0)
		if jpeg_name="" then exit sub
		if not(sdcms.isinstall("persits.jpeg")) then  exit sub
		set aspjpeg=server.createObject("persits.jpeg")
		set logobox=server.createobject("persits.jpeg")
		if not(sdcms.isfile(t0)) then exit sub
		aspjpeg.open server.mappath(t0)
		if not(aspjpeg.originalwidth>=clng(jpeg_minwidth) or aspjpeg.originalheight>=clng(jpeg_minheight)) then exit sub
		
		if jpeg_type="true" then
			jpeg_minwidth=(jpeg_fontsize+1)*getstrlen(jpeg_text)/2
			jpeg_minheight=jpeg_fontsize+1
			draw_x=drawimage_x(aspjpeg.originalwidth,jpeg_minwidth,10)
			draw_y=drawimage_y(aspjpeg.originalheight,jpeg_minheight,10)
			aspjpeg.canvas.font.color		=jpeg_textcolor	
			aspjpeg.canvas.font.family		=jpeg_textfont
			aspjpeg.canvas.font.bold		=jpeg_bold
			aspjpeg.canvas.font.size		=jpeg_fontsize
			aspjpeg.canvas.print draw_x,draw_y,jpeg_text	
			aspjpeg.canvas.pen.color		=&H000000		
			aspjpeg.canvas.pen.width		=0				 
			aspjpeg.canvas.brush.solid	    =false			  
			aspjpeg.quality=jpeg_quality                    
			aspjpeg.save server.mappath(t0)
		else
			if jpeg_photo="" then exit sub
			if not(sdcms.isfile(jpeg_photo)) then exit sub
			logobox.open server.mappath(jpeg_photo)
			logobox.width=logobox.originalwidth							                 
			logobox.height=logobox.Originalheight   						              
			draw_x=drawimage_x(aspjpeg.originalwidth,logobox.originalwidth,10)
			draw_y=drawimage_y(aspjpeg.originalheight,logobox.Originalheight,10)
			if instr(lcase(jpeg_photo),".png")>0 then
				aspjpeg.canvas.drawpng draw_x,draw_y,server.mappath(jpeg_photo)
				aspjpeg.quality=jpeg_quality
				aspjpeg.save server.mappath(t0)
			else
				aspjpeg.drawimage draw_x,draw_y,logobox,jpeg_transparent,jpeg_bgcolor,100 
				aspjpeg.quality=jpeg_quality                                                
				aspjpeg.save server.mappath(t0)
			end if
			
		end if
	end sub
	
	function drawimage_x(byval t0,byval t1,byval t2)
		select case jpeg_position
			case "0"
				drawimage_x=t2
			case "1"
				drawimage_x=t2
			case "2"
				drawimage_x=(t0-t1)/2
			case "3"
				drawimage_x=t0-t1-t2
			case "4"
				drawimage_x=t0-t1-t2
			case else
				drawimage_x=0
		end select
	end function

	function drawimage_y(byval t0,byval t1,byval t2)
		select case jpeg_position
			case "0"
				drawimage_y=t2
			case "1"
				drawimage_y=t0-t1-t2
			case "2"
				drawimage_y=(t0-t1)/2
			case "3"
				drawimage_y=t2
			case "4"
				drawimage_y=t0-t1-t2
			case else
				drawimage_y=0
		end select
	end function
	
	function getstrlen(byval t0)
		dim t1,c,i
		if isnull(t0) then getstrlen=0:exit function
		t1=0
		for i=1 to len(t0)
			c=ascw(mid(t0,i,1))
			if c<0 or c>255 then t1=t1+2 else t1=t1+1
		next
		getstrlen=t1
	end function
	
	function getrndnum(byval t0)
		if t0="5" then
			randomize
			getrndnum=int(5*rnd)
		else
			getrndnum=t0
		end if
	end function
end class
%>