Return-Path: <linux-aspeed+bounces-5090-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478C1CA5FCB
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Sep 2026 15:27:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvzRr72FKz2xSV;
	Thu, 01 Oct 2026 01:27:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790782024;
	cv=none; b=CkdT5TDqGd827g0mFclzR7ivTASpmsg110gFzpciPb2P4YU2YowYFcjCU/G0DykeMYbBDAcGiw/02GhK0DP39WQQdZ2o/HDyOrp0mWWfP2BsEzGimk+uQDarFad812Tbu+kjiLWonFJ88LxKaAW4G8QtROjwL5kL/1zzYAVaTHeTiyLLu3fPyMVzW5qq6Tibb+/S9VlAqCXSdh1UseExLgGa2wyxGaAF3VZY82nbbjflLxNl+ZpjBpiC9yhN50mMMLr5mASrAmGBIWESogZdEfDd6wv/nzYXgE1HvtgdMfch685jMcnH6qTyIVRb35iIPacfJO/FM6aIkUoTxVvC2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790782024; c=relaxed/relaxed;
	bh=WKdkz1BYvLrQk/8aMA/M0VzHCoi8lQfFBU94QLV8ZrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhEyAtf3950kO/7Z0nzvHhp2jDepKjzv7p9pbXW3yXeCMv+6kmgnyAD8MJsJnZ6XqKUwBEWd9LD93oAp3R7SLCrxKSmDAwwKqQ0ddrqylEYL1KJVXVHVgpINF8Z84QJB5D/tc72JcFkamxjfsElKnRl8XI0pGLP2WjbtP+DcwroxdTNVe4BsyXngNgsF4tcWElzFQooNsmpYcc6wJrbc96hdOUwpk/k3df1oQ13svkm1XBM/z0mxqMb5zvBMtmiNTNt88ocfNzfPpBvhKqxG3S63M5Z7zHJwXGXwaRlj3dtCAIzu9nK+NOWCCG7Dzfcc2vYY5A8vd+DLDrTnNJkCjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YCigCSQ/; dkim-atps=neutral; spf=pass (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=alexandre.belloni@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=YCigCSQ/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.85.4; helo=smtpout-03.galae.net; envelope-from=alexandre.belloni@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvzRq1FCXz2xM9
	for <linux-aspeed@lists.ozlabs.org>; Thu, 01 Oct 2026 01:27:01 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6B3D24E410D7;
	Wed, 30 Sep 2026 15:26:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3B8C860749;
	Wed, 30 Sep 2026 15:26:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B2917103281E9;
	Wed, 30 Sep 2026 17:26:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790782013; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=WKdkz1BYvLrQk/8aMA/M0VzHCoi8lQfFBU94QLV8ZrY=;
	b=YCigCSQ/jqKVGvnheb3+DGcKvvYgGY5QvVbgPml2ZqdCs1fe0uap+hqMvnedjqX5RbmJo/
	0+wacTSCNn+VDU+AanMmOpoloFY86p0C8dQd8Y0XKYpmiIvRdm0V2L3jOlWOFgWJUl6ocx
	U9n4cEtex4QKLKEXj7ItBIF0T7hKcE6RynSirU5B/lclASfld4seim4lyBTYwguZ+SDnB6
	VLpiUKoHPhqDbqsCNkPK+/ogSn6TbkC/4pitlJe+zVLBV1AQTgv6Nfo1yzdrsDBd8zcT/Z
	ZYwSGoAaqEW+n/RnuMbDmHmK/kt7Lge14ZjxcZ+r+KzyCYnH0eQuWGI7PqkFgA==
Date: Wed, 30 Sep 2026 17:26:46 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Billy Tsai <billy_tsai@aspeedtech.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaGOiBbUEFUQw==?= =?utf-8?Q?H?= 1/8] dt-bindings:
 i3c: Document the AST2700 I3C controller
Message-ID: <2026093015264653e04d9e@mail.local>
References: <20260901-b4-i3c-hci-ast2700-v1-0-19909e7cbd7e@aspeedtech.com>
 <20260901-b4-i3c-hci-ast2700-v1-1-19909e7cbd7e@aspeedtech.com>
 <20260907-imaginary-economic-oyster-57cdd6@quoll>
 <20260917154754dd1eefbe@mail.local>
 <SEZPR06MB7237179374D186C39384D9808B812@SEZPR06MB7237.apcprd06.prod.outlook.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEZPR06MB7237179374D186C39384D9808B812@SEZPR06MB7237.apcprd06.prod.outlook.com>
X-Last-TLS-Session-Version: TLSv1.3

On 24/09/2026 05:39:47+0000, Billy Tsai wrote:
> > I guess we need to make them generic. Probably nobody needed them yet
> > and not all the controllers will have support anyway.
> > However, I would like to make sure we get enough commonality between
> > controllers that support setting the timings individually, can you
> > check?
> 
> I went through dw-i3c-master, i3c-master-cdns, and the AMD/Xilinx AXI
> I3C driver. Every property in this set has a direct counterpart in at
> least one of them:
> 
> - Open-drain and push-pull SCL high/low: dw-i3c-master has
>   SCL_I3C_OD_TIMING/SCL_I3C_PP_TIMING (high/low count each); the
>   AMD/Xilinx driver has separate SCL high/low and OD SCL high/low
>   registers.
> - SDA/data hold time: the AMD/Xilinx driver has its own hold-time
>   register computed as a percentage of the low period; cdns has a
>   data hold delay explicitly there to meet the MIPI I3C tHD_PP
>   minimum "regardless of PCB balancing", their words for the same
>   board-variance concern we have.
> - tCAS: dw-i3c-master's own comment says its MST_FREE register
>   represents tCAS in pure I3C mode; the AMD/Xilinx driver computes an
>   explicit tCAS minimum from the spec value.
> 
> None of the three expose any of this through a DT property today.
> They either derive it purely from the bus rate, or hardcode one fixed
> value per compatible (cdns's data hold delay is a flat 10ns baked
> into its per-SoC match data, the same default we picked
> independently). So there's no existing naming convention to be
> consistent with, but the underlying quantities are clearly common
> across implementations, not something specific to our controller.
> 

Thanks for the investigation, then let's have them in i3c.yaml.

> Thanks
> Billy

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

