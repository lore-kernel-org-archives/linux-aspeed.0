Return-Path: <linux-aspeed+bounces-1791-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37CFC83F17
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 17:37:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnLtn13Bfz3bmc;
	Thu, 24 Jul 2025 03:37:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753292257;
	cv=none; b=nOO4q7Uh6nLQijVTgy06zDFTl8ajjbjo/awuzC+tDp5qNzfQBDxdFlcS9dx6+9iTmvoAHt1AMJHoM+cplSOM1RFHmfocxX0PLOt/SNEhWuhO6+zWIgjAjD9Z161gNyiIuJZDbQ9FIeRs44G3vKdg919ptIurJ4BOgDf9GMiczJHKUJdadOHL+ORU5gzRiu2XJoMt8p6aa5vclj0/mIa/hqth7BQ7Bcm2Km36S2cP1L9j7kMJ4wNaQoguD1dWEKOodgnt387/YOs2kmxyDpjLDmpHc6aIndELK+czck5CvWWfg5KcLUogcjXVT5ItzgaVzFRFppEdxmRBcOhKIFbsGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753292257; c=relaxed/relaxed;
	bh=NAN36tnPlVScqFyW8H2kecVmf43LbzR0LCpjmIdCB6k=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XRiofxsho6f/gj2m+XpB7QvB9lD3vN0pjT8GEFW7c3/JK4W89p70vKp0xIhKx0KTHpRaaLMxYa/AjXjchfO6RYZ0b5wsdz1IjjYhRib4JyftFIt0raESCmAeo9UmOB/OHhTMCeKVq3+cXefYsaeTzguJeDPtzoJdLe7YDCfiMpV70/LF5tie9SjUUlrFQIHPfhryl3ue9YDHhIV9IJiCQiv0rf3P3xtzmynw1/Wk6E5pEpDvYDlIxe1WPoR8M42MSKt884i6GzJfwhaoGgilJSPC8IK3rYFCNBcF4lR2IaKLG0H/vFhLuuHthuU2HD4yOzX+gfDbdviKIh13jp741w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dTEoClWJ; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=V/m9EQLS; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dTEoClWJ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=V/m9EQLS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnLtk7374z306d
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 03:37:34 +1000 (AEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753292247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NAN36tnPlVScqFyW8H2kecVmf43LbzR0LCpjmIdCB6k=;
	b=dTEoClWJpdbZ8dDT/H8RBibW5G3pXOOc7s0AFPsIuxm4wZIG3cAMH4PBg7kS9MSRq90Z7p
	mdkx7DyiIBN13jDTsP4J3u7cq80L9uQDFENlrOzvWmmllj4cYDp8CWrhP73KFXPFDLa5Rh
	ufDzvNPhC6DkMEy/jgY/NpIGpgsP+B3UQ2R+FnIHCYfKdbv+bgnfuL8jvPslRiwEdTRDM+
	auRoX4DfeM7cJO5PagYEI1rkPT+ts9Xzm58KVrqTNA68AAbhiW1Z3PZmG3VezBuwE8bywZ
	Wzlxur0f6tt0Lb1ZqpQkWyt9g+zWAgLuhXQHESNLqMoyf0QJyzB1S113gM9nsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753292247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NAN36tnPlVScqFyW8H2kecVmf43LbzR0LCpjmIdCB6k=;
	b=V/m9EQLSeALkvLMUgne5PHhsAdv3wLFBWfmwy/iiP2pq1OL7lDqxS5TYhKlnJ2UF4PJaNs
	39ByRYfi3VRICtBw==
To: Ryan Chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Kevin Chen <kevin_chen@aspeedtech.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>
Subject: RE: [PATCH v3 2/2] irqchip: aspeed: add debugfs support and AST2700
 INTC0/INTC1 routing/protection display
In-Reply-To: <OS8PR06MB7541516DD4FDEBD72A764042F25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250722095156.1672873-1-ryan_chen@aspeedtech.com>
 <20250722095156.1672873-3-ryan_chen@aspeedtech.com> <8734aotfdq.ffs@tglx>
 <OS8PR06MB7541516DD4FDEBD72A764042F25FA@OS8PR06MB7541.apcprd06.prod.outlook.com>
Date: Wed, 23 Jul 2025 19:37:26 +0200
Message-ID: <87wm7yrep5.ffs@tglx>
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
Content-Type: text/plain

On Wed, Jul 23 2025 at 06:02, Ryan Chen wrote:
>> > +struct aspeed_intc {
>> > +	void __iomem *base;
>> > +	struct device *dev;
>> > +	struct dentry *dbg_root;
>> > +	int (*show_routing)(struct seq_file *s, void *unused);
>> > +	int (*show_prot)(struct seq_file *s, void *unused); };
>> 
>> See the chapter about struct declarations and initializers in the documentation
>> I linked to above.
>
> Sorry, I don't see the struct "> > +	int (*show_prot)(struct seq_file *s, void *unused); };"

I fatfingered that, but that's not the problem.

> My original submit is following, it should ok. Am I right?

No. Read the chapter I pointed you to.

> https://www.spinics.net/lists/kernel/msg5776957.html

I have replied to this very mail. No need to paste me this and the pointer
to some random mail archive


