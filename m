Return-Path: <linux-aspeed+bounces-3667-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3AF107BCE2
	for <linux-aspeed@archiver.kernel.org>; Fri, 13 Mar 2026 21:46:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fXdNB423Vz2yFd;
	Sat, 14 Mar 2026 08:46:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773438378;
	cv=none; b=TITbu5o8ETiuDQDKFK5WfmR8cR4f28zEqRK9RfjeyOfh9p4JKqgScAg2cZE1dVpKq/+2trdHl/m91e+DAWyd/lemq7jB7oWWoRNc8ct8GqFpJk+1yreU0ENB/kQnTeiuVi4wMbJYqgBbMT8axY8fuioyUqM9YP9aeA6IN5zj5k/eBWOfTMaZ8SMWIGLUpnE/UncsxGGKaCMxlQZ8M/V1zrKE03tahOELLBZ24S+W0aNBovq14oDKmXhHQ7AqFRH8wiAGNvtzGugFqASWcMLojqaR0Vl++95DA5Uw+4cvve5y1PwST9Ca9c/IMRCJQMv2K1FVG99qDjZ0e5tExd95bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773438378; c=relaxed/relaxed;
	bh=7pMrp7QFPYIlbrLMp+HZgW7atJSL3fSFR1EuK/IswdM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=gt/KOvs8pvNz5xDpdeFKVWWuTB8B13NrW4aqByeULQJIyvKRR45dyb+4MaEXZj3crJgUyCxbvmOaPDkEGqS6J460zlJk/uIWwgfjKXCC9B+48XfbQde8GIDx6F3P6xiNY32ItSgseSwiIb/aIs7iUAznvRcGtHQBlLzT1+DHddxCCxCnVYszBIDQ2/KmcVP7BqOmYB58cNLqtzL4xVy/H7zOHUAwS1FebMXExykvz0RwuVO8vxTwBNfwrZraRMz8e1wyPHjdM2U6eKeHRmI2O6Y4eHJf5IKuoez4f7SmpotWTmKtZ6SXW/wSGcd+1Uv8LWZMi6NRdxKmdjaY/mIr3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=cAo6k1+5; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=PFowjt9Y; dkim-atps=neutral; spf=pass (client-ip=103.168.172.154; helo=fhigh-a3-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=cAo6k1+5;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=PFowjt9Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.154; helo=fhigh-a3-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
X-Greylist: delayed 561 seconds by postgrey-1.37 at boromir; Sat, 14 Mar 2026 08:46:14 AEDT
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fXdN61kytz2yFb;
	Sat, 14 Mar 2026 08:46:14 +1100 (AEDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 93B8E1400105;
	Fri, 13 Mar 2026 17:36:49 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 13 Mar 2026 17:36:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773437809;
	 x=1773524209; bh=7pMrp7QFPYIlbrLMp+HZgW7atJSL3fSFR1EuK/IswdM=; b=
	cAo6k1+5+nosN1sCm0enMvd9CKWn6pa8U0HG4Y5VjJSVTTxW+7HPe5iEM+d6ll6g
	ozZNArgiQcDkG7u6r+Xt8K2Z55ju3OTbFNr9npCQsl1LfLaM45zfX1G4irXruLKR
	l4wDEy/L4OZ+QVf5z/dQoplIZEZeq0tcqlxExlljfYZTPt0sl21mlBDZu3XaFoeB
	soAzufFuk8lSQWxsiiIuk/ZB0bBufiYlIaCp/XZ16XDvhfAhoX6+lDd0iTjb1XBD
	qc6pRCSfqbVLwiuNXRIEbzJhVqUUn18msQ1gHfGPODXH4axhbmkX5xEAjnbN/U4k
	/YfIAR0RNFRiGjlkLuHYjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773437809; x=
	1773524209; bh=7pMrp7QFPYIlbrLMp+HZgW7atJSL3fSFR1EuK/IswdM=; b=P
	Fowjt9YS6Do1BVQbtcb2RXAG7+rbWHr3QS+aW3NffjVzDlTpZfLKfcITI3YF63S0
	SFkTpPyQW/GmwcdfccV/XW26pkXpGslazgt6UyUpTMFC90pEVv14i48+KmXQgpYw
	romgTAc2XNbCj7AOXsvsf6jymyBG9TGY1JaSJCGeSP23zFp25UnLjGOhDq9i4V3L
	QU/tdpOyry67C9oDTuelEb91ylGKCC89iTMSLc7z8KCsKDFf+dyjFGQ/p5XMxGm6
	EFhG9D5h7puaY2A9LzsML6wXNP1wmAFJ7kEnXuIqIIrRVr+V/AhNcSdIbTSlAlVu
	w367Sr6oUMm8vy1btMMWw==
X-ME-Sender: <xms:b4O0aRvQFjGyv9GOyunRSo1Ojn3of9HvevxGrX8bR4yatcqbN3vQ8w>
    <xme:b4O0aVSxIYRJRAjMWGRiEfdkTrjrQxxXJE94b6KFHdJU7RJNUmmtgnN8Rh9vqy5aw
    7uZF0UsuHmAW8pmwrhzptoneA0Z6OJGow5_4hHEjzoUzkEb-0vwL8Iz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvledtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehrhigrnhgptghhvghnsegrshhpvggvughtvggthhdrtghomhdprh
    gtphhtthhopeihhhgptghhuhhnghesrghsphgvvgguthgvtghhrdgtohhmpdhrtghpthht
    oheprghnughrvgifsegtohguvggtohhnshhtrhhutghtrdgtohhmrdgruhdprhgtphhtth
    hopehmrggtihgvjhdrlhgrfihnihgtiigrkhesihhnthgvlhdrtghomhdprhgtphhtthho
    pehjohgvlhesjhhmshdrihgurdgruhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheptghonhhorheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkod
    gutheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:b4O0aZ4G5qt_rgvhSsT7ELLuZk7BoC5vWKCjem0FYTXw7sLxAqchmA>
    <xmx:b4O0aS2Ez0EwiYmU6TtfsuajpwORU-Cp7H43_tMSajUfKYpw9S4RKA>
    <xmx:b4O0aWlReRj-L7JI3fYRjfYubNEU7_VbW205DdpNNZDBFHC7IaPn1g>
    <xmx:b4O0aYjYPajBz2aaXL0UPH0ACExr6HF7034Rq5-qYClkG0QLs3OytA>
    <xmx:cYO0ac4FpKHz4EEFh5AoSYjRVz8gUgjh4aZvLe0PZujSvqH99efjQEmM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 15C76700065; Fri, 13 Mar 2026 17:36:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
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
X-ThreadId: A224H4bSXjB-
Date: Fri, 13 Mar 2026 22:36:02 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Conor Dooley" <conor@kernel.org>, aspeedyh <yh_chung@aspeedtech.com>
Cc: "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Joel Stanley" <joel@jms.id.au>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>,
 "Ryan Chen" <ryan_chen@aspeedtech.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
 maciej.lawniczak@intel.com, "Mark Brown" <broonie@kernel.org>
Message-Id: <23909400-4e7f-49c9-a982-14036372af98@app.fastmail.com>
In-Reply-To: <20260313-energy-casket-ca8adc1f1fd1@spud>
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
 <20260313-energy-casket-ca8adc1f1fd1@spud>
Subject: Re: [PATCH 0/7] soc: aspeed: Add AST2600 eSPI controller support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 13, 2026, at 17:24, Conor Dooley wrote:
> On Fri, Mar 13, 2026 at 06:07:35PM +0800, aspeedyh wrote:
>> This series adds initial support for the eSPI controller found on ASPEED
>> AST2600 BMC SoCs.
>> 
>> The series introduces a eSPI controller framework for ASPEED SoCs under
>> drivers/soc/aspeed/, adds AST2600-specific controller support for
>> peripheral and flash channels, defines the corresponding devicetree 
>> binding, and adds the AST2600 eSPI controller node to the SoC dtsi.
>> 
>> The driver is intended to support host-BMC communication over the BMC-side
>> eSPI slave controller present on AST2600 systems.
>
> This all seems to be in the wrong places entirely, shouldn't an eSPI
> driver and bindings go in the spi subsystem?

From an initial reading, my impression is that patches 1, 2, 3 and 7
should be modified to use the normal SPI interfaces to implement
an spi target driver, possibly a combined host/target driver.
Reworking this should be fairly straightforward because the interfaces
to the SPI core are well documented.

It is possible that the hardware can only be used to provide espi
device emulation. From what I could see in the code, there is
not much special in there, but I'm not that familiar with SPI

Patches 4, 5 and 6 in consequently would need to be reworked so
these can implement the TAFS spec independent of the SPI controller,
and can be shared e.g. with other OpenBMC targets using the same
module and the same user interface. None of this should be aspeed
specific. 

There is a good chance that both the user interface and the placing
of the code will need a more debate, but I would suggest first trying
to move everything over to use the SPI subsystem but leave other
parts untouched for the moment.

> FSL's appears to be there.

I think this is just a similarly named device: Freescale/NXP's eSPI
device driver is unrelated to the Intel eSPI spec but rather implements
a normal SPI driver the same way that eDMA and eSDHC are Freescale's
implementation of dmaengine and SDHCI drivers.

    Arnd

