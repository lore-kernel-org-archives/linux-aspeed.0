Return-Path: <linux-aspeed+bounces-2264-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E586CCAC59F
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Sep 2025 00:01:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRwlp4Xltz303B;
	Thu, 18 Sep 2025 10:01:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758132675;
	cv=none; b=OPr44rBFuYQFUrP6+kTpx3QjS4yJwSB+1YKYYiZOE4I6Ox1AJ3qNQ5bFos1nyu9g3mSHIy2Xh8xOklK/KNNbae9bQ/V8DJXdDKJgSfYHGDe7igNik2q9PWMMHlxa05AJHteV77bAyKJbAAukwATFUap0Kzrev6KOP4UVICibjm3tSy1eisWs3oycXAI0Zh7CFqrotu0IqzRnMj+XIDiqobTghNQcnFuO3ES5vfzirVNrL9mMSPVSpAbr6yrI9KVoj2bd0ybF4WQ4T43EJjxvL8XMFBxZKiTg8sMICCvQuiB5fhSG5tgllTu/WU47QRiRP+NQeo8BXKBEudcUGDDwPA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758132675; c=relaxed/relaxed;
	bh=MmY+rQ6CX5jSxSv8cWbPfwXi6SSyhtzs/3Z2Z1CrXyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZsTAoQe0rTdhcF60Mo3tLHO2K9dIp82y1t8JLAsTgP32ee3ZYgXAeMmjbSee/ib+dEObgfrJ4o/78L5ZSDvI61OKfYLAD2w54mQHJ+M7wbwz0soIn7Pwd3W21VtE0wUmKjmm7EPKTJi4eQ7cJC83tj1SU17VTN+CD3xg97UNMijIC5loq+dCobfRUj3CDevfIMni/VF4lgAYYaWUOwODuh7pS9qrlS7slRKxGRcvvxVGgHK1NgQTieoCP9BjBUNnYY6hDhDW/eb5YE7970NfUVrFm5b4plZHeDSMLzkMjqOOwFlfpyC/S5jJ7cluxsg2Si8zUSbwA/rgY1mFPfKUw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com; dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=BbMYj2Nx; dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=Jj2Ss5bD; dkim-atps=neutral; spf=pass (client-ip=103.168.172.146; helo=fout-a3-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org) smtp.mailfrom=bsdio.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=bsdio.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bsdio.com header.i=@bsdio.com header.a=rsa-sha256 header.s=fm2 header.b=BbMYj2Nx;
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm1 header.b=Jj2Ss5bD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=bsdio.com (client-ip=103.168.172.146; helo=fout-a3-smtp.messagingengine.com; envelope-from=rebecca@bsdio.com; receiver=lists.ozlabs.org)
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRmzk2sBFz2yhD
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Sep 2025 04:11:14 +1000 (AEST)
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id A272FEC01CE;
	Wed, 17 Sep 2025 14:04:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 17 Sep 2025 14:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsdio.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1758132275; x=1758218675; bh=MmY+rQ6CX5jSxSv8cWbPf
	wXi6SSyhtzs/3Z2Z1CrXyE=; b=BbMYj2Nxl0uG8TrrV+4MPx/MCLl6dy7zI61qa
	xBM0nMs1RBwkUYUapcvKROnSvxMGden3l78ZuxwEWN1qQOaArdoQKzUGjW9DJ/JM
	/EJyIwJR5JIO316qTScS4VHvozdl9qBGUjFRy/ofHFKmVJ5agECrly5cMjrlE1Ga
	9f4BscYy+IFx3IzSaDc4h/BFEGukmOn7DDmER3WMfwbRSO84GHPWoahEckuVLc8J
	wRbCvF4D1r0ZuFxfABGZ5b5NK5tYJbCcLY7XWesPxPVS3i4ZdIDMCwhpZl/zb33H
	tXZHVj5Mv6BXQnVlRZcA33nHs2OxS+ptlfXrvbOswoca/3zNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758132275; x=1758218675; bh=MmY+rQ6CX5jSxSv8cWbPfwXi6SSyhtzs/3Z
	2Z1CrXyE=; b=Jj2Ss5bDsETXiZgw8z06njHdzi09K2fNOYwhRKOFT59LtHAClh+
	bM+0FYmfrWYYj04ER54Yl6pGOgJnkjFjT5u3uQmZgXD+oj5NTFuLAXj9SRn2Mmq/
	6+mju9Erp8FP9QxkcrhLsOFAgaNaEz6ryGgZJnFGCJX1l2thLFh1fIogst+x9eRv
	3yLNxpxrof+oS8JLi0vY6mGwueN9NSjHDM/QEfAbjiBr9GHKz/bjQtC/QvqeX+H1
	+SVeYZ42s0AMHl7HNWgeePRVkjrrbDVDuTXyGve8F0s2stE+QzuYRhzeUlGMNTTr
	HQmkv80oIb5hKsS0HKuF02GPFfW6pq6E9+A==
X-ME-Sender: <xms:MvjKaBtfT7UYX4UvmktezWeYaOG9mpp8GTuTWYluG3GKGizyq_WwWA>
    <xme:MvjKaGQrU1alR1FA_ai-FXWJVqJvZZjQdiCMfZRRridgRa8d52KkRm07mfR02zNLQ
    _7ovBrp1GplZB9Y0Lo>
X-ME-Received: <xmr:MvjKaAKL5vpkJTwu3HW-8dCdsSEKQV6rlI0Vx8ZZ1Wmg6-FRdz2ehfLeYwfa4dNa6N8tTAKSWm5y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeftvggsvggttggrucev
    rhgrnhcuoehrvggsvggttggrsegsshguihhordgtohhmqeenucggtffrrghtthgvrhhnpe
    eghedvvedufedvheehvedtleejteekudfhvdekffevudduhedutdekfeehheegheenucff
    ohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprhgvsggvtggtrgessghsughiohdrtghomhdp
    nhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehroh
    gshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopehjohgvlhesjhhmshdrihgurdgruhdprhgtphhtthhopegrnhgurhgvfiestgho
    uggvtghonhhsthhruhgtthdrtghomhdrrghupdhrtghpthhtohepuggvvhhitggvthhrvg
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdq
    khgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplh
    hinhhugidqrghsphgvvggusehlihhsthhsrdhoiihlrggsshdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:MvjKaBs5kwkIojafz6Rn0y2e9cFGWP988O5fGOwjAd7Jh2UwDKb8Wg>
    <xmx:MvjKaP8obK4yI20rtg5irglefP4zhIukd0Xm0IfWPaOslY8XD4X4VA>
    <xmx:MvjKaD1g9YhaeciocwmF84hAUTHD90wdaDq93DJqZU0XNoq_mCuYww>
    <xmx:MvjKaMjVxSxzopX5fSUUhsxtz2iugk2RAuhctS3lKuFHP1jkW-l5fA>
    <xmx:M_jKaE7Ey3LRWLTDa2HFRiC8e7nHzmeuInpx1vEOF7oPXZvy36zT-znf>
Feedback-ID: i5b994698:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 14:04:33 -0400 (EDT)
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
Cc: Rebecca Cran <rebecca@bsdio.com>
Subject: [PATCH v2 0/2] Add device tree for ASRock Rack ALTRAD8 BMC
Date: Wed, 17 Sep 2025 12:04:24 -0600
Message-ID: <20250917180428.810751-1-rebecca@bsdio.com>
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

The ASRock Rack ALTRAD8 BMC is an Aspeed AST2500-based BMC for the
ALTRAD8UD-1L2T and ALTRAD8UD2-1L2Q boards with an Ampere Altra
processor. The BMC runs OpenBMC.

These patches add a device tree and binding for the BMC.

**Changes between v1 and v2**

- Reordered nodes to be in alphabetical order.
- Removed status lines.
- Fixed naming.

There are still several warnings from
make CHECK_DTBS=y ARCH=arm W=1 aspeed/aspeed-bmc-asrock-altrad8.dtb
I believe the only one which is reporting an issue in my dts file (as opposed
to included files) is the first, and that's because the code partition contains
the TF-A and UEFI areas. I couldn't see a way to suppress it.

aspeed-bmc-asrock-altrad8.dts:578.16-581.6: Warning (unique_unit_address_if_enabled): /ahb/spi@1e630000/flash@0/partitions/code@400000: duplicate unit-address (also used in node /ahb/spi@1e630000/flash@0/partitions/tfa@400000)
aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/memory-controller@1e6e0000: failed to match any schema with compatible: ['aspeed,ast2500-sdram-edac']
aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/syscon@1e6e2000/p2a-control@2c: failed to match any schema with compatible: ['aspeed,ast2500-p2a-ctrl']
aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/display@1e6e6000: failed to match any schema with compatible: ['aspeed,ast2500-gfx', 'syscon']
aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/timer@1e782000: failed to match any schema with compatible: ['aspeed,ast2400-timer']
aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/pwm-tacho-controller@1e786000: failed to match any schema with compatible: ['aspeed,ast2500-pwm-tacho']
aspeed-bmc-asrock-altrad8.dtb: fan@0: aspeed,fan-tach-ch: b'\x00\x08' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
aspeed-bmc-asrock-altrad8.dtb: fan@1: aspeed,fan-tach-ch: b'\x01\t' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
aspeed-bmc-asrock-altrad8.dtb: fan@2: aspeed,fan-tach-ch: b'\x02\n' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
aspeed-bmc-asrock-altrad8.dtb: fan@3: aspeed,fan-tach-ch: b'\x03\x0b' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
aspeed-bmc-asrock-altrad8.dtb: fan@4: aspeed,fan-tach-ch: b'\x04\x0c' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
aspeed-bmc-asrock-altrad8.dtb: fan@5: aspeed,fan-tach-ch: b'\x05\r' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
aspeed-bmc-asrock-altrad8.dtb: fan@6: aspeed,fan-tach-ch: b'\x06\x0e' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
aspeed-bmc-asrock-altrad8.dtb: fan@7: aspeed,fan-tach-ch: b'\x07\x0f' is not of type 'object', 'integer', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
aspeed-bmc-asrock-altrad8.dtb: lpc@1e789000 (aspeed,ast2500-lpc-v2): reg-io-width: 4 is not of type 'object'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
aspeed-bmc-asrock-altrad8.dtb: lpc@1e789000 (aspeed,ast2500-lpc-v2): lpc-snoop@90: 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/mfd/aspeed-lpc.yaml#
aspeed-bmc-asrock-altrad8.dtb: kcs@24 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
aspeed-bmc-asrock-altrad8.dtb: kcs@28 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
aspeed-bmc-asrock-altrad8.dtb: kcs@2c (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
aspeed-bmc-asrock-altrad8.dtb: kcs@114 (aspeed,ast2500-kcs-bmc-v2): 'clocks' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/ipmi/aspeed,ast2400-kcs-bmc.yaml#
aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/lpc@1e789000/lhc@a0: failed to match any schema with compatible: ['aspeed,ast2500-lhc']
aspeed-bmc-asrock-altrad8.dtb: /ahb/apb/lpc@1e789000/ibt@140: failed to match any schema with compatible: ['aspeed,ast2500-ibt-bmc']
aspeed-bmc-asrock-altrad8.dtb: gpio@1c (nxp,pca9557): '#address-cells', '#size-cells', 'gpio@0', 'gpio@1', 'gpio@2', 'gpio@3', 'gpio@4', 'gpio@5', 'gpio@6', 'gpio@7' do not match any of the regexes: '^(hog-[0-9]+|.+-hog(-[0-9]+)?)$', '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#


Rebecca Cran (2):
  dt-bindings: arm: aspeed: add ASRock Rack ALTRAD8 board
  ARM: dts: aspeed: add device tree for ASRock Rack ALTRAD8 BMC

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml |   1 +
 arch/arm/boot/dts/aspeed/Makefile                        |   1 +
 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts   | 633 ++++++++++++++++++++
 3 files changed, 635 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-altrad8.dts


base-commit: 5aca7966d2a7255ba92fd5e63268dd767b223aa5
-- 
2.47.3


