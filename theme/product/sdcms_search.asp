<%if not in_sdcms then response.write("template load fail"):response.end() end if%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=7" />
    <title>{key}搜索结果_{sdcms[webname]}</title>
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
{sdcms:include("sdcms_head.asp")}
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
      <div class="ny_mbx">您当前的位置：<a href="{webroot}">首页</a> > {key}搜索结果</div>
      <div>
        <div class="l_left">
          <ul class="nav_list">{sdcms:rs table="sd_category" top="0" where="followid = 1" order="ordnum,cateid" }
            <li{if $rs[cateid]=classid} class="in-on"{/if}><a href="{$rs[link]}">{$rs[catename]}</a></li>{/sdcms:rs}
          </ul>
{sdcms:rs top="5" field="fileurl,url,title" table="sd_expand_ad" where="islock=1 and classid=7" order="ordnum,id"}
          <a href="{$rs[url]}" target="_blank"><img class="mt33" src="{$rs[fileurl]}" alt="{$rs[title]}" width="216" /></a>{/sdcms:rs}</div>
        <div class="l_center">
          <div class="lm_name">
            <span>{key}搜索结果</span></div>
          <div class="content">
            <div class="newslist">
              <ul>{sdcms:rs field="id,isurl,url,ispic,pic,title,style,classid,point,createdate" table="sd_content" where="islock=1[sql_where]" order="ontop desc,createdate desc" pagesize="20"}
{rs:eof}<li>没有资料</li>{/rs:eof}
                <li>
                  <span>{sdcms.getdate($rs[createdate],".",1)}</span>
                  <a href="{$rs[link]}" title="{$rs[title]}">{sdcms.highlight(sdcms.cutstr($rs[title],60,1),key)}</a></li>{/sdcms:rs}
              </ul>
              <div class="qipapage">{showpage}</div>
            </div>
          </div>
        </div>
      </div>
    </div>
{sdcms:include("sdcms_foot.asp")}