Return-Path: <linux-aspeed+bounces-2491-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85377CCD184
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 06:33:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnw4p0ktXz2yrt;
	Fri, 17 Oct 2025 17:33:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760682809;
	cv=none; b=ONCYUfxIfE2jfPQAZwOeklfFZVJNi1r4VVZYY2smvfo9ksVHK6NcTe7NSDpi0HbPtnVHC2OQKVxqIzViOGlSN/4DXthv2ml/V3S2cGBUeJpjtNaXkZZlM0wokq9mJ4bQ70d/dtNiBY9lolMX1ZaqtwydNDwc9TtG5zr7+VsntWylG7xJ/C5+qRyVvqNTNuuQmL97KsrFSvPSOQ3o8aAC5urB7ieHor5RE1GShpdKKXdxaALe+SE93TubG4Emah4h6te8D0mjLNBLyQvKnVWiSH++FZC8IwpM4D7DeFNljLiCZAj5buDv0O2kPcxdPk7P/6Aw6+Opd2dcGsVGz16qlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760682809; c=relaxed/relaxed;
	bh=l4zzfEVXv3kCRK1+tRhEDpGxTNtWTV7qUWhG7JQ8YIo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FfRdsFBk/lFtJeMxFbXt+KTgLzAdtFKmbvUiYYPUrdXvyD4krTcmYxVLfG1DtImWXRKN6lRSPE327xH+Qp8+22+bCZr6JsEaZ5qV1fU2WYqP5rX9PqGOLkXG77u0oirEbQhuaFYfhVI3HVoEQd7w/F2TZ13dqh3epnrPYxt7YKYzWMdvhpF8CYVgLjjvUMK2UCBRPsNwN5YMplVSSHj8P3hliM5jsp+mrY1f9IoCnmXJNNpk8HLV9yka3l7qyEFMRZoO7OTmWqBz/boztmCtLtlC0wjHBREEPpCwEGsGnAakTHiU9qYnNdaUC1pFMXLqfmV4+Q/RwQE0TUkmb2u4Cg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=STF6XOpt; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=STF6XOpt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnw4m2rVLz2xQ0
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 17:33:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1760682807;
	bh=l4zzfEVXv3kCRK1+tRhEDpGxTNtWTV7qUWhG7JQ8YIo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=STF6XOptFjEdvztYJZwPnC0JyF6vqPLgDYj+odIW6iC4xrMsgOUu1dfvk5Hggrdfk
	 Z1nlI8gOrbCAB5obJh5jS0l47Ed0gTddOrs8sXOSM2qvt+AL3pcz2x3BlrqSPptDfb
	 Ghzz7Tsp1a83YtdmlKCHDDndNwStg1z+lbxlhI893/kEk5sgabe9Wkj8J/p/xxp0PU
	 OItXpZqj7Z7cNUNnxhjvgAdyBiYYHEr7ORzntoPlKozXdtE+XbDi5HtEOU8Sv/VsdA
	 EslNzMXdoPc8kCH2pGRB4AF/2Jjx2sOGSgxLLWhqLltHKnc89xnqVBcK+rHgVO+dVf
	 O4+fKXtQSvVNw==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E420D7702D;
	Fri, 17 Oct 2025 14:33:26 +0800 (AWST)
Message-ID: <8bf232de1d4254afc408b415d3476c2c2183a4ac.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: bletchley: remove WDTRST1 assertion
 from wdt1
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Cosmo Chou <chou.cosmo@gmail.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, joel@jms.id.au
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	cosmo.chou@quantatw.com
Date: Fri, 17 Oct 2025 17:03:26 +1030
In-Reply-To: <20251016052727.881576-1-chou.cosmo@gmail.com>
References: <20251016052727.881576-1-chou.cosmo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

On Thu, 2025-10-16 at 13:27 +0800, Cosmo Chou wrote:
> Remove the external signal configuration from wdt1 to prevent the
> WDTRST1 pin from being asserted during watchdog resets.

Yes, this is certainly the immediate impact of the patch.

But what's the motivation? And if asserting WDTRST1 was the wrong thing
to be doing, why was it done to start with?

Please address both questions in an update to the commit message.

Thanks,

Andrew

