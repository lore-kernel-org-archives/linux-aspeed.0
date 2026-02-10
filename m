Return-Path: <linux-aspeed+bounces-3511-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC81CEA3F0F
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Feb 2026 07:26:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9Clw2wspz30FP;
	Tue, 10 Feb 2026 18:26:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770708364;
	cv=none; b=OAsRk4yjEQRoEQulx9a1/ItVc3P+MD4fFbcX8t/e661qCIS1vrdJJdceNViF4T/Zaie1VzMK8lo2kP74PFrOlMf15Q4uGcCcxHHpLCeDZUo999JtKkFo0iswkBch5uyeGhu5JAXM9ckrMQpjXpDZH82PcN8jML1hqUtta3mJHre4dqrxdv0IULQRRoiApizUZ4dGMUw9Pm2W28zs2bmzdFI2XXJUKBWKhtSTNbB2AWYK2pPYqKmBgmcFutTcN80hR4ODFJB9ShyLXcvPAtD4dKXkWNe2alxgHLOFR5BF344YzMDNG/SoCOV17UObJgXs0C0StaWul5MMEWODBH2A+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770708364; c=relaxed/relaxed;
	bh=8ledWZbn+TzX2T22Aa+xwzh+iAFsRkUxzf+EyA9TX7s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZyGugPCbtRfeCOrtKq5NVX94xoIRHmti6QyZ1SZ5M2sFQWNEgXFCGayYWi+7KaBWnQc8QWb5ZXHVFdXWVdSAwbRcGiFcQDe5AhpFUHQ9cDm9mWSZQKhcKNO5428bWWJO2mUZe7RzXE1RkNnx6Q4W/ZV4wxh0ezqz9wRg0qQAu+msEaXnEYwsuNfEzYVcdIKCT5wEOYuGaPTXSNWFO/FwfDGrvFjJO43FwYy3uSDu/c2neSnIaZ1UIES567U2gYJPnELMMzL7K9LctynfETe6m2cnR3AbDQm3g6g5Mni8Oq0cXGd/obqyf7ElnpbHmS6kp02pCmKdYHqrZLoBOdruVg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=E+HqPabo; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=E+HqPabo;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9Clt65Cxz309N
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Feb 2026 18:26:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1770708361;
	bh=8ledWZbn+TzX2T22Aa+xwzh+iAFsRkUxzf+EyA9TX7s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=E+HqPabozX7gbg0tjWTuECfyirjpr0nWgXujSn25Ar2B8oaYpH00TUh9B6IaioJHK
	 eqU8tsIKfX2npYQkA6VV+LUbeg3jeX5Y2Lp6C3QlDl3gMmxV7cvzCR0up3C42CRskV
	 gL5Re3fuUEVoMqQhoTsTCvPf9mBuv6DQeL5ijfZL3TgWi4JED1isiv96UgEinTPqia
	 0vuJioL5O2vOOTjQaUd9Ej0WeZECD8LcpZ0dYoPhUwD2bORMRPCMxY/u+ouZGTzSAT
	 KCNvYAYKiXaEZf2ASacIaApc7p3K7HOa68CmC+7YlH+XFkdyIJOB7BgjpzaLc8T6Qo
	 6kclYs2fn75UA==
Received: from [192.168.68.117] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 179126024E;
	Tue, 10 Feb 2026 15:25:59 +0800 (AWST)
Message-ID: <feedc58438adad98f4b2a74a1499b2afa92a5eae.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/4] Add AST2700 INTC0/INTC1 support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzk@kernel.org>, Ryan Chen
 <ryan_chen@aspeedtech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt	 <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti	 <alex@ghiti.fr>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "devicetree@vger.kernel.org"	 <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"	
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"	
 <linux-aspeed@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"	
 <linux-riscv@lists.infradead.org>, Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 10 Feb 2026 17:55:58 +1030
In-Reply-To: <6de719dc84324166ed60bb8ec130cf2c9ef351f5.camel@codeconstruct.com.au>
References: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
		 <20260205-intrepid-vengeful-deer-14e2eb@quoll>
		 <TY2PPF5CB9A1BE69B07F90DFB245FAB735DF299A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
		 <d5e45c9f-f3c7-4289-8991-02bd2c5b9587@kernel.org>
	 <6de719dc84324166ed60bb8ec130cf2c9ef351f5.camel@codeconstruct.com.au>
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

Hi Krzysztof,

On Fri, 2026-02-06 at 17:49 +1030, Andrew Jeffery wrote:
> Is it acceptable if we take the following actions:
>=20
> =C2=A0=C2=A0 1. Do some b4 magic to transplant this series back onto [1]
> =C2=A0=C2=A0 2. Send a follow up revision with a link to this discussion =
in the
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cover letter

Following up my own post, I don't think we should attempt such
grafting. [1] references v4. v4 was superseded by v6 at [2], which was
merged.

Because of that merge, separating this proposal into a new series seems
warranted, but has the downside of making it difficult to compare to v4
of that earlier series.

I have gone through each of your feedback items from the earlier series
to consider recurring issues. Defining a new binding is unfortunate but
its addition side-steps an ABI break - perhaps rather than remove the
existing binding we can deprecate it, and keep the associated driver
(assuming this isn't overkill, given there are no in-tree users).
Otherwise it looks to me like the proposal has concerns covered, but
let me know if not.

Andrew

[1]: https://lore.kernel.org/all/1a2ca78746e00c2ec4bfc2953a897c48376ed36f.c=
amel@codeconstruct.com.au/
[2]: https://lore.kernel.org/all/20251030060155.2342604-1-ryan_chen@aspeedt=
ech.com/

