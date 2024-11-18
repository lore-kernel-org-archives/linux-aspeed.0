Return-Path: <linux-aspeed+bounces-137-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A00D60CF8
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 Nov 2024 23:05:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XsjsN3LJGz2yT0;
	Tue, 19 Nov 2024 10:05:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1731971144;
	cv=none; b=ZzhoUxiCayP/kr2CmR4BQQK9sf4NxlU6UrmZUfC0PD18tcoBRgFD9LCaAZHEcjNXnsmrZWhEawdQIcu1kW8st9oz+QSFOnsoITriHmMQBn7rPTqO8AT3T7AaTn3r6zRb6dK3e+qcDVyul1UwOxsEkEXmpDH5ObkxRbPoi+amimRhU+9BccTo/y79sE916k6RGE9VqaTgo8/ZZGyJU8uAERFQABWy0wlUFRy822C/+sWsOtmFDD/+WOYfYelBdGxfpci9jvqc4729TmuYtJcqukyhCOiRAz4lfv9QunIEajx3nGQCdeKnffiw6rqieV9uycR/8TlAMw3vChIXC9oMXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1731971144; c=relaxed/relaxed;
	bh=+OxDHwQ+LwgR6Jb7OIDjCgKY879pFmYdyYNHXVCDwog=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=giEBnX9MpPjc3u+dHg35L+fMJ3cc43U1SxM+4WaCX4qixVuQnM4SJGRVFrSM7AmJhSum8zKYszgk2lUPlhhyVh8WjYKAR36OGigHaCXmKoiMVbcPMtPU1RHKX+UfkuEOoCTqLFBpAk/jnVribTT1rbD4AVSnFX+Wwunnr0h21IomxvoC/vsC5etFtN4FzTK3JZaoIYgT3oHCdiQwFjQPdf8/Ru9Yq+41ZwNv8GonRGuIYZwiUgsNZ626Vjau8zasJdf3b3eXm0blz4SwbWWISDcYDzzyB0FBT8nBkiCAq1x4u0+tm12Ntc7m7/8lqD3o5ZVCEKn5yfrrXkwlZ/lXCQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=eQ9tesHA; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=eQ9tesHA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XsjsM5838z2yDl
	for <linux-aspeed@lists.ozlabs.org>; Tue, 19 Nov 2024 10:05:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1731971143;
	bh=+OxDHwQ+LwgR6Jb7OIDjCgKY879pFmYdyYNHXVCDwog=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=eQ9tesHA9Iuny+nyiRBUQMhg56mp5yBbcOvuBP4P9VvuulUB1B9pwUMqTLaOflq0p
	 NWDJi2a7YW8/K7l8nTmi3QzuEmCyzVAwcVp49VZIR81EtCuMPkLpCRzcl753hR29K3
	 pkKEs3a/l2+6kwP9QvQlURg8KqmhuTK1LLZr91FOh4QABe2/a+EO1weSdgRCby8tfk
	 fOIX7v+tKMQ+5Nq+oTf6pZkUJJDlsp/MuGX6FPDmA5JsuS1COoy+NHGiQ+Crb/r28d
	 JtxDWS5h2ntqSglCcnDvK4y4/VHvLEyOOvqX5VqN0cxjOq7hg00ktmJL2gH/j8RhvB
	 T9rwNRyKA6KzQ==
Received: from [192.168.68.112] (ppp118-210-181-13.adl-adc-lon-bras34.tpg.internode.on.net [118.210.181.13])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 76E9668D9B;
	Tue, 19 Nov 2024 07:05:40 +0800 (AWST)
Message-ID: <0d53f5fbb6b3f1eb01e601255f7e5ee3d1c45f93.camel@codeconstruct.com.au>
Subject: Re: [net-next 3/3] net: mdio: aspeed: Add dummy read for fire
 control
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jacky Chou <jacky_chou@aspeedtech.com>, andrew+netdev@lunn.ch, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joel@jms.id.au,  hkallweit1@gmail.com,
 linux@armlinux.org.uk, netdev@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Date: Tue, 19 Nov 2024 09:35:39 +1030
In-Reply-To: <20241118104735.3741749-4-jacky_chou@aspeedtech.com>
References: <20241118104735.3741749-1-jacky_chou@aspeedtech.com>
	 <20241118104735.3741749-4-jacky_chou@aspeedtech.com>
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

Hi Jacky,

On Mon, 2024-11-18 at 18:47 +0800, Jacky Chou wrote:
> Add a dummy read to ensure triggering mdio controller before starting
> polling the status of mdio controller.
>=20
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
> =C2=A0drivers/net/mdio/mdio-aspeed.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/mdio/mdio-aspeed.c b/drivers/net/mdio/mdio-
> aspeed.c
> index 4d5a115baf85..feae30bc3e78 100644
> --- a/drivers/net/mdio/mdio-aspeed.c
> +++ b/drivers/net/mdio/mdio-aspeed.c
> @@ -62,6 +62,8 @@ static int aspeed_mdio_op(struct mii_bus *bus, u8
> st, u8 op, u8 phyad, u8 regad,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0| FIELD_PREP(ASPEED_MDIO_DATA_MIIRDATA, data);
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iowrite32(ctrl, ctx->base=
 + ASPEED_MDIO_CTRL);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Add dummy read to ensure tr=
iggering mdio controller */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(void)ioread32(ctx->base + ASP=
EED_MDIO_CTRL);

Why do this when the same register is immediately read by
readl_poll_timeout() below?

If there is a reason, I'd like some more explanation in the comment
you've added, discussing the details of the problem it's solving when
taking into account the readl_poll_timeout() call.

> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return readl_poll_timeout=
(ctx->base + ASPEED_MDIO_CTRL, ctrl,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0!(ctrl & ASPEED_MDIO_CTRL_FIRE=
),

Cheers,

Andrew

