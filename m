Return-Path: <linux-aspeed+bounces-2044-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516EECA0EFF
	for <linux-aspeed@archiver.kernel.org>; Mon, 25 Aug 2025 01:49:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c9DHD3QXNz3blg;
	Mon, 25 Aug 2025 11:49:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756086552;
	cv=none; b=Uoy1qE4DornTODedj/4FmBIOOMPZjYLZyY24JQGhtZCNGSuH00X+iOJzql+rgvKR0NWdE+Zpb/D9wrXVH2Pz50ErvFjtBSxbhDuupAGuh5nkezZCoI9SkNfTrSDmyuyfO3Z3r33CByFUuc4pWFsHh76qffsXUleXcfrbSajXHHz6U0duE4zxtnPc4lDi9Oh+mLruVnvfO3tNARwseCkmWxTKDCuYVcQULT/5NrHOPbdGniy1L/SV6GJbcNicLhgBVjlJ9ewBKeNlou+X5aImSL5Fvsk/RT8pQx8ZRk3ktfvlMpAm2hbXyNq5WgCiCgGH2ATPiAdoY78OiI17X7b7og==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756086552; c=relaxed/relaxed;
	bh=wgnOb3qWz6wBb9vyKuCsG5rQeCBlBsWJND+E1w6iSmU=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Mx54iIYz35vBzaUz4gU6Z6uBzNzgd76zlJg5I7nHJgmd+ygvNPrRGkfnTNpPMEW0WKkTFWZZ014LCrcqvwRwE5b0I9iaQqaNERElfeUGHq97KYxhnLgIoVdM+EyT2mqUXIUpHyn7qodSmnTedt4oraTcf3ipAfAlX7jE9mLBnknjcTJW1UtB7T2swt4i2oTPBMMt/sx7NfOF8a73KgfeP6NwXRWHYrvZ8Z1zkqdl0WZHmOfAoWyjymkNqTzfh0RT+hT6zeoyOfpcbULxM8dxPkNzYJh6Ak35sD3EIygcclg15mGfgT4R0z9YUJ4tbRhgQYtSCoIRpaRMGvpxEJWKAg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=BwNiLTp9; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=BwNiLTp9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c9DHD0NJkz2xc8
	for <linux-aspeed@lists.ozlabs.org>; Mon, 25 Aug 2025 11:49:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756086551;
	bh=wgnOb3qWz6wBb9vyKuCsG5rQeCBlBsWJND+E1w6iSmU=;
	h=Subject:From:To:Cc:Date;
	b=BwNiLTp9/zW5Dlir+EesRuR54/NgyA3gVrB1YA7dvgsvYUnl8rRHS7ScuKlRNlItE
	 MhTgoFefOXbypEA4vR1CT/V0IqLTcLi+ljrRV8fvGKxCgYLETfHSRQSXSOGqq+d+Aq
	 184CDgl4BwsximKIqixoYTEH+t5iyYDuwIQiKllcS+xr6gulQgmBo+6BQfP9nRbv5/
	 qMbjPlLY1xuL9iSO5Bs/2/g2N7rTLvtLp4Gh7EfgOcl5y8XQlnQrKRB1YKXKCoT6kk
	 fa5rkcyjhy0KuuXdPiLHXtryJbqan0qASeR/bPgjgjPi3qUOQ6SfsljO62UMKI7LTc
	 9f5R5fbWaFdlw==
Received: from [192.168.68.112] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 1BF056443C;
	Mon, 25 Aug 2025 09:49:11 +0800 (AWST)
Message-ID: <5e7e5d2cedb3bb232420ad720c857b95d8c02f21.camel@codeconstruct.com.au>
Subject: [GIT PULL] nuvoton: early devicetree changes for 6.18
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: soc <soc@lists.linux.dev>
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>
Date: Mon, 25 Aug 2025 11:19:10 +0930
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
n-arm-6.18-devicetree-0

for you to fetch changes up to 7686b441c0ad921211b0a69977bad746d18e4b33:

  ARM: dts: nuvoton: Use generic "ethernet" as node name (2025-08-11 09:38:=
03 +0930)

----------------------------------------------------------------
Early Nuvoton ARM devicetree updates for 6.18

So far we have just the one fix from Krzysztof that switches some nodes to =
use
generic names, as recommended by the spec.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: dts: nuvoton: Use generic "ethernet" as node name

 arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 2 +-
 arch/arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)


