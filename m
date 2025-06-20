Return-Path: <linux-aspeed+bounces-1515-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAE3C7115B
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Jun 2025 07:27:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bNpw32n3wz2yf3;
	Fri, 20 Jun 2025 17:27:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750404451;
	cv=none; b=JwB7sgcff88rCD3+cqQcANeAUVC60Oi+bYBt+Yj0L0+FMR6QPUYJi/DoS1+EbUOKuAgo/j2BtNcIS14ut6y3K8KK+T8IVdzlOctpcT6w6b/Vifg6A5pbpLAPUjD4QUrILOXlIt44A4N8K3tptmXfsVcpygdEDUs2KOwa4a1XLTLkumgVdowqGXC5S9pauHzFuelGuuGFeXEo+WW78KtQPbcVlidsKIBWh4aPRSSjg4SGjcbFqiqBZ7ksMq5/cIM+lPsdkXPH0kF7lcpzdhCFd+JNAjIhmBeEXVkiP0RN3ppHCpCT1wz1+YiflN8uyUnHHXr340aRoB0ZA2WMp8Xecw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750404451; c=relaxed/relaxed;
	bh=Llxea915k6LzdSVVh5d347vix2QwFPkuKoZ1a41Dx6Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lqN+r+jWIrQ3r+kW/Rz+RELqtdPzStu+FFltHRBxMjh7ghqwVxFakbz+YlVCoEE1D+gcrZBGOj1d/bSKxAM09yS0mWDP046gADAo3W2mjCYpbgW46W2xjEf5TEWahaLoijQHbNSczZlAz3+Wd9n6DDAsOUKIDlbASHcylUOMwwxt355tuHV1e9u8DZArbk/uqqNYg4JCtAJI5WYlxyNcyd8uw8RTG4WPjnPdtQqBCOMvqDx1XSFj8g6uucWo3x6wRvx6E3hwQCAlA+lxnFT4FxXh5npOVjRE3DBjVZzjWszVyUeDx1X/+ULOifTc/Mh25xNL4ENDJ/K0+40uky51ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=l4hcFMv0; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=l4hcFMv0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bNpw23jXvz2yF1
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Jun 2025 17:27:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750404446;
	bh=Llxea915k6LzdSVVh5d347vix2QwFPkuKoZ1a41Dx6Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=l4hcFMv0ZLtCfDwqChqiSB5rAz3iNblcm5qseWJ5OgeDRuPfYl+Tvd7ZpGBP2ek7w
	 26jD82lDoH9yVBqfqEYJ4ERn+SACy0Q3/mQ7CkeQuDOFRKXuFc+DQvEueeQRrrQNnW
	 wgZGVNgO3UYKXEKYcDneS5bAHxXO9POMZQBGjKUOwlwuvZRGZLqVr+2IdjaHFSn7NN
	 n5q37/NwLBf6oxnkbV26YaDdc+ctbuElQlRB2riLvUjNS+6Q9IpUSEleYdiGwGtieI
	 aWJ4HrDbms0F0A28V0xUHo2zHWznEIJAxkAUBBF9y9Xk2Z/UusHT1DKLIaPQFMHCc4
	 yZfGX/io7IRlA==
Received: from [192.168.68.112] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 08AD3640A0;
	Fri, 20 Jun 2025 15:27:24 +0800 (AWST)
Message-ID: <623c8da5fdf3bb69b6b63733beb4a63b38cf6c7d.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4] ARM: dts: aspeed: yosemite4: add gpio name for uart
 mux sel
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: MarshallZhan-wiwynn <marshall_zhan@wiwynn.com>, patrick@stwcx.xyz
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org,  linux-kernel@vger.kernel.org
Date: Fri, 20 Jun 2025 16:57:24 +0930
In-Reply-To: <20250618070823.4136687-1-marshall_zhan@wiwynn.com>
References: <20250618070823.4136687-1-marshall_zhan@wiwynn.com>
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

Hi Marshall,

On Wed, 2025-06-18 at 15:08 +0800, MarshallZhan-wiwynn wrote:
> Add gpio line name to support multiplexed console
>=20
> Signed-off-by: Marshall Zhan <marshall_zhan@wiwynn.com>

Thanks for fixing the email situation. However, I notice your git
username is set to `MashallZhan-wiwynn`, which is different how you've
filled out the Signed-off-by tag. I'd prefer you make them consistent.
You can do this with:

   git config --global user.name "Marshall Zhan"
  =20
Some people choose to include their employer like you have. Typically
this is done like:

   git config --global user.name "Marshall Zhan (Wiwynn)"
  =20
The patch is fine otherwise.

Thanks,

Andrew

