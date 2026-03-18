Return-Path: <linux-aspeed+bounces-3708-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB8B610854C9
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Mar 2026 01:55:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fbBkB5tK6z2xQr;
	Wed, 18 Mar 2026 12:55:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773798946;
	cv=none; b=KfwAX6mkIiS9YxNrGdfs+MB40PSF7sls42PHrV0b4ejlGEYxeNl2OqYDxSkz7E1uvZHUoocI5CTtn4PeQ9O/c2RhRRvlRcI8DnafVphZrJCXHNMCWnQizJDgo1ItLocDHYkk2S1YTpH0Ia3XsVEpIfktEWpNi1A3Si0mIrWLZPNMWmjNptfC9jCs/ko9Znnq5fXpY8OvP69T3Kby6mKkq4DK33jEWVO26OvgzJY2PzA1t1qRcuvc3rV/tiCmVCg2GgaS/1EzT4xauYpMNpVR2yXyyYv7QUIlCKug41o+XnTa2rCoKl8FSldZQClH5TRa7llhdXn1QpWALXdanP2+Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773798946; c=relaxed/relaxed;
	bh=3JThk0kPSAg9d5X5Swzc6oumoGxMPTx0zxcz2YCRC5w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oTswW5Sf6EKkMFnBcxfrwXHzrYXU9c+p6DFZahWmnbhCHItBOUOuC095UwVl6uXnzg5nL+vXs7ZeJeATXuHyPQmVJvYDrS+t3LSovuTAWvw14Pc++cVHcNucyfn3RvhkhV4ie8E/96wHGBtlPezh7fQt4I1CviRdYD1oM8rV6eOQ4FwR9VeRlSEb4Xo3V7xnssch8RDTiw+DkT1tKguVM7N0rcSf2/lPotb0AGkFQAevLcr9lXdbgDW9OQmtHvd7BpggV9qX0ngBJpBZcJ/nm0SSdgzddNQVbkbsG/HDHSDUwXE+dvl4lbXQFQNnelujCBaTdookhOT7fdpt7qCEUA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=eltBYvKc; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=eltBYvKc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=jk@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fbBk93ySmz2xQ1;
	Wed, 18 Mar 2026 12:55:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1773798943;
	bh=3JThk0kPSAg9d5X5Swzc6oumoGxMPTx0zxcz2YCRC5w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eltBYvKcITP0xHs321ACs74jrhtX41HLi324xDPVprg8uoy3LRLpDbASpZSS9W8KJ
	 wwVB8Xd3P17NelBT1MyKWm2gg/tGN+RisolDk4blV1nidbZrwvZ649K5Sid8QYCGoK
	 yQd3SqvvIIQbpo5XgT/4l01J+f+ZIb/IBVytDapnBVLinY6V+udzANQfDX3gN6QRU2
	 M4ocEkXCJ6y+Cy/LTMx2mwcaG8IAfI4ghduDGKL2YgGGKh2vy8LEykNdugwnZjUj8q
	 gWPW5jY8nPq5LSRHhpgGxDEYyE+mG5sCMGbZaM1Qfs74um+Xw0ZUl63H5a05+7fPG3
	 LJCPvPpPtIIvg==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8DA5660BA5;
	Wed, 18 Mar 2026 09:55:41 +0800 (AWST)
Message-ID: <071adc5f76b71b3e8d2691945e7b178602b285f9.camel@codeconstruct.com.au>
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
Date: Wed, 18 Mar 2026 09:55:41 +0800
In-Reply-To: <TY2PPF5CB9A1BE6EAA73D3AD6F75F1ABD53F241A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20260309-upstream_i2c-v26-0-5fedcff8ffe8@aspeedtech.com>
	 <20260309-upstream_i2c-v26-2-5fedcff8ffe8@aspeedtech.com>
	 <20260313232125.GA3618633-robh@kernel.org>
	 <TY2PPF5CB9A1BE6A19D439C675AF5028C13F242A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
	 <7ae8222bf6abd83a3c2ac976f54a2edbe4e9727a.camel@codeconstruct.com.au>
	 <CAL_JsqKQp=HyA90rQ2Hzu148k63k5-qrGLH6sEHXNcjAu3QSwg@mail.gmail.com>
	 <eeac1db0a5692ae45b5528a85ed1510b8b1cf771.camel@codeconstruct.com.au>
	 <TY2PPF5CB9A1BE6EAA73D3AD6F75F1ABD53F241A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
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

> > Not at all - the next paragraph was my attempt at a recap of those, but=
 Ryan,
> > please correct me if I am wrong on any of those points.
>=20
> Your understanding is correct; the byte and buffer mode is mostly the sam=
e.
> And also mode should be decided before xfer, due to the controller/target
> both use the same xfer mode, not decide by transfer time.
> The original my submit is only buffer mode and dma mode, and use only one
> Boolean property, aspeed,i2c-dma-enabled, but someone suggest add byte
> mode select, so I start to add at v17. I can drop the byte mode, if this =
is confused.
>=20
> byte mode request:
> https://lore.kernel.org/all/010e55e9-d58b-444c-ab57-ddf8c75f2390@gmail.co=
m/

I understand that there may be valid uses for byte mode, but that does
not mean the configuration belongs in the device tree.

We do not seem to have much data on what those valid uses are, but I am
assuming it is not an attribute of the controller peripheral hardware.

[As an example: I suspect MCTP cannot be fully spec-compliant without
byte mode, in order to support the NAK window on target-mode RX. In that
case we can enforce byte mode when the controller is selected for MCTP
use, without requiring a mode selection property in the DT]

> > Ryan: I think this gives us a much cleaner approach to the binding.
> Thanks the feedback, do you mean, just one boolean property for mode sele=
ction,
> Am I right?

The property would not select a mode, it just indicates whether DMA is
available.

A driver implementation can use that indication, along with any other
configuration data, in order to select a mode. The Linux driver
implementation may use other runtime facilities to control that
selection, if you need, like sysfs or configfs.

Cheers,


Jeremy

