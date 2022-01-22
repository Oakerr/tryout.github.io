/*jquery取色插件
作者：IT平民
网址：Http://www.sdcms.cn
部分代码素材取自百度的ueditor
*/
(function($,undefined)
{
	if(window.colorpicker)return false;//防止JS重复加载
	$.fn.colorpicker=function(options)
	{
		var setting=options;
		if(setting.inputid==null){setting.inputid="title";}
		if($(".sdcms-colorpicker").length===0)
		{
			var picker=new colorpick();
			var html=picker.init();
			$("body").append(html);
			$(".sdcms-colorpicker-nocolor").click(function(){
				$(".sdcms-colorpicker-preview").css("background","#fff");
				$(".sdcms-colorpicker").css("display","none");
				$("#"+setting.inputid).val("");
				if(setting.backid!=null){$("#"+setting.backid).css("background","none");}
			})
			$(".sdcms-colorpicker-no").click(function(){
				//$(".sdcms-colorpicker").css("display","none");
				$(".sdcms-colorpicker").remove()
			})
			$(".sdcms-colorpicker-colorcell").click(function(){
				var a=$(this).attr("data-color");
				$("#"+setting.inputid).val(a);
				if(setting.backid!=null){$("#"+setting.backid).css("background",a);}
				//$(".sdcms-colorpicker").css("display","none");
				$(".sdcms-colorpicker").remove()
			})
			$(".sdcms-colorpicker-colorcell").mouseover(function(){
				var a=$(this).attr("data-color");
				$(".sdcms-colorpicker-preview").css("background",a);
			})
			$(".sdcms-colorpicker-colorcell").mouseout(function(){
				$(".sdcms-colorpicker-preview").css("background","#fff");
			})
		}
		else
		{
			$(".sdcms-colorpicker").css("display","block");
		}
		$(".sdcms-colorpicker").css("top",setting.x);
		$(".sdcms-colorpicker").css("left",setting.y);
	};
	var colorpick=function()
	{
		this.init=function()
		{
			var COLORS=(
			'ffffff,000000,eeece1,1f497d,4f81bd,c0504d,9bbb59,8064a2,4bacc6,f79646,' +
			'f2f2f2,7f7f7f,ddd9c3,c6d9f0,dbe5f1,f2dcdb,ebf1dd,e5e0ec,dbeef3,fdeada,' +
			'd8d8d8,595959,c4bd97,8db3e2,b8cce4,e5b9b7,d7e3bc,ccc1d9,b7dde8,fbd5b5,' +
			'bfbfbf,3f3f3f,938953,548dd4,95b3d7,d99694,c3d69b,b2a2c7,92cddc,fac08f,' +
			'a5a5a5,262626,494429,17365d,366092,953734,76923c,5f497a,31859b,e36c09,' +
			'7f7f7f,0c0c0c,1d1b10,0f243e,244061,632423,4f6128,3f3151,205867,974806,' +
			'c00000,ff0000,ffc000,ffff00,92d050,00b050,00b0f0,0070c0,002060,7030a0,').split(',');
			var html='<div class="sdcms-colorpicker">' +
				'<div class="sdcms-colorpicker-topbar">' +
				 '<div unselectable="on" class="sdcms-colorpicker-preview"></div>' +
				 '<div unselectable="on" class="sdcms-colorpicker-no">\u5173\u95ed</div>' +
				 '<div unselectable="on" class="sdcms-colorpicker-nocolor">\u6e05\u9664\u989c\u8272</div>' +
				'</div>' +
				'<table style="border-collapse:collapse;" cellspacing="0" cellpadding="0">' +
				'<tr style="border-bottom:1px solid #ddd;line-height:25px;padding-top:2px"><td colspan="10" style="color:#366092;font-size:13px;">\u4e3b\u9898\u989c\u8272</td></tr>'+
				'<tr class="sdcms-colorpicker-tablefirstrow">';
			for (var i=0;i<COLORS.length;i++) {
				if(i&&i%10===0) {
					html+='</tr>'+(i==60?'<tr style="border-bottom:1px solid #ddd;line-height:25px;"><td colspan="10"  style="color:#366092;font-size:13px;">\u6807\u51c6\u989c\u8272</td></tr>':'')+'<tr'+(i==60?' class="sdcms-colorpicker-tablefirstrow"':'')+'>';
				}
				html+=i<70 ? '<td style="padding:0 2px;"><a hidefocus title="#'+COLORS[i]+'" href="javascript:" unselectable="on" class="sdcms-colorpicker-colorcell"' +
							' data-color="#'+ COLORS[i] +'"'+
							' style="background:#'+COLORS[i]+';border:solid #ccc;'+
							(i<10 || i>=60?'border-width:1px;':
							 i>=10&&i<20?'border-width:1px 1px 0 1px;':
							'border-width:0 1px 0 1px;')+
							'"'+
						'></a></td>':'';
			}
			html+='</tr></table></div>';
			return html;
		}
	}
})(jQuery);