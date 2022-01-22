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
          <ul class="nav_list">{sdcms:rs table="sd_category" top="0" where="followid = 4" order="ordnum,cateid" }
            <li{if $rs[cateid]=classid} class="in-on"{/if}><a href="{$rs[link]}">{$rs[catename]}</a></li>{/sdcms:rs}
          </ul>
{sdcms:rs top="5" field="fileurl,url,title" table="sd_expand_ad" where="islock=1 and classid=7" order="ordnum,id"}
          <a href="{$rs[url]}" target="_blank"><img class="mt33" src="{$rs[fileurl]}" alt="{$rs[title]}" width="216" /></a>{/sdcms:rs}</div>
        <div class="l_center">
          <div class="lm_name">
            <span>{classname}</span></div>
          <div class="content">

            <div class="feedback_zx">
              <a href="#book" class="gotobook">我要咨询</a></div>
            <div class="faq">
              <ul>{sdcms:rs field="avatar,username,createdate,content,reply" table="sd_expand_book" where="islock=1" order="id desc" pagesize="20" isadminurl="0"}
                <li>
                  <div>{$rs[content]}</div>{if $rs[reply]<>""}
                  <p>{$rs[reply]}</p>{/if}
                </li>{/sdcms:rs}
              </ul>
              <div class="qipapage">{showpage}</div>
            </div>



            <style type="text/css">.table_form th{width:80px!important;}</style>
            <link href="{skins}/css/table_form.css" rel="stylesheet" type="text/css" />
            <div style="width:520px; height:330px; overflow:hidden;display:none;" id="bookform">
              <form action="{webroot}plug/book.asp?act=add" method="post" id="bookforms" onsubmit="return checkbook(this);">
                <table cellspacing="1" cellpadding="0" class="table_form" width="650px" style="font-family:Microsoft Yahei">
                  <tbody>
                    <tr>
                      <th align="right">姓　　名：</th>
                      <td>
                        <input type="text" value="" id="name" name="t0" class="input-text"></td>
                    </tr>
                    <tr>
                      <th>性　　别：</th>
                      <td>
                        <input type="radio" value="0" name="t3" id="sex" checked="checked" />保密
                        <input type="radio" value="1" name="t3" id="sex" />男
                        <input type="radio" id="sex" value="2" name="t3" />女</td></tr>
                    <tr>
                      <th>联 系QQ：</th>
                      <td>
                        <input type="text" size="40" value="" name="t6" id="lxqq" class="input-text"></td>
                    </tr>
                    <th>电子邮箱：</th>
                    <td>
                      <input type="text" size="40" value="" name="t5" id="email" class="input-text"></td>
                    </tr>
                    <tr>
                      <th>常用电话：</th>
                      <td>
                        <input type="text" size="40" value="" name="t2" id="tel" class="input-text"></td>
                    </tr>
                    <tr>
                      <th align="right" valign="middle">填写留言：</th>
                      <td>
                        <textarea name="t1" cols="40" rows="5" class="input-text" id="introduce" style='width:300px;height:70px;'></textarea>
                      </td>
                    </tr>
                    <tr>
                      <th></th>
                      <td>
                        <div style="">
                          <input id="dosubmit" type="button" value=" 提交 " name="dosubmit" class="bookadd">
                          <input type="reset" value=" 取消 "></div>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </form>
            </div>

<script language="javascript">
$(".gotobook").click(function(){
    $(".feedback_zx,.faq").hide()
    $("#bookform").fadeIn(100)
})

$(".bookadd").click(function(){

        $.ajax({
            cache: true,
            type: "POST",
            url: $("#bookforms").attr("action"),
            data:$("#bookforms").serialize(),
            async: false,
            error: function(request) {
                alert("提交信息时发生错误！");
            },
            success: function(data) {
		alert(data);
            }
        });

});
</script>


          </div>
        </div>
      </div>
    </div>
{sdcms:include("../../sdcms_foot.asp")}