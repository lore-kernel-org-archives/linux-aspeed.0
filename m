Return-Path: <linux-aspeed+bounces-1137-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DC2C3600B
	for <linux-aspeed@archiver.kernel.org>; Fri, 28 Mar 2025 00:46:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZP20d603Fz2yrQ;
	Fri, 28 Mar 2025 11:46:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743122817;
	cv=none; b=nYE9gBb6raRBEVIGklxZsbk7IHk4Djd90CJPyPiYaTDiLGXUOqIX/mjPu0HUvy/FOXaBSRq6gd443yjzO7eAtbHipncGAo2LBMrsZDyqNKLAGVtrGAsE0VOC8EvzhtWLox2BdEwC1gwl+ycAsR1VmtjSKhPf07nlxKZi4eRXbdgI6EcvTo1rLShbRioAlFOexqUB28i1ohWJRRrB8kL5RQrS6FqJVeTifU+oDTLQsr514PDPXJwtVLYWi4LJAVX2FWSlJP605tBsvn9I/G1itqZmFXWO4wWT2tBcrS0urHnXbVpUC75DPd2rXAioEwyBqr32QMgnpoCMeSQX6cGrMA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743122817; c=relaxed/relaxed;
	bh=p+ra6T2kuA7+mt1Iw7ON824iAjkZzokAvi5uNjYApfw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hv+fRqG0jZ1wUmjxyZ5GVhTqNjswMIgUxHAPPQiODKcimGXgcJSxqCA7wTIO0KzaTILRCEDTDW0ledqGYYGBBNp5QjBzh0vYiX2KyAhFh/wgvM7s6RU1czlbLGJh1h/IKD3txJJ9R7xRtN+7voxz0Ra1Fl04m0rayl23mFeHvwfqIE4T00bzMYGqlotLINH9fPWHWyXTJ+/W95ZbCp3BQ6o647ylliQZpxB7XXSkHj1XtweXUPVQK4909HBWgNHEnH0tswo+WZal5SqlV4hNMhQB8Q8yV8Ef1YInbw1lSuShs924wb5F+wIfEldgZNn9P2ALeCXsLZgTbRotjg0FZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=l8YUapQx; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=l8YUapQx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZP20c5n7Nz2yfK;
	Fri, 28 Mar 2025 11:46:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1743122814;
	bh=p+ra6T2kuA7+mt1Iw7ON824iAjkZzokAvi5uNjYApfw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l8YUapQxzkeoWlqLL49sQe2NZt+CDE+Nbw6PPh7eZKP++2Ac/TSsnK1tiM8aLmjXH
	 ar97VpEYv4CJvV2HBzYiqAYvGRrXS5SX1+jOn8cZbD2UXHu0hG+ziM/hyTG7h0MAyp
	 eCrvBZPGJH/pl5yjqZGxCdUUZbbPn8RAshQSwN2XFyx4y5qhrlsHmE6fttMcr9p63Y
	 mWibmTpNIuw6aArxfyUc4gHIgIdHCwAgKe6okSnUvEjAtjpNnsrMVqHfJBpdi0NiFD
	 essgIYoScXVdiCnLgBILlmAyiayUxWWj4wNKzK4NeNA9WT/igeteJsm/lHbAnK/DGU
	 wBJTYZY0MyPmg==
Received: from [192.168.68.112] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C0E4C7BC5A;
	Fri, 28 Mar 2025 08:46:50 +0800 (AWST)
Message-ID: <d0f7003c22e19c8fc7617610043edc7be925a180.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 2/3] dt-bindings: pinctrl: aspeed,ast2600-pinctrl
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Willie Thai <wthai@nvidia.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au, kees@kernel.org, tony.luck@intel.com, 
	gpiccoli@igalia.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	openbmc@lists.ozlabs.org
Cc: leohu@nvidia.com, tingkaic@nvidia.com, dkodihalli@nvidia.com
Date: Fri, 28 Mar 2025 11:16:49 +1030
In-Reply-To: <20250324175926.222473-3-wthai@nvidia.com>
References: <20250324175926.222473-1-wthai@nvidia.com>
	 <20250324175926.222473-3-wthai@nvidia.com>
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

On Mon, 2025-03-24 at 17:59 +0000, Willie Thai wrote:
> Add EMMCG5 enum to compatible list of pinctrl binding for emmc
> enabling.
>=20
> Cc: Andrew Jeffery <andrew@codeconstruct.com.au>
> Signed-off-by: Willie Thai <wthai@nvidia.com>
> ---
> =C2=A0.../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 1
> +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git
> a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
> pinctrl.yaml
> b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
> pinctrl.yaml
> index 80974c46f3ef..cb75e979f5e0 100644
> --- a/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
> pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/aspeed,ast2600-
> pinctrl.yaml
> @@ -276,6 +276,7 @@ additionalProperties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - BMCINT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - EMMCG1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - EMMCG4
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - EMMCG5

What pin configuration does this correspond to for the eMMC controller?
These groups aren't arbitrary, they correspond to the 1, 4 and 8-bit
bus modes.

You may have added this squash a warning, but I suspect the pinctrl
configuration in your devicetree is incorrect.

Andrew

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - EMMCG8
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ESPI
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - ESPIALT


