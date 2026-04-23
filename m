Return-Path: <linux-aspeed+bounces-3954-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECA9FDEE28
	for <linux-aspeed@archiver.kernel.org>; Fri, 24 Apr 2026 01:02:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1vny3BTkz2ybQ;
	Fri, 24 Apr 2026 11:02:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::22d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776970837;
	cv=pass; b=Uenh9DSFQLv5zYpJKqEmC2ZgEAztZRFQQSEwtyDgCgYJRzvg/OzIqcBRVXmCJebBVm1doZFIUsPwmi7OwMpyIyYtUAnn7fgQAO8B09urPUWAqFPD77DtCjIEWC8dQw7+NGnMC+bXmAo1/9xYyCL82/VrJ3wUGXrqZlW0gfwjM4UiYH74rVAsKaKUWtzyPuRBym2atTv01Xs0+Etgfv3kEtYMdtSCoymXd71UrICBHirBRgdIwAuZZIYiFeXN26plhpu9CgohSUPqPLlr9umRieXHGxXFU8Lcs7BhPPpXK57wwnmZqGDb6BokJosL7ad9Ob4EMVsxpWcE9FtF5yHKzA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776970837; c=relaxed/relaxed;
	bh=iaSZGDSTIt1t0vqnrwKkzM3vMPJqVoykTgkWKgeHifU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=OUbOMVAnGJWSq/4HxrDsQC3OMunYR4fYL3TSGv4gymSQBehwWHWsZXTY9qdk0/O2NPD/ad8WF5WqulQQg+VcHtZecRYgV424O5wsNTKVoTbvrDHLQulwSVqArChhsrTHB56yGthftUvtCFuYwGSQ6BI3J4anUsmANyIphVsv1KzWFsDiB96UGeMqXkuezG00Bt8j3luNpxeGEkENlxClJ8ZbZQf5XzxQZ+hYb4CnUFi+yRPBMMbchyY/vRQPVag88dunLCQmJRp+zipozkTDyMOmPsfDwewq2z0Hie5YagrOZmasYWhgqXMW+8tepA2fJnT7k1mneL6ddePiDzYyog==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZKeimGo0; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZKeimGo0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22d; helo=mail-lj1-x22d.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1lm40Xnlz2xSB
	for <linux-aspeed@lists.ozlabs.org>; Fri, 24 Apr 2026 05:00:35 +1000 (AEST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-38e7d983f50so78937591fa.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Apr 2026 12:00:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776970828; cv=none;
        d=google.com; s=arc-20240605;
        b=XiwpZp6JjiqzQrn8G9MOSBCF1OQWqxzfQ7RNCcvTJGL/kitJHRRhr24uubntzOJSoc
         LIl5odRLS7OIf7ExenQzcctdvzDJswBpMCFv0KeNP5eH4H/Y45yJBkTYM4QqF++6mw+j
         YUzXnN7Ts1FFy4AiV3EjWvYHMo/0U7gtSutqVf0fHVlg+AU3Vn0q41vKht71qHtf0Qbi
         2e7r0U1qltHWy+wpOagMB+RSJWV0LcKSupEXVtFs3exI4EQ4eHUTKXr4QQG8oTFblmZn
         YcR3aL9A31WWIqxgzi0kmMBY8zQLmL7WD+eM31xJRNbTI3d5JyYrNBIyv9OtJ/lo3Hus
         vyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=iaSZGDSTIt1t0vqnrwKkzM3vMPJqVoykTgkWKgeHifU=;
        fh=OfYKBNJpNTfJ7uHCjlUb3MEzh/4PPOOIoyT6ItS5CWA=;
        b=RgqfBeTci9J+8mVsDmKQl/2cCaOI6m4lNf/nNA0udLGoWZy2GuVgXSOUPRwWekJo2j
         U2Bqx6168b0Lfu87l1bbtaRFG3zTrT5EFmKhMTm5mbsJ9QaXzlBBLAaWQW5HBs8c7aYg
         qi011DK2OwkUHhzuMoOcIXw8oj2I4k1z6pknJMHTB3/RInimtP//BisE/fap2/zZmlhG
         bpgR5YNbtqRkfb1Tyq0byN//wvL9uarkEKbfzrj9eDOt0DNLLOcBlAydWNm04EYy5pi1
         JE7gpuVhJPMcWuaPj+UbtECdq0mzUaozLm4MKbXwFP5cCuX/eUT+cmuXI3i53n+aJ4O+
         gMbg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776970828; x=1777575628; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iaSZGDSTIt1t0vqnrwKkzM3vMPJqVoykTgkWKgeHifU=;
        b=ZKeimGo0NpsM0LNtu6JhXoJ5+nWjIiTnTARuN2KAz0cspnVNNUxBPaJJ+tZ6RhGQz+
         O97GFm41VSCzeA7l1rE/VFlG6d2ttbBX6vLTGXJKk1d9q1rND57oa19BoIHG2RF74rIV
         quYVKxlQBYTPhTyIWYUJO+G9N/ypNCvu9gyJob0OHgM0BSBq5HG0B377zODC0SK5+0bY
         r2Uu2p+yizp3NvYza2OQFu44V79YuxITW1kP1lfvPhGrto2ZONzkjRhuS/TRD9tqceTf
         hkGiaM0XDjGnQiWqPTDsbPxDmigjyxcm5lqvBO6Y0VH30RQiSBhTM3+zLS/X+NEsXceg
         9izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776970828; x=1777575628;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iaSZGDSTIt1t0vqnrwKkzM3vMPJqVoykTgkWKgeHifU=;
        b=rrMB2vPI/6P+nzAEqyrtn35J+CdiKp6vnW0pgY2y+eBBV8I0CGbq6IBA6pNsA6EzUZ
         DBqiO905f3U6OSuB7/aPNVUVHZnjP8mrtJMLZitG07BdOpwg+SmzdXz/SxfYqOfVXPgF
         69B3ijjDKW0wbg7EYcIArKQEzwBTReP97qtqLqmP8bS2pDYR24FBw1XL2pghBsNgIxsr
         c28RFt7g+n0WCocRvWQ/JJGiqxyS1UYI4n7aQeH2KBCa5Kir2tfpmiQquVPrlYip4mZU
         Qpvn4zqMxl0WyrxLKso4uxVlY7xbtkJjECLe9PbjzuCEwfQRvjqyb0+xkfAlUpDfscIl
         EcDA==
X-Forwarded-Encrypted: i=1; AFNElJ9pocYmEqRQNrsMOxasq+tj0DQKsGi05M3ZmFjEjZ75N83OJkbkXeHy6WhYpygRyKW+fNhypVA/j+xgGtk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzO2DEtTqlQ7+tDK4wY7CsWM99kuy8BbzRTJ34K2bSgLfxk/51T
	OFQ+VOxeILUQBAPgLYMmQaGJAaxfbJjEf9xrz4YFkN418mmRhiUniyerYvNkuk2np8YYX9EXMdI
	eeyXYuTwKAoXh+xXzlS7uiJT4cX1b4IE=
X-Gm-Gg: AeBDietCK3o3TDSQLfk49jwZQo4BqdM8Ui2b2cjYkvuzu8ZnSYmwZSRq1hgzShezoEa
	ZYRb8QD3WX1lExuG9Zlai8kfyoDUJFVUQRLWMj7sbGArVzMUZVMBt3fV8HWDhOYEYA3DeNgLhG6
	SRk2x8Rr6v4spznuQutQxF5UVEkQVTjM8kU8aQ+4xK3vI3jFkxgh87WSYYOy5raW6vjEcDuX01B
	rJK7C/5pmg9wTvpV++yluTs+KFrs5ExKJ3mTwtrtFqKwQf7ZIG3S630i9rS9hY/tiWfQ643EctT
	EuBZOv+ibZs2hogBy0peNy9poWEPxe8Rw620pTHV5cpb/SrwvQ==
X-Received: by 2002:a05:6512:3b8d:b0:5a4:19f3:f2bf with SMTP id
 2adb3069b0e04-5a419f3f386mr8816464e87.24.1776970827228; Thu, 23 Apr 2026
 12:00:27 -0700 (PDT)
X-Mailing-List: linux-aspeed@lists.ozlabs.org
List-Id: <linux-aspeed.lists.ozlabs.org>
List-Help: <mailto:linux-aspeed+help@lists.ozlabs.org>
List-Owner: <mailto:linux-aspeed+owner@lists.ozlabs.org>
List-Post: <mailto:linux-aspeed@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linux-aspeed/>,
  <https://lists.ozlabs.org/pipermail/linux-aspeed/>
List-Subscribe: <mailto:linux-aspeed+subscribe@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-aspeed+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-aspeed+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
From: karthikeyan K S <karthiproffesional@gmail.com>
Date: Fri, 24 Apr 2026 00:30:11 +0530
X-Gm-Features: AQROBzAACTNKgczWUdLDKoK0N8p6t9ZSbvUCg1HXPCRwXkUzT9c4U3H7ST8sp-U
Message-ID: <CAP_JKPter_ggMMvUY=pDZyZupSQb5KWGVPeig41Uw2wBDXepMg@mail.gmail.com>
Subject: [PATCH] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
To: joel@jms.id.au, andrew@codeconstruct.com.au
Cc: jdelvare@suse.de, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000eee9cc06502542fe"

--000000000000eee9cc06502542fe
Content-Type: text/plain; charset="UTF-8"

From c50ff07baf2032ca12133775c61c50a38e8a2029 Mon Sep 17 00:00:00 2001
From: Karthikeyan KS <karthiproffesional@gmail.com>
Date: Thu, 23 Apr 2026 21:26:08 +0300
Subject: [PATCH] soc: aspeed: lpc-snoop: Fix usercopy overflow in
 snoop_file_read

snoop_file_read() passes the userspace count directly to
kfifo_to_user() without clamping. The kfifo backing buffer is
2048 bytes (SNOOP_FIFO_SIZE), allocated from kmalloc-2k slab.
A read larger than 2048 bytes triggers a BUG under
CONFIG_HARDENED_USERCOPY:

  kernel BUG at mm/usercopy.c:99!

Reproducer:
  hexdump /dev/aspeed-lpc-snoop0

Fix by clamping count to SNOOP_FIFO_SIZE before the copy.

Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc
chardev")
Cc: stable@vger.kernel.org
Signed-off-by: Karthikeyan KS <karthiproffesional@gmail.com>
---
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
b/drivers/soc/aspeed/aspeed-lpc-snoop.c
index b03310c0830d..5b59e826cc68 100644
--- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
@@ -125,6 +125,7 @@ static ssize_t snoop_file_read(struct file *file, char
__user *buffer,
        if (ret == -ERESTARTSYS)
            return -EINTR;
    }
+   count = min(count, (size_t)SNOOP_FIFO_SIZE);
    ret = kfifo_to_user(&chan->fifo, buffer, count, &copied);
    if (ret)
        return ret;
-- 
2.34.1

--000000000000eee9cc06502542fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"margin:0px;min-width:0px;pa=
dding:0px 0px 20px;width:auto;font-family:&quot;Google Sans&quot;,Roboto,Ro=
botoDraft,Helvetica,Arial,sans-serif;font-size:medium"><div><div id=3D"m_-6=
80033585644009664gmail-:ou" style=3D"direction:ltr;margin:8px 0px 0px;paddi=
ng:0px;font-size:0.875rem;overflow-x:hidden"><div id=3D"m_-6800335856440096=
64gmail-:pb" style=3D"direction:ltr;font-style:normal;font-variant:normal;f=
ont-size-adjust:none;font-kerning:auto;font-feature-settings:normal;font-st=
retch:normal;font-size:small;line-height:1.5;font-family:Arial,Helvetica,sa=
ns-serif;overflow:auto hidden"><div id=3D"m_-680033585644009664gmail-avWBGd=
-83"><div dir=3D"ltr"><div style=3D"color:rgb(187,190,191);background-color=
:rgb(18,19,20);font-family:Consolas,&quot;Courier New&quot;,monospace;font-=
size:14px;line-height:19px;white-space:pre-wrap"><div>From c50ff07baf2032ca=
12133775c61c50a38e8a2029 Mon Sep 17 00:00:00 2001</div><div>From: Karthikey=
an KS &lt;<a href=3D"mailto:karthiproffesional@gmail.com" target=3D"_blank"=
>karthiproffesional@gmail.com</a>&gt;</div><div>Date: Thu, 23 Apr 2026 21:2=
6:08 +0300</div><div>Subject: [PATCH] soc: aspeed: lpc-snoop: Fix usercopy =
overflow in</div><div>=C2=A0snoop_file_read</div><br><div>snoop_file_read()=
 passes the userspace count directly to</div><div>kfifo_to_user() without c=
lamping. The kfifo backing buffer is</div><div>2048 bytes (SNOOP_FIFO_SIZE)=
, allocated from kmalloc-2k slab.</div><div>A read larger than 2048 bytes t=
riggers a BUG under</div><div>CONFIG_HARDENED_USERCOPY:</div><br><div>=C2=
=A0 kernel BUG at mm/usercopy.c:99!</div><br><div>Reproducer:</div><div>=C2=
=A0 hexdump /dev/aspeed-lpc-snoop0</div><br><div>Fix by clamping count to S=
NOOP_FIFO_SIZE before the copy.</div><br><div>Fixes: 3772e5da4454 (&quot;dr=
ivers/misc: Aspeed LPC snoop output using misc chardev&quot;)</div><div>Cc:=
 <a href=3D"mailto:stable@vger.kernel.org" target=3D"_blank">stable@vger.ke=
rnel.org</a></div><div>Signed-off-by: Karthikeyan KS &lt;<a href=3D"mailto:=
karthiproffesional@gmail.com" target=3D"_blank">karthiproffesional@gmail.co=
m</a>&gt;</div><div><span style=3D"color:rgb(121,192,255);font-weight:bold"=
>---</span></div><div>=C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 1 +</di=
v><div>=C2=A01 file changed, 1 insertion(+)</div><br><div><span style=3D"co=
lor:rgb(121,192,255)">diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/=
drivers/soc/aspeed/aspeed-lpc-snoop.c</span></div><div>index b03310c0830d..=
5b59e826cc68 100644</div><div><span style=3D"color:rgb(255,161,152)">--- a/=
drivers/soc/aspeed/aspeed-lpc-snoop.c</span></div><div><span style=3D"color=
:rgb(126,231,135)">+++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c</span></div>=
<div><span style=3D"color:rgb(210,168,255);font-weight:bold">@@ -125,6 +125=
,7 @@</span> static ssize_t snoop_file_read(struct file *file, char __user =
*buffer,</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret =3D=3D -ERESTARTSYS)=
</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINTR;</div><d=
iv>=C2=A0 =C2=A0 }</div><div><span style=3D"color:rgb(126,231,135)">+ =C2=
=A0 count =3D min(count, (size_t)SNOOP_FIFO_SIZE);</span></div><div>=C2=A0 =
=C2=A0 ret =3D kfifo_to_user(&amp;chan-&gt;fifo, buffer, count, &amp;copied=
);</div><div>=C2=A0 =C2=A0 if (ret)</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 r=
eturn ret;</div><div><span style=3D"color:rgb(255,161,152)">-- </span></div=
><div>2.34.1</div><div></div><div><br><br></div></div></div><div></div></di=
v></div></div><div id=3D"m_-680033585644009664gmail-avWBGd-84" style=3D"cle=
ar:both"></div></div></div><br></div>
</div>

--000000000000eee9cc06502542fe--

