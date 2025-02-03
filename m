Return-Path: <linux-aspeed+bounces-604-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94F3C0218A
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Feb 2025 03:48:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YmXXH2Pb5z2yvq;
	Mon,  3 Feb 2025 14:48:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738554495;
	cv=none; b=JiufWIhVf1bWkbkzdPz/wzOTftY4/CXQk+Yzw4j0HeZxj2AEjCwOYtMCorXA0krk7eeT6fFk7TPN9rE2rodoSV7w0ORet5fz27UC6BfCAh8pZthPGgv6TpN6w/R0PPDpFQLsJyc+iUBSS7iQ04VA8XJDHsmsxyZ+tuKegGN+K39n8HiRYVAaZTji776q1IrDWqQBtK6LYCq5KkI4fN28Yeq1dc469vsS6ixQBD/vKmGjHbJLd0c5C/6j/PPSvYUmNnl/Zx+A8sfN9ZYFxn4y2slGTiCJnqV3kc5Wu659ey+bGVv0GbACb8sPRml5fSLATeekyfomQ7qy8hrVrDAvkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738554495; c=relaxed/relaxed;
	bh=n8IcwophMB3hoBBGXT86DKcgpvdtGcA9h2Vz1Sh5RwU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f0iso4a5XowBNCSX4V4TgBrzBVCZzguvewHanqek+6zUqtnIvKLS4/zo9jTwryJN85XelZA/olApc9r1dB61MSdGzTbJuqgf78c0VGKEHHSzju9xeyXE4hoVtFzkwKehvw+hb+DdrYEFmQojx8o/2m/SUUD5imE2oC4PPIuMXQSogrujHfspfKX3xZQST91s8AHCCOyIlBWSGCpiEsxlnyEkQKwTuOSA4pEPlp0bexqpweHyJ1gw6Q7zkPge66Iy37aRQhUkvJP8VIMzMhO8egMnradPavgdrUbzsQZWmHhZZMBsGtEQweczUWEz98HAG306nyoyZonNJHHTG7OzFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=eMdjBFk3; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=eMdjBFk3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YmXXG6416z2yvn
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Feb 2025 14:48:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1738554494;
	bh=n8IcwophMB3hoBBGXT86DKcgpvdtGcA9h2Vz1Sh5RwU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eMdjBFk3KbuTs5LrRrBeRuUqTEk7k4QsMpb/VX5ewByVywkhR5nQEJwluEJ/4pdRE
	 tvN9zct23uahM+UuXIXsQza+rKNiTbRDbn3ORYvLYyr4dlxm7zW/yC11kTCcj/vYiK
	 XyKs6sCqI4rOqRN5/Jdj4rDRnSP/ujlvUaFNOvN83pN13aYHPxQBWhEOzqDk43JlOr
	 PETvdpqQRMN3BdD+L8Z3g2JZRNsWU3yqKAUzhS+C8CSHhxWdGK4U/WlL7JkPXh6Vhw
	 eQwjKpQw+B6mwwH7Ra6Mf0QGmf6u4fVFS2gzIqxCOvZTTYq3+xi5DBMO9haGMa1e5K
	 DkLmHOoJlKxRw==
Received: from [192.168.68.112] (58-7-156-140.dyn.iinet.net.au [58.7.156.140])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 5B04173C54;
	Mon,  3 Feb 2025 11:48:12 +0800 (AWST)
Message-ID: <0cbefd2b2488b7855fb374ce94facd9f7440b7a6.camel@codeconstruct.com.au>
Subject: Re: [PATCH v3] ARM: dts: aspeed: catalina: Update DTS to support
 multiple PDB board sources
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Potin Lai <potin.lai.pt@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>, Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, Cosmo Chou
	 <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>
Date: Mon, 03 Feb 2025 14:18:11 +1030
In-Reply-To: <20250114-potin-catalina-dts-update-20250102-v3-1-14981744b2fe@gmail.com>
References: 
	<20250114-potin-catalina-dts-update-20250102-v3-1-14981744b2fe@gmail.com>
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

Hi Potin,

On Tue, 2025-01-14 at 14:12 +0800, Potin Lai wrote:
> This patch updates the Catalina device tree to support different
> sources
> of PDB boards.

Can you expand "PDB"?

>=20
> Changes for Main source PDB board
> - Thermal Sensor Monitoring:
> =C2=A0 - Added IOB NIC nodes (TMP421) for thermal sensor monitoring.

Can you expand "IOB"?

> =C2=A0 - Added FIO remote thermal node (TMP75) for thermal sensor
> monitoring.

Can you expand "FIO"?

> - Fan Monitoring and Control:
> =C2=A0 - Add fan p12V power sensor node (MP5990) for sensor monitoring.
> =C2=A0 - Add fan controllers (MAX31790) for fan control and tach
> monitoring.
>=20
> Changes for 2nd source PDB board
> - Fan Monitoring and Control:
> =C2=A0 - Added 2nd source fan controllers (NCT7363) for fan duty control
> and
> =C2=A0=C2=A0=C2=A0 tach monitoring.
> - Power Monitoring:
> =C2=A0 - Added 2nd source HSC nodes (XDP710) for power sensor monitoring.
> - Address Conflicts:
> =C2=A0 - Removed all ina238 nodes due to address conflicts. Moved the
> driver
> =C2=A0=C2=A0=C2=A0 probe for ina238 to userspace.

Can you unpack the issue with the conflicts a little further? What was
going on here?

Andrew

