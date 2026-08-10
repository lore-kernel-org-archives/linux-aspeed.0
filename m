Return-Path: <linux-aspeed+bounces-4672-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2880BC5AD4E
	for <linux-aspeed@archiver.kernel.org>; Mon, 10 Aug 2026 04:34:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hJMNq49VKz2yvL;
	Mon, 10 Aug 2026 14:34:51 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786336491;
	cv=none; b=ilnqej6LrL8ZCEOIT/q/8MisjD7vmHOd/ojSX2ohliU/f184qo5uEp/HE5qZi7y9kOQohNAYtHmAsgSzAf1+WDjWhMo3weJAziYo6fsWWSAYy1UmGbMtMZuTy/vEDNQF994BkgOFt/5JQGOIPqSXF5wPOvRV3o65dIOeq9afoK85snn23yTg8yBkxRc4feEs2+yUxkkn3iwuJl+a3yCEDWbtCAfDQyHN9mNVlwOW7nMTLYZAqIdu4sQHjU5+j/m5+tsCqOCk2Toa12cSlZNbeQLAAPxQd8yD685FBEKMPSl/hbB3cB7L2bGHKATH4MDdFCtTy+9LEPUDPzQRbXmYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786336491; c=relaxed/relaxed;
	bh=d+3HW+UbDinwr8l0lTIom8vJ4+7ShLxx8WvyQiMaSHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuUtpJJ7swNPIpMkf3qCKR2rYVNInJPHVc2ucKJORqNUuNis1RweL1dHXS/8ygGWe5MRw61AejYUjqrjXAgrMuv1WHTVAI3D9aWMnOdF18TnNMUTzILDoohv1INbNc7QMm+TOfxfXv4VJIM52IZwzJkylxP9lqJS/62dZfxkhjH59+3LpPXyErqmBKMWJnTuwY1SzajsGUeq6EII/my6bLqITIoZcaflt6VGZKmyMqndp968uVlawYlEmo0CiDNFC2BVypuYP5enKg6pf2iKfIBxCG2p/ToAxcqwybkOiXAOEnyyuM4000Do7BqbXrEKdp3SzuiKZln5hNKzlolHGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=icVM4+bR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=icVM4+bR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hJMNp25CZz2yvK
	for <linux-aspeed@lists.ozlabs.org>; Mon, 10 Aug 2026 14:34:49 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-2d032846c95so17939305ad.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 09 Aug 2026 21:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786336486; x=1786941286; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d+3HW+UbDinwr8l0lTIom8vJ4+7ShLxx8WvyQiMaSHk=;
        b=icVM4+bR4jutlzcN8Z0WdMZ4BJUeWhMU58nOCqePCZGsK2DApuQgs3vwk55MFjFjlA
         2zJV4UXhYA6AX5U6TxNlxkTHAHZPlk0/UckOzueYQODqEmPv5cNLOurUaglSqPFJ1p8o
         plFDmq+3PhzSxFSa4TOrT0FtJfQSYPSYFfUhp5EqFdeZXrui52o1/6N5Ln80nUnkgNmw
         NPvWL9x9qVgf4Flc4Nhy16pPHaL90MA4UhrXg4annC195ivjFFJnhC+iHqp9KBMSkptU
         S6j68NWWmqLh0o9Wn7TYTyl76YgUUHrKjgDTnS9ByMx5jWEiQwnBRvW4y+eUvUZ4Cnan
         spPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786336486; x=1786941286;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d+3HW+UbDinwr8l0lTIom8vJ4+7ShLxx8WvyQiMaSHk=;
        b=KZUZAOF3/OYMKJjTYedJTaE4ZO5TV8eRZfNWLF+4HyjpvnFCFCBYCEQpaSfB+s2ORo
         W8R7Lseq4d2NHfh7YrnFzY9HTCYYSgBq52VRFB23GQ1f0EaEXiVCB0mjLnmZNb7OBS6G
         qBc0WMiS67ziCMKrHY2HVAeM+VaFSduzz7cZJ5SStSCZDyOeg740WzFZDmI4177i9dFI
         ngFDfCAq4aqwCdpeK0wfsyr6wLMtYXR+aAyelLXx7C8yqrtHNLONAtH4+TnnCd74M8Z+
         ZK8FDN8flg8AmLW5UiT4T5QLcaczz6C52JkIALg4bdNSR73r+oo/xVax7c0e63/JTyaP
         86YQ==
X-Forwarded-Encrypted: i=1; AHgh+RqAZradQfI4c6WxHKutps2m7ROB3bVPSdnKCLWfsRTm6zHuhOjuxLQidzzfi0/4uPQiP/cYypgZmCWorzw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw88V0k9CuY99bdtI3Ut7GCJP7EXtjf4N1qXXPBUJQe9/qQYvkl
	lHEwMyaOyfHcrV1FYL+jBYCELGZHMmZo9IzSKBpnyJA/9EWhJQyxKrx1
X-Gm-Gg: AR+sD10ENYNT960ApEaehfCQsXZzyXvqd1G2ebNGKIzhYM6F9gLTB2qkTLVur2db+SQ
	Ys7I8TbKJlDemUStFk2LDnY/ywThwDxG+fpDxUuARVDQGJdAxMcYv+MbeY6rZ11EDudw5WQcxAc
	/5Hi2BWD9uGBesfOYm5dgIMifv2XEidqhhB7znIx8EQCOIAmh7CFui+5rpiZxcDGmOMdqgz3X4g
	LsxjE6l672nmwK+8SzRLRbmAqq3OgBgM/bwndLi6I5K3zRxHsqlJl9pq11oKlm0mdivesHCn2+L
	j/qx+g0Jjx59AGCfwJTTnPOirVP21PakNZ5oRzsoxGzH8Zcl4xoFNOOgHMj45py2DBLhpIoesTI
	lgS7KmTbOFr+ovNMzrMz261flNPvtFYdesPhCVoGM2LuUtakDYlnsBQz7hOFZCvydCdtNKx1CMR
	ByOUlxU4U9Rwhh5C3yuQ0gzkRFotzyalIm2trjSNsFnhLHlalanQZ8SRIykudY4k3uyKoJfLLIK
	05k6BfuHS0Q
X-Received: by 2002:a17:903:ac4:b0:2cf:a1c0:d4ca with SMTP id d9443c01a7336-2d0ca961ad6mr521823535ad.22.1786336486542;
        Sun, 09 Aug 2026 21:34:46 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c502bbdsm28714455ad.81.2026.08.09.21.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 21:34:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 9 Aug 2026 21:34:44 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: phucduc.bui@gmail.com
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/4] watchdog: aspeed: Propagate errors from optional IRQ
 lookup
Message-ID: <443b829d-67f1-4af0-9e07-021e1592bb0e@roeck-us.net>
References: <20260807081652.38692-1-phucduc.bui@gmail.com>
 <20260807081652.38692-4-phucduc.bui@gmail.com>
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
In-Reply-To: <20260807081652.38692-4-phucduc.bui@gmail.com>

On Fri, Aug 07, 2026 at 03:16:52PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> platform_get_irq_optional() returns a positive IRQ number on success or
> a negative error code on failure. For an optional IRQ, -ENXIO indicates
> that no IRQ is available, while other errors should be propagated.
> 
> Propagate errors such as -EPROBE_DEFER and -EINVAL instead of continuing
> probe without the IRQ.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Applied.

Thanks,
Guenter

