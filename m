Return-Path: <linux-aspeed+bounces-1395-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29791C71136
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Jun 2025 07:56:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHvwt4h7Gz2xPL;
	Thu, 12 Jun 2025 17:56:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749714974;
	cv=none; b=GhIksythhyjbBXDsrdUcDjykZiE0CNF2mlS98o7E4mO7RbkfhGtQ2ELYpwaHp7bZBsSw2iEZZziVMrhZNrwoLz2Y7ll2wE0iOSBq5tAjL9KJwDtmi9Pf6icDaY1jqSQyIjbyy2nR0511NLN0ZmL9H2Jb7mf1nM1H1yrcm94+dUziV4Zq6B32CvldQME8es1WBZHCVYUu4U4v7SNWCmF6Ud813ma3IWua0wH3VfObWXAkuvLMloN8/fzESQiy2kHrCrWmGsQwZxPob3cr5+acKVWAZ0D0ZUISbWfvrdGmvdNH/xDpX4/fAh0KTbYmGIN9r3cQFPWrIEoiC7FvdHWycA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749714974; c=relaxed/relaxed;
	bh=wEfLjsMWOcY/1xx1MExuBedf8lJgAMiB/kQuvYjhW5Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SQ7MT3pmqHQP4HQXnLrBZ5k6ImNavifgef3T8IxVktF1RfC2+uPhVE+rpgvgA2kcT3qJSbhadpp7oF0MjWwSODkYyT/KTNJYc2oh+x6jlxRclK6jsZV298Vy3yJl2KC0Z7BzX+3z0I0NSzQSqYFz/eB1JHFjTs8MP3tKxtJAQr/UTIaBrfTGq/5nXQSvbskb0hz7oxLRyhlbHadlVHAYrpY8Ogd2DTEA0zH+JaqKJCZgDka0mFEZ6hDAbn5jegbP/mkMueU+CISppGVX8Izl2QPOwp3+mqH0vWnQVR0o33Si2tJtLXTWJINgvp3Yb5wFr0yjFmRJwOoCJPY4U0XgMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=OrgM7fk2; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=OrgM7fk2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHvwq3rglz2xHT
	for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Jun 2025 17:56:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749714968;
	bh=wEfLjsMWOcY/1xx1MExuBedf8lJgAMiB/kQuvYjhW5Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OrgM7fk2giHneU0ZGmbu6sAUqh0o40hFWABuR8jC1UoQ6AMuK23qacFbdtW1PKj96
	 J0bXtMXgXsKDTVzDwKYXcEhpLrP50g+ShbQsfkkMxa8o0+MRQA30dyAUdwx5bV5urY
	 IEf9R48l50xXY7Sq8MyhKVgJFvd+e9IX2URjPXiU2FW5dMGPcsyhi1gppru8foPSMR
	 cs/Lw/ZYLYUKVpgXJzzimXU+faACgixnOiAMf3b7c3eCIs4mUssVDrJARPgkLRM5H8
	 biL1kpIltutmH3L2Qlyg4zbS7rHVSEFfcQ2dPEqyRAWfNJ8dI9lzlc3lU4jQ4xLde/
	 K8HF2RX7ivetQ==
Received: from [IPv6:2405:6e00:2427:47f7:b08d:7091:d46e:c806] (unknown [120.20.31.221])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EC56B65F91;
	Thu, 12 Jun 2025 15:56:04 +0800 (AWST)
Message-ID: <67c89ca729669f55e2659ad8070a154c59ef83db.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 1/1] ARM: dts: aspeed: Add device tree for Nvidia's
 GB200 UT3.0b platform BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Donald Shannon <donalds@nvidia.com>, robh@kernel.org,
 krzk+dt@kernel.org,  conor+dt@kernel.org
Cc: joel@jms.id.au, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, etanous@nvidia.com
Date: Thu, 12 Jun 2025 17:26:03 +0930
In-Reply-To: <20250611013025.2898412-2-donalds@nvidia.com>
References: <20250611013025.2898412-1-donalds@nvidia.com>
	 <20250611013025.2898412-2-donalds@nvidia.com>
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

Hi Donald,

In addition to addressing Krzysztof's comments regarding checkpatch:

On Tue, 2025-06-10 at 18:30 -0700, Donald Shannon wrote:
> The GB200NVL UT3.0b BMC is an Aspeed Ast2600 based BMC
> for Nvidia Blackwell GB200NVL platform.

Can you add some words contrasting this platform to the one submitted
by Willie?

https://lore.kernel.org/all/20250401153955.314860-3-wthai@nvidia.com/


> Reference to Ast2600 SOC [1].
> Reference to Blackwell GB200NVL Platform [2].
>=20
> Link: https://www.aspeedtech.com/server_ast2600/=C2=A0[1]
> Link:
> https://nvdam.widen.net/s/wwnsxrhm2w/blackwell-datasheet-3384703=C2=A0[2]
>=20

Please omit the blank line here so the Link: tags are part of the
trailer.

> Signed-off-by: Donald Shannon <donalds@nvidia.com>
> ---
> Changes v1 -> v2:
> =C2=A0 - Changed phy-mode to rgmii-id [Lunn]
> =C2=A0 - Removed redundant max-speed for mac0 [Lunn]
> =C2=A0 - Fixed typo from gb200nvl to gb200 in Makefile
> Changes v2 -> v3:
> =C2=A0 - Fixed whitespace issues [Krzysztof]
> =C2=A0 - Fixed schema validation issues from my end ( there are still
> issues with the aspeed dtsi file that are not related to this new
> dts) [Herring]
> =C2=A0 - Reordered to follow style guide [Krzysztof]
> =C2=A0 - Removed redundant status okays
> =C2=A0 - Changed vcc to vdd for the power gating on the gpio expanders
> Changes v3 -> v4:
> =C2=A0 - Added changelog [Krzysztof]
> =C2=A0 - Added nvidia,gb200-ut30b board binding [Krzysztof]
> =C2=A0 - Removed unused imports
> =C2=A0 - Reordered a couple other style guide violations
> =C2=A0 - Added back in a couple needed "status okay"s
> ---
> =C2=A0.../bindings/arm/aspeed/aspeed.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 1 +
> =C2=A0.../aspeed/aspeed-bmc-nvidia-gb200-ut30b.dts=C2=A0 | 1154
> +++++++++++++++++
> =C2=A03 files changed, 1156 insertions(+)
> =C2=A0create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-nvidia-gb200=
-
> ut30b.dts
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index a3736f134130..420fabf05b24 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -98,6 +98,7 @@ properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - inventec,starscream-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - inventec,transformer-bmc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 - jabil,rbp-bmc
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 - nvidia,gb200-ut30b

For what it's worth, checkpatch reports at least the following:

   167: WARNING: DT binding docs and includes should be a separate patch. S=
ee: Documentation/devicetree/bindings/submitting-patches.rst
   180: WARNING: added, moved or deleted file(s), does MAINTAINERS need upd=
ating?
   193: WARNING: DT compatible string "nvidia,gb200-ut30b" appears un-docum=
ented -- check ./Documentation/devicetree/bindings/

Thanks,

Andrew

