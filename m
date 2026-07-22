Return-Path: <linux-aspeed+bounces-4540-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF56C44536
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 15:41:05 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4z4H13GCz2yVd;
	Thu, 23 Jul 2026 01:41:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:3051:3f93::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784734863;
	cv=none; b=LYJIS49qpywlrTD9YDu/ooKiThMyRICKbtK6N42P3U4t6Q8yzJPuTG/itaooIUobXAC3SDldzN9n3bJCTJJRmWvdEx6GdbMQBCLnFsQ+XBD3odQv1eV1p03IdN37JLbpX+PSnNQ9yV55HK7D5XbHHfQQhdrqaZlXOpOZq0zJ2i/eOVgwtcwyYUtkP8srgEtY3EwzQUHgPeGaYxNAgNnxKGJGRPHd2V8+MbR1WF8WXoNKyd/z3//zFSJodUTTzLnQq3Qnl87T8DfV0wnwoxjttTbzJjJQqdj1wP9YrCCpoj1xnarHVEn3aX5zfB0eP+ZCvFQKmJ6QyEqEHGDtUedysw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784734863; c=relaxed/relaxed;
	bh=+XBZRhKpknaN9ie61rDFV9v+KJvFVfjWzRKaC3sDmO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWzkb8KtGXM4vl/Q4/4qiiIaNfiovnhDs56O1TJVDk5djQB0K6PSIBXW9jkI9j+T9Z86N0m/3RvXanTluTWYY7HkLK3NB0hY1ECcEUhrw60//vnZy3Sz3mi/lZoOyjNWRz8n74S8ep0zlgI72aO4Xh38ka5DJZJLaxrfaSpevTBl12QNDWxoqvpFfZMqbTLWXhY3U4TBaVHhMgADrARg6a9QSMr2aa+1D+Tt3tRvsulSwt4UpkGPH+V4TTcAeL1934VoRwEq819HcxpHiRS0+0TNOVBIn6mCfMpvxfPw70ER7CCGXzEpkB+AUgsbZfGtkRMmfl1onSfSdS+d32c+Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=faNcpSa6; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=faNcpSa6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 321 seconds by postgrey-1.37 at boromir; Thu, 23 Jul 2026 01:40:59 AEST
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4z4C0WZxz2yFK
	for <linux-aspeed@lists.ozlabs.org>; Thu, 23 Jul 2026 01:40:58 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5362940E00C4;
	Wed, 22 Jul 2026 15:35:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Ut7K_oDegzWP; Wed, 22 Jul 2026 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1784734514; bh=+XBZRhKpknaN9ie61rDFV9v+KJvFVfjWzRKaC3sDmO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=faNcpSa6xVfsnQIYl/CUXMMs6ASkhRB0yoDgBH9DwQupc0uTRFB/F9/LJoPzrKXSI
	 x+2wiROamekYhcg5CsD6Szr6hqbF5Wl29eVEOfxYDPhZiOjFSaAdDRlMxFhPN3JsqJ
	 eLbheNeZguE+iajoxqT4O8h/V0AXeTS/Qj1U9QAVyW8PmXUYDPr18lDOhMyKbq41AC
	 kke4bENmeypiNDMI9PiOJ/nm5+6wdanIDXfwbV2Fxg5p4WsP7ketpZ4LohCRnaQq74
	 hryCQIHdi5nHIG5yu8awSK7Qayh/3vk4ASXTvLr3rZW7GAF3Ysthkob/CVgbgnRkpL
	 UnYRvhedHLUAHVNx58EekH+DLpMnwz8sIqUUn4PTlAXqx6UbqHeZaUwKTbqaSk3KAC
	 R3pWCKc2nxL2oc5Ys+yOPdd5MzCy7P9FxzWYW4VfUCljoNsw68yHDbSS+D+2CdGxnc
	 Zr3goeUiS6K4u8iajxvSpu1G1uoRFeR3J2Y9LMf0UF84C5QHrdFgs2pg1k2Mg+OO0P
	 QjwXmBGOTAXtQy998c6+3b0Y2dNP7Ztb4RuOrmqQJuUrh/v8bGyGIeSZpSmlDmoQzu
	 k3Y1cHRuKklPNBS6G++YxFNF+bjmP8Ku9mdc5ikN/WOiZKKWuM9m8JM7X+XFZoguzP
	 N2bKi6buZGkgVPY8LaiGpX0U=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F01CA40E00DC;
	Wed, 22 Jul 2026 15:35:00 +0000 (UTC)
Date: Wed, 22 Jul 2026 08:34:57 -0700
From: Borislav Petkov <bp@alien8.de>
To: Pan Chuang <panchuang@vivo.com>
Cc: Talel Shenhar <talel@amazon.com>, Tony Luck <tony.luck@intel.com>,
	Stefan Schaeckeler <sschaeck@cisco.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Andre Przywara <andre.przywara@arm.com>,
	Robert Richter <rric@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	"open list:EDAC-CORE" <linux-edac@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/ASPEED MACHINE SUPPORT" <linux-arm-kernel@lists.infradead.org>,
	"moderated list:ARM/ASPEED MACHINE SUPPORT" <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH] EDAC: Remove redundant dev_err()
Message-ID: <20260722153457.GBamDjIXWetAs3s-U7@fat_crate.local>
References: <20260713131510.332386-1-panchuang@vivo.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713131510.332386-1-panchuang@vivo.com>

On Mon, Jul 13, 2026 at 09:15:10PM +0800, Pan Chuang wrote:
> Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
> devm_request_*_irq()"),
> devm_request_irq() and devm_request_threaded_irq() automatically log
> detailed error messages on failure. Remove the now-redundant
> driver-specific dev_err() calls.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  drivers/edac/al_mc_edac.c       | 12 ++----------
>  drivers/edac/aspeed_edac.c      |  4 +---
>  drivers/edac/highbank_mc_edac.c |  4 +---
>  drivers/edac/thunderx_edac.c    |  4 +---
>  drivers/edac/xgene_edac.c       |  5 +----
>  5 files changed, 6 insertions(+), 23 deletions(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

