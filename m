Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718CD606A31E
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Nov 2026 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WT1mmyjh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY0zS4lpdz2y7p;
	Mon, 23 Nov 2026 20:30:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b131" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795426228;
	cv=pass; b=Y053n+8Svpyuqww6DOyr3sUU+R5lweV4md9qJPh4MHBgJPZfuS9Z9qOLr6TsibFX+pHAzN2uWFqF2xXg39iBScO4/rwGA6L9fRc2Bk7rd4SjAPDcLGoFhsIFaGfhVK1KQY2de2JDr5ifqkeFyVBJJCci3tE2M4os49lZhcOCiwcYToiI9oDOCTdPRnABR4N4k3oSVYpBixDusaCVKQrbs8mfbu+H9zs1PjTTwkX1hp0mVxXXImOgtzg0e3VKV0TYG21Jm+yB9U2836mhNE8WD/Of8TWliUmGl89e+UUQfLtkOh2SsJleDa9BHJG4KInEwWvxB17h0YFIkybhhnbqkQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795426228; c=relaxed/relaxed;
	bh=TfuZUX8mfvP1wlJZ5oBsp8JU8zB5VTHYrC1NJB4pEqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ke1uNKglD1jN+5V58P4wcyG6EjdbuqyG7fKemvqZa2LL6tvJ/e83/1V/JnyhekArD3Z/sX75sKNn4R6n0OF4SFU8NlOgvm2L/NJekywMyybZeX3e0wCI4R10bbQOYe3haSWJ5fFmYQXYmsu6IxPuUzbaONat/uDP+5b0BmaiqMh6PZsTfaCXXwkcsQzam9n3hzlDR5GqfN7k+q6+NLTXu3idURJScBU61fNRfCPI+431oLz5IlJUTyPlbKOKBL40n0GF/KyYjwemvEAC33zTYHBkQe822Tb02MQDmSQD8QLEiL2NvgEbPJtO8oVlKwGKLqKt1ErIyZWS668e362JYg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WT1mmyjh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WT1mmyjh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com [IPv6:2607:f8b0:4864:20::b131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY0zR21yQz2xyj
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Nov 2026 20:30:26 +1100 (AEDT)
Received: by mail-yx1-xb131.google.com with SMTP id 956f58d0204a3-67db1f6f50eso3025230d50.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Nov 2026 01:30:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795426222; cv=none;
        d=google.com; s=arc-20260327;
        b=lMgWAYkeCSFvVdIa0Um82DzSj39AzZSFyhKSB//mIychFmiD6YiHd4Mr6Nrg0Uueow
         AiXyRzb8InllL++pnBsuGKTACn5T2OIla7/dpCOCGaIxA8YYr+H4mxARaSROHOAJkFu1
         9JAsP71qkkBjeg7ISjGotXIw8Z8q5tX2rHI4HDRhO7ZW4VbxtZKHrPOV6p6+3kFmkwOF
         6nxSRzoUdd1b7dtyxtTjZCqmk2bMcLtql34spyehZsJc5WICY3loah/PyvxD14/OAzUn
         +5nGmxNCo/NZmf+ZAXFS0cHXVjhtPPS2d74dkkrmHVt7jOp2ida786vTqM1ENT0vQLA8
         pgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TfuZUX8mfvP1wlJZ5oBsp8JU8zB5VTHYrC1NJB4pEqA=;
        fh=4Gl06Yu1PxFYrHU3eRS2zEhlhvwiMlGhJ96N/AuCu5k=;
        b=borffQ9vf/UHunDNXhRysz/oQ/FCSUOm9HTGE4Mz6/k53qdCN17agqcssBdGtgdA+w
         jHJOR5vnlaQmqHQtCckon7AiojWPplPh0IpzaHcYjWdM4/q2jaZ26fWu0ckjQ8xBUu2K
         QsXsN9vMaJXgQZFI7KpNihCnU+eBXjggEhNRKx++JecP3gaRNkVOg0MaZAsnrlp34936
         /Q+S5XUkY7lyiVWrSKG6k1ZiTwOS+jjpRcfdHCH9A8TZG0rJvewzumICuT1J6+7S2LP4
         iJjlQ68920+z3KKGrmuzksAEK7Yanh5xNDH1GO0v6yfJoqagC22H8nLYyrgMxQNWHPNn
         S1Ag==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795426222; x=1796031022; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TfuZUX8mfvP1wlJZ5oBsp8JU8zB5VTHYrC1NJB4pEqA=;
        b=WT1mmyjhinlJDMCqgcCfD5UxpprdJ9CAnxP/3JPBPnDYudw/xhQKICoFGXlWykf0Ek
         NZIR/clUKbOgXsbVlQP/tqyBhjme37iJsaV5D8ZrBZbtznEC68e7g3iyNgcrlbeQzSfv
         GueAVAefQZRoQTxT0SyNqln/7Kltxv+oOK4S1CV8Hwufvrz4Fn9Wi8vb6cuvpqcmX+IX
         a2nLGMZvSKmodjXLwTc2YJLwpPmw3HzpfySVPWC/eU/bOOJ9OKUm4h6Pdcq/BpWM8e67
         qmLtEMmGxVsZNnGn86U0jL4R0bYXdlgIrWdLyjQ8YxWlBZJ59tEFto54RSPXLoXhadGb
         4Kzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795426222; x=1796031022;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TfuZUX8mfvP1wlJZ5oBsp8JU8zB5VTHYrC1NJB4pEqA=;
        b=u5n2YwNO/RZqqZXLAoY5t5LSQUfR6lmWzac23aFrimMDaDZLtCKfgxiA0imXq4+RJW
         KxI/qaFeKYJg94g0cqmc+83OR9vsmDPT+dZMS/ZMKNYA+2YgDUsHV39XaAMni2X4JpZa
         f2OlLam64XN5iEMYu77f88G19BSxJ7nQut/cCFlnVlKRHqf0bP+ptsS7/ifJlIi4hncc
         +030DhQODe15qrcq0TtZBwMRfn4yF5ytmspEAQemoda3LAGuoYSuucNZDk1MgLUsGhML
         cyViMYwbbCMuhmiW+SVoRLatTwQRX7WlBohDy8U+aPBjYs+GtpdXqzJg2DfF6GKLNb3O
         v4sQ==
X-Forwarded-Encrypted: i=1; AL+hErEY8PKM6fuGCvHneYHJDZ/5EhpTHDJ0aMN1qGuWV9lXbBwCk9abPiUPzP8hOQz5v6cZyNwUgXiJyKohPJY=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z9KSsUIimYciLurOPc7w0rY8IRR7YpUnAASNMmU+tilUfmj10ep
	7m97OC5a7RsXy3QUVReYjbA0BYJbImlxmjWqqBJ+41ySp5vt146LQ7bam4q34NW41yhGby2Yu2I
	oyCJW9iyp96TN2uL4FRYLdvJIOUqBTyg=
X-Gm-Gg: AZFdTZeQeyopRRcpfRyfMVLPzDdCHeCMGdK0mmNVTn/KTvrmi1J0juv7JbnDxd/VR2n
	wvlE0X4ukcgOA1bjcyznH/Jv3NHEoeDEaxdLmAZZw4aXnH1QNiWfeBYcHLiNhAfhYy92EVmbuwa
	TesG6Gx4UvN8KRd85Vmf5K2IAV0yOFlMl46R+uCkxQWpjVz+wJSeNHnN039rhHl8A8Qe/2EwzpD
	Z6RWVpAbxwsPECxYpdwMGjXvB6/2TpLUeQDCJDiEJNq4Y3CZ5wytr7ColZsrYRmOEk5RXVUL+pt
	M9Asb5NkSTIQiqjrOaHTADEny3r9qr+XgM058HGpJWjFAkPDv5gj9XFn3r+3pXSIZJ+pHeYbJqa
	ZzH/TQHf8DVuqpxsZ1dnrcv4aK0K2uxxEj4WmmdV5S93X9LQzJRvTd5P0e48=
X-Received: by 2002:a05:690e:bcc:b0:675:3f33:b183 with SMTP id
 956f58d0204a3-67df43ce1bamr4794506d50.24.1795426222603; Mon, 23 Nov 2026
 01:30:22 -0800 (PST)
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261121034053.39878-1-prasanth.padarthi10@gmail.com>
 <20261121034053.39878-3-prasanth.padarthi10@gmail.com> <awQDxB-09pHSgfJ_@monoceros>
In-Reply-To: <awQDxB-09pHSgfJ_@monoceros>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Mon, 23 Nov 2026 15:00:10 +0530
X-Gm-Features: Aa3M54p2Tg3Xn3_mGIg8UrqjUBdm1BTWQzb3Jw475KREmNKAwgQOwvk1PFUKFkE
Message-ID: <CAMFFDGiW5PAxd509=v6fLpXR4mzr+PJUD5JGN1iYgBB4hT_H8A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] nvmem: aspeed: Add read-only AST2600 OTP support
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: srini@kernel.org, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Neal Liu <neal_liu@aspeedtech.com>, 
	Tan Siewert <tan.siewert@9elements.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="0000000000003800e80660ee3ea5"
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000003800e80660ee3ea5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks, Uwe. I=E2=80=99ll drop the linux/mod_devicetable.h include in the n=
ext
revision.

On Mon, 23 Nov, 2026, 2:45=E2=80=AFpm Uwe Kleine-K=C3=B6nig, <
u.kleine-koenig@baylibre.com> wrote:

> Hello,
>
> On Sat, Nov 21, 2026 at 09:10:53AM +0530, Prasanth Kumar Padarthi wrote:
> > +#include <linux/bitfield.h>
> > +#include <linux/cleanup.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/nvmem-provider.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/unaligned.h>
>
> <linux/platform_device.h> already provides of_device_id without all the
> dependencies that are implied by using <linux/mod_devicetable.h>. So
> please drop the latter.
>
> Best regards
> Uwe
>

--0000000000003800e80660ee3ea5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thanks, Uwe. I=E2=80=99ll drop the linux/mod_devicetable.=
h include in the next revision.</div><br><div class=3D"gmail_quote gmail_qu=
ote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 23 Nov, 2026, =
2:45=E2=80=AFpm Uwe Kleine-K=C3=B6nig, &lt;<a href=3D"mailto:u.kleine-koeni=
g@baylibre.com">u.kleine-koenig@baylibre.com</a>&gt; wrote:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">Hello,<br>
<br>
On Sat, Nov 21, 2026 at 09:10:53AM +0530, Prasanth Kumar Padarthi wrote:<br=
>
&gt; +#include &lt;linux/bitfield.h&gt;<br>
&gt; +#include &lt;linux/cleanup.h&gt;<br>
&gt; +#include &lt;linux/io.h&gt;<br>
&gt; +#include &lt;linux/iopoll.h&gt;<br>
&gt; +#include &lt;linux/mod_devicetable.h&gt;<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/mutex.h&gt;<br>
&gt; +#include &lt;linux/nvmem-provider.h&gt;<br>
&gt; +#include &lt;linux/platform_device.h&gt;<br>
&gt; +#include &lt;linux/unaligned.h&gt;<br>
<br>
&lt;linux/platform_device.h&gt; already provides of_device_id without all t=
he<br>
dependencies that are implied by using &lt;linux/mod_devicetable.h&gt;. So<=
br>
please drop the latter.<br>
<br>
Best regards<br>
Uwe<br>
</blockquote></div>

--0000000000003800e80660ee3ea5--

