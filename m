Return-Path: <linux-aspeed+bounces-846-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37001C021B2
	for <linux-aspeed@archiver.kernel.org>; Tue, 25 Feb 2025 23:28:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z2YhP3PMWz305D;
	Wed, 26 Feb 2025 10:28:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1740526133;
	cv=none; b=l1nh5ytB2fm/LXEYIdUPT0zD86B7p8ogrviv82d29fCIDlmL3CQjxyqlheXR5cl745he73g2qQ4Pm5n5+LMC7PhYa9J5i67on6awk+81r3DsZOSTl1suUyrVfvgURKPT172R+RuN9kYOz+GtxoFEbAeYpj+VjE57DRKTqSdA1EOUCTyysCwnZzC1WwjMvKb5ryaiat0W9PqBTR/478cwiExVFWR0ufsk1xlNvXYmO0qpKojtJPRJ+iGpoEBwY+dzif8JDmO2WqJut6WvGq+pEhZ7rb0L+ar/oY2pCtKJnjMbCgYvBJzJmSge40L9sMGsTqAyohrYwP7/vYrQEMRCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1740526133; c=relaxed/relaxed;
	bh=QSvc/XemxvspxE6At8l/Qu+fHyG/W1yOWa6QPQHBb58=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AJib7EPzAyPIgAXK4tIrVAxeNRQDfx32g2azsC/zpyiQUyLBScqwRis7smMyYczsALbH6zOVpH56F4WB0fSaVT5dVyhZCx/gCnB4B+lMueNBgw7CzwHwRV6gfKuysWf1gTPTmC01MsICdCVN4cxvwZr9sM4oM7a6aH1JTq4vE1Awiu7GNoxrCjHW+USST3WqrsZzFo/6ZSsKFov5pV5Pq1GnLGHOcdR8nrvcYm3FQmp8ApzsWvJSY95CJmXRQJ30zX8s/mi6ayyboksWxh9hukh+t5u9RW307cVcVC+yt+d2GcxwVi85ACx6J5WpLAJiqFtnsk8/pWfFyj3Pzqf6ww==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=JoDWORWh; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=JoDWORWh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z2YhM5XLFz2ydQ
	for <linux-aspeed@lists.ozlabs.org>; Wed, 26 Feb 2025 10:28:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1740526128;
	bh=QSvc/XemxvspxE6At8l/Qu+fHyG/W1yOWa6QPQHBb58=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JoDWORWh5GMuHWhPpH1YC1VOcRnB6A0kfhfXPOGKob7Lozkmp3Ldds10SIb0gMhEo
	 fmHS9hlv8mpFF3iIb62peumhlZfdGhgFv3CgFEpbMtrVtyKku5LWeuo/UR2qvIQH3t
	 Z8jAT5Wcm8SyNW+trXOBYBpF6Gk+cYA+lsQkvKDh7kS53ux52/9KGCGUU/lWA4zwAr
	 8PvFv8z+MShtsR07hsYXl3OkWSbnXfFCkv3tesjsRtL2NBV8wjH2lKY37vYfVp/CYy
	 2rPbc879sPoopOr5hnt0fyzuB0ocRbNoDd1Kaut3S26MhoDuno6+T2IE5VlHCTKMzc
	 HEV5j0ycCFL5A==
Received: from [192.168.68.112] (ppp118-210-173-152.adl-adc-lon-bras34.tpg.internode.on.net [118.210.173.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1415377691;
	Wed, 26 Feb 2025 07:28:43 +0800 (AWST)
Message-ID: <0008bab55f56252016406e06f147ef52f058bb86.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 3/3] soc: aspeed: lpc-pcc: Add PCC controller support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Mo Elbadry <elbadrym@google.com>
Cc: Kevin Chen <kevin_chen@aspeedtech.com>, "joel@jms.id.au"
 <joel@jms.id.au>,  Z-ChiaWei Wang <chiawei_wang@aspeedtech.com>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "tomer.maimon" <tomer.maimon@nuvoton.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, "lee@kernel.org" <lee@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>,  "conor+dt@kernel.org" <conor+dt@kernel.org>, Jenmin
 Yuan <jenmin_yuan@aspeedtech.com>, BMC-SW <BMC-SW@aspeedtech.com>
Date: Wed, 26 Feb 2025 09:58:41 +1030
In-Reply-To: <CAOO6b=udHyXx3QXyUE=siuuJopanUxzbFeBujtqWRy=j2ut4fw@mail.gmail.com>
References: <20250217114831.3225970-1-kevin_chen@aspeedtech.com>
	 <20250217114831.3225970-4-kevin_chen@aspeedtech.com>
	 <e43b5f8f-37e4-4468-b3ca-5059a5e6f3c3@kernel.org>
	 <6fd7cd57261ddf9831f57dc4c637b24e9f8982d9.camel@codeconstruct.com.au>
	 <PSAPR06MB4949C65DF5C034BD6B40C9B589FA2@PSAPR06MB4949.apcprd06.prod.outlook.com>
	 <d4945482509cad0bf3e8cd93c1fb21bac2e0c7f2.camel@codeconstruct.com.au>
	 <TY0PR06MB4960EA7255DF0BDF235F0D9689C52@TY0PR06MB4960.apcprd06.prod.outlook.com>
	 <ba2757fd02b3e7c8f9c862c76f2cfcd2b6bfb41b.camel@codeconstruct.com.au>
	 <PSAPR06MB494947E21AB39369ADFA8C9489C72@PSAPR06MB4949.apcprd06.prod.outlook.com>
	 <f7369d6205e05c7aac3f3de7cbd08c3b08960d75.camel@codeconstruct.com.au>
	 <CAOO6b=udHyXx3QXyUE=siuuJopanUxzbFeBujtqWRy=j2ut4fw@mail.gmail.com>
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

Hi Mo,

On Mon, 2025-02-24 at 20:34 -0800, Mo Elbadry wrote:
> Hi Andrew,
>=20
> I agree that a small layer of abstraction is needed to provide common
> chardev semantics to userspace. I think that effort can come where both
> Nuvoton and Aspeed unify their design and agree on a common abstraction
> layer.
>=20
> I think such efforts may take some time for both to unify, is it possible
> to get this upstreamed (after addressing all other comments) while both
> parties work on an agreed unified abstraction layer?
>=20

Given Arnd doesn't want bespoke userspace interfaces in the SoC drivers
this will need to go elsewhere, perhaps drivers/char or drivers/misc.
Greg and Arnd maintain both, so the patch needs to make a convincing
argument to them. For my part, my comments are just opinions based on
my understanding of the use-cases and the SoCs involved, and the desire
for reasonable devicetree and userspace interfaces.

I don't think it's right to try to rush things as devicetree and
userspace interfaces can be tricky to change or remove. Rushing tends
to be painful for all involved in the long run.

Cheers,

Andrew

