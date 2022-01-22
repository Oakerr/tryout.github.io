	$(function()
	{
		if($("#sdcms_buy").length>0&&$(".buytip").length>0)
		{
			 $.ajax(
			{
				type:"post",
				cache:false,
				url:webroot+"plug/buy.asp?act=load",
				data:"id="+infoid,
				success:function(_)
				{
					var act=_.substring(0,1);
					var info=_.substring(1);
					switch(act)
					{
						case "0":
							//$.fn.tips({content:info});
							break;
						case "1":
							$.fn.tips({content:info});
							break;
						case "2":
							$("#sdcms_buy").css("display","none");
							$("#sdcms_content").html(info);
							break;
						default:
							alert(_);
							break;
					}
				}
			});
		}
		//
	})
