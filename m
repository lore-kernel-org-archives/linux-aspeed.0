Return-Path: <linux-aspeed+bounces-1935-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50364C87FCA
	for <linux-aspeed@archiver.kernel.org>; Fri,  8 Aug 2025 01:47:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4byn376z6Yz30WY;
	Fri,  8 Aug 2025 11:47:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754617651;
	cv=none; b=Fy96Arg2x2lT5bm3guPfiuKys1tHXxKtb3t5/w1cY4h4Z+StZq3q+dJUX4tUvrHKs/DNXts2IU/yffZ/BGCbitg9+iSMy+Q0A2FzcqlKCaqIzD7oU5hP3JvkAdYvN01izoWX3HyQCPg9EiW1ozrfqV05pM8a5cPmoVd9ZoCK8yhferdYFitl5rlu7N4YErZtgQnnFlPVL0dt62BDFk+fXad9KTmai4uk2wijzmB5LmuFLVXkiyzignijQHS74zIeN2e5fRckowqT43Nofe6Mujqnh844Yb+laO1C5f+jTA2x7oofzDFkZacIkPwBKjAbqFq/z2qbE2q11XXBWm9+9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754617651; c=relaxed/relaxed;
	bh=THXhfIs9H9rrYB2vrX4MQGnujXZkNVq7DEecFH0R2bc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NwDc+VqiuLjPlfiGvrm9XyDzm30WqpGNycHSomQqOGbvijbMPiTHPvx7nXCnIuN1U5WWVWCZ4Spz8LPn2eN5ZpMbHi0wy7iahGeW5BUti2Od34jazE50t5OieG5KJThnA7r6u2Vkn8pDNRjaeluZRVdkHMFGHTEAkBTtcWPsfq2etVmujGK/+RNaAXTQoq/p9RLjmYSxmP1Wy64zHIrCaEvYIEE6EvXkPEh0/jyGu9FkFNjFpDJa9OPxXLTJC+MSeRXbXr36V2BkZuofg9CfuUUwu1+o2GWsoDwkpI33ffYqu9k3cu0/y7BxwDUZV/4+CmMp4WvzH5Da6XvPlRH84w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=CWTs9ETK; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=CWTs9ETK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4byn374K84z2xc8
	for <linux-aspeed@lists.ozlabs.org>; Fri,  8 Aug 2025 11:47:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1754617651;
	bh=THXhfIs9H9rrYB2vrX4MQGnujXZkNVq7DEecFH0R2bc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CWTs9ETKMKNU5vACd1Li7sftjh7SfZF8+G16VrXkmjc2puUADe9n2XkBxAMsc+Gmj
	 k6zsMKq0tD8KbbkjMsEnmSPAkW+tZAnVXNqS4CO4Bw3ntAm+opgbp7rM9beeaSdGnP
	 PoyoGO217ooYZ+MLJaR4hpYCi+fnb0O7GRs8a6BrdVy26kY9QiiWkHaSH1MPMXSVQO
	 EC2kaVA9ebD24Y1va02psaU2Kkxmh+bW5p131xgNLrNS2MDCpTrfHIBpYde+lSn1YR
	 9F8fDY9MH0b/NsZTQpzL6gIBOu1GHFJOhGRlrQbqTu2fV+K8qXAY+oj8KfTgdKGRdo
	 3mpYkp4ktMi9A==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4991E6AF39;
	Fri,  8 Aug 2025 09:47:30 +0800 (AWST)
Message-ID: <a14b98078554e27453fc1f96a667b299a15fd4c2.camel@codeconstruct.com.au>
Subject: Re: [PATCH] dt-bindings: ipmi: aspeed,ast2400-kcs-bmc: Add missing
 "clocks" property
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: "Rob Herring (Arm)" <robh@kernel.org>, Corey Minyard
 <corey@minyard.net>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>, 
	openipmi-developer@lists.sourceforge.net, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 08 Aug 2025 11:17:29 +0930
In-Reply-To: <20250807132852.3291305-1-robh@kernel.org>
References: <20250807132852.3291305-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

On Thu, 2025-08-07 at 08:28 -0500, Rob Herring (Arm) wrote:
> The ASpeed kcs-bmc nodes have a "clocks" property which isn't
> documented. It looks like all the LPC child devices have the same clock
> source and some of the drivers manage their clock. Perhaps it is the
> parent device that should have the clock, but it's too late for that.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks Rob.

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

