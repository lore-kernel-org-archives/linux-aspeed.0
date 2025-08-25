Return-Path: <linux-aspeed+bounces-2045-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43476CA0EED
	for <linux-aspeed@archiver.kernel.org>; Mon, 25 Aug 2025 04:35:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9Hyg6r3Xz3cR1;
	Mon, 25 Aug 2025 14:35:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756096507;
	cv=none; b=E4bWm4UxKmqDkTg4Eh7zXf1g2d5bVbQ3WJqrxgr3kTOA93SQFwg/wxCH0z1C9PJWeVvctDaCtUT8jDyD85uEbJH886LEvnsGMqwqTOtOwS5G1HB/wwTMuKT9f+lvvA8tWrleFvSq5AIcUi/X8nfoqNFFbawyDduyWN2Ztb7E0SsY8fCbGm9459wUKwVvI9i4JR1GgCAy89I8RjKITxuY5ZQoc/J+jgRU9ytSgwpYUrn5NN6fc6eM5MaKIOD+ah7lply7Vp5OAsw7t+1IWoKk1EFdSg3A9OLEQLBSlF4gIX0ND/33ejk5d0c1MGyq6ir4cShsiL3FvRbAESb5TlYbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756096507; c=relaxed/relaxed;
	bh=KRq/IwotzLLYuVj7PpxaygrL44sgkinwI3pjoy5upqE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=iOU8mzV+t7dCQMK6hf3+W51h7bTdh66i8Ki0LDqcVo8kFTGbfTKKgDTUZ+bpwPH+tXN8Uga+DuMXX49poZQjFINbNYCatz9M+kgt4QpUj64iQgktwq5Vhs29iJBDLWBv5erC74W5QmRANpz9+jdoPp/aMJZBD6VTGlBiO56nzK4jQpI5pH6n4k5sVLIndao88k4p1VQsVMsasITSllk5aQhjoD5bdcQ4gnn5pwP0gmTwa+RGRRK7F9Li3cl8AXIJCpaQc5jfbXzeK6aYBWd8vTxGBmSFzqiNFo70NGeVq/cnENz5oKUVOHXAdaoCiCmKSIiB0g6WJ6TK/32t3BK18Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=migGjffZ; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=migGjffZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9Hyf695Kz3cQq
	for <linux-aspeed@lists.ozlabs.org>; Mon, 25 Aug 2025 14:35:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756096505;
	bh=KRq/IwotzLLYuVj7PpxaygrL44sgkinwI3pjoy5upqE=;
	h=Subject:From:To:Cc:Date;
	b=migGjffZRA8dfDHH3+sAjmK/q1cv6bIL74ULtRDFN4fleamO+S7VfU1iVs73cw2eG
	 Hhad4DV03Lc3c3k3DdISvGbgygzgVJXRkD9w34lcbiQEaGqAvzj4rw5tRG42P8neKq
	 B96gwzXu3tu7TlesGJafzo3oPV4LZKB2IzzMh1869QVs6TDbjTi45UMpSQ0sOaSrFJ
	 8R3tJ4wQyfp1Y8cnm2vhaI4LkfIqqT5Gq1jiy6O9iKz98HV5xaFxRej5Rc0M9NZPFV
	 Radu8EiQmbWWrVgj2YX1O0Q3HBvzQ8lwu0U82giBbxbMnPzh45GBmqSnd6p+1wBvAc
	 3B4G9FiNf2JNw==
Received: from [192.168.68.112] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 179C0640BB;
	Mon, 25 Aug 2025 12:35:03 +0800 (AWST)
Message-ID: <bf3734aab62a5fcc8959261551bb4b1fa636efbd.camel@codeconstruct.com.au>
Subject: [GIT PULL] nuvoton arm64: early devicetree changes for 6.18
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Mon, 25 Aug 2025 14:05:03 +0930
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
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

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585=
:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/nuvoto=
n-arm64-6.18-devicetree-0

for you to fetch changes up to 13587befb34ffa5d605196494c243420e045f28e:

  arm64: dts: nuvoton: add refclk and update peripheral clocks for NPCM845 =
(2025-08-11 09:38:08 +0930)

----------------------------------------------------------------
Early Nuvoton arm64 devicetree updates for 6.18

Integrate changes from Tomer reworking devicetree pinctrl, reset, and clk n=
odes
for NPCM845-based platforms.

----------------------------------------------------------------
Tomer Maimon (3):
      arm64: dts: nuvoton: npcm845: Add pinctrl groups
      arm64: dts: nuvoton: combine NPCM845 reset and clk nodes
      arm64: dts: nuvoton: add refclk and update peripheral clocks for NPCM=
845

 arch/arm64/boot/dts/nuvoton/nuvoton-common-npcm8xx.dtsi | 669 ++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++--
 arch/arm64/boot/dts/nuvoton/nuvoton-npcm845-evb.dts     |   6 +
 2 files changed, 663 insertions(+), 12 deletions(-)


