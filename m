Return-Path: <linux-aspeed+bounces-1158-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86EB3C3601E
	for <linux-aspeed@archiver.kernel.org>; Thu,  3 Apr 2025 10:15:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZSyKW71RSz2yNG;
	Thu,  3 Apr 2025 21:15:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743675311;
	cv=none; b=a9l75fqJTcUtiP9ZA+MLipFeCQyh43Q88DALtdMFQJNh1tiYay0VbsgPq7fWOYhkwvkvVPuTri+nuskGgb+mM7K+P7RXo4Y45ZifyCSDOJzwHMc9nJumzk4Co9NZWHK7WINkAHSh5RzoSsHxEsJvpDylfcrSVQONTmjAOTBSG1L55dwYQ2mdNMCNgw5AgIv+CtA93dlwmmVvbHU6Rq+R1orLp09wWvfNZ6MymdRFtk2ifCepLy67vV9ZOFuJiwDQMRL6yRuCHZ2/yKviSyBXZCkQtC+CCqgHkMSElM4FXpYJrOh7Ae23J0mdzZq6Ik1YjYejXXwho3Y95BriARtn9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743675311; c=relaxed/relaxed;
	bh=6YiZPdINyfjJtYAnZKaHv2MfxtG1OcVQesKXKvaLIoc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DR5nOxY9tMfJFaHbq3GxUO9i8+Gr0Qsd4WLdo04/4Dw7Uh/FhHljlIMLQVmm0CLbz5qDpB1WsaFqVDRmYCITHR29iKygkqdELqMLFiaKOAILwugBAuRpN7smi6cdmJ0iPKANEP5vZHVItlw2O0uFLcA+fNHQBetLRNCwzgidLVlkZ70ZZOkZadkUjgruklwgL89B9eJ99GjjGmF0Lc3nbqWSBsTqmsrjYUp8T1iZ/3yJkqS54cA0hAKXn0gX3ohpRErmV6PJf8jYISfv1Ojcmu2xBGv8wT++aJekgiEMunjxER/mj/8s7pheg1MwuRvKQv6/SkuXuf0YfaPDkQhdqA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=YjHebHiX; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=YjHebHiX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZSyKV3qTJz2xjQ
	for <linux-aspeed@lists.ozlabs.org>; Thu,  3 Apr 2025 21:15:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1743675301;
	bh=6YiZPdINyfjJtYAnZKaHv2MfxtG1OcVQesKXKvaLIoc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YjHebHiXBKcucM1B5xCxyF7McIWBWvSfR7Oy71lKvde+bw0b5DyjcJdXoFNMkJpM7
	 wguVnfH/FpNTX4NRS5O57Kbq+qf0TiNvMDMPioOwjHzmtoidj5Iv74hr0rK7f1I8HR
	 mfbilxoenBUuSg7fD+YGMLG1g2aTCjGoOMCDu0NpHAuhVyYrrG6qc8JEqEzZxgQts6
	 /aUil5JOL9KdckyutnY5QCssgu29OKMSu9+Aj+2vbU/WtAV76DCPb7Flw+y5vg7Xdz
	 OQubU3vZ3QkC349Yojaye8/QLM8F3LRkXt1iYoeqJ2b8gx7XIkX9aowLewqg4VOurN
	 hTmFaKjc9s+dA==
Received: from [127.0.1.1] (unknown [180.150.112.225])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B6C8A7C3B3;
	Thu,  3 Apr 2025 18:14:56 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: joel@jms.id.au, gsomlo@gmail.com, heiko@sntech.de, arnd@arndb.de, 
 herve.codina@bootlin.com, andersson@kernel.org, 
 u.kleine-koenig@baylibre.com, Henry Martin <bsdhenrymartin@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250401074647.21300-1-bsdhenrymartin@gmail.com>
References: <20250401074647.21300-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v4] soc: aspeed: Add NULL check in
 aspeed_lpc_enable_snoop()
Message-Id: <174367530124.3067819.2690843491529168690.b4-ty@codeconstruct.com.au>
Date: Thu, 03 Apr 2025 20:45:01 +1030
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

On Tue, 01 Apr 2025 15:46:47 +0800, Henry Martin wrote:
> devm_kasprintf() returns NULL when memory allocation fails. Currently,
> aspeed_lpc_enable_snoop() does not check for this case, which results in a
> NULL pointer dereference.
> 
> Add NULL check after devm_kasprintf() to prevent this issue.
> 
> 
> [...]

Thanks, I've applied this to be picked up through the BMC tree.

--
Andrew Jeffery <andrew@codeconstruct.com.au>


