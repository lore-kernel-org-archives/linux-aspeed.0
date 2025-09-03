Return-Path: <linux-aspeed+bounces-2121-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C42ECA1007
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Sep 2025 05:19:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cGrX41Hw0z2xQ4;
	Wed,  3 Sep 2025 15:19:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756876788;
	cv=none; b=PV/Oz4FhvGIskztj7MyKX3tKjjd4jCXnNNZDMmesj1MQ7nbWq+ERFixKdx9+NgYoeUWfQ9Vc2RvPJgK2NGPNwFcIbSWdiRiYvDcH6iYumjGKXWPxBKq+mQSYaKJDcJMOGFotkDy0t438tkn/KnXZi/CE3oHfvyWdf8g9g1tRKJ6b4F6VRrr1uW7SOc7MopmrbjRzo3fnBM2oMbMtj3dTzXN35Bxw0HawWirJ+BIb1HUUPzt9NKk9PtYqZ1IlAWSrQKtiLEKkCCCejkeBiOME5BjbrYMTptx6RB34Cw3WWCdQmHvA3q2D/gvzwuAITIV5RsMyV5jHpWh36nWMINlfZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756876788; c=relaxed/relaxed;
	bh=zPZlV7Py6/VRUORcSB1dWGAGhVzyzc70O8zyBF7V8tQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oSVrwmDZ6M3sXdmuqKYsIYs86lXZMU3j+PGH20Zl3V23sR+dx5Ddp2ZdogrFXkf6C1Df6W9MFUvmilQMNSykQ1JEhn6X3uE2vbwGAF3RE39MBlGT49ft7HuDg/tj6/xM3XJy/JtQv3i//jz/15vFCSHRli4R3KU/cOkR8cMnv43pyiR8tKcl4oFz6yF3rd+4SbfA454M6vUVniVlcx0Z5zLsufO3yFL/mosrcMyNSCG0jPduthey+AxS1PyPRgRrQ2dg0cWgWVZ4ULIf/O5Cwsa3citTY6dOaw9k/E4wDF2QOqcaZt5otM40RUz9OZQxY5JYKXM9zgecxAwDbDXZ+w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=CW/QlFXs; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=CW/QlFXs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cGrX35Hywz2xQ2
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 15:19:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1756876787;
	bh=zPZlV7Py6/VRUORcSB1dWGAGhVzyzc70O8zyBF7V8tQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CW/QlFXsuzAcNLftV0U2xce2xp2B/g48O+/UrXEyV9J72oh287kr8qrneOSLQKqEw
	 lwgy8e+DpddxwKZSai4eCuJxgF8VhkcTc10s9du8G1nktTa6ZI6aTlPuNCX6psyUOF
	 i7od2YPjJ/7qF4be7lUpdWXc58VmCSRTRYD5h7IwcSpFYHUB+NyUy33x8nBL5Vcxa0
	 F8IX+413MPzXuz0uElHCvwT+N6lbu9UPzdrmkJm8C0rcyihCFIrgui0NQHGaNZUnsO
	 CL6+syxHAzBXWjU/r7hnLC5FdULCUXdZloKmzp4e9YSmB269Jsg+0TaQ3Z6xLRYQdl
	 BhtxXHaIiN22g==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id BC0556ED31;
	Wed,  3 Sep 2025 13:19:46 +0800 (AWST)
Message-ID: <ae0a7a59eef7f2370174454a06f90ba61d4b49bc.camel@codeconstruct.com.au>
Subject: Re: [PATCH v4 0/4] ARM: dts: aspeed: Add Balcones system
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Eddie James <eajames@linux.ibm.com>, "Rob Herring (Arm)"
 <robh@kernel.org>
Cc: linux-aspeed@lists.ozlabs.org, conor+dt@kernel.org, 
	devicetree@vger.kernel.org, krzk+dt@kernel.org
Date: Wed, 03 Sep 2025 14:49:46 +0930
In-Reply-To: <f366aedf-0231-43f1-8416-994ca4b91342@linux.ibm.com>
References: <20250815194730.41695-1-eajames@linux.ibm.com>
	 <175530106096.3523003.10423924922951806073.robh@kernel.org>
	 <f366aedf-0231-43f1-8416-994ca4b91342@linux.ibm.com>
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

Hi Eddie,

On Wed, 2025-08-20 at 14:40 -0500, Eddie James wrote:
>=20
> On 8/15/25 6:38 PM, Rob Herring (Arm) wrote:
> > On Fri, 15 Aug 2025 14:47:26 -0500, Eddie James wrote:
> > > The Balcones system is similar to Bonnell but with a POWER11 processo=
r.
> > >=20
> > > Changes since v3:
> > > =C2=A0 - Add max31785 to the max31790 document instead of to trivial-=
devices
> > > =C2=A0 - Fix minor formatting in dps310 document
> > >=20
> > > Changes since v2:
> > > =C2=A0 - Fix a couple of incorrect i2c addresses
> > > =C2=A0 - Document dps310 and max31785 properly
> > > =C2=A0 - Drop the UCD binding documentation update, it's been fixed
> > >=20
> > > Changes since v1:
> > > =C2=A0 - Add all the ucd9000 driver supported compatible strings
> > > =C2=A0 - Fix node ordering in Balcones device tree
> > > =C2=A0 - Improve commit message to explain addition of ibm-power11-du=
al.dtsi
> > >=20
> > > Eddie James (4):
> > > =C2=A0=C2=A0 dt-bindings: arm: aspeed: add IBM Balcones board
> > > =C2=A0=C2=A0 dt-bindings: iio: Add Infineon DPS310 sensor documentati=
on
> > > =C2=A0=C2=A0 dt-bindings: hwmon: Move max31785 compatibles to max3179=
0 document
> > > =C2=A0=C2=A0 ARM: dts: aspeed: Add Balcones system
> > >=20
> > > =C2=A0 .../bindings/arm/aspeed/aspeed.yaml=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0 .../devicetree/bindings/hwmon/max31785.txt=C2=A0=C2=A0=C2=A0 |=
=C2=A0 22 -
> > > =C2=A0 .../bindings/hwmon/maxim,max31790.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
> > > =C2=A0 .../iio/pressure/infineon,dps310.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 44 +
> > > =C2=A0 .../devicetree/bindings/trivial-devices.yaml=C2=A0 |=C2=A0=C2=
=A0 2 -
> > > =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0 arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > > =C2=A0 .../dts/aspeed/aspeed-bmc-ibm-balcones.dts=C2=A0=C2=A0=C2=A0 |=
 609 ++++++++++++++
> > > =C2=A0 .../arm/boot/dts/aspeed/ibm-power11-dual.dtsi | 779 ++++++++++=
++++++++
> > > =C2=A0 .../arm/boot/dts/aspeed/ibm-power11-quad.dtsi | 769 +---------=
-------
> > > =C2=A0 10 files changed, 1442 insertions(+), 792 deletions(-)
> > > =C2=A0 delete mode 100644 Documentation/devicetree/bindings/hwmon/max=
31785.txt
> > > =C2=A0 create mode 100644 Documentation/devicetree/bindings/iio/press=
ure/infineon,dps310.yaml
> > > =C2=A0 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bal=
cones.dts
> > > =C2=A0 create mode 100644 arch/arm/boot/dts/aspeed/ibm-power11-dual.d=
tsi
> > >=20
> > > --
> > > 2.50.1
> > >=20
> > >=20
> > >=20
>=20
> Andrew, are these warnings acceptable?
>=20

Please fix (at least) the maxim,max31785a-related warnings (rename
child nodes).

Andrew


