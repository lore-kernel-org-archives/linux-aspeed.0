Return-Path: <linux-aspeed+bounces-1673-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B0BC83F0F
	for <linux-aspeed@archiver.kernel.org>; Thu, 10 Jul 2025 02:24:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bczF01zW3z30MY;
	Thu, 10 Jul 2025 12:24:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752114260;
	cv=none; b=AtRX7I1D+CPjRt2S/v75Ybaqg5Gyed6Cjvo8VKz632Io7kCXXiu6yoaGgcdqQ+jM27B88GsC1cMVfrTWp0Zdl6Waet0g7jNRyE6hu+OLdW1YW2v2OJhQ5U8t3FJXhqXQvR3dcLFf9i2OLGJaFMqfbeZ0KEvV1+HWSScDtpJQ13kMpBrEv3BaGxnmZz/WctbuFHh7wQJzhIPy61q9MzpZdZMZ7WodMhatfudNOshVny+dLDEy7QNCkRMNzCWkVKfMTwjhgSLSY7OB5WTxnEN0fXgjbia2CaR/pccf9sg4svH6W7aO1WNrr8d15DadQwNE/m0zFrGcxEhFHLTlq0cHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752114260; c=relaxed/relaxed;
	bh=lFaBzW/UFNKRDOoKgOilQk2+bD1ofG50x/0d54hiwwo=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=MrdAF+V3e4MUEaD3RfmdP/nwdZkLA6gS10z+SOeProKsMBFPxF9J0FdDxjCCMDe8aq0IguuxAAEq3j0zh9dpgvVQAXS8HDE7q3Il/ULjIT6W1U+QI6gAJPtXWHNARVqYH8CvXBNRSYAw9iYcD7X+tZdbtvE6kce0BToqF7JWHJJ0+D7SZ5riVZGd++Zadi/9kyTOw1QBv4jJKcf6wbB94OwtxQ0cQlVPEbY/3/D/SQUWI4+oT2fm6bXbmvwEP196wn054rB8VpR8Hem9+dKi7zi/xGcOelWQ0+0vLG3jFdrGOa8yIcrWu+GGXgXWPWIlcp7XTE6J1Wyj4ijAmI6sRA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=O3MbPEDV; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=O3MbPEDV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bczDz0Nkpz2yhX
	for <linux-aspeed@lists.ozlabs.org>; Thu, 10 Jul 2025 12:24:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752114257;
	bh=lFaBzW/UFNKRDOoKgOilQk2+bD1ofG50x/0d54hiwwo=;
	h=Subject:From:To:Cc:Date;
	b=O3MbPEDV8Vl5EyZd0IlS9GM7zFbwanUKbgi8uw38SA+/7kAG7A5I3K6ne6QLYVQ5W
	 QYE7yjtnUqcs6SXZNOQoj/kRpTxPpnbabtnuBeHjf6ZqZO/Xow2zMoyTTtz8/x2YZz
	 mM3u9e1zWiE7P7qvwU1e+DhY4ykrkeIJVcCIA+Tcvw4N6nsHPwoGnT2d6yo92Oeztn
	 dUMJODDPBsu0MHHxcO39SIobpy3QdatzTOhVNLX4+hJ2N52Vr4KpGrQp/64oXoNuGm
	 8YsAJQzi05wkBJqBKvptPYI5gftXk3EvuiRymsscENZpuzd6NoJk0g4po/FpHeRPRC
	 Av0g/SX3FK7OA==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D972E6508A;
	Thu, 10 Jul 2025 10:24:14 +0800 (AWST)
Message-ID: <d119a7b44b25a1e55a710adec7fce3e9a9fc898e.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: drivers: changes for 6.16-rc6
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-aspeed
 <linux-aspeed@lists.ozlabs.org>, linux-kernel
 <linux-kernel@vger.kernel.org>,  Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Jul 2025 11:54:13 +0930
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

Here are two fixes to the ASPEED LPC snoop driver for the 6.16 release
cycle.

Cheers,

Andrew

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494=
:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-6.16-fixes-0

for you to fetch changes up to 56448e78a6bb4e1a8528a0e2efe94eff0400c247:

  soc: aspeed: lpc-snoop: Don't disable channels that aren't enabled (2025-=
07-02 11:05:20 +0930)

----------------------------------------------------------------
ASPEED SoC driver fixes for 6.16

Address concerns in the ASPEED LPC snoop driver identified in the first two
patches of the cleanup series at [1].

[1]: https://lore.kernel.org/all/20250616-aspeed-lpc-snoop-fixes-v2-0-3cdd5=
9c934d3@codeconstruct.com.au/

----------------------------------------------------------------
Andrew Jeffery (2):
      soc: aspeed: lpc-snoop: Cleanup resources in stack-order
      soc: aspeed: lpc-snoop: Don't disable channels that aren't enabled

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)


