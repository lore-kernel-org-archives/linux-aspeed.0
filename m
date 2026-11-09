Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0813606A320
	for <linux-aspeed@archiver.kernel.org>; Mon,  9 Nov 2026 02:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=DAcUw3xM
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jNDZD2xZJz2y8p;
	Mon, 09 Nov 2026 13:41:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794192100;
	cv=none; b=Wvw1PRcGnSdLMCp/E26yCAbiI69jgHXsn/i6S+ME49lDtjfN3dx9oAutAakzfmRp+umg4NjAhS+NCJnwHqiSkpJBT4//Q+BMSfeyTic/+4oAV2iDITVUTfN9dRprILxTu+GtNMCHsZYdCAii40kJuFvIo5CiQ2AA8gxODI7yHbtxmw7GjgFSWjTcCLeGZlp037Hi8ithMjFI4v/twUiuzLbJuSuwBmuphBk2Y/qJs/riENZ/qU9wQ0EeDzmRyTW0G5LzH1ZZeTyGsfy6btIHT39NSvL5DjH9WDC+5P1KkTGUD22gDCl1YaTonGDqhoY/7FvD2UlJ/OENSn2C4d9nJw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794192100; c=relaxed/relaxed;
	bh=OjFjDEv6r6cygeke1RGOx0xnQni07udazDvq2kGmw6Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PIR93F7ERptUO5/JfTGDeUwqtULv1Au80nLyu/qpzHSRYDrDyvUSFs7W3nrnRZdcicKtkjf2PiojYU0AfMDCibEn04muLsbHj1f5j4xfeKi85o8aiZ+6s6hCfQqVqO+DR0yW1f2yEjCS4bXnygeleVuXi1I65bbNvWsIhE18XanhqjKWPsQcZ2W826PJyCuDrKSAkPRjkn0mCX5DkLeAe9FhEzMkuy6QjYlQjZkWql2lglpLg+82SrOpiJM7EdWSH1ZZkDPE0Mu8u6R0fSTy7y0/qEmXIqvmI9UcvU2I7lciZBmY6RGiVDd3MisS2ZGIdR8lpj/neXXjHp9CmfN1xg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=DAcUw3xM; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=DAcUw3xM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jNDZB2Y8mz2xfK
	for <linux-aspeed@lists.ozlabs.org>; Mon, 09 Nov 2026 13:41:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1794192096;
	bh=OjFjDEv6r6cygeke1RGOx0xnQni07udazDvq2kGmw6Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=DAcUw3xMa4qeJC1vFRGVhhYj1tSb0WLQ9EQbRR5f/o0vdPPNqQcoYpE6ZxBhUNULY
	 5KF9zDQuoC3MtcxEayVxCfq1VRXVOQ0KjPMcz8+YhPW6Imo/0M8F4XV3irgDTvme+1
	 7rvC/x+hNTHcp27znFou+cqgG8H67smYgDZjU78Ru8Iwh+p66c9XP47tn7yTyJLsXG
	 Xfj1g+3owQrm6MHyrwM/9BvS7f1oqMQ/HtM7BsvyDNyNvcoxe8+rPZWIhzmwxhVxGH
	 H0qrLlvfZTgwu+4d1D/eAOv63vQNgL8gqIilCnN5c3r0j72WQrOlk+p+QZ3HxO/sUf
	 xHvau8a+rWNoQ==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id F2FBE64952;
	Mon,  9 Nov 2026 10:41:32 +0800 (AWST)
Message-ID: <245d0e9d4043c0957716a6a32985b6ea5a8cb9ef.camel@codeconstruct.com.au>
Subject: Re: [PATCH 0/3] ARM: dts: aspeed: ventura2: Add LTC2305 ADCs and
 GPIO line names
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
	 <billy_tsai@aspeedtech.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 13:11:31 +1030
In-Reply-To: <20261106-ventura2-dts-update-v1-0-b085ece9bf57@gmail.com>
References: <20261106-ventura2-dts-update-v1-0-b085ece9bf57@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 2026-11-06 at 11:08 +0800, Kyle Hsieh wrote:
> This series is a follow-up to the Ventura2 devicetree.
>=20
> Patch 1 describes the three LTC2305 ADCs fitted on Ventura2 and exposes
> the valve voltages read by the bus 3 ADCs through iio-hwmon.
>=20
> The LTC2305 ADCs use their internal 4.096V reference, so no vref-supply
> is described. Patch 1 therefore depends on "dt-bindings: iio: adc:
> ltc2497: Make vref-supply optional for LTC2305/LTC2309"; without it,
> dtbs_check reports a missing vref-supply for the LTC2305 nodes.

Can you provide a link to this patch? I am yet to find it on lore.

>=20
> Patch 2 names the presence detect GPIO of the optional COM Express
> module so userspace can determine whether the module is present.
>=20
> Patch 3 names the reset GPIOs of the three USB-to-UART bridges so
> userspace can reset the bridges.

This isn't so much a summary as something self-evident from looking at
the contained patches.

In my opinion what you write here should identify broad patterns across
the patch series (perhaps how you've grouped the patches and why, if
necessary) and not rehash the commit messages.

Andrew

