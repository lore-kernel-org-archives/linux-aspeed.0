Return-Path: <linux-aspeed+bounces-3776-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0806C109E553
	for <linux-aspeed@archiver.kernel.org>; Thu, 26 Mar 2026 06:07:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhCxP4YNqz2xlM;
	Thu, 26 Mar 2026 17:07:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774505273;
	cv=none; b=Rhmm8vfyzL//60evET77Ol/u9xLp5Au9du7BFL942YgWC2BnKCh91+oZzboLXvxBLJLwGU/RFKMJe5PsdafxeZjw/hCnvn4+eFxbzmrmqjWoum/g/OWdMJOoSpdLhoMu4SlwlZeJwYg0Epw0YQdppIZ/GY+mhpxa6HXxpjN3PBoHdm9fYvW1prCv18Bky2yoIrjnNg706PA8+CANpU9OGFeOBqB+yQu1y0/0Ll1UyVBsUnapfUlTa0FiGRdhR2Z5Z7h0ZV84GwOn1B5UToz4K1aDmVTGfrZHiIBRQ0FnlmYbIv7DLp11ntKQUBc0pREeZsGLmNYaD8M9a0gNAkzdHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774505273; c=relaxed/relaxed;
	bh=D4BWqwsowftV0uLn6UqEICU6dheuLBTYAGw06kSQO3c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ooMonPmVLvn7MoPHkVzm4hlUyRMEqL9cBxit60eospJqswG2MKUnWXLzwuTucYAXmJMkGjP7EpBWTW9p3VPp/rjUnJ26SND2w0U2teinlI7d7QJSJQSOLFu5E2iItdgq7kaUshMBVEJfm5E+sIKCJroImwVhwnugaLXfMJ/BANeoA5twNWXm/evseelxL1KjpQ4X7GMOg6ZfIcgsT2k+kbsoTLBG7auwnX3i8ZEsh2qJ1/7wmibXlwL9BZVP1sxHIurMg8EIp4VkluenlAT4eh9Rq4eMtVuN7/NR1ooNNXExmQZOeQ9OyzP40hSAYtChac541OpNL7FDKHZDJSE6IQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=khH2mG+u; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=khH2mG+u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhCxN66rQz2xd6
	for <linux-aspeed@lists.ozlabs.org>; Thu, 26 Mar 2026 17:07:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774505272;
	bh=D4BWqwsowftV0uLn6UqEICU6dheuLBTYAGw06kSQO3c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=khH2mG+uBGCYkDqfbI4rBOR+DTt4gDN3awebhhzeDtW0i7D3pFkiOjQbFbo4FjsfX
	 hFlHdj8si7MP1DHnhNbUp3N8c2TsJISpuRilYRg/TpM4rP2me+OoPSM02N69Rh1djq
	 w2M2xXTnQquI/E9IkIhPLX0NXuMtf8GYQbNRPkvyoCkAR4on53/sA7OvI2W66kesbB
	 p1xejc2yVcKPEt1JaD05UqQ9f6ihO5wmxvFWc4QO9pt7c/lf7c9U9JSwiZhVyxk8Yo
	 jYeLz1YCr2Tpx92RMhR2xapSSlCKX0dGwldW/Pwbg8ubyoDFQ1lAR4z8aPKRFs9aHv
	 d1mRbsa8jIfuQ==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7CDF76597C;
	Thu, 26 Mar 2026 14:07:51 +0800 (AWST)
Message-ID: <d7794f74b26bbc1ee0a70e39c5671acc018f80eb.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 2/8] ARM: dts: aspeed: yosemite5: Remove ambiguous
 power monitor DTS nodes
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, 	linux-kernel@vger.kernel.org, Amithash
 Prasasd <amithash@meta.com>, Kevin Tung	 <Kevin.Tung@quantatw.com>, Ken
 Chen <Ken.Chen@quantatw.com>, Leo Yang	 <Leo-Yang@quantatw.com>, Jackson
 Liu <Jackson.Liu@quantatw.com>, Daniel Hsu	 <Daniel-Hsu@quantatw.com>
Date: Thu, 26 Mar 2026 16:37:51 +1030
In-Reply-To: <CABh9gBd3b9TB1-s=Gq1q-M8bX+4UioXePUF0DPVrU2N3N8S9yw@mail.gmail.com>
References: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
	 <20260223-yv5_revise_dts-v5-2-fc913e902488@gmail.com>
	 <73ea41bf341df0e3215c58a029c9ea2386c4ef8a.camel@codeconstruct.com.au>
	 <CABh9gBd3b9TB1-s=Gq1q-M8bX+4UioXePUF0DPVrU2N3N8S9yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

Hi Kevin,

Sorry for the delay.

On Mon, 2026-03-09 at 11:41 -0700, Kevin Tung wrote:
> On Tue, Mar 3, 2026 at 6:41=E2=80=AFPM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
> >=20
> > Hi Kevin,
> >=20
> > Sorry for the patchy replies so far, but this series bothers me and
> > other priorities keep bumping it down the list.
> >=20
> > On Mon, 2026-02-23 at 19:17 +0800, Kevin Tung wrote:
> > > Two different power monitor devices, using different drivers, reuse
> > > I2C addresses 0x40 and 0x45 on bus 10 across Yosemite5 board variants=
.
> > > Defining these devices statically in the DTS can lead to incorrect
> > > driver binding on newer boards when the wrong device is instantiated.
> >=20
> > There are effective methods of maintaining devicetrees for variants.
> > Why are we choosing to remove information about the platform rather
> > than use existing techniques to properly describe them?
> >=20
> Hi Andrew,
>=20
> This is due to hardware design changes during earlier development
> stages, and the fix is expected to remain stable as the design has
> matured.
> Could you guide me on the best way to maintain devicetrees for
> variants? Thank you :)

My expectation is your platforms move through several design phases
prior to (mass?) production. My suspicion is that you have sent a
devicetree for the pre-production design phases, and you're trying to
evolve that one devicetree to match the design for whatever current
phase you're in.

So, ideally: Send a devicetree only for the finalised design. Don't
send devicetrees for pre-production designs.

If you feel you can't do that for some reason, an alternative is to
have a separate .dts file for each phase in the design process.

This may sound tedious but it doesn't have to be a burden to maintain.

For instance, you can use one or more .dtsi files to describe the
common components and relationships for your platform. These .dtsi
files are then #included into .dts files as usual. Often .dtsi files
are used to isolate different hardware scopes (SoC vs board, for
instance), but we're not limited to that, we can use them for the
purpose outlined above too.

If there are only (very) minor differences, there's also the option of
#including another .dts file. From there you can adjust properties or
even delete nodes where it makes sense. For example, we maintain a .dts
file for the latest revision of the AST2600-EVB, but we also have a
separate .dts for the A1 revision with a different regulator setup:

- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/arm/boot/dts/aspeed/aspeed-ast2600-evb.dts?h=3Dv7.0-rc5
- https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/a=
rch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dts?h=3Dv7.0-rc5

Any of these are better options than this current approach of trying to
justify incompatible changes against unclear design boundaries.

Andrew

