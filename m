Return-Path: <linux-aspeed+bounces-3710-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF1DFCD0A1
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Mar 2026 03:55:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbFNS3BbHz2yZ5;
	Wed, 18 Mar 2026 14:55:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773806136;
	cv=none; b=Yuul+IoVie/iQMUkXJAlRmrqAR4aRck+hiUIxnqhNJViHPtUX6eTpIad0PS/I3KoD90g8l4xORVxQqGH/JdvRDV6TtulX/9DEVPrpdCuwzhS9sTUZgTIvQcvcBB/I2l1bZUNsWusHsJccemEsvg1bhvKbCBRgUf4rc4iOfyKDFMBF9GV67wQ3jVyH2+xTpg21Wpldi250gME5/d6lUIg12QrwRN/64DMID/mo+vasOBDOVfAOwlSp6EcRY3o0ZVcpiysr+cIv/El9f8NY8DV4yAd7KNn40kwLzX3CRgxorb3GZogto82WSwMMBIlc18oKuMY3BYwyFRG5gqscBk9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773806136; c=relaxed/relaxed;
	bh=XcCPj0djZ7iwvsvLXAAWU0n5yU8OTGIc1kAvZ/CFY3w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PBi5bglRsX6NPfxS+uSPh+ZrdiKbTaQLRO76xUZzBmqd3rnnR3MRw1APQiYqfCSYxvjAwntIsrLt32E9dpBJX5pF2m1TbCFSjP4Xrz6OnnHNm0/Wwar7R35DoMON7buP0dLSpe8FRXMXyH+rOJUjVrYBkwNehqQbhvdudyiW73JHQjc4UyereJuhx6ZRGgnZBt465ivH+NeB5vbOmQDW6wjdDi75OgFeo2GGEn75mSUepSraNMWcOLLcefK6KgXEfnVXSJfJW3nphVCrbV7oMYBrU+Lpq67frEBPGD874DFlVfhhepnDkyrlROxki2MdhjLaNDj8kp41A2Y09Gp5pA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ETg2cZME; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ETg2cZME;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbFNR6M8Lz2xQB;
	Wed, 18 Mar 2026 14:55:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1773806134;
	bh=XcCPj0djZ7iwvsvLXAAWU0n5yU8OTGIc1kAvZ/CFY3w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ETg2cZME6M6ho60BQ1zKAgYALPDMsyF2RAOX6zfhHWI+bdZp+BGK5bBpfFd9H0mTW
	 aiphV7IDK/bb4zHyuGpJdyrLQ5fugH6PzttqLVSanSt5GXmc9CCOKKQl/tW8lxhmlC
	 WLSNGYlk4sJwUBNur404RnG0EpKHGNGgkkbssZeAVFSNAVYLGzhBKH8Bb/gGZOEHa5
	 OxmSOrY6fYv7m4/EBxGZKfWbSUIKrRxpYS3VbOYJ1ApxPFyj0mQ3Gtr2Sz65u3YZ38
	 Cjfh33eBCWVyz9BxhygBdGPXm2xOU+1ZgvQnTkDdzyxo8vFACUoZmh4uQxIVMe79aN
	 rxfnt/GXYSduw==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 0C0E860C33;
	Wed, 18 Mar 2026 11:55:32 +0800 (AWST)
Message-ID: <d5ae7e63dd5a39ffa26002a3a5988eb0d74cb189.camel@codeconstruct.com.au>
Subject: Re: [PATCH v26 2/4] dt-bindings: i2c: ast2600-i2c.yaml: Add
 global-regs and transfer-mode properties
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>
Cc: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
  Andi Shyti <andi.shyti@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>,  Philipp Zabel
 <p.zabel@pengutronix.de>, "linux-i2c@vger.kernel.org"
 <linux-i2c@vger.kernel.org>,  "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "openbmc@lists.ozlabs.org"
 <openbmc@lists.ozlabs.org>
Date: Wed, 18 Mar 2026 11:55:31 +0800
In-Reply-To: <TY2PPF5CB9A1BE67264C727ACBEBE4642C7F24EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com>
	 <20260309-upstream_i2c-v26-2-5fedcff8ffe8@aspeedtech.com>
	 <20260313232125.GA3618633-robh@kernel.org>
	 <TY2PPF5CB9A1BE6A19D439C675AF5028C13F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <7ae8222bf6abd83a3c2ac976f54a2edbe4e9727a.camel@codeconstruct.com.au>
	 <CAL_JsqKQp=HyA90rQ2Hzu148k63k5-qrGLH6sEHXNcjAu3QSwg@mail.gmail.com>
	 <eeac1db0a5692ae45b5528a85ed1510b8b1cf771.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE6EAA73D3AD6F75F1ABD53F241A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <071adc5f76b71b3e8d2691945e7b178602b285f9.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE67264C727ACBEBE4642C7F24EA@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
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

Hi Ryan,

> Do you mean sysfs select support mode selection(byte, buffer, dma)
> Or just force byte mode?=20

I would think that the best approach would be a mechanism to specify the
mode - either byte, buffer, or DMA - if DMA is indicated as available to
the controller.

Cheers,


Jeremy

