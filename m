Return-Path: <linux-aspeed+bounces-1482-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B9FC71155
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Jun 2025 13:39:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bLWMW6VpMz30RN;
	Mon, 16 Jun 2025 23:39:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:edc0:2:b01:1d::104"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750081191;
	cv=none; b=Ji04V+uIsPdYpioUMHZybLidV7dQUAUKNK0sLuokTw3o2k53Q9GBclpov803Mr+XLVmw0Xs67KMDkX8GEWgdHN2pSBfRk5MEi1MbYOF5dBQHpxRNkwbQpri4y17liQPH1I5j5UqNAktHMg5h2+TiXgsfEfgLAhYzK7mIVtN/JVivZCuQ4eAI2xBt3yeX64KjSvKmGyzUw2N93Ti5PB0txOmO+7I45XAyudrjzCFa9imV5j/ldLQNp8ecEOL6wyWZzVX1butR1Gnz1UwpT3sAS3Jf45aP2BtlXJHVGXecDhduLf7vx6vp51ycwQymLkS7fvgvMefddFR3T0qlN6WU+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750081191; c=relaxed/relaxed;
	bh=duYGcmi4EnfLmnSVWEuzIDTi/3dvghq/BtjYskrpPhY=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eGJ4WpjJ39bQC4r3cLyvcIK95deDlOGzmF2+2siYv1yim46yz6S/tgjKAURnb/aKptHF0tX4HGICSVYVoTfTHb6GEObF9cOi5gdNFoFMzPlKX7bCNqE1oExaiYf0KHCmNCwLY/ys/2I9Zhu8lW4eQCU7AI275EBgb6JxOVWkW6AQPCo2ucbGVYOIYqK9qAUT8gjX8kavlZslG8Td9C1VLt8BDLBuLTnIngPWkFUj//SpMkApuCtrCNLoFE0DHSnjHyePUNq5OUg+sBpRSb1zcRW4BOX/9xEtGLIhV5TlxFslXTz2+BfA1Og3oimMaGWWGJAavxEYi25J2wUbKlBygg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=p.zabel@pengutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=pengutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pengutronix.de (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=p.zabel@pengutronix.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 1029 seconds by postgrey-1.37 at boromir; Mon, 16 Jun 2025 23:39:50 AEST
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bLWMV4t5qz30P3
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Jun 2025 23:39:50 +1000 (AEST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uR9n5-0003xV-Cd; Mon, 16 Jun 2025 15:22:23 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uR9n4-003oWd-0b;
	Mon, 16 Jun 2025 15:22:22 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uR9n4-000VBo-0L;
	Mon, 16 Jun 2025 15:22:22 +0200
Message-ID: <6aeab5e5b616b1e690c2622d6599c5228a391e69.camel@pengutronix.de>
Subject: Re: [PATCH 1/8] mmc: sdhci-of-aspeed: Fix sdhci software reset
 can't be cleared issue.
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Cool Lee <cool_lee@aspeedtech.com>, andrew@codeconstruct.com.au, 
	adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au, 
	linux-aspeed@lists.ozlabs.org, openbmc@lists.ozlabs.org, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 16 Jun 2025 15:22:21 +0200
In-Reply-To: <20250615035803.3752235-2-cool_lee@aspeedtech.com>
References: <20250615035803.3752235-1-cool_lee@aspeedtech.com>
	 <20250615035803.3752235-2-cool_lee@aspeedtech.com>
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
Precedence: list
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-aspeed@lists.ozlabs.org

On So, 2025-06-15 at 11:57 +0800, Cool Lee wrote:
> Replace sdhci software reset by scu reset from top.
>=20
> Signed-off-by: Cool Lee <cool_lee@aspeedtech.com>
> ---
>  drivers/mmc/host/sdhci-of-aspeed.c | 55 +++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-=
of-aspeed.c
> index d6de010551b9..01bc574272eb 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -13,6 +13,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/reset.h>
>  #include <linux/spinlock.h>
> =20
>  #include "sdhci-pltfm.h"
> @@ -39,6 +40,7 @@
>  struct aspeed_sdc {
>  	struct clk *clk;
>  	struct resource *res;
> +	struct reset_control *rst;
> =20
>  	spinlock_t lock;
>  	void __iomem *regs;
> @@ -328,13 +330,58 @@ static u32 aspeed_sdhci_readl(struct sdhci_host *ho=
st, int reg)
>  	return val;
>  }
> =20
> +static void aspeed_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +	struct sdhci_pltfm_host *pltfm_priv;
> +	struct aspeed_sdhci *aspeed_sdhci;
> +	struct aspeed_sdc *aspeed_sdc;
> +	u32 save_array[7];
> +	u32 reg_array[] =3D {SDHCI_DMA_ADDRESS,
> +			SDHCI_BLOCK_SIZE,
> +			SDHCI_ARGUMENT,
> +			SDHCI_HOST_CONTROL,
> +			SDHCI_CLOCK_CONTROL,
> +			SDHCI_INT_ENABLE,
> +			SDHCI_SIGNAL_ENABLE};
> +	int i;
> +	u16 tran_mode;
> +	u32 mmc8_mode;
> +
> +	pltfm_priv =3D sdhci_priv(host);
> +	aspeed_sdhci =3D sdhci_pltfm_priv(pltfm_priv);
> +	aspeed_sdc =3D aspeed_sdhci->parent;
> +
> +	if (!IS_ERR(aspeed_sdc->rst)) {
> +		for (i =3D 0; i < ARRAY_SIZE(reg_array); i++)
> +			save_array[i] =3D sdhci_readl(host, reg_array[i]);
> +
> +		tran_mode =3D sdhci_readw(host, SDHCI_TRANSFER_MODE);
> +		mmc8_mode =3D readl(aspeed_sdc->regs);
> +
> +		reset_control_assert(aspeed_sdc->rst);
> +		mdelay(1);
> +		reset_control_deassert(aspeed_sdc->rst);
> +		mdelay(1);

Why are there delays here ...

[...]
> @@ -535,6 +582,12 @@ static int aspeed_sdc_probe(struct platform_device *=
pdev)
> =20
>  	spin_lock_init(&sdc->lock);
> =20
> +	sdc->rst =3D devm_reset_control_get(&pdev->dev, NULL);
> +	if (!IS_ERR(sdc->rst)) {
> +		reset_control_assert(sdc->rst);
> +		reset_control_deassert(sdc->rst);

... but not here?

regards
Philipp

