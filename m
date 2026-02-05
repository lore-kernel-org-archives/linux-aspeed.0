Return-Path: <linux-aspeed+bounces-3484-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A297DE91294
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Feb 2026 08:53:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f69xC735mz2xrk;
	Thu, 05 Feb 2026 19:53:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770281615;
	cv=none; b=XnOtPiMIkQVEBxBJNOHZBpeflwlBor4SUKVtde696nxTjXSiknC8rzEkz0bCCZtGZJ1MPzJUD5IQuiAJ5GJ/n8s4oRfjOry//H3ZaikjLcCKhGYnVluu2iyS/841FrWzTxi3YxaFRXo7NJUdlZFfJ3urv2lP86mpHIbO3bzEdoUQmL+DMrfyoGyL6azCVPlvTnGKcEo82DD2QJNCyowCL7pE8F/yITCB2fVHuQv9PZxm7q0ZwgvhFuiPJd7s10qmvRcuBMk8t7zxoGSF+MMwLy1Z96/tlP9XZfuex7GmgwI4Wxq+ghWrhmecD4XT+Ap+NRSvYTQPw8NpwP1DB8UmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770281615; c=relaxed/relaxed;
	bh=hGfoS2SrOUSUcNbo4lzcjQ1KpCcVybs+F31qmzUiqIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsTBZ42kwz5Wz1G2EYsqyNawGgSDcig9LwnuvnLJP++V+CCE15JlrgK2LRE8BwLLzbSym3nEbwgz/IGHFOpSfZH+LoZM9W1k9Jb/i5zm0hR9sSZnYSo6ntUpQIYQxZhXE2vGpOmMGlQ/gIzV2r1D0EUripbLspBtI58OyhOElE1/ZGj+JpLVrivNnNC1APY9ndH2zw7q9/rz2W6gR7tKxtmvmRvCVDeHcjgl57pM6E4YN3KRQ0fZaSOdjY54+Bm1XgqrZ5e77cs8IV8je1BJuE2y8LzBDy3sNMGElbElO/chBofDjsGY2/x6jVinPp0qwgobo4lu0amr7u2gh+J6MA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ph8JSWSr; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ph8JSWSr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f69xC2bHfz2xg9
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Feb 2026 19:53:35 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BAD8743F57;
	Thu,  5 Feb 2026 08:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF4EC4CEF7;
	Thu,  5 Feb 2026 08:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770281612;
	bh=hGfoS2SrOUSUcNbo4lzcjQ1KpCcVybs+F31qmzUiqIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ph8JSWSrJDO/nNl/EDjq1HLoqZ7oqDk9ZkC8ZHgNJIoJYcGndSMn7dt+ixyyNs/NN
	 soxAKOh22cP02z6s2AiMyvZ1HbQWiajQRn61b20N8nZyffm45mcUB/DlaIr+me8aHW
	 N9+MwiMvy8w+Y6xebb5w93SOs6lMxfHP6pc9kbFdUJdOv81Rd2NcBfWIe6fmslQ/dK
	 ET4UPmOBMUrDRiwQ6kH0bSwxwmeLauLWbHrdYUMm+FCBnvB6MfqXaabQBmV8nKEerO
	 WblDJBfsDaJNAt1kqJP7j4vl8zUnVcnH7CF2+9aUpyJ3wVj/jN5QRZJ5o+xO4Rvx9I
	 NiWLf248P3bGQ==
Date: Thu, 5 Feb 2026 09:53:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/4] dt-bindings: interrupt-controller: aspeed: Add
 ASPEED AST2700 INTC0/INTC1
Message-ID: <20260205-hysterical-crouching-beetle-e0d1b5@quoll>
References: <20260205-irqchip-v1-0-b0310e06c087@aspeedtech.com>
 <20260205-irqchip-v1-1-b0310e06c087@aspeedtech.com>
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
In-Reply-To: <20260205-irqchip-v1-1-b0310e06c087@aspeedtech.com>

On Thu, Feb 05, 2026 at 02:07:19PM +0800, Ryan Chen wrote:
> INTC0 is used to assert GIC if interrupt in INTC1 asserted.
> INTC1 is used to assert INTC0 if interrupt of modules asserted.

What happened with 20 revisions of previous discussions?

Did you just ignore entire feedback?

Best regards,
Krzysztof


