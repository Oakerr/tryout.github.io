	$(function()
	{
		//检查是否登录
		if($(".downlist").length>0)
		{
			$(".downlist").click(function(){
				var config=$(this).attr("config");
				config=config.split(":");
				var id=config[0];
				var point=config[1];
				var order=config[2];
				if(point=="0")
				{
					window.open(webroot+"plug/down.asp?id="+id+"&order="+order+"");
				}
				else
				{
					
				var html="<div style=\"font-size:14px;line-height:30px;\">确定要支付<span style=\"color:#f00;margin:0 3px;\">"+point+"</span>积分，下载此资源吗？<div style=\"color:#999\">提示：不重复扣分</div></div>";
				dialog({
					title:"\u8d2d\u4e70\u63d0\u793a",
					content:html,
					okValue:"\u8d2d\u4e70",
					ok:function()
					{
						$.ajax(
						{
							type:"post",
							cache:false,
							url:webroot+"plug/down.asp?id="+id+"&order="+order+"",
							success:function(_)
							{
								var act=_.substring(0,1);
								var info=_.substring(1);
								switch(act)
								{
									case "0":
										$.fn.tips({type:"error",content:info,time:3000});
										break;
									case "1":
										var url=document.location.href;
										dialog({title:"\u8d2d\u4e70\u63d0\u793a",content:info,button:[{value:'\u767b\u5f55',callback:function(){location.href=webroot+'user/login.asp?url='+url},autofocus:true},{value:'\u6ce8\u518c',callback:function(){location.href=webroot+'user/reg.asp'}}],cancel:true}).showModal();
										break;
									case "2":
										dialog({title:"\u8d2d\u4e70\u63d0\u793a",content:info,button:[{value:'\u5145\u503c',callback:function(){location.href=webroot+'user/pay.asp'},autofocus:true}],cancel:true}).showModal();
										break;
									case "3":
										$.fn.tips({type:"ok",content:"购买成功",time:3000});
										setTimeout(function(){location=info;},1500);
										break;
									default:
										alert(_);
										break;
								}
							}
						});
					},
					cancel:true}
					).showModal();
			}
				//
			})
			
			
			
		}
		//
	})
