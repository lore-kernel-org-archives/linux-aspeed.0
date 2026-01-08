Return-Path: <linux-aspeed+bounces-3260-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7217D148A0
	for <linux-aspeed@archiver.kernel.org>; Thu,  8 Jan 2026 06:05:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmvWb6Qhgz2xZK;
	Thu, 08 Jan 2026 17:04:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767852299;
	cv=none; b=lp31xzNGhC6qxH0snG28v84U1TOuSuIR+fhc9BNs3vYVKQ8qqbIKieBcENANpTe5GZq4AXtfTE6Oj3i+QKRY6IsqzJ56jalVRr8qqC+TiaQzH07yZAPGFffTyYbeqkvyo0r7s+dCi7cC96KzbdZHYNCCsyCggNTl7d1WUqHS7LwR4salJMWZefuY/iEInzPiX6N3JWj6NmS0GcTuxqGwxLEH1SAEnT1hGZNOoyffvadLHpK8T9OdpgIqLuxyqI7EKSb8B+3B6n+ZXo1BM1rZNhTRcNX2BgHqCCg8DyWFTtYf3kK8Sc6PPlwOhfsmWliO3UJhYeh4/pk97yvhyzRZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767852299; c=relaxed/relaxed;
	bh=Lzc+HCU/UMiCZqanaq1/Hyk80NttsM3prspmFkSZ1dM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m7nDYIhVhkla4u2B25M25g9HIOh6zEfFNwh4VLN0Nzav1NFQboQicbKzAJhmgkM/hkbojDEbsaITk5kY6VaKqyyF9XGdjj1bympoR63yHncmJsqLOByIg1y2UTa3sNDxj0bsngxsL0rC3G8Uqt/0MB/meyviQEjRSpv3WuzIr5x898eXtKI86i7ynqP5BH4fTknT4GulyJiWo/5zfHx86BiTgsoYCPfIDfAQhkkeVCGhoKo76TS5tmQJ4+147adZ/4uWbAcCUuOgnxqx2qICwnzzFGGQr703ymz+bmHErodYsi9j4Ivb0H1KK7HrnWUdvSommMEVRgv6KokMPxefgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=FPvChj9Q; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=FPvChj9Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmvWZ4xPqz2x9M
	for <linux-aspeed@lists.ozlabs.org>; Thu, 08 Jan 2026 17:04:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1767852298;
	bh=Lzc+HCU/UMiCZqanaq1/Hyk80NttsM3prspmFkSZ1dM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FPvChj9QFoYELv4NmJ0HWX4qTD4n8uT2clQe2BuBk2aDz3PVF8Ry8moGU6xwAI7H5
	 MMH5yumSsONLqGEgMIiqfxAh9Dn4CdPhwzQeP3gi6/T3aHhCr27XkY95VVg4xUezQV
	 QGKMyyzP5v+/xq/b4u+QROxP7YbForn4nLzIsXArRg/z+VwzcUI58n2TwjMt5vkdRX
	 Ac4cAXty41G8FHnWcWF7jU8eoyGu61VaBx6z1K8IEreEIRCxQ4AHB/uJ/cHlqggX9a
	 6GOg9qnkpB0b2RAXEWf13igTQnR4S0UUAg/fZACzLE9iNmDS9ZfU/DyYZpgBj4dw7E
	 i6vlPPAuW0yYQ==
Received: from [192.168.68.115] (unknown [180.150.112.60])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id B16BA7C834;
	Thu,  8 Jan 2026 14:04:57 +0800 (AWST)
Message-ID: <3d6aaf558fd8b60ec7010f976a747d9f0a727f98.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 1/2] arm: dts: aspeed: add an alt 128M flash layout
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Marc Olberding <molberding@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Jan 2026 16:34:57 +1030
In-Reply-To: <20251218-alt-128-v2-1-10499a0b7eb9@nvidia.com>
References: <20251218-alt-128-v2-0-10499a0b7eb9@nvidia.com>
	 <20251218-alt-128-v2-1-10499a0b7eb9@nvidia.com>
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

Hi Marc,

Regarding the subject prefix, can you please capitalise the 'ARM' portion, =
so:

   ARM: dts: aspeed: add an alt 128M flash layout

That way it's consistent with the rest of history.

On Thu, 2025-12-18 at 10:48 -0800, Marc Olberding wrote:
> Add a 128M layout for the BMC flash chip we didn't boot from. Including
> this allows the user to write to each partition on the alternate spi
> chip. This dtsi follows the existing standard of using the same layout
> as non alt version and prepending `alt` to each partition's name.
>=20
> Testing: Include this in msx4 and cat size, offsets and name

I think this would be better with s/Testing/Tested by/ and associated
grammar fixes.

> ```
> for devdir in /sys/class/mtd/mtd*; do
> > =C2=A0=C2=A0=C2=A0 [[ -d $devdir && -r $devdir/name ]] || continue
> > =C2=A0=C2=A0=C2=A0 name=3D$(<"$devdir/name")
> > =C2=A0=C2=A0=C2=A0 [[ $name =3D=3D alt* ]] || continue
> >=20
> > =C2=A0=C2=A0=C2=A0 size=3D$(<"$devdir/size")
> > =C2=A0=C2=A0=C2=A0 offset=3D0
> > =C2=A0=C2=A0=C2=A0 [[ -r $devdir/offset ]] && offset=3D$(<"$devdir/offs=
et")
> >=20
> > =C2=A0=C2=A0=C2=A0 dev=3D$(basename "$devdir")
> > =C2=A0=C2=A0=C2=A0 printf "%s name=3D%s offset=3D0x%X size=3D0x%X\n" "$=
dev" "$name" \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "$offset" "$size"
> > done
> mtd10 name=3Dalt-rofs offset=3D0xA00000 size=3D0x5600000
> mtd11 name=3Dalt-rwfs offset=3D0x6000000 size=3D0x2000000
> mtd7 name=3Dalt-u-boot offset=3D0x0 size=3D0xE0000
> mtd8 name=3Dalt-u-boot-env offset=3D0xE0000 size=3D0x20000
> mtd9 name=3Dalt-kernel offset=3D0x100000 size=3D0x900000
> ```

Can you rather remove the markdown codeblock and instead indent the
code snippet (IMO 4 spaces is fine)?

Also the shell continuation markers seem a little unfortunate. Maybe
just drop them for clarity? You can separate the output from the
script.

I also found this helpful:

    diff -u arch/arm/boot/dts/aspeed/openbmc-flash-layout-128{,-alt}.dtsi

Andrew

