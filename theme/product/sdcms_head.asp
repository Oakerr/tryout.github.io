<%if not in_sdcms then response.write("template load fail"):response.end() end if%>{dim wdh:wdh="13966885166"            '''【网站电话】}
{dim wxl:wxl="#新浪"            '''【底部新浪微博链接】}
{dim wqq:wqq="771436657"            '''【QQ】}
{dim wxc:wxc="教育部院校代码：0344712"                     '''【头部宣传语】}
{dim wzb:wzb="116.404844,39.913385"          '''【地图坐标，百度一下（地图坐标拾取），找到您的坐标在这里填写】}

    <div class="header">
      <div class="innerwrap header_bg">
        <div class="soso">{sdcms:rs table="sd_category" top="0" where="followid = 41" order="ordnum,cateid" auto="k"}{if k<>1}|{/if}
          <a href="{$rs[link]}"{if $rs[modeid]=-2} target="_blank"{/if}>{$rs[catename]}</a>{/sdcms:rs}
          <form action="{webroot}plug/search.asp" method="get" target="_blank" class="mt15">
            <input type="submit" class="but">
            <input class="txt" type="text" name="key"></form>
        </div>
        <div class="pt34">{sdcms:rs top="1" field="fileurl,url,title" table="sd_expand_ad" where="islock=1 and classid=1" order="ordnum,id"}
          <a href="{webroot}">
            <img src="{$rs[fileurl]}" alt="{sdcms[webname]}" class="fl" /></a>{/sdcms:rs}
          <div class="fl ml38">
            <h1 class="header_wz">{wxc}</h1>
            <p class="header_tel">
              <img src="{webroot}upfile/header_tel.png" class="fl" />{wdh}</p></div>
        </div>
      </div>
    </div>
    <div class="nav">
      <ul class="nav_list">
        <li class="drop-menu-effect">
          <a href="{webroot}" class="selected2">
            <span>网站首页</span></a>
        </li>{sdcms:rs top="0" table="sd_category" where="followid=0 and ismenu=1" order="ordnum,cateid" var="sdcms_rp:cateid"}
        <li class="drop-menu-effect">
          <a href="{$rs[link]}" title="{$rs[catename]}"{if $rs[modeid]=-2} target="_blank"{/if}>
            <span>{$rs[catename]}</span></a>
          <ul class="submenu">{sdcms:rp top="0" table="sd_category" where="followid=[sdcms_rp] and ismenu=1" order="ordnum,cateid"}
            <li><a href="{$rp[link]}" title="{$rp[catename]}"{if $rp[modeid]=-2} target="_blank"{/if}>{$rp[catename]}</a></li>{/sdcms:rp}
          </ul>
        </li>{/sdcms:rs}
      </ul>
    </div>