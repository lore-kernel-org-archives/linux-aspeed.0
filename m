Return-Path: <linux-aspeed+bounces-1376-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4C4C677C4
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Jun 2025 07:54:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHHxH1v46z307V;
	Wed, 11 Jun 2025 17:54:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4b98:dc4:8:216:3eff:fe9d:e7b4"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749628467;
	cv=none; b=Nix8SrF7wTktFgu3AErzx/7KtNUP5iyTYqX6PERedbk5sDbXAjZb+TczTwKfFDuIs6IMWTzd0KIJe56xLNLa5VcbEh2AdfwJhrOT8OuBea7tg96xlGMgTGQcrc3InjsBS43gCEhKC52BMROt140YpEDHoh+G6juOf3C5C2kw2fds0eSCEroApMBfkYXgcwNIgIYRIIdt//Ilc2mq15WGQcNaYG+4pO8rIdzN52U9hEl1nVXZe76eN1Yid5QQodQ+MuKsBxcN0PHLUuyv4WxewGWer9aAyV9EPdzS1ZhXRgRJGp1U/1qx0EUgwa3GJXyceOEcpD6MHU7boyKzPhrVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749628467; c=relaxed/relaxed;
	bh=KiyDyclqecsk9BIhJPotcA86DvJLdYwDNphU2h/Syvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISmEbUP1snYNxLo4laVVVGZ2C6hd4HefMXQj9PenSrovLdk64p/XlI2d5kGD47JgfVZsfGxjpiLIeKkfgwsqULFb+T/qtq4t7b3v3zEG1sOWkN84dZ/mYXJB7dt3Cry5JzK3gO0LPhoQgwdqls6GpKZ6iKURwdRILS8rSgCXpeBNF0m0fC6b7D9iakdJvvyRn7pj2wIOPu+6Gi9OotIOWXvGY3NpdOX4MTcFHEA5S1YgrXEvHRs0GUjeu+/dbLBeq4YUcMX00wSW8HjcCkKodHCz00zxYitPxjCNxqj0VONPqEGMfvZBjGpKHsZ5LjIE7YO1XXnmX5L40Faz31qgIg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=ExHWWoEY; dkim-atps=neutral; spf=pass (client-ip=2001:4b98:dc4:8:216:3eff:fe9d:e7b4; helo=mslow3.mail.gandi.net; envelope-from=alexandre.belloni@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=gm1 header.b=ExHWWoEY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=2001:4b98:dc4:8:216:3eff:fe9d:e7b4; helo=mslow3.mail.gandi.net; envelope-from=alexandre.belloni@bootlin.com; receiver=lists.ozlabs.org)
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [IPv6:2001:4b98:dc4:8:216:3eff:fe9d:e7b4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHHxD5B80z2yMt;
	Wed, 11 Jun 2025 17:54:24 +1000 (AEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id 927B7581411;
	Wed, 11 Jun 2025 07:35:39 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id E7773443D3;
	Wed, 11 Jun 2025 07:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1749627326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KiyDyclqecsk9BIhJPotcA86DvJLdYwDNphU2h/Syvs=;
	b=ExHWWoEY7rGIzBH2hTP41+dRx7QD45h9+GCRlhMqsGjxIUva5rl/uu6M7C0UepYUk7Y9I4
	y0QCs58j7ZYuyIoZCiOsT7vAdRmdkfa4EtnvTsBT1pAMdwtmXmYU7NRLjlgz/AogBmT9gq
	2US+W4HBVTtpEw73AVkrR8bxCiZTAOQiYLy4Yt0KuNdklqu4q7Okv0y1OK+A26vcxX6zqf
	6wsxpsI6vtrPBsIEOGd0J/N5QdPcZ5QjoQqEX5Kxy9Ra7Jwt2ZmzTwU5dJMbq7HNgHQQcr
	ISRQwIoW5kmXWeccGDoDXEyzEJpJB9DPCj8MHSy8O/THILFtsRDHsDLiDWTTvg==
Date: Wed, 11 Jun 2025 09:35:21 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>, Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Sean Wang <sean.wang@kernel.org>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Lars Persson <lars.persson@axis.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Michal Simek <michal.simek@amd.com>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Jianlong Huang <jianlong.huang@starfivetech.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Manivannan Sadhasivam <mani@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@axis.com, linux-riscv@lists.infradead.org,
	linux-rtc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 17/17] rtc: stm32: Constify static 'pinctrl_desc'
Message-ID: <20250611073521eaf70434@mail.local>
References: <20250611-pinctrl-const-desc-v2-0-b11c1d650384@linaro.org>
 <20250611-pinctrl-const-desc-v2-17-b11c1d650384@linaro.org>
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
In-Reply-To: <20250611-pinctrl-const-desc-v2-17-b11c1d650384@linaro.org>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduudeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehlvgigrghnughrvgcuuegvlhhlohhnihcuoegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeiieevfeekgeevgfegudeuuedtfffgiefffedtudeftdehkeelieettdffhffftdenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmedvugdutdemkeejugehmedvsgguieemvdehjeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmedvugdutdemkeejugehmedvsgguieemvdehjeejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgigrnhgurhgvrdgsvghllhhonhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeegledprhgtphhtthhopehkrhiihihsiihtohhfrdhkohiilhhofihskhhisehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopeeurghsrghvrghrrghjrdfpr
 ghtihhkrghrsegrmhgurdgtohhmpdhrtghpthhtohepufhhhigrmhdqshhunhgurghrrdfuqdhksegrmhgurdgtohhmpdhrtghpthhtoheprghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphhtthhopehjohgvlhesjhhmshdrihgurdgruhdprhgtphhtthhopegrvhhifhhishhhmhgrnhejtdesghhmrghilhdrtghomhdprhgtphhtthhopehtmhgrihhmohhnjeejsehgmhgrihhlrdgtohhm
X-GND-Sasl: alexandre.belloni@bootlin.com

On 11/06/2025 08:13:49+0200, Krzysztof Kozlowski wrote:
> The local static 'struct pinctrl_desc' is not modified, so can be made
> const for code safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> 
> ---
> 
> Patch depends on this series - const in pinctrl core. Please ack and
> this should go via pinctrl tree.
> ---
>  drivers/rtc/rtc-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-stm32.c b/drivers/rtc/rtc-stm32.c
> index ef8fb88aab48a0edad19ae5872421815aa04fe46..d4ebf3eb54aa9e91c8e9f8254f571c53794192fd 100644
> --- a/drivers/rtc/rtc-stm32.c
> +++ b/drivers/rtc/rtc-stm32.c
> @@ -393,7 +393,7 @@ static const struct pinmux_ops stm32_rtc_pinmux_ops = {
>  	.strict			= true,
>  };
>  
> -static struct pinctrl_desc stm32_rtc_pdesc = {
> +static const struct pinctrl_desc stm32_rtc_pdesc = {
>  	.name = DRIVER_NAME,
>  	.pins = stm32_rtc_pinctrl_pins,
>  	.npins = ARRAY_SIZE(stm32_rtc_pinctrl_pins),
> 
> -- 
> 2.45.2
> 

