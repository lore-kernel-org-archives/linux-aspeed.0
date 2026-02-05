Return-Path: <linux-aspeed+bounces-3488-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF6CEC1E89
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Feb 2026 09:57:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6CLY2Tfbz2xrk;
	Thu, 05 Feb 2026 20:57:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770285429;
	cv=none; b=U2C2/9ime9YbZVgazAPxOXnxIhzqNbI0mjpv/u7UmEcU2kYj8pJLLQvYNStfh6TUDEIPJybPts+Ev3/qZL2xK6wfsEtAFmyAlvHOFkO7NMAVyzSKJ+Yp0q3NJ8SriYN9nC1Yiv75ZcxvTbocxu4+oLlJTJoPINLtwcvF1wMzegKB7lRH1T5NdVuR+lTTWL7Kn7uqdzUG11BMjSHIfC34iEhOSPxZsc475NfuSyBI3cGNk/h7NX8YG5Lo+MffF4mq3y416gBQ0kOnnoVGCYRzPHzqNLJ6nyp18YSBOjbCsB6aivfVpiqsepgYOZGa6KBMuoF6i0GQqejK1rHNaNw8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770285429; c=relaxed/relaxed;
	bh=mRiywo/vL9r/7Hrha4JxGH2fWmR3loo/Oz5ikqSntHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qfxrj5OekeFdixjti2lU8WHkwEUuRQz8htikh5IUO1SZ64g+xwwBkN2AWmxZwVKffHwUS7VFbGw+P6JmksykQlqYlE6BGm36IkCROT7oMp2vxlAGrjQ0HhOVyEqM1NxKLQUZz0Kp52xgEjF57T234wdBtnXrzaeyf4GBUH16LUtSDyP1MkOYbDqdY1QYlUDeNCkSxjWURrUnGWkbg3cvAcOw+IvbHLect106kF6O4gHkSwEmOEnYqkCK0jXZzJuWaFJ6H8jOJPwPFt37dZeNHlYOh3V/bSDXU0gBgIAhpcdGtkwVPqwNTXaDfYBy05XmwkCLUBdfkiknLraCo32ydA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SCI9GAgV; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=SCI9GAgV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6CLX19Ybz2xg9
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Feb 2026 20:57:08 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4022C600AD;
	Thu,  5 Feb 2026 09:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92D4C4CEF7;
	Thu,  5 Feb 2026 09:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770285425;
	bh=ydsz5YAsH2V92PFtoZdy7hnlsysJyjQLfGvGLyXdUAc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SCI9GAgVmHGbiebgjq18AmfgxuOoIypKP6uWLLuphuQIl9p6PtuewVRXrDpgZvhi0
	 hZMkwA0UDOtLGl5dXkMtVoAfWpcp6sYACf6PTetKQHMVMfq9giOaG6k6wz/7nqXVwn
	 BVzWiVy5V5IKRkHHzYOzw17g31u3u1BwMZttKSC9UnfH8CmxLV4AGwLHDrNKcEkuL3
	 QiOrqCv89MJhNoMJdqYcrs7BvTXTdewfmSM6zQxPeD7HBhyYQI0MNwS6ND2jZXLY/2
	 F5GViMYY7FfPj7wvArhxNUV4LWRZ7D1fd1BaLJF/CTMU1sCx2OLkUPycIFPxpugszF
	 vc993aIo0WTTA==
Message-ID: <d5e45c9f-f3c7-4289-8991-02bd2c5b9587@kernel.org>
Date: Thu, 5 Feb 2026 10:56:59 +0100
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
Subject: Re: [PATCH 0/4] Add AST2700 INTC0/INTC1 support
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
 <20260205-intrepid-vengeful-deer-14e2eb@quoll>
 <TY2PPF5CB9A1BE69B07F90DFB245FAB735DF299A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <TY2PPF5CB9A1BE69B07F90DFB245FAB735DF299A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/02/2026 10:49, Ryan Chen wrote:
> 
>> Subject: Re: [PATCH 0/4] Add AST2700 INTC0/INTC1 support
>>
>> On Thu, Feb 05, 2026 at 02:07:18PM +0800, Ryan Chen wrote:
>>> This series replaces the existing AST2700 interrupt controller binding
>>> and driver. The original implementation was focused on a narrow,
>>> PSP-centric view and could not fully describe the complexity of the
>>> AST2700 interrupt fabric:
>>>
>>> * It was focused primarily on the perspective of the Primary Service
>>>   Processor (PSP).
>>> * It could not handle interrupt route configuration.
>>> * It could not handle interrupt register protection.
>>>
>>> By contrast, the new bindings and drivers describe the interrupt
>>> controllers at the block-function level and provide a unified binding
>>> design that can be used from the perspective of any of the four
>>> integrated processors (the Primary, Secondary and Tertiary Service
>>> Processors, and the Boot MCU):
>>
>> Where and how did you address last feedback given to you here:
>>
>> https://lore.kernel.org/all/20250814-auspicious-thundering-jaybird-b76f4f@ku
>> oka/
>>
>> "This binding is not improving. You are not responding to REAL problems
>> described to you. What's more, you send it in a way making our life difficult,
>> look:"
>>
>> So how did you make our life easier now?
>>
> Hi Krzysztof,
> 
> Thanks for your feedback.
> 
> The series you commented on in Aug 2025 (v4 1/2) attempted to model
> The hardware by introducing parent compatibles (aspeed,ast2700-intc0 /
> aspeed,ast2700-intc1) with child "interrupt-controller@" nodes using
> aspeed,ast2700-intc-ic. In hindsight, that approach did not align well
> with the actual hardware structure and resulted in inconsistencies
> between the diagrams, the schema, and the register layout (including
> unit-address issues). It was also difficult to review in isolation.

Read my question again:

"So how did you make our life easier now?"

And then read the earlier comment - what I expected of you. Please
answer these after the "look:" part.

Answer these please. I am not going to review any of these because you
keep ignoring our process of handling patches and not really responding
to review comments.

Best regards,
Krzysztof

