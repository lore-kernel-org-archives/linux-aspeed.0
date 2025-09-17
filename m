Return-Path: <linux-aspeed+bounces-2262-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBB3CAC59A
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 00:01:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRwld0Yw7z302b;
	Thu, 18 Sep 2025 10:01:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758146846;
	cv=none; b=T/8v/giVzfnjh3VFMqeVqyTEBVe9RNJExtK6VmNJJfHMgQNtxA0IMSAzM3R0Dh9l6N710HugBwU7rBo9C0hbv9OIeEM0QzitjyHPWDdPtiA2OmbfJH9wtSrYqfKqSEK689nH3fwX++DgC3hjKQ2BzShRh/X51bXNfO6oFow8D+m+USUrmd83pms77WjwNmVbMYClZ2ZtQ+RjhXqauE+94aA5r+XxuEo7p3d5WOXCUR70A9IS+unCYrQLfEC9fnvuBXyO+evMoW1b476ZJOcv9n0aHv6mxwj8mJE+739unTdRYQxKrNrKnLOmHRZEca/VlkPH7sBN/imSUrHsgUR0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758146846; c=relaxed/relaxed;
	bh=u4T4Y+htEHk0Kb10DGACvmH0TTe+99pyaFvj37z6/wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgIM8ezGYO7tdWzZlfee7hikpBHbOSr9jmDB1J1ezbLPZpejT8WDjdCa2QRdCte6h+NNLW2qFwyUx3+A+BtQ9OcEaxtVDLi3l4/8Y0uRwHuRw4Au9pE6ROFpd38qm5AFOW0KiwGIh0X7GTocraxd6el3oeCV/NoEOUgMK8fJq3meAe5arZqVyKR8he4DBYsEqNbmcofUjb8y/vC/2P8GjGLSi1lmVDVI6v23UUpzloJ9J6vgFwsVFJOYkMrbGoquYR8Zc28npj21ovncT6rIw2x30yNNSgHt9/ui1Txy5ejKrRcU2mkqI4VAacVAGn35wHeAqlbB/uKY561zJsc8Lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=GnyFuQsE; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=cjS6Tyca; dkim-atps=neutral; spf=pass (client-ip=103.168.172.149; helo=fout-a6-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=GnyFuQsE;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=cjS6Tyca;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=103.168.172.149; helo=fout-a6-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRtDD57CCz2xQ1
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 08:07:24 +1000 (AEST)
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 906BCEC0294;
	Wed, 17 Sep 2025 18:07:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 17 Sep 2025 18:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1758146842;
	 x=1758233242; bh=u4T4Y+htEHk0Kb10DGACvmH0TTe+99pyaFvj37z6/wg=; b=
	GnyFuQsEKF2IuQGMNvo9BwlxBb5jX4kHD4votbFAGjxKrwFfUSJYmllYV85P4h1l
	V/OhdskoOYAmG21Kb1jc4Ge/6d6Mg5br3YN0qVpnl/E1FWPn4lT0BI/jzUixCm5C
	METW3z+BDaHm8wBRGQjmf19Kzlx+RHS/abGnksvprQUjlPfC6BYtoc0SABNby/oG
	2HBbGqcBelDRDUhRIEDnMmDG0VvFrCtS4d+WyvNYeKQE3T3PqrRxSTuuF0U7wgKv
	eKVJG/SJTf/zEWJ/zeGQ1n3JBLn9e+xysydgW1iRtYWVU/lYZiUs9IrZW8S6oApq
	LCmEVrMRJcj/9tIEK4IdSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758146842; x=
	1758233242; bh=u4T4Y+htEHk0Kb10DGACvmH0TTe+99pyaFvj37z6/wg=; b=c
	jS6Tyca1YI5+/Ml5n6Zv44XcnJH277ch3KUi3J50S5ENRl8WcyxcfncfQuGr++Ng
	7TO2Eem7GT8rrINW1FKZG9a76GOcEsD49YYjZfFyyMBFga8+1x2rbz6SkiIP4w6P
	qyjKryn/uHVRnqBg4cG5L4TQUa8+4vcnTjBie+yUQhRUU+HNiDeHS95xJDYROQcT
	GojHS1uSWwt8KWmnhb7CjyMBor/mm/pHA//xQnXKvT+JF/xC6hnE556nZnUta1xJ
	oqZSdd2bvOtSnB6DASJBON63q7vZRjIHUzwwylyg2r7qHDh5874QrlpR/93eu1kB
	2OhJyYH8/yzVxMTjqvf2g==
X-ME-Sender: <xms:GTHLaGRU6ie16DyxXOMBGRfYaBIMGtHrauOk4RN2ZDARaZAmi-SlPA>
    <xme:GTHLaK_hktpwucTvYO0UAfF97ZtlaX3lLYKIBSUvOQ8ey6zPvk502-C7Hn6DsuHTA
    S3pvvrbsBtTkXHx-u8>
X-ME-Received: <xmr:GTHLaGi80pOI6MFvlMGJhY5aPagZ7LFfEz52-29coRxXpLqHPb-DPwqUVkZlh5XTJMTZTopY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeeitdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomheptfgvsggvtggt
    rgcuvehrrghnuceorhgvsggvtggtrgessghsughiohdrtghomheqnecuggftrfgrthhtvg
    hrnhephfekvdekvdfhtddvteehueeuleetjefhieehjeeuhfdtuddtvdeguddtkeevlefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvsg
    gvtggtrgessghsughiohdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhope
    hrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohgvlhesjhhmshdrihgurdgruhdprhgtphhtthhopegrnhgurhgvfies
    tghouggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtohepuggvvhhitggvth
    hrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghr
    mhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqrghsphgvvggusehlihhsthhsrdhoiihlrggsshdrohhrgh
X-ME-Proxy: <xmx:GTHLaLbhMO5zUH2oImyWNfvzJgSsabXu2pBe4O5jyXtJ7UtD9hHCMQ>
    <xmx:GTHLaL_bD3CujM01bn6a3OGstVlhe6WxadDNXZLBkNo9Ch9Ds0_iHg>
    <xmx:GTHLaNPAzHLJZsafqLU0_TGdG_0WOka9ID7cbuQAWiEqw_jiRG9KOw>
    <xmx:GTHLaIF97r2dpKj9SqD4afZIHb2zHr9-7xF5L3kPSZPXu_oCZQloVw>
    <xmx:GjHLaFSh6Lpz6c87qmzXNVP0KiwxTrDNvyQnzyWfhDSsquPoxCQcR6nf>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 18:07:20 -0400 (EDT)
Message-ID: <93193358-9818-4c63-bd55-9b910631e2a9@bsdio.com>
Date: Wed, 17 Sep 2025 16:07:19 -0600
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
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: add device tree for ASRock Rack
 ALTRAD8 BMC
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20250917180428.810751-1-rebecca@bsdio.com>
 <20250917180428.810751-3-rebecca@bsdio.com>
 <8b5625a5-56bf-49bc-b4cf-82c60460db65@lunn.ch>
Content-Language: en-US
From: Rebecca Cran <rebecca@bsdio.com>
In-Reply-To: <8b5625a5-56bf-49bc-b4cf-82c60460db65@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/25 15:04, Andrew Lunn wrote:
> I see you did not manage to get phy-handle to work.

No, I didn't. I added a printk and it said the addr is 0, but adding the 
phy node with a reg value of 0 doesn't work.


-- 

Rebecca Cran


