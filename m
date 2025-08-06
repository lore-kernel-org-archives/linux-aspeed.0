Return-Path: <linux-aspeed+bounces-1915-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3CDC87FD3
	for <linux-aspeed@archiver.kernel.org>; Wed,  6 Aug 2025 14:45:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bxtPF71qbz30Vb;
	Thu,  7 Aug 2025 00:45:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754491505;
	cv=none; b=bWPaw6Rcyt0IDEipTrRt5nSrQ7IjwTmGSSiO2k1y8VjmMPKZZRz74/7qLptkdGiI9dLZi6jeiwT0aGEpox6RViyIwwdNfrSpOMa5GPkHofxm4akNM1vkc4AhlBQsdx14U1lKIZeUHwDu3yqpszSnMF62PwgWd2P5I36u4OQ8ZVPA6LBwKY/M5Hjcb3eWisWkCQL5AEzYEUkEOFqbFOmm8iJOPsLnJ7xLt4Q66UIATLixniikkqNw30usV7z8mekjTjpu1HzqAKRqA9n2acGAlwMdBNhYLlJ7K+tCgGk95H/IRwKfCvl22a5yMI1NA5NPVyaN803hpNjfjVtLYV71hA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754491505; c=relaxed/relaxed;
	bh=9dKSnmyZhBtsAHpcDfwkp4+zP/Y5X/HnAHpBN0o8UN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f71wvD6E8EfLafu2mRkfm96fkR6ePTOy1tPbk0qc9iUb3yryfSq+wpV+uKM05g+7c0Y6SYT53FcjuiXd3qjWrS105pVWqQzL1VtzntUhgiSSgLi+3/PH9wxQsxJ0Q7TFpcj8MmX3LbeL42gbeqB5WsDzXjPTixMBHqg8hqLur6pp1igA5QFaPtCQqEHA5uDc1g1K8tVlPWepop+KTRgeBHvLPFF8mwTz1nf83eh6b8CQ88gclxiVD7xPPTZNIdcHUcBfsNP4P4mgQn1WTh/Y/cUel06SuiSnuLKLm/vkeGIyTmXlRQtHPm1/6aqHn2rKC6LQcXYH1YgUuNdH0mVhHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=N9H4ngx6; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=lASAwrt6; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=N9H4ngx6;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=lASAwrt6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=tglx@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bxtPD501Yz2ygJ
	for <linux-aspeed@lists.ozlabs.org>; Thu,  7 Aug 2025 00:45:04 +1000 (AEST)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754491495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9dKSnmyZhBtsAHpcDfwkp4+zP/Y5X/HnAHpBN0o8UN4=;
	b=N9H4ngx68JBjI+CbEYzUEvOnNXD/Q6OJGe1uzRJazZvmOAOq21F1qC9dAupcKLSxl4q3SO
	79ebFfOGuYvCJVjSHAOz4Fb1BP2cSfdb7HwM1sOOVNmCDOpw3LPqVNsEIyzwVfiNfKzbFR
	pnHyoy1SSxeiaDdh4J7V9mi/bfHRx/GRD5W3virKQZOYw2BFY4AuUcXuzlpVsn5a7eTayU
	ALC26UxbEr4FBDdtG2IhRLh7mHfmehwyKSM37iYyYmVbFAJqE8GzWyqTGmsV2P9Z4p/ZdM
	fDorgcfgO18MHPF93cg2Um9Qm0yoZcjnun7pcBGtlKKivz6ecZvAjUVfhMX6/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754491495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9dKSnmyZhBtsAHpcDfwkp4+zP/Y5X/HnAHpBN0o8UN4=;
	b=lASAwrt6n8amrUQUmEoeShj8JgZ2xMaBO+EriCZrbtsqgS+AkjEQPlEGR8itBoqhSxEygY
	Z5pRdhqRdttGdDAA==
To: Eddie James <eajames@linux.ibm.com>, Ryan Chen
 <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, "linux-aspeed@lists.ozlabs.org"
 <linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 SCU
 interrupt controllers
In-Reply-To: <5c46082a-c31b-4d12-a1d6-f315c8ce7aaa@linux.ibm.com>
References: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
 <20250804053445.1482749-3-ryan_chen@aspeedtech.com>
 <20250805153908.GA1807801-robh@kernel.org>
 <OS8PR06MB75414ECA0290018D5D113B62F22DA@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <5c46082a-c31b-4d12-a1d6-f315c8ce7aaa@linux.ibm.com>
Date: Wed, 06 Aug 2025 16:44:54 +0200
Message-ID: <8734a4ecgp.ffs@tglx>
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

On Wed, Aug 06 2025 at 08:41, Eddie James wrote:
> On 8/6/25 2:14 AM, Ryan Chen wrote:
>
> How much is common with 2500/2600? I wonder if it would be easier to 
> just create a new driver only for AST2700, instead of all in the same 
> file/driver?

There is enough consolidation potential to keep them in the same file.

