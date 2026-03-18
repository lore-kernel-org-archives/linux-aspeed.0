Return-Path: <linux-aspeed+bounces-3711-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818CFFCD0A5
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Mar 2026 03:59:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbFSZ1L6xz2yjm;
	Wed, 18 Mar 2026 14:59:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773806350;
	cv=none; b=fkuxNcHDk7+r2MQo+lQQyYR5ttvq5XDCxQbXuEuFEoaK0PqsOlFK3pRZs2T1GAHZca/ksCt+Nc1duaRIw3XXYROQPrFFwrCqjlNdDhdpaIwil7vYzX6gCh4dwsmSXduQDNbPDyhMCjj3lH8z63qf9jptxA1vqoKBkC3pKhj8rt11/t1pr7TpEbfxkd3FiV9IXNDmICqeXQ0L83tMDkKC6Od1hn9Ut9Ncb6uahLBFKWocfa1S1qzEIamrgzCfOmJT67p3yaNGn7Q3eM7j4VTpeMmOb5HwIQtjstKO0B33s7NNl8xUWwKsNcTODIut1dSPSkjUMG9ldkfyap2PLfqjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773806350; c=relaxed/relaxed;
	bh=bQj0bFjWadUcgXbTgg6MGFPtwTABJbc7PhB3q6d4igk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J17YIQzvQKE+3QHg9WCVa0Wd/PYe8e4KDCr/9/sm7RlJzgkciSuS2JQQzY6xV+vT2NbRa1ZDeiSOXuZpMk+qnyuaD3rgWEiLv3b4WFdCPkQlYznBqMDzR/r1tAdGTkiD2VsZyFgO51bi4KY/BKzi1ZzkGLEIhlRpZ6tOxzkrUxCkSrbrGW1rRlXkaKnm4XCk0CtEnkT8B65Oc4SbB+hKuJhuUBhgc0ayPzV9uELkhCb3/dMt3ARN85iqpvLQTMUfY+YZ4FadxWjWDzWL3RjlkRcdo1m4SzL77rLieC+8j/NhvzBxbDCUOLlsEobDcVLBBYRdylSKXT5kQtJ2xXqgEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Sh/J5eSV; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Sh/J5eSV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbFSY4TXgz2xQB;
	Wed, 18 Mar 2026 14:59:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1773806348;
	bh=bQj0bFjWadUcgXbTgg6MGFPtwTABJbc7PhB3q6d4igk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Sh/J5eSVXfwhiP18su5vv07xvYT6L7MM5NHAEQd10+lSARv/26zjCToqf4y8cyS+c
	 WCYE5i/0a0mUgr+l6ttC3GKFcmowYUrCMYTeD2y8GEPthvB8tTzH5R9x8Pk93J5iId
	 ca/Wim3vHxuy0ije+8QA25qSEWIbxpozyC2vYhhtN2aWHs1ecXCkcn0f0pfENGR5Px
	 DAkuJyBolfqt7UUFUofoSnYX8F8erm8PXO+pFi7y7/Isr+9ACz48pU8CmKu5zS8/hU
	 vckifOR1eXQOQnve7GFWLD5q9/TJQX/bksTumzuyKQygO/naB7R6+Vk+m6GUlt7PGl
	 zGuRfKS64sQjw==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id ACC9560C33;
	Wed, 18 Mar 2026 11:59:08 +0800 (AWST)
Message-ID: <20ed3dc6f6841435a2c9f8b3cc51a3ca12a9ce63.camel@codeconstruct.com.au>
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
Date: Wed, 18 Mar 2026 11:59:08 +0800
In-Reply-To: <d5ae7e63dd5a39ffa26002a3a5988eb0d74cb189.camel@codeconstruct.com.au>
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
	 <d5ae7e63dd5a39ffa26002a3a5988eb0d74cb189.camel@codeconstruct.com.au>
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

> > Do you mean sysfs select support mode selection(byte, buffer, dma)
> > Or just force byte mode?=20
>=20
> I would think that the best approach would be a mechanism to specify the
> mode - either byte, buffer, or DMA - if DMA is indicated as available to
> the controller.

... with a sensible default mode (DMA if it is available, buffer if
not).

But none of that logic relates to the binding, it's all driver
implementation detail.

Cheers,


Jeremy

