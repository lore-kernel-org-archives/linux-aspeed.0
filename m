Return-Path: <linux-aspeed+bounces-4680-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7966C5AD55
	for <linux-aspeed@archiver.kernel.org>; Tue, 11 Aug 2026 00:16:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJsc51Fkyz2yys;
	Tue, 11 Aug 2026 10:16:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::636" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786329515;
	cv=pass; b=mDiGwYqnf6LICcIxBlMfL65rIsfRI7YPlV6yZ7y1VuvZM7WGAURBwekAoYZ5EG97n1D7DMvEdHpwPYRQ6HbSe0Ddt4PhhP2n05E6fqHeIXTSaTNof6eO7NK8MXjNTLUzUlB8L6fyOA5xDKWES0rCN96SkiuVJFx1S73JA7VgmQj2V5BVWaPExDJvFHSBJlldpMAaH4LJzFIdJXhNO/hjYenDWraAhAGWCn+VMV3tC0sx6unhP8KN54NS0N4CBIWK9ZUoQIGPReFlNJiK66p5GNyUIBji6qon47ohL49bKRuzBxjZ3ywNDkn6Q8jKRe2GgUhfmmDeia9r/cHP859dxQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786329515; c=relaxed/relaxed;
	bh=6DGwzvD9/IQFl9yYfrwzS70k4e8kTkJHKmvyNHmKPbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXKZuPWyRYeP4BqzBtZksblQXZWRQtgMbJD2iPx6W6TxoDK5yl0YT/vlS7+z160qTcr50QIUZGdogHR/jjq9rib+Fn1qPGVWw3JPL913Nh5tZZsrpm72wIBS/cJddtxSlKWMWw4dffeqAn0Pr3ZYkuLpmBfYebz/eGYx9OmU2TmC6nXHybE8cVaE7AxLFCe9AJfK/0NQiVlCWuS7hdQLdXq5U+pOwftyqOrQToiEw06+N3IJu4om5eZuOkxuhR73nDuPu6LnA/nd8wMHhvRJWCzjTkCixLhhhbWPoUFQY2y6JIpxT7O71p9p5JFfiKhXBvr2k8nj/8XVsOvVLM1OSQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OrmBC4fq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OrmBC4fq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJJpd3PhCz2ypk
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Aug 2026 12:38:32 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2cf52d15d88so10402805ad.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 09 Aug 2026 19:38:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786329509; cv=none;
        d=google.com; s=arc-20260327;
        b=apB9y7Tx8jvwjXdpaeWIOLTYIcngW6rQ6O8046YzPcbIVrqPgXc6ehSG4ctF2FLGMh
         azYPfvJr2wIMsdd6qsRUvgwagws2GwOsEnUDBo9gn5vnTMew+J6Ap3WGW1Uwmh2z/yTJ
         NHnMcW2YbYOhDUM0mqc6bREZb61xhOpcQcik5OB5ecZ6nZTEqLiw29ILcezsrp7JpClY
         4QOARl7xRMkSI/TvOnO+DgvFJ6QjOHXLxYPFR6EXPV8yt830wvPghqn3HZ7RpGxTLBoP
         /sVsN/9Ylfs1EP1TktcG3ezUKkfQHJ71ZhkogoxVXQkklRo1mTy3nRE1AS0CZocw3Gwv
         JE5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6DGwzvD9/IQFl9yYfrwzS70k4e8kTkJHKmvyNHmKPbc=;
        fh=w3n/aGH5K2NzqL+hY9U1M9WQbmKeFrPXjIBssscBNww=;
        b=IGPxl59aaXEm770G+KAuYzERYZM3fkNpjZh86kV0NJ0ixfHXcuuelxKkukpxDPRlBY
         JDVZHjLC2AHqLlU8mGhT27bINoKIlPfT0Ot+if92qX6WR/I1Rw5zWyncu/TUSSBa1q6L
         I09fZfOGl7dWoUxcNJDkxQ1aRSLWi0wZMEkvyxxqm5XH8PKoLCbnEFiLnkhW74iH3Mga
         lGMC/KFxF4AKI+CYwchK9bkZQ/W2GSBJWBVM3tXvSxX25gt3LRX/xboU2ttAlzg2Kpaz
         W/vIszzj75MW3hqD95Cnc2D0ClMvdjIp4M+8IiTn/CBX8e7djwTexpmIylxJLWqmTHuM
         2Tiw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786329509; x=1786934309; darn=lists.ozlabs.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6DGwzvD9/IQFl9yYfrwzS70k4e8kTkJHKmvyNHmKPbc=;
        b=OrmBC4fq+ZtjqIqtf9HehT0NpJpbIwOXG3yvHiP3Amvic5FBYB1rZna4wsaIRX5f4H
         l3g2Mgzzz3X/e2BZlQredAC1twlvh4aKwA6onNww5bmbZPmn4moPx6/UHRbxOSdJCNu2
         BAKfZSbv7yqN7vCfh5ilCnTY4yE7RhkqL/rB/ytkkkzyLGLbSXTYfI16HfDk3Ftoy89s
         3wOl0RFUfTSLteQgveqN13pP5/mo8msJx+5zE9mCIqtEHFLsjnAlbAXiKLRef/OcceBT
         oTON4lX6Ukh2fjzcjgsfeW5poSiktbReo9yzsSdy6E8v/hHx5kv7ds0bs4Xmc57mEIlV
         8m7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786329509; x=1786934309;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6DGwzvD9/IQFl9yYfrwzS70k4e8kTkJHKmvyNHmKPbc=;
        b=aulyCiV6c4JXGwXFRwJ4av6NWB87MgfUXsWxUKQyw4gTU16v8oDTv5vy7dkrC4RUzW
         M0XfwZEi0m8LpFLxQbi1SqbutIi+0/lZDBX7aqqAlq9I65m6QWeseYcrdgtdwnmNJHp2
         Wf7jDN0HnrnuEk2Xp4adwmULZn/8nLoUmG2ZA986ay28Wm7Rgdzmb0/lFGe4EUHbi4xS
         cm5MM16dwa2XdP1SlSq+PPFl2NytB2SoCV78liDJ/SIJYNadguyKtceo0o1YVmrAghAY
         EqgNyYRx21nGVh2lMwecv28e+yhU20KasdBB9sMskJ6uup6DFc8VYMDZRnHzgFiAhsTe
         GCgw==
X-Forwarded-Encrypted: i=1; AHgh+RokmkfUA1wPz2xUaLgShta1UsbuVagvdDO3RievSliCnHKTd0/a6N+YWYHAD6uBqAftruzW57v7UyCCjCw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwIlN8rIWzG3I2g4s1RJA5yTrHKE++5HiBMILYlIZyX803dZQxx
	Ysz38mLbblJKxVKY4g8D5pLLP2tN6nr8Upj591tQAsEH3fnFIPq8yJlIeeD2/H0b6OtjnfKS07d
	qR6+3sGI8soOJuyKqqhS6/xCdM2Qwj5w=
X-Gm-Gg: AR+sD10YpfLqlu1mFFaQTtGL8abr7aADfQ86qPmOr+MPGUSWqErUHEBecGHvU7+VSK1
	tdU4g7OHjXFDtmBf506J4twwbI/ptuFMsdxBj1F9xmAOlr+A/mNO1wcyMmrLZyVIleC5hD7Bemr
	MXmjGNOwIFfpVnwlyx0NwGo7mocMb4fmWNC87AOudrym2EupkLksOD5zrNE1ispGQSPWcPB9xrh
	J6xj6jvNuXXUHdt4x4Cz49IB+CUamkbtIkJQ4dOxh4lOy6S8OCfTjJEZl/lahnYDDYmdAkcUGr+
	CgRiHMiq/CTRwNOY7y5oTKEw+XFBm4i/EOB3daJ1TInpYu747s+5GTGGggWmDgaB+Zz6au6GZoQ
	xpcqZeegNJPxlYnXpT4sUk6cJjPHGQ45A8cB5Nyz5caMKv/XW6ZGJhkNV
X-Received: by 2002:a17:902:d58e:b0:2bf:27b2:4b80 with SMTP id
 d9443c01a7336-2d2a8d1d97dmr211697695ad.14.1786329508803; Sun, 09 Aug 2026
 19:38:28 -0700 (PDT)
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
References: <20260807081652.38692-1-phucduc.bui@gmail.com> <20260807081652.38692-4-phucduc.bui@gmail.com>
 <1f26fc28-da13-4ca3-990f-676b53d23630@roeck-us.net>
In-Reply-To: <1f26fc28-da13-4ca3-990f-676b53d23630@roeck-us.net>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Mon, 10 Aug 2026 09:38:17 +0700
X-Gm-Features: AUfX_myaPy--xKkkil0mfKwIudM0kq93jPRIr1aFF5iubyuHeV4xAEUrCHwB2E0
Message-ID: <CAABR9nFy=GD4afdDxzsbp31Sq=smGVFf+HvqsrJKh_FjqdUrJA@mail.gmail.com>
Subject: Re: [PATCH 4/4] watchdog: aspeed: Propagate errors from optional IRQ lookup
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-arm-msm@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-watchdog@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

Thank you for your review.

> > +             if (irq < 0 && irq != -ENXIO)
> > +                     return irq;
> >               if (irq > 0) {
>
> This if () is no longer needed.
>

If we remove the if (irq > 0) check, irq can be -ENXIO and would be
passed to devm_request_irq().
I see that the irq argument of devm_request_irq() is an unsigned int.
Would it be safe to pass -ENXIO to it in this case?

Best regards,
Phuc

