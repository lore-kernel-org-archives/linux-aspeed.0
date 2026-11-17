Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AFC606A31C
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Nov 2026 22:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNai+9v8
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTfl03cYmz2xyB;
	Wed, 18 Nov 2026 09:38:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794904363;
	cv=none; b=kJUAYqwJRxEAJtNPI1bYH+IxLqYMnxCU4kntSC54CNqUvRp6Qcp47b4g956YtrJJMCMTaloolqCpLGYLcnVpaNu1LgBmt3snz97bRHtRA6BQxUGPzzEWQuFYmZT3pyaOQ6OWjbWGsvJz81paIIto4f88ij1BrsbrXUqcTqNG+AeHm04r7cSKASwnsT5nIxUhwaQVwybUPNIrGj9Nu2N8DNJfTemSDtMFDPxvtefn3IV2vvIcbcHO890mNZWhVp1QUQkQtl2O/pwhTmENoGzCO75pkYRWd5OsPaUMNaPZ4qubUm39ArP7vv31EWVT5KzVKEjLAuvHDDZzYEzVU0eVgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794904363; c=relaxed/relaxed;
	bh=sUnKsuDGKFImQsuMY/DHbO5AZYpcq2an3IW8zzTpUo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UU9kcSLaThgTbxLdKbxyUJMGaeI7W74f/29QXl2/DuHC3IhQR9SqCn8j7tkjhIwmwnz7mlWYt2OA1lMb99C7xFBtMVN2w2d0whRym7JTuMi/iEraVWpn8yMrqO7qLmRnXaJvW6xkU9hv1dZ8EtXMx0EPB9CNKgIJAAv8kuZbe9gAf8UNIGxC0rIUk76EfJPzGozupPy1srAkXXUXaczvrJSz8vlpP/m022oc8WLzsGVywEGRsSA4ll+ybN787VudTmG+cwn1LPo+tSzIZEJCwHX6Mmaj+Sm9XLPpJ3Biz1EAgm2gxFleh+VwPf6DxguhQr24mg5SIxMR7V+tBWAyvQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNai+9v8; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNai+9v8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jTHzZ60Cbz30HB;
	Tue, 17 Nov 2026 19:32:42 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id EE70762E6C;
	Tue, 17 Nov 2026 08:32:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 006551F000C4;
	Tue, 17 Nov 2026 08:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794904360;
	bh=sUnKsuDGKFImQsuMY/DHbO5AZYpcq2an3IW8zzTpUo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eNai+9v8+RaoNiuRSFvmegAXjAMPmru/wvqVSCDMJbYCKrktLLRcl0rI8BU4X/LHR
	 GhRqi2Rk3U/JVMaUPv+w+DsF5nuIajLtggeUFQK0eXyQ19ikXbAW5OOMoSDYpEilu8
	 f48TdLGe1c+SYYciXV/KwKweBQW0FglSXswuV5UfaY99CBJFT64TF5KnxOUL/cT1MJ
	 2spAL5weAcQ/z63d/fcamlFPtFYTecsTHNjeGw1LoP+wLgqrm9+RYrjtJlZny6B9ts
	 ZClRUPQybqkE+YTT1k7SWJmiBRZjLR3dlxTaM/er66wvit52x/5kDoM+hhorKZhGry
	 pfOut5SZb+2qA==
Date: Tue, 17 Nov 2026 09:32:37 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Eddie James <eajames@linux.ibm.com>, 
	Ninad Palsule <ninad@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Linus Walleij <linusw@kernel.org>, linux-fsi@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH] fsi: aspeed: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
Message-ID: <bdsajtpcyfh6slwpwvi34uabych3gzlvibw7yvpieg2345xcxs@2qr6ect74cfc>
References: <20261103-fsi-aspeed-gpio-nonexclusive-v1-1-1fb040c59386@oss.qualcomm.com>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-fsi-aspeed-gpio-nonexclusive-v1-1-1fb040c59386@oss.qualcomm.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 02:20:42PM +0100, Bartosz Golaszewski wrote:
> There are no users that share fsi-routing-gpios in any of the upstream
> DT sources. Even if there were, the right thing to do would be enable
> HAVE_SHARED_GPIOS for the aspeed platform as this is the preferred way
> of sharing GPIO pins. Don't request the GPIO as non-exclusive as this
> flag is now deprecated and will be removed.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Hi!

Gentle ping for this.

Thanks,
Bartosz

