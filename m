Return-Path: <linux-aspeed+bounces-2984-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63059CFA466
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Nov 2025 05:05:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dFDL56Wkvz2yvN;
	Mon, 24 Nov 2025 16:05:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763960749;
	cv=none; b=oh5ANMdRvOJzhKww6n9QchwhikTWcFHbxsCK5qYgiZKjAqTvLBCoXZH78nWSl2PyTM/1aBUyYLMowEUr9pSKcyfWQ6E68rpYmUAhRRTTMrhAZhjYuxjor0SbMVbqNJdZ7rYTS4Pou4HBSunEq5LBKjtOHIv04BNOJaGWw18tvy3TZXgeYVzT+wGHMqVr3TsaMiRVyfxMW4AXwvn7pXYCIS1MNIMENLiqiPmXz9AUx1302hqi9uQif19U6Kp/J0TpzEtbELiXnIBZwSmf9/WwuNnxoT0JjXTpmbY3hsYEoS1y9lCFvxXGbcntvj6I9b2l7BdV+oLGeaPZgl6bGBK0Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763960749; c=relaxed/relaxed;
	bh=MmvYsdYLqi8x/SH3dyd0R5ZjK0zEZ9vTir8J+3U8sXY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZKgK4SsvH8ZjWq7f2pJckz6a5rQv2tEbexavAcE/RtZUTjoJ1nm3wr2SEhXZX821yz/DprPqJOoK3ozPFoGv1iuWgLmO1icV8C+zBhWhBmdDsWiyV0jpRdpiOi65MAnC3Q+VtJ+80GSHj17qZaZ/yMbiLXwqTiCrq/QGjN2idszzBE1+yXb1qIz+LVeyxFqjj7aOVV/E7xTfhlZwtrHe3oNnCFrXTd5+TRF4HrBuaxsbvUPL8NERvWdDJwZUw899HaxSdPQVvtObYSwz34X7rSNtQcuB8FQCH2UUSG3tesmz/jK75e4GlojIq0cSStH3hbAR0LuCBLKf5EqQeUzX1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=U4n1f8Na; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=U4n1f8Na;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dFDL53hn1z2xQs
	for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Nov 2025 16:05:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1763960748;
	bh=MmvYsdYLqi8x/SH3dyd0R5ZjK0zEZ9vTir8J+3U8sXY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=U4n1f8Nai6P/wji1kcpqWMJCN1Pgwyp7L6Hc/2dmWMe9f19pTgvDvuDOsuOtxq+pP
	 uQd8JsuBDJxBZZLBWlF+ssOO1J0kLRvyWePn4iSWYMkP6FJBnkxDMqGgppd1LfEMeh
	 W3rOt5uwLnflvUn5noi9fLGhdHojb/j9cQboiMr6wlA4yO/X3MKjIcM2Bnm50aPzmC
	 d8hBKLbK0+CssWRCUC/FuzkHdzmqT0tKta1IYs4FC6oRs2gTaYbKYuhjWKFWFBhn3L
	 XK3BCs8CsNEauTX5dKEm8YEvtLOVzfVF0/GG+EtjPFiYMcV04OC+80oi8JWMVtTVzZ
	 02lM+KhhKUmog==
Received: from [192.168.68.115] (unknown [180.150.112.38])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 563C464DF5;
	Mon, 24 Nov 2025 13:05:47 +0800 (AWST)
Message-ID: <9e322334bbb18d559c5f1a73947976218f84f3fc.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3] ARM: dts: aspeed: clemente: add gpio line name to io
 expander
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: kimi.zy.chen@fii-foxconn.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	george.kw.lee@fii-foxconn.com
Date: Mon, 24 Nov 2025 15:35:47 +1030
In-Reply-To: <20251120-dts-add-gpio-to-io-expander-v3-1-cb650ac76f85@fii-foxconn.com>
References: 
	<20251120-dts-add-gpio-to-io-expander-v3-1-cb650ac76f85@fii-foxconn.com>
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

On Thu, 2025-11-20 at 10:41 +0800, Kimi Chen via B4 Relay wrote:
> From: Kimi Chen <kimi.zy.chen@fii-foxconn.com>
>=20
> The chassis power cycle process requires a forced shutdown before
> cutting off the standby power. The SCM CPLD implements a hard shutdown
> host function that is controlled through the IO expander in the
> Clemente platform.
>=20
> This change adds a new GPIO line named "shdn_force_l_cpld" to the
> PCA9555 IO expander at line 10.
>=20

This doesn't line up with my count of where you've inserted it in the
gpio-line-names property? Is there some explanation for that? Are you
referencing pin 10 of the device? If so I feel it would be more helpful
to describe it as "IO0_6" or some such.

Andrew

