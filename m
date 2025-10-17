Return-Path: <linux-aspeed+bounces-2486-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC67CCD184
	for <linux-aspeed@archiver.kernel.org>; Fri, 17 Oct 2025 06:04:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnvRm6S3Hz2yhX;
	Fri, 17 Oct 2025 17:04:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760681092;
	cv=none; b=U3JfmIGUkEd72RP7WEhTXAjtNFj5FRVwu+LdtJO2iRUrI+Jj996WFjGH4Z0kgDX6Vjn8wovP79k+G/N3drsTgfYSQc8kmI/3kTnw/2sT3Wf6XkSVdmQ/Iv0EoqrHkOeAAAiFPNbfrF3sCF6XOwRpI66x7QaUHy4ASI8tnlZDOFZxZsqwIkcqDfxDhs1XBRqvOUsCeB8Yb3Vy2MPnq/fS/8I2IYaqu6hOih7C111Pl5Ph8FdcV9TOAwg15avs34IvuYMY3uqrTHIdwFuNuG8dtzseU7vovwihJBR7JpornB1NnZKvY02TH+aNOGcc/uV4d7P6/rAUu+dMlJMd9zAZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760681092; c=relaxed/relaxed;
	bh=aSPqFe3S0bFVfaza5qOmb8ksimgWhn1Shr3aJzL1jL4=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KHM8NiPi5BmaAlQGyNjTVPSIaA3r6Ued/dZeG4G1CM6h5715mr1x1Wxm+D4cjlV7/2pr+t0I8Kcamxl7W1Foe+ZweLIvXOVa37dtN92DuSVWwgmfuRvFcggGZhGABZdk9C3BAji7ePbXbS8/gh1KWrKeCKv0qgQVHtXP0BntQ3WiNZMXuA+jj09CGFppkbfZZhGfAB27fL1GzOJ9+h+jJqDmXgn+ddubs6VjmAxfvDDHzpvmRZzglfhdXNZ6zyyE2MQra+IeScHLWd2GvKDfAQa5X7gAjKd6aRCLRtKr80ep8tiJ1l2tJAfwbZT4D3spq3I/D4dicQSd5coUTHd1ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ka4i6dPR; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=ka4i6dPR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnvRm3gPhz2xPx
	for <linux-aspeed@lists.ozlabs.org>; Fri, 17 Oct 2025 17:04:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1760681091;
	bh=aSPqFe3S0bFVfaza5qOmb8ksimgWhn1Shr3aJzL1jL4=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=ka4i6dPRHxsCXqsyxlL789vXXBplQXn+rQsOZupQaXGVhS2VfvbN5EspJsCrA96ce
	 N3B+5bHeblJ8q5T9XYzhouTFLvxPrm4RLuCTtaNzWtN9t7BJMlZpOROBHFgGFgyGFI
	 bMRSmXhF2HxrkiTY2lW5RxBuJI3ZLbJDd9CMXUmTNr2+LeRayr92hbPmkMtMUOdTS9
	 IVbG0COzvRSjOrytIZH5gwSwWkKs9Zuh8NvAScfaXQZkQuyQeDfgg2MwnsUYyY32YT
	 wlb5i3QnWHsFJnpw08f36blNsbgcTvPJAYU9AsnsLfmTlcSFMgTyHNggw8eUiSuiBB
	 YAhZ1F6+qrhfg==
Received: from [127.0.1.1] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E73C8766F5;
	Fri, 17 Oct 2025 14:04:50 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, Guenter Roeck <linux@roeck-us.net>, 
 Tao Ren <taoren@meta.com>, rentao.bupt@gmail.com
In-Reply-To: <20251015204840.80070-1-rentao.bupt@gmail.com>
References: <20251015204840.80070-1-rentao.bupt@gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: fuji-data64: Enable mac3 controller
Message-Id: <176068109091.239120.10783664740576101312.b4-ty@codeconstruct.com.au>
Date: Fri, 17 Oct 2025 16:34:50 +1030
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
X-Mailer: b4 0.15-dev-cfd50

On Wed, 15 Oct 2025 13:48:37 -0700, rentao.bupt@gmail.com wrote:
> "mac3" controller was removed from the initial version of fuji-data64
> dts because the rgmii setting is incorrect, but dropping mac3 leads to
> regression in the existing fuji platform, because fuji.dts simply
> includes fuji-data64.dts.
> 
> This patch adds mac3 back to fuji-data64.dts to fix the fuji regression,
> and rgmii settings need to be fixed later.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


