Return-Path: <linux-aspeed+bounces-1675-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A59EC83F10
	for <linux-aspeed@archiver.kernel.org>; Thu, 10 Jul 2025 02:54:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bczvF3BlZz30MY;
	Thu, 10 Jul 2025 12:54:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752116041;
	cv=none; b=GQAFgIdfjJBjglCnHM/5aqDQBD4m1B+Gt09A88q7yGsZ2osf8QX4a4BpaAa/qdFlZfgB9GuX9KMvTzBzPO3juXqj2n8iw2KjfIBGo8NIUlbENu5bBD49WVAM3szb68V/aYABUTzPGyi8/1rtzaUyVk/r5IJZhq1WIVrbhZLHGWxdy1nx+km4f40kjws6tKUaCkjVNvWk1uXmYU0CtuXGX0CoM9hNFrEevf4VJzaDqzhlXvuwt2ORiEUqpQnUEqyPY5WihnmwUeHnASNfUV7uWcYvC/j9YvfPNFSS8zA2Mphlq2qmk51G1YSZpnvMJlW8NvZAOjFu5HTb4ZVtbYLbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752116041; c=relaxed/relaxed;
	bh=8dzREoZ/WsyaHQKz6zD+3j3tk+9rN2BHKiKlFhHQROA=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=bPKrQmTP8/FtH8jneEeYrGeoktEDTfJSCEfoUlgSSprGLrNyZCtDwK0Ut9sPYois1frPa0YbQmD2Y6ec/of+Wu4x8gFaoy1shogQWVNQbnCtMe1MOTIh7Yoi0A7aRh0zSC0w9TiCB1r0yixzD4byWI+6dLxLShlH5hD85lb1NoogrCmAutbflVRVNAvNWdkZKBj27rMNJzK0n0fK9n6YadUV1Z1rwpRqa1xSVTxUAe+KGm4QDIl1TgIc02DRPENGs1A43Wd7Zc2B3zCkTTiWqZk3xRbI+Y3bgAee8l8sPsMwBnrQgrcc8jsGu5hlLEGLPLY8S3aD3GlaM4F0dXhyxA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bjicqfx2; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=bjicqfx2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bczvD5lD7z2yhX
	for <linux-aspeed@lists.ozlabs.org>; Thu, 10 Jul 2025 12:54:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752116040;
	bh=8dzREoZ/WsyaHQKz6zD+3j3tk+9rN2BHKiKlFhHQROA=;
	h=Subject:From:To:Cc:Date;
	b=bjicqfx2rgywaAX0RM2JysJJTO3TVqwRoCaMymwSQcoJL5VujZkVZM+TNowxxjUuo
	 v6BuM6P+Px0ibNyrm/wG0mfebevRTIvUApMST7bTO7upckx19xnc594OiAHYPXRdht
	 zJuS+zk31AZxWUbG7Y3qnapLI4xjSUyN8RJnypB8GRfkrVDu5LrLqxTaVkCVLKbnaG
	 vb2SntBDI9QjLtYdlhjT9QANxeVgLG2Tx00M0DBy98Vdtf269dwFjJlFliiDsDGPDU
	 z6dDpDjnhPnpMVSDlrA9fVdcvq5QDVMxQccQNN+FgSiPPny1CFPlHPpRzB3VtCGPrp
	 NSCBI15IteGPg==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id D2D856508A;
	Thu, 10 Jul 2025 10:53:59 +0800 (AWST)
Message-ID: <9123f151280e52c63dcb645cb07d4eee3462c067.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: drivers changes for 6.17
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-aspeed
 <linux-aspeed@lists.ozlabs.org>, linux-kernel
 <linux-kernel@vger.kernel.org>,  Joel Stanley <joel@jms.id.au>
Date: Thu, 10 Jul 2025 12:23:59 +0930
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

I've done further rework to the ASPEED LPC snoop driver in addition to
the immediate fixes found in the PR at [1]. The commits in the tag for
this PR build directly on top, so those from [1] are also listed in the
shortlog relative to v6.16-rc1.

[1]: https://lore.kernel.org/all/d119a7b44b25a1e55a710adec7fce3e9a9fc898e.c=
amel@codeconstruct.com.au/

Let me know if I should arrange the changes (or the PR description) in
some other way.

Cheers,

Andrew

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494=
:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-6.17-drivers-1

for you to fetch changes up to fdf003f30b99e232cd3e61cc42d836ed14d08ccb:

  soc: aspeed: lpc-snoop: Lift channel config to const structs (2025-07-08 =
11:35:07 +0930)

----------------------------------------------------------------
ASPEED SoC driver updates for 6.17

The ASPEED LPC snoop driver was recently the cause of some concern. In addi=
tion
to the initial fixes, the channel configuration paths are refactored to imp=
rove
robustness against errors.

----------------------------------------------------------------
Andrew Jeffery (10):
      soc: aspeed: lpc-snoop: Cleanup resources in stack-order
      soc: aspeed: lpc-snoop: Don't disable channels that aren't enabled
      soc: aspeed: lpc-snoop: Ensure model_data is valid
      soc: aspeed: lpc-snoop: Constrain parameters in channel paths
      soc: aspeed: lpc-snoop: Rename 'channel' to 'index' in channel paths
      soc: aspeed: lpc-snoop: Rearrange channel paths
      soc: aspeed: lpc-snoop: Switch to devm_clk_get_enabled()
      soc: aspeed: lpc-snoop: Use dev_err_probe() where possible
      soc: aspeed: lpc-snoop: Consolidate channel initialisation
      soc: aspeed: lpc-snoop: Lift channel config to const structs

 drivers/soc/aspeed/aspeed-lpc-snoop.c | 224 ++++++++++++++++++++++++++++++=
++++++++++++++++++++++++++-------------------------------------------------=
--------
 1 file changed, 110 insertions(+), 114 deletions(-)



