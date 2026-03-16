Return-Path: <linux-aspeed+bounces-3688-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2905F4643B
	for <linux-aspeed@archiver.kernel.org>; Mon, 16 Mar 2026 09:44:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ9D04pTMz2ygh;
	Mon, 16 Mar 2026 20:44:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:edc0:2:b01:1d::104"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773654272;
	cv=none; b=jebt+bvJ1/j8t//daBmHslUiMrQikXhOKm0QXZodlQZFMz7/GXCRT4fQe/V0/Yu8aGWW96RwOKTKGGapUoncJDVB9oti0NbakVAThDpblfRw4nskw/mdmhgPiagbZX5E/T6hKniP0V60aiPVjHMMIWuCyFdMVTQpvlDThw1Ss/s3unp2S2w1iqkBiMjcnZVLnmsa2Lx1kpk5LQ+fiSSxdWo77R+nK9vS8EJoD3LlaNNetzedrkLlljFNSwo5z4RmHK6CI9siQIx0roXtjChw2/L57R2iWgmdIyvmjUopf4K7JR4u14VZzEbwpzaGW7IGyELq5iI9X0H5jg6Yn0ndCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773654272; c=relaxed/relaxed;
	bh=zw3DkHicmWizyHDhINQfNMKY50+BlsEmdn8V8+1Eqpo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oyUhAHDmn1F3zReMyc1ri5IvprK1gAuxC5KxO/6/glC6qEez6Getp8jKf3FPmwwp8+uVu42inuGkwPW1XT1UO65RstiWhtZJqvH28w26HVPchqud0asM70wZ7fa/EXtDqk5FT1UT8UrQR9hfXQyUpWUBE155UL640FSvOGbLwMSFAyw4hNd7MpjV7iY/G/xyU5MJb80m3Ifbu2Awd0Y4MlzI/1ewYqAqhgcNn/uwctCb3RH/m69e86xy/uMjoKPQviPO6QsCSQh4TfTZZJdXMkfN1zLyG2gUzsGYEkFT+q0OfqtPhVRHeWgowcB+9Mtdw85ylj7JMTs85/+Oa4+adg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=p.zabel@pengutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=pengutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=pengutronix.de (client-ip=2a0a:edc0:2:b01:1d::104; helo=metis.whiteo.stw.pengutronix.de; envelope-from=p.zabel@pengutronix.de; receiver=lists.ozlabs.org)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ9Cz4Cnyz2y7r
	for <linux-aspeed@lists.ozlabs.org>; Mon, 16 Mar 2026 20:44:30 +1100 (AEDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w24UX-0007e2-Tc; Mon, 16 Mar 2026 10:44:05 +0100
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w24UW-000Y09-0o;
	Mon, 16 Mar 2026 10:44:04 +0100
Received: from pza by lupine with local (Exim 4.98.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1w24UW-00000000hnW-0gS2;
	Mon, 16 Mar 2026 10:44:04 +0100
Message-ID: <618f82e69dab57f9ba335e2fc4bb62d2d601f7cc.camel@pengutronix.de>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-aspeed: Add ast2700 support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Andrew Jeffery	
 <andrew@codeconstruct.com.au>, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Ryan Chen	
 <ryanchen.aspeed@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Andrew Jeffery <andrew@aj.id.au>, "linux-aspeed@lists.ozlabs.org"
	 <linux-aspeed@lists.ozlabs.org>, "openbmc@lists.ozlabs.org"
	 <openbmc@lists.ozlabs.org>, "linux-mmc@vger.kernel.org"
	 <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Mon, 16 Mar 2026 10:44:04 +0100
In-Reply-To: <TY2PPF5CB9A1BE6CFB3FA0165159C68D3F0F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
		 <20260313-sdhci-v1-2-91cea19c8a67@aspeedtech.com>
	 <352a522b5325e9db80c880dd7a3a052516f3b673.camel@pengutronix.de>
	 <TY2PPF5CB9A1BE6C2F2EFFA36CD917C623CF245A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <TY2PPF5CB9A1BE6CFB3FA0165159C68D3F0F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
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
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-aspeed@lists.ozlabs.org

On Sa, 2026-03-14 at 01:21 +0000, Ryan Chen wrote:
[...]
> >=20
> > Thanks the guidance.
> > I will update use
> > sdc->rst =3D devm_reset_control_get_optional_exclusive(&pdev->dev, NULL=
);
> > if (IS_ERR(sdc->rst))
> > 	return dev_err_probe(&pdev->dev, PTR_ERR(sdc->rst),
> > 			     "unable to acquire reset\n");
> >=20
> Sorry, I review the devm_reset_control_get_optional_exclusive_deasserted
> I will modify with following in probe.
>=20
> 	sdc->rst =3D devm_reset_control_get_optional_exclusive_deasserted(&pdev-=
>dev,
> 									NULL);
> 	if (IS_ERR(sdc->rst))
> 		return dev_err_probe(&pdev->dev, PTR_ERR(sdc->rst),
> 				     "unable to acquire reset\n");
>=20
> And add reset_control_assert(sdc->rst); in remove.

Only do one of those two changes. The devm_..._deasserted() function
will call reset_control_assert() automatically. See:

https://docs.kernel.org/driver-api/reset.html#c.devm_reset_control_get_opti=
onal_exclusive_deasserted

regards
Philipp

