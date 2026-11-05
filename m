Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A313606A32D
	for <linux-aspeed@archiver.kernel.org>; Thu,  5 Nov 2026 05:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Kh3y7Xy6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKrF33VYVz2xNC;
	Thu, 05 Nov 2026 16:18:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793855911;
	cv=none; b=jj9ujvpnZVMV3GO8dMH16YY24CAc4mGOEbNrq1PRulcQUZDFT27cf4lbXQ1Io4J8u4SxhExQde4I3+mzLf70xLdiIRnCFEXvKI1pSJ8l8bLWoOkMwCRDB/twxSVm6OfrGxyWfPCtSL7t5GDsloOH8iWyK0DlU54eMsRO6JCVDzIWGAsEIJFxxaF7XOy6aCy/T4am6jc0Li4iyyg3928UFVSnu2JOjOCnM+SAUsqqEpeF27l1kWK4Zd9eL/QkocSZyuzsgGu8smh5MOy2Qjm59R4X04xqthLHboJ3YUzp5WfynF+YWAeMp4xGopNI/uHjzC4ahNpvrcpKdlSVtpmwyw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793855911; c=relaxed/relaxed;
	bh=+8q0BMvB9wWUz5f3EYAzIeMUb+gnozsdbkCnoECk4mc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AxWa+5wz50shRwUJOwqLe2YArCBFaWIqOJXdB/S8pGphEeFldcWJhxtbFUozc7PYUxsfV675xtvwy2xNvcsVOgu56pq91K50AtzIgnmKJFmS3lvI643fw0PK5z8/lxj98KOhMsE7pHs58zxy20snfMhyx0Gxy/QBbd9aKTGFzMclsefh1ws8CgHPF7UFRNGfgrKoNW2ECKxYod+H60o7WG5tnT5FQ9tdmA9BU0zLtyO/kj9XdLZ5K3GUr9+CTROMs/kkiz3H6GiPIvvzyC4c2r0OpnOu4/J+Pn0YAvx0bHxwz06SA9+4rNYvt7GGXy7VVrb/XWDcBP8tgGPdbSuoEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Kh3y7Xy6; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=Kh3y7Xy6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKrF12Z7vz2xLd
	for <linux-aspeed@lists.ozlabs.org>; Thu, 05 Nov 2026 16:18:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1793855907;
	bh=+8q0BMvB9wWUz5f3EYAzIeMUb+gnozsdbkCnoECk4mc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Kh3y7Xy6tZVSiGt/8Es7VfOUi/arBd5FRbyFObIdv6Iiq6PPE8Ipb5wD/3A1B5YDB
	 jVC65cPMNvPDYZ9I7gkMppRVGCjkGLRRk2Q8Rut8QPRoZ97316SO0eNKVyl/6s3D0/
	 W/lBZC+hy5iIdqG6iMyiSDCQ/yWYBAZtNeLYaFwsmQw/X/Iw/nv3CBz0U2fhj92UZC
	 hp2LQKsSf9ylwKPVwnzrnLtIwGKrxNy95syFEE1QtZlsL1jEpTCOeKw191U2cLVbX/
	 rs3XBp6jJ1cc59t0iTHQlP46QweFyhZFYwpaG5QkwthHluMcomrhgQjD1p4ymDwmTC
	 U/dn18Hc4XOaA==
Received: from [192.168.68.117] (unknown [180.150.112.139])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 3446C64698;
	Thu,  5 Nov 2026 13:18:27 +0800 (AWST)
Message-ID: <3c6f78a78dcea12e97b62f8a65c0248f023bbc64.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/2] gpio: aspeed: Clear only the acked line's G4
 interrupt status
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Billy Tsai <billy_tsai@aspeedtech.com>, Linus Walleij
 <linusw@kernel.org>,  Bartosz Golaszewski	 <brgl@kernel.org>, Joel Stanley
 <joel@jms.id.au>, Ryan Chen	 <ryan_chen@aspeedtech.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Aaron Antone <aae@amazon.com>
Date: Thu, 05 Nov 2026 15:48:25 +1030
In-Reply-To: <20261104-gpio-aspeed-irq-status-v1-1-9805645f856d@aspeedtech.com>
References: 
	<20261104-gpio-aspeed-irq-status-v1-0-9805645f856d@aspeedtech.com>
	 <20261104-gpio-aspeed-irq-status-v1-1-9805645f856d@aspeedtech.com>
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

On Wed, 2026-11-04 at 11:58 +0800, Billy Tsai wrote:
> The G4 interrupt status registers are write-1-to-clear: writing 0 to a
> bit has no effect and writing 1 clears that line's status flag.
> aspeed_gpio_irq_ack() clears a line's status through
> aspeed_g4_reg_bit_set(), which reads the bank's status register, sets
> the line's bit and writes the whole value back. That write clears every
> interrupt pending in the 32-line bank, not just the acked one.
>=20
> aspeed_gpio_irq_handler() reads each bank's status register once and
> dispatches the lines that were set. If another line in the same bank
> latches an edge after that read and before an ack in the bank, the ack
> clears its status and the handler is never called for it, so the edge
> is lost.
>=20
> Write only the line's own bit when clearing the interrupt status on G4.
>=20
> Fixes: 79fc9a2fcc45 ("gpio: aspeed: Create llops to handle hardware acces=
s")
> Cc: stable@vger.kernel.org
> Reported-by: Aaron Antone <aae@amazon.com>
> Suggested-by: Aaron Antone <aae@amazon.com>

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>

