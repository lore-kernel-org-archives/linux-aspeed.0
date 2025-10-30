Return-Path: <linux-aspeed+bounces-2706-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4963CCF9E3
	for <linux-aspeed@archiver.kernel.org>; Thu, 30 Oct 2025 22:42:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cyJzB1gphz2yx7;
	Fri, 31 Oct 2025 09:42:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761864166;
	cv=none; b=JKW6ouODl2RTrfAAO5JLD2/pDvB2Az5KbRiw8bSSBQG0v1KU8fVnjBr0Xp6iTfpY35Oj867FzA9+hgiN2caC+R3ERbG8vbi9ZOPPI+Nott9oc0KNFKQjB4epv5wy+wMEMLKBuhn05eZonuP6HZytSuREnaA/195ZrXdonkRsGl+0duSnz974Z/enWQcJm+Rp6pVGewnhrqznDZ7IAABobAeMK8Ddt8BBA1+trCtmg7ZI2dpjQNq89ht4TJantyiwoHmFsslrXQCHC/0L447Vcs3h8Lmc6L+RrQiCeN3JyVznnKSxzpwjVHfVkXNNXZ6OEGltgHAvrPV5WCftY3axhg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761864166; c=relaxed/relaxed;
	bh=PGcZ609ASUkoNdD7qkyIUnsaVC30SmdUGzl2/Zy8Bug=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=A3u/hXnTmrHKnjX7ouAlj+0Hf1oumkRbPa91u89876GefxMzqInIFN+PkA0y5ES5wuMukWhrADAkYAWQ9zjpPV7wBcTGrqiuHCqDOkODo39CteNNPxmg92Zw0pFzz+UiEHZEHSP3Npyw4y8rcOH2liuSAzbHdUMjMNfBmR9R8fzSt/2gBnMxV9H001STjJcEFVPzvOZp4Uc5bbA0QY961PUtQgiehdtA/59fNkEInHJf1LWlKtBXGFb9UUASWlUaD18HsQJRWDPPl74BuDx/lf4ryLjBwo0vF/Y88h0pmqaDN4Ij5AUG5u1oDHRIlyEk10om63/4+0UZcgZ2/G7dWQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=aA/7kD3s; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=aA/7kD3s;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cyJz92Ftpz2yrZ
	for <linux-aspeed@lists.ozlabs.org>; Fri, 31 Oct 2025 09:42:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1761864163;
	bh=PGcZ609ASUkoNdD7qkyIUnsaVC30SmdUGzl2/Zy8Bug=;
	h=Subject:From:To:Cc:Date;
	b=aA/7kD3sm9oCzF5qsgyxJbyrX3wsi5wtluu6MaklvKPCKBJDIxqmCc0DX1EcJyHF+
	 gktPwE/58no3ApFkCtcNv8yEMM+ryE0mrK6TVBIcLLqvti4SoWrZcUl2JEE2nHW8dz
	 dXJ/5WdYgSH7S8llbvX1bThJCAtvrlMcEQEpkCLI/KGBEkcWogC7WFGKSdBdEoHMyL
	 UjxUukyTD+7ODEPJaXgXzuewd1V06yoaUG0FliGNne34xGI5vHFSUiqrO7MH2z2lpU
	 D3AM5UX1COUxnTkrqQWeHnBYjCM+4q54HE+kqjos4xxyiztlpCehukyddHWlCCjAKx
	 NDUh4IG5k008w==
Received: from [IPv6:2405:6e00:2421:7372:17cf:8b2f:ac7e:ac4d] (unknown [120.20.6.198])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E8E2C78C99;
	Fri, 31 Oct 2025 06:42:42 +0800 (AWST)
Message-ID: <d79a0c80cdd9e2c45e6a82fd8c78219b6d53f206.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: First batch of fixes for 6.18
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Fri, 31 Oct 2025 09:12:40 +1030
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
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

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787=
:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-6.18-fixes-0

for you to fetch changes up to 85893094535cced32b33766e283240164a5b11f8:

  ARM: dts: aspeed: fuji-data64: Enable mac3 controller (2025-10-17 16:29:4=
0 +1030)

----------------------------------------------------------------
First batch of ASPEED fixes for 6.18

This time it's just the one fix addressing a PHY configuration regression i=
n the
Fuji (Meta) platform's mac3 devicetree node.

----------------------------------------------------------------
Tao Ren (1):
      ARM: dts: aspeed: fuji-data64: Enable mac3 controller

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji-data64.dts | 14 ++++++++=
++++++
 1 file changed, 14 insertions(+)

