Return-Path: <linux-aspeed+bounces-4601-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825E5C55822
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Aug 2026 05:36:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDj2H66Gzz2y1Y;
	Tue, 04 Aug 2026 15:36:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785821767;
	cv=none; b=ljaByJDzq/QpevpGX6PhJvQhw8nXmErCQ3Qkc849R0U0mzs3DpIWg76HWVNpalO3cn24MNRb+WWOPmPretdI1pqAHzw5HUT7Y/k4pfECEXS6Vz8JDITGwESLORI1NdWxMhX9BtU9XbkEDdX22bYwF2APWo1qErt7auk5hs18nO22zWm+kJ/F5JJe0MG/v0EKIiCDWNIx1w6J2RqrCp9XoM1C/b7hqIn65vH9hH8XyrqaDa398gbK32oPSLt4BhaBQ49y8QEU4EKPsyJXsr4wYdiXIWpOABoqA69X+fyzzOO3wcZEKlUB5fevmOJN6X1goag7+YroJvHJY3k0hmj/HA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785821767; c=relaxed/relaxed;
	bh=HUzmDv8dlY9hJpk3TBvoU3edR9tSDvSdfT2jQQqZ4hc=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=gx3SRXYDpvetOO4zrlL43i054fYf692mQD38st/eb2RC/2CtIABz1IEno//5Ephpx/2O7hbYUTipPvkZvj+TxYzF+FZL9rR1dzc4KF0etEBJcCsWbOKExygkOLyhsjJ024eeVjwRwopG2C0qtl7poUGgVM6r7uPVN1s1P00LXx1cdlcuFuWMvuaQQ7AWKHUQXpt06T1rasH6J20ZtVEWQWp9BUPSdvChVGBWgdB+UKDj/m9vu2ysbY4vhRoQuDRyj5gIBhjqrxh5tK52YFj8yCDie4boKmFrLufJsEJSx40TQvoM+LUYHoyXQnsZeA0ilc0PO2yAAoystoKDKsdm9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=m1MRgEct; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=m1MRgEct;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDj2H0gxdz2xpn
	for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Aug 2026 15:36:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1785821766;
	bh=HUzmDv8dlY9hJpk3TBvoU3edR9tSDvSdfT2jQQqZ4hc=;
	h=Subject:From:To:Cc:Date;
	b=m1MRgEctHCoSjVbYDOJlLmw7m2Jk/8V65lDiaGymSNOhsntYXlV0556jD84kH0vI+
	 nDobRlI3Z+59Fxuqs+HeJJnm6HeUxMxFBV8nPzkkQsx/gW08QEPlIWatXlQD8DYQy+
	 7/vRK2OzKVISRSUF9DUdJxVGI9pXHqDjofP4soFT7UF3Y5hOCTBRyj6l/tFxn2DiFN
	 /BYhfryqxSvgVzIyBct1XXxWe24fTK097U4w0kU2sAZKIgA2h6AhcbbCz4JxBJvwAD
	 29mDGdK4zB6mGIWp5BZQ3pXtQKadJT2f5Ry7/BIaXFqQZLrSjybKpZtMR6zQN8kgQQ
	 oZKZYlCVhnUeA==
Received: from [192.168.68.117] (unknown [180.150.113.112])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3FDF8655A9;
	Tue,  4 Aug 2026 13:36:06 +0800 (AWST)
Message-ID: <a0dbb1b1642b5d30f01adb5f48c51e426414dc90.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: First batch of ARM devicetree changes for 7.3
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Tue, 04 Aug 2026 15:06:05 +0930
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

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482=
:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git aspeed-arm-=
7.3-devicetree-0

for you to fetch changes up to 749c34389679f8d56cb200a69b62f9a64670034f:

  ARM: dts: aspeed: Correct indentation (2026-07-23 00:52:02 +0930)

----------------------------------------------------------------
aspeed: First batch of ARM devicetree changes for 7.3

No significant changes this time around. Instead, several cleanups
for Meta's San Miguel platform, along with some changes enabling
dt-check-style.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: dts: aspeed: Correct indentation

Mike Hsieh (1):
      ARM: dts: aspeed: sanmiguel: fix PDB HSC shunt resistor

Potin Lai (2):
      ARM: dts: aspeed: sanmiguel: Fix FIO IOEXP interrupt pin
      ARM: dts: aspeed: sanmiguel: Fix PWRGD_RMC_N active-low hog configura=
tion

 .../dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts   |  14 +-
 .../aspeed/aspeed-bmc-inventec-transformers.dts    | 432 ++++++++++-------=
----
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-vesnin.dts |   2 +-
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            |   2 +-
 4 files changed, 225 insertions(+), 225 deletions(-)

