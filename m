Return-Path: <linux-aspeed+bounces-3198-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE22BE6F091
	for <linux-aspeed@archiver.kernel.org>; Tue, 23 Dec 2025 13:54:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dbGj62Q09z2xQK;
	Wed, 24 Dec 2025 00:54:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766498090;
	cv=none; b=WoQ5bw+6grrKtuvysaaDer3HtcVBrs2aLPdiO/COl+FXAhRb7juRwFxANPnnbin3Da1/5iAS+G7o60CasQM3d6v1zKDrKNpdoHJybDzKPVHisGP2K9FGkrzd1GTKiDLsmdZJE0vUMw4qUrmSB/tBB4m4Xzs++UjpiT3PJzbbWDDeF8NWExF0pa4XTwF8ARS1Sa6oN/HvbTwvUJAC3avooGxpQd0d/+UuPh0Y+J9nNfx7EloW/QnAU39zlBIatLKtVNZlHkIbcmLiJggYAoqdsZ76lDGm4+iyNYviBX0m9SJoMxV7QRlI2pE7woizy+Oh6wBZuX4fZMBaSEFLBoU8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766498090; c=relaxed/relaxed;
	bh=2m1nXDkMRbgyrNZ3fWvlis7fsd1EOi9IRHGFWYhTUl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHBVXuxcMGgnRZBG98Gq6V1PgCPQpN4Q3QNtoo9ivTRkdAYRcQ3KGonU+RL9r41xxJ8KqvOJ51g0rVagIR+evQWyQ2ZNu/uVzQH4rX470SsDFfRrTm9nFltc2pZM8gwT9e9i95JXUuhAR5ohyzgmdYQbL1Qdwc0kIgk1nQt+++S99MADCpCc+lOnPpLNtwrwbufSK9tN2DPVNWdDuJpiZhzVGrSCkdiUMLLNLIaS7etq4GhuGBP2hASmTv1BWYH4YzTd+OL3qa9ZJeznGfGhydWCFX+/cMjiam1xZwFQeyakyRd6d16euii+2HzO2bIqfLh/T+wVd8yw12ymwQqnEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qrmsdykT; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=qrmsdykT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=krzk@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dbGj53x7dz2x99
	for <linux-aspeed@lists.ozlabs.org>; Wed, 24 Dec 2025 00:54:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 64A9360123;
	Tue, 23 Dec 2025 13:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBEDC113D0;
	Tue, 23 Dec 2025 13:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766498056;
	bh=AiITmCreaKBX7HKqX2F5SX04cacgCiPL74DHqx+cHiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qrmsdykTICzc1mqAHBjdG9SAc/oCv5sxGKGxwnXadPn1+LOy1LVhoMMzrBhhBkuDP
	 w2K07fAkYvb3vTL6xolLw35bpdOQqJAmGrdrEwXfdrobtJe8tibdsHa4nwC/pq9P01
	 ma2qh2+JsjFFIa5o3aZRLYbkNVhyEfQadnc+P41mkK60xosPQDc0Sptz3Mj2dwkopE
	 jRCW2U+pVv3Jkgfmi6+LzzJZkDzq6lvnXARy4IeKr+89d46c9FCsLBqnxIbP0m7vCQ
	 Kkkf5GPDTZxUkPZwNK6G3RvQHHut/6W6guZ9aCsNxLfbAKZ1jqx5wLKouSTNu7anUo
	 F1Ay4F91canbA==
Date: Tue, 23 Dec 2025 14:54:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kyle Hsieh <kylehsieh1995@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: aspeed: add Meta ventura2 board
Message-ID: <20251223-ginger-worm-of-swiftness-a8fa05@quoll>
References: <20251222-ventura2_initial_dts-v1-0-1f06166c78a3@gmail.com>
 <20251222-ventura2_initial_dts-v1-1-1f06166c78a3@gmail.com>
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
In-Reply-To: <20251222-ventura2_initial_dts-v1-1-1f06166c78a3@gmail.com>

On Mon, Dec 22, 2025 at 03:45:43PM +0800, Kyle Hsieh wrote:
> Document the new compatibles used on Facebook ventura2.
> 
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof


