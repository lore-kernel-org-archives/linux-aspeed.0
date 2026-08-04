Return-Path: <linux-aspeed+bounces-4604-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E79CDC55172
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Aug 2026 06:44:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hDkYg3Klhz2y1Y;
	Tue, 04 Aug 2026 16:44:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785825895;
	cv=none; b=E77mrzdkMC1HVze0mYi82gBjvrq9wQNrXCBuP3PZeLEWA437pz2JFm+5x3vHRGWQ+QvGvQoFEqaG4KqDqFxMiSpgH5Be4g4+/43G3wPwF+3yCGjYuNoiBoB+6IjUvxnCN1OMD2IWw3qZCrV34agh536FWbr7A1NT9fEUKTwinw8GNxOmnLHRAS474X5cbEQ/5P4gorh8yyPktwkEnk5Pbb2cpjBmnwGeO+c1INjnYsYLrOjEPUSjJI9itDewh+ZiVlFlEZuPt3tUdE8LQdrzfJQpxq8K8/sn65X+qNlHJVApfWfpjjsxjHAJoHtNuRUSSJFtE8AspPBDBFLbJsyodg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785825895; c=relaxed/relaxed;
	bh=Bf2vZiMryyidrIVtaECU1kR4CLMERTZBJinxRYUKU/E=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=GRiUx85nGIQxnr0YugjnjoL5snxFDR5E1OJvndEF2xDcQ1AZRlIwExra4b9oeY/Mrzg1YvIfb7pHnE4dRWIpBCLbCQ9ZfmuaxNGLeegiPPBHKa4DrT96Ux5ga+OhX3hKqlbYOhuW8M0aekJidkb2EGFtteO7BFk+HB13F0acT3Ns5aEGE/BiGP7UL07v60KF/oMsQfB44kgR4P2VGQ39qMIK/LHDWS/2VvYg2rVUZtkw45AvMmzdNbM+PdT2gVW+elqAnNUPdr4Hq224xYdTyHN1KK3TJ1Vh2LvIUY+57g9K3RWwh/lYmoEkVviJ0wxL/CRtm4bd2rlpJCh0juKjbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=eG9KGIxi; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=eG9KGIxi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hDkYf0CDjz2xyk
	for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Aug 2026 16:44:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1785825893;
	bh=Bf2vZiMryyidrIVtaECU1kR4CLMERTZBJinxRYUKU/E=;
	h=Subject:From:To:Cc:Date;
	b=eG9KGIxiXBF6NDuZtZX8mRQEkbxls6aRsqKf7LXLXpHL3micaiofpXy/GdhJ9MPEH
	 JQHFBtyhPIlseduOGmpqiLGYaIUWFARzav4Ul8Fowu3deWTZSb2oEhCGiy+5q3unKW
	 UbxjiGFIeDvXjW8bQlePVJJYBKIuFhM3jYyWTu4SmLJMp78cJmaYLg3N4Prg5GR/HG
	 YF1lNDz+TruXJoetiFT86zzsB4jnnMTpGDTo7IQGNTCp8UVORiiLF/uMJtIQLFQR4N
	 x4ZW5lmu3QkrYBLkE3yKxpCy5td/tN02/lmklbWkhshqGnmzl4bYfrEtX2khjnLNDN
	 VZHcNk5p3fetQ==
Received: from [IPv6:2405:6e00:242d:870e:1a3e:8259:e4fe:6a28] (unknown [120.20.146.186])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E781D655A9;
	Tue,  4 Aug 2026 14:44:51 +0800 (AWST)
Message-ID: <3da63bea367b3490b041c909a4503cc2b5e9c394.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: First batch of driver fixes for 7.2
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Tue, 04 Aug 2026 16:14:50 +0930
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

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-7.2-driver-fixes-0

for you to fetch changes up to 1acef6d85bfd98bd9dfe1f08bffa397a4dda8a6f:

  soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read (2026-07=
-22 22:10:54 +0930)

----------------------------------------------------------------
aspeed: First batch of driver fixes for 7.2

This time it's a single fix for a kfifo overrun, caused by the the lpc-snoo=
p
driver implementation behaving as multiple consumers.

----------------------------------------------------------------
Karthikeyan KS (1):
      soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read

 drivers/soc/aspeed/Makefile           |  1 +
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 38 ++++++++++++++++++++++++-------=
----
 2 files changed, 27 insertions(+), 12 deletions(-)

