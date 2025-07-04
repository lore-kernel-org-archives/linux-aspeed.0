Return-Path: <linux-aspeed+bounces-1629-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7201AC83F03
	for <linux-aspeed@archiver.kernel.org>; Fri,  4 Jul 2025 00:11:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bYDZz0n8Xz2yFQ;
	Fri,  4 Jul 2025 10:11:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751587915;
	cv=none; b=HcR2Uq+KR+CRSJwO54NYoSzsY6+QhR1LYaDrdZQEFZQKeFJmKvH5YPSreP8Cta2sdyetIvYWrZyPvUPb0XH0BUtM/TWxojtI87d4KwCdSzECzIMHDjfOnHWkR2+NS1dgBb/gHRHwNBt4iXWT0zwkBLSk2VAXVQ++cCMupVEViKelrrAoA14qxXEOFg6OIZudhDCUurwepqYqiBJ/C5l5gcrbn2DmMnx35lGxqx2TVZj8vx3YecZ9u8WmfeoWjy7ohiBHl/ON9nZt6M8Tsv1VzAWYhAw0KqEdfh99U5t2U8Cxjoo4dQL6gewtu40G576YD8/aYxqU8qEMb7Ob5y3Qdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751587915; c=relaxed/relaxed;
	bh=vRae16FTMewFnY4A+z3eMOBzVPHBvIAgsebZ5Q3YlCg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n+OrNl7OsV2O2yydD0ziwUutE1Xx7GSy+gU7IT3h4nauQ1EtiYg2xhuuaPpha7qKoC8azhd5HYkGtxIAb4xSrawzmU3Jkz3CYVVjlvQpTYcHjmhbxITxXoMxgTe/Q8meC0EeRxHBWM9h6A6A2QEZ7UdlscqaKUGt9FTTWVKKxRI/TjeJ7Vyy9VDrJGaSwrD7vl1oloJhGOB6xHUY4e993uixAMNGBZlz6Ekz0XyY/hduZqxF+RuEyfhzXsUzl0wXEDbkxYubVe4OdN5x+qmk6Zdb7K/njhwfyDY0eC8PFnrUbfLD96wJ09gmN1KjkMBKZxN1CREkRFeRvGzchXOu7Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XeyBwjIM; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=XeyBwjIM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bYDZx5QYhz2xJ1
	for <linux-aspeed@lists.ozlabs.org>; Fri,  4 Jul 2025 10:11:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751587913;
	bh=vRae16FTMewFnY4A+z3eMOBzVPHBvIAgsebZ5Q3YlCg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XeyBwjIMtpLKcmGrtMZ/p6veE7enBFfIx18cUA84QVUnc3r7+KVvnP460pGyRB7Lk
	 fMJQc5WaHrrq7Iuym6bElVh7D+OWhkBVfOywVr61lhmlErWAUPZZZIRsYwjmFk2nq6
	 cdn0uXeYgQvp5oYXwM0j5MlaDHoSZxj7o85AeYJWSWhFzl61fSls/yT3B0fUfgUTv7
	 ZaD6Bf0+6z6CxWov480SlKUpL3V9msSQqoCMoEMwivfplSMEegPQ2ShA0AWew7xGhU
	 hApgTFQZijidnuAvWx93Wdn0n1G7Cr+se8Vc4N+4fEqC6rIa5frvi15iIiT4SOS7Ga
	 EYSuTjqpko4oQ==
Received: from [192.168.68.112] (unknown [180.150.112.153])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4065E6A680;
	Fri,  4 Jul 2025 08:11:52 +0800 (AWST)
Message-ID: <0782e276f6e22a2f590eb905ef2c5617f0870b63.camel@codeconstruct.com.au>
Subject: Re: [PATCH v6 1/2] dt-bindings: mailbox: Add ASPEED AST2700 series
 SoC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Jammy Huang <jammy_huang@aspeedtech.com>, jassisinghbrar@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, joel@jms.id.au, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 04 Jul 2025 09:41:51 +0930
In-Reply-To: <20250702011956.47479-2-jammy_huang@aspeedtech.com>
References: <20250702011956.47479-1-jammy_huang@aspeedtech.com>
	 <20250702011956.47479-2-jammy_huang@aspeedtech.com>
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

On Wed, 2025-07-02 at 09:19 +0800, Jammy Huang wrote:
> Introduce the mailbox module for AST27XX series SoC, which is responsible
> for interchanging messages between asymmetric processors.
>=20
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

