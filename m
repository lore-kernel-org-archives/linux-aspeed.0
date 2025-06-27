Return-Path: <linux-aspeed+bounces-1581-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB10C7EE32
	for <linux-aspeed@archiver.kernel.org>; Fri, 27 Jun 2025 00:59:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bSxzK3T7Nz2xJ1;
	Fri, 27 Jun 2025 10:59:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750985981;
	cv=none; b=URZ3LPkjVjCbqokVY++OGZFiTPfKvkFISVhnerof+yPnIvqhXErw5Us1DYc0PJqcSD0cTrmZAW9ZcscnWFw/bEVdL8uYJmXRUY06j+vpL51lzt9cOR3tAw/wH0u2+C8yvdp+CyDXu2pqhtSzQ9NBKk+Nlk1iWQWdcW8LmmusWsBLODRbZk+VWypOrvb2yGNJKAe+/9LG06P7bbjWe8RkFCKt1zgMmefgMV1fc2RBXlEpgU5xALg0okLewWeazMDoG2vl6G8z6h3IiGWLMaLmW0HQiY+7jUTjByCzhDGQI/73HGYLst0f+ti7JYl30PGusSHeo2xY1k5qTFqCHoPr9w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750985981; c=relaxed/relaxed;
	bh=fbp9P2iizIVjHAFvaoJljb4kc256KKZrn7l4KhzZ0qY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DlQhp0ZF7kQuiq51v41LLfeUkxMVlaJzKNR91XtMegr1QNJUZjz+ugiKD8pQcaxE9b5qdc4RHmTuJa7+2asX4KHIw0MRkfjeF8EzO40h+qMG/pnFAU3hxYy4bL5GWgEkWNjn6RGseSdXbp0TdNO+GajLDhuBMQb0puCTQQJtV93osTPUwbw5X6iTqfoNYLDVsp4x6iO/VLFtNoayZFH65O89hFHCsMda6FGAoZY4E4bnoH7+VXKqemGvk2wR7Kea6+AdpUM9PmnpPZ5uu+Cr8VZqAp9lmREPvkaCSTOshFxMRfgCkOeFGfAx9c72Z617NvyhPwfnw517z8586lACLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=EVFoYbCp; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=EVFoYbCp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bSxzJ3CkYz2xCW
	for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Jun 2025 10:59:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750985978;
	bh=fbp9P2iizIVjHAFvaoJljb4kc256KKZrn7l4KhzZ0qY=;
	h=From:To:In-Reply-To:References:Subject:Date;
	b=EVFoYbCp9fUe9+bqYh1IGMMzlewoor+XFV/4eQA6KKsztO/mqFNQDq8Vm72regOfr
	 uz4gHpPrVQtZjJr6k+folNRmesr5AKosxwNRoY5qntWS/MLwL+JZeFjt57Q2+vyrhi
	 mdnf6Hw7GpZIdCiIosvO9KvWU6UWU2NsisqlUaSVyxrwxAXpKY5dVT2wD4EiUt0+rS
	 rXsemOn5pvFTp4iWWuz/AjSKkwDilBgR7a+n2t/qUx2YFNdct+vAd3dntB1wA2ht4f
	 9KBaQEwd3LN3HabjO/PvH+ewItNIQgXybrXUtzdD0EzZCnoMQqX4PyfB28FNYlcykV
	 645UbApT9U8qw==
Received: from [127.0.1.1] (unknown [180.150.112.166])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3CCEB6443C;
	Fri, 27 Jun 2025 08:59:37 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Fred Chen <fredchen.openbmc@gmail.com>
In-Reply-To: <20250625073847.4054971-1-fredchen.openbmc@gmail.com>
References: <20250625073847.4054971-1-fredchen.openbmc@gmail.com>
Subject: Re: [PATCH v2 0/2] Add Meta (Facebook) Santabarbara BMC (AST2600)
Message-Id: <175098597713.150233.11475739280254945170.b4-ty@codeconstruct.com.au>
Date: Fri, 27 Jun 2025 10:29:37 +0930
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
X-Mailer: b4 0.14.2

On Wed, 25 Jun 2025 15:38:36 +0800, Fred Chen wrote:
> Summary:
> Add linux device tree entry related to Meta (Facebook) Santabarbara
> specific devices connected to BMC (AST2600) SoC.
> 
> Change log
> v1 -> v2:
>   - Enable mac3 node
>   - Add GPIO line-name FM_MUX1_SEL_R
>   - Remove 'pinctrl-names' from gpio0 node
>   - Reorder top-level nodes alphabetically
>   - Reorder device node properties per style
> v1:
>   - Create santabarbara dts file.
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


