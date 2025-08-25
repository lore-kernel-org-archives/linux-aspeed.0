Return-Path: <linux-aspeed+bounces-2043-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B91CA0EFF
	for <linux-aspeed@archiver.kernel.org>; Mon, 25 Aug 2025 01:36:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9D0P0Lk4z3blg;
	Mon, 25 Aug 2025 11:36:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756085780;
	cv=none; b=Vx5gMjvv+dpLYosIiTquGNuMyJ8/l5s3wSIyDRyvLFmQG9hrWpQinI4Bp+JRxs8U4JQEOofIUWot/rcmoOc47ggoKWws2Sox9gwUN3VELsa2pOH6b+Oi1nn7Esv9gy1rBfXBVB1UK/O5rfqQKuZSuKItVeweowgbGWYQffYHljybQj/1MzXWzXpmW1pSQfHzCBnmzGRxonagtwKauoZaW8d0g9z8y81rd3RM9KaBaL50KBWobAQ5gRreWgRcwMU/C+UbtfNEdWWQIPWzapYleu/T4sAXC+hZhXZ/ipC9oF34zW0oBQYnxLGAIVL+EHPh20eqkBdVnWtazB9XcmGh2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756085780; c=relaxed/relaxed;
	bh=4788WmMOb8QcQZCKza1zlDpD6qQhfOULV+R7eq25UYE=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=WyutW8cr2zH7kFtubClbroqlCNDObGuHR6qEOBO3MlS2yoQ//5Zrda09AhDyJ2CojYwbslFXmrBkQw8i7MrPcudPzEw0LqDpZF4LjSg9x8PSZGIhR9qR9NG1l/JRlSMoN0GAI1W4nYlz8TiqjwDxhvTQNeAnw+wuMayLcPJXZ2PlFzfV+q9PdFHMtyOqyHXsVQho4JvKtLSQQQHYoPe/eHKwtAe+v3r3rB8xWI0IXysqCIV28KNZWm+LhdCVandSd9r6IuNlutbnt7EvoOBQei+ZWVAZSc2kLHz9o5TKlkAfWTP2wKP9+IwwO4tktBP+dXzlULuxyt/rnWFSVB1DbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=hYDQYF7I; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=hYDQYF7I;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9D0N417Qz3bcj
	for <linux-aspeed@lists.ozlabs.org>; Mon, 25 Aug 2025 11:36:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756085780;
	bh=4788WmMOb8QcQZCKza1zlDpD6qQhfOULV+R7eq25UYE=;
	h=Subject:From:To:Cc:Date;
	b=hYDQYF7ICrPQbbVsQ9aGIrolwpB1J3Xl7bPdu3NyuDciq9+EM38ftWyhio1x04cJR
	 l10v8DPXE3dwOsJVLgYzpCaS/0QhKlpj1ZkX8ydz/89wJ5mLmWEExbZudHAf/mjZE5
	 yxPCl7gn7ruTzxoRtVfORyVa4ete4LN6Amw3kuEnS0QTFz38c6JHcYa6xdismMexyc
	 3wn22phg3f22RIhMQSVQW87dmNmu8V3FbOdMe+TEsc/AhHtbBDS6hIFOk3LJXDe3PF
	 zuYm9BPlJBE3w7gYVxjrJTwnAiTJD/muy1kJbz9OVfznWS9iK91Mq786Ke9RlORuur
	 u8oGISEBNos1Q==
Received: from [192.168.68.112] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9E95964C1A;
	Mon, 25 Aug 2025 09:36:19 +0800 (AWST)
Message-ID: <2d122b5c4a19261148993b66e4b98371a684ba74.camel@codeconstruct.com.au>
Subject: [GIT PULL] aspeed: early driver changes for 6.18
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Mon, 25 Aug 2025 11:06:19 +0930
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

  https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git tags/aspeed=
-6.18-drivers-0

for you to fetch changes up to c30dcfd4b5a0f0e3fe7138bf287f6de6b1b00278:

  soc: aspeed: socinfo: Add AST27xx silicon IDs (2025-08-11 09:37:53 +0930)

----------------------------------------------------------------
Early ASPEED driver updates for 6.18

Two small changes, the most interesting being the addition of the silicon I=
Ds
for ASPEED's AST2700 SoC family.

----------------------------------------------------------------
Rob Herring (Arm) (1):
      soc: aspeed: Use of_reserved_mem_region_to_resource() for "memory-reg=
ion"

Ryan Chen (1):
      soc: aspeed: socinfo: Add AST27xx silicon IDs

 drivers/soc/aspeed/aspeed-lpc-ctrl.c | 14 +++-----------
 drivers/soc/aspeed/aspeed-p2a-ctrl.c | 14 +++-----------
 drivers/soc/aspeed/aspeed-socinfo.c  |  4 ++++
 3 files changed, 10 insertions(+), 22 deletions(-)


