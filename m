Return-Path: <linux-aspeed+bounces-704-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFF4C02198
	for <linux-aspeed@archiver.kernel.org>; Thu, 13 Feb 2025 00:21:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YtbSd5TKqz2xmk;
	Thu, 13 Feb 2025 11:21:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739406065;
	cv=none; b=DjOPYoUdSrx8+DAW2i4YbMm7g4S90Ccl3b7Qh1lOV/PeKLxyYvRuWASuvbWi8vPkkf7x0TP5XAVutYtzyjekiMa4zOoEP2dyAwkEY50OvtQaOeNPIP5ChwMNshWNQFgpcy57SlKdYEPQnGLq8H5WMBECuR+uxsnI8Nm6V+oEFJwkAFDE6WvDPXTWLNtoba5jzeWNfpBmyoR3hg9PH0p1Pk0C064yXHkzRInz6qhTSeEpdeSq2tGfBKC9lISWDwehC52VV+INRLY+4ITbS8jGKvMymdAPqghow4bdsiTsuPEyWdpMYTxoZU/Rf15wa1894vpJMVV3ura8KFlNdwdloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739406065; c=relaxed/relaxed;
	bh=jnRRalYsfx7z1FMzhIoHU7Ms/KER3HC5c+11l6mllmM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=goUYofIL0H4MaitOpbdyzehqsRXmJ8QdtwZ4qM6GdKwzr8ZSKztbrZIxmmSoJnv5TcTifqBGxqXlHzhnbVjRIOVXjDXnhjSD5u2h28tU2EwyB6VQBK/TFDsvUfUy4vrnMeS4/1g11z2jtroyRaH/I4iloi2jOsoLdJ8uqcS3OhKLS1joaQ22i5p3lynXigJSRmGV1maMjMmNnvL1PzvkpzlJ2EH78BXylZzVV4LKkoWqp9HhoXSEdOzzsBJsnljG1vOPyOHu+WrJ79LDvlpk3VeYaVScrZnoMF/z87QmvmWZpGfSiJG8IM3aLmoU15mC8l/sX9psSF0g5A124Kly/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=jtht8LwA; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=jtht8LwA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YtbSc5xBTz2xmS
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Feb 2025 11:21:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1739406062;
	bh=jnRRalYsfx7z1FMzhIoHU7Ms/KER3HC5c+11l6mllmM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jtht8LwAMfpecc9QULdps43dmB2r9suxd0Al+T+TcRwf+jWzxNINzQjWb7ANfiPym
	 nYWEb3NrG5KPb7Nq/hEZUHiQsJX6ZOQWZNrqslozedBLb6+RlwoPj9rdp1UnhU3+RX
	 MBZqp9p8n3mTFAiW2svDTgNF2e2h8/A7grImi4ukZ3O+AFOLkEmTmMhNH5kGOVgrSS
	 Lw0YoAVJOYKHd0egB4JEn/vQjZns5tY2kDJDn224NuWa/pMlrfRWQYl0cqtF+F1wit
	 /2bJhstEdhGGsG5HagLr4OSVsFV7hnzcsBXe339aFQjMC0wat3wyyaFgAHQQ1/qDb8
	 nsAGBIjOKWvoQ==
Received: from [192.168.68.112] (203-173-7-184.dyn.iinet.net.au [203.173.7.184])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 880B57576E;
	Thu, 13 Feb 2025 08:20:59 +0800 (AWST)
Message-ID: <f649fc0f8491ab666b3c10f74e3dc18da6c20f0a.camel@codeconstruct.com.au>
Subject: Re: [PATCH] soc: aspeed: Add NULL pointer check in
 aspeed_lpc_enable_snoop()
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Chenyuan Yang <chenyuan0y@gmail.com>, joel@jms.id.au, 
	richardcochran@gmail.com
Cc: linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 13 Feb 2025 10:50:59 +1030
In-Reply-To: <20250212212556.2667-1-chenyuan0y@gmail.com>
References: <20250212212556.2667-1-chenyuan0y@gmail.com>
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
MIME-Version: 1.0

Hi Chenyuan,

On Wed, 2025-02-12 at 15:25 -0600, Chenyuan Yang wrote:
> lpc_snoop->chan[channel].miscdev.name could be NULL, thus,
> a pointer check is added to prevent potential NULL pointer
> dereference.
> This is similar to the fix in commit 3027e7b15b02
> ("ice: Fix some null pointer dereference issues in ice_ptp.c").
>=20
> This issue is found by our static analysis tool.
>=20
> Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
> ---
> =C2=A0drivers/soc/aspeed/aspeed-lpc-snoop.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index 9ab5ba9cf1d6..376b3a910797 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -200,6 +200,8 @@ static int aspeed_lpc_enable_snoop(struct
> aspeed_lpc_snoop *lpc_snoop,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lpc_snoop->chan[channel].=
miscdev.minor =3D MISC_DYNAMIC_MINOR;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0lpc_snoop->chan[channel].=
miscdev.name =3D
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0devm_kasprintf(dev, GFP_KERNEL, "%s%d", DEVICE_NAME=
,
> channel);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!lpc_snoop->chan[channel].=
miscdev.name)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return -ENOMEM;

This introduces yet another place where the driver leaks resources in
an error path (in this case, the channel kfifo). The misc device also
gets leaked later on. It would be nice to address those first so that
handling this error can take the appropriate cleanup path.

Andrew

