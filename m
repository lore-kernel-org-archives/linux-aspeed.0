Return-Path: <linux-aspeed+bounces-4881-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 722AAC61DE4
	for <linux-aspeed@archiver.kernel.org>; Mon, 31 Aug 2026 01:28:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hYBGZ5NBYz2y8d;
	Mon, 31 Aug 2026 11:28:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1134" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788138843;
	cv=pass; b=BR3BKPyW/7krD2UTwWA8eXD0IJCp4ba0YLLiceI/QgEEGynlVNMMrS10CNKLGRkFLuRlHRJQHPp02EPLIBp7yLp4PifveXVP73mtK95FPvuyMKnTwQ27I8RO26zcFmLdBz6WwJzW5/obwG0BdK5fcBBgNfGExcIhuEiDcqR285iDwkUk/NwaiOU0+zV98+jOSJ51I0+IsoDLMaYbMSasRkjYLfRJTsw0/AnndsUdz8g3FfaDm4kHCABhtVPqAc9XFm7oxz6WBBkxK/rJFNkXLKiqXnq3PSOvUYqidWUr/a6ywGT9SgYrqMbr5epCamUaD/Ld3UFXiT1+lASIof2OVQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788138843; c=relaxed/relaxed;
	bh=6m4rUqLAErBEQ2/4HLOA40kOXhkRfhn69xpi1o/FS84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2jqDib4RUsfbGlVBwWDZcupqIGsKumcrWKISABtwvjP77IoPKgCy7cR4i8O5W4WjffV3c4wKIpoX1VMIDnrODOMEN+RXN1apbOoCZp0EyzQRwX+fpRgQqzyxAWlbgjzseKt8WFn/nuC+mNkQJC9lKOAPdsiCiNWpgjcVPTioa7JYHBNXp9kc5m5C9Laip5Bi4hX3MbnS2ekds1I4IDMyNA76uMo7dQJY1XLuXZM6Q60chzK7LDqgDeNFK4e20XVXjrZsArJ5Qik37nfr79+PMYkMmzH5fBRL6Z0Db3BsFueRbJwTtWA6d5bIvxeTE6j5O3U9PEZUOqVNJQCNwUOQQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FVIYPIsr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FVIYPIsr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hY9xQ20bnz2y2f
	for <linux-aspeed@lists.ozlabs.org>; Mon, 31 Aug 2026 11:14:01 +1000 (AEST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-856114a8247so33493007b3.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 30 Aug 2026 18:14:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788138838; cv=none;
        d=google.com; s=arc-20260327;
        b=JRSBv3hVr/ztyGJNTN+AmQs6qtq5EE/hXwY9j/3yJjYWAbiADLOzG4/0N7dTTCh2/6
         li5aPtnhQE2lFwvGrpZFYHRzZaG8RGiwOoSCNmFJ25dwSptYWN74pVPDSCyFDvAUJHWU
         xv2kyaENMsExbgP2M8vx8ooE/MMdQgqKBg+StDl4LK4RhMliPZ8sXR/6pJDxN2pND16V
         NY4p0o1lTc70LL102itPBmRJCeHMUdTeUbJlwc0RaWGuRhF58QRBNDjYAHMcAqdaqpdy
         NxZseDw2aORCk76/suvURZ/6CQEX4JdmVsk5aOI9duSaTgmyjwbKUziMDd86/Mviswak
         5ikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6m4rUqLAErBEQ2/4HLOA40kOXhkRfhn69xpi1o/FS84=;
        fh=40f9zbZju2D1X5kAR4EYQOQBUy1WB9tDw8Qv/wEwp1k=;
        b=UfFdRwGLxVKdCQUJ6Ip+ORl7jKW2bV/PXwg9qV4PCwoaAu6ktnnAXPBdAwoARV0wEp
         sAcXnNwJBDeoFhSGUUXdhlO9KeCUKkK32iSMzYZSfL5fcaa0o42JxXZ2ZMJU9OO8fDYZ
         lYvz8Y2WdK3jg7QwJ7rrYHYoZEgUMarvuoJ5LpXKYHT0ZEWEN0Fq3UD62exLl6Ihl0md
         DHtcmx1i834JT9KG0P3cym1p7w1YQL7Jz1wzHQ4/5Eh/5qApDYTufMkjDU5e7VPH49aW
         fRxEDBULtK/Cfw5xZxf1IyeNmU1q38cDfZcLlBY3UJn2CkuH6NAL5/NAd1TFxjos/J3V
         CDlw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788138838; x=1788743638; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6m4rUqLAErBEQ2/4HLOA40kOXhkRfhn69xpi1o/FS84=;
        b=FVIYPIsrXlDp2yJze/SDr6+acXHqI6o+R3UwR7RxrLlV1/3n8O9f1VfifvkA/0vAFi
         cBhTjlNhx/ZuLBkgwpbbOnTypVdS5FCZCbh7kr/LWKIqX2+RZVnrr2XxKB2LxOlACZRK
         PEwNy1PxKlJRlVXsz75kRTWK4no5+283kSR7Aqr5YXm8Kal8c89qXM+SkJBDfNHrct9a
         OC1uTBQbkqq5rTpfcUaFo8de4RN5f61RYOxiEMAV7qV5YYx1EC7652Rccn6VGBIAombE
         SnJHH6tvmMeQhBk/t3Etw8+jRgtT1LLlfw/Orh4yv0rsBWKVm22z7HmIw2JzK5bC07fk
         7XGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788138838; x=1788743638;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6m4rUqLAErBEQ2/4HLOA40kOXhkRfhn69xpi1o/FS84=;
        b=E3Prhekfo4AWyewSwg4TbQM4e9844oJiVNQZxcS28eS4RG/h54pI8of9LjYs/SW+vF
         F0+CBZ53Zr9Fw+35CLf7OZlV4by8TfGe1Cp1p6pQh28kkLTc4rNe5xA26ClalPbeWFZ1
         FdQCwzFEa/2E5tU6xcNA3Daq5i+g/dZavTbdXzZd85KPGSF9MQyRL8M0DGciKMdkcGzO
         0YTlPdpgr/PaQSqNkKtrbDHq70d2lLpY7wh4gTasJ4RQ3DlWRhXG7Mb4C/o5ccJn+EG+
         tbLfaw3c30clUGzziS4hSJzx4oIsy+GzNAnkXL+nBBXWkShoJpoH0CVVtRrQtsgCzyww
         J4YA==
X-Forwarded-Encrypted: i=1; AKwUvBzk3X2LumyXrrbb8G1j61wVJyqDsOF33K2o6PHAoAboyvwiZogBqX8Trl6+waMKPYqQjp2DiYREQgapvzE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++kOQGAy9gSPfdOpwBOCQXLSymBl+LExJMDjOrMpfHPwlQX+weS+
	R7NK9kF1q9lPtFHi6tTHbbvRJ3isywu+x0+NGvc8q7kE2YlVD0kDJSPmNhT21C2ilF1V+FYVUKf
	4FO7TkQnQvGVBQADOfgtVQQ97ToAV74k=
X-Gm-Gg: AYBFou0HivHwY32OxCTD7etx5uV0lG3u0MeMtnR5jj9TO3nFcJdYXbyPuYrynbEMtgN
	iUiwRyI+4HtPggSJDrpGxRHJ2t8oPhWIH2vodihb/Ax8TWt+EbDud5gj5FgOcGr6MfTkwrSDW2A
	Ge3xjMCOQO2UofVHed7D3IcapVw4vcSMK2hJkMCIyTTJqYup0of+r4lsHNj2jk2KeTe1NXoKpF1
	BeSABo0a6LP3tSaBndsHYv1i7Goqf/ieHV6v+3rDT8anHJRiB/f7uX4n1huPXwydHwZiogivVJs
	4KZuximTnWPkD7e86dffsnck/3NDfwIodgITebYt7z3pGALAOvpmI35L
X-Received: by 2002:a05:690c:f14:b0:81e:9826:942c with SMTP id
 00721157ae682-85d625bd769mr85269827b3.0.1788138838366; Sun, 30 Aug 2026
 18:13:58 -0700 (PDT)
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
References: <20260830182036.284736-1-prasanth.padarthi10@gmail.com> <d60f234e-1b9e-44cc-9bad-da79e794fe44@lunn.ch>
In-Reply-To: <d60f234e-1b9e-44cc-9bad-da79e794fe44@lunn.ch>
From: Prasanth <prasanth.padarthi10@gmail.com>
Date: Mon, 31 Aug 2026 06:43:46 +0530
X-Gm-Features: AcwNN1XN0yEU2D69YE4c1BELWZsilUqHUb57aFdBmNeJpFvnp4h-BloqM-iVkto
Message-ID: <CAMFFDGgTnNouukst3V1rEg0NCNMW-BZ6tM6+fbQc0zeXaOb72w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="00000000000045248b065a4d843b"

--00000000000045248b065a4d843b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

I do not currently have the PCB layout or trace-length information, so I
cannot prove that the board provides the TX delay externally.

What I have validated on hardware is:

rgmii: fails, with RX CRC errors and no valid RX traffic
rgmii-rxid: passes, 5000/5000 packets, 0% loss, no RX CRC errors
rgmii-id: also passes with the same traffic test

This shows that the RTL8211F RX internal delay is required, but it does not
establish where the TX delay is provided.

Given that I cannot provide PCB-level evidence for the TX delay, would you
prefer that I use rgmii-id for the next revision?

Thanks,
Prasanth

On Mon, 31 Aug, 2026, 1:53=E2=80=AFam Andrew Lunn, <andrew@lunn.ch> wrote:

> On Sun, Aug 30, 2026 at 11:50:34PM +0530, Prasanth Kumar Padarthi wrote:
> > Add device tree support for the ASRock Rack B650D4U BMC, which is
> > based on the ASPEED AST2600 SoC.
> >
> > The series adds the board compatible and describes the BMC memory,
> > SPI NOR flash layout, UART console, and MAC0 connected to an
> > RTL8211F Ethernet PHY.
> >
> > The MAC0 RGMII timing configuration was validated on B650D4U
> > hardware. With plain "rgmii", the PHY negotiated 1000baseT/Full but
> > received no valid packets and accumulated RX CRC errors. With
> > "rgmii-rxid", a 5000-packet test completed with 0% packet loss and
> > no RX CRC errors. "rgmii-id" was also tested successfully, but the
> > additional TX delay is not required, so "rgmii-rxid" is retained.
>
> Please take a read of:
>
>
> https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bi=
ndings/net/ethernet-controller.yaml#L287
>
> Does the PCB have 2ns of delay for TX, but notR RX?
>
>      Andrew
>

--00000000000045248b065a4d843b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Andrew,<div dir=3D"auto"><br></div><div dir=3D"auto">I=
 do not currently have the PCB layout or trace-length information, so I can=
not prove that the board provides the TX delay externally.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">What I have validated on hardware is:</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">rgmii: fails, with RX CRC =
errors and no valid RX traffic</div><div dir=3D"auto">rgmii-rxid: passes, 5=
000/5000 packets, 0% loss, no RX CRC errors</div><div dir=3D"auto">rgmii-id=
: also passes with the same traffic test</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">This shows that the RTL8211F RX internal delay is required=
, but it does not establish where the TX delay is provided.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Given that I cannot provide PCB-level=
 evidence for the TX delay, would you prefer that I use rgmii-id for the ne=
xt revision?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Thanks,</di=
v><div dir=3D"auto">Prasanth</div></div><br><div class=3D"gmail_quote gmail=
_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, 31 Aug, 202=
6, 1:53=E2=80=AFam Andrew Lunn, &lt;<a href=3D"mailto:andrew@lunn.ch">andre=
w@lunn.ch</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Sun, =
Aug 30, 2026 at 11:50:34PM +0530, Prasanth Kumar Padarthi wrote:<br>
&gt; Add device tree support for the ASRock Rack B650D4U BMC, which is<br>
&gt; based on the ASPEED AST2600 SoC.<br>
&gt; <br>
&gt; The series adds the board compatible and describes the BMC memory,<br>
&gt; SPI NOR flash layout, UART console, and MAC0 connected to an<br>
&gt; RTL8211F Ethernet PHY.<br>
&gt; <br>
&gt; The MAC0 RGMII timing configuration was validated on B650D4U<br>
&gt; hardware. With plain &quot;rgmii&quot;, the PHY negotiated 1000baseT/F=
ull but<br>
&gt; received no valid packets and accumulated RX CRC errors. With<br>
&gt; &quot;rgmii-rxid&quot;, a 5000-packet test completed with 0% packet lo=
ss and<br>
&gt; no RX CRC errors. &quot;rgmii-id&quot; was also tested successfully, b=
ut the<br>
&gt; additional TX delay is not required, so &quot;rgmii-rxid&quot; is reta=
ined.<br>
<br>
Please take a read of:<br>
<br>
<a href=3D"https://elixir.bootlin.com/linux/v6.15/source/Documentation/devi=
cetree/bindings/net/ethernet-controller.yaml#L287" rel=3D"noreferrer norefe=
rrer" target=3D"_blank">https://elixir.bootlin.com/linux/v6.15/source/Docum=
entation/devicetree/bindings/net/ethernet-controller.yaml#L287</a><br>
<br>
Does the PCB have 2ns of delay for TX, but notR RX?<br>
<br>
=C2=A0 =C2=A0 =C2=A0Andrew<br>
</blockquote></div>

--00000000000045248b065a4d843b--

