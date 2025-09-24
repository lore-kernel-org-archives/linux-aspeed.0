Return-Path: <linux-aspeed+bounces-2334-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB2CCAC5A5
	for <linux-aspeed@archiver.kernel.org>; Wed, 24 Sep 2025 13:34:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cWyWC0k57z2yqg;
	Wed, 24 Sep 2025 23:34:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758720871;
	cv=none; b=nFLAQRjpjy/H72K5rKy8czwHDnn4qj2QvPC2x1UTlkAgfQlZoWc89fc2QUSVD8Sh/NjcnnpgWUu5JsIznDGXayt1BkwHSKa3YKdrQEzc44SuaJ/lS7EIGYGby0b6mnSbgpOWwfw6RdX1e0f+eGq8u6FbUxHthLYy3cz7awAWHkbeVp9WxrF+o4j0kQSjteZjmyVsS4Ien1u32ri1mImyId8Gdczdfb5mc6b6C7fAO1W0tF04KYBSTzUBRSlpJwx/28c9G8Xc0psnw86CzZSL+KbRqMGbK9+EGPpWAbUN7dXUSjYlhcX2SAvu1oCPLbaWbCaafPpuuXhVP68a2Y3+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758720871; c=relaxed/relaxed;
	bh=J9Vr9KY4xbvuuPlwdSJb5M89fpFiaZAEVobis/+vA7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJXCV9KJp+9dly1BHb2eQmDK8kcQuxWFOQ+bplM0X903pv+T9/F7DeBBPB/CpLM++JeNlb0N1SBHF7JU50WrN8bMKiwGn+EORWUlBjOiRdisnVDLGhkmBPTV16CgvDzO9Ir9Y73mb1LWskP29QxpJ5Q0sa/GS5QPDQjkH/nQahg5V5DZNkmfDI68Qcr1qvkbsXWznVjvys15ruxxI7birrzSyVAoa1ljEqZe8LUZPalvheUMmqirlZx7EZ4/4HrF7ztDJInHdPsmSHYEitoGWvNNdyqBIhb6rFRz3wsOlxG/xLCU5lnPHix1l7ih9Mo1nDVX0mB1tkQV1/akCdRH4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tK4g8xF3; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tK4g8xF3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=robh@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cWyWB2Qnzz2yqP
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Sep 2025 23:34:30 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id EE19243CA5
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Sep 2025 13:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC4FC4CEF7
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Sep 2025 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758720867;
	bh=3Z6XTJa/2I09pYSflW4MDbMqly8jjfPgHvxuTYEtOvk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tK4g8xF3KJeMYnB9VZ4gO8VRMtQvT117WCk3DHhVlEegaKquqejM1Ot5xjEhSSEOK
	 43WmDcGlPeFBVd6oCpGsmL+8tu5/12oZs4cT3CBOvCTcpV/9ieFFCe0OnqgT5j3e+E
	 kamp4muCI1+ku/3UZUUk43jADlPfZFB/OGQbWFEL1yIieBn5z+BjOVZvX1yaSW2VRG
	 8hor0XFKZBCNhDYppKwVU3Vmmj4G7OBcqnycvEma7dxeTlVQ9NQ7zdf/KO//cZhphQ
	 zs6/ZVsvHe5w9Ygt933ZX8EDJqUdOzRtNRnuAu0X9OGJH948CqCf7TfTwDLEtb4W2w
	 atUla77I4Zl5A==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63491fc16c3so481452a12.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Sep 2025 06:34:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXKDNI31P5RrL+Ou4HXRylsOYyT+u0I760cjIzHlqk8gbQgepRIBlFHFHcl9Y1emfx68tEgbrc5qarbdiM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyHLwqIWOj3M4Mro79YCGvcchwC3EHvsqUa/bYiWOhg19rfeYfZ
	8cfLrHgmxGPitjELbQzG4iWSXoXW0thRU8nGJ1K8LIntmMhImujtvHcLHFTrkYmeH3QhC6d1+Zs
	0Czpqs+urgY0RWHvcninLnCUm8KLb4w==
X-Google-Smtp-Source: AGHT+IE6gNa61RcE9DKf2iXVRg4jwELeBK0rbWB2RUsPPFiJAgwlJN43oTxNrNqM4YRqC7tDc6X2gwE56i96k2A7jt0=
X-Received: by 2002:a05:6402:a00e:b0:62f:b6bd:eff7 with SMTP id
 4fb4d7f45d1cf-63467813addmr5004269a12.38.1758720866242; Wed, 24 Sep 2025
 06:34:26 -0700 (PDT)
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
References: <20250917074812.4042797-1-kevin.tung.openbmc@gmail.com>
 <9bb9929a-8130-48da-983e-2901a7c3da36@lunn.ch> <CABh9gBew1=hbJvg1Mhg5dE7Lr_Z442_kbBX6zTs_6_C2NRyLbw@mail.gmail.com>
 <7e6f568da28d7a63738b6ed22b33db3df4c478c9.camel@codeconstruct.com.au> <CABh9gBcoWbXurPo0f9U9+gz8k6gttUvj=NMMDVfgjo5dgaTLSA@mail.gmail.com>
In-Reply-To: <CABh9gBcoWbXurPo0f9U9+gz8k6gttUvj=NMMDVfgjo5dgaTLSA@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 24 Sep 2025 08:34:15 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+zBK1CBJX0XcaqaYeOPUhoRE-nMeYvkTNwQovJ+dakGg@mail.gmail.com>
X-Gm-Features: AS18NWBRbwk465MJYJkBc3f6vXfBHLpagMAmj_NyZMMJpbB87hfWSByQAiUtoWU
Message-ID: <CAL_Jsq+zBK1CBJX0XcaqaYeOPUhoRE-nMeYvkTNwQovJ+dakGg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add Meta (Facebook) Yosemite5 BMC (AST2600)
To: Kevin Tung <kevin.tung.openbmc@gmail.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, Andrew Lunn <andrew@lunn.ch>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 8:05=E2=80=AFAM Kevin Tung <kevin.tung.openbmc@gmai=
l.com> wrote:
>
> On Mon, Sep 22, 2025 at 10:47=E2=80=AFAM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >
> > On Thu, 2025-09-18 at 10:21 +0800, Kevin Tung wrote:
> > > On Wed, Sep 17, 2025 at 11:12=E2=80=AFPM Andrew Lunn <andrew@lunn.ch>=
 wrote:
> > > >
> > > > On Wed, Sep 17, 2025 at 03:48:08PM +0800, Kevin Tung wrote:
> > > > > Summary:
> > > > > Add device tree for the Meta (Facebook) Yosemite5 compute node,
> > > > > based on the AST2600 BMC.
> > > > >
> > > > > The Yosemite5 platform provides monitoring of voltages, power,
> > > > > temperatures, and other critical parameters across the motherboar=
d,
> > > > > CXL board, E1.S expansion board, and NIC components. The BMC also
> > > > > logs relevant events and performs appropriate system actions in
> > > > > response to abnormal conditions.
> > > > >
> > > > > Kevin Tung (2):
> > > > >   dt-bindings: arm: aspeed: add Meta Yosemite5 board
> > > > >   ARM: dts: aspeed: yosemite5: Add Meta Yosemite5 BMC
> > > >
> > > > The threading between your patches are broken? How did you send the=
m?
> > > > git send-email? b4 send?
> > >
> > > Yes, the threading is broken. I initially used git send-email, but fo=
r
> > > some reason, only the cover letter was sent. I then sent the remainin=
g
> > > dt-bindings and DTS patches separately as a follow-up.
> >
> > I recommend using b4, it helps blunt some of the sharp edges of git-
> > send-email.
> >
> > https://b4.docs.kernel.org/en/latest/
> >
> > Can you please send v2 of the series so that it's properly threaded,
> > after applying tags you've collected for the involved patches, and
> > checking your work with `make CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook=
-
> > yosemite5.dtb`?
> >
> > Andrew
>
> Sure! I have sent v2 of the series using b4, and the patches are now
> properly threaded.
> I also checked the work with `make CHECK_DTBS=3Dy
> aspeed/aspeed-bmc-facebook- yosemite5.dtb`,
> and the warnings that appear are not related to these patches.

Um, they are related because they are warnings for *your* platform.
You don't care that there are warnings for your platform?

Rob

