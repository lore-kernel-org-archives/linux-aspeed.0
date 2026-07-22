Return-Path: <linux-aspeed+bounces-4518-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08608C44512
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 06:38:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4l2B1ZWHz2yVd;
	Wed, 22 Jul 2026 16:38:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784702306;
	cv=none; b=bUIKZofQi3eSowXIvkIBOxJS2qhPjPwhpKOq3ofSDtFAzxIN3wFpJ6IdjwU5qGqGQ3aFfyT5iwN9lTfyPh2DjM9Xq4baH5Y9ECmoLWVuw2jTRyP8P8Vu2TplEhAjG8eT2ptSZYMRmkTQlmkODTjP1g5mg0hDnVH5Cg/E13w806VRWjN5lNhTa9uiL0P32YEOdbRA8UE1g3P6kD5t7CZw4yfAfnoBuzumHWeuzm85nka8IHFX3dULqPjfOA4+e23gr7elbSDkDdL8P+MO3l0JUEH2NM5C4pImMOh7QwR9CJwBMLuTxxN99lOBXQgtqsOksxqKzWtV6cJVSJrhgaDXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784702306; c=relaxed/relaxed;
	bh=+zb3qHEfQNdn/VPyYyBL6pEsHOl2hhCoI2rgqrXHwIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LAdsJbjw77XzAXphxQb1U+NT9VPmIa3eMScTznY8uyRGn8W0OpsGkl4R0N01mVp86XKnJDaCWt3PpgiOlFx1yo+95+wlExrUF03GuB4jjd1aYgFDU6tjs+o4NQ8LJdrOdsGm2MXn0e81ROpWE+ivsE2UMlkav6pUkHeYbNbYUbuFoD7ujinbSLTDrzHzlXuacQ0+//6usng0W+edZ5QwRorCswm50Kv6MbaYoppNtrmwl2ylldPM7SGKI2+HYL21HmUUwXeO5NgcFcLlHvRrRkpC2iCg/10bo3IqvehhUvdNam+G//IxeT+t2c2o5q3eY5fbDe4LK8+C0c4pUj9QhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=eSe99VQZ; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=eSe99VQZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4l2930s2z2y1F
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 16:38:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784702304;
	bh=+zb3qHEfQNdn/VPyYyBL6pEsHOl2hhCoI2rgqrXHwIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eSe99VQZiVbw4Fq0s58JabWxbarccjIvszDKZhQLLk4Yv3U8Am0+gmICw1uqhhv0Z
	 KnM6wgUNlZ9d9PiqfqSXh1g9Km1CX+mzFtZgu9HSUL9UkzwSlfPQb9eCFD1zHVNQXt
	 93NC8NHw7PC8wQIfOm5iOjGORm4Hj+p/ckpQNSKuDvbYvABav4Ix4MdsxFaDuCIWGP
	 nh/5xBGWW8YceGIEX4AD1lRQeKjmFkx8o2+L2lUHRNZEPwnfw4ZHkOCa9EsDGOBztS
	 TcSoAFEQJNStXvrQJXB6sQe6v7vJew1xaCJgiMEJk3gf6mFoF/boTqiQgEGZtpYAS4
	 6zEWuZRMIe06g==
Received: from [127.0.1.1] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1FC0465B37;
	Wed, 22 Jul 2026 14:38:24 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Patrick Williams <patrick@stwcx.xyz>, Potin Lai <potin.lai.pt@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Mik Lin <Mik.Lin@quantatw.com>
In-Reply-To: <20260716-upstream-sanmiguel-fix-pwrgd-rmc-n-v1-1-8287b306e02a@gmail.com>
References: <20260716-upstream-sanmiguel-fix-pwrgd-rmc-n-v1-1-8287b306e02a@gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: sanmiguel: fix PWRGD_RMC_N
 active-low hog configuration
Message-Id: <178470230401.777395.14157899070923881410.b4-ty@b4>
Date: Wed, 22 Jul 2026 16:08:24 +0930
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 16 Jul 2026 10:31:17 +0800, Potin Lai wrote:
> GPIO 14 on the fio_ioexp (pca9555) controller corresponds to the
> PWRGD_RMC_N signal, which is active-low.
> 
> The pwrgd-rmc-hog node currently specifies output-low for this GPIO
> with GPIO_ACTIVE_LOW flags. Under Linux gpiolib, configuring an
> active-low GPIO hog with output-low sets the logical value to inactive
> (0), causing the subsystem to drive the physical line high.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


