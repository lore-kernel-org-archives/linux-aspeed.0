Return-Path: <linux-aspeed+bounces-2715-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E111FCCFA03
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Nov 2025 08:18:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0PbW0rNRz2xQ2;
	Mon,  3 Nov 2025 19:17:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762157879;
	cv=none; b=kVGXIpiDgEFsHYNUB2UaPCyR1rve/8UYUUt/E4jpzD1GLXgZvfdwEbkHG51U7i2X/tzx2kLB8pIptLtvH5x/9kyb75/Z5bPB0cI6lC0R+Wtyt2tvsz/MqG+2r9rbPP5wwJ2BYH8lLxIn57rX+ZETVUahq1JueB3fC1ffJ3T7MpTC/1SnkBY0wdezzNA3eOJ+FMd4aM4nFaQlpr0RiuCkIo3HdWBJYEad8BpOGMSEd5RmxWIMQF9t1gdjt3cM2nhQuXsIeJuMVbul7oVbyhJ37ToM6m/aRdbWUHHUZZIR2n0uUyodSGbc3BiWhbnb416rvL59zO1a0Jl0sOfSEzhJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762157879; c=relaxed/relaxed;
	bh=+El+MDXdmfsNSaC/SCdwjn4AbXykYyugBqpJMifOazM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBxejap4PgFcfA4w/auGpNYTvwQh6byrD0p94u4rJFV2I/KhOGI0mo1zWMLvbGlvz+6Khth+R1EoHbNp1OKq1bJ1whJa4xojts31qqnSMZc2lzyHIMSCkrsZqs/9mQtwZbfqe/qCL2xPM8NvvVX7Toom0nt8TXaUYP8LUIGwrmO+Rw/1V6Far8Yeql/WbU/Ws1D8+B7Qi9aPDvBP4IcZ+4lSNnNGkZFB3xadX38x+S+ZAn/Us4c7Y0bq4rfslI3h4LZYQ8utcnB3luLLICCNrCqKGxaW9GWq1KZpdsTxnV3DxyrWPKBTwNPD06mmsHxBdfjqrwknZYKmXOaYnSg88A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hPgHPj60; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hPgHPj60;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0PbT5Fjxz2xPS
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Nov 2025 19:17:57 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2BB3760053;
	Mon,  3 Nov 2025 08:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDA0C4CEE7;
	Mon,  3 Nov 2025 08:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762157874;
	bh=e4eP8kIUbnxFkpE508lw7JjVKEVh23zzNZi3k04+VEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hPgHPj60n+mdv62mBOJGsVRWqHQ01Gjr7rTSTRIbj0hEjbXQsio7zNnampwXmqVfr
	 Sa91lh+8Xq11c2+0Eob2Mol7XBSQJj7zWPNQ5V/g6F1JDR4dqvCiIP9HT2K+AkNAcL
	 Getpo0YGj7SaTIBeEQrO9vLl8D1dpFVaLA9BHQJwYUBay5ujiO3DOp4ST9WOasWYrR
	 iEe9bbG/vX18ImVYbICTXGNw3rJ2W9y7N7ru3GyHbfFCGaO8tCGT+29JaOtPbGXYKS
	 2Tw6/LfHfQ+08W0UHnbz56r9V02UmWfUDrvk7LicyK7GpLoz5kyMept3/H2CWlbjR9
	 BFmCJrOBptHrg==
Date: Mon, 3 Nov 2025 09:17:52 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	jk@codeconstruct.com.au, Kevin Chen <kevin_chen@aspeedtech.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH v6 1/1] dt-bindings: interrupt-controller:
 aspeed,ast2700: correct #interrupt-cells and interrupts count
Message-ID: <20251103-economic-lime-chupacabra-d7adec@kuoka>
References: <20251030060155.2342604-1-ryan_chen@aspeedtech.com>
 <20251030060155.2342604-2-ryan_chen@aspeedtech.com>
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
In-Reply-To: <20251030060155.2342604-2-ryan_chen@aspeedtech.com>

On Thu, Oct 30, 2025 at 02:01:55PM +0800, Ryan Chen wrote:
> Update the AST2700 interrupt controller binding to match the actual
> hardware and the irq-aspeed-intc driver behavior.
> 
> - Interrupts:
>   First-level INTC banks request multiple interrupt lines to the root
>   GIC, with a maximum of 10 per bank. Second-level INTC banks request
>   only one interrupt line to their parent INTC-IC. Therefore, set the
>   interrupts property to allow a minimum of 1 and a maximum of 10
>   entries.
> 
> - #interrupt-cells:
>   Set '#interrupt-cells' to <1> since the irq-aspeed-intc.c driver does
>   not support specifying a trigger type; only the interrupt index is used.
> 
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
>  .../interrupt-controller/aspeed,ast2700-intc.yaml   | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


