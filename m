Return-Path: <linux-aspeed+bounces-2120-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B66CA100C
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Sep 2025 05:16:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGrSM5rY8z2xQ4;
	Wed,  3 Sep 2025 15:16:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756876595;
	cv=none; b=UYv9KvCPRxB+zQQWHIli0guzHqpw6+7KFnl3Uz0AhKB9r19lavGFHQ0M3G9bIXsc8JPC7aA2C3ctH/j7R29gnzVOn/0tLwVxW8uh1eO18ihx8r68z9w5+5PxdQVfyloc0MVCpZrRIaNi4BSZtl6hWLmhIX+d/NnJbbMUGmIq6NYwinbSwGW1WRtE7PmKqVdj/fV+qEyPuqSUbQHRy/Xb/aBlECz8T4Fo9+ay7oJ3fouK4qmvuvgwupeuUf3IDVhQNlp4NzLzkWLiKtdvdIo47Fyo4pd55jbRUReR5NuWtUANcONTsBSm26zpb/iUIp/RFIip1YmSr08TF+33BhquAA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756876595; c=relaxed/relaxed;
	bh=VxqW1+HVqZt8tNdYWLOekx1h+1GGvAsmtTB9R2oJ/V0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GxaOeOAA3AxUT0J0U5sNYc7N+3Ed+kofya+R+AF5tOI8ND3IWqkxYO5QZM4wyTWZJJVaFKm6S50m2XyN3jtWKtYR5jSgkTee0t2xms2N+YdN2pkgJ2b92dTf0knE3piBk7hYNKYc1vzGgc0n74CmqqQeVBaWoese/ELyaYlRWe9yeLhLVIYEnvrNe8IPVJ7e6Al1tMwxOA5yReLM1zg46m4ZZuvnvu+UkgYGRdPRgyE2lZQkj2uHRDyOHAgZ4NvYL+hQelKrllTMZoTTkEtYRvApqho8jEdeAfOXbXe7vPx8ID8YGWv/k6ObgGCpZL9I7GaodYv5GMG3af4qmqTmDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=O6ZwNqm2; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=O6ZwNqm2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGrSM02xxz2xQ2
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 15:16:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756876594;
	bh=VxqW1+HVqZt8tNdYWLOekx1h+1GGvAsmtTB9R2oJ/V0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=O6ZwNqm2xWP5UVmWTAh/vmC9/Iv0DHsjJ9LS1ak4NXOYFWnbcjDIZ6vNXkLlC9YEg
	 OLljPDxHBzYs1mptfy4DnBLEAnujJ8vbmmpnd3Gnd3GunjnkGx9XPJ/zp3JhlMCIKc
	 yblsFpJb/kETW9SUoNODv8q7sxvz7djFActkyYveGNIxVIySrtM6I0KNxkU1ksGdNY
	 B1VEHcsBShr+T3wPmm1J5oORFNBY6ehYLXRBfFl+trkrxjgMyAq2pcuB+xzHn1Qmeq
	 tOnKep1DBIeJsDbMgEQFeSMYD5iBK1rPyzbsYiTZiSAIXOOn61gF21VU6NBelnJGWk
	 UrOpZtsgrpQRA==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BF2DB6E02C;
	Wed,  3 Sep 2025 13:16:33 +0800 (AWST)
Message-ID: <ab4c3c62e3b48dfac1bcce15e0aea402d66bc198.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/4] Revise Meta Santabarbara devicetree
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Fred Chen <fredchen.openbmc@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
	Dooley <conor+dt@kernel.org>, linux-aspeed@lists.ozlabs.org, 
	linux-arm-kernel@lists.infradead.org, Joel Stanley <joel@jms.id.au>
Date: Wed, 03 Sep 2025 14:46:33 +0930
In-Reply-To: <175529259974.3212367.16366822597087067588.robh@kernel.org>
References: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
	 <175529259974.3212367.16366822597087067588.robh@kernel.org>
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

Hi Fred,

On Fri, 2025-08-15 at 16:19 -0500, Rob Herring (Arm) wrote:
>=20
> On Thu, 14 Aug 2025 21:16:56 +0800, Fred Chen wrote:
> > Summary:
> > Revise linux device tree entry related to Meta (Facebook) Santabarbara.
> >=20
> > Change log
> > v1 -> v2:
> > =C2=A0 - add 'bmc_ready_noled' LED and update commit message
> > =C2=A0 - add sgpio line name for leak detection
> > v1:
> > =C2=A0 - add sensor nodes for extension board
> > =C2=A0 - add mctp node for NIC
> > =C2=A0 - adjust LED configuration
> >=20
> > Fred Chen (4):
> > =C2=A0 ARM: dts: aspeed: santabarbara: add sensor support for extension
> > =C2=A0=C2=A0=C2=A0 boards
> > =C2=A0 ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
> > =C2=A0 ARM: dts: aspeed: santabarbara: Adjust LED configuration
> > =C2=A0 ARM: dts: aspeed: santabarbara: add sgpio line name for leak det=
ection
> >=20
> > =C2=A0.../aspeed-bmc-facebook-santabarbara.dts=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 857 +++++++++++++++++-
> > =C2=A01 file changed, 853 insertions(+), 4 deletions(-)
> >=20
> > --
> > 2.49.0
> >=20
> >=20
> >=20
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in this
> series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>=20
> =C2=A0 pip3 install dtschema --upgrade
>=20
>=20
> This patch series was applied (using b4) to base:
> =C2=A0Base: attempting to guess base-commit...
> =C2=A0Base: tags/v6.17-rc1-9-g8e4021078863 (exact match)
>=20
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
>=20
> New warnings running 'make CHECK_DTBS=3Dy for arch/arm/boot/dts/aspeed/' =
for 20250814131706.1567067-1-fredchen.openbmc@gmail.com:
>=20
> arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dtb: mctp@10 (m=
ctp-i2c-controller): 'label' does not match any of the regexes: '^pinctrl-[=
0-9]+$'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0from schema $id: http://d=
evicetree.org/schemas/net/mctp-i2c-controller.yaml#
>=20

Can you please address this warning and send v3? Check that it no-
longer appears after you fix the dts. You can test it with the command
suggested above. More thoughts here:

https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sourc=
es-with-the-devicetree-schema/

Thanks,

Andrew

