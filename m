Return-Path: <linux-aspeed+bounces-1435-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD634C61DB2
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Jun 2025 05:37:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bJSpM45Vkz2yMF;
	Fri, 13 Jun 2025 15:37:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749793051;
	cv=none; b=OUO+Gvu8VJC93jVb5wu6Fi6qUc+8qf6yuc2wCeNtm4bDTZo1w4QRShKxYReSp0f7gK+o7n9dv2Y1PwZwW8kLnDk3zIHiCkidocvANJOuseQZ4Coalzm7bIVWVZhrJ10KZtRzZy52/J6DkYmWwp4N1Tx07BUtjiAk9FQAmWvxYrSeVcwttrJpYM6FVPGM98dpqusJer5EPRqx4YbdAwGsAnI1FoIFYNFxLaXXPydsM6vMoW0Cif+S0XqI628llQg1CPnCjM1JHU+7GFoyTMBW8US3YuMERFAN6oD/xVSwPmWB6WLE+BTFy6ybvHC9/GFiDzi4XMpXA4j+smouQwcbSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749793051; c=relaxed/relaxed;
	bh=m3k1yr4GslKpTzf5lqnCGMcEjSghKmBJjnIvXsOuWCc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GxQ6ZnJPVArU/fVteTznWjYekaBQodCymKwPRvwDNshSrG6sBBfIpUiX1Xje2RUN7LunpNpDG4VDNWtRivGnBLY9fqytzHqLEaSDlMvj7WqUid2CEzUK2ek9r62E8mnx1yM+GUIBp/DuO6KgvDaKzMGSSGPkC0Lp2RBt6jBrPrgHNk/CzZWyi2ZDuRCCg2/xeMurcXAAA1E3LMNbLuT81IT6StZicTfuKMBXwb1W0Q8adaFps4fSP/1hnSShbPomdbUhvIO0+8fOXgwVMU6Ea62V8ck/dr6CbSGvw70WTrd+UENszoRVCDWUxkP6UWTqdCp8JtJwqa128PUO+TxMQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=mAUilWM2; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=mAUilWM2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bJSpL6NL0z2xKh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 13 Jun 2025 15:37:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749793050;
	bh=m3k1yr4GslKpTzf5lqnCGMcEjSghKmBJjnIvXsOuWCc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mAUilWM21VC7VSJqWG0x27cxIkQzvrwFDSVB5KSKvDE9cRXOzAys05cSFQ0cOXawd
	 IgOPWk7nlVlI3B8Ovt9CMgQps65zkZ3WyAnjRUiRhamZjUIZ+sVyNdg9emdwGzYk5a
	 8hvwEeYNdivCAuWWNeYndziLQeHNjfRRE0ZuzRQ/CRdQteb+PK39YJGQR5MHwGhicq
	 B7lBcvGfmNrYMZVMVBQSSfVX1UZhUU/1U0JhBdcnUnvMDYGecwE9OVDQUUbg3HvC17
	 KgE2RlbyhioHPG78vPgk/xjs7BEnFiOocWdLH/hSRF0yx6f3+QAcl2soQ1wVPYHMVX
	 p7JKPApw5UHpQ==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9C11E680F3;
	Fri, 13 Jun 2025 13:37:29 +0800 (AWST)
Message-ID: <6a51eda96a7ffbb228ec08877a4f6649413c9bef.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 1/1] ARM: dts: aspeed: Add device tree for Nvidia's
 GB200 UT3.0b platform BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Donald Shannon <donalds@nvidia.com>, "robh@kernel.org"
 <robh@kernel.org>,  "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: "joel@jms.id.au" <joel@jms.id.au>, "devicetree@vger.kernel.org"
	 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, Ed Tanous <etanous@nvidia.com>
Date: Fri, 13 Jun 2025 15:07:29 +0930
In-Reply-To: <PH7PR12MB72826C4B588D08923A512E91D774A@PH7PR12MB7282.namprd12.prod.outlook.com>
References: <20250611013025.2898412-1-donalds@nvidia.com>
	 <20250611013025.2898412-2-donalds@nvidia.com>
	 <67c89ca729669f55e2659ad8070a154c59ef83db.camel@codeconstruct.com.au>
	 <PH7PR12MB72826C4B588D08923A512E91D774A@PH7PR12MB7282.namprd12.prod.outlook.com>
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

On Thu, 2025-06-12 at 16:59 +0000, Donald Shannon wrote:
> Hi Andrew and Krzysztof,
>=20
> The difference in this device tree is adding more GPIO expanders and
> changing the networking.

Can you please include a description of these differences in the commit
message?

>=20
> Would it be best practice to create a new device binding (in this
> case nvidia,gb200-ut30b), even if it is just a slight modification on
> gb200nvl-bmc? Or can I reuse the gb200nvl-bmc compatible string and
> avoid the yaml binding change all together since it would share the
> same drivers?

You can include the aspeed-bmc-nvidia-gb200nvl-bmc.dts file and
override the nodes where the differences lie if that helps. There are
existing examples of this strategy, for instance:

   $ git grep '^#include .*\.dts"$' arch/arm/boot/dts/aspeed/
   arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dts:#include "aspeed-ast2=
600-evb.dts"
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-blueridge-4u.dts:#include "aspee=
d-bmc-ibm-blueridge.dts"
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-1s4u.dts:#include "aspee=
d-bmc-ibm-rainier-4u.dts"
   arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier-4u.dts:#include "aspeed-=
bmc-ibm-rainier.dts"

Whether or not the differences warrant a separate compatible - I'm not
sure.

Andrew

