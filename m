Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19C3606A31B
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Nov 2026 04:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Bk8cTMk/
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLRLH3H3Mz2xH7;
	Fri, 06 Nov 2026 15:40:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793940007;
	cv=none; b=WKtcTjETDbpCKbn16dBs/Xbs+D7+QPnhK+Q1Za8DgaeZStyVTkU223Pc9e9LNmJa8Bs4WIzGxUDlsHT3Szp5VzJlLkH+QgD6a3GAZPky/6iiGPazZ+O2LzvN6fbhQyUoBFvLttIpJvBsu3yV91q2bWRoVp0fmeYJKzQyY7C+Efm4QYNiJSRAL7rTMWaaU4num8wK4mZ8G0NcBbaNKZqgEXH1GjB295yJCRnNBHWpl+HgmqHkToP4O89LdbrSx/B+cWHImbF+xZ4WfWE1OIwwKcUAIinrHWeAbzaqdrRuMUwKNoopgdUzK19hrRcM1vYpKVlyqjWaqiFeHTouxpNyAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793940007; c=relaxed/relaxed;
	bh=pgE10eCMCTY/ZcVx7ek1lDVXJ0ro/xZZDrYhv8RrKbQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VCgm2bp53dbq8f5rSJgalsI8PMPQcfV82IcKhMUgtgMqvrNtRReo7D29nHhpKlCWnTruyc82MUoV61orgsZV1fO1AYuSeAruijZ3+DBFiv431HDjDUsCnRO2dRm8UO5bQD2tCOl6fj4e189ZbDNf6TXkCO8R2biBJM1A0sjcHNdhq1tuXBs2uuLnCeAvjOe2NnlXRdJCIkSYdDc1yK9LxLtFrfYE8g1dDBBtlIYa6KGdIXPmJBHzJ43dJv7LUfvK+kEhl9xP8okPTARJ4/Xncpl9Xmfz7dBnmKZW9L3XU2dJKCPPfxFpnEm1k5e4QgtaQgeNiZ/HUC1+rb8prK7/ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Bk8cTMk/; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Bk8cTMk/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLRLG40zVz2xDD
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 15:40:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793940004;
	bh=pgE10eCMCTY/ZcVx7ek1lDVXJ0ro/xZZDrYhv8RrKbQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Bk8cTMk/fNQGf1WV2bC9cjno9nlavkIUND5zvDV1Piiwz1bSFM2pjubO2ka40IVE2
	 Tbzh+Fu2D0O+T05AfWjADO5pT3gjwTKECtiKDvHCHgSLOa9zQReHwLFPXMrCj0lGnI
	 u9Rb9I/ay++2itl/y+LxMgZrst7bpuJI4AsgTgySwh/Q7yBzusCVYBmbuuUHZz7R2r
	 jIb5Y+PcaPlSPu6+mSBBt2MJ8Ld+LJzfrK+Kv/2PVGTNfr931iG2hJ8ZXOd/Z+Iqtb
	 6rb4XaJsVpru1GxcBh2ruOlEobO23x6N3vvQtCQqE0JQoednRHYKe8rDL6SfeJLPkS
	 FCo4nwCK82swg==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A250C64952;
	Fri,  6 Nov 2026 12:40:01 +0800 (AWST)
Message-ID: <d7a1f55d822af84b00591a57d2bbc1541c184412.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 0/3] arm: dts: aspeed: add Intel AVCRP and JNCRP BMC
 platforms
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Dawid Glazik <dawid.glazik@linux.intel.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	maciej.lawniczak@intel.com
Date: Fri, 06 Nov 2026 15:10:00 +1030
In-Reply-To: <cover.1792749922.git.dawid.glazik@linux.intel.com>
References: <cover.1792749922.git.dawid.glazik@linux.intel.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-10-26 at 17:40 +0100, Dawid Glazik wrote:
> This series adds initial upstream support for the Intel AVCRP and JNCRP
> BMC platforms based on the ASPEED AST2600.
>=20
> The first patch adds the board compatibles to the ASPEED binding. The
> remaining two patches add the board DTS files and register them in the
> ASPEED DTB build list.
>=20
> Changes in v4:
> =C2=A0 - Rebased onto aspeed/arm/dt of bmc/linux.git. No other changes.
>=20
> Dawid Glazik (3):
> =C2=A0 dt-bindings: arm: aspeed: Add Intel AVCRP and JNCRP boards
> =C2=A0 ARM: dts: aspeed: add Intel AVCRP BMC
> =C2=A0 ARM: dts: aspeed: add Intel JNCRP BMC

Bit of a nitpick, however, I have other requests on the relevant
patches:

For both of the latter commits, can you please capitalise the first
word after the prefix list (in this case, 'Add')?

Andrew

