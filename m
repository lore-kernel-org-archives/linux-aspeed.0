Return-Path: <linux-aspeed+bounces-587-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E90FC0218A
	for <linux-aspeed@archiver.kernel.org>; Thu, 30 Jan 2025 05:32:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yk7206LHLz303K;
	Thu, 30 Jan 2025 16:32:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738215128;
	cv=none; b=Z+fd1uKjH2ZymoUfI6TGK3HA6eqmij7NlCJC7e6GTbwU64tgY6SD9p1QR6Ae3tAsJFzovKHenyonKvJyY2lStAikTUMA8hhVIfplsdZ79n7wBX20OzFUe/j7T+FvIJfbJWJPI1QtJRgRabkiYxqlpK2y6LCchXBAl2yz64flzJCnVz22l7QumDirBGUEcYzX785ciY1CBiiknjxz1fAbDpE/DZTlcrvZ51AHqEmxqfFjcim2H+Vkei+rxGJMzcpB08cqnACKtrPv2ccuCpy4Agif2qabw8+l1mrnuZIaDliXUUA/z3igftFR2kmeVTchbDdWZIgyvAmc9f3oHsBTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738215128; c=relaxed/relaxed;
	bh=gFQ7g+YN21EUHYN7l+aFFtAggeW26EdwSPTQBPw5JIA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nOtM0L1TahHpQX5Gm3oisAhPOiN0lnFzkSEUomlit5HbPdYkMdDC5vMzkeUWDy1Y9aeHDDNfrqKQ89bJezmSERgnLkSlztT/UBbpo0J+JSfbdSx1vm1eFPZcH1Nx4lIY/84FFUgXXT8y+8WFPVBMzyHQOMa8JgyVLJee0z37Xj7uLymx9vCrnXnDRu4LJhVeQtU6sdFGmMtraTDAKRTCfU2yDqItxtU98fK8B1zdLXzxj9T5dEc1ZCVkB7CBIPJ65pol0nddP4b9sM96VeDdsLMcl2ETVm0kqsy1YwXfOv7u6XNC5sd4cn8qrYUY4VYG3gRNoFnpZMp63eG87Kf8dg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LlkoPShM; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LlkoPShM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yk71z6RZtz302c
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Jan 2025 16:32:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738215126;
	bh=gFQ7g+YN21EUHYN7l+aFFtAggeW26EdwSPTQBPw5JIA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LlkoPShMIY3IbkAOzb1KgLzgG8YOLulzUiA6dqoqMW35xYM1vY4FUxuyCclGILpYC
	 IJdPkr0eO2aU1S4RZJ82yPuiFDJg5q2lE1bfAyD+54vhNauy/40V0JqAiOYMuAxYT/
	 Q2k+tCOwgqrz3bJvt6XPO1WtELw104gr2JBqDUcfgndWOAnOkSOG1gA3spVGBKw2X1
	 9aURVXj532gT/Q8Joss7WwNumv9lyGY6e597x3LGlGCDJpIVT4x8a5TyuK54JK0ELB
	 enXAG4EEYPp5fOHwx2er0mYGSdpYRP37/eC5/pGcc86wWKG0w6xtA6DqfWNlWyjDAC
	 nRayZo2kLifTw==
Received: from [192.168.68.112] (58-7-158-64.dyn.iinet.net.au [58.7.158.64])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2E8DC73836;
	Thu, 30 Jan 2025 13:32:02 +0800 (AWST)
Message-ID: <daa6bcaf1e612f667c5d5d26b9d515f43985b595.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] drm/aspeed: Use
 devm_platform_get_and_ioremap_resource()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: oushixiong1025@163.com, Joel Stanley <joel@jms.id.au>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>, Shixiong Ou <oushixiong@kylinos.cn>
Date: Thu, 30 Jan 2025 16:02:00 +1030
In-Reply-To: <20250122030155.57802-1-oushixiong1025@163.com>
References: <20250122030155.57802-1-oushixiong1025@163.com>
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

On Wed, 2025-01-22 at 11:01 +0800, oushixiong1025@163.com wrote:
> From: Shixiong Ou <oushixiong@kylinos.cn>
>=20
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to
> devm_platform_get_and_ioremap_resource().
>=20
> Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> ---
> V1 -> V2: Add Missing commit message.
>=20
> =C2=A0drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 3 +--
> =C2=A01 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> index a7a6b70220eb..33f81b53771d 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
> @@ -146,8 +146,7 @@ static int aspeed_gfx_load(struct drm_device
> *drm)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct resource *res;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res =3D platform_get_resource(=
pdev, IORESOURCE_MEM, 0);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0priv->base =3D devm_ioremap_re=
source(drm->dev, res);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0priv->base =3D devm_platform_g=
et_and_ioremap_resource(pdev, 0,
> &res);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(priv->base))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return PTR_ERR(priv->base);
> =C2=A0

I think I prefer this one:

https://lore.kernel.org/all/20250128-cocci-memory-api-v1-1-0d1609a29587@red=
hat.com/

Andrew

