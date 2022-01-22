<%if not in_sdcms then response.write("template load fail"):response.end() end if%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Keywords" content="{seokey}" />
<meta name="Description" content="{seodesc}" />
<title>{sdcms.iif(sdcms.strlen(seotitle)>0,seotitle,classname)}{if page>1}_第{page}页{/if}_{sdcms[webname]} - powered by sdcms</title>
<link href="{webroot}lib/css/base.css" rel="stylesheet" type="text/css" />
<link href="{webroot}theme/default/css/public.css" rel="stylesheet" type="text/css" />
<link href="{webroot}theme/default/css/artlist.css" rel="stylesheet" type="text/css" />
<link href="{webroot}theme/default/css/photolist.css" rel="stylesheet" type="text/css" />
<script>var webroot="{webroot}",murl="list.asp?classid={classid}";</script>
<script src="{webroot}lib/js/jquery.js"></script>
<script src="{webroot}lib/js/jquery-migrate-1.1.0.min.js"></script>
<script src="{webroot}lib/tips/jquery.tips.js"></script>
<script src="{webroot}lib/js/base.js"></script>
{if sdcms[sys_mobile]}<script src="{webroot}lib/js/mobile.js"></script>{/if}
<script src="{webroot}lib/validator/jquery.validator.js"></script>
<script src="{webroot}lib/validator/zh_CN.js"></script>
<script src="{webroot}theme/default/js/sdcms.js"></script>
</head>

<body>
    {sdcms:include("../../sdcms_head.asp")}
    
    <div id="position">您所在的位置：<a href="{webroot}">首页</a>{sdcms.getpostion(parentid," > ")}</div>
    <div class="w980 mt10 mc" id="container">
        <div class="left">
            {sdcms:rp table="sd_category" top="0" where="followid=[classid] and modeid>0" order="ordnum,cateid" var="sdcms_dim:sonid" auto="j"}
            <div class="b{if j>1} mt10{/if} w670">
                <div class="subject"><span><a href="{$rp[link]}">更多>></a></span>{$rp[catename]}</div>
                <div class="p10">
                     <ul class="phototop">
                    {sdcms:rs top="4" field="id,title,style,createdate,isurl,url,classid,pic,ispic" table="sd_content" where="islock=1 and classid in([sdcms_dim])" order="ontop desc,id desc"}
                        <li><a href="{$rs[link]}" title="{$rs[title]}"><img src="{if $rs[ispic]=1}{$rs[pic]}{else}{webroot}theme/default/images/nophoto.jpg{/if}" width="130" height="100"  alt="{$rs[title]}" /></a><div><a href="{$rs[link]}" title="{$rs[title]}">{sdcms.cutstr($rs[title],14,1)}</a></div></li>
                    {/sdcms:rs}
                    </ul>
                    <div class="c"></div>
                </div>
            </div>
            {/sdcms:rp}
        </div>
        <div class="right">
            <div class="b">
                <div class="subject">热门排行</div>
                <ul class="toplist">
                    {sdcms:rs top="10" field="id,title,style,createdate,isurl,url,classid" table="sd_content" where="islock=1 and classid in([sdcms.get_sonid(classid)])" order="hits desc,id desc"}
                    {rs:eof}<li>没有资料</li>{/rs:eof}
                    <li><a href="{$rs[link]}" title="{$rs[title]}"{if $rs[isurl]=1} target="_blank"{/if} {$rs[style]}>{sdcms.cutstr($rs[title],30,1)}</a></li>
                    {/sdcms:rs}
                </ul>
            </div>
            
            <div class="b mt10">
                <div class="subject">随机推荐</div>
                <ul class="toplist">
                    {sdcms:rs top="10" field="id,title,style,createdate,isurl,url,classid" table="sd_content" where="islock=1 and classid in([sdcms.get_sonid(classid)])" order="rnd"}
                    {rs:eof}<li>没有资料</li>{/rs:eof}
                    <li><a href="{$rs[link]}" title="{$rs[title]}"{if $rs[isurl]=1} target="_blank"{/if} {$rs[style]}>{sdcms.cutstr($rs[title],30,1)}</a></li>
                    {/sdcms:rs}   
                </ul>
            </div>
            
        </div>
    </div>
    {sdcms:include("../../sdcms_foot.asp")}