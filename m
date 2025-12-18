Return-Path: <linux-aspeed+bounces-3146-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA837D6E2CA
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Dec 2025 18:41:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dXKHw2X4Bz2xqm;
	Fri, 19 Dec 2025 05:41:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766083276;
	cv=none; b=RB9+SVukTKljTh2txLYvhOjcprzNGpPKahlWPDWQfd8sXkmBE3vx/3Orh5yv1CWBSBZSWjv4gKa0esubeQnIaEcZSje4NwByrj/rnDuWmsgHPnfblwmePTyIRgKmfsRX9MlT/jrTkaHm9XMv9QNMbkn9Zk04i4vJT6Nr1dpvWIrdLgfyhBjLJd6LV3Mb8ttMPySOE4VWhMrN6x0hmgxei/i9w/8tJWHCKC8sxyJYrPq0KtCM4Hew9CEdV8pi7rjttK32OuM81A6UVD8ZOEHeOVW2/Beo37MPemUbOxFtsxQrFS24C2z6u2Y8s3nJGK7XPFoyZL8iCC2LMKTPjQ4+UA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766083276; c=relaxed/relaxed;
	bh=cdouFEOrCPjvUbFG8nWL4nevGsYtHhwmjnJ0/LBie9Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PneL2vE+CZ/JT30pEayEL0OIKF6OcJpauZFG1EVuMN8ZJvUB7h8I4qd7GfusazMY8wsG1bABt8y8KQwZPnVITqFTGOwCz0OmFl6NNA6lGaVqCI+w6n5zwUpgWBatPKAbtS7JdqjlycPzOXEN+eyYzBHiHnYqkbGomIHUtchOFqyGtSEsGd9d93asp6+KkqNlfMHKxENMHZu2IJX7IoTtByml1EzqVSRkuYXZKAsrgS8IidBn7zDV12d98tdUkQhIFEr8WxoKhRmjv8G9e3mTY60SiI5I8WalRM27qoxBXtfTXtY5IlwhLnMYO3susL/H6Wdus25SfDXSjdQW3JETOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=dkcki0hm; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=YvQrYqW+; dkim-atps=neutral; spf=pass (client-ip=103.168.172.159; helo=fhigh-a8-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=dkcki0hm;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=YvQrYqW+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=103.168.172.159; helo=fhigh-a8-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 425 seconds by postgrey-1.37 at boromir; Fri, 19 Dec 2025 05:41:13 AEDT
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dXKHs5wVJz2xpm
	for <linux-aspeed@lists.ozlabs.org>; Fri, 19 Dec 2025 05:41:13 +1100 (AEDT)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DBC2D14000B1;
	Thu, 18 Dec 2025 13:34:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 13:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1766082845;
	 x=1766169245; bh=cdouFEOrCPjvUbFG8nWL4nevGsYtHhwmjnJ0/LBie9Y=; b=
	dkcki0hmWQsGbAYxWik7uerrrukMUQZU2KYD3RuSCvsUhqB6C79x5uwOrshVWjrY
	mQk3FkvMFZsHsyzvL+1sg6NHxHe0ZBklRmkIDzO+x96Aprrrpdi4fFs7IffQRDTQ
	gK0tSPSjwdveR9y49lnZDbKKTM9Er511nheLpX9blAxpEWuv7kgSxE+bCduyMlPf
	SliTpctMoQD64ILSu7qjaWTaWmgDnOihSgssiuP8UCtuVWKb7XmJQo7LFaT+4r55
	staQMxZwt9ech8RjKyfjfWKSuKSYcQa80q6Usf647kMMUnXDRu5BXA5sWUPwdIhY
	qvYsOZimeBjC8SpYRatcAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766082845; x=
	1766169245; bh=cdouFEOrCPjvUbFG8nWL4nevGsYtHhwmjnJ0/LBie9Y=; b=Y
	vQrYqW+44Cj5gBN+GVjhOPOEsOz6vWtW9bxDZvv2Bo5Y88PCMJJlSHYnpWKdKpZQ
	TWyKBon/AahqG6BE3QH6LWM+/1MQvxqfkN64ThAKYfXaPHi50EgyRdRzc3Tu57CW
	b66664KkeiNDd+jMsi2/dQM9Dwn7ZK2ltI8F1PM59jL4DYY7QITjTivXqSsyo5Yf
	2DJkuRuPaNNDz4Mj2E7NvoLiHnRzSg66Cp397fSVAFohhk6C+igEXpBvSIXAnxf5
	D3ophywQd9IdbWYPoRdgYiUHWx9NSefbpPibvTfCuZ+gJXL+79itc0oYsWCYQZtL
	hu+crSlG+dS1UR3YhT3bQ==
X-ME-Sender: <xms:HUlEaWUVDsel0KlcF3YMKRRutSo5-PP-WTHp7F6c1xOqXYybd76S_w>
    <xme:HUlEaSIZclUOu9g0hoqRS08bG2Wdntjxw0kjXsZWvuingqGA6Jzg-ADDbERIA-yOf
    JBqnMXRlkm-WnOhhieyl4s7HWZy6Zc_ME_GEjMm0m-qZZxIChW3jjY>
X-ME-Received: <xmr:HUlEaevS_G0xtFGjZkkZbQic-HTbKLmH6znjn7mWnsks9fYoUK9U4R-nW4HP0nRTTpXSk0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegieduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfhuffvvehfjggtgfesthekredttddvjeenucfhrhhomheptfgvsggvtggt
    rgcuvehrrghnuceorhgvsggvtggtrgessghsughiohdrtghomheqnecuggftrfgrthhtvg
    hrnhepfeegtdetledvieffvdffteevhfeggfeuveegheffjefhvdelieejgfeitdehgeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvsg
    gvtggtrgessghsughiohdrtghomhdpnhgspghrtghpthhtohepudefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrhiikheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupdhrtghpthhtoheprghnughrvgif
    segtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphhtthhopehtrghnrdhsih
    gvfigvrhhtsehhvghtiihnvghrrdgtohhmpdhrtghpthhtohepuggvvhhitggvthhrvggv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkh
    gvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:HUlEaf1vqXWYGyVztb4bg_3bccL29zxHr04LN7Lx0Quj2usg3cUf6w>
    <xmx:HUlEaeONuTnfgntPUEyVeNF8Aal7ivurpoOPVb7IzjsmyuQ8fhIhoQ>
    <xmx:HUlEaXVw9HfkK3UVLcmqWN7gguA0hkyLCXzecVyRLEFS5M6DW_NBqg>
    <xmx:HUlEabafv35P00PVXcY5cgUNip6VBMVJnIaTZ5bd-GDsWNQd8SFQAQ>
    <xmx:HUlEaQ0x4Daogj9ujBrVRmhgqyM4zyz9yqjirYGmqQpbjvqNeGjqDzx6>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 13:34:03 -0500 (EST)
Message-ID: <4eff8506-8049-46e9-997e-a41edff32bbc@bsdio.com>
Date: Thu, 18 Dec 2025 11:34:03 -0700
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
User-Agent: Mozilla Thunderbird
From: Rebecca Cran <rebecca@bsdio.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8
 board
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Tan Siewert <tan.siewert@hetzner.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: Billy Tsai <billy_tsai@aspeedtech.com>,
 Conor Dooley <conor.dooley@microchip.com>
References: <20251218161816.38155-1-rebecca@bsdio.com>
 <20251218161816.38155-2-rebecca@bsdio.com>
 <5aa36c56-798a-40cc-b0b8-be3f7c92136f@kernel.org>
Content-Language: en-US
In-Reply-To: <5aa36c56-798a-40cc-b0b8-be3f7c92136f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/18/25 09:21, Krzysztof Kozlowski wrote:
> On 18/12/2025 17:18, Rebecca Cran wrote:
>> Document ASRock Rack ALTRAD8 (ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q)
>> compatibles.
>>
>> Signed-off-by: Rebecca Cran <rebecca@bsdio.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> Tested-by: Tan Siewert <tan.siewert@hetzner.com>
> How was the binding tested?

I ran "make ARCH=arm CHECK_DTBS=y aspeed/aspeed-bmc-asrock-altrad8.dtb"
to check for errors

and have used the dts file in an ASRock Rack ALTRAD8UD-1L2T system with
Linux 6.12.61 running OpenBMC.


-- 
Rebecca Cran




