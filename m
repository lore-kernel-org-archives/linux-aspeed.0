Return-Path: <linux-aspeed+bounces-1676-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091B3C83F1A
	for <linux-aspeed@archiver.kernel.org>; Fri, 11 Jul 2025 01:20:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bdYmb3FKxz2ySY;
	Fri, 11 Jul 2025 11:20:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752196815;
	cv=none; b=JThhs2qfSiFuXDACvpEZnJzv3//XSl93OTPi7lQJwpSIqYr1HNiCx8mDC7l97xQmARzoVh0bYIXAAU+cgSXtJAZhWp5B35JiBJbO/2ouB/zdGRsMoM7SltbR/YHy4poIlhq4I1n7QNXo9bQEpO6ZdAkzRCP4h7pfzX0G2JmySBtDi94t4ZUTLcU/7zD/uBGNHsNzuiiS3muae1D0Mu/AvFiPoENo0za4sW70i0L/cKO2zfJ++lIecGIPJY/csx0Dohl0uQNeTG1kqCXpMrKaj/z32ZWsju5Fk/LnbFsD4u/qeX7hBjto7wtJX43/pVysgK/BrpmJ3gVMhiRXP9TzIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752196815; c=relaxed/relaxed;
	bh=l4UlN0Wafho6MahmKxGDM1wRAp7sFrpVKSoHrCpTA4c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mv8nyWHwHeB1X6YsdYtxc+xrMZrCz15l12zd+a84MKduc4yL3rmDhdXp7V/SfWi1vYDj9B2W1CQV0hVFrZlENubFSW/awzg+HViT9Eagd9qQCKJKYlVtRMgIZv4ibATM1nkMXkXJTJhx5Ct97CjEj8JLFNHHIM5YcPAKGWvc0iD6kiWlOxyy962yuBRKjExQnAN/oUNCh8SWGsf4Esub0hExIqBkPflt1qRKGMMaCwAecvI4fKymYqPv4nxfyWy9izeCio71p60pd6VXI47x7tG8inZcizBunn0JB7fQg5i+pvo0MHWO70yxwvqq1A6/9veMqYobZI+V2eCS6JBrHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NIN+1oRO; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NIN+1oRO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=patchwork-bot+netdevbpf@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bdYmZ4X47z2xHp
	for <linux-aspeed@lists.ozlabs.org>; Fri, 11 Jul 2025 11:20:14 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 83F6347155;
	Fri, 11 Jul 2025 01:20:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2D8C4CEF4;
	Fri, 11 Jul 2025 01:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752196811;
	bh=IHx4h69R13Or67ZMOMaSeRoVxPzmcWG/NZh6P4Ei+UE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NIN+1oRO/ktlMLvxpr5oyhzKdiKGbY37jGX1lxWxCpJkzHZ++lY+dmePCONpYbsoU
	 1FTjG8FW1ThT69hHy4BW4BxdBeWnACSykXHqLKShlqHZGufGNYWZUjj2d63oOMUfEf
	 8sM+J+1Q47VeVnzSHkcdCnUgbRVHs74LbjCLjSSgGjM5HYykkNs/uj6OH3EiNb9ycg
	 ysjFsmQQbHC8pWtSlRE1Mh9btbyasQVJkb8fy2IfvB+6hC5D+fcg9JR5xFNxq4fTAn
	 0Ar+E8cdOe5XdB/SAXEi/WHWrbKwGpAtGZljUN1OsSe0o3kPLx7v+wjqX9FmawNXPL
	 ly+HdBmwlqvIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE060383B266;
	Fri, 11 Jul 2025 01:20:34 +0000 (UTC)
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
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v4 0/4] net: ftgmac100: Add SoC reset support for RMII
 mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175219683324.1724831.15355320324094175037.git-patchwork-notify@kernel.org>
Date: Fri, 11 Jul 2025 01:20:33 +0000
References: <20250709070809.2560688-1-jacky_chou@aspeedtech.com>
In-Reply-To: <20250709070809.2560688-1-jacky_chou@aspeedtech.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 horms@kernel.org, jacob.e.keller@intel.com, u.kleine-koenig@baylibre.com,
 hkallweit1@gmail.com, BMC-SW@aspeedtech.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 9 Jul 2025 15:08:05 +0800 you wrote:
> This patch series adds support for an optional reset line to the
> ftgmac100 ethernet controller, as used on Aspeed SoCs. On these SoCs,
> the internal MAC reset is not sufficient to reset the RMII interface.
> By providing a SoC-level reset via the device tree "resets" property,
> the driver can properly reset both the MAC and RMII logic, ensuring
> correct operation in RMII mode.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/4] dt-bindings: net: ftgmac100: Add resets property
    https://git.kernel.org/netdev/net-next/c/fc6c8af6d784
  - [net-next,v4,2/4] dt-bindings: clock: ast2600: Add reset definitions for MAC1 and MAC2
    https://git.kernel.org/netdev/net-next/c/4dc5f7b2c0cc
  - [net-next,v4,3/4] ARM: dts: aspeed-g6: Add resets property for MAC controllers
    (no matching commit)
  - [net-next,v4,4/4] net: ftgmac100: Add optional reset control for RMII mode on Aspeed SoCs
    https://git.kernel.org/netdev/net-next/c/af350ee72e9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



