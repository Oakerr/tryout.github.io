<%if not in_sdcms then response.write("template load fail"):response.end() end if%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=7" />
    <title>{sdcms.iif(sdcms.strlen(seotitle)>0,seotitle,classname)}{if page>1}_第{page}页{/if}_{sdcms[webname]}</title>
    <meta name="Keywords" content="{seokey}" />
    <meta name="Description" content="{if seodesc<>""}{seodesc}{else}{/if}" />
    <meta name="author" content="{weburl}" />
    <meta name="copyright" content="{weburl}" />
    <link rel="canonical" href="{weburl}{sdcms.getcateurl(classid)}"/> 
    <script>var webroot="{webroot}",murl="list.asp?classid={classid}";</script>
    {if sdcms[sys_mobile]}<script src="{webroot}lib/js/mobile.js"></script>{/if}
    <link href="{skins}/css/css.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="{skins}/js/jquery.min.js"></script>
    <script language="JavaScript">< !--Hide
      function killErrors() {
        return true;
      }
      window.onerror = killErrors;
      // -->
      </script>
  </head>
  
  <body>
{sdcms:include("../../sdcms_head.asp")}
    <script>function dropMenu(obj) {
        $(obj).each(function() {
          var theSpan = $(this);
          var theMenu = theSpan.find(".submenu");
          var tarHeight = theMenu.height();
          theMenu.css({
            height: 0,
            opacity: 0
          });

          var t1;

          function expand() {
            clearTimeout(t1);
            theSpan.find('a').addClass("selected");
            theMenu.stop().show().animate({
              height: tarHeight,
              opacity: 1
            },
            200);
          }

          function collapse() {
            clearTimeout(t1);
            t1 = setTimeout(function() {
              theSpan.find('a').removeClass("selected");
              theMenu.stop().animate({
                height: 0,
                opacity: 0
              },
              200,
              function() {
                $(this).css({
                  display: "none"
                });
              });
            },
            250);
          }

          theSpan.hover(expand, collapse);
          theMenu.hover(expand, collapse);
        });
      }

      $(document).ready(function() {

        dropMenu(".drop-menu-effect");

      });</script>
    <div class="innerwrap">
      <div class="ny_ban">
        <img src="{if catepic=""}{webroot}upfile/nb.jpg{else}{catepic}{/if}" alt="{classname}banner"/></div>
      <div class="ny_mbx">您当前的位置：<a href="{webroot}">首页</a>{sdcms.getpostion(parentid," > ")}</div>
      <div>
        <div class="l_left">
          <ul class="nav_list">{sdcms:rs table="sd_category" top="0" where="followid = [topid]" order="ordnum,cateid" }
            <li{if $rs[cateid]=classid} class="in-on"{/if}><a href="{$rs[link]}">{$rs[catename]}</a></li>{/sdcms:rs}
          </ul>
{sdcms:rs top="5" field="fileurl,url,title" table="sd_expand_ad" where="islock=1 and classid=7" order="ordnum,id"}
          <a href="{$rs[url]}" target="_blank"><img class="mt33" src="{$rs[fileurl]}" alt="{$rs[title]}" width="216" /></a>{/sdcms:rs}</div>
        <div class="l_center">
          <div class="lm_name">
            <span>{classname}</span></div>
          <div class="content">

{sdcms:rs table="sd_model_page" top="1" where="classid=[classid]"}
{sdcms.get_content_split($rs[content],htmlrule)}
{/sdcms:rs}
{if get_content_page<>""}<div class="page">{get_content_page}</div>{/if}

{if classid=5}
<!--地图开始-->
<style type="text/css">
#allmap {width: 100%;height:400px;margin-top:20px;overflow: hidden;font-family:"微软雅黑";}
#allmap b{color: #CC5522;font-size: 14px; }
</style>
<div id="allmap"></div>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=OfldXkI591GW281wpaUBSHES"></script>
<script type="text/javascript">
	  var wzb="{wzb}"        //坐标参数
	  var strs= new Array();
	  strs=wzb.split(",");
	  var wzby=parseFloat(strs[0])
	  var wzbe=parseFloat(strs[1])
	  var winfo="<p><b>{sdcms[webname]}</b></p><p>电话：{wdh}</p>"    //联系信息
	  newditu(wzby,wzbe,winfo)
function newditu(wzby,wzbe,winfo){
	  var map = new BMap.Map("allmap");
	  map.centerAndZoom(new BMap.Point(wzby,wzbe), 17);
	  var marker1 = new BMap.Marker(new BMap.Point(wzby,wzbe));  // 创建标注
	  map.addOverlay(marker1);              // 将标注添加到地图中
	  marker1.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
	  map.enableScrollWheelZoom();//启动鼠标滚轮缩放地图
	  map.enableKeyboard();//启动键盘操作地图			
	  //创建信息窗口
	  var infoWindow1 = new BMap.InfoWindow(winfo);
	  marker1.openInfoWindow(infoWindow1);
}
</script>
<!--地图结束-->
{/if}

	  </div>
        </div>
      </div>
    </div>
{sdcms:include("../../sdcms_foot.asp")}