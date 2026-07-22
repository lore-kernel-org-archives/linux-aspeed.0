Return-Path: <linux-aspeed+bounces-4529-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F37C44539
	for <linux-aspeed@archiver.kernel.org>; Wed, 22 Jul 2026 11:46:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h4ssm3kKMz2xnK;
	Wed, 22 Jul 2026 21:46:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=203.29.241.158
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1784720796;
	cv=none; b=mTj2KmogfjTvRMC/JpD/vFJ3IlpPGTX1PMSDL37E3vmrP1Nh+1ZIyxNK6wjDmPUzH47g073T96Y6095Itz9D/2kDQzK9pzx8QKzSHi/9sue/VxdkGDJ0VsB1712JdN/EDCrA3GeGxdGkJ+peM6DXDet9N9RJcaZBShe5ATfVrdnDLCG0bH+8ex9xJTuX5BDcAAmk5w/1FQ930deshZUo0on/Y95JVZ7FmU3w+J89Spc+FS87OBzEKPocgKvblgkzmTD4HoAopQ0/OwRkgzY14YQvuTYUtZWm8x2tDqP7hWcfD7qjrf1JMK4FTejH4VmtB0SUJgCZKFuqMMQljAhWtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1784720796; c=relaxed/relaxed;
	bh=BWcCusQ28FbVznAVl+tc3Bd3miMXsSj/x/rAhqbfUa4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ciJIZcrPthgyNtVCjI/dO6kav7dKBZvGZaPheHjHClvKc39pIYCedkANV24o4FMXZhlsGa5Uhn1ALfCoJ/zc26QDPo0MPhDvw41hE3EX2Rf5VbdejuTXPNpZfLm8oghwhebx6lftG+LwR5LeeBRgQ7RcIVRdd9mhwgheTV+6yBdCw5iFbzrDTTD0TU0+X8O1o1eWgOEAOd8tMZwYaxINH7SKhi0ML/ovsshsDszfuUCNjrHCn5vf2s3pmQGWhXe4NYSfbsR3JqVz89zfD+p6RXa2kIbU+g2uSfe060m4SRjnxpQunoMSDJ6tlWSu7cYVtiW/IM0Y9cUHrZ84hIqb5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=JkpvVUfU; dkim-atps=neutral; spf=pass (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org) smtp.mailfrom=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.a=rsa-sha256 header.s=2022a header.b=JkpvVUfU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codeconstruct.com.au (client-ip=203.29.241.158; helo=codeconstruct.com.au; envelope-from=andrew@codeconstruct.com.au; receiver=lists.ozlabs.org)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h4ssl25yDz2xJT
	for <linux-aspeed@lists.ozlabs.org>; Wed, 22 Jul 2026 21:46:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784720794;
	bh=BWcCusQ28FbVznAVl+tc3Bd3miMXsSj/x/rAhqbfUa4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JkpvVUfUdMIzlFefv4cRZkhynvd7wAubwbSMBmvFJ0Q/21oUq6YfApbKZ2Z0m/eJt
	 ogG3DApQoHwMFnVc5Xr34XUsOpmAPxRSuYzscQviykpMsgO8TJpMg2F6nWr/AAbzkh
	 GuZw4E0wvX8lCTatFcpdWz8bOljjcmbs0i0WKUkmPO1cWYw4uauY/tb1S5BHDk1JnL
	 R9n14gFWYxA/DXpssirUUjl3o1mdkZ1qaBwTqh1ZUdfgxohrbir6sbZMGUQtWqXdnG
	 R7pVczUByMRRndbcPq/N5w+bsWqs1qZ0aYPXlyhxFTvzjWCgmyhjziiqvy2551u5ZT
	 k0IxNzNLX4QwQ==
Received: from [192.168.68.117] (unknown [180.150.112.11])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 6DB93662E1;
	Wed, 22 Jul 2026 19:46:34 +0800 (AWST)
Message-ID: <de6f82c5601a4481e418270171e803340368bd2a.camel@codeconstruct.com.au>
Subject: Re: [PATCH v8 2/2] ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Kyle Hsieh <kylehsieh1995@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 22 Jul 2026 21:16:34 +0930
In-Reply-To: <20260615-ventura2_initial_dts-v8-2-c89f92c80447@gmail.com>
References: <20260615-ventura2_initial_dts-v8-0-c89f92c80447@gmail.com>
	 <20260615-ventura2_initial_dts-v8-2-c89f92c80447@gmail.com>
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

On Mon, 2026-06-15 at 10:46 +0800, Kyle Hsieh wrote:
> Ventura2 is a Rack Management Controller. It is a modular
> device designed to manage liquid cooling systems and monitor hardware
> states within an IT rack. The system uses an AST2600 BMC for management.
>=20
> RMCv2 serves several critical roles:
> - Detects liquid leakage at both tray and rack levels.
> - Communicates with and controls liquid cooling equipment.
> - Manages leakage events and executes system recovery protocols.
>=20
> Key hardware features include:
> - An extensive I2C and IO expander topology to support comprehensive
> =C2=A0 sensor monitoring and backward compatibility with legacy trays.
> - MCTP over I2C support for asynchronous device communications.
> - A dual-flash design for BMC firmware redundancy.
>=20
> Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
> ---
> =C2=A0arch/arm/boot/dts/aspeed/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0=C2=A0 1 +
> =C2=A0.../dts/aspeed/aspeed-bmc-facebook-ventura2.dts=C2=A0=C2=A0=C2=A0 |=
 2903 ++++++++++++++++++++
> =C2=A02 files changed, 2904 insertions(+)

We now have scripts/dtc/dt-check-style. Running it over the dts with '-
-mode relaxed' yields 49 instances of 'mixed-indent-chars' - these must
be fixed. Further, can you please look at the output with '--mode
strict', address all the warnings that are reasonable, and then discuss
what's left?

Otherwise, there are still some concerns reported against the bindings:

   $ make CHECK_DTBS=3Dy aspeed/aspeed-bmc-facebook-ventura2.dtb W=3D1
   ...
     DTC [C] arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dtb
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dtb: /ahb/apb/lpc@=
1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast26=
00-lhc']
   /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/bo=
ot/dts/aspeed/aspeed-bmc-facebook-ventura2.dtb: fan-controller@20 (maxim,ma=
x31790): 'channel@2', 'channel@5' do not match any of the regexes: '^fan@[0=
-9]+$', '^pinctrl-[0-9]+$'
           from schema $id: http://devicetree.org/schemas/hwmon/maxim,max31=
790.yaml
   /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/bo=
ot/dts/aspeed/aspeed-bmc-facebook-ventura2.dtb: i2c@400 (aspeed,ast2600-i2c=
-bus): Unevaluated properties are not allowed ('aspeed,hw-timeout-ms' was u=
nexpected)
           from schema $id: http://devicetree.org/schemas/i2c/aspeed,i2c.ya=
ml
   /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/bo=
ot/dts/aspeed/aspeed-bmc-facebook-ventura2.dtb: adc@48 (ti,ads1015): '#addr=
ess-cells' is a required property
           from schema $id: http://devicetree.org/schemas/iio/adc/ti,ads101=
5.yaml
   /home/andrew/src/kernel.org/linux/origin/build.arm.aspeed_g5/arch/arm/bo=
ot/dts/aspeed/aspeed-bmc-facebook-ventura2.dtb: adc@48 (ti,ads1015): '#size=
-cells' is a required property
           from schema $id: http://devicetree.org/schemas/iio/adc/ti,ads101=
5.yaml
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dtb: /ahb/apb/bus@=
1e78a000/i2c@580/power-monitor@69: failed to match any schema with compatib=
le: ['pmbus']
   arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura2.dtb: /ahb/apb/bus@=
1e7a0000/syscon@0: failed to match any schema with compatible: ['aspeed,ast=
2600-i3c-global', 'syscon']

Can you please tidy these up?

Thanks,

Andrew

