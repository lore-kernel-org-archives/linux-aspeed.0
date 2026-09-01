Return-Path: <linux-aspeed+bounces-4902-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7FBC61DD3
	for <linux-aspeed@archiver.kernel.org>; Tue,  1 Sep 2026 23:05:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hZLzk2yzCz2y2h;
	Wed, 02 Sep 2026 09:05:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788303906;
	cv=none; b=ERuvShVIIFkCtMG3QOd63IAC+Rc8J2AnDzDMzIy4G1eh15hTLrXktROU1pavN1Ev82Jgr3leJ6p1q3qgPXvPQQy0Iz5lcADVqgQAiA0C6UgloI7Ee7FL+JklG+u0u7TD9G645BpRB3zQwbbj0ywM8oSlFdmqIAvuoJ9eYnaTFddJCPu1CktsVP3c/ZPvxiK/8s8SszCzcQS7Ai+hbL8nBqY/uRCh/HcaZT46tzt9erWtzTID+eDqteZbqzCbnbqtGqn9AI2u9bJ9LM4+vCHetr9/ebGMhmigMjPWdRGs5x/EADPtlichp3wdkUhkaKpzW3hCOqJtBH4asJrlisy32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788303906; c=relaxed/relaxed;
	bh=tmOCGEePW4HCHBy9intmcc0xfKUaVb9xCHFv+Cs6LwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYTzOitTWNh8RXHCNUE6RU9KsTL1Svthn7+tDIcg+dLAj/nLEpqQLfCuQ92s1UuMfT253EtNm9QI/CKzLdgQeMDP1bsMs5aoy8pqXxUvF/2m0t98jHCMJNp0BW3sMMjnS0WXcA6epeNHsOLLTpFNhcuAwy+P50on0hbMp6SKf/Qbn39AR5cu24EI2ltAdRaTGroLJofIs2aQ1DSceYAgGlYD1sQYOPqfXuzSq9rPPhZHzX7A7qFLMW07Bgvyg6AO8zJspU+8yP9xYmQ24qjHjDX9U22UdQkmagcvi7PdTeklTO2bKThCwfK5c6cECCJB9lcH9+fl+vl2gbEJpiPetg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I7hWZlba; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I7hWZlba;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hZLzh0FY5z2xyl
	for <linux-aspeed@lists.ozlabs.org>; Wed, 02 Sep 2026 09:05:03 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-381b831d535so632459a91.0
        for <linux-aspeed@lists.ozlabs.org>; Tue, 01 Sep 2026 16:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788303901; x=1788908701; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tmOCGEePW4HCHBy9intmcc0xfKUaVb9xCHFv+Cs6LwY=;
        b=I7hWZlbayw1i5R5PG6oI9ORTsHwhTfAqwzBIs7eUZ7wwORR4H8j7EvFcfkOOZrYAeL
         77Lij0/HDnNGxLIKJmxTRuu94cx7netFAhqnhqKegFQiN+ZK5O20vIiFXZZaNihYpFaJ
         xwqONl0Z/zKppv0Ot5mCk2Rlr0iUcvogzfs5RbslFKdd4jVgh+savZ0j9dm8+S09Al0J
         l8G5Z1eCMOUqyEeKkAMJF4JcuN54AFezcZgYKNkpUI0VjNCkTMs6zwT1G6eTDqBkQzBb
         Ic1PYkGyXIc1iu5e/jNhmVfLtIoGaBuLTt5K1rKFFF3lbBftBo41wtk6EGpQhgES1Kl6
         fqKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788303901; x=1788908701;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tmOCGEePW4HCHBy9intmcc0xfKUaVb9xCHFv+Cs6LwY=;
        b=NbPZ0oW1VsQ0fG6+9P2+q9T4Q7f7DoaPPY0g2g/fFWRXd23S2pAx5kuc0IfCvvbJiy
         T5Fdg1uEZn9PRdh4Qbhyy9rLLpJIz8KwiGjSSgCRbWqg/8gW+mnOypi0y4M9JA3BxHKV
         Urb8/4B5pONA+fEWR9u/ufIlKPmwuESHVf9f4b33efkjJhOAaKgoMVHR7gdG+ABG8fe+
         GEiFz1rYG0auixPamvDttOCnE7SsLIw4tWNi2r1S+9WJvNQoT2jlEgKmAapFyuyX1QvC
         6Tlo5+g0YmhL/8nsHQicIFFtIBcLqIWue1AHXjCHPkzpljx64zs4soG8G48srgyqMBeH
         tOLw==
X-Forwarded-Encrypted: i=1; AKwUvBzrXOkEJ+U/vNbFZpgCKFEd9kv9gu0TBGx3BKH7XsiS60+QHiFJE0hyVH4aS7veeJIibHpwTmbYYeJSwEU=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lL/uK23mxmTD9YNId4ZD4mCkvrtIgUl3yBxR+kFt8uOZyu23H/
	B6ESXAjCwjrAOm4/AHOFFsXUvserYgqkR/Dsnm4453a0i8ULDUeLhla6
X-Gm-Gg: AYBFou3ysvthYt/5vpj1tG12+sd5kFsUwd+wl0oJYOCGoeiOM27+E7lFtJ/rjXiVACm
	c8IP7rAc+G5R0d3wSPF2C5qfNvuyBvYNjT3+Hf/H5xn1ybZtUU1N6A2xwN+2NGEmGgzk1z4Dxnl
	WWtenbaPlILCbUP3idyfPxIkxIf8yeWoHOQ/m3PFcKrZWibghKO5JpgDk4cykyvue/yoKMAPWVD
	vOmyrZerr8ov3PaaG4X5UlXeoseM5wv0mX3wyzSb1diGhHYw6XEIBnEQ09TLJe9IhpZAENy10WM
	alEzVZW0IemEab/lK+EO9Vx/MX4us6zLJqEsqbhIr5d9WN4lmy3GsGX/kru9HTgA5yoWxhftAA+
	tYNTEzm+1AM0+R2/WisSmplKyQzZ8xlogeaJXnrHJnW56tNKl5KaNu40zY2Etw6IVRguLXoOcPJ
	2MRj3+xppPk3X+imECeGjPk9U1/tWSsMVWk44kwm3tGdzGyAaBImtCkzIWh3zQvP2GSK/RsufP9
	A==
X-Received: by 2002:a17:90b:3d89:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-39aedf89b82mr567737a91.1.1788303900563;
        Tue, 01 Sep 2026 16:05:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07bdb15bsm1138117eec.26.2026.09.01.16.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 16:05:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 1 Sep 2026 16:04:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: aspeed-pwm-tacho: propagate reset deassert errors
Message-ID: <e3e4ba55-9b54-41a6-9130-52981f83f106@roeck-us.net>
References: <20260830125044.97718-1-pengpeng@iscas.ac.cn>
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
In-Reply-To: <20260830125044.97718-1-pengpeng@iscas.ac.cn>

On Sun, Aug 30, 2026 at 08:50:44PM +0800, Pengpeng Hou wrote:
> aspeed_pwm_tacho_probe() installs its reset cleanup action and configures
> the
> controller after an unchecked reset deassertion.
> 
> Stop probing when the reset controller rejects the transition, before the
> hwmon device becomes visible.
> 
> Fixes: 18c514cc0e02 ("hwmon: (aspeed-pwm-tacho) Deassert reset in probe")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Applied.

Thanks,
Guenter

