Return-Path: <linux-aspeed+bounces-3809-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788111061B27
	for <linux-aspeed@archiver.kernel.org>; Mon, 30 Mar 2026 22:42:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl5ps1ZWGz2xGF;
	Tue, 31 Mar 2026 09:42:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1230" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774743261;
	cv=pass; b=EpIEShWi52z4JMsNaW07OrCOJUoBjhjoq3LPZZ9eCufGJu1rE57jvB5mT7U2W1kB1s7OiDdFgC/JufiOkohOFtu8c9QGeMICd6VIWtnURByoyenAAd0B6bWZQ+swpdsmdTxar8QHhpAZvy4HHhRBLMk/KjwcIgaMeCYReWIyIiaKau8SCf5iqXmuQfHY3R78l52xXDuqD1QpteI3ALk0ivqYsIONWLbi0LlOfKgoUfAtkHWgTwCnpBoMjBVS5ry/RuirO2wFe/YfMPEBy8uUgUuJJ3MwXm6hja6a0+IIX0HG9YtFR2KDfqwb1LJBbgmTtNSaOKED5uwRMsgAbolaOA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774743261; c=relaxed/relaxed;
	bh=wLm/cWeL+ALoe0xoKYMB0cJ1r37KJ8n7QLIQtxRsqdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ng6ZrUr58OoEJrIfChJIisa+ykLSraxF753etl6tkjXwQ/EmbzVACd/8A1SRsP/lIXGk+aUdPVurZFlJnAs7ijH7+j3FWLC9HDdxGl2MIsCpYmrtDnhdhcSh82do3Lov2QlACZDaXRtJuHmMBPqCkDF/ddft7Us77mJXAsO9rx/sNb9AHLCxH5yq+mXfKXII6sshWv6X/F7hE4Zn3mQIzCchr0lgMeyTZHvH+08y6IdRVs+xGT0ubhnnB/EBiK09coVCdI0hPWFOb13IfODDgEUnVHvd3tx4PU+x1Vl7Tbpb9d61HqRGHO3W5yK77++KWMB6Hdnu4uY5eD/gQFBN7w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZCp6yuaR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZCp6yuaR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com; envelope-from=anirudhsriniv@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com [IPv6:2607:f8b0:4864:20::1230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjvy42ySTz2xmX
	for <linux-aspeed@lists.ozlabs.org>; Sun, 29 Mar 2026 11:14:19 +1100 (AEDT)
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-12a80c36350so3666554c88.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 28 Mar 2026 17:14:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774743256; cv=none;
        d=google.com; s=arc-20240605;
        b=jH1iGXEKwAzktkVO+K/HyzL2ftKUyYZQS4DPCCz3c+PVeoGXy3wijdVlf49CZ8Gq0+
         HuySNhJrOuMyKgY9tTo+cPjZsP/h57GLXm/tVA0rCrq3Aq+n8O4CiV9qsIcM1xom5YHo
         snRRnzDRaDLEqIrmNyPzqogB9P+4CRySHk/CEztyHV5wPyrG+qYgziprMnWyc8+6IMpt
         ZwoadAiSGBHB+ITc8uB1KPnjs0F2ji+e9MEWNcY3kTvCDmODnxyv+AQepLRaCkHj09Yf
         FfBtw09/zFuXbzHI9xxgtKdlFQdx4WUjZ1/4bp5kybw/rfdZ+cEJj9LhSVTLGfTnirYT
         PCLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wLm/cWeL+ALoe0xoKYMB0cJ1r37KJ8n7QLIQtxRsqdU=;
        fh=7760SYtjCtZmzdDKV0yufWYAlcRk9SrxqS3vTnzaHpk=;
        b=egpeYGuTTe5esaK56ZX3GIGITw+6ZFG1UCalEhYrn0SN3XsyP388X3a1h9ngq0tpIH
         OPNv9hxqsVnC09a0sNlkv7ZYFT4CnzmjqDib1gvMYeJAX0Y4X7KhnnagDy44DVyqyylV
         cCem9STixjHDkXDTNpE3WebHozJiBL5ggOeoUGDSbCSxYB4YRjx+9W2uPt8uKKApa2a1
         Wo75PCk6eW/cnVP0gbDwNm8JInC05IcXcOvFMZSb/Kpx62S5LL0DncKlBamlJLVafOZm
         osGE4mESEQacXBjM365N7uvRWBCrKxzbdrmIGkjAcOgKJR+3bnpGfL2GyuBqa9ubv90F
         SrgQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774743256; x=1775348056; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLm/cWeL+ALoe0xoKYMB0cJ1r37KJ8n7QLIQtxRsqdU=;
        b=ZCp6yuaRZ4b2+bvJNHlAmlFnPnfJJ4fISPvZ1RudLCGOnIsIYQWzhw860ZkReTPn/f
         QYDxj42gS8tavuMPMMQLFYi6C1Rv1kW2nIv3od8AgaqikXwcYA1xnkM4IJJF1toV0fGw
         xtTnwAViieD/KSlGvSpdY0ElTp/ZbxfXTV0H4HFavZxdWvsModxZwFNh777wNN0VNnfk
         zz7AoP9Mze2XptRmC006nP2L5nZEN/4zJcFFFVEiexmPIfILM7c6hYbERN37l5l6OJC2
         ZEp+0neQumfmVucZUBA4mY6ey+vch6KGvEK/X3x8f6CsnE4p+P1T+J//VpCk2mFxHxTo
         W0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774743256; x=1775348056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wLm/cWeL+ALoe0xoKYMB0cJ1r37KJ8n7QLIQtxRsqdU=;
        b=kpuIHk79rQ2FolFtsI/SM8htoTwn7plznKKAx8XqLZ/HD+QCoRitjB3/MRc6vMo/wa
         pEQfQnl9FmplbnW7z2rb3YltTJaNMXrnKNiRQfNOo5HZ5wCFF22bnUbDINlxHfCemlxm
         vnP3LHgEZRow7gT5wngw1V4y6iIYPoix1mJcOJIBqNTS72utWrG2RRnxsO/Q15rTmYev
         6WFn9rm0B2D1UN2GO1yBsha89SfphkKsnXdowviBe7zN5UQWnLWQihwRNQQjy5JgmE3q
         HIBrZkEabcYVXPgXVNYtTywzTlDdBnR2AUxxkkQyJCbKBvE5pmI6AY6f+bGAIzBCBP9T
         /LJA==
X-Forwarded-Encrypted: i=1; AJvYcCVsWKSc9CT0r8jC9p3npWtD0zWDEHWa+QYmWxD3t3BF0VOOG0Fg6Txe9NwpbXTpPGgHyMLNZE4wYTYVt1g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzeF7cWTvynYwOiIGwhvTZa0rxPEnySjckTWt3eM6t42O+SRwOw
	v0CqrLJpFTu3gQxsyeH7m1zXZlJTR3wcqen49f2q+KkAQ6s4poMz3GusiZEHP93ihsZ47b2/oMO
	O41If8gJOxudNSu/60DBWS02ABiceCIM=
X-Gm-Gg: ATEYQzy1YGFkA99Ng70M4OVW5M18/N6RughN6wH7fHPckJRC3ya7ZlJuTFkTN82bpzQ
	fVa7ZkBqGGmh7KTn8Aef7Wka/Im6OwpqTfwPYDugKORGcvQEQwyNdcccLxL063R3A9/LiwlWpz7
	A+YML0v4qZtAcYE95QPy/0eqrHGR6LzLCT2azCyCFbh0XJOesBmRYkYtEZ9ezPflHlJ9I3ndfUb
	vO16FGqpfnlkYqKYYJAJogIFT21JQSboeieNPZOlfC0mKmwJ55S/95OgXH656DFZcvgDQcH++Nr
	kUfQ5ciYrMiUrwuIl7vg
X-Received: by 2002:a05:7022:220a:b0:12a:71ab:8235 with SMTP id
 a92af1059eb24-12ab284be87mr3912794c88.6.1774743255658; Sat, 28 Mar 2026
 17:14:15 -0700 (PDT)
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
References: <20260328-asus-kommando-networking-v1-1-66d308b88536@gmail.com> <ed3d39df-0a0e-427b-86cf-b9b2d2094b51@lunn.ch>
In-Reply-To: <ed3d39df-0a0e-427b-86cf-b9b2d2094b51@lunn.ch>
From: Anirudh Srinivasan <anirudhsriniv@gmail.com>
Date: Sat, 28 Mar 2026 19:14:04 -0500
X-Gm-Features: AQROBzAt7ICtBirsaNdRYtv4vbmjxcTMi8IMv_vX0eO1yy8eUd3xiGfmPfRlEXY
Message-ID: <CAJ13v3S7ucjd-ifmKFBDGtsg32MbOar2OBeiGMVEJBsH8+JP7Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: Enable networking for Asus Kommando
 IPMI Card
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew

On Sat, Mar 28, 2026 at 7:05=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sat, Mar 28, 2026 at 06:39:59PM -0500, Anirudh Srinivasan wrote:
> > Adds the DT nodes needed for ethernet support for Asus Kommando, with
> > phy mode set to rgmii-id.
> >
> > When this DT was originally added, the phy mode was set to rgmii (which
> > was incorrect). It was suggested to remove networking support from the
> > DT till the Aspeed networking driver was patched so that the correct ph=
y
> > mode could be used.
> >
> > The discussion in [1] mentions that u-boot was inserting clk delays tha=
t
> > weren't needed, which resulted in needing to set the phy mode in linux
> > to rgmii incorrectly. The solution suggested there was to patch u-boot =
to
> > no longer insert these clk delays and use rgmii-id as the phy mode for
> > any future DTs added to linux.
> >
> > This DT was tested with a u-boot DT modified to insert clk delays of 0
> > (instead of patching u-boot itself). [2] adds a u-boot DT for this
> > device (without networking) and describes how to patch it to add
> > networking support. If this patched DT is used, then networking works
> > with rgmii-id phy mode in both u-boot and linux.
>
> I've been looking at
>
> https://elixir.bootlin.com/u-boot/v2026.04-rc5/source/drivers/clk/aspeed/=
clk_ast2600.c
>
> And i don't see where mac2-clk-delay is implemented. Could you point
> out the code?

I'm testing against the u-boot version that openbmc uses for its
builds. I don't think upstream u-boot is used by openbmc.

https://github.com/openbmc/u-boot/blob/v2019.04-aspeed-openbmc/drivers/clk/=
aspeed/clk_ast2600.c#L999

>
> Thanks
>         Andrew



--=20
Regards
Anirudh Srinivasan

