Return-Path: <linux-aspeed+bounces-4599-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B11C55171
	for <linux-aspeed@archiver.kernel.org>; Sun,  2 Aug 2026 03:11:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hCPwL3DTpz2yNn;
	Sun, 02 Aug 2026 13:11:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785537722;
	cv=none; b=kQH/9kcHEkBVVLxb7DPh2rmClrUDnArZanR3YV+zw+w6kEN0LJgYe9UsRE0Scr0tLnBYFJabBnc9zr3V4WmWppBv8AXGlkP0K/hSvxhKRkYtXVuxarqtOKVM3D5QMDhzaZn/9Is1lgerZi8Sv9CIC7uOGhe1T1nhZezBl9lROTY3Ao1A1HJaij3pTcxPBtS88eAWM7Fyk7j1LLKFwwDx4JO6bkYuuHeJ9OBT9qkW3GNwuYOxncWpLbsRcQqsJJFVmb6Mnnw57+H0oJvmG2rgKzgv/VRcnxxulSbHAc4OClc8ySLN1AA6hZv6OY7Gx3xZZDyCcC2mEqygiJ1KIes8KA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785537722; c=relaxed/relaxed;
	bh=4O9p1HgfmCPNuO8NrFXNLQh/x3qwmv7rnJHjHYwKXww=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEBPy2HRzgY//RyZ3SSLHVAfAFL+qlbMdsB8obp1IQJbhbUsl2QbAnzOnYPMGmuPRgkZKDcKJ4F0yGIlMPf+PBe1VOHwzPMn7AE03x8dyukSVIeuwtVef3UJBXQ5SiUSFUb7GkquHnT8oKcMTlh1cMTptk4XCcD1NlCiI3YHN6Is6j0iZcqapV4OAptNRNa3ucAPLEk3qvOMrXY5/kVaS9knU6KwuyXFBduUfkhF12ZqqmNh7p+bKom06NqJxA8oftR6qHcoo2hb6cIhOYE9vaH1C/1cSVpnlOAhJ3k4LZoZeAuAERSueEXOolxJKx3XktjLJNlO3JHANpFSZ8UsTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=0KKjty0d; dkim-atps=neutral; spf=pass (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=herve.codina@bootlin.com; receiver=lists.ozlabs.org) smtp.mailfrom=bootlin.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=0KKjty0d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bootlin.com (client-ip=185.246.84.56; helo=smtpout-02.galae.net; envelope-from=herve.codina@bootlin.com; receiver=lists.ozlabs.org)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBgzr3Dwhz2xLq
	for <linux-aspeed@lists.ozlabs.org>; Sat, 01 Aug 2026 08:41:58 +1000 (AEST)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 568CF1A136E;
	Fri, 31 Jul 2026 22:41:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 28C286039A;
	Fri, 31 Jul 2026 22:41:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E7D8111C16E1E;
	Sat,  1 Aug 2026 00:41:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785537711; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4O9p1HgfmCPNuO8NrFXNLQh/x3qwmv7rnJHjHYwKXww=;
	b=0KKjty0dM7ebLLjGiCJKPaCQjGBzRbPIr9XjLPmQ+bpL4q8cu7H+1zyFd243pIJXOUxI0w
	qnBF5o7cj1TrnAd/fVBsJHnH/ld2r57x/y5hLhI55HrSEiYfyCz6wQHxAsvWWD96Ccy2/b
	Swtkbry9la+J/VJCnTZENyD2ySfmF+XqxORC72KxAKuQiuIpe6dDmyqnUWF5OjqDr9blqk
	JN+kWNzw9s+jr483d76Abh8yTTefuISnO8INgZunCszadmPo46Wwo4uVcMo91k9QD59Scj
	a49XNG8fcD9K5/8kB6wR1lcsE0TG+2ziyLzOobChCWqCEmgkseaNvn9VjG9R5g==
Date: Sat, 1 Aug 2026 00:41:43 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joel Stanley
 <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Neal Liu
 <neal_liu@aspeedtech.com>, Cristian Birsan <cristian.birsan@microchip.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
 <jonathanh@nvidia.com>, linux-usb@vger.kernel.org (open list:USB
 SUBSYSTEM), linux-arm-kernel@lists.infradead.org (moderated list:ARM/ASPEED
 MACHINE SUPPORT), linux-aspeed@lists.ozlabs.org (moderated list:ARM/ASPEED
 MACHINE SUPPORT), linux-kernel@vger.kernel.org (open list),
 linux-renesas-soc@vger.kernel.org (open list:RENESAS RZ/N1 USBF CONTROLLER
 DRIVER), linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT)
Subject: Re: [PATCH 05/11] usb: gadget: Remove redundant dev_err()
Message-ID: <20260801004143.1b0d864d@bootlin.com>
In-Reply-To: <20260731035448.252289-6-panchuang@vivo.com>
References: <20260731035448.252289-1-panchuang@vivo.com>
	<20260731035448.252289-6-panchuang@vivo.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Pan,

On Fri, 31 Jul 2026 11:54:39 +0800
Pan Chuang <panchuang@vivo.com> wrote:

> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"),
> devm_request_irq() and devm_request_threaded_irq() automatically log
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/core.c | 4 +---
>  drivers/usb/gadget/udc/aspeed_udc.c       | 4 +---
>  drivers/usb/gadget/udc/atmel_usba_udc.c   | 5 +----
>  drivers/usb/gadget/udc/r8a66597-udc.c     | 4 +---
>  drivers/usb/gadget/udc/renesas_usbf.c     | 8 ++------
>  drivers/usb/gadget/udc/snps_udc_plat.c    | 4 +---
>  drivers/usb/gadget/udc/tegra-xudc.c       | 5 +----
>  7 files changed, 8 insertions(+), 26 deletions(-)
> 

LGTM for renesas_usbf.c.

Reviewed-by: Herve Codina <herve.codina@bootlin.com> # renesas_usbf.c

Best regards,
Hervé

