Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B033B606A326
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Nov 2026 04:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=GF7ywrzT
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKqmP61P2z2xNC;
	Thu, 05 Nov 2026 15:57:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:3051:3f93::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793854629;
	cv=none; b=itkrexw1oSNamaX/02+2MdK+6FXR4qmAZce+rYpn4UL19pDmqHBFwk3oJs8UTQF+n1UAvC6bkOzjjceWx3RIrVRW12+CA9ORLB0W9fdAc5TZhBoy4xXpfIKpjLsgTC+73FOFYWpVTlhT0OIW22ZnY5lgwXb1NmHqSd9g/u1YTRhbzIbyKSbcJUGWpTSKCg8J03MKLJ9dfljenitqLetHA1/XQgIuWaPU0Kp7nFpyTBV0x2Mg/Fl73u4ISKDnkczlgP8J81F5XUIGRpEsQRmGMjCsx5ZxlVzYiebCVA9QlpBI11yS9F+HQyHXco7t8vO9vrWxYCX8F9C/ebs6LNMdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793854629; c=relaxed/relaxed;
	bh=iu+wu+Zx/NtlCLRN5PCs/YxG7yDVrWiVNMra53EYeJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3KONgteShqRdfD3y0pgfusaEYCVboZlngZ684/bftjL2k04F/l8frRwF2IDIUlRMh6TfO1Dqkpehg8aBrCgH4xcf+R5YD17atxChcMm4wb2Ya7HzWJNcvRBD1AC0tZYjZfmA1VpUH7G9FFBpvClH4ggJytVkxphVayC+mJsi62hTsgqjHiFOW1RX13UDshPKuQXsIILyew68+pJfIm3UqN01fMpD1Y/qa08Z1BEqiQwrP4qIPYnuLPP8cYfIOdCSr3KpHwCnuTP5n4hBrwJpenKIwkUfnpl4Z/pWA6QiC5j7wxSF05vK5g0Yf5h/YtQ+g+jB5AvOE/YW2undB3z2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=GF7ywrzT; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=GF7ywrzT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKqmL6yF6z2xHG
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 15:57:05 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EBCA740E0299;
	Thu,  5 Nov 2026 04:56:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wsGM9sTHQm2m; Thu,  5 Nov 2026 04:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1793854612; bh=iu+wu+Zx/NtlCLRN5PCs/YxG7yDVrWiVNMra53EYeJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GF7ywrzTQZ6wEHZIFfdeWnirhkOvcOJFxiVrxYiRH0aY05M7xKyHS0sGBRA8n2s2M
	 dJd4WhV9WzQ7ochMxOUgRrEz5y0ZEpAJZEyg5fhjTFjQsbvQdbXiBsIDpPU+Z5SXwc
	 aX4fZUf1z9evJkNy1kfx+rK0gwfdlcYzYIkb6DzfqsK50kJZkmucFgt8Ds1QHsO7Ei
	 8HMFrbUKv9L3ljhBY6cGmdD1Uxbpofv7JdmHxvynTAT8c7WXMNnOPcxnHLvkSj4FGk
	 v1VMnL4Ubm+nit/kNnQRQ1eQn2Oa25hVosc1n4YQpXtCPYE07TuCORD1JdMEZRBva7
	 3/TbnXvQPR0LNPKgbOfsXm/X7oaLui5ok/ZO8UL1RM0pG7PnvI3cKS/jwReMNom5rB
	 SBNZB38/Te2XhJsQXjulGCVr2I2JhhMLoSUqFEtVPVf9fzTIX2E6WN33ScmJA78vMF
	 AzwexkNCTIW8c4d9d1R5GOAFi/mqLSCtnlfWONXnSaR7gbMmHJ4mZO1z1tXJk1vnjS
	 M4rJmM2CqEvRT5MdYzqeQBAZItq6Wd4AEqnlJlr+Ec9rIIgKDDQhvOmLiXmorhl+yx
	 khIdhO8MU5KywJeSCsJtkXM7qOc8DcSP5jM7bm/ejk9B0fV4bc9s7cM0DJRxU59RxO
	 C648Rd/lSWIroYXKWCf2ENgk=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DAAA240E0184;
	Thu,  5 Nov 2026 04:56:37 +0000 (UTC)
Date: Wed, 4 Nov 2026 20:56:35 -0800
From: Borislav Petkov <bp@alien8.de>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Stefan Schaeckeler <sschaeck@cisco.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Tony Luck <tony.luck@intel.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH v5 6/9] EDAC/aspeed: Replace regmap with direct register
 access
Message-ID: <20261105045635.GBauwMg0oqd2tVPH-4@fat_crate.local>
References: <20261007-edac-v5-0-5c31fc5df4cf@aspeedtech.com>
 <20261007-edac-v5-6-5c31fc5df4cf@aspeedtech.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261007-edac-v5-6-5c31fc5df4cf@aspeedtech.com>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 07, 2026 at 02:13:23PM +0800, Ryan Chen wrote:
> The driver instantiates its own regmap purely as an MMIO wrapper: it has
> no register cache, uses custom .reg_read()/.reg_write() callbacks, and is
> not shared as a syscon with other drivers. So it brings nothing here
> beyond the spinlock that regmap takes around each access when fast_io is
> set.
> 
> Drop the regmap and access the registers directly with readl()/writel()
> under an explicit raw spinlock, held across the whole read-modify-write so
> the controller is unlocked once around the grouped writes rather than on
> every register write.
> 
> Annotate the register base with __guarded_by() so that, under
> CONFIG_WARN_CONTEXT_ANALYSIS, the compiler checks at build time that every
> hardware register access is performed while holding the lock.
> 
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> 
> ---
> Changes in v2:
> - Take the register lock with the irqsave variant in init_csrows() and in
>   aspeed_probe(); the interrupt handler takes the same lock in hardirq
>   context.
> - Move the dev_dbg() of the interrupt status register out of the
>   raw_spinlock critical section in the interrupt handler.
> - Opt aspeed_edac.o into context analysis in drivers/edac/Makefile, so
>   that the __guarded_by() annotation is actually checked.
> - Note in the interrupt handler that the counter and interrupt flag
>   fields are read-only, so writing back the read value is harmless.
> ---
>  drivers/edac/Makefile      |   1 +
>  drivers/edac/aspeed_edac.c | 131 +++++++++++++++++----------------------------
>  2 files changed, 51 insertions(+), 81 deletions(-)

https://lore.kernel.org/r/sashiko-outbox-162667@kernel.org

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

