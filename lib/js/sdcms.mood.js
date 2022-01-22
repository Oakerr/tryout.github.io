$(function(){
	if($("#mood").length>0)
	{
		$.ajax(
			{
				type:"post",
				cache:false,
				url: webroot+"plug/mood.asp?act=load",
				data:"cid="+infoid,
				success:function(_)
				{
					if(_!="error")
					{
						var mood=_.split(":");
						for(i=0;i<8;i++)
						{
							var mood_arr=mood[i].split('#');
							$("#mood_"+(i+1)).html(mood_arr[0]);
							$("#mood_num_"+(i+1))[0].style.height=mood_arr[1]*0.5+'px';
						}	
					}
				}
			}
		);
	}
	//
	$("#mood li div a").click(function(){
		var mtype=$(this).attr("config");
		var data="cid="+infoid;
			data+="&mtype="+encodeURIComponent(mtype);
			$.ajax(
			{
				type:"post",
				cache:false,
				url: webroot+"plug/mood.asp?act=up",
				data:data,
				success:function(_)
				{
					if(_=="error")
					{
						$.fn.tips({content:"\u60a8\u4e0d\u662f\u5df2\u7ecf\u8868\u8fc7\u6001\u4e86\u561b\uff01"});
					}
					else
					{
						addNum("mood_num_"+(mtype))
						var mood=_.split(":");
						for(i=0;i<8;i++)
						{
							var mood_arr=mood[i].split('#');
							$("#mood_"+(i+1)).html(mood_arr[0]);
							$("#mood_num_"+(i+1))[0].style.height=mood_arr[1]*0.5+'px';
						}	
					}
					
				}
			}
	);
	})
})