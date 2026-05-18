Return-Path: <linux-aspeed+bounces-4071-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427C8CD4F50
	for <linux-aspeed@archiver.kernel.org>; Mon, 18 May 2026 13:21:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gJz3G64Ggz2xpn;
	Mon, 18 May 2026 23:21:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779110490;
	cv=none; b=Quyj+sOe62bjo6C80RXhzUxdFPRSNNe3FDItyAoXA9a7tTXWnTZnpr/3/V4p+yYl8iZCsk+yAS82+V1uD0ddCH9BLI9E1pKzbuoRib7MkRUaav2EaM4h75LiymKFbxwekAuVftLBGXOu4CE9FbHvvy9olK/BX0s+musYIBlxKhW7o6Yr3UHZjoBkUjYuB0FnjyqGdMtz2GJWitRYE0NGPsR2ZkRyuwSD3i7ryD+vzRCQ8E6EP/TbTzIVRGjrPOohWkfgVn5f0GrgSp2WNXEV1OzQMW5DSmJtMjY9Z2GQII7Ng0Yetz4rmrN5Fh5wnkdp1O56U1pZ6Zjk2/Eztgx3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779110490; c=relaxed/relaxed;
	bh=JXZoMwG6Tq2zUsTH+zIYCTcolUhrlhhkb8dDKfwVMps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XTGjyAIykr9zDfTDxphMMMHDN/R4EiXZHj4BWrKt0ZL7UMbrBI3iA3CnSLtL7Uey3KSlYAzTFazcp85fDXMM72r9dTGxQmHTdu26pHX988sWj4mblaXIIb3YW9T4FNiRtHNZfSIfX2NHvryzUT1vZ6YAJX4/xYuBWdsge60eaj5JN8qnaLCV/Xt1DGFK1QzclI5qzMz4aUg6dA5Jeelf2ozuS8YZtP0DCcsBKpqR01xVogGMPUFfgnpOuT/xl14Dw7ay2ORUC2fFINmuJMNKKXumCs6nEUNpNR5cXcwoGVRw/r64786FVTlZU0CLHLU0kEs2kLTb38m5taX6jhXjnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=hDEFirza; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=hDEFirza;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gJz3F5bddz2xRw
	for <linux-aspeed@lists.ozlabs.org>; Mon, 18 May 2026 23:21:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1779110489;
	bh=JXZoMwG6Tq2zUsTH+zIYCTcolUhrlhhkb8dDKfwVMps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=hDEFirza8m1RgJJ4fITtD4O7v1mJn+kDX0+ykhsSsA8bV4Q2G+obJXnrUaVCKq8AE
	 nIVrZnfWz2AZmAfI4Z96nKjDqyQmwbfoms/EgqD56fjJSyFdbZL4vUIEgO3HVqORhS
	 S5GwBwtIuYOliiIxO4z8nqzImblYdw51yKu8HjMtPSX3+JCoSSD4MQ9wofcqDVnnU7
	 yyApWLNJTlifGccheD6149zegNNnlEe2kIQyDU0u3h3Y3/9fchxnT6zCKgsJj9FYEY
	 9TtpgH2P4ETam1xkCp/96FtEDQEpLI0/WftJEZ1KaanxqnKc35u/Uo31/HFT8n8GKx
	 txrAj+nJwh9Sw==
Received: from [127.0.1.1] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A52726025D;
	Mon, 18 May 2026 21:21:28 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Billy Tsai <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260326-g6-dtsi-v1-1-348e7a0661c2@aspeedtech.com>
References: <20260326-g6-dtsi-v1-1-348e7a0661c2@aspeedtech.com>
Subject: Re: [PATCH] ARM: dts: aspeed: g6: Add PWM/Tach controller node
Message-Id: <177911048854.1942419.17635653553206157832.b4-ty@b4>
Date: Mon, 18 May 2026 22:51:28 +0930
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Thu, 26 Mar 2026 18:29:22 +0800, Billy Tsai wrote:
> Introduce a device tree node for the AST2600 PWM/Tach controller.
> Describe register range, clock, reset, and cell configuration.
> Set status to "disabled" by default.
> 
> Prepares for enabling PWM and tachometer support on platforms
> utilizing this SoC.
> 
> [...]

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


