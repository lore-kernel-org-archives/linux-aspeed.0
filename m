Return-Path: <linux-aspeed+bounces-3042-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453FED2CDE6
	for <linux-aspeed@archiver.kernel.org>; Thu,  4 Dec 2025 22:56:16 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dMqcZ4k43z2xGY;
	Fri, 05 Dec 2025 09:56:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764882184;
	cv=none; b=HK5jVjofeWK3pbeugfmmNFjqE1RXzrE5wOHAEjiWIwG6VwjD5VsT69i8Nli0qYlot9lDHvmlvBAE3sgGlYYQgGlbE3glLp9fZmWR5dB+WNcYOzM1mrsCR0EoIwGL2nW1pIIxEd1dldqag0MTnoLsBAEfGcSTpY0d+JThScthJ32kuZw5zWWcwI7FhZ8ts+OklIB7I1w4wAkxAYDJfReA77NOc1XS+Jnz05UiiWy+QOXOJVbL+Abhdy70hT2hB/PSNkRtHBgVXVS3ChRo+JNJQrEcR+o9SKmlwh1BHr9EYqqi52R4T7G7BIu+bGcvyKtbBF4nuZq6zdQ1mWzbjivGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764882184; c=relaxed/relaxed;
	bh=I3JyN6uQ6yNFenjv47EfSd7nrikiNFLfs5LjBOSqI2o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MvQdTFp6OVNh3qyzn9TX/D5qV8U72LQk8D7qttwhwyYD2ByP3CrdYhYF4I25ysOn1PdFbKPBzN5qyVOkEVTY7enQGBjSPT0U5zxM4e58FnqFv5xDhWJk7jxgceTospFA71Wkxt4FoFbq6bAXUYmJQ3dGv7GRp4cS/uYOc6y09WRFGzfS7tK4rFTCO4QumerH0Hbwkfl5s7TkgzkvOPa3ztgAMiNVmqin1gSa6QovHKriLtltpWbMpEJM7ZpIXBA856S52LP/3H4MOX8wtuR8g90LstFHFYJ16ewMjmup3zNygLRWk8VnfYuEe7jwBPdsuVaeY1pQRCl2dwKw5hytSw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=rK0RJANI; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=lsIfHw/c; dkim-atps=neutral; spf=pass (client-ip=202.12.124.145; helo=fout-b2-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=rK0RJANI;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=lsIfHw/c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=202.12.124.145; helo=fout-b2-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dMn5y0VJnz2xGY
	for <linux-aspeed@lists.ozlabs.org>; Fri, 05 Dec 2025 08:03:01 +1100 (AEDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E2B151D0014C;
	Thu,  4 Dec 2025 16:02:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 04 Dec 2025 16:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1764882177; x=1764968577; bh=I3JyN6uQ6yNFenjv47EfS
	d7nrikiNFLfs5LjBOSqI2o=; b=rK0RJANIOIsD0uqvPoJBbyRWEGXwXsHapTZb5
	n910WWWjTmj3QftdJ57Uy2jJ1bLH3XvnZaTnxZjtAZipXKfP01+Pf8sQA/eAY2nl
	8nEgTcWFLTYay0wbQ9kB0y+xl5DaoeAZW0K/gxVBHfZQm0BlRfzRJDP7OgrrSSEJ
	VQ2ujhPG1D8yGYe26lCnZwN24GBzfokVgyvhUEBNqUa8Hwu6ydzPGCew61oYJdPk
	VzC9wAxRW+PP7Pq1W5JO75EiVwdNPwkNiA5W/0l8ShAdvMQQ+CAia3QKlrhJLWkO
	GYDkapB3RLwWKHW1lYvpe5ue1+u3WOZuzKqyTtG8BN1OKPg9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764882177; x=1764968577; bh=I3JyN6uQ6yNFenjv47EfSd7nrikiNFLfs5L
	jBOSqI2o=; b=lsIfHw/c0wyswHBUCEHZAR99I2ZVJs6H2rJDnl81RqGfBhSLjYB
	Tu/f6Uwm+mqu/EcRsG51Ooxg91cgYM4R3NrmMq79o5H+31b9eaIxdepdb8824Kdq
	AEaDepttW5X/iQHrQpXLFl0PP1TzwAFwe70DXszs+9KVHkYaF2fQtfKBy+HRI4if
	0x1/of4E3T4Hm/MdRoQHKpQeQsUh1/8AKWPmIv+aBWtLDEMWEL1PUduARWQw2pHz
	GKsCBiMhKqR1gcaKcwjDD828xOZihlixayfHZJ2XSLHW796HlkKiFyvJ0nxclpEj
	7K1kNURCHN3EyC9kyRTfovxoW3Rl0F8WFKw==
X-ME-Sender: <xms:APcxabIWzF6Epg04HgGAHowvaBtGMYLtGpCLXciMydnv3j90imAGIA>
    <xme:APcxaXRnYCxHfoc-W5TNwh98HH9KjvcTYoRp0_9_nBrYwHwry3A2ScQKamZEXlbDW
    9dE8YmFRRCKheAmpPRw2j7l92JPheGdGUz1QKa0UGo58jPxaVyyhCI>
X-ME-Received: <xmr:APcxaTNSh0LbfLUx28dXIGEYvo1-Ch_PtTuVHOme3xKMJI4yUVZUm_4vuBqcQXdSMuUqSKcmPE87YtZB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeiiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptfgvsggvtggtrgcuvehr
    rghnuceorhgvsggvtggtrgessghsughiohdrtghomheqnecuggftrfgrthhtvghrnhepue
    dvkedtleekueekgfejjeettefftdduiefffeehveefgfevueelgffhleelgfdvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgvsggvtggtrg
    essghsughiohdrtghomhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrii
    hkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohgvlhesjhhmshdrihgurdgruhdprhgtphhtth
    hopegrnhgurhgvfiestghouggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthht
    ohepuggvvhhitggvthhrvggvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdho
    rhhgpdhrtghpthhtoheplhhinhhugidqrghsphgvvggusehlihhsthhsrdhoiihlrggssh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:APcxaUVQ5jpOmrPV83ebfhCrLGhZwxMpIb2Y_Olwzz0zGm1EsZ1BAA>
    <xmx:APcxaehMulI1aS0ZlQkrTqWdpiGetmW75epFd08Bi8_QfuHTafGGiw>
    <xmx:APcxaVjOuBW8RmnoyjVWzpgnVtUfMPTXrbhT393U0IwqwuWJlwEwug>
    <xmx:APcxaUH2HGs_Rv84w7jNn5Pyd_9JU5gxH8CnuagzpKHpLdYgN4JT5Q>
    <xmx:AfcxacqgAeFqijyrJL-ZmIPnX4vTi-qw3svllPXxjXco1azWn1FLzmgi>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Dec 2025 16:02:55 -0500 (EST)
From: Rebecca Cran <rebecca@bsdio.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Rebecca Cran <rebecca@bsdio.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
Subject: [PATCH v3 0/3] Add device tree for ASRock Rack ALTRAD8 BMC
Date: Thu,  4 Dec 2025 14:02:33 -0700
Message-ID: <20251204210238.40742-1-rebecca@bsdio.com>
X-Mailer: git-send-email 2.47.3
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
Content-Transfer-Encoding: 8bit

Apologies for the long delay between v2 and v3 patches.

cc Billy Tsai for the move of ast2500 pwm-tacho docs from
aspeed-pwm-tacho.txt to aspeed,g5-pwm-tacho.yaml.

The ASRock Rack ALTRAD8 BMC is an Aspeed AST2500-based BMC for the
ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q boards with an Ampere Altra
processor. The BMC runs OpenBMC.

These patches add a device tree and binding for the BMC.

**Changes between v2 and v3**

- Removed system fault and enclosure identify LEDs; added heartbeat.
- Removed the code partition from the BIOS/UEFI flash.
- Renoved bus-frequency from i2c nodes.
- Renamed hardware-monitor to temperature-sensor.
- Fixed indentation of nct7802 subnodes.
- Swapped eth0_macaddress and eth1_macaddress.
- Removed pca9557 subnodes.
- Reworked GPIO names to be more consistent.
- Moved documentation of aspeed-pwm-tacho from txt to yaml file.

**Testing**

Ran `make ARCH=arm CHECK_DTBS=y aspeed/aspeed-bmc-asrock-altrad8.dtb` and
verified the messages about the aspeed,pwm-tacho device are no longer present.
The remaining messages are:

arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2500-lhc']
arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2500-ibt-bmc']

Rebecca Cran (3):
  dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
  ARM: dts: aspeed: add device tree for ASRock Rack ALTRAD8 BMC
  dt-bindings: hwmon: (aspeed,g5-pwm-tacho) Move info from txt to yaml

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml      |   1 +
 Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.yaml |  91 +++
 Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt  |  73 ---
 arch/arm/boot/dts/aspeed/Makefile                             |   1 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts        | 612 ++++++++++++++++++++
 5 files changed, 705 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/aspeed,pwm-tacho.yaml
 delete mode 100644 Documentation/devicetree/bindings/hwmon/aspeed-pwm-tacho.txt
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts

-- 
2.47.3


