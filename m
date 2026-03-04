Return-Path: <linux-aspeed+bounces-3587-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A543EDEC01
	for <linux-aspeed@archiver.kernel.org>; Wed,  4 Mar 2026 02:41:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQcNy5kSmz30FP;
	Wed, 04 Mar 2026 13:41:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772592066;
	cv=none; b=RD+cwjVKsZGp5MeZyKOUX2OFG32dCRCh8OFjtcmmxjPe1LG68QCKQwEDKelSEmPIqA15b8Lzm9akXz9bNDyE0M3n22r+hbYsH/akPz2tcIK5vi9cExqFkLIdlnDEbaSLoJaWmSCKMoz46xZJhp6GhjHlLrCT4NeldrsWZs8PbvkMXXXJUHrUpmdwI9PpCphMybKApGtn/8gy0PZ1WSu0noy2LKKTqFiBb9EnNOc2VBTK+sebe1TlbnWPiU00Akscgk5bX1XjlIHKxUFuFOe+oDIVt92MQ87FA+YmnBQFXAXh0IM3pv638WrN1NIuwJn1nHSTTvG1/cRYG4RRyaE3Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772592066; c=relaxed/relaxed;
	bh=Ih8XBInDkYJdrPvgQj+yzh+6t6OHwUs1ab86hkiTbV4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oPWArRlaXyDHAyQ5Kh6vDF+soR+e9ePYvfvS1IDtoeLS4JvmBFdQKBEGyqpDm4qy+XqoAPI2jar8q0oYFKfpjvm2eZ6I0ZTIFRffSLacoaBIukvx7dycoGBozB9JZf6ahRSLQQ+3cc06zSnHyMXVaysGvKu7HmXKaG5jFEHPcZ3qpgppkB4a3slPOrorvKwkX/9+eVDQXUF+b9Lm5SwZ/juAnmEPF7REdlwDboAOpzEwlZy+8VXDvt9WpouSvtelSI9F+wiRUg0IMIpaAjRQKw1Gi96V3IViRq78SBaEn1tZx7/SLr7U7zCKhV9UWAun2qyZ5bBWKCDxmdtTu7JfZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=SalvJloe; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=SalvJloe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQcNx6KvZz2yLH
	for <linux-aspeed@lists.ozlabs.org>; Wed, 04 Mar 2026 13:41:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1772592063;
	bh=Ih8XBInDkYJdrPvgQj+yzh+6t6OHwUs1ab86hkiTbV4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SalvJloerZOYvex+zkrwh5UMW3MGxyhruNDEFL83KHvFNP8bYTJoq3fe1rizA3YJB
	 tms5oPmwKDAxRx2zBqjtQXszG3mgr81wHMWJhjq8O7/cNElXxH0m0vs+mNewFj770X
	 sm+famqvqJ5TG6U1ZCqUwKE1i+rpFx0pdaWjbLyTVEldTLpGyJpJuJcvJ+U02RxTfc
	 f0g0KqrpGfelQXbhMUuJB/w6fuunQ9R5AH2OuqymTxL5mZQw6cqWcq5PyfixqUczAQ
	 JBFvPK2STremjsw79QuSjFU0/iz9oJeVLrTwaJEpnfzGlfI9aRtE7E/LkwsW5Xt9wJ
	 Bjb1FsQoPR9PA==
Received: from [192.168.68.117] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9C80C6000D;
	Wed,  4 Mar 2026 10:41:00 +0800 (AWST)
Message-ID: <391b9b912492c07fd1fd7a737b7f49382d361fe2.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 3/8] ARM: dts: aspeed: yosemite5: Add new SGPIO line
 names and rename signal
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Joel Stanley	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Amithash
 Prasasd	 <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, Ken
 Chen	 <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, Jackson
 Liu	 <Jackson.Liu@quantatw.com>, Daniel Hsu <Daniel-Hsu@quantatw.com>
Date: Wed, 04 Mar 2026 13:10:59 +1030
In-Reply-To: <20260223-yv5_revise_dts-v5-3-fc913e902488@gmail.com>
References: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
	 <20260223-yv5_revise_dts-v5-3-fc913e902488@gmail.com>
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

On Mon, 2026-02-23 at 19:17 +0800, Kevin Tung wrote:
> Add new SGPIO line names for user space monitoring and event logging.
>=20
> Also rename PADDLE_BD_IOEXP_INT to ALERT_IRQ_PMBUS_PWR2_N to match
> hardware naming. The original PADDLE_BD_IOEXP_INT is unused, so this
> change does not affect current system functionality.

Why are these two problems being solved in the one patch?

https://docs.kernel.org/process/submitting-patches.html#split-changes

Essentially, your use of "Also" is a bit of a red flag here.

However, on the specifics, why was the PADDLE_BD_IOEXP_INT hardware
naming wrong to begin with? What changed?

Broadly, it feels a lot like you're revising platform designs, then
trying to make the one devicetree fit the current design, and are not
explicitly communicating that this is what you're doing.

If that _is_ what you're doing, then we can come up with much better
schemes to handle it that aren't a constant stream of compatibility
breaks.

I need you to engage with this concern.

From inspection, I only find patches 1, 4 and 7 of this series to be
something I'd consider applying without further discussion.

Andrew

