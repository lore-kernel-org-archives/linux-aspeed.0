Return-Path: <linux-aspeed+bounces-3706-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFA8F33824
	for <linux-aspeed@archiver.kernel.org>; Tue, 17 Mar 2026 09:50:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZnJp4h9dz2yj1;
	Tue, 17 Mar 2026 20:50:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773741050;
	cv=none; b=JZowLrUIRAro2UQDI1AJwdA/pJNu+6SIfaUv2HBeR2seoVUm2WGVqOONvihFiKbdmbw/ubSScGGdFTyaGBqsh2uhSpOMjCrO2JMmWXl3XVgz3ZTwckU0/mATvnxhHbF3qBOCJPUkjso98eCwu0+FcZIg9wLQ7ZeA5GHuJXpmmZpviM1gCCY+2Ei2hPW9iGrb12vlk1+r7LxQugnrVbZju6wHNTvMyPuNHQGpvDjzSWptx5s9SbeBoySRmUSpEcdpaxIBUQ1zQ0BBVwQnHzdytbydGvX8uT873PLUTNpsGguUBwe3R7+2tCozJLj7AhDft3xYirEHaSlry7DuEufVKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773741050; c=relaxed/relaxed;
	bh=5fLxoANUqctZUS+Z3Co69HqUNOcNosCE/Q8jVsqBBUg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=EIM/LyjVM3cJOVTZyE7E2puPrdLrI37Td8dk9Qdb8xlUX2MUVZ3sLtDSt0ExPOtp+yBSkeXBoDq260EPXaOhU81L2QrqKmRI/TWYEDT3hqBF4UrnuUDVR753cb/3uABbL/Dj2cwJ8kxtfJ/VFj3bg1WSaMgUJTxcyhzeIqRKGt6Hc+sf7gVjy/FRaN7tc4xuO5zbn+y9Dq3FkPfBRKwgnuw5b2kP4FX3A4wqSVoIrgwD1nvjwJqPfESgBs/qLfFqYgveDQ34WTLB5O073W8AmijQ53e1/JbHELXlXLq1R0hsDna3ebo/eHbxMYc3t1tggw6IfjLms4hOElA8dvLl6g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de; dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=j9izhecz; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=Sphob5gh; dkim-atps=neutral; spf=pass (client-ip=103.168.172.147; helo=fout-a4-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org) smtp.mailfrom=arndb.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm3 header.b=j9izhecz;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=Sphob5gh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=arndb.de (client-ip=103.168.172.147; helo=fout-a4-smtp.messagingengine.com; envelope-from=arnd@arndb.de; receiver=lists.ozlabs.org)
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZnJk3FdNz2yfP;
	Tue, 17 Mar 2026 20:50:45 +1100 (AEDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 4E466EC00DD;
	Tue, 17 Mar 2026 05:50:42 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 17 Mar 2026 05:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773741042;
	 x=1773827442; bh=5fLxoANUqctZUS+Z3Co69HqUNOcNosCE/Q8jVsqBBUg=; b=
	j9izheczf9aXHJ3ux1Ulk46cPvtmXGU6l5efH9OapXxeqAsXntGEdDL9qxCMXStG
	fkAGLeArjUnIc1TYDeDdzPKRN0fuAWkudgs/Ms1mFEQE4ktPc+z4ETtXoMD+NS4g
	Amb1DvREGwg737NlFYD+bHd1Rr+jp31cio2idHBrQ6Pxx3/kNBZEM+J1VYqXvku5
	ZAuxAwazvXYjI9AXrlJxASnPrmfTOrDBlMspqpTflfASkF9vaxmAfCSLkweE+5+h
	WTBubjmgB0HA9w7lPlcGQgY22YVHWU4I3rHCZqawtwAXN3YZ5V6kQ/xp7kAs15Oz
	uCqL8oKfIBi9o/k/VFGpKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773741042; x=
	1773827442; bh=5fLxoANUqctZUS+Z3Co69HqUNOcNosCE/Q8jVsqBBUg=; b=S
	phob5ghFn0DzHcEbtHEBV5Nllsaqn0xB7zZEmEtSv/6QFpFi9jsLW1o6PCgXLAAk
	4oLzUYxc+yDp0+fDEqV7M7M+NCmdy4DY8Gb4UIj7KAwadWr9K1PJ99nXcnj8pYI8
	rQDukuCasyugtvAfAHshMDm09awoOn3m844pFGd5P9UL9pR6JFWFGpFQJXxsiyLO
	eT2j/cIjOQpRlfHQXA9p+RwXmXaX4RXIKnIBddp6mUwtHjn6UKwiz5uJiJJwwyh1
	vJqcCNX5LP3i+qhHKNVxFhbdNia9sC4eGyCt7bDcYSCZH9VKCWbHuE4pFuDbNCSv
	PQfr4Zmoga9Z1uSYNyk1Q==
X-ME-Sender: <xms:8CO5aVCSbFm5-5AI28l-qPCyJjvkZMYQiac3oozMCeGzH0X1xSH3hg>
    <xme:8CO5aeX__LuecRfzEcH7oHPPx27sSRAJcCtQXcrV10s2k0BNIqoJ-Z5pF9xBZKxJg
    yUKOyzuBbSPnKfbaZ-ptbCBZ_X0I0oZcdj8EON6JIVgsUPfF4r_8cQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftddtleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhihrghnpggthh
    gvnhesrghsphgvvgguthgvtghhrdgtohhmpdhrtghpthhtohephihhpggthhhunhhgsegr
    shhpvggvughtvggthhdrtghomhdprhgtphhtthhopegrnhgurhgvfiestghouggvtghonh
    hsthhruhgtthdrtghomhdrrghupdhrtghpthhtohepmhgrtghivghjrdhlrgifnhhitgii
    rghksehinhhtvghlrdgtohhmpdhrtghpthhtohepjhhovghlsehjmhhsrdhiugdrrghupd
    hrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgho
    nhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8CO5aZMbSeyN3RQqG9n6P2uzhCmKggv9NMbIEQoDWv_MS110fnCGmw>
    <xmx:8CO5aX6Or3i-QsBLWieYFayNJ9ph_3S937sX1O7wvmzYSb4WVb4drg>
    <xmx:8CO5aeZ7zn9ATGkDVlAtAgvHlTh9weIuEzEbAczQtSxuT6AUBHJ6Gg>
    <xmx:8CO5acE96byr1qKyXDx_eNW4OXzKtW19QrMcsfFfucQANLw8sL22Jg>
    <xmx:8iO5afCGo-vGSYe9A1p9dM1cRzSVO7DRrUI6Yb2rfFtanz03t8PGKo1x>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CE679700065; Tue, 17 Mar 2026 05:50:40 -0400 (EDT)
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
Date: Tue, 17 Mar 2026 10:50:10 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: aspeedyh <yh_chung@aspeedtech.com>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>,
 "Conor Dooley" <conor@kernel.org>
Cc: "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Joel Stanley" <joel@jms.id.au>,
 "Ryan Chen" <ryan_chen@aspeedtech.com>,
 "Philipp Zabel" <p.zabel@pengutronix.de>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
 "maciej.lawniczak@intel.com" <maciej.lawniczak@intel.com>,
 "Mark Brown" <broonie@kernel.org>
Message-Id: <0f7f0f96-a918-47d5-a0bd-bbde494c8fed@app.fastmail.com>
In-Reply-To: 
 <KL1PR0601MB4276ED93723F0B1F42349AD89041A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
References: <20260313-upstream_espi-v1-0-9504428e1f43@aspeedtech.com>
 <20260313-energy-casket-ca8adc1f1fd1@spud>
 <23909400-4e7f-49c9-a982-14036372af98@app.fastmail.com>
 <c3b28ee92fa46700887d0c68b23045b2418358a7.camel@codeconstruct.com.au>
 <KL1PR0601MB4276ED93723F0B1F42349AD89041A@KL1PR0601MB4276.apcprd06.prod.outlook.com>
Subject: Re: [PATCH 0/7] soc: aspeed: Add AST2600 eSPI controller support
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Mar 17, 2026, at 09:14, YH Chung wrote:
>
> In the meantime, my understanding is that this driver is for the Intel 
> eSPI interface used by the AST2600 BMC,
> rather than fitting a conventional SPI controller/device model. That 
> was the reason for initially placing it under
> drivers/soc/aspeed/, since there does not appear to be an in-tree eSPI 
> subsystem at present.
> However, if that is not the preferred upstream direction, we are happy 
> to restructure the series accordingly. 
> It would be very helpful if you could advise on the preferred placement.

I think we need to make sure everyone understands what the options are
here based on what the hardware can do, and what your use cases require.

From reading the old comments that Andrew linked to at

https://lore.kernel.org/linux-aspeed/HK0PR06MB377924CFCBFE9BD40E1C4A5D91D49@HK0PR06MB3779.apcprd06.prod.outlook.com/

I understand that the SoC has a "hardware mode" in which eSPI is
directly implemented by redirecting upper-level eSPI transactions into
functional blocks of the chip, while the software mode behaves like
a regular SPI endpoint controller and your driver implements the 
same interfaces in a mix of kernel and userspace components. Can you
confirm that this is a correct understanding of what the hardware
does, or where I misunderstand parts?

If I understood this correctly, I think there is a general agreement
upstream that the low-level device access should indeed be in a
drivers/spi driver, with no ports of it in drivers/soc/aspeed. Using
a portable driver subsystem is always better than a custom solution
if it works at all.

For the higher-level interfaces (flash, gpio, ...), I don't think
there is any consensus yet about how this should be done, but again
I think this won't be drivers/soc but instead something more
generic.

One option here would be to sidestep this problem entirely by
moving all of the eSPI implementation out of the kernel but instead
have a hardware-independent userspace implementation that uses
the spidev ioctl interface. This is always going to be slower than
an in-kernel implementation, but also much easier to implement
and debug.

An in-kernel implementation of the eSPI backend (on top of
the SPI layer) is certainly a realistic option for the higher
layers, but requires finding consensus both on the the logistics
(subsystem, code ownership, interfaces to other subsystems)
and more importantly the user space interfaces that look like
they will require several revisions on top of what you have
today.

      Arnd

