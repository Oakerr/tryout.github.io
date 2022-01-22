<%if not in_sdcms then response.write("template load fail"):response.end() end if%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">{dim tindex:tindex=1}
  
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=gbk" />
    <meta http-equiv="X-UA-Compatible" content="IE=7" />
    <title>{sdcms[seotitle]}</title>
    <meta name="Keywords" content="{sdcms[seokey]}" />
    <meta name="Description" content="{sdcms[seodesc]}" />
    <meta name="author" content="{weburl}" />
    <meta name="copyright" content="{weburl}" />
    <link rel="canonical" href="{weburl}" /> 
    <script>var webroot="{webroot}";</script>
    {if sdcms[sys_mobile]}<script src="{webroot}lib/js/mobile.js"></script>{/if}
    <link href="{skins}/css/css.css" rel="stylesheet" type="text/css" />
    <script src="{skins}/js/jquery.1.7.2.min.js"></script>
    <link href="{skins}/css/dialog.css" rel="stylesheet" type="text/css" />
    <!--提示信息css-->
    <script type="text/javascript" src="{skins}/js/dialog.js"></script>
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
    <div class="innerwrap clear">
      <div class="banner">
    <link rel="stylesheet" href="{skins}/css/swiper.min.css">

    <style>
    .swiper-container {
        width: 763px;
        height: 429px;
        margin: 0px auto;
    }
    </style>
    <!-- Swiper -->
    <div class="swiper-container">
        <div class="swiper-wrapper">{sdcms:rs top="0" field="fileurl,url,title" table="sd_expand_ad" where="islock=1 and classid=2" order="ordnum,id"}
            <div class="swiper-slide"><a href="{$rs[url]}" target="_blank"><img src="{$rs[fileurl]}" alt="{$rs[title]}" width="763" height="429" /></a></div>{/sdcms:rs}
        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination"></div>
        <!-- Add Arrows -->
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
    </div>

    <!-- Swiper JS -->
    <script src="{skins}/js/swiper.min.js"></script>

    <!-- Initialize Swiper -->
    <script>
    var swiper = new Swiper('.swiper-container', {
        nextButton: '.swiper-button-next',
        prevButton: '.swiper-button-prev',
        pagination: '.swiper-pagination',
        spaceBetween: 30,
        centeredSlides: true,
        autoplay: 2500,
        //paginationType: 'progress',
        loop: true
    });
    </script>


      </div>
      <div class="ban_gg">{sdcms:rs top="3" field="fileurl,url,title" table="sd_expand_ad" where="islock=1 and classid=4" order="ordnum,id" auto="k"}
        <a href="{$rs[url]}" target="_blank">
          <img src="{$rs[fileurl]}" alt="{$rs[title]}"{if k<>3} class="mb26" {/if}/></a>{/sdcms:rs}
      </div>
    </div>
    <div class="innerwrap">
      <div class="news_gg mt26">
        <h2>
          <a href="{sdcms.getcateurl(6)}">
            <img src="{webroot}upfile/news_more.jpg" class="fr" style="padding-right:18px; padding-top:14px;" /></a>
	  {sdcms.getcatename(6)}</h2>
        <script src="{skins}/js/jquery.img_silder.js"></script>
        <script>$(function() {
            $('#silder').imgSilder({
              s_width: '100%',
              s_height: 254,
              is_showTit: true,
              // 是否显示图片标题 false :不显示，true :显示
              s_times: 3000,
              //设置滚动时间
            });
          });</script>
        <div class="news_gg_pic">
          <div class="silder" id="silder">
            <ul class="silder_list" id="silder_list">{sdcms:rs top="5" field="id,isurl,url,ispic,pic,title,style,classid,createdate" table="sd_content" where="classid in([sdcms.get_sonid(6)]) and islock=1 and ispic=1" order="ontop desc,createdate desc"}
              <li>
                <a href="{$rs[link]}">
                  <img src="{if $rs[ispic]=1}{$rs[pic]}{else}{skins}/images/nophoto.jpg{/if}" alt="{$rs[title]}" /></a>
              </li>{/sdcms:rs}
            </ul>
          </div>
        </div>
      </div>
      <div class="news_xy mt26">
        <h2>
          <a href="{sdcms.getcateurl(7)}">
            <img src="{webroot}upfile/more.jpg" class="fr" style="padding-top:14px;" /></a>{sdcms.getcatename(7)}</h2>
        <div class="news_xy_date">
          <ul>{sdcms:rs top="3" field="id,isurl,url,ispic,pic,title,style,classid,createdate,intro" table="sd_content" where="classid in([sdcms.get_sonid(7)]) and islock=1 and isnice=1" order="ontop desc,createdate desc"}
            <li>
              <div class="gs_news_date">
                <h1>{day($rs[createdate])}</h1>
                <h2>{year($rs[createdate])}-{month($rs[createdate])}</h2></div>
              <div class="gs_news_content">
                <h1>
                  <a href="{$rs[link]}" title="{$rs[title]}" {$rs[style]}>{sdcms.cutstr($rs[title],30,1)}</a></h1>
                <p>{sdcms.cutstr(sdcms.nohtml($rs[intro]),40,1)}</p>
              </div>
            </li>{/sdcms:rs}
          </ul>
        </div>
        <div class="news_xy_list">
          <ul>{sdcms:rs top="7" field="id,isurl,url,ispic,pic,title,style,classid,createdate" table="sd_content" where="classid in([sdcms.get_sonid(7)]) and islock=1 and isnice<>1" order="ontop desc,createdate desc"}
            <li>
              <span>{sdcms.getdate($rs[createdate],".",0)}</span>
              <a href="{$rs[link]}" title="{$rs[title]}" {$rs[style]}>{sdcms.cutstr($rs[title],30,1)}</a></li>{/sdcms:rs}
          </ul>
        </div>
      </div>
    </div>
    <div class="innerwrap">
      <div class="news_jy mt26">
        <div class="news_jy_bt">
          <a href="{sdcms.getcateurl(21)}">
            <img src="{webroot}upfile/news_more.jpg" class="fr" /></a>
          <span>{sdcms.getcatename(21)}</span></div>
        <div class="news_jy_jj">{sdcms:rs top="1" field="id,isurl,url,ispic,pic,title,style,classid,createdate,intro" table="sd_content" where="classid in([sdcms.get_sonid(21)]) and islock=1" order="ontop desc,createdate desc"}
          <p>
            <a href="{$rs[link]}" title="{$rs[title]}" {$rs[style]}>{sdcms.cutstr($rs[title],43,1)}</a></p>
          <span>{sdcms.cutstr(sdcms.nohtml($rs[intro]),90,1)}</span></div>{/sdcms:rs}
        <ul>{sdcms:rs top="5" field="id,isurl,url,ispic,pic,title,style,classid,createdate" table="sd_content" where="classid in([sdcms.get_sonid(21)]) and islock=1" order="ontop desc,createdate desc"}
          <li>
            <span>{sdcms.getdate($rs[createdate],".",1)}</span>
            <a href="{$rs[link]}" title="{$rs[title]}" {$rs[style]}>{sdcms.cutstr($rs[title],36,1)}</a></li>{/sdcms:rs}
        </ul>
      </div>
      <div class="news_pic_xs">
        <div class="news_pic_xs_bt">
          <a href="{sdcms.getcateurl(9)}">
            <img src="{webroot}upfile/more.jpg" class="fr" /></a>
          <span>{sdcms.getcatename(9)}</span></div>{sdcms:rs top="1" field="id,isurl,url,ispic,pic,title,style,classid,intro,createdate" table="sd_content" where="classid in([sdcms.get_sonid(9)]) and islock=1 and ispic=1" order="ontop desc,createdate desc"}
        <div class="news_pic_xs_tp">
          <a href="{$rs[link]}" title="{$rs[title]}">
            <img src="{if $rs[ispic]=1}{$rs[pic]}{else}{skins}/images/nophoto.jpg{/if}" alt="{$rs[title]}" />
            <p {$rs[style]}>{sdcms.cutstr($rs[title],30,1)}</p>
          </a>
          <span>发布时间：{sdcms.getdate($rs[createdate],".",1)}</span>
          <em>{sdcms.cutstr(sdcms.nohtml($rs[intro]),50,1)}</em></div>{/sdcms:rs}
        <div class="news_pic_list">
          <ul>{sdcms:rs top="4" field="id,isurl,url,ispic,pic,title,style,classid,createdate" table="sd_content" where="classid in([sdcms.get_sonid(9)]) and islock=1" order="ontop desc,createdate desc"}
            <li>
              <span>{sdcms.getdate($rs[createdate],".",0)}</span>
              <a href="{$rs[link]}" title="{$rs[title]}" {$rs[style]}>{sdcms.cutstr($rs[title],40,1)}</a></li>{/sdcms:rs}
          </ul>
        </div>
      </div>
      <div class="news_pic_xs_385">
        <div class="news_pic_xs_bt">
          <a href="{sdcms.getcateurl(37)}">
            <img src="{webroot}upfile/more.jpg" class="fr" /></a>
          <span>{sdcms.getcatename(37)}</span></div>{sdcms:rs top="1" field="id,isurl,url,ispic,pic,title,style,classid,intro,createdate" table="sd_content" where="classid in([sdcms.get_sonid(37)]) and islock=1 and ispic=1" order="ontop desc,createdate desc"}
        <div class="news_pic_xs_tp">
          <a href="{$rs[link]}" title="{$rs[title]}">
            <img src="{if $rs[ispic]=1}{$rs[pic]}{else}{skins}/images/nophoto.jpg{/if}" alt="{$rs[title]}" />
            <p {$rs[style]}>{sdcms.cutstr($rs[title],30,1)}</p>
          </a>
          <span>发布时间：{sdcms.getdate($rs[createdate],".",1)}</span>
          <em>{sdcms.cutstr(sdcms.nohtml($rs[intro]),50,1)}</em></div>{/sdcms:rs}
        <div class="news_pic_list">
          <ul>{sdcms:rs top="4" field="id,isurl,url,ispic,pic,title,style,classid,createdate" table="sd_content" where="classid in([sdcms.get_sonid(37)]) and islock=1" order="ontop desc,createdate desc"}
            <li>
              <span>{sdcms.getdate($rs[createdate],".",0)}</span>
              <a href="{$rs[link]}" title="{$rs[title]}" {$rs[style]}>{sdcms.cutstr($rs[title],40,1)}</a></li>{/sdcms:rs}
          </ul>
        </div>
      </div>
    </div>
    <div class="innerwrap">
      <div class="fri_link mt26">
	<div class="linktitle cl1">{sdcms:rs table="sd_category" top="0" where="cateid = 36" order="ordnum,cateid" }
        	<a href="{$rs[link]}">
		<h5>{$rs[catename]}</h5>
		<p>{asp Ucase($rs[catedir])}</p>
		</a>{/sdcms:rs}
	</div>
        <ul>{sdcms:rs top="3" field="id,isurl,url,ispic,pic,title,style,classid,createdate" table="sd_content" where="classid in([sdcms.get_sonid(36)]) and islock=1" order="ontop desc,createdate desc"}
          <li><a href="{$rs[link]}" title="{$rs[title]}">{sdcms.cutstr($rs[title],90,1)}</a></li>{/sdcms:rs}
          <li id="fri_link_last">
            <a href="{sdcms.getcateurl(35)}">更多</a></li>
        </ul>
      </div>
      <div class="fri_link_t mt26 ml52">
	<div class="linktitle cl2">{sdcms:rs table="sd_category" top="0" where="cateid = 3" order="ordnum,cateid" }
        	<a href="{$rs[link]}">
		<h5>{$rs[catename]}</h5>
		<p>{asp Ucase($rs[catedir])}</p>
		</a>{/sdcms:rs}
	</div>
        <ul>{sdcms:rs table="sd_category" top="6" where="followid = 4" order="ordnum,cateid" }
          <li><a href="{$rs[link]}">{$rs[catename]}</a></li>{/sdcms:rs}
        </ul>
        <div id="moren">
          <a href="{sdcms.getcateurl(3)}">更多</a></div>
      </div>
      <div class="fri_link_t mt26 ml52">
	<div class="linktitle cl3">{sdcms:rs table="sd_category" top="0" where="cateid = 21" order="ordnum,cateid" }
        	<a href="{$rs[link]}">
		<h5>{$rs[catename]}</h5>
		<p>{asp Ucase($rs[catedir])}</p>
		</a>{/sdcms:rs}
	</div>
        <ul>{sdcms:rs table="sd_category" top="6" where="followid = 21" order="ordnum,cateid" }
          <li><a href="{$rs[link]}">{$rs[catename]}</a></li>{/sdcms:rs}
        </ul>
        <div id="moren">
          <a href="{sdcms.getcateurl(21)}">更多</a></div>
      </div>
      <div class="fri_link_t mt26 ml52">
	<div class="linktitle cl4">{sdcms:rs table="sd_category" top="0" where="cateid = 29" order="ordnum,cateid" }
        	<a href="{$rs[link]}">
		<h5>{$rs[catename]}</h5>
		<p>{asp Ucase($rs[catedir])}</p>
		</a>{/sdcms:rs}
	</div>
        <ul>{sdcms:rs table="sd_category" top="6" where="followid = 29" order="ordnum,cateid" }
          <li><a href="{$rs[link]}">{$rs[catename]}</a></li>{/sdcms:rs}
        </ul>
        <div id="moren">
          <a href="{sdcms.getcateurl(29)}" target="_blank">更多</a></div>
      </div>
    </div>
    <div class="innerwrap">
      <div class="friend_link_content">
        <p>合作伙伴</p>
        <script type="text/javascript" src="{skins}/js/mf_roll.js"></script>
        <div id="DivGoodsCommend" style="overflow: hidden; width: 1158px; height:70px; margin-top:20px;">
          <ul style="width:1345px;">{sdcms:rs top="0" table="sd_expand_link" where="islock=1 and islogo=1 and classid=6" order="id desc"}
            <li>
              <a title="{$rs[webname]}" href="{$rs[weburl]}" target="_blank">
                <img src="{$rs[weblogo]}" alt="{$rs[webname]}" width="127" height="56"></a>
            </li>{/sdcms:rs}
          </ul>
        </div>
        <script>new Marquee("DivGoodsCommend", 2, 2, 1158, 60, 20, 0, 0, 32)</script></div>
    </div>
{sdcms:include("sdcms_foot.asp")}