Return-Path: <linux-aspeed+bounces-3355-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA69D47CA4
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Jan 2026 01:13:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dshgn44Pjz2xpl;
	Fri, 16 Jan 2026 12:13:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768526021;
	cv=none; b=UFz+ImRNiJmBi5LV59BwVmfGQo5V8uQvvlQBb1ZvbCY7Z+63uvreATqArxkQs1MP2iGGmgVP/MkwweumhrYboVib67on3qr4WLmmysbbZqwOMDOGUthI30sz+aTYt4pij1b0FrRZGt3/7e92JT4HfrZK+HiCjtf/jqV57fSEIi/kN42Hr8n2Ia2mUTC1ZxhHonLH29ytxnY7OJ8ZBO1LNY3kaF9QMWXEd/m2nbqeGLzOcg6aBuBOrHeBCTIdg9eXV3Plspf5/Ghz6RbOto7zGvQlEfDdb+ulMHK52LTIJ/VUbvXBJ8C8wekeMN2BLtaMgH8ANrfgn5owt7u3bVbJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768526021; c=relaxed/relaxed;
	bh=8v/THlnoXVHvcH673OA27G5X5V3+koupdlMYV2m+jOw=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Nsrj4VEGajwkheECmoKU7JelFjkFHKv6G/4P/lxhjE/fSjDquhm2O7dB9a/P1DilUJS1vteQOPu9o4stw+m+CZQpZgH/XAI9Gs3PH6xCoEW7r4LSi70Uj2TBwRvhqxBARsbxzCuwBTtQn8P0XTSa2f2r8bNKHw0Iv+WUsEwBqM1gFVVc5ks0K5ArcDcgSkIcZeBfZq+5mp/zERohR6JTwBnsTWb5QdjLfJAjp0wXBr9hrAb1oBmW+WzpQX3oAoZGiVy+QOvdue1IwulDlCU5GIve7i1dsOvL/h3BunZyW5DrbovPrtx86KkKFLWF6zph+ApiB8Xsbx3hpII7SI1Sjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=llyvELKS; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=llyvELKS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dshgm0lxpz2xPL
	for <linux-aspeed@lists.ozlabs.org>; Fri, 16 Jan 2026 12:13:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1768526018;
	bh=8v/THlnoXVHvcH673OA27G5X5V3+koupdlMYV2m+jOw=;
	h=Subject:From:To:Cc:Date;
	b=llyvELKSiIznZFW2NMeR6N9UUpuMCbNG5eZ6NMYA4qKlLjDmjmignOGD8GbWRNYv4
	 sFXxCPIzeM/fWBcLbmmYM1v3fpQSqi3JvkS1FIW1D63OhQXIzSgtjMUlR+v3/6ZC0O
	 RRACwGPLcHw0sVQIxHcWvdPpyo6UZ/+gUZ/mPR1MBIYOghg0Mx+m83v6/uIukXIAMG
	 cYmA3Cl/6Ek4v7wLoorSmvF/+RoeP49KrRSUKQ1J1Z92QxTYWNr65kCik1JYjLavm8
	 IwvKa72cO1dqks7sMNL9vU8D16BxrNnzmlT+wIUKau8jWH2MNv3sPMfISTVrPLdwaP
	 SDEFLCB0xHvKQ==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1D5BC7A005;
	Fri, 16 Jan 2026 09:13:38 +0800 (AWST)
Message-ID: <392d9247f7c15d11b115c86cba762568f37cd10f.camel@codeconstruct.com.au>
Subject: [GIT PULL] nuvoton: First batch of arm fixes for v6.19
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Fri, 16 Jan 2026 11:43:37 +1030
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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

Hello SoC maintainers,

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8=
:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/nuvoto=
n-arm-6.19-fixes-0

for you to fetch changes up to 70b8c45d8621c4d77b5659270e9a26ce7b1123cf:

  arm: npcm: drop unused Kconfig ERRATA symbol (2026-01-08 17:11:35 +1030)

----------------------------------------------------------------
Nuvoton NPCM Arm fixes for v6.19

Just the one change from Randy dropping an unused Kconfig symbol.

----------------------------------------------------------------
Randy Dunlap (1):
      arm: npcm: drop unused Kconfig ERRATA symbol

 arch/arm/mach-npcm/Kconfig | 1 -

