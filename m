Return-Path: <linux-aspeed+bounces-4193-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351F0CD8C8E
	for <linux-aspeed@archiver.kernel.org>; Mon,  8 Jun 2026 04:16:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYdyL3qWhz2ytV;
	Mon, 08 Jun 2026 14:16:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780886441;
	cv=none; b=CYFxe5GTCmAy0rUJpY6EL+8LiC5R6YbBU7thtRXQvWKe7AFNjgaMGvFtUTgBHvMnL2g01rEzkmS8BbHvwPASEK9iUXBRN//iKaFZB8bVGj+/+n9QxPwaMMZ1gwyHXbTQyxwKAQIi40PZXp0Nu//Ms8UmuaafTRQzTD6wAy6vVBN3PTbgoDMetc5hQ6xtfhEAV+WnS7H19lE2hLO5b1C7jf4TlTY4PtRlBnw5TRlt96XX25PItenXDXmnlLa4JXqlVUX7zTAfawrOM1l+o7ipei1ZRgR+wOIJrLsqzdEB7L1Rs2uqAZrUY/fmgX/WlKxkkxsnS6ClPujW+zDOhcE0vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780886441; c=relaxed/relaxed;
	bh=38SrOSOGK3sCwLNpHejTdRoa1jMmte3Iy/3zoqwAvic=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Ol0DEfsgpqGdk2jdA+j36Su1dYHPLq+bxVLBKY8z0EM0uJVNGTRp9psTr6Vs7T1AjNtDcOQVVAGZAeDrBVX8m5tL4B8BrE+cd7o5AMy8d/L7kbbG8op9Wq1SwdbwWxvKtlEGvXvbSMxeQvI2Lc2n7XxwjBsocBJVux5eaL/DpiuTeGwXqbUZQNWdI0wzmVHgPefOtkbqq+S5iF1GmjAsNoc5Wr1BBgI40YLGw6OL8AsHeGZ4Jc4bjY9WliMVTxT37ScjFw9UdLr0uxCFkvjaMpI4DM2C6VEIfyVFcos7cAQnwkQJsuKKfNp9twnVbsy8W9ryP46tT+IOTkhtq722rQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NHqCgg53; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NHqCgg53;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYbr76bGpz2xqv
	for <linux-aspeed@lists.ozlabs.org>; Mon, 08 Jun 2026 12:40:38 +1000 (AEST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-842358aaf36so1313679b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 07 Jun 2026 19:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780886435; x=1781491235; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=38SrOSOGK3sCwLNpHejTdRoa1jMmte3Iy/3zoqwAvic=;
        b=NHqCgg53yuc0YtgGMnKfqSyJJnJZQ+ZOM1tbdZHnJi0zRz/FXMh2DqWJEoM/aB874e
         Xy+QOhhKrlddUvkG38H1f2GF5U6q775nHcdt4Hq9vHW4DIuGXdDQ/apHVR6rJEAstCII
         3Dt0HQdPFgjKYeovhksS8bJTR2wF4UN8GAe1Lo3fJJANDauw4lRibUv7DQT7Q8sw9ZOk
         dXxSLi20asN+lw7C3X6ptE+dtvp6uKa/orb+KMAmIPCEDZUgeWXTo7WhIKU8vvSLvLW3
         XjZcPrwonMlFDuR/jZ/1SAyrZXM1tDEw9JCUx6Pi7JkxXWAsjgxqPETlSAUMyoyi8FWH
         Q0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780886435; x=1781491235;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38SrOSOGK3sCwLNpHejTdRoa1jMmte3Iy/3zoqwAvic=;
        b=J/g/ieYrQg3o8IIx9ZMSch5jrzmWKRdq7+RO85K6cigqxzzW4rYnw/ET7xHHoXZ5KA
         5NZH1HkwV2s+a0rIGNd/bAsg0Fk7u7B61vKSUKxnPiej4GQmHmlibmcjwOLsm5P01edQ
         XhBeV4cMAwPmfnR3po/4rj7KLInJpO4CysBeg5C4HIww3oYjDIX1Qu4yaVv0WioI1HyD
         3xEKlJOs1k7OxEqW3rgUUv/CoSmeYFYLPRJORREfesOhceKWwtYdfNk/Qi0JyYT+ic96
         ARrQrhqezQEQD8yVMKLsDLpmeUV4Uxd0Gv+KKxfid2d/zOmXPCiuYPw0irYRh31mTIDd
         VVCg==
X-Forwarded-Encrypted: i=1; AFNElJ+oyuDVt+zEblU/DvgPGzCc1bXNHRg8JgEbbeAAZQbJmffXOJeHTxnBfmW/ijDt0hWNIW71Ns5SB+jvNC4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz/DdlM+T2/jw3fna2pf6Vc5U8crMJGV1Pp4plcPFWAsCjNiIh4
	mDwSleLZpquk9b0IoxpSYVO6Y/KniXugCGXOn3U6a0CQ5t8nhL5NcsVh
X-Gm-Gg: Acq92OFA8HKyVQ7iTDTjj1EPshXJkMuOW+X3gKJAGQ0K9ioXSJa9SGT7/zlfrP+uIiA
	0T7AehheRrJtDvp8oaC2UeyF1TrkJ8GP/i8z75VHqOzGNfw9R1FY0/q+J/N2sR09HJL3vifjK4g
	NS0mF1jqtm8rt7BNChupNVu+GyAJ6T1mdnMhTsakgGREZBCU0x8OXne7GzBGGho8qoMRhHuqKni
	IvAC5DyD/oGIlFzlHsMrXp5VF8DgDtbPRUE3AtJKpbsYSy2qfphG0OOf6DXCuQjE7d8eTTzdKI2
	L0zmLBHUR5mL5Ii9QGmyyE2bfckl6JHnnXcZ9LaLr48ukUxunrRbmSPAlAR89VoxFTnumVcuykB
	lSxY1InpAyyCoM/MrJQmsD5sTjaS48UcYjFFw+yijhFKuQkut2cegCcBEgpoPLPfe0Ajrul2I1q
	H6gMPRk9mNeCGC2VKtEGWD8bQsS9jusGzOrtr8NKVKXMDp5s8e0MbtzcIv2GRstjAo5AflKf/xV
	g==
X-Received: by 2002:a05:6a00:844:b0:835:405a:7e6d with SMTP id d2e1a72fcca58-842b0ea14f4mr13899922b3a.21.1780886434827;
        Sun, 07 Jun 2026 19:40:34 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842824a1cb4sm19310520b3a.26.2026.06.07.19.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 19:40:34 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v5 0/2] Add Meta(Facebook) ventura2 BMC(AST2600)
Date: Mon, 08 Jun 2026 10:42:07 +0800
Message-Id: <20260608-ventura2_initial_dts-v5-0-37ee5bcf58b6@gmail.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP8rJmoC/4XO22rDMAyA4Vcpvp6HLJ+aXe09Rily7LSCNhl2a
 jZK3n1uYaxshF3+An3SVZSUORXxsrmKnCoXnsYW9mkj+iONhyQ5thYIaBUiyprG+ZIJ9zzyzHT
 ax7nIDrqg0fvonBVt9T2ngT/u7Nuu9ZHLPOXP+5WqbtN/wKokSDWAU871fkv69XAmPj3301ncw
 IqPiFlBsCGD6nQgGw34P4j+RhwopVcQ3RCMYYjkyAbjfyPmBzGrn5iGbMEFgERGK/OILMvyBYq
 Xx9SHAQAA
X-Change-ID: 20251222-ventura2_initial_dts-909b3277d665
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2830;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=Gi78jGqhca4I3YcILxH9j+RePrTUjsAyMzxkhn6QReQ=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqJiwEBeVbdsZIqyr8QR4WZFHc+4DWcWIpgMLHD
 L4ZxmsorE6JATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaiYsBAAKCRClg0K3CVbE
 gfajCACvzmERcaUA5uZwA+10S/TWH6Nt3JMJnEm+URle13QSepXcDkTNb0eQmi4RsfL4iVmNsoc
 /HrrnqUGJS4o41K7I2CL0WynKLmUiv4gJQx4v5jymkNb09RR4n3mHvvXI8BdNz4VOZBoS0tusQi
 zAsZD4NI9x+3U+rCzFfRt5VdWzbutkScoAIOT9XF1kk5UdiR4MRy5LqpoS9UDPQRnhNmI0fewMU
 MxixylKyvMS7KPizt0rf59y9QmhNnq9BXaQG9zWX/PCWIJzlVAKJHQMRwrxVThJ69V9z+MdpIXz
 hDeKrlubXoPM2vXYsHHpku5Y4zXSK0vPfeBqgjBVmp56DV8T
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Summary:
Add linux device tree entry related to Meta(Facebook) ventura2.
specific devices connected to BMC(AST2600) SoC.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Changes in v5:
- Addressed review comments:
  * Added comments explaining the necessity of 'legacy_' prefixes (hardware label collision), pre-allocated I2C aliases (future expansions), and the 'ledd1' naming convention (schematic alignment).
  * Removed the empty `&mdio0` node to comply with upstream networking subsystem guidelines.
  * Removed the redundant `&peci0` node.
  * Sorted `&kcs3` and `&lpc_ctrl` nodes in strict alphabetical order.
- Hardware/DT alignment updates:
  * Removed unpopulated sensors (adi,adt7461, infineon,tda38640, ti,ina230, ti,ina238) to accurately reflect the current board population.
  * Added the secondary flash node (flash@1 labeled "e810") under the &spi2 bus.
- Link to v4: https://lore.kernel.org/r/20260424-ventura2_initial_dts-v4-0-806b00ea4314@gmail.com

Changes in v4:
- Fixed capitalization: "ventura2" -> "Ventura2".
- Reordered I2C child nodes in ascending order of unit addresses.
- Enable PECI, LPC control, and KCS3 interfaces for host communication.
- Configure MCTP controller on I2C4 and enable MCTP support for specific mux channels.
- Add Infineon TDA38640 and TI INA230 power monitor nodes.
- GPIO and Pinmux cleanup for PVT:
    - Aligned gpio-line-names as requested.
    - Remove unused or non-existent GPIO line names to align with Ventura2 PVT.
    - Update specific GPIO pins to empty strings where signals were removed or consolidated.
- Adjust SGPIOM frequency to 200kHz and update signal line names.
- Enable UART3 and add serial2 alias.
- Link to v3: https://lore.kernel.org/r/20260113-ventura2_initial_dts-v3-0-2dbfda6a5b47@gmail.com

Changes in v3:
- Add annotation for marvel 88e6393x
- Modify the gpio-line-name
- Modify the node order alphabetically
- Modify dt-bindings document for rmc instead of bmc
- Move the gpio-line-names to original node
- Link to v2: https://lore.kernel.org/r/20251224-ventura2_initial_dts-v2-0-f193ba5d4073@gmail.com

Changes in v2:
- Remove unused mdio
- Link to v1: https://lore.kernel.org/r/20251222-ventura2_initial_dts-v1-0-1f06166c78a3@gmail.com

---
Kyle Hsieh (2):
      dt-bindings: arm: aspeed: add Meta ventura2 board
      ARM: dts: aspeed: ventura2: Add Meta ventura2 BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 2888 ++++++++++++++++++++
 3 files changed, 2890 insertions(+)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251222-ventura2_initial_dts-909b3277d665

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>


