Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88848606A329
	for <linux-aspeed@archiver.kernel.org>; Sun, 15 Nov 2026 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=mJ5C3PhF
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jSRh46Zf2z2xnn;
	Mon, 16 Nov 2026 10:16:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794784580;
	cv=none; b=mP6INKfhIXJX6Lrpg8D3VATsXk7D2MxHruOtCXY2E8Caiswycefoa0aivJBSeXEuMtENbIb46EzPU7gvJt824l/HQsdA+L/FTVQgAB31VQdHdO66KQv68fzCW3YFnKDS9vV/v4Znr5JLNkv1RlRfUefecnxUBiU1QLuD0uxIa5xJcycSzqrTvlUoKkm04gCJ/t0XcyYOJHMXK7rkNz0ISz6i85J+U74HqrywLMDNheUU3EVJwubKN3zTQwNUHgQX8hMw51+eHnQJ2c0FC+nkwjoCB/3oAdHGMrl9MnbayFUnVSatj28uGMklJjECjJ5uVGwJKHCvNqFtjHu2ZoHnxA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794784580; c=relaxed/relaxed;
	bh=6fWr66mLdGMUcPCfj2lY5yCay2OcZCA9qUhBwidyWNs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K/3qz8hG7mjeot3+bw/kG2wpArhLBHd+XOh8awRd3UKfiKMcpcyFkAPWL45FOUsj4WC1f+Lq0Mzd0u9SYSwr5lC0OB6aTJFzAK3x3T4veXIJ1yg45Ah1xcKM/mMNvTw7bd8zT32KrWojUMssgU0KYsRiqnDqDlWVV8HPjg7sY2QMaUmFWy6bDeP9Ti/iOdq8TNdWeSsiVIcoam/XditVXfaWhd0EhgHTaS4ERLC959bmjP++8dEDnz8ShQh9n6y8aJDdYkiPKdGJatLghO1d6kZUHqktrKtABobw4x/hOnZ/SVymGmgMosr9TRMJ9tQ9NoesTSWXXFgFEbVWF/mtDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=mJ5C3PhF; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=mJ5C3PhF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jSRh31gf9z2xnW;
	Mon, 16 Nov 2026 10:16:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1794784577;
	bh=6fWr66mLdGMUcPCfj2lY5yCay2OcZCA9qUhBwidyWNs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mJ5C3PhF3Ubvh+ERFg1RVv+/p8e/beY7R3lbHUreYXp2Ks5lkZG5P2Yqau+Znd1Tc
	 GSloz2NUdiHQmdyFMwVG/C5auPC38/cujdEB+dH9CPMATkceOmGPrMUx8mTxAepKCr
	 aQaHSdgkr+CnoX+jJ6+0JQZbSqGQxjndWCTlZbNT75/H8e93b3xeyk3jrgxBzJaJrJ
	 yRrqRfoMNBh8aljOnF2WLCSZnbap3NrGAzMYCEAM1rwvl+wblKQLPZxAmRhbzgVx1Z
	 YkyvYTb7T4UnCA2yAb3J307fhqKhhAo4KFQtQSQuwljM0rnIRRKIzOumV24fEmxHX5
	 uDu+AuK1fCjiA==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 713FC6005F;
	Mon, 16 Nov 2026 07:16:15 +0800 (AWST)
Message-ID: <91dd4caa78cff5961b5617958f4f7985ff55724c.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 2/2] ARM: dts: aspeed: Add NVIDIA MGX Vera C2 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jacky Huang <jackyhuang@nvidia.com>
Cc: joel@jms.id.au, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, 	ryan_chen@aspeedtech.com, billy_tsai@aspeedtech.com,
 devicetree@vger.kernel.org, 	linux-aspeed@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, 	linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org
Date: Mon, 16 Nov 2026 09:46:14 +1030
In-Reply-To: <179455982636.2173009.10261089569510079520@nvidia.com>
References: 
	<91edc3ed1d65a6765530895c6574714bfd76b8d0.camel@codeconstruct.com.au>
	  <179438627442.2016371.12057101111349178921@nvidia.com>
	  <42bb0b817905637239c16b94a562254cd0e6a644.camel@codeconstruct.com.au>
	 <179455982636.2173009.10261089569510079520@nvidia.com>
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

On Fri, 2026-11-13 at 16:57 +0800, Jacky Huang wrote:
> Hi Andrew,
>=20
> Thanks for clarifying. My previous description did not explain the
> purpose of the platform. I would like to include the following
> description in the v3 commit message:
>=20
> NVIDIA MGX Vera C2 is a dual-socket, air-cooled 2U server reference
> platform based on NVIDIA Vera CPUs. It provides a reference design
> for partners to build and customize Vera-based servers using the
> MGX modular architecture.
>=20
> I will also include the following public links covering the MGX
> architecture and Vera CPU:
>=20
> https://www.nvidia.com/en-us/data-center/products/mgx/
> https://www.nvidia.com/en-us/data-center/vera-cpu/
>=20
> Hope this can help others better understand the role NVIDIA envisions
> for this platform.

Yes, thanks for the extra details.

Andrew

