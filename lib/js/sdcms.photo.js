$(function(){                          
    var index=0;
	var splitnum=5;
    var length=$("#originalpic li").length;
    var i=1;
	//关键函数：通过控制i ，来显示图片
	function showImg(i){
		$("#originalpic li")
			.eq(i).stop(true,true).fadeIn(800)
			.siblings("li").hide();
		 $(".thumbpic li")
			.eq(i).addClass("hover")
			.siblings().removeClass("hover");
		//增加对IE6的判断，使高度=图片的高
		if($.browser.msie&&($.browser.version == "6.0")&&!$.support.style){ 
		 $("#aPrev,#aNext").css("height",$("#originalpic li").eq(i).height()+"px")
		} 
	}
	function slideNext(){
		if(index>=0&&index<length-1) {
			 ++index;
			 showImg(index);
		}else{
			/*if(confirm("已经是最后一张,点击确定重新浏览！")){
				index=0;
				showImg(0);
				//所有图片数 - 可见图片数 * 每张的距离 = 最后一张滚动到第一张的距离
				if(length>=splitnum){aniPx=(length-splitnum)*92+'px';$("#piclist ul").animate({"left":"+="+aniPx},200);}
				i=1;	
			}
			*/
			//
			dialog({title:"\u0053\u0044\u0043\u004d\u0053\u63d0\u793a",content:"\u5df2\u7ecf\u662f\u6700\u540e\u4e00\u5f20\u002c\u70b9\u51fb\u786e\u5b9a\u91cd\u65b0\u6d4f\u89c8\uff01",ok:function(){index=0;
				showImg(0);
				//所有图片数 - 可见图片数 * 每张的距离 = 最后一张滚动到第一张的距离
				if(length>=splitnum){aniPx=(length-splitnum)*92+'px';$("#piclist ul").animate({"left":"+="+aniPx},200);}
				i=1;},cancel:true}).showModal();
			//
		}
		if(i<0||i>length-splitnum){return false;}						  
		$("#piclist ul").animate({"left":"-=92px"},200)
		i++;
		}
	 
	function slideFront(){
		if(index<=0){$.fn.tips({content:"\u5df2\u7ecf\u662f\u7b2c\u4e00\u5f20",time:3000});return false}
	   if(index>=1){
			 --index;
			 showImg(index);
		}
		if(i<2||i>length+splitnum){return false;}
		$("#piclist ul").animate({"left":"+=92px"},200)
		i--;
	}
	
	$("#originalpic li").eq(0).show();
	//增加对IE6的判断，使高度=图片的高
	if($.browser.msie&&($.browser.version=="6.0")&&!$.support.style){ 
	 $("#aPrev,#aNext").css("height",$("#originalpic li").eq(0).height()+"px")
	} 
	$(".thumbpic li").eq(0).addClass("hover");
	$(".thumbpic tt").each(function(e){
		var str=(e+1)+"/"+length;
		$(this).html(str)
	})

	$(".bntnext,#aNext").click(function(){
		   slideNext();
	   })
	$(".bntprev,#aPrev").click(function(){
		   slideFront();
	   })
	$(".thumbpic li").click(function(){
		index  =  $(".thumbpic li").index(this);
		showImg(index);
	});		
	//
	//var timeid = setInterval(function(){slideNext()},4000);
    })	