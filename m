Return-Path: <linux-aspeed+bounces-1933-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C63AC87FCA
	for <linux-aspeed@archiver.kernel.org>; Fri,  8 Aug 2025 01:43:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bymyV417sz30WY;
	Fri,  8 Aug 2025 11:43:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754617410;
	cv=none; b=fmt6vE8VXmzjC8PlfC0Us0oJJw1Rq05wo84+hcu4srzJU5su+tZ8Wf6pm9kenbkCHp1ATNFCSopBQ1Cvt35PayjPupIu4oIqpxPyqbR1k7whGP6DrbDH+Y3e12X0KAnDDICEOpkKMojmi9GIFMdGqkqZwFTQ5r4sEmtL6fkeUwv59Ugn7zEdFk7OkOxO034ImA6yh78Dnw4N2Wkey5AgcrTB8GcQoePo4VEpE//bsUv2bV6aUOzFFOq0e92lH1rc3Ypm4vrYAHquEipRWDzVJQnmKhDvBIuioGLF/Yrre1zw3VyuVpzCDtvH42LqwB4Qlc9HeEKSdkxWB/F3GLriPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754617410; c=relaxed/relaxed;
	bh=Ts1zobpCK/euzxoCBpLogZaK0KIVWRAOk6N20EwhcMI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mnf4krfSXGj9s+EiEzlGngTq818BSHi4pQIU38/VL0m7pb8Vdr6EUQ2SRPO4ePytKQpRcnOkOHPEAHqnDXKPa9kBAhm3vWkd/jV5UIDWc+S29KL+5awUyYTGIqWoNNDTulKAXbCFrTD1vmdrJ4QPIlxIVorZNFMI3ZLijvg03fVL3b/4gNUY6SGO5A/Pb+OfGf1j9x7cUYSp14xVaj+XEEoyk4QtKkkQjaqEuTBKRqtQjyIEIDAC1vpjYLOMUSY9NXWyBV/eppMjkbE7cswGGXZzhl2NEms7CNBIxFZzdIdiLUJENLr2JYCET9QfJ0/vfobKS4vz1aYnZ9+SSJ+USg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=FHNEVcw7; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=FHNEVcw7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bymyT1qfLz30Vl
	for <linux-aspeed@lists.ozlabs.org>; Fri,  8 Aug 2025 11:43:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1754617407;
	bh=Ts1zobpCK/euzxoCBpLogZaK0KIVWRAOk6N20EwhcMI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FHNEVcw7jWORt5mo5EgNeEBRd3dIcoL/5kB5U83zUl1HwD6KeiVLYcBokMPbHCaRg
	 6ou1vmExWaWE4rBAJGHNlNxdP3/FMMFy90TxLwoalnTh6qt5N5xhvfW772Dm9NGC9d
	 LUBTPFp8nDLlQHHPmoJM6lu+4PIc3rxgXNdLYBdqWwaUEtNqZ5Qo3eVBeffXksgC3F
	 0Z2/E8U0GKsbHniDdgYZF/c7JarjK8Tjz6YjeeEOiJ8RpiJRu2c+un7bYjU2vKKh+j
	 pEgcpXsLnrXnhuezZEdoX5wCWvLrAPO1L03W15Rq/jxkmRhcasVvZp19MKTZiLKvHc
	 +iHss2W0MA6DA==
Received: from [192.168.68.112] (unknown [180.150.112.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8234A6AF39;
	Fri,  8 Aug 2025 09:43:22 +0800 (AWST)
Message-ID: <f1aaeb371eb0c753e6ace45e5e1ce5ccd73a0f76.camel@codeconstruct.com.au>
Subject: Re: [PATCH v10 0/3] ARM: dts: Add support for Meta Clemente BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Leo Wang <leo.jt.wang@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Kees Cook
 <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,  "Guilherme G. Piccoli"
 <gpiccoli@igalia.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus
 Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	leo.jt.wang@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
	bruce.jy.hung@fii-foxconn.com, Conor Dooley <conor.dooley@microchip.com>
Date: Fri, 08 Aug 2025 11:13:21 +0930
In-Reply-To: <20250801-add-support-for-meta-clemente-bmc-v10-0-c1c27082583d@fii-foxconn.com>
References: 
	<20250801-add-support-for-meta-clemente-bmc-v10-0-c1c27082583d@fii-foxconn.com>
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

Hi Leo,

On Fri, 2025-08-01 at 16:22 +0800, Leo Wang wrote:
> This series adds initial support for the Meta Clemente BMC based on
> the
> ASPEED AST2600 SoC.
>=20
> Patch 1 documents the compatible string.
> Patch 2 adds the device tree for the board.

There are now three patches :)

However, the main concern is that these do not apply without fuzz.

Can you please rebase them on the following branch and re-send?

https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git aspeed/dt

Thanks,

Andrew

