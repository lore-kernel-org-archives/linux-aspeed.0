Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204B606A31B
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Nov 2026 11:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=F+Hs7Zkl
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKNLs5jCfz2xSF;
	Wed, 04 Nov 2026 22:21:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a0a:edc0:0:b01:1d::107" arc.chain=pengutronix.de
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793791317;
	cv=pass; b=KOz0geXEWH316UjATy9GMKtwMyzeXPWS5190rtWGhyAvtbUP8PIHiHG0EBLuvYknNdvHx//7dQ0CoXGZHlWdUG3Hf3PlW5nBjsHcuKlUSIe/Xyn8FikQJbJyUzF5HR9azUYc13n1hzine5nIregShxrB4x45kQ5drb1u17zcsBtxFST1MrlR3rZaY9YTQQMsUFcit+CDQoCjQvVdfHeDfbCJz2yCqYIJ8wndYJNLNZnUUvxZd1rwdD/a09sGibErQDc7jpaJbFXa0nZUuYF4O4cIEs5Jyy0HpidapA8B3xKafgxJ9dHH6HHaXbel2+Ldp5yoJyGDM+4Vjoj1B5zq/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793791317; c=relaxed/relaxed;
	bh=cdadhiwqFD1XQPwZ7A8u+lLGgi3X6HTFVWqBQeJs09g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j5TyyPy9/seXU2pf04YLN4oNIudtyufwGCXExDAVuV2VOY9aG2DSIL6gCTXemiFyXxfPJl37j+2E4+ZfAMylG7Jo+L3qNdsEjUvObg0YLq+G9OpQWdFjDypXv5Igbj6ExdMKnWW9Ez+ZMeqBba19CoeERXKw8otX/CMB1gtJAYI2P6PebRsPgo6OkesGLnQiUbyTx3dKytuP82NKSa9WQzGVGN7k2dPzFwsDNdGqB6gJwNbet2wCOgw3wR9aZHcVFBR1Qcx94bygxaupBBParPGL9YIfa1pT0AZfPuUT9DWU1tH6gXy/SpfNijoV2MgzyOanv+LIEftHl8K/o2ljpw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; dkim=pass (2048-bit key; unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=F+Hs7Zkl; dkim-atps=neutral; spf=pass (client-ip=2a0a:edc0:0:b01:1d::107; helo=mx1.white.stw.pengutronix.de; envelope-from=p.zabel@pengutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=pengutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=F+Hs7Zkl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pengutronix.de (client-ip=2a0a:edc0:0:b01:1d::107; helo=mx1.white.stw.pengutronix.de; envelope-from=p.zabel@pengutronix.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 409 seconds by postgrey-1.37 at boromir; Wed, 04 Nov 2026 22:21:54 AEDT
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [IPv6:2a0a:edc0:0:b01:1d::107])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKNLp5kvrz2xNC
	for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Nov 2026 22:21:54 +1100 (AEDT)
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de [IPv6:2a0a:edc0:0:900:1d::4e])
	(Authenticated sender: pza@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 83A95202292;
	Wed, 04 Nov 2026 12:14:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793790891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdadhiwqFD1XQPwZ7A8u+lLGgi3X6HTFVWqBQeJs09g=;
	b=F+Hs7ZklKQA+hKlTabYnteiaJVNueYAugR1Q/qUI4xLuMqHhAdmpZGVjaH6yHrM4NYCLcn
	79lIsxaNCFCGXC7AlfZCuEs+mULGPCZgChO2RTN3l+9VunkAcERhjvB4k4AiwawNyZPBeG
	LO9Ol0SzfKhU1OWFCW5E243yUgUrlVF6H34sSHnEF57Bn9wS3wqo+THnyuGkQ4IfDFbEaz
	mcxEiodBVjXwyJWyuVTue8+101f37igg/urP469Iopbq6qXcN5oQmlH9ZK4jYpRpUwiRBn
	ldUqxa1Q2uVT0HLHy9PTEjQ4vdi9S10fS9frWQ4Y7ECwG6vQv+7gBUDMrjtzBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793790891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cdadhiwqFD1XQPwZ7A8u+lLGgi3X6HTFVWqBQeJs09g=;
	b=RPOIuofdMmzWOeqvJTQfIBxki9Kuz0qF73e4Tz3f1fJHNoGvbtSH/251M9Q5dfMkUh3iiA
	1/ZWwAN1uP1gtcwOjnay2sCZ6VrclDEIHnGnMjrVvWvYiSMVWodiCg9B+/Y7Qo0KWOcm6D
	dAhILaJgg5IxmlMJIwY69CltaZJAvAvedHOsTXt0EN0DwoIVm2ZBqBYjiuBBFoRc3tKIM+
	Ce/Dk5zNe0KYgwhHe1p9alAU8c+32Onh6NHSmuBsEwAY/1nfr5CZ9+YjkODlskgpYYOu38
	MemSh/+rsRShG1D2csJ1roaT4lBpvYWzIzXyVZk7IHKN61ZbkMI45PEac7Mf5w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793790891; a=rsa-sha256;
	cv=none;
	b=LP2/0w7Mgi15Aj5Pov2DLRSqEo7VTVEY2F8tfQYnnX3md6Ij43w5VgzDFf4uqgV8jTqG3O
	0nlSa9wNjgqUAi6Xv8mKlsF0/v90NsmTZQIHwNddtSoWyItdYhIESMslX8PrFCvPeVUCj9
	AubOLcI+VaiZSaZtH07cNUjJBXpHN1VvHysAKLkcjHefA0rTZu4VUR5oY8IeHWapk878wv
	2Q3/4FB6W+Wq88bl4SHnDjU3XrdGh+WGUcZW4K89ipi+N8TmZwS3ANAJ3R+9lGuPFDXN6b
	/xWd++Aetvcu90FyfexnmRwjDncJcBugmdlX7YBHxmwdkNB04ckjAuo4kVlSAw==
Message-ID: <f0633026a1ae251715af3c7323fcfd26e96ffaab.camel@pengutronix.de>
Subject: Re: [PATCH 5/8] i3c: mipi-i3c-hci: Add support for the AST2700 I3C
 controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Billy Tsai <billy_tsai@aspeedtech.com>, Alexandre Belloni
	 <alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	 <andrew@codeconstruct.com.au>
Cc: linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 04 Nov 2026 12:14:51 +0100
In-Reply-To: <20260901-b4-i3c-hci-ast2700-v1-5-19909e7cbd7e@aspeedtech.com>
References: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
	 <20260901-b4-i3c-hci-ast2700-v1-5-19909e7cbd7e@aspeedtech.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Di, 2026-09-01 at 19:35 +0800, Billy Tsai wrote:
> The AST2700 I3C controller carries an ASPEED vendor extended
> capability describing an in-house control block and a PHY programming
> window. Recognize the ASPEED MIPI vendor ID in the extended capability
> parser and cache both register bases via the generic vendor_data
> pointer, which other vendors (e.g. NXP) also populate; add is_aspeed()
> to identify ASPEED specifically.
>=20
[...]
>
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> Assisted-by: Claude:claude-fable-5

Drop, see 1e035297ffda ("docs: remove Assisted-by references").

> ---
>  drivers/i3c/master/mipi-i3c-hci/Makefile        |   2 +-
>  drivers/i3c/master/mipi-i3c-hci/cmd_v1.c        |  21 +++
>  drivers/i3c/master/mipi-i3c-hci/core.c          | 175 ++++++++++++++++--
>  drivers/i3c/master/mipi-i3c-hci/ext_caps.c      |  15 ++
>  drivers/i3c/master/mipi-i3c-hci/ext_caps.h      |   1 +
>  drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.c | 234 ++++++++++++++++++=
++++++
>  drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.h | 174 ++++++++++++++++++
>  7 files changed, 606 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/=
mipi-i3c-hci/core.c
> index 2290a889701cd..e0ee8148aa2f8 100644
> --- a/drivers/i3c/master/mipi-i3c-hci/core.c
> +++ b/drivers/i3c/master/mipi-i3c-hci/core.c
[...]
> @@ -1146,10 +1235,17 @@ static int i3c_hci_init(struct i3c_hci *hci)
>  	return i3c_hci_reset_and_init(hci);
>  }
> =20
> +static void i3c_hci_dma_rst_assert(void *data)
> +{
> +	reset_control_assert(data);
> +}
> +
>  static int i3c_hci_probe(struct platform_device *pdev)
>  {
>  	const struct mipi_i3c_hci_platform_data *pdata =3D pdev->dev.platform_d=
ata;
>  	struct clk_bulk_data *clks;
> +	irq_handler_t irq_handler;
> +	unsigned long irq_flags;
>  	struct i3c_hci *hci;
>  	int irq, ret;
> =20
> @@ -1176,8 +1272,12 @@ static int i3c_hci_probe(struct platform_device *p=
dev)
>  	}
> =20
>  	platform_set_drvdata(pdev, hci);
> -	/* temporary for dev_printk's, to be replaced in i3c_master_register */
> +	/*
> +	 * Temporary for dev_printk's and is_aspeed(), both replaced with
> +	 * the real values by i3c_master_register().
> +	 */
>  	hci->master.dev.init_name =3D dev_name(&pdev->dev);
> +	hci->master.dev.of_node =3D pdev->dev.of_node;
> =20
>  	hci->quirks =3D (unsigned long)device_get_match_data(&pdev->dev);
>  	if (!hci->quirks && platform_get_device_id(pdev))
> @@ -1189,6 +1289,40 @@ static int i3c_hci_probe(struct platform_device *p=
dev)
>  					     "cannot set DMA mask\n");
>  	}
> =20
> +	if (is_aspeed(hci)) {
> +		struct aspeed_i3c_vendor_data *vd;
> +
> +		vd =3D devm_kzalloc(&pdev->dev, sizeof(*vd), GFP_KERNEL);
> +		if (!vd)
> +			return -ENOMEM;
> +		hci->vendor_data =3D vd;
> +
> +		vd->rst =3D devm_reset_control_get_optional_exclusive(&pdev->dev, "cor=
e");

vd->rst is only ever used in i3c_hci_probe(), this could be a local
variable.

> +		if (IS_ERR(vd->rst))
> +			return PTR_ERR(vd->rst);
> +		ret =3D reset_control_deassert(vd->rst);
> +		if (ret)
> +			return ret;

Is the core reset never asserted again on purpose? Otherwise you could
use devm_reset_control_get_optional_exclusive_deasserted() to simplify
this.

> +
> +		vd->dma_rst =3D devm_reset_control_get_optional_shared(&pdev->dev, "dm=
a");

vd->dma_rst is only ever used in i3c_hci_probe(), this could be a local
variable.

> +		if (IS_ERR(vd->dma_rst))
> +			return PTR_ERR(vd->dma_rst);
> +		if (vd->dma_rst) {
> +			ret =3D reset_control_deassert(vd->dma_rst);
> +			if (ret)
> +				return ret;
> +			ret =3D devm_add_action_or_reset(&pdev->dev,
> +						       i3c_hci_dma_rst_assert,
> +						       vd->dma_rst);
> +			if (ret)
> +				return ret;

This looks like it can be simplified with
devm_reset_control_get_optional_shared_deasserted().

> +		}
> +
> +		vd->clk =3D devm_clk_get_optional(&pdev->dev, NULL);
> +		if (IS_ERR(vd->clk))
> +			return PTR_ERR(vd->clk);
> +	}
> +
>  	ret =3D devm_clk_bulk_get_all_enabled(&pdev->dev, &clks);
>  	if (ret < 0)
>  		return dev_err_probe(&pdev->dev, ret,
[...]
> diff --git a/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.h b/drivers/i3=
c/master/mipi-i3c-hci/vendor_aspeed.h
> new file mode 100644
> index 0000000000000..8760384d1c6f5
> --- /dev/null
> +++ b/drivers/i3c/master/mipi-i3c-hci/vendor_aspeed.h
> @@ -0,0 +1,174 @@
[...]
> +struct aspeed_i3c_vendor_data {
> +	void __iomem *inhouse_regs;
> +	void __iomem *phy_regs;
> +	struct reset_control *rst;
> +	struct reset_control *dma_rst;

These two don't seem necessary.

> +	struct clk *clk;
> +};
> +

regards
Philipp

