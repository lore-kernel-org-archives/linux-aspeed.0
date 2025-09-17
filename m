Return-Path: <linux-aspeed+bounces-2239-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A964CAC592
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Sep 2025 00:36:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRKbF57Zpz30Kg;
	Wed, 17 Sep 2025 10:36:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758069417;
	cv=none; b=inPYhKyvemTf/MMoh6BiPxMg7NruDLdGxs3BpOhb00P9kEHM2tgTvRVfpOpfZkR0tyIXL8gZSMSpoZnLP0iW8ghRmR9YBAuamQ1uxwx+dh3g4U15Kco8SXI1fndsJi7VgvJsx/kj0EjRtR5Frqb3/vJoiBIzsz4fLKFaaj2fS1pJUV2aO3HX5tZK0+GKTb/En3t6x0zyHkOjWjud9SFqfPcACW2+7kH6NYbd1x1W4JZ4LV3c8sSK2LYQwORXUDOqpr6tBmuZlgKK5iKN05cS1E+aqUYEYtROlEXhgQYZ8R0BJJCGi/WwT99VTsUacCGt19I/m9qCu/gmKiS5cX6/Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758069417; c=relaxed/relaxed;
	bh=2aQQfGbAOvDVkwEgS59kc/rR3ZeQC8NQMOe0HdHu520=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R7cQQw7AA4XGIVtZ7z5laP14OMXWBvLdVl1E61xuPG1z0jGwbi69seHCTngDwt69/cmv1PqzK48f5Ig5e4j7p7IeHWphR0oRJXQYcHEXUIfuQJBDAq2wEABoJRxpFvOZKXhnQ+ja+FH5iPaO6yBeKj8Gi6Qk5cG1DubYtMvil+9aW/zzwfizMEI53NJYVC7EFtipqaRSrVtf03TQ+SOQnR8J+k4XEmDUrdETWfoM+/XC4o64OBcD60X/Fp9BLXHZ19ah94PTbWjVC0rpiSFlCbFAU9PSG+t0G8cLKcadcIKelFcbKQOKXIThLJYEuKnqBIgmfgrIOIuG9o0tLvyl9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XFiZ6dWq; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XFiZ6dWq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRKbD0zrsz30BW
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 10:36:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758069414;
	bh=2aQQfGbAOvDVkwEgS59kc/rR3ZeQC8NQMOe0HdHu520=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XFiZ6dWqlEq5JjXJDc3jTkzqlLjsXOYeOEaYvqx3w+QWmoF02AibYhO/0qogfCNoA
	 6Cw8Hgj15YSEAeqDI+FNe1jTCivXry3hZqLkFLRKe67f794gwcj+kqahWzefuFRmXZ
	 VbzTWtHHL1k9NEf4dA0n4guxa6IZ6qQlojXlRKLUioC+GWSKANFEZ0gkGKnjxiRmql
	 7II0uBU+85pghCodofZ0T0srNeTCav74b6daG1tWJNFl8I30RCnLa2mc5CXgsOl29a
	 qH3Jwa3gqfmPQDK2kR5PQ/eS1AQdbeWTM4i2PEVwNtTImtr1qoEhQilX7o4+BAeCjX
	 23gXItncK/V9Q==
Received: from [127.0.1.1] (unknown [120.20.76.56])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 09EDF6F070;
	Wed, 17 Sep 2025 08:36:50 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Leo Wang <leo.jt.wang@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com
In-Reply-To: <20250915-leo-dts-add-shunt-resistor-v1-1-d65389148a3d@gmail.com>
References: <20250915-leo-dts-add-shunt-resistor-v1-1-d65389148a3d@gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: clemente: add
 shunt-resistor-micro-ohms for LM5066i
Message-Id: <175806941070.498785.13666236370278646492.b4-ty@codeconstruct.com.au>
Date: Wed, 17 Sep 2025 10:06:50 +0930
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

On Mon, 15 Sep 2025 17:47:23 +0800, Leo Wang wrote:
> Add the 'shunt-resistor-micro-ohms' property to the LM5066i power
> monitors on I2C1 for the Meta Clemente BMC board. This accurately
> describes the hardware and is required for proper power monitoring.
> 
> 

Thanks, I've applied this to the BMC tree.

-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


