Return-Path: <linux-aspeed+bounces-346-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3C9E77197
	for <linux-aspeed@archiver.kernel.org>; Wed,  8 Jan 2025 00:29:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YSTMJ5Cmgz305P;
	Wed,  8 Jan 2025 11:29:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736296188;
	cv=none; b=TluDZfqDOHl2uDg0m9a/2egJqtTI6OSRIHYJz2gjreQPIq92oonCaEtkclvhw5rmRvxc/O0GvkDNZ1DwHJCWZVTi0SyD/I98oTCV5vNtkUfRCw10IDs9PDglYBKJwpoaDX0D1wqsnK5tXml0YUR6rzsHQ+atAjaftINYBcqWnh/BZ86EbAfajWSnSj26QCsTsNL1zDspjPUg/DG1ApQi1QB9K0OWjVNSexERI19huv7h1if0A+UNG5+c48xx0RTqDaZ6vMXJZxIkvQLWBQpG63gU1clRGlmyTslFs1VqS8FcO9QRM4/4yuPPsnnUNm85QADGNkLbvOqHgCSZ+V2gqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736296188; c=relaxed/relaxed;
	bh=ngFxpbsAhBt46D4upIiQUrqXmQXQRu9BcTtfx/SuZrQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HDn2Z/epCdIsOxKa4YZtfDv8T8618Ha+LS7ag/wum0iheXj1wmDa3kFGjVLvIjHeBIz0lLoH39jEwu1UzFYiI+Crb393hPHGertEiAlkunyZIDoM2A6y9K3oG9eFrclHTvKhR3qRkVO7SVk+c1DoWTz8jNQTu5EG6M7TNz/CTcUL4F8t3OHDJ+rdzSg6qMkUztiyv8IbeyvT2U3LdytwHjFohkuLNMYVk65wuvmmKE7s5bboBJrM/uhaKSeDXbLntjN1ME1KSOjcTWoIoO8i+q0TddjCR7hhu2R7nxCryPQWpgrQqFY9qDSIa58FB9pEZdty6N9uBjQ6g5+rDrQTWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=cS5aGQNn; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=cS5aGQNn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YSTMH0K6Qz3055
	for <linux-aspeed@lists.ozlabs.org>; Wed,  8 Jan 2025 11:29:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1736296182;
	bh=ngFxpbsAhBt46D4upIiQUrqXmQXQRu9BcTtfx/SuZrQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=cS5aGQNnH8pG8T95/gV34zVLaRqjpN019oKppskkOEPws+2cBRPC2LsXVWHWQbQK9
	 2gswAEXTbEB2AweMzsHU2tfCGYYW7CZldvBxXOrunMD01odqogdtEmCo38bl9wDFju
	 zYmvmmtlXjeY7dL7M/D0aO4deRxw8cxHj8JpZYWpzOc/xJ8KY1tAHRJgb02yrTtDna
	 5p/J8Pp68UkUdV/Yv7tCBYc6le/IVT23pFr6Xt5PQy1rvbInQX3Gj5eEAhX62riQfV
	 dUGGBqeX3a/7M2SOJs5mBn9+EsYVuOrE9vpdkcDOfOKGUZI3iPWsQKzRjq6k89dO3H
	 sBHimNEPs1ChQ==
Received: from [127.0.1.1] (ppp118-210-64-24.adl-adc-lon-bras32.tpg.internode.on.net [118.210.64.24])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E49F670B92;
	Wed,  8 Jan 2025 08:29:40 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250107162726.232402-1-patrick@stwcx.xyz>
References: <20250107162726.232402-1-patrick@stwcx.xyz>
Subject: Re: [PATCH v1 REBASE] ARM: dts: aspeed: yosemite4: adjust
 secondary flash name
Message-Id: <173629618084.481094.9284702547524010515.b4-ty@codeconstruct.com.au>
Date: Wed, 08 Jan 2025 10:59:40 +1030
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 07 Jan 2025 11:27:25 -0500, Patrick Williams wrote:
> Meta (Facebook) has a preference for all of our secondary flash
> chips to be labelled "alt-bmc" for consistency of userspace tools
> deal with updates.  Bletchley, Harma, Minerva, and Catalina all
> follow this convention but for some reason Yosemite4 is different.
> 
> Adjust the label in the dts to match the other platforms.
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


