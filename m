Return-Path: <linux-aspeed+bounces-3035-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FE6D1266D
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Dec 2025 05:55:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dLn1M0HQrz2xQq;
	Wed, 03 Dec 2025 16:55:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764741334;
	cv=none; b=TnlqGY4Iu81kq7W9q+RcZt6dDk9paIgx1xhxwJPnqqTMbZebBgcIY/U/QiKIdNybjYDKqlvdMIS56mBRoo9hdOsdefzs4Yu7HrUnnKbLaWwYTsRuEN7kHof2/DwEU7OizMUTLZzvYb4gO8OtIVpsUK7p404ALyf85sbMky40Y+jgSx8SOvY7796BZqtqQTynJ5A6dLRAK2OjcvbEqWUX2uDVIVIf+9CotzGb3F4TwINS7fnA5B01gpTPwRVVOdg+RRMzgEch8C/0lAKNASKQZJIe3Q3zmMWlUfG5tAnx5NRxhYEcHiDTpb93HxOIxzNKmF56Vy05/G4f4jt6V0xLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764741334; c=relaxed/relaxed;
	bh=Zt1X1IcZPRAdEgh00iL8e6/dAz/J6p6qgR5VZMG7S4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V0UORLNC9Q70OXhRyC4vsO+fu8ZcFeHUWe0iRHNRc6/jCCo7gz0xQ4qqf/ly10BXKgl7HsPQFIG7OjnOeaaXXvK6PFJJlACGPTK7g9NXf12GHNRCMowKq5rxXh51bq9Bpc7ixTz5jvlN6ciaDV2gb8NdG+Zb/rhDEWLLUOsG8HSwzptzzAXX+oIKUJRu8dP+6FerN6dG4DLWANo6B/8cvIb3mD7Da/GpjpbLVAqE8jtoOn+qzf6dc7ycJV0pMzh4AJC3/XCdHqWzNCdVzyyKM/jgeqnWmqqTlydSpDlVdn/qP4ASe/Rgyks1xqnL0oxabZ1VC2/PtQTvf0fcsCdRMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Wuy1YbS0; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Wuy1YbS0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dLn1K5XLsz2xQ6
	for <linux-aspeed@lists.ozlabs.org>; Wed, 03 Dec 2025 16:55:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1764741331;
	bh=Zt1X1IcZPRAdEgh00iL8e6/dAz/J6p6qgR5VZMG7S4w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Wuy1YbS0Wa5ljm3DHFmlc6wSh1Mw9H59CYdGUMrhUfSqSXtQ26sbz9vuECfFgBW5g
	 qFXss1OOAQc4nKjr2VuU1G5KaLodBe2J5Rk7POyVMXMmjDRrl/BGJCw40eitHomkmz
	 tEQsvAVWA8WC36VVzCfWBTDBCLI2iJqw5wlKrPCPMKpEeCOrD80K0G3LPbyT14QfXV
	 mWFv3LBwDF0MF6JSNtctvhWKaB8C3QTbQuTvnocx1aPsNBs6IDae2AUnEKgYjjS22u
	 /irKXOvwFVkwP9inl2tyqZmRaZV3omq4Ou5AEo22mmOLbdI/51ofTykz30jxSDDy4X
	 Z5ja2MpHpnKIg==
Received: from [192.168.68.115] (unknown [180.150.112.216])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id F03137B6A2;
	Wed,  3 Dec 2025 13:55:30 +0800 (AWST)
Message-ID: <64349026443d6178487db34233d24478821a1ca1.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] dt: aspeed: clemente: move hdd_led to its own
 gpio-leds group
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: alex.ts.wang@fii-foxconn.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	george.kw.lee@fii-foxconn.com
Date: Wed, 03 Dec 2025 16:25:29 +1030
In-Reply-To: <20251127-leo-dts-add-shunt-resistor-v2-1-c77dfbfb826c@fii-foxconn.com>
References: 
	<20251127-leo-dts-add-shunt-resistor-v2-1-c77dfbfb826c@fii-foxconn.com>
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

On Thu, 2025-11-27 at 17:44 +0800, Alex Wang via B4 Relay wrote:
> From: Alex Wang <alex.ts.wang@fii-foxconn.com>
>=20
> The gpio-leds driver requires all GPIOs in a group to be available;
> if any GPIO in the group is not available the whole group will not be
> created. The hdd_led GPIO is only present after standby power is
> enabled, which can prevent other LEDs in the same group from being
> created and blocks properly setting 'bmc_ready_noled'.
>=20
> Move the 'hdd_led' node into a separate gpio-leds group so that other
> LEDs are not blocked and the 'bmc_ready_noled' flag can be set
> correctly.
>=20
> Signed-off-by: Alex Wang <alex.ts.wang@fii-foxconn.com>

I've applied this, however, I fixed the subject so it has the usual
'ARM: dts: aspeed:' prefix, and added the following Fixes tag:

Fixes: b5dd16228216 ("ARM: dts: aspeed: clemente: Add HDD LED GPIO")

Andrew

