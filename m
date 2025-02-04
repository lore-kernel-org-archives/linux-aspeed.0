Return-Path: <linux-aspeed+bounces-627-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2FAC0218F
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Feb 2025 04:33:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yn9Tp58ryz2yZ4;
	Tue,  4 Feb 2025 15:33:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738643598;
	cv=none; b=XVaHh1Q3W/Bxzs5iPexh8HGyt7n4U2WEsggqM5a/5SgXzCyPHP6041VqqpUVvisqgGZahNhpdhd/3P+7wZcJZ7comFdEwWXyU11sqPJCBlHth5w6O14dH5tW6OA/RWcoTzJxC5OlqSYkDnRgYSKhaPOLtrp4aRZSpSNkwSwyoKKsI7B2bP88PPxndp7UWwSbMMNsxXYknIzl4EIzB65bKSY0vMYMQE4xaJz6HwL7cu2Qu2seHjeB+F8Uf55zJ6wgPqvXqYQI0nrt4PqthF/Ayhi5Rd4djYqEQjxAJh+q6DObwY+5gmHN5C6ToFazcwWglqiyVQtAldKgkhvKtqKi4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738643598; c=relaxed/relaxed;
	bh=OVO7pPvS9it63pRV7s9Xy2kC4yPGFJZs59pPpi//UPs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hjm82tSGTMsmQ17EJ91sH7VdYDrcrBQURp4aQTI0Jw1EhYrTVpj3IL2hKfH/7uvazRBEgca+iZ7rDFCIE2BCHLSO+k+T6bxgAlQrqIU6UZyr4M35XWSTNeowuJsv/AXFtCCFxam9w+BFekDWJkoqpwVUyELcRRh7GwsYar5CSYyKOf36WMsYRmZDQfV5ID20uuX+6rKWm1pVyYEg1Pdm7QitjVbvmAE32Tm3gjGFklop2LH6qtMEKRhmxqgduXv81ROLG8UjplSgMZ3xYsB1AyHHGBDivNs3C/eljn3oUJsdDuccod4ygH2BGZhYTc5H3mI/NpDK14Gl2RYhe5TbdQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=AZ5+ijlK; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=AZ5+ijlK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yn9Tp1Wqdz2xs7
	for <linux-aspeed@lists.ozlabs.org>; Tue,  4 Feb 2025 15:33:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738643597;
	bh=OVO7pPvS9it63pRV7s9Xy2kC4yPGFJZs59pPpi//UPs=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=AZ5+ijlKDQgxKTEifzz0lMAm8+CID+Vq9cW8amOSUOU2Lnrbgnn+RCsZMj1J/bF9P
	 IXpGFNm7WoQQrR5ryZs0gtv7IJQ3SiM/fDn72Ih4I/3VGF2Bp/MKobboggFt1+xwPE
	 20bsV5MIrHoCNcVNagNJVt72f4eopKbWzvG+eqWWe7fsd1hDwWs7vJFg5vOctzsb2t
	 gUfSqg0iYSd5RlppAuDM2qcmEB8YxwbJspydO//mUNV6Xhu+4fceeckJJy3Mn7gSUv
	 EtsHS5/nOLzIYgNbpyy78UmaGA5ttbtGugGQBuhz2hKfevC4/FMBLMO1bOPGqqbJV2
	 T3oJaaY0oFD8A==
Received: from [192.168.68.112] (58-7-156-140.dyn.iinet.net.au [58.7.156.140])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D96DD734A6;
	Tue,  4 Feb 2025 12:33:13 +0800 (AWST)
Message-ID: <79b819b6d06e3be0aa7e7f6872353f103294710c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v7 0/9] DTS updates for system1 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Ninad Palsule <ninad@linux.ibm.com>, brgl@bgdev.pl, 
 linus.walleij@linaro.org, minyard@acm.org, robh@kernel.org,
 krzk+dt@kernel.org,  conor+dt@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  openipmi-developer@lists.sourceforge.net,
 netdev@vger.kernel.org, joel@jms.id.au,  devicetree@vger.kernel.org,
 eajames@linux.ibm.com,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Date: Tue, 04 Feb 2025 15:03:13 +1030
In-Reply-To: <20250203144422.269948-1-ninad@linux.ibm.com>
References: <20250203144422.269948-1-ninad@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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
MIME-Version: 1.0

Hi Ninad,

On Mon, 2025-02-03 at 08:44 -0600, Ninad Palsule wrote:
> Hello,
>=20
> Please review the patch set version 7.
>=20
> V7:
> ---
> =C2=A0 - Updated pattern in the ast2400-gpio.yaml
> =C2=A0 - Dropped "dt-bindings: net: faraday,ftgmac100" patch sending it
> =C2=A0=C2=A0=C2=A0 separately.
>=20
> V6:
> ---
> =C2=A0 - Fixed dt_binding_check errors for ipmb-dev.yaml
> =C2=A0 - Changed the hog parsing pattern in ast2400-gpio
>=20
> V5:
> ---
> =C2=A0 - Improved IPBM device documentation.
> =C2=A0 - Added the hog parsing in ast2400-gpio
>=20
> V4:
> ---
> =C2=A0 - Removed "Add RGMII support" patch as it needs some work from the
> =C2=A0=C2=A0=C2=A0 driver side.
> =C2=A0 - Improved IPBM device documentation.
> =C2=A0 - There is a new warning in CHECK_DTBS which are false positive so
> =C2=A0=C2=A0=C2=A0 ignored them.
> =C2=A0=C2=A0=C2=A0 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dtb:
> gpio@1e780000: 'hog-0', 'hog-1', 'hog-2', 'hog-3' do not match any of
> the regexes: 'pinctrl-[0-9]+'
>=20
> V3:
> ---
> =C2=A0 - Fixed dt_binding_check warnings in ipmb-dev.yaml
> =C2=A0 - Updated title and description in ipmb-dev.yaml file.
> =C2=A0 - Updated i2c-protocol description in ipmb-dev.yaml file.
>=20
> V2:
> ---
> =C2=A0 Fixed CHECK_DTBS errors by
> =C2=A0=C2=A0=C2=A0 - Using generic node names
> =C2=A0=C2=A0=C2=A0 - Documenting phy-mode rgmii-rxid in ftgmac100.yaml
> =C2=A0=C2=A0=C2=A0 - Adding binding documentation for IPMB device interfa=
ce
>=20
> NINAD PALSULE (6):

Why is your name all in caps here but not for the binding patches
below? Can you fix that up?

> =C2=A0 ARM: dts: aspeed: system1: Add IPMB device
> =C2=A0 ARM: dts: aspeed: system1: Add GPIO line name
> =C2=A0 ARM: dts: aspeed: system1: Reduce sgpio speed
> =C2=A0 ARM: dts: aspeed: system1: Update LED gpio name
> =C2=A0 ARM: dts: aspeed: system1: Remove VRs max8952
> =C2=A0 ARM: dts: aspeed: system1: Mark GPIO line high/low
>=20
> Ninad Palsule (3):
> =C2=A0 bindings: ipmi: Add binding for IPMB device intf

This one needs an ack from Corey if I'm to take it.

> =C2=A0 dt-bindings: gpio: ast2400-gpio: Add hogs parsing

This one needs an ack from Linus W or Bartosz if I'm to take it.
However, it's also causing some grief from Rob's bot:

https://lore.kernel.org/all/173859694889.2601726.10618336219726193824.robh@=
kernel.org/

As the reported nodes should all be hogs the name shouldn't matter
anywhere else (as far as I'm aware). It would be nice if all the
warnings were cleaned up before we merged the binding update. That way
we don't cause everyone else looking at the CHECK_DTBS=3Dy output more
grief than they already get for the Aspeed devicetrees.

In order to not get bogged down it might be worth splitting out both
the IPMB- and GPIO- related patches like you did the FTGMAC100 patch,
and then I can merge what remains (from a quick look they seem
relatively uncontroversial).

Andrew

> =C2=A0 ARM: dts: aspeed: system1: Disable gpio pull down
>=20
> =C2=A0.../bindings/gpio/aspeed,ast2400-gpio.yaml=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 6 +
> =C2=A0.../devicetree/bindings/ipmi/ipmb-dev.yaml=C2=A0=C2=A0=C2=A0 |=C2=
=A0 56 +++++++
> =C2=A0.../dts/aspeed/aspeed-bmc-ibm-system1.dts=C2=A0=C2=A0=C2=A0=C2=A0 |=
 139 +++++++++++-----
> --
> =C2=A03 files changed, 147 insertions(+), 54 deletions(-)
> =C2=A0create mode 100644 Documentation/devicetree/bindings/ipmi/ipmb-
> dev.yaml
>=20


