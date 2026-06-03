Return-Path: <linux-aspeed+bounces-4172-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53436CD6E4A
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Jun 2026 01:45:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVVrm4Mljz2xg3;
	Wed, 03 Jun 2026 11:45:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780451128;
	cv=none; b=YFVB2kgucIYP5HDCnLAQr5JaH3JuqVkKiY7msrocQAh1PYnNIL8WvJTNptOpxyjDQias/3bFTZCM0w9FzRrIfOe91ZAjvrBW2dKFsi3ekbh9vXrjuCrjZy/TPokYbSUfXXhS/lHxDBGmCIb0KYLyumTqnNeC4JbN2I1suAFfsPJOz7o6PlWkthy6J8ZY3Nlpn7UMXNgcn/8B5VJBglC7wauDf3flBqKaSZiUVN3VfshAComXXmw/MaL05YDdUjM/HmFvyKKHX2baas9+4OPfiMsxHPrd2y7LkahM0cayYuflY44cAefPpWeoAsRwaxZTFSH+PbGImF+Zgn4ilb5eKA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780451128; c=relaxed/relaxed;
	bh=6sNKaf6Emxid3ZVnRf3FrHFQvVHAGDbo00Rv0+jMbEM=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=GOAE4Eu6mv9LQ37/lLb0vBEgMY3fhUgO18feIXc6KCx0S06Qg3eOQc02kJ1vrPhUchMEK2M1C5vVgtUeCnOJ9ptG8a8u9Pz4RCepaqQ4H7cRjkwL7DW1hWCw5K9Tyj4M4M0K/ICnyC4+vUYUw+NjIBdlbEdA5p2tHjv+hyXVgrsTEtUbAS78EJuG7mbpEBVsZiqRr5hySIEeeMYnRiRo3cuX6Gu22Do+diGCWcpXJpJaGefqwUCJfKgL1SmHsZTvBWDpRbQJE5ex0Y1IY6lJvkfkmYWyJnTAX5vdWdP7vDgkH3t2RQ+grCrXbJ9+k7AklS3x51srIfGmVT7zEpF9EA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Pzsp8wid; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Pzsp8wid;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVVrl5z6Sz2xc2
	for <linux-aspeed@lists.ozlabs.org>; Wed, 03 Jun 2026 11:45:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1780451126;
	bh=6sNKaf6Emxid3ZVnRf3FrHFQvVHAGDbo00Rv0+jMbEM=;
	h=Subject:From:To:Cc:Date;
	b=Pzsp8widNNQW7lqYjOla9SV0FDAI+RLJyW+mVvMJR4Uqg8RR3xCb5tR/ehxAWXxhW
	 6CPj7Sz8sHE83Jc8qynufLBIG4JAk44kcJtAg68SDJnPV/B2IwL7s5ZcCv2y5r1ocU
	 LdjthGl3VI7blsWS8gJiC48QHG6NQAb7GXJ0dSANxhXjAxzvIAOaaddUU8ti2tTYSH
	 q0IUd3HvVe5fjzz4deqhllDjKgLVnJMtFVShHDe2QG+z5FKjy13tSh399hxRONzUqO
	 AL1ev+iZvi3fIZtXaKR/02pKI+ImwZiqd92b5zcRF3SpF4u6qtXryJFN6MqsDd5MiM
	 lEJkg7RMGrRcw==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1B9F66025D;
	Wed,  3 Jun 2026 09:45:25 +0800 (AWST)
Message-ID: <6b6b592163523beea48e875a047afc8b4bdbb00b.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: First batch of driver changes for v7.2
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Wed, 03 Jun 2026 11:15:25 +0930
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

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731=
:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-7.2-drivers-0

for you to fetch changes up to bc13f14f5cd3d15054de38dc1232b49343d36297:

  soc: aspeed: cleanup dead default for ASPEED_SOCINFO (2026-06-03 10:47:55=
 +0930)

----------------------------------------------------------------
aspeed: First batch of driver changes for v7.2

While bc13f14f5cd3 ("soc: aspeed: cleanup dead default for
ASPEED_SOCINFO") was committed just now it has been in -next for a while as
b333a0f1c857411d83a02aa6f1d9ecc7666d6179. The commit is fresh as I moved it
between branches.

Other than that it's just the one other patch from Krzysztof tidying up the
location of MODULE_DEVICE_TABLE().

----------------------------------------------------------------
Julian Braha (1):
      soc: aspeed: cleanup dead default for ASPEED_SOCINFO

Krzysztof Kozlowski (1):
      soc: aspeed: Move MODULE_DEVICE_TABLE next to the table itself

 drivers/soc/aspeed/Kconfig            | 1 -
 drivers/soc/aspeed/aspeed-lpc-ctrl.c  | 2 +-
 drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 +-
 drivers/soc/aspeed/aspeed-p2a-ctrl.c  | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)


