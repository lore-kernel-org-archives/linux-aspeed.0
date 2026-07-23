Return-Path: <linux-aspeed+bounces-4548-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791E6C531CD
	for <linux-aspeed@archiver.kernel.org>; Thu, 23 Jul 2026 08:38:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h5Pfh3cTlz2xrL;
	Thu, 23 Jul 2026 18:38:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::130" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784795932;
	cv=pass; b=FbzMqazcqG1NhzDaWzxdx2At5qlxpMtkd6ggyVxS8oqJPR9erGtEiDIl9EfJkpfUHV3LrUuatnXr22q30IVWfzNCd2xrlnVE48II2DE6A7FOHyHQWD+0wBdKn6DtrIRul0jeqVglm29y4pEu15yEKuGDdMMJVfRNIzssZoeNFlBLyE0BH++HyY30X4wLVEK2uTxSPq34R/wsvhmEmIXtkEg4qhqfGpzG5xuJ3rPdwbjRgp38R3Qs76gUfX3JT6wZ48OD3fBaRqMEtFmYVI5mnUX5i8Xx6J2umQD18dRvFS3fmcDY9Gj4cYBN02TFO1/rVKmHjqTfWxjErqkI2PNWVw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784795932; c=relaxed/relaxed;
	bh=JMndNBDrNRSXZklDAozkSv6Z/iRQ8qtJLkHPftqq8ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOZuGBB0ys6Q4J5dDyy4wH1cOP06uvqK0J78R+k61YOh5Sx5wIDRv3jKlGeReUjVjuIb35g/++OVHTdmCegdunZ/+/A05bS3DjSsjHxqQkekXWcqN7zf8SglvEFejmFYZKvxk1crGr85KW1N7yFPwHznhpstdC1C1463KAVL+sFc94legyytXi7LPxuKD7C3sfZ97DdvroVhmVCZEvJYr1fSdFwpOSlYJV7ywQNIr8HBg5log4QeOfI2Y7XTBwKp505M49Y5jZ3BT/v2zhTtq+0TTKTvSwApPBpfZeJNPzNpz0Qnsd6IfzIuGHtB+hZMSDvbhqFl8Q0IzqcbjHg1xA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eYXF/F8u; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::130; helo=mail-lf1-x130.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eYXF/F8u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::130; helo=mail-lf1-x130.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h5Pfg1tmLz2xJT
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 18:38:50 +1000 (AEST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5b015532f7bso363439e87.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 01:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784795926; cv=none;
        d=google.com; s=arc-20260327;
        b=aWbvctxr6tcO4L0c3n16DEl/v3RIlr/KBZX/TZveqeAGETm+owPBJdVKGBGlfq67l3
         uGtoDkzxscOzgrtCXmvUEM6FfM+gUHctVbkcbmgo1SMH1CGPypoKs+Romj3RX7e0tW8d
         xNXDixoiRMavZyQzAXKkHDkB0QWX+aaTyhKc7ls7ceuwsCHvMYjdgfF/n6Me+5JEerDX
         vYkDW6MVCEKMFUS3mQKXGRX6iVIDrYSp15FbBoGqvraCz+PTYw8GQcsBRS22yoC8wMfM
         kCfU9RDMA9iFEmwbtW9udKEaIJZ9rmPTxDuhG3tEASY4ftru/S6Dyox4muY2AQK/4M40
         e+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JMndNBDrNRSXZklDAozkSv6Z/iRQ8qtJLkHPftqq8ss=;
        fh=m7KCggBilQPT/iDbGWu+1yKiTgqMbLFS5vQkzfK9Vg4=;
        b=hRIk2C8di2wGoehszK6AGSXTIvp2HyJFmL29BNPEr1wz2HBy3dtK+HJFYA1nZo6JLP
         erWXmpjl+8DguqWxXavcWc37HCRBFW+2I+VCxf2VnndiYqafZwqTYjOejT2ueDbxVTa1
         799QJECLet9j7AUi6JKYDMXnLoJoxdb7DIkcFDgb6vpxoxaJ2HHes1pkToFrol7n2BK2
         RnCobHrm1DTdcqwu1LJsK7S23yExzPDA7RQkXeODIRaxFny3gaXCt8oTLQoGP+prDjIm
         angYA0GRL1dlIdHv7ACbrGRh0hFy4u4bVejtya18jVWzxZgm9PxkS5ygNELYrk6izyyk
         PtAA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784795926; x=1785400726; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JMndNBDrNRSXZklDAozkSv6Z/iRQ8qtJLkHPftqq8ss=;
        b=eYXF/F8uJXa2tkYtpTN/ApjcqFNXW9+htw2QL8xQk39gLQP5+LvIUtTnlTPH5i4grg
         w/WKdL9C6k9tLHSLWrcEAVT1F6H7Rq+7YSsp87kwoF1A4c4Aaa55OHmzhnPQiPgALz2w
         tnDCUVMvNpxeQkigjbc0AZGyv5XyJJTJoMDXEPTO8Pjvnaouq/08uu8TiLqK/a+9gA1S
         SFxDr9EIJy4vOrL2miXrBskMTzSUVYzLkFYWhGjjQZ6t42ROn5V2/u7rPMKieyBZ/AS4
         d9KqWxopjjiMHWmWdNZ8+IgTUuN+bCfQ4PaDOAlP+C4YEm04zrNHfXWqYB4xclPqxH5M
         0dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784795926; x=1785400726;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JMndNBDrNRSXZklDAozkSv6Z/iRQ8qtJLkHPftqq8ss=;
        b=NJpap3SwpcYpLn6xmXIGi3GKiC4Ph6Ek3qf0jFgLNgdWdnb+zAQMcMrPTAQSnqvXCY
         gYWXSpBUAIn4LwMIoNK0mZVE3OBuyGYzT3f7aS3UepmtR75fm46ScEFbVKLJdj7SNkNM
         qOS1+XLb38iP1zsoP7AbjVZl0rbOR7Nh/qnBSrr0XyP4eipWAa1es519mGTEgyzcwC7S
         /fs4yCXaDBauRJ3bYyW/719K8Zs/7X0MTMj9t4f/9JSsZ+Uy2NtS4LjBoAkJUNmPIT3G
         7tJzz8EBMpIFKwiEcgCo5I4K6FL6QImoWPEToF7+B9SxOurno0BImk51fUHqzEkYPzMX
         JlMA==
X-Forwarded-Encrypted: i=1; AHgh+RpmlRSFDKAwcsvcMR8OijfktgAJc8Q4DgYRVF0e2vy/VC8FRFNJNVa9yFBzV6m0iujX0gueuHl9bm1Wu2E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzrjdUMCdswYRjtb1cZM+XoMj/3OjO3Q7eaK1Q7i/oGRmvkzyLX
	rRQ6Z4oBSSvLaFivyXKlUPPOXjJ1HXJ2gOlAlpqSe6UURmf9xpsPkvbubgY9WX1mvSGOWIkI2xq
	vMHg9bAsPiSnPskV8KBmxqV3Gy4CMt4I=
X-Gm-Gg: AR+sD11c7CvQHcQ9eI5EGC9ct1uUNfEpuo9JJfOoxYHWnp0bQabLnGSNftrTRKKS5YV
	yML8amyoW1poGsR4/+HP4Vve2AVfgBWLCf3KRIHwyYg6irMf9YABvHEsGe5YhgdQRmhhD5okfql
	/TG+pt2t0jL7jZ9aULLjOgB5YxVOLZHsEzdoAz6Zj2l1iaBaD3yMB+crmSASWFIwTWh7iLt2qB4
	WmpTJx8bU/6hzUihyEz37mBNJ0ceqOfodJup+iG0L2syOP8apias23+IRJtxwo=
X-Received: by 2002:a05:6512:3f4:b0:5b0:7766:54d1 with SMTP id
 2adb3069b0e04-5b2b2f54040mr266927e87.27.1784795925744; Thu, 23 Jul 2026
 01:38:45 -0700 (PDT)
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
References: <20260615-ventura2_initial_dts-v8-0-c89f92c80447@gmail.com>
 <20260615-ventura2_initial_dts-v8-2-c89f92c80447@gmail.com> <de6f82c5601a4481e418270171e803340368bd2a.camel@codeconstruct.com.au>
In-Reply-To: <de6f82c5601a4481e418270171e803340368bd2a.camel@codeconstruct.com.au>
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Thu, 23 Jul 2026 16:40:32 +0800
X-Gm-Features: AUfX_mzgVslcyDePfLi1-LkdPZo905qgCpAOduekKppC45gZMvMEvUh9-ZO5AuY
Message-ID: <CAF7HswMG1HWxELQxTSaEWVeWi2Mjk8HpuM18AAVLCV5j_r467Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks for taking the time to review this.
On Wed, Jul 22, 2026 at 7:46=E2=80=AFPM Andrew Jeffery
<andrew@codeconstruct.com.au> wrote:
>
> On Mon, 2026-06-15 at 10:46 +0800, Kyle Hsieh wrote:
> > Ventura2 is a Rack Management Controller. It is a modular
> > device designed to manage liquid cooling systems and monitor hardware
> > states within an IT rack. The system uses an AST2600 BMC for management=
.
> >
> > RMCv2 serves several critical roles:
> > - Detects liquid leakage at both tray and rack levels.
> > - Communicates with and controls liquid cooling equipment.
> > - Manages leakage events and executes system recovery protocols.
> >
> > Key hardware features include:
> > - An extensive I2C and IO expander topology to support comprehensive
> >   sensor monitoring and backward compatibility with legacy trays.
> > - MCTP over I2C support for asynchronous device communications.
> > - A dual-flash design for BMC firmware redundancy.
> >
> > Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> > ---
> >  arch/arm/boot/dts/aspeed/Makefile                  |    1 +
> >  .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 2903 ++++++++++++=
++++++++
> >  2 files changed, 2904 insertions(+)
>
> We now have scripts/dtc/dt-check-style. Running it over the dts with '-
> -mode relaxed' yields 49 instances of 'mixed-indent-chars' - these must
> be fixed. Further, can you please look at the output with '--mode
> strict', address all the warnings that are reasonable, and then discuss
> what's left?
I have fixed all 49 instances of the 'mixed-indent-chars' formatting issues=
.
I also ran it with '--mode strict' and addressed the formatting
warnings accordingly.
>
> Otherwise, there are still some concerns reported against the bindings:
>
>    $ make CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-ventura2.dtb W=3D1
>    ...
>      DTC [C] arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dtb
>    arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dtb: /ahb/apb/lp=
c@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast=
2600-lhc']
>    /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/=
boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dtb: fan-controller@20 (maxim,=
max31790): 'channel@2', 'channel@5' do not match any of the regexes: '^fan@=
[0-9]+$', '^pinctrl-[0-9]+$'
>            from schema $id: http://devicetree.org/schemas/hwmon/maxim,max=
31790.yaml
>    /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/=
boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dtb: i2c@400 (aspeed,ast2600-i=
2c-bus): Unevaluated properties are not allowed ('aspeed,hw-timeout-ms' was=
 unexpected)
>            from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.=
yaml
>    /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/=
boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dtb: adc@48 (ti,ads1015): '#ad=
dress-cells' is a required property
>            from schema $id: http://devicetree.org/schemas/iio/adc/ti,ads1=
015.yaml
>    /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/=
boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dtb: adc@48 (ti,ads1015): '#si=
ze-cells' is a required property
>            from schema $id: http://devicetree.org/schemas/iio/adc/ti,ads1=
015.yaml
>    arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dtb: /ahb/apb/bu=
s@1e78a000/i2c@580/power-monitor@69: failed to match any schema with compat=
ible: ['pmbus']
>    arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dtb: /ahb/apb/bu=
s@1e7a0000/syscon@0: failed to match any schema with compatible: ['aspeed,a=
st2600-i3c-global', 'syscon']
>
> Can you please tidy these up?
The board-specific bindings have been fixed:
- Removed the invalid `channel@X` subnodes from the `maxim,max31790`
fan controller.
- Dropped the deprecated `aspeed,hw-timeout-ms` property from the I2C bus.
- Removed the incomplete `ti,ads1015` ADC and generic `pmbus` power
monitor nodes to fully comply with upstream schemas.

However, the warnings for `aspeed,ast2600-lhc` and
`aspeed,ast2600-i3c-global` still remain.
Since these nodes are inherited directly from the SoC level
(`aspeed-g6.dtsi`), it seems their YAML bindings are not yet merged
upstream.

>
> Thanks,
>
> Andrew

Thanks,
Kyle

