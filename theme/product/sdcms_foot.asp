<%if not in_sdcms then response.write("template load fail"):response.end() end if%>    <div class="foot">
      <div class="innerwrap foot_contact">
        <div class="footer-bot">
          <a class="wechat zoom" title="扫描二维码关注我们" href="#wx" target="_blank" rel="nofollow">{sdcms:rs top="1" field="fileurl,url,title" table="sd_expand_ad" where="islock=1 and classid=5" order="ordnum,id"}<img class="wxewm" src="{$rs[fileurl]}" alt="{$rs[title]}" width="150" height="150" />{/sdcms:rs}</a>
        </div>{sdcms:rs top="1" field="fileurl,url,title" table="sd_expand_ad" where="islock=1 and classid=3" order="ordnum,id"}
        <img src="{$rs[fileurl]}" alt="{$rs[title]}" class="fl" />{/sdcms:rs}
{sdcms:block("db")}</div>
      <div class="innerwrap copy">{if sdcms[webicp]<>""}
        <span class="fr">
          <a href="http://www.miitbeian.gov.cn/" target="_blank" rel="nofollow">{sdcms[webicp]}</a></span>{/if}
	  {sdcms:block("bq")}{sdcms[webcount]}{if tindex=1}<p>{sdcms:rs top="0" table="sd_expand_link" where="islock=1 and islogo=0" order="id desc" auto="k"}{if k=1}友情链接：{/if}
<a href="{$rs[weburl]}" target="_blank">{sdcms.cutstr($rs[webname],20,0)}</a> | 
{/sdcms:rs}</p>{/if}
      </div>
    </div>
  </body>

</html>