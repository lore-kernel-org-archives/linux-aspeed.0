Return-Path: <linux-aspeed+bounces-1625-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0CFC83F03
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Jul 2025 23:43:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYCyM51fzz2yFQ;
	Fri,  4 Jul 2025 09:43:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::835"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751535884;
	cv=none; b=fkNgRjuJ7o/HtNv3rvPJFhbRJdfL7I4AXynIAsaecUMxOSoGvFbZHEQf2X0mO825lyema1BMDN6EgcpwHlOx22Ng2U659+xFiqqAIzubbei289cNC2igIdzKLTk0bvM0yiBmJxZVBzTr8KNI4m+dP7eye1ISFNw4JvycYejZLjyUDb9KXuaaCTiT6f5Cge2w7TX/naS8Ms4ZmVjW0R6ms2wlIlCdI3X0yO8Iy5yEHTvaAjOyUPlK4D2h94qwgzHeyqP3vosYUMbrp1rse2bmUoxQOk7eZ/s6OfLEVDVMmz9V7HRuG47THwzgWrCmKD9yoqq5fplEDqxUSCY00QDe7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751535884; c=relaxed/relaxed;
	bh=fHEiEmJCzizMk14+0qI4uUl6IlGuTzoGNKvo59baf48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrflvrGVWbocoLZj0zekh8oyg0asYn2FnD3w1WoURyxso24RPcMSzdm5U8P19EOWXwEwYsFwnJpzTg7J5CslfMGJKkxqm55TJpNaWq83huSU+FHE/Fmw8J6p8SaUdWz6e7LHHC4t+9xKgCCB05Y8ZkpNFLKCOKBbTjpubnzJ4C0V+QwgQp7aj2skdDOu2XsECjgL4ZReP9iGfnb8msqM0bG0ccwEXjK2uAxTfVy7rERsF9WWOyeaiPctVD1Ba3GAquBfeou2HRlEYLWcFWZMPrgWZM9NVqRqcUaczWxxsULQFWZg/oqo70X8z1QYAqsOHApMMr5M09m+9m6F/8iz1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mk+TQ7kz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mk+TQ7kz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::835; helo=mail-qt1-x835.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bXsLM1LPCz2xgp
	for <linux-aspeed@lists.ozlabs.org>; Thu,  3 Jul 2025 19:44:42 +1000 (AEST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4a44b9b2af8so29997441cf.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 03 Jul 2025 02:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751535880; x=1752140680; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fHEiEmJCzizMk14+0qI4uUl6IlGuTzoGNKvo59baf48=;
        b=mk+TQ7kzSaOyGGLf7psDK2rwkdy4PgQkjtzWt5eS6v28lDwfKVntBd6x8zZ+w0lxrO
         U6ydEd/AT0G5iM+8nFxzHo3b5CK0tUC6WC78516y847giTKMsWr5djGto69DMZhrsB9+
         kR4wTPzkudcFPE+r8jhm92+MEvQvFY4m5LnMs5sc+q9Z4jO3gM3K/GF4mn2ErPbD+NIr
         Jcwsn5egBQX6J4uQ782HdPK+GdJJVjqFuMGloDlx2v1MziEmUex1auEJtjxOycPGriLA
         BgPaFpwwgxNwo7Q/jm97zohHU0GmzBx/DFfwGlqrtYsQ5rmEyOiVuCoP0OuP88C+FsAL
         ySPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751535880; x=1752140680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fHEiEmJCzizMk14+0qI4uUl6IlGuTzoGNKvo59baf48=;
        b=GdZY1BHcdWA+iZ4yk2lUzkCMpUOSlE4Jbw2gH8xhDrYqP2T540rSvdcsbycr0nYsKz
         tUrE5c4M1Th4Y5vvMqeln9w17qAG+XkqIzAWoAZ76+aiPkP1QyHiRTTZDoe/vm8/4XvV
         IZ4DqRf8+ARVx9U06Tz15NmiwvytFGyrVt+A38642Uezy0jN+wOIn+1XzFkbwS8CB4LU
         pKL+P9wfOOcEUp7w8oVOq+yN2onAyibSGmXsboA6R7+149g47QviiSjmBDiWNR73jHzJ
         EQU/QVxHtv4wCmUsnuEphKVZ97csDI2V/ZDnJlXcvkvydFpDb+rzWmz0k+GUMPwOU+CS
         X93w==
X-Forwarded-Encrypted: i=1; AJvYcCUpVGcFozsNYVZdo6iP7RPcKZ/1GDx/405Qmv73SZ4gSs27Q4UjUNxQ61a+BWUuIfuxzE2oLgRh2LySeSM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxMHuIk3PnFJ4KOegDlAxlHCaWGDZ5ZFK5r9xYgYAotDOqEMtbI
	z3mWORGnOEN+u+hpRlZFkXzx9phmgIAI1Vy39aWNsk/L47DMuD3NAPcBOrhrJR7ThAqBeHYLMre
	VmQ4Qj8NLCBs4SMn93zeEUXBvggUzjTs=
X-Gm-Gg: ASbGnctO+b9BkIPL8qiHcecY2KftMpbLNgPqYtafM+vVybHgJjR+VPR3HH+mzvh4qi+
	HbQitiJIVvD+9K2i7fFonr11IfkU5MJyAo9NA8ZQudH0uWTww5yv1TLXyeuypYOhxVYii8JAiTI
	cVAymRTyqJwebQrYH9fTaAdHZLuIgW61TqAN4LHZQxshc=
X-Google-Smtp-Source: AGHT+IE1HDAUXwE/YvHkxWsBsN49ALMjdj2debtXVRhW5v60AOrNee/p+CGAoPoBUCSxTBxi3iNNgKR0+pJxDrNKK0A=
X-Received: by 2002:a05:622a:8346:b0:4a7:14fc:205e with SMTP id
 d75a77b69052e-4a97858c0damr88621701cf.50.1751535879923; Thu, 03 Jul 2025
 02:44:39 -0700 (PDT)
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
References: <20250627-add-support-for-meta-clemente-bmc-v5-0-038ed6f1cb9f@fii-foxconn.com>
 <20250627-add-support-for-meta-clemente-bmc-v5-2-038ed6f1cb9f@fii-foxconn.com>
 <06178661-5665-4b9d-8652-de12c2a55f94@kernel.org>
In-Reply-To: <06178661-5665-4b9d-8652-de12c2a55f94@kernel.org>
From: Leo Wang <leo.jt.wang@gmail.com>
Date: Thu, 3 Jul 2025 17:44:28 +0800
X-Gm-Features: Ac12FXwIAlFYgAT4AIZthgezYgKHL7a3VcxQe34aZ5heoKlbtlRJva-8dUGtXqg
Message-ID: <CAF9ZvUvBtMVwUZLaqMLVJryx_0OqDXsybMDDcimSMPoPV0Pmyg@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] ARM: dts: aspeed: clemente: add Meta Clemente BMC
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	bruce.jy.hung@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
	Leo Wang <leo.jt.wang@fii-foxconn.com>
Content-Type: multipart/alternative; boundary="000000000000ef2cef063903394b"

--000000000000ef2cef063903394b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thanks for your feedback.

I checked my patches using b4 prep --check, and I see the following two
checkpatch warnings:

   1.

   WARNING: added, moved or deleted file(s), does MAINTAINERS need updating=
?
   2.

   WARNING: From:/Signed-off-by: email address mismatch: 'From: Leo Wang <
   leo.jt.wang@gmail.com>' !=3D 'Signed-off-by: Leo Wang <
   leo.jt.wang@fii-foxconn.com>'

Are these the issues you were referring to?  If there are any other issues
I missed, I=E2=80=99d appreciate your guidance.
Best regards,
Leo Wang
On Fri, Jun 27, 2025 at 10:47=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg>
wrote:

> On 27/06/2025 09:31, Leo Wang wrote:
> > From: Leo Wang <leo.jt.wang@gmail.com>
> >
> > Add linux device tree entry for Meta Clemente compute-tray
> > BMC using AST2600 SoC.
> >
> > Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
> No, still checkpatch issues.
>
> Best regards,
> Krzysztof
>

--000000000000ef2cef063903394b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><p>Hi Krzysztof,</p>
<p>Thanks for your feedback.</p>
<p>I checked my patches using <code>b4 prep --check</code>, and I see the f=
ollowing two <code>checkpatch</code> warnings:</p>
<ol>
<li>
<p><code>WARNING: added, moved or deleted file(s), does MAINTAINERS need up=
dating?</code></p>
</li>
<li>
<p><code>WARNING: From:/Signed-off-by: email address mismatch: &#39;From: L=
eo Wang &lt;<a href=3D"mailto:leo.jt.wang@gmail.com">leo.jt.wang@gmail.com<=
/a>&gt;&#39; !=3D &#39;Signed-off-by: Leo Wang &lt;<a href=3D"mailto:leo.jt=
.wang@fii-foxconn.com">leo.jt.wang@fii-foxconn.com</a>&gt;&#39;</code></p>
</li>
</ol>
<p>Are these the issues you were referring to?=C2=A0 If there are any other=
 issues I missed, I=E2=80=99d appreciate your guidance.</p></div>Best regar=
ds,<br>
Leo Wang=C2=A0=C2=A0<div><div class=3D"gmail_quote gmail_quote_container"><=
div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jun 27, 2025 at 10:47=E2=80=AF=
PM Krzysztof Kozlowski &lt;<a href=3D"mailto:krzk@kernel.org">krzk@kernel.o=
rg</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On 27/06/2025 09:31, Leo Wang wrote:<br>
&gt; From: Leo Wang &lt;<a href=3D"mailto:leo.jt.wang@gmail.com" target=3D"=
_blank">leo.jt.wang@gmail.com</a>&gt;<br>
&gt; <br>
&gt; Add linux device tree entry for Meta Clemente compute-tray<br>
&gt; BMC using AST2600 SoC.<br>
&gt; <br>
&gt; Signed-off-by: Leo Wang &lt;<a href=3D"mailto:leo.jt.wang@fii-foxconn.=
com" target=3D"_blank">leo.jt.wang@fii-foxconn.com</a>&gt;<br>
No, still checkpatch issues.<br>
<br>
Best regards,<br>
Krzysztof<br>
</blockquote></div></div></div>

--000000000000ef2cef063903394b--

