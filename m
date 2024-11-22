Return-Path: <linux-aspeed+bounces-168-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A35E65D0B
	for <linux-aspeed@archiver.kernel.org>; Fri, 22 Nov 2024 00:54:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xvc7215cMz2xMQ;
	Fri, 22 Nov 2024 11:54:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732236846;
	cv=none; b=K3o8ouGcnWBSnNo4T8v2AkoXhBpK63vDiziKmyndzUk8ryPsE0YHfrzLVhRk/nT+cSHQtaMugflcM0yVAzJpyKvcl3YWr8Jo82KWjbia3TISPpHLmP+8SVMcGcbIM0eBlSntc92hpAiDQCxQlCQmBIag15j1MpbfohQhBXjZK6hYQdFAOeDMOM9CxIUqnQyKccjunF02mIrUZodRTP9JRVQJtka6ResJOWYxXfG9gMNOAbj61EBlhj3m5MX9vOk1Gw6lcNxY/i+0GM4MjXDm3mqMK3RMz73OvV3WiLpLF36cknyO06O/DyG+B4gEWwnY7cx04LuMHz1kG1fG3Q6zyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732236846; c=relaxed/relaxed;
	bh=T1I+8cWLkRZIi/BV4IKPI5W32DddwVLd1vKWfehM2gA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MveH7fp2Lx7gDGgXlhnZQbjTHMEeXuTrCS+D+qrzko4GCj60SoIxEJtrg0UseubeugkrUR8hWRHlPzP7v2PgnhpAys/hDNlEAerunOVK4V371nV5oku+Ppqyav8Aqje7x+c49LvcjSnASFOSUscjZhzGtGP8AevWA7eywt8e6LyVRBfFZlE9hMXY5FWH27zgv9v5gadgC/kU0eQJ6WO5wYC5Xf01tfRMmWJd/H6euG+ep87CdTYn2I0/oZ/N07tJVuq9767Lqod2HY9g3uoPoimkubc+p/btHCd7Po318ps3nWCa56iAE/LRWMWxaH3rLg/BF+vFf1Gjh2tEip2cvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RU73TvfE; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=RU73TvfE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xvc7041fBz2xKg
	for <linux-aspeed@lists.ozlabs.org>; Fri, 22 Nov 2024 11:54:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1732236841;
	bh=T1I+8cWLkRZIi/BV4IKPI5W32DddwVLd1vKWfehM2gA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RU73TvfE9jQCiayiefvYQq6OgCagPxOTLZXEkNDt96tKd0KZJIgesMdZGbaWIQFUZ
	 9skdEkbMBUInwC+EaFpWF9P40wZD4j8D2Co3U2vvENhpb+kOYeSb5GOA8HQqcDC9Ts
	 pmZhr41GyJH6WlZlalhT59KnweAlhD6WT8ZLmBdipsSiJToUtsDysu0GUoXhyGq/36
	 huXQipJhSIt46ScYrAamK9JGD41x4gWu+T4TPPqwQsDZN2r/FItXuDOlu2dI+znp5b
	 nGpgLY8Ra+nw6nGiYNCwbj29EjuiiYS+kCY8Z1LlAmxZwy8fob0ixrWiY0ekT1eQ9H
	 5npHOCCECq7YA==
Received: from [127.0.1.1] (ppp118-210-73-187.adl-adc-lon-bras32.tpg.internode.on.net [118.210.73.187])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9EF3068F88;
	Fri, 22 Nov 2024 08:53:58 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Patrick Williams <patrick@stwcx.xyz>, Potin Lai <potin.lai.pt@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>
In-Reply-To: <20241121-catalina-dts-20241120-v1-0-e4212502624b@gmail.com>
References: <20241121-catalina-dts-20241120-v1-0-e4212502624b@gmail.com>
Subject: Re: [PATCH 0/2] ARM: dts: aspeed: catalina: revise catalina dts
 file
Message-Id: <173223683845.339623.11713825079934765892.b4-ty@codeconstruct.com.au>
Date: Fri, 22 Nov 2024 11:23:58 +1030
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1

On Thu, 21 Nov 2024 12:34:03 +0800, Potin Lai wrote:
> Add following patches to fix issues.
> - revise ltc4287 shunt-resistor value
> - remove interrupt of GPIOB4 form all IOEXP
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


