Return-Path: <linux-aspeed+bounces-55-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDDA5D6B6D9
	for <linux-aspeed@archiver.kernel.org>; Wed, 30 Oct 2024 21:02:24 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xf01q1cNvz2xKN;
	Thu, 31 Oct 2024 08:02:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=147.75.193.91
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730322143;
	cv=none; b=W0N8umhko57hWPWkulGfCiQ3cG+gFqh+DBVbP765zL7r0xeHpNeTwcqAFG72uVmegh5XvbwP+z8mwq7IUY+6l+nAyCfH+JAhzNi3PTIY293pCvT8Jb0+qJEhDzaFtUaMse+T+6rh0E7u7QQr2w0jQpSstUoe6M6JWe7u26gCKQrPrwTa6lkgVpDH47iYUo1wupd1Fav+udthdZLYzpfnxWyzafLi88CfLPwnDZiE1aME07ASRv1v4HA92SqWogjsSQcYtmE8cac7wkQEXppVI7GPpF439YU59AWP4GuvhzMnqr651uU9BXmnZV8wuwzKTbizRDe5+yH2qjDFNH0NFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730322143; c=relaxed/relaxed;
	bh=dV0CJUVYk+pJK8bM5R2R8JIpg8iSnCYQ7BBihu9uQzg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:To:Date; b=a7CzLoR4tJquN7ymuT2ZPLJaMNKjPc89CiJnmRhM5nrUiwXE0E2kKARFIEDT9a+YJM+b+r0cqlm/30seDvNNAlPyxyLfXoVIAi9YeK7t0j4oW0GzVQMAbICEJhXh0l3olY3zICckXDm+FQRpRdnGUgcSgcoRvzSxf4AL0tad+TT17l2rR5yCnvyrRSLW4Ut05+LbRSuauR1yFi0QtqAnMOHkNXYyxKgnP6pNiLZAaHCY5THlnYi7FjvZbYH7MIOYvwLoq+jyLXLh/VG9nQPXB0LLOuy90UATjvzeyioFEOhj8g2QYg+u4ne0Ial440bnWdoCo1o7TXMIxnmlM/gBFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tcPLhnp5; dkim-atps=neutral; spf=pass (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tcPLhnp5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org; envelope-from=sboyd@kernel.org; receiver=lists.ozlabs.org)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xf01p1zQvz2xH8
	for <linux-aspeed@lists.ozlabs.org>; Thu, 31 Oct 2024 08:02:22 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 67159A4334C;
	Wed, 30 Oct 2024 21:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB83FC4CECE;
	Wed, 30 Oct 2024 21:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730322138;
	bh=dV0CJUVYk+pJK8bM5R2R8JIpg8iSnCYQ7BBihu9uQzg=;
	h=In-Reply-To:References:Subject:From:To:Date:From;
	b=tcPLhnp5GzJZQ2VpKma7dkoBKrGxTJLc4urxLyX2ZX2D+mCJMmZ5A/5k/eY+Kjs23
	 +i3Ap3fcbmnmY5KdVDasrOjRZefl56qhuvJ0JHp2SSOucvfzDTpuLvwQhI/8Uo1FYg
	 rmzmL5HDTNHsAgB/jCDwSjju4+HqSuEQhAZU1TYuNyFIrKRK+1SRxbmSaCqjrwKHwC
	 5JL1tKZIYwWJ1zsu1x4LbTAagHgvaNFiZHNoowfDBa6tLhVjgPWPjhkEUK4kWaBfLP
	 iefzW0+e4peqz6SR7V8ullh4BlBJUY/5nPrnpV7U6Mu/DkorDlj/cCS6kLGltbgXjk
	 Og0oNm4t49KWg==
Message-ID: <9d9e16d140e50b9c16ae6d3f58de719a.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241028053018.2579200-4-ryan_chen@aspeedtech.com>
References: <20241028053018.2579200-1-ryan_chen@aspeedtech.com> <20241028053018.2579200-4-ryan_chen@aspeedtech.com>
Subject: Re: [PATCH v7 3/3] clk: aspeed: add AST2700 clock driver.
From: Stephen Boyd <sboyd@kernel.org>
To: andrew@codeconstruct.com.au, conor+dt@kernel.org, devicetree@vger.kernel.org, dmitry.baryshkov@linaro.org, joel@jms.id.au, krzk+dt@kernel.org, lee@kernel.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de, robh@kernel.org, ryan_chen@aspeedtech.com
Date: Wed, 30 Oct 2024 14:02:16 -0700
User-Agent: alot/0.10

One more thing. Please remove the period from the subject. No other
patch in this series has a period at the end.

