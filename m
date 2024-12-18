Return-Path: <linux-aspeed+bounces-280-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51878E77188
	for <linux-aspeed@archiver.kernel.org>; Wed, 18 Dec 2024 15:14:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YCxzZ6SQqz30Vq;
	Thu, 19 Dec 2024 02:14:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734534858;
	cv=none; b=kwkLokSSUX4cKI/esXj2e+vjymfPaUVyHmABxFHw2y5dMfutn4wUBl9qZMsdv6Vazx4JYvvorOxYfqzNi+7ioGbr1KTcq5jT/pr0eAuKLqXwwSUtbotVebReNgPI/X6LSBzW2fJo47D0Fr9afr+lweehZJttWUtD+Oi6edG/EB99Bp7GwEZumhLyNMt8I28ao4Y0Xh9oYWBYsbLrXSIM4F4Weyp40Y8LT69eFUWtjjvS7AhiCVqVlDmGkpYlSg8AYmBJt3zuFe5YU8/1Ui/vHvKMWoxWLtkJeIl8srO1T0oTWnRC5wuFuKzs/ME3vZEcWaRd3tE3WBBfh3442gKQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734534858; c=relaxed/relaxed;
	bh=tyZoW9fvDykJjh+t7cBP6j9yz1yzBTIkPLx63WQaNAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HD8zAFieMP6LEBlU3UAOc+Szpw3drzWw/ODNfCnAKirEf3CQa8/O5V2zByZjBN9+knpCKl6jDrnPjdp+6zAqWcg3q+xIimSvyD5K1Nxq2nfRipZOWVjb0hN0CLi87vuVjhPBh9+4tNmFLchShOZlD9+OUoJmoru2uO0V1jUcQ/q8Dr/nOJEz073N1l/G56+EQKRC2Qye7QHeqQMYv9tStPsahkLssdaJt2rho+FM4K7z8N6GHBJ+SFEzmmXJMzhh2RoOPg+WK7NpH+0BqiUmM+3toBmCMqocwe/IjODBcBi/bjQ2MI7EifuWp4wNvhdOyJrTDN2MiMLVLVJcehZ2Fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WNbpi+Gj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WNbpi+Gj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=groeck7@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YCxzY6nYnz30RS
	for <linux-aspeed@lists.ozlabs.org>; Thu, 19 Dec 2024 02:14:17 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-725f2f79ed9so5379597b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 18 Dec 2024 07:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734534855; x=1735139655; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tyZoW9fvDykJjh+t7cBP6j9yz1yzBTIkPLx63WQaNAw=;
        b=WNbpi+GjthD4bNJyOQjjwkxaqfg4KhHu5FO6ScY9vIkYqRHqSJIAbgIlekdaNL5tZI
         oE4yic7JcABaQH7Q0EPJdtJBd60RGyJP93HaDDOgsxHFAnhCpQ5NEmNWrC3UKAO2R9HC
         wuiNauYGMXG217PT8qmCyUswKPNh/CfYEkuxdC3rr7IOTIhZ3iN1/poTUUcBRajuJAwp
         WISzDJiw8hdLqAOMWkRxGmNoCkhNFAsNjYp81uCmGBM6NFPMhQkyTYUGM6vXpKxpgYA/
         MDRk3OqtsaWNeVTyfNNOyamAFsmj6ueOGuc1e4aZLSQ7KZj0i+hesSESn7dRAkduCUM2
         agAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734534855; x=1735139655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyZoW9fvDykJjh+t7cBP6j9yz1yzBTIkPLx63WQaNAw=;
        b=f5IGoOiPS79vV9gAPD+7RwQnNk9lRC4Yksil/GN0MxyoJI2KgjI4FwiAgudG49tnAF
         0psH9JSm1wJvPrFMbYuGJzhZVlcrlqkm/DjI5VZKXwlN4hewRRUsKvSVxJGWgkGlRFP8
         tms9/VwLoufhPbFK6rdJk/CI7vk/cYvDeYHzaeW2hE30VADFag14sLYcjAxk9gwI0fEW
         ilohSeN2CUMGHRaSy7CeGR7aANF/q8rwlgehFGbgmwxZZB71SA8peDvxCDuzDkrRdfRY
         nhp+FcWlV6noQZTG+iHnXruAlfXB5tRC4IGYF0GpOgQMat6g1GTwkRC+fFcYUbjeWZED
         B3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrF4YOVx6g2t8jRy2iE9c4QortveBGRDKXamtOOct7m5Z7pGPyDSRzudAashhgp8IKCnX/NFHa/oKM63k=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz2V3zMDGmW6sbEO0EHDxc+/q9d/brSSBgiLesXph48iypUjTUu
	aIca0wRSYKZp8sh3v2PLQs6LGZcirk2Qx99tnVPUbeVfcBFJHIf+
X-Gm-Gg: ASbGncuYduLgmRHn7yj8DZqq5wpDuZxrNPe7jFXjo1QhCbbsvtN1yuW3poH3IS0SAYq
	JIKlZCSoVHKNCca5RG2n33fcF7GFflzBPvxgN3qZqe7FGfyuI2N+PWce/hHK7oXvhcsFMbeKRcd
	lJ2QHHAcGnmVp3RDI8hL1MWUDvEDUYnNxETKajFWy2wMwiS1ImQuxJ7234hCOp/qRhovSxcsZV4
	4gvlLfpgvxfbM7qfYM+ClWHCT1AYBFMLxGH+y8oLV5jSPWCvbrMhoHC/qEE1AewP3EUTA==
X-Google-Smtp-Source: AGHT+IHEL03aH+5l/Jz7FYfrcitsFgP9ffzprpgrgzAbhB/MKzdMCk++VqGl84RAs4ABj585pIWjAA==
X-Received: by 2002:a05:6a00:ad3:b0:71d:f2e3:a878 with SMTP id d2e1a72fcca58-72a8d01e3b4mr4778325b3a.5.1734534854909;
        Wed, 18 Dec 2024 07:14:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918b7c7c1sm8640241b3a.112.2024.12.18.07.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 07:14:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 18 Dec 2024 07:14:13 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	eajames@linux.ibm.com, jdelvare@suse.com, corbet@lwn.net,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	Delphine_CC_Chiu@wiwynn.com, broonie@kernel.org,
	peteryin.openbmc@gmail.com, noahwang.wang@outlook.com,
	naresh.solanki@9elements.com, lukas@wunner.de, jbrunet@baylibre.com,
	patrick.rudolph@9elements.com, gregkh@linuxfoundation.org,
	peterz@infradead.org, pbiel7@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-i2c@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 3/4] dt-bindings: hwmon: intel,crps185: Add to trivial
Message-ID: <4f8c8445-0d98-4905-8cc3-752dba3ec11b@roeck-us.net>
References: <20241217173537.192331-1-ninad@linux.ibm.com>
 <20241217173537.192331-4-ninad@linux.ibm.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217173537.192331-4-ninad@linux.ibm.com>

On Tue, Dec 17, 2024 at 11:35:34AM -0600, Ninad Palsule wrote:
> Add INTEL Common Redundant Power Supply Versions crps185 bindings as
> trivial. The hardware does not have any resources like clocks which are
> required to be included in the device tree.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>

Applied.

In the future, please base your patches on a well known baseline.
I had to apply it manually since "git am -3" didn't work.

Thanks,
Guenter

