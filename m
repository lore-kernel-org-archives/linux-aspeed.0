Return-Path: <linux-aspeed+bounces-2903-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F12CDE001
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Nov 2025 03:57:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d73Hf2qsWz2ySq;
	Fri, 14 Nov 2025 14:57:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763092638;
	cv=none; b=RGpbcO9QfjH+UEI8aXryKbO5WFcddLLwgAo0u7aM3r/siEN+No0Yn/nuFb5P9mcXFcqvsY2CzNZIkhH+wREAZwFU/oFIHIBqAOdMmspZ15Qee0k7tt7WtdJlvv3x5YhnR+6ugcD2Xt0p/8LMTT9XTuxvBbPTX43IgVnnMJB5UBrsMOZcb9V3uA1kFRG1N+E72IyfgR2gI1TWI0bgoaiRNcA1Sm4R/UejGJ0cNKjLP+jsjglL/OjA+YkSDNqKYzdK4EUxeHrx9vVX73DeNufxgmGXJ98FVxb4vyILha3s9CtqR5qPf3xPfF3CcOz4VDvTeRSPA5398rBVzf9x9amM9A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763092638; c=relaxed/relaxed;
	bh=PBEe7m4ruu9JlDhXEHQH8OB4d4RdZCG95qxZSNdiuTY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IQXv+sgFUwQgeNgGli8oqv96FQacVcVqBKjKlCmF9lSBTDJvgGduku85OzcJxdHR9RHHt2BJKJycBfE1waqSWNxWwVXEguBl2ASRbfBok2RL9ONALWbWnydtkOnJd4elbhcfEPBXmTzOteq520JVcoqErgCXeN2pIOLWMntwAOXzJrnQEI8E8zWOJNR32zDSb186fJEE1o9pJRsqQNfpizcZKflX3xFvFA3nIqGg0iDduZ2ePouhIvI4RlENjTNHupj60Eg3c6jl8rvvVvSRlZs5jq4njEVVzeHM00eVN9pAFnQKMkaq9YgZ1HzjSWvZbHsV/ohtYBT9VTrgcQ40+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=aLxhxlYH; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=aLxhxlYH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d73Hd4slcz2xnh
	for <linux-aspeed@lists.ozlabs.org>; Fri, 14 Nov 2025 14:57:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1763092637;
	bh=PBEe7m4ruu9JlDhXEHQH8OB4d4RdZCG95qxZSNdiuTY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=aLxhxlYHg2hEiiWKzEYXsroGVyP6tEsllRg0s94dGktPw0RofSA9ijkHG8FF/F8Dt
	 dI7hgQVrAO/cPcx5AhN6WWJwHb4wdOynv4GwtrHCxfqDMi5Fs1fRKcKBDARkSJzroS
	 FaBRKGR7hQj2aNoXKlb4bot3zw4eHiRt2ugKzPAtjxcMVeVkPdeiZqxr17xPrSmyV1
	 vvbzLcyMXTPOKtbNmUyuCqjqR1mHVkNT+Kby05srb5zpEItW2ExrTFr63MRB8nb5YS
	 NbxgVsIXvxMj3jFNrCNzd4sF/sWpsarQjuFo9kBRD+3mZJY1MLPgWzIwNWEg2Ey8Ec
	 uK19jp5cSwzUw==
Received: from [192.168.68.115] (unknown [180.150.112.244])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 752DD783DF;
	Fri, 14 Nov 2025 11:57:16 +0800 (AWST)
Message-ID: <0118d17eb884ee664a035d44ddbbec56a418e353.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt: aspeed: clemente: move hdd_led to its own gpio-leds
 group
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: alex.ts.wang@fii-foxconn.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	george.kw.lee@fii-foxconn.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>
Date: Fri, 14 Nov 2025 14:27:16 +1030
In-Reply-To: <20251023-leo-dts-add-shunt-resistor-v1-1-5d9980aba308@fii-foxconn.com>
References: 
	<20251023-leo-dts-add-shunt-resistor-v1-1-5d9980aba308@fii-foxconn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
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

On Thu, 2025-10-23 at 18:26 +0800, Alex Wang via B4 Relay wrote:
> From: Alex Wang <alex.ts.wang@fii-foxconn.com>
>=20
> The gpio-leds driver requires all GPIOs in a group to be available;
> if any GPIO in the group is missing the whole group will not be
> created.
>=20

To me its behaviour appears inconsistent. Contrast:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/leds/leds-gpio.c?h=3Dv6.18-rc1#n176

with

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/leds/leds-gpio.c?h=3Dv6.18-rc1#n281

The driver should probably pick one policy or the other?

>  The hdd_led GPIO is only present after standby power is
> enabled, which can prevent other LEDs in the same group from being
> created and blocks properly setting 'bmc_ready_noled'.
>=20
> Move the 'hdd_led' node into a separate gpio-leds group so that other
> LEDs are not blocked and the 'bmc_ready_noled' flag can be set
> correctly.

How is standby power applied? What are you doing to enable the use of
hdd-leds once that occurs?

Andrew

