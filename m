Return-Path: <linux-aspeed+bounces-3728-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D19109318B
	for <linux-aspeed@archiver.kernel.org>; Fri, 20 Mar 2026 08:37:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcbYG4zk4z2yYY;
	Fri, 20 Mar 2026 19:37:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773995103;
	cv=none; b=IJ0YIaeaEsx9nL8QbV+G8KXfm0NDUwteYLIEY0/HmOZmvrwxTcIitKCUhnggmWxq8Kb3RvoO8neYj/xgupKS+S+5Ggdh8pmtbOgZ1CxPu4dexZiRDfR1HJ/I08lET/ksAWrePOhlAgBedvleINvLvXOeR/I5kwJRI5KU7zWzVG0HFGle9Q9nzlH14aU6WchaA27cc9JkKbnIwAAgSVT59Fnh3CGmQneyF1/5CvxZSCvUYrPvHMX0p8MXMXPjvqylOKFHvCKvb2ZzCjy5dx0IwDXKCNlC1JFBUsOR72imKf9QKH+L6jJCO/GH1Oj201qVYKocVAxfHNhvlzM4ePZIVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773995103; c=relaxed/relaxed;
	bh=te7Xho+l2M4XyF2VhG3APGIPAEOtC9hgA22fVNJ7X3E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aGzVHwVfIMri/ZMS1WGXs2XYbnC90HVk4OciWZS/JeKWAnB3fCzeu/welHMlmeFQXCV9MpJ2PzjjHgu4QPuZLHbq2J9bTXe51JBUlPGXqn3iGAYAIU9wQBpxTl2x5NQ6BZ+aPVltXDKT443Vn0yCQTP2Xt2YfJDYrO5Sj0FKAPvIR/UVguhnjyND7dMynadh04nABOicLKwlIHPsD5mcqFkz0/QbUN24/g10/AUk5JP5RyDO7ofFE5AvGE9npz0Dy8e5GmG/hOKvTYwkg9DVJbrHrwvMTK/8N5gMYbb07Q4Gor/wKjyeWeGjTojh88doJjzyn08Cf4K3JuKqcsY+0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CzS5eoM0; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=CzS5eoM0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcbGR14Zlz2yY9
	for <linux-aspeed@lists.ozlabs.org>; Fri, 20 Mar 2026 19:25:02 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 80C284456C;
	Fri, 20 Mar 2026 08:24:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FE54C2BC87;
	Fri, 20 Mar 2026 08:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773995099;
	bh=5sQNvmWQfpu+8Hr47TI2X8prZ8bvsa2R1XHx8VD2x8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CzS5eoM0f2loHEf3GLYkghCyVQ2yYnMGqfDIRbO7GCqBNLBsQ20/Qo2IFO//yQjkP
	 L96R3cHLc0svMwur92gnB0/OMaBzF3mSeJdJp4zo5wqxfI9egzkjCXOs6lPnRexoGt
	 CGNUxpBADXLcD31k7tJNxqHxKv76QzAl1ebIPfaFSTVTR8e5ENh5uztgarug6VMKVa
	 IEKKMDfDDTO8UfULyEPLHWQeRnQHBVMBPq8NFPRGq+JeRhykAGDLox6sCMXO+BMHoP
	 sFgUAoEfG2zm6WrxHo8hYJFF4zEdDKxD3/6xhLEoUw06ZsXSpCkKd8Snq6ZXvqw/K1
	 BRzE7vr5n8D4A==
From: Thomas Gleixner <tglx@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, Ryan Chen <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: interrupt-controller: aspeed: Add
 AST2700-A2 support
In-Reply-To: <20260306-irqchip-v2-1-f8512c09be63@aspeedtech.com>
References: <20260306-irqchip-v2-0-f8512c09be63@aspeedtech.com>
 <20260306-irqchip-v2-1-f8512c09be63@aspeedtech.com>
Date: Fri, 20 Mar 2026 09:24:55 +0100
Message-ID: <87tsualxgo.ffs@tglx>
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

On Fri, Mar 06 2026 at 16:07, Ryan Chen wrote:

> Introduce a new binding describing the AST2700 interrupt controller
> architecture implemented in the A2 production silicon.
>
> The AST2700 SoC has undergone multiple silicon revisions (A0, A1, A2)
> prior to mass production. The interrupt architecture was substantially
> reworked after the A0 revision for A1, and the A1 design is retained
> unchanged in the A2 production silicon.
>
> The existing AST2700 interrupt controller binding was written against
> the pre-production A0 design. That binding does not accurately describe
> the interrupt hierarchy and routing model present in A1/A2, where
> interrupts can be routed to multiple processor-local interrupt
> controllers (Primary Service Processor (PSP) GIC, Secondary Service
> Processor (SSP)/Tertiary Service Processor (TSP) NVICs, and BootMCU
> APLIC) depending on the execution context.
>
> Hardware connectivity between interrupt controllers is expressed using
> the aspeed,interrupt-ranges property.

Gentle reminder. Can the DT folks please have a look at this so we can
make progress here?

Thanks,

        tglx


