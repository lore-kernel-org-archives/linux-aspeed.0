Return-Path: <linux-aspeed+bounces-656-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910AEC02193
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Feb 2025 23:54:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YngG3025jz30NF;
	Wed,  5 Feb 2025 10:54:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738713290;
	cv=none; b=jG+yZ711XYSa9VGo0wN0kyxloYs3cn89EPRrVIk+S2ur5w3ErkFKRuuh4QyJLEEFZlxbka9d1Bk/st8c5scjfE+u+uai+kHBkANNUFkq3bDKmEMC+2ZFaXbZWg9tdfGQP5RUiEkiQB489ClgHhatYQzv0g/bHoMy7JcRnH1eSsush6OpCDri7xE51FAODU1u7Ds6yE4M+dRlWWrF68Ucd7ZzK+3TrlQ5YX9M7oB41KeewC4gR4hjQEiosPQeD7GVNqGqV0TYW8/0OaP9GwybbBxFZSjIt8byeZ8jmSB1NYIMMj8tU/rLQ8DV9xqRLG6C2aDgojBrZclYKUi7CglH8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738713290; c=relaxed/relaxed;
	bh=6fywcASxWYAyXe88HcHEfSTs2+ci+gNxhmlmjs1+cpQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mRdueZvxlS1F0/n80K9y/kUv6vPxrKBBNIVTnSdyEH8qF1VZ7t9dA0VW7kWFA6duKBPYNk2tM6jD1+lIA/Aq4Ti+tE2ENLeZjt9dwh1RXddH/ueDpSqAPXLu3Ljp4tOG8dA8A8Q4jQFAW3Qrmi8ceUkO1CiNQIwF0WncGIKTAmeq1lix3H3wE4YzGSQVsgS5G9shqgnHL49AEDuGNlKuEX4w78hoqz/MvooNKoTMmocFrXng1E6BwD8qbwCEtnmPfyTBPwr/etrd5hBwEmE6ku++uFCunbzNH5EpP8XSjGLdPi9sk2UviMmhV1JVyw4y2Ay6JJWXAQ8YripYmE4Uxw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=SpMfykSl; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=SpMfykSl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YngG101Nfz30Mn
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Feb 2025 10:54:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738713285;
	bh=6fywcASxWYAyXe88HcHEfSTs2+ci+gNxhmlmjs1+cpQ=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=SpMfykSluKgdk8YeirzJeNWJPS6WWBTrvit5wimmjLcvuMQdWaUsPh4ytqTNWoMOj
	 3TIKvTfWx4ToxQe+CStSaV5W3cA2HKgwoWnTErraOKCRglgNaz9YF/bP6B85VU1UX3
	 1Eh2/Yt5lGqp8aW5C/Q/a8JSS+hE5JMkMQtrA4g7AMp645tnHm5KgExy9sUd/V6svF
	 R4u9YssW0MsdCMYQSA5GrX95gSQQfct4UFdEmc7ef+KscsF6uv31LXH0AbNfSF1UCd
	 G9pEjBB4R2LOdPPtAQH2BfzWmUUZS2pijenEHUmrwCh7c2H/5g7hA5Cs2NV1Gzakqw
	 KZDjolH9iCcMQ==
Received: from [127.0.1.1] (ppp118-210-185-209.adl-adc-lon-bras34.tpg.internode.on.net [118.210.185.209])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 27CE77104E;
	Wed,  5 Feb 2025 07:54:43 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250116090009.87338-1-krzysztof.kozlowski@linaro.org>
References: <20250116090009.87338-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: aspeed: Align GPIO hog name with bindings
Message-Id: <173871328303.403310.37142305555247656.b4-ty@codeconstruct.com.au>
Date: Wed, 05 Feb 2025 10:24:43 +1030
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Thu, 16 Jan 2025 10:00:09 +0100, Krzysztof Kozlowski wrote:
> Bindings expect GPIO hog names to end with 'hog' suffix, so correct it
> to fix dtbs_check warnings like:
> 
>   aspeed-bmc-lenovo-hr630.dtb: pin_gpio_b5: $nodename:0: 'pin_gpio_b5' does not match '^.+-hog(-[0-9]+)?$'
> 
> 

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


