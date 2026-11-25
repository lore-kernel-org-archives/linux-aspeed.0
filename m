Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9DD606A323
	for <linux-aspeed@archiver.kernel.org>; Wed, 25 Nov 2026 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuPxSU+b
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jZCdD0bYJz2xlh;
	Wed, 25 Nov 2026 19:33:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795595631;
	cv=none; b=kU4SBkJAqBJ+L76GNhK+ugIamGWDhipddzXK+JT3ZDnYk40dj29jRBIjqDDK8LyjQUPhaBZqI7NbGlmnk+vKcanYwGoQ4HKdmvA5Rj/lMR6/8Lfcmdxl4oJmZ7iwf0OfF19cOzKM37v073cvGsSOVBH/gFtRBzIk8iGnjUrlHuze2BLywRj0Bonv0+t1xk5BwmxgKmryGyfeQXMAT5KvTUPk+AvFFLNL33LMJCquzBnae2b2i13yqPN2lOKlDINDCyfE1EE04ydMvUqjMf3s4LpP13CBMju9ni7YY+YBKoW4bTiXh//zJY/1WsWMXOECKeUg29u9TSELuNO64ZoJAg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795595631; c=relaxed/relaxed;
	bh=XT0zzvytIO4H3CpKWXv+xGNfGei+5WGWs5aivBiZYBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fORoTVum+cP49OWdE/elcmWnxYxJAPK2+ODHBYpcOFLEWcWbFRGWalGv2+RjOI61iouugD5nd3WnALbZowImRr5wu9Yg3eAYf9koxVgz4FRMENffHjU0lHim87Afaus8DPbQVRAkHHwCSy2qiplW26K0ODmz5wfazseo5M+lV0r5xWcW45pvhvK636jY987iIFlD5HUAozRUeL1DpxHeeg9tnXHvLxSgVEboAt26UshLgcsTVi1OK9KWMWtCimOqrX++/7jFvFy4YG+zNZ7m0oH5sMuXC2ncPawnFILzqxYH8mvjXLPOtYBeyw9VzKfkbyCUgDzz40Bat74HU9kdeg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuPxSU+b; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OuPxSU+b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=brgl@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4jZCdC1HW7z2xYw;
	Wed, 25 Nov 2026 19:33:51 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with UTF8SMTP id 10A2D620F3;
	Wed, 25 Nov 2026 08:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B84E01F000C4;
	Wed, 25 Nov 2026 08:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795595627;
	bh=XT0zzvytIO4H3CpKWXv+xGNfGei+5WGWs5aivBiZYBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OuPxSU+bewCYDd1OYpqvTwQl/jJa5r1ydQzRYynSncPE0s+bR2wSev0EoFc21yYpm
	 lIZl/k1ZkGQpihIgjQysM6gcHyd086CIAqZH2GZ3v5TjVKMQvoWv5Gqm5uCjGsQ4k9
	 ARox0LDStLmf58VxXC5gEz27NNiIYbjDEN8EJDq+24Fbbx/h8/mkFmo2ZOt79ZhkEs
	 zbxMIFXZuFU3Blkr2sitY0xcYrGtj/ATyYdbsJOOq1hWj3/m7nrxxkLEOtKuVJNapk
	 ANITUoMWm2gBPaso8CoZMt1k5CTGixvg2TrqODKueLCKWUq2WGmRmsymdBj5qAXWt9
	 s2n1OMdDkOpYw==
Date: Wed, 25 Nov 2026 09:33:40 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Eddie James <eajames@linux.ibm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Ninad Palsule <ninad@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, Linus Walleij <linusw@kernel.org>, linux-fsi@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH] fsi: aspeed: drop GPIOD_FLAGS_BIT_NONEXCLUSIVE
Message-ID: <2fy6bcld3qnquytnfjnft2q7fab4jcxpmpwjbsgxfam2wqndi4@gghtmnfdry5p>
References: <20261103-fsi-aspeed-gpio-nonexclusive-v1-1-1fb040c59386@oss.qualcomm.com>
 <84bb623a-151e-4f6d-ba6a-a303838f4aa7@linux.ibm.com>
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
In-Reply-To: <84bb623a-151e-4f6d-ba6a-a303838f4aa7@linux.ibm.com>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 09:39:27AM -0600, Eddie James wrote:
> 
> On 11/3/26 7:20 AM, Bartosz Golaszewski wrote:
> > There are no users that share fsi-routing-gpios in any of the upstream
> > DT sources. Even if there were, the right thing to do would be enable
> > HAVE_SHARED_GPIOS for the aspeed platform as this is the preferred way
> > of sharing GPIO pins. Don't request the GPIO as non-exclusive as this
> > flag is now deprecated and will be removed.
> 
> 
> Thanks!
> 
> Reviewed-by: Eddie James <eajames@linux.ibm.com>
>

If there are no objections, I'll take it via the GPIO tree for v7.5.

Bartosz

