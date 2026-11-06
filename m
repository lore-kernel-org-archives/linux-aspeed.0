Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E4A606A326
	for <linux-aspeed@archiver.kernel.org>; Fri,  6 Nov 2026 05:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=G64l78gU
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jLS8q5wKqz2xHG;
	Fri, 06 Nov 2026 16:16:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793942219;
	cv=none; b=eGCiD0nYqp5fp85rzUy/ussSvzduAmZPKITool4Dw4XcWZy6ctgbL/60LnjAieVNRz1eLivscUrgij2qEoOPaeHKbMT6F3h2LsUF1dJX992RLS8jGj8ohbq4Qgi63wikFzt/qvhV9BenLzuIYWJ0VarR1FQtKC2SJaIgHClHFVINVd6J74K24xuSxZPgJpj5XoVLfaSbGZnhk0dSjprDE6L8g9Ym7tsoXuSSHQUs3RC9dMzYmIoObL9sjbOt4fDV7kpIRf3qZmlBDXkfjvKKw8oIqjfiz5hBGvpy7EM6JFdsGSxMmMf5krw9jW9KFMdKyZz3ABr2SaIgcgl3PTwyFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793942219; c=relaxed/relaxed;
	bh=7nQnjeigU0D/Ve61Bm64NyUI5X1+1HOvlN3FLT7eQws=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZAHT4UyjFCiR8S9/YZJkLXjNU55HwLgdRxQn9AyGuYK1BA0IPxpyG/imHO5sn/5DUDxYx7nomIC5/thpfUwtisgkg0wJrtipQWMW65dmNyVD+Nj5lxDPc57CRxAnoZHDUJ8+LyF02W8CCGOwXuhUs9FsNwqU9IHl4ZhGYJV4TH2tpfVN7SH9Ms77tXbInmbLEnsLKxWBapO9KOJ2gGFpcKn8P+jL0fn5U3g8enAbD5V4k0zBCNsgbUNNgTCYVM0memNw1Tm/Nk08torK1jPkHDiksfvqUv/0t5bwXX4YB6MN4HdfOC7/JTWuZXB3cnNv9j4LYCieNli1rwwmIbaT8g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=G64l78gU; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=G64l78gU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jLS8q1yTvz2xB1
	for <linux-aspeed@lists.ozlabs.org>; Fri, 06 Nov 2026 16:16:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793942218;
	bh=7nQnjeigU0D/Ve61Bm64NyUI5X1+1HOvlN3FLT7eQws=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G64l78gUR0IAlLTqhtV55R1Lb0orlCMZJq0U09Smi0VvQzm6H0sg0MuO+0ZDbw0Bh
	 68LLXZ6W9vlek5PSzEXG4YuQERv7CSRERiZnqQmyn5dAVrRVQeaefh9e4zYqJDzMgW
	 Mopav8bnBAWo71A7hDm0/39v4Wmdp94SWcYIuCWpb78GyL2NXJ2lrSan0fl0D7GPBg
	 l5bbr/nRNFN2gRPR2s58wf0Y7R9u0gr7kara2GOhoGRN0pRAh66T2Eo4LBsXnG/w2p
	 7pLFDrkzQL5xbg4Z9urIbaGcaUwPSGFrQF12jZxjcCbOvOrUqsrXmxRCKZ53be2KMp
	 6Hh5+nWNR8GnQ==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 773437127A;
	Fri,  6 Nov 2026 13:16:57 +0800 (AWST)
Message-ID: <4d149414902c2e7d2d8cbfb2cf741f6e6b21add0.camel@codeconstruct.com.au>
Subject: Re: [PATCH] ARM: dts: aspeed: yosemite4: Remove Floating Falls
 board nodes
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: eric.yang.wiwynn@gmail.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel
 Stanley <joel@jms.id.au>,  Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai
 <billy_tsai@aspeedtech.com>, patrick@stwcx.xyz
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Sean He
	 <sean.he.wiwynn@gmail.com>
Date: Fri, 06 Nov 2026 15:46:57 +1030
In-Reply-To: <20261105-yv4-remove-ff-nodes-v1-1-aa707a9577b7@gmail.com>
References: <20261105-yv4-remove-ff-nodes-v1-1-aa707a9577b7@gmail.com>
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-05 at 09:49 +0000, Eric Yang via B4 Relay wrote:
> From: Sean He <sean.he.wiwynn@gmail.com>
>=20
> The Floating Falls (FF) board carries a pca9537 GPIO expander at address
> 0x49 and a FRU EEPROM at address 0x50 on each slot I2C bus.=C2=A0
>=20

So the expander and EEPROM are on a pluggable board?

> FF was
> planned in the early Yosemite 4 design but has not been used since the
> DVT stage,
>=20

That indicates they were used at some point, and the design has
evolved. Which "stage" does the devicetree currently represent?

Have you seen this discussion:

https://lore.kernel.org/all/d7794f74b26bbc1ee0a70e39c5671acc018f80eb.camel@=
codeconstruct.com.au/

>  so these addresses never acknowledge. The pca953x driver
> fails to probe all eight pca9537 nodes on every boot, and the at24
> driver does not bind to the eight EEPROM nodes either. Remove the nodes
> for both devices.
>=20
> Signed-off-by: Sean He <sean.he.wiwynn@gmail.com>
> Signed-off-by: Eric Yang <eric.yang.wiwynn@gmail.com>
> ---
> The changelog was drafted with an AI assistant (Claude Code) and
> reviewed by the submitter.
>=20
> Tested on two Yosemite 4 BMCs, baseline vs patched image: the eight
> pca9537 nodes and the sixteen 0x49/0x50 slot-bus clients are gone, while
> the 0x51/0x54 clients, gpio chips and FRU objects are unchanged.
> CHECK_DTBS=3Dy W=3D1 shows no new warnings and the DTB diff is exactly th=
e
> sixteen removed nodes.

This kind of verification isn't terribly useful? Are we trying to prove
that dtc has correctly translated the dts? This reads like it's AI
fluff and is better left out.

Andrew

