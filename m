Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02886606A326
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Nov 2026 22:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C2sl8Cc9
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jPzCb4b09z3bZR;
	Thu, 12 Nov 2026 09:46:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::336" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794388105;
	cv=pass; b=Iy4woPx3yPJ7kAtLnCLov6mkdy2Fbd/Df8rtBVZoCfYBI7Z62Lxln24NjAEaV3A0wRsLQao+ZS8ua9Tik8ycaVumLLIGLPHsyMxCTtplaCO9+RoOEHBqO9l1n6ikxWzhL22epXPff6XB624O0SCTIUSi5Jsd2uRHmoGXLc+dgqwVSOqAG5yX4AElfPw7X9cv/VHY/I0Z6ZaXbIyNZpoQ4eWMqTcgfswi5DcbYAUy3usWCf/1a55SwqLIYtLgSqTqzSesGpvGl0Ud6strTl9ntSEte6YPtSJSXFWMx6xfQtw1Fs4JTbnlVaM1oXo5ZsmjmXKIR13LMQ2vj5eIm1rySQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794388105; c=relaxed/relaxed;
	bh=/l2T4p9jCPLPtTUGGPewfdDVP0Og2K5VK9xJnKL6jZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UHjVx6gpAHop2En6AK7exABQrpy++FTImdoSp0gdBKQnQ3guw32goL3jQreBa/Mlr6kTc6wSe9oYzAwHVjisG5LhCsl3l2Mxult/OQBbcxvUQ+ijsTRyPyokbUju2sdIS471e5lmCT5xvQgTnBr4s9/xL51NrJBQ/f1xm7Ldsvq0K0aTxEdqGm+k18/XbirLSoBrh2Rh/SFCRn6df4sq20AFPup47yqh4/bpPsu+59laXf4p0DlisyhO1/x4DT7JI9qikgJtpVNaIWEa9auAXMizq0l4leH2Ql6Rql1g3Y7dqUtnsP2HRXxK/kkGjTU6SGWuD4YOvC2gs50AaNeRXQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C2sl8Cc9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com; envelope-from=eric.yang.wiwynn@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C2sl8Cc9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::336; helo=mail-ot1-x336.google.com; envelope-from=eric.yang.wiwynn@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jPd3X1tP5z2y2h
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 20:08:23 +1100 (AEDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-8451a619da7so1820026a34.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Nov 2026 01:08:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794388100; cv=none;
        d=google.com; s=arc-20260327;
        b=pmwnIXHjDkD9qPhZMjnoOULuJgOChBvv41Vv3hQxTJu9ojLYzG29rlur2fK6Tt2DB9
         WxEtKOxuBZE6VtEQY7QJhFZVFNknj/aaLG/yRsJAG5nmj1Fq6PDTd7GlVWM0Jbj1oFfh
         zIawTU5AlMEjheG0oU+/IGO6FEdRxBDzM2ZX6dPmfXU66Ht8zBD7l9PaWLxIQp1vvgnW
         M6YIdBv8pwNFyhPt1b+vLEUspSPJ7X9mYncvsEOAQZ+/q/ldWkfjopT7k4cD8cGhmHhO
         wTuPoSdp8Yms+xo8vuFicKwj2uZTNTUsGvgETJIiNuYsF9DSw9gyd/gd6PjTgFB7uLdY
         ADTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/l2T4p9jCPLPtTUGGPewfdDVP0Og2K5VK9xJnKL6jZ4=;
        fh=Dv24ID1CSaNyCehlimqZERHE+6nCyDZpwIPCHEKD3+8=;
        b=k3AMGDRdWKqK//nwwZxWklQTPgvhwjR7UuTe66TblnPucKXz2hs1F1SaAfHdekYloz
         d2hrSmvqptvmGuvkB+v2n0XwpIiWkWmRK9z2nFuCsZu5cGv2zAfILs82fPiwF9MoCibN
         HWUtywFvsnGcAefy14m3PirVPL2hiSV10jj+oPQZYvZQYhy/0HsFpcsG8NFdhNVk/4Fi
         K0rIQOSXf9tHQ0zMFXAXW7/Lg09R7RAsnEa2uhQAirSgEHzU3ycwq9IUd76hd8y0gL3C
         CcF0nV1vTZeDmD6aQJsGb28JMtF4poKoQGbLuyjzuerHQ949hGv9/3Gaz1FePmgaIivm
         fE+g==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794388100; x=1794992900; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/l2T4p9jCPLPtTUGGPewfdDVP0Og2K5VK9xJnKL6jZ4=;
        b=C2sl8Cc9cR7sBv2HjpBh1E4Q4cuI1guHCaK5CywV3+O0sE22VqktamJUW/JaA5A3i8
         pmqK/hU81KzYvpF78L/M14mRKtJ4OvVM8qTkztonWT02wBr2hfcDcD0yVOha9b8QQhvp
         CTm71487mVolzPPUDtIz8ELkaEznRbzO2beMH6G9wZqGyrBUlLNFqIwlik4KmSqL+ebJ
         rQBzXDSBIMVfrq26vom02pcd4o9t4pzSei4wA9oq2AIAF+GDVnsTPub9pEygmMQbXPHL
         OFTUYeF7r43S9AsOnp/xi6w8yofkG1PNC1T84g4u4rI8eckAVBwFOB+rkU0FHi2PJvMg
         FFaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794388100; x=1794992900;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/l2T4p9jCPLPtTUGGPewfdDVP0Og2K5VK9xJnKL6jZ4=;
        b=qITcgb8V+KLB6jajlSxXRz4SZ7UJXFQyC3XbtZUAvIDGnpdLaMbK4n4HPCeCrW+ucd
         jws8x55hl+99LQjM/+Rih6eY+GqYYS1RSHPwwJIV/s30EgKaI4plpZOmwC6lphsVvE3j
         UYcxUGRcxceH3tv/gyHWADiagerST1xd9Ag8shgUt6bcbQgYvT4fyOUs7S5bclZcjaUt
         4ixb9F2zTFbL2cxtD4HV4HFoFfjHeV1yhYIyCYSQEbUav6WVYwfVT/OgoEyxQfxqDkEH
         Fz1Wen9sI3wiu8nqu56VnV4/vEoN6Fcg1eQvSyjsSr4DW8XEkRx9ejGbgsjwTpA40zZn
         YOVA==
X-Forwarded-Encrypted: i=1; AL+hErFknRfNoeWVQB2EZLB4eU7VyM+kbPTauIau6Ng2P7LDG3kN74hFCfXHzjKH4ngEmE06kDQytLqbJ/ACE8o=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+kt2mTcWBzL/oWzQia8m3ntGtanYnMZ8cGGBeUXzPKb9afnYcK
	WhdycoqDApC2qMlJkp+tY+IiSvliQnl1H3646dVXhca9SAlJjrt7eFWIQ08KpfLE+BHDFDU5kUx
	VlwUxWXEMBlei8oLqg7U4P9LWXAynUlA=
X-Gm-Gg: AYBFou1iipTtd8oaQxcMh5Ht/s0G7Q1yxt3nDxaScPrtKbpbEcyR9Ll+yjpNj5stUpD
	MycEgpa6xbaE3IquaiG4JbSvraYHnWS3FVHBrJS/vg/H/oJiCZFP5+NZSPBql3v/Zmp4Ojmkl+B
	dsan/tTVa4o/8nLRfIXDOScyrmFdg4UPC/+NBVi1db9XbgnDiecPQ3Zj8gkvL+y7+Ov692663lH
	KW8wzUAzAGimrq+9H3WqDgaYagkuTImqOv29g+EOSzlB8v004iyinANipkFLD6T9dwkLL4cURJm
	sZ1O0d8JHbHOu+gSHer7+Jkwwr4Il518l2vVQSX8Vn74kX3A1F+p48hYasCGSDLz6d3JRZpT7iQ
	YWYoDZG81nLwU7r7pS2J356XJ7yXZUVIxQ3QJLg==
X-Received: by 2002:a05:6830:438a:b0:824:e29:e00e with SMTP id
 46e09a7af769-860f287b5famr1402960a34.20.1794388100515; Wed, 11 Nov 2026
 01:08:20 -0800 (PST)
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
References: <20261105-yv4-remove-ff-nodes-v1-1-aa707a9577b7@gmail.com> <4d149414902c2e7d2d8cbfb2cf741f6e6b21add0.camel@codeconstruct.com.au>
In-Reply-To: <4d149414902c2e7d2d8cbfb2cf741f6e6b21add0.camel@codeconstruct.com.au>
From: Eric Yang <eric.yang.wiwynn@gmail.com>
Date: Wed, 11 Nov 2026 17:08:09 +0800
X-Gm-Features: AclHuK9PoMNLsTgMB1BxJw0pLV5rr9HNmObTBU7Lyh86uA-154BvlF3_R020LyE
Message-ID: <CAFme=rkf7Kgvv2DjLos8EbLamqVzcHMUWsUQb-ZRmeMWjWZ-mA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: yosemite4: Remove Floating Falls board nodes
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, patrick@stwcx.xyz, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Sean He <sean.he.wiwynn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

Thanks for the review.

On Fri, 2026-11-06 at 15:46 +1030, Andrew Jeffery wrote:
> So the expander and EEPROM are on a pluggable board?

Yes, they are on the Floating Falls board, which is a separate board
that would connect to the Sentinel Dome through a connector. That
connector is not populated on any Sentinel Dome currently in use.

> Which "stage" does the devicetree currently represent?

The Yosemite 4 hardware itself is not going to change any more, and
this is its only devicetree. The Floating Falls board is not part of
that hardware: no system currently in use has it. This patch therefore
only makes the devicetree describe the hardware as it is, by removing
the nodes for a board that is not there.

> Have you seen this discussion:

From what I read in that thread, your concern is that a devicetree
that is changed to follow the current design phase no longer says which
hardware it describes, so changes to it become incompatible changes
against a boundary that is unclear. You suggested:

- sending only the finalised design
- a separate .dts per phase, with the common parts in .dtsi files
- for small differences, a .dts that includes another .dts and adjusts
  properties or deletes nodes

Did I understand your concern correctly, or is the number of changes to
a devicetree also part of it?

I would also like to ask for your advice on how we handle future
platforms during their pre-production design phases.

In our case the firmware is built from the devicetree of the latest
stage only, and the devicetree and the userspace usually change
together, so we would like to send each change as we make it. Even
within one stage, the devicetree can need changes because of new
requirements or problems found. A platform can also have several SKUs
that are developed separately and can be at different stages. We build
all SKUs of a platform into one firmware image with a single
devicetree, so a devicetree per SKU would mean an image per SKU for us.

Of your three suggestions, the second looks the most workable for us.
Sending only the finalised design would leave the devicetree we build
our firmware from out of upstream until the design is final, which we
would like to avoid. The include approach looks suited to small
differences, but the differences between stages on our platforms can
include:

- a device moving to a different I2C bus
- GPIO line names changing
- devices being added or removed

My understanding is that your per-phase suggestion could work for us in
the following way:

- The top-level .dts keeps the platform's current name, and our
  firmware is built from it.
- Parts that do not change between stages or SKUs go into a common
  .dtsi.
- For each SKU, the top-level .dts also includes a .dtsi for the stage
  that SKU is currently at.
- Each change is sent as a DTS patch against the file for the SKU and
  stage it applies to, or against the common .dtsi if it applies to all
  of them.
- When a SKU moves to its next stage, DTS patches add the next stage's
  .dtsi and switch the top-level .dts to include it. The previous
  stage's .dtsi can be removed in a later patch, or kept if you prefer.

For example, with two SKUs at different stages:

  platform.dts            (top-level, keeps the platform's name)
    includes platform-common.dtsi
    includes platform-sku1-stage2.dtsi
    includes platform-sku2-stage1.dtsi

and after SKU 2 moves to its next stage:

  platform.dts
    includes platform-common.dtsi
    includes platform-sku1-stage2.dtsi
    includes platform-sku2-stage2.dtsi   (added)

Is that correct and acceptable to you, or would you recommend something
different? I would appreciate your advice.

Also, when two SKUs have different devices at the same address on the
same bus, the devicetree cannot describe both. I would appreciate your
advice here too: is removing such devices from the devicetree and
creating them in userspace the only way, is there another way, or
should this be avoided at the hardware design stage?

> This kind of verification isn't terribly useful?

In v2 I will leave that paragraph out and reword the commit message to
say that the board is not in any system currently in use and its
connector is not populated.

Thank you for your time and for sharing your perspective on this,
Eric

