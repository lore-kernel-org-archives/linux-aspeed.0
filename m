Return-Path: <linux-aspeed+bounces-3485-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D3CE91297
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Feb 2026 08:56:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f6B0y2TSbz2xrk;
	Thu, 05 Feb 2026 19:56:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770281810;
	cv=none; b=ePG8ggdx6h6oCddclWRZagiZh8GweIIya9TgWbiTe99E0ppbCtHlTimSGWlCJ+ywjmH5yZHpO4bWwwUCw468718hHDbsyPOAJ7JfFHwKLc8R4UAYVP2Q9e0njMM6s51qNB927zCJBUtCc1XhTjLVW97v+UbIe5IrOaxT4cMXS79fsbrR6Lpxwjl6L4eQk5Wtf+pk2SGryrfedUWgXYXBRx7nZH5hfGPTPEbSC4pAdrf3jzgDOMnIyUl1ISHBlaJhAlI9Ky4C97SOFtxNSTTo9j4jGL5sKekBZkZdWY893L6mOQIJP73l7e6G36Gyxp357LzHcQhxz4KbepV7X+a8CA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770281810; c=relaxed/relaxed;
	bh=Xh6wHExqeA5n6IMsD3EGtDkJKvRvUzSg32v/BWdv0gE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3TtxvBlF2MoF0MVl/1KjkGTkAKRstBTC74BjI4Bud/axgqZwek8JTTvnZMJOSH53/6TMiybcddc85npGLCaZVbQUPHmUXSWr8Sia2HuqC9P7YX9fUlwCWqI9P1Png9TFrRngPa20Xx+YXBCnwN+e8VdM6UoEP3eImrxSdZLW/HqU7Lzm8wkZ+JoaXwm9UdKKrZ0YHDdbDulCqymbOxV7xdgm2z/j4BmT9BEUms2+DVVoIev4rIl8LZLG0PbBGe7E7Vl9ngPDgEOG8RNDH5i/zJV78J3gYeoEr+5MTIe+Z9QCYM681IUff2zx21nxgfg+xiYeIeBudkGf/RD1blC4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VEqnGVOA; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=VEqnGVOA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f6B0x4dpGz2xg9
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Feb 2026 19:56:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 01B164354B;
	Thu,  5 Feb 2026 08:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1D4C4CEF7;
	Thu,  5 Feb 2026 08:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770281807;
	bh=EpeKVSUECcB0qRTU/0YGWj2Tn1oofcM/dtc2qrBjOCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VEqnGVOAoESTGAH1kB0Oty8u2WWao6axm3BidFtcpHznfrpYXSrc/a7v55Q6z+DGh
	 iOcCxtSKu6pINMwf9h3nbdFgopXZWj2ZtBocy+n/FP3+gEbCio2NJuZPKA4H4L42Qj
	 wcLsE38wpK1r1L1QRNrkPvyVM0/8ZTpqcfmVeLnMSZ8hAs9iI8ILQe+gJ8ugHtX3ZV
	 k6UKX/HQ7GcLOlYspbbkhddXgkOtnY3dglQ1jZtlFDbbOF9/yk+8tDOvwkWIgLUwdh
	 WDQg1xdSnzDg0kIHnBJdRRlIngHV33u6pFR44VxvoSp7Kdy3aJjFf/3Z6QE6XposNS
	 S5GOd9t+tLwkw==
Date: Thu, 5 Feb 2026 09:56:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 4/4] dt-bindings: interrupt-controller: aspeed: Remove
 legacy AST2700 interrupt binding
Message-ID: <20260205-neat-honored-monkey-74d37a@quoll>
References: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
 <20260205-irqchip-v1-4-b0310e06c087@aspeedtech.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260205-irqchip-v1-4-b0310e06c087@aspeedtech.com>

On Thu, Feb 05, 2026 at 02:07:22PM +0800, Ryan Chen wrote:
> Remove the legacy AST2700 interrupt controller Devicetree binding.
> 
> The legacy binding was limited to a PSP-centric view of the interrupt
> architecture and cannot describe interrupt routing and protection for
> the full AST2700 system.
> 
> It is superseded by the new ASPEED AST2700 INTC0/INTC1 binding, which
> describes the interrupt controllers at the block-function level.

You just added all this ~year ago. I also do not understand how multiple
previous revisions of patchset [1] were just ignored. No versioning, no
references.

This is either unprofessional or just wasting our time.

[1] https://lore.kernel.org/all/20251030060155.2342604-1-ryan_chen@aspeedtech.com/

Best regards,
Krzysztof


