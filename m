Return-Path: <linux-aspeed+bounces-4524-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C4FC4452D
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 07:45:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4mWl1Bwsz2xpn;
	Wed, 22 Jul 2026 17:45:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784706339;
	cv=none; b=jBI63LFNepwgLiBUFK4lm9XbrgZvCKZySh9kF/XFDte537wvzEjdqA3wfakjteiBorTwvuiBcaET4JRemhB2QsJx/SBdP069yVZcWUa1XXJxSo26jXdmK86bIqZMWdfbjmvYVMzGYdIMQdbuQ7NWgWvplS+D75mK+GR0p/kaJ+RW77inUi3sIcwrRBLYZ1JtW8Ft7/Z8gi/CvPi7+zyDzHcR9OIbzdMo3S4RClTfqTn2stPAUBjyZYrX2aVtP/xIG2GmUa2T3T+y1ozWAKPi2XAhYnhJzhFhI2A+Z6Rk2Ry+b4+DNrVW0ORu43yuCVxlN6HvX87jfTJWrRl2dqFDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784706339; c=relaxed/relaxed;
	bh=F0DOZ6IJ9ra0/dlBSWtiIdXa1p1W7GVECGzod3oAz00=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y27W191fQxZ5osf6qXVD1/Nt380iuuZagsIxzVGJCmOo3k4Zfpx7vN2GZZNuyPCFOxdMAHrQnIzyoZSua3khZDoa6U5Z1d6GwyuWyMz0pO9Jj7MXcA/sQoDWc/4w+lgM/1Jj3g3sRvR+kjeryi3b3GQ4Llrv1Ru8dI75luxNOU1EOdff5d4Qx2p7uziHmCLwCQrJMcEk3CloEm+owmqnuYOCBerJd69+co7zZaSDhSQXrJ5nJAxxk/ixVg6JiuzUzuqLL2qIAkDsis1prTaDOMUuhWyzv/FaD4Kb3MSOkR9xx+tLSSG76BmEmZidPgzBWGf87Sk5puSqhP1eg464Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=dGfWOxgQ; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=dGfWOxgQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4mWk32Qdz2xJT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 17:45:38 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784706337;
	bh=F0DOZ6IJ9ra0/dlBSWtiIdXa1p1W7GVECGzod3oAz00=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dGfWOxgQM8b6nirRFWRn9PTfUHrA5xIHQZBzIx9qrKgUwiomGtO1iWJ5XwL/JnDo1
	 jg7gjWJfkrUEqXd+2QnhKu8NO1p0ScMontpwibmhx3uTJxzeX+7zwbep6nJZbI9OSx
	 IPO3D0OyTjPs0o7+u/wU6oWLtvSOMfT0xw1pIx0hmHI2tXwJs7xeWkHCz6wtiGehrB
	 E5gCcMaQlYKxVUNZexGGUlPH9+Pp0sQe0kc2jGVhkUPyoA/LH8GgzCtEeCC91xfHjU
	 wIWGUI6OT38gJReLxhRh7NP12NFcRRhypHRQtODNP/yEJI/zK6mu1eNCfwRMlGSyop
	 nQrVYOTMewLAg==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 424E8662E1;
	Wed, 22 Jul 2026 15:45:37 +0800 (AWST)
Message-ID: <b707f061cbdfe52f8d72ccd33ec177113e20a5e5.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3 2/2] ARM: dts: aspeed: Add NVIDIA VR-NVL BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jacky Huang <jackyhuang@nvidia.com>, joel@jms.id.au, robh@kernel.org, 
	krzysztof.kozlowski@oss.qualcomm.com, conor+dt@kernel.org, andrew@lunn.ch
Cc: devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org
Date: Wed, 22 Jul 2026 17:15:36 +0930
In-Reply-To: <20260710054849.3178747-3-jackyhuang@nvidia.com>
References: <20260710054849.3178747-1-jackyhuang@nvidia.com>
	 <20260710054849.3178747-3-jackyhuang@nvidia.com>
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

Hi Jacky,

On Fri, 2026-07-10 at 14:46 +0900, Jacky Huang wrote:
> Add the device tree for the Aspeed AST2600 BMC for NVIDIA's Vera
> Rubin NVL compute platform.
>=20
> MAC0 uses phy-mode =3D "rgmii-id" because the on-board PHY supplies
> both RGMII internal delays.=C2=A0 The matching U-Boot device tree does no=
t
> enable SoC-side MAC clock delays, leaving the MAC internal delay at
> zero so the PHY-provided delay is not doubled by the MAC controller.
>=20
> The corresponding U-Boot change has been submitted to openbmc/u-boot:
> Link: https://lore.kernel.org/all/20260629105202.1417679-1-jackyhuang@nvi=
dia.com/
>=20
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Jacky Huang <jackyhuang@nvidia.com>
> ---
> v3: reword the &mac0 comment per Andrew Lunn's feedback.
>=20
> =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0.../aspeed/aspeed-bmc-nvidia-vr-nvl-bmc.dts=C2=A0=C2=A0 | 901 +++++=
+++++++++++++
> =C2=A02 files changed, 902 insertions(+)
> =C2=A0create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-vr-nv=
l-bmc.dts

We now have scripts/dtc/dt-check-style, and going forward I'm asking
that all new devicetree submissions pass in strict mode.

Currently:

   $ ../scripts/dtc/dt-check-style --mode strict ../arch/arm/boot/dts/aspee=
d/aspeed-bmc-nvidia-vr-nvl-bmc.dts 2>&1 | wc -l
   152

Can you please address those?

Andrew

