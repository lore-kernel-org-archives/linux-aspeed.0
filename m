Return-Path: <linux-aspeed+bounces-2152-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0108CA1010
	for <linux-aspeed@archiver.kernel.org>; Fri,  5 Sep 2025 07:47:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cJ7k331GXz3bcy;
	Fri,  5 Sep 2025 17:47:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757058475;
	cv=none; b=oBqg4txGEdWgO/SM5wu/7vNngMTW7KYVUt2tAIZvbY9ftQ4W+8NNT52aX1BXCDbGqhcJE6/I+Kuv1TpAaPDC9QDatK7i7uJWTaKeltIFB7xQOm3GihSGPUN4yui6xf4W9vHqMpX6A7ClL0Hm8FI6f8t3hPKU6lpclbGcq7eCjfbMEczqyvCpUEwyOXSNNE9XrB/G3qlNbBvCOecNvJexJRDBNb8F4nGjHF8wJCOYJNo5sQm+17zRqET3e5z0w8KrGIvQYQTT5LspSK5f1e2rMdqNYv88WZqLU8f/Eju8ZCz4J7hidUaQ42qMjAX6Ig6pVD6MlHoHpJDRuhrbax8hFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757058475; c=relaxed/relaxed;
	bh=rBtkAe6H+jyGj4tt5HXrxDOSNwUiyry3aDabLs2QBuI=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fgY5xOeuBf+ex9A79pKOczPZf8zy/dbbub4rkzoTf/Ko+lGo7KBWF5NB++/199JSIL829x8Yp52zsSEFzsg1MQOWLiUbfFA2G+P4gdHR6UKTyP9VYn8Ngjp6dXo7h5bLwGR7SrA2QzyMVImGKoQGZDaOlysDmwiaBM5V/bOGxha2JMaBtb8VBe9HSSNApzzSQVVewT9J6Pe7ToQHD9PDYygFzRNx1oIHwJAXk1HbmqzylhMBTdho2SWAqoXOW7AIJHwzbrZ0WULh62ZbLIxAlonC7W5Lrlxdjm+qI/QhBOIqSO7rjoK97k71qKQ6r53SZ2NMudiE6ZYDsze43bZ2Mg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wbJMk1A9; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=NJs6nJbE; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=wbJMk1A9;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=NJs6nJbE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cJ7k22ZBYz3bYx
	for <linux-aspeed@lists.ozlabs.org>; Fri,  5 Sep 2025 17:47:54 +1000 (AEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757058467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rBtkAe6H+jyGj4tt5HXrxDOSNwUiyry3aDabLs2QBuI=;
	b=wbJMk1A9M/sLp/JYaMOxP5tGNweS3NYiR5ynw15kjZMAZ5rUMMSzHOnG1xBv+8gq4Vxhj+
	oI1zFvBrXNGizVzbHofs4WCKcyD7In5isJOgPj+8Vc8aIWO2wap9DplKViLeXEQvFB8dPm
	7gY5pnY/L4llUs8PDxJdWy3PUK7IXezT+B8lUw59CJpDwBlURZ2PzaLH6DlsQOawbKMPvJ
	guPWRrINA9tUjXJ9RppdoorgcwTpGQJ3k7WnJkAgcttp7blEXkozcrCNWGk+LIl2jBelZk
	J66iUGfBnBHmZecbdPkARyTfSWWr6SglxrlRTY/2RM77NlSX7RQ+PPrxzTIH6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757058467;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rBtkAe6H+jyGj4tt5HXrxDOSNwUiyry3aDabLs2QBuI=;
	b=NJs6nJbEfespe8MIIJCa7ECvbrIBkCIhMite81FenHjk7bkCHnKDVUp/y1C6hXCIANO45v
	SdDXOIvxzzqVzYBg==
To: Ryan Chen <ryan_chen@aspeedtech.com>, Eddie James
 <eajames@linux.ibm.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Lee Jones <lee@kernel.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 4/4] irqchip/aspeed-scu-ic: Add support AST2700 SCU
 interrupt controllers
In-Reply-To: <OS8PR06MB7541CD16E659666868EAECB9F203A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250831021438.976893-1-ryan_chen@aspeedtech.com>
 <20250831021438.976893-5-ryan_chen@aspeedtech.com> <87y0qx0zqu.ffs@tglx>
 <OS8PR06MB7541CD16E659666868EAECB9F203A@OS8PR06MB7541.apcprd06.prod.outlook.com>
Date: Fri, 05 Sep 2025 09:47:46 +0200
Message-ID: <87tt1hwdb1.ffs@tglx>
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

On Fri, Sep 05 2025 at 05:55, Ryan Chen wrote:
>> So you have two different handlers. Why can't you provide two different
>> mask/unmask/ functions along with a seperate irq chip instead of cluttering
>> the code with conditionals. Thes two variants share no code at all.
>
> I will add irq_chip in SCU_VARIANT, like following.
>
> struct aspeed_scu_ic_variant {
> ..
> +	struct irq_chip	*irq_chip;	
> };
>
> #define SCU_VARIANT(_compat, _shift, _enable, _num,  +_irq_chip, _split, _ier, _isr) { \
> +	.irq_chip		=	_irq_chip,	\
> .....
> }
>
> static const struct aspeed_scu_ic_variant scu_ic_variants[]	__initconst = {
> 	SCU_VARIANT("aspeed,ast2400-scu-ic",	0, GENMASK(15, 0),	7, &aspeed_scu_ic_chip_combined,	false,	0,	0),
> 	SCU_VARIANT("aspeed,ast2500-scu-ic",	0, GENMASK(15, 0),	7, &aspeed_scu_ic_chip_combined,	false,	0,	0),
> 	SCU_VARIANT("aspeed,ast2600-scu-ic0",	0, GENMASK(5, 0),	6, &aspeed_scu_ic_chip_combined,	false,	0,	0),
> 	SCU_VARIANT("aspeed,ast2600-scu-ic1",	4, GENMASK(5, 4),	2, &aspeed_scu_ic_chip_combined,	false,	0,	0),
> 	SCU_VARIANT("aspeed,ast2700-scu-ic0",	0, GENMASK(3, 0),	4, &aspeed_scu_ic_chip_split,	true,	0x00, 0x04),
> 	SCU_VARIANT("aspeed,ast2700-scu-ic1",	0, GENMASK(3, 0),	4, &aspeed_scu_ic_chip_split,	true,	0x00, 0x04),
> 	SCU_VARIANT("aspeed,ast2700-scu-ic2",	0, GENMASK(3, 0),	4, &aspeed_scu_ic_chip_split,	true,	0x04, 0x00),
> 	SCU_VARIANT("aspeed,ast2700-scu-ic3",	0, GENMASK(1, 0),	2, &aspeed_scu_ic_chip_split,	true,	0x04, 0x00),
> };

You have this split_ier_isr field already, which should be good enough
to select the chip to assign, similar to what you do with the handler, no?

Thanks,

        tglx

