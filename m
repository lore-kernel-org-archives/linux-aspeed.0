Return-Path: <linux-aspeed+bounces-2240-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58C2CAC598
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Sep 2025 01:00:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRL6H2k5Dz30PF;
	Wed, 17 Sep 2025 11:00:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758070823;
	cv=none; b=JnJ4CbcUxqxPI/mZbncrVZ7MxGhZpRyIXMr+Vg0X7/rTOh2shqSGIgIVpfeOPOYncAma9nZfnsVXzlQT7wh0hoBIWFEWfS+tEJoA2DRk69AiN67MY6cDCUQ9G3B7V6zw9JsqQGgOIA33R38Wm1MGQJg+FseKDIKmCySTuWBs5mTuCkkaThfO6y1L9djeqboDdWuRLnRWPQiWE/JgKY9IIEXh2trBy0rj4h7Crgti8IP+X5jemcx8pT1VVHWU1xUMbFYZC9vYCRsCYxXn5Vqsk12uBDWti2JaFJTodZ8eiK4ZuEN/UxC42g4CBkfPvC0HHuBAl1SDl6AL/kHoFxjhjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758070823; c=relaxed/relaxed;
	bh=kPcYVN/bdj4IAsOc2wtOoTywOlIcugnZO98J5M8IzPg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FIHHPZmEmtsmHvQlUvaMRDcFDikRP/ONSJdyzWFhPyPc0YSeOh7R3RETN3orr7oKHICjWN2pi+9VLnXqhem0X08+Sjx+a4wTR1LaTZ5lAfR6jGJmklxGvknLUVqTa9fxzIZzNv/ICqcq7/Kdy4quu4Oa1vWLZJ1e5NDzBfQHdw8GEnB76ihVxE9DkiMFclqONR2mt2hVepgw3T0tcZ59GV34uPUs2pDYBy89ei+kp1FBM8j9TX7SR0nKae9HSdBGszb1FwKwOwyTizVQtlXyZmVdopNfS/LgPB2/GUTEKMhdMDAYNvceuFCEEXzhrovJCbLTTHA2coQ/V4gXeR636w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=kit1a2J7; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=kit1a2J7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRL6G5XqBz30NF
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 11:00:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758070822;
	bh=kPcYVN/bdj4IAsOc2wtOoTywOlIcugnZO98J5M8IzPg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kit1a2J7OpKqINcCyhtqpEkjNPspQe0QOwfTIt3cnWsRBM0Z6bkiByAs5lTFy4yOl
	 jdhbbVke58ds1NvIYBtljzY6o64gXE/r6XUIB4c6KrMbQQ2fJqBMEApFsPC5CQqyyV
	 xaw+8O4jlmznaFgL1/A1IrL1WCIi1LumdLGHboTGVV5qtNLGigxKejX9HzmHn89vxD
	 sjfViM6+lAkrql/m7IrQvBED6sFGuZrauJ9FPgc72Q4zNiZKVc+v5N2x4NB9DlewGO
	 B9mOrlF/vyTg3ofG3J1+ITkzLEUnaI9jjs/r1fg/ih8GDLFa1KEpTEoaNjXHeWzoA0
	 L67cOlWzEMtAQ==
Received: from [127.0.1.1] (unknown [120.20.76.56])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BCCFC6F070;
	Wed, 17 Sep 2025 09:00:17 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: patrick@stwcx.xyz, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, Zane Li <Zane_Li@wiwynn.com>
Cc: Zane Li <zane_li@wiwynn.com>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20250916034036.348247-1-Zane_Li@wiwynn.com>
References: <20250916034036.348247-1-Zane_Li@wiwynn.com>
Subject: Re: [PATCH v1 1/1] ARM: dts: aspeed: yosemite4: allocate ramoops
 for kernel panic
Message-Id: <175807081736.540394.10309376848327644681.b4-ty@codeconstruct.com.au>
Date: Wed, 17 Sep 2025 10:30:17 +0930
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

On Tue, 16 Sep 2025 11:40:35 +0800, Zane Li wrote:
> Reserve a ramoops memory region in the Yosemite4 device tree so that
> kernel panic logs can be preserved across reboots. This helps with
> post-mortem debugging and crash analysis.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


