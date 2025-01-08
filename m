Return-Path: <linux-aspeed+bounces-348-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE90DE77198
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 00:35:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSTTh3Kghz30ML;
	Wed,  8 Jan 2025 11:35:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736296520;
	cv=none; b=goB8xT6VqwKuhaSj6WgO2QOYTVY1iXx/ShS5XtivSj1vAGECbrVlaNPyFSNd3DJF2DwPlM5RBeqYiahMCl70yUKoHhf6Skbsy/CvVZ8kwzWM6SBTmdNCvvhU7aavgtXaOUrI+Y+S7BCkHvuQDOQC+n6QA9mr5cgnMDz04gPSV7svidslS/u1ntPHiX18RAKoykXOaAXsQBmEFEtf4+5f5/e376u76Yv9sL+Ap9nxphODzlA5kHHibh3VVP4AVNwrJjaxJiBsskQTSC1PvovaJh8UaV6jXj60xrLXSSMOScwgYG1FVc5aLztNG4fuDjJ0d1OyQMMNxSNRHwzfcVgMZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736296520; c=relaxed/relaxed;
	bh=CGtf0U2QWath+kQBWiGScXsK40BA3Bpp91eZ5jHTv+o=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VJFRdBp5i0TlI3P0FZwTwj27Yb9f4//2MUn6y8x9SQTIOW+Mbt9O9hjmjelRotd+iL8Yp6NdCBRjMrKPMtI6cLUjuXpwd2CE3IqBlyaNQ4UO3fqvJPSl4MyDjE036x4ErAfdSHsl8sa6MzLYjUyCzIl9RRvE2Tvbwx/uwm/viP2WAV9O33co1W0+JpXi60T9/4ARmHeg4f9w668kiLmNjDNFdupgEItodv7YwYUth9wra7e6i1EtoUddcxh5+mVmcwEPdPwcJSrYg7zXwT03Mz+VfGd3lm9r6KK++Ds/ZHx/YfUIRgdWH6yTAZKq0dXVDvjszBccpjHcCIRAt2p62A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LWugbcXw; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=LWugbcXw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSTTg4H36z305c
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 11:35:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1736296518;
	bh=CGtf0U2QWath+kQBWiGScXsK40BA3Bpp91eZ5jHTv+o=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=LWugbcXwyQ2jmJE0FpuMAzMD5WQrpJxWPGSomgMn6vElvDZGGzvzADUdG90a++wCa
	 ti+EOrg14yaVMAFkiLk/FCoTcpMTerokvinOMT/TZuesb+Ukx66Qc2oYOYVCu39wBU
	 7cTWBtpDi6GYuSYp2nPAwiKge9cCPo3pN9LwJY/77pj93i2eRe3Il6Qj5U/6cfUpF3
	 Ns5leRi97JmVr9IiiBTCfBq/g5eqC94V6zKhaPLWmKat+DBDz+Dn90bySdlpm8H+bu
	 SQ9BYe+zoTct0QqFM7azgR6JydzCvf4zuwpeceC9j00oNR+RjcsemHbbICWO0YRb83
	 GZeHxlfd3QwCw==
Received: from [192.168.68.112] (ppp118-210-64-24.adl-adc-lon-bras32.tpg.internode.on.net [118.210.64.24])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 93F8E70801;
	Wed,  8 Jan 2025 08:35:12 +0800 (AWST)
Message-ID: <cf3d472b843eeedcb718013c38612cfb33cd0cdc.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: usb: Correct indentation and style in DTS
 example
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>,  Justin Chen <justin.chen@broadcom.com>, Al
 Cooper <alcooperx@gmail.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thierry Reding
 <thierry.reding@gmail.com>,  Jonathan Hunter <jonathanh@nvidia.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Magnus Damm
 <magnus.damm@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
  Florian Fainelli <f.fainelli@gmail.com>, Benjamin Bara
 <benjamin.bara@skidata.com>, Bjorn Andersson <andersson@kernel.org>, Ahmad
 Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,  Del Regno
 <angelogioacchino.delregno@collabora.com>, Tianping Fang
 <tianping.fang@mediatek.com>,  Jassi Brar <jaswinder.singh@linaro.org>,
 Biju Das <biju.das.jz@bp.renesas.com>, Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
Date: Wed, 08 Jan 2025 11:05:11 +1030
In-Reply-To: <20250107131015.246461-1-krzysztof.kozlowski@linaro.org>
References: <20250107131015.246461-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 2025-01-07 at 14:10 +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces
> and
> aligned with opening '- |', so correct any differences like 3-spaces
> or
> mixtures 2- and 4-spaces in one binding.
>=20
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> =C2=A0.../bindings/usb/aspeed,usb-vhub.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 40 +++++++++--------
> --

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au> # aspeed,usb-vhub.ya=
ml

Cheers,

Andrew

