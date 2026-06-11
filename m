Return-Path: <linux-aspeed+bounces-4236-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB3ACD98D2
	for <linux-aspeed@archiver.kernel.org>; Thu, 11 Jun 2026 09:05:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gbcDh0MFyz2yQH;
	Thu, 11 Jun 2026 19:05:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781168723;
	cv=none; b=b1mNRRVVaQh7+8p9DYGCJrfCRa5lh4IYDM+BjyCHY7jgVntVaqlr1QlpqXr97L+6KkD1h9B6aPbFR2xLufJSeiz09sTJSuXbGQmE/wZ4oSfHdLAGtmwLLYEoZht9GM/JBjZGKgtHeaqupM312zl6gb/GDnYqJMGgZB7uAUHJ0CNTN73xrXkTuIt3tiuU+LILwRb3aod+OMSFb11gEeCoQZnLaZXqkPSWJNdKYirSp51mrQSnK8WLc2c9eqYTd8vTABhq4oYYUKW1KKIcvDLvVAnC5ZwQ9FpXkGLzfs+4eYCpF21fn+I1Ox2+PqWtAhK7NoMuKv3mKkDD5zLVUpqTgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781168723; c=relaxed/relaxed;
	bh=1Mj84MHRpXBohUBJnwrZGqmrt19z2ndsx48TqvGHQGY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BfvQ4jeNtQQENwVkGyek2NnkKMnWhpCq+S7uW+xwxJsi6uGJhzLPOJxll2Arcj6y9wi9FSklyHQ38Qgb3k0dnJqWEORZmJjnkPda3eI3vsR2Oso+iGGPNHP8NpyyEWWXuLZDfTJsKnLtOckZR+AtLwymKhJMIhq4yPHiQwVomZWsUzl+bFgNqWvkfXcU+y79NEUgYMzcbyMpdr897YlVTRpJvibWqaNj/zgPe1kgToYiONEI/PHlwjeCcgadKlKtMgASC5Ch34f7ggQYhvVYmXrTnuShAHG30JaMN4rIax9UJTw3J2zzL/DqEL9rs5XqDeB0DwZPM71wzHsZ6FTmPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l0ryD2A9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l0ryD2A9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gbcDf65XQz2xl6
	for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Jun 2026 19:05:22 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-8419ab3a297so3459699b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 11 Jun 2026 02:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781168719; x=1781773519; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Mj84MHRpXBohUBJnwrZGqmrt19z2ndsx48TqvGHQGY=;
        b=l0ryD2A9tK4W6Oir4tTXvPgtjdj9Fk+zl/O9TXkyKTZJ0UOIXtbN+tnr+A090cZgkC
         QqFBs0gA6FPR9i1Zl3WYyw7NRSSel/eaobqGMA27e66rvDgW/ZuW8LQvtToGgAcqP68r
         FoSv3FDnFNIL8VgVlEjP44Z1jq7bDZh8PlgqE/3MnrtJiq82Vi/SdYush3sT1BqW5t/n
         DgwDl5G8rXuKtfOp++Ef1zZslGOjo2n/CS4eMHZUWS38YLotdA1QcawEsE8cx/y/yxhn
         yxO1WXFfMXbTUot8L7WvcW5BX5ypWFCIifc2KczxPgvdrkUAzx5bA1KgH5aeMBGXxCX+
         5hEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168719; x=1781773519;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Mj84MHRpXBohUBJnwrZGqmrt19z2ndsx48TqvGHQGY=;
        b=KNqZ6bHhvNBk6VhGou4Gd0Z4XWglKkWM3ZrfU2KUCVwMmy4E6T60BACjt7ICyORfSM
         bXWsi0rYR1RaOp0OdoyBv5MVVAwbcqai6tPpDLaK8mXdlf8ShLGrJw40UtFba4+Fpc1x
         gNbqO+0tqh9l0Z9kvoj6z6tU7E/ICNtxSXzk8xRJ9KaJp05CYkvupZtuP6AF5UEeb0Mv
         XiR+YQpCB2orDkcylSybcwhDO/lausYvdvuHDdFlb1fV8b5my0AdkwtN/DQgOYdbO7uu
         MRdmQuSBQdSS5WV71EyhmKmVXOrGDrit3YyQzLwXkzz6i3Hj+rFDkZluMxdkpoAA/eug
         kukg==
X-Forwarded-Encrypted: i=1; AFNElJ90jJUM4cVc1GHxZ0To6JDRXj0UxAZw8+mbv5knAlyIYKqLlr8MXB9P+yuMhUgWZA7bn8F5UR56KgWNqoI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzQn0oHgP28n/dvpzltBmhHMRXE6y4nvDgCDhBKvsh2Tqsfn7HT
	IxRS2re0xLGPjNggMwCLWpj/wD4MaD3K1c4Rz+rEj342DazprLxY0Ip01Z7WXg==
X-Gm-Gg: Acq92OHUClW5WbXVM+mSwnj00PZ9ReVgBX/shGRIGVP8XuIK5pC/dBdRjN5BCrEm9jc
	Wr77xdEBLwAjU6ai3xSFpkukWnfsjQUduaaoFI43p8peSejC1sVReYGtP9HOa6aOzNZuCahyvOc
	cF4qvixcz/jJ+J4MieNntU4c5zWMvvC8CS5AsoMhJ5/KGwrGwwne9LEG1NAnVoC6cvpJ2mOjagH
	dtLRAa6Rl4JwUaAbeEkC39WnaC9GXTunYdQpT5yMppWgkO2Z79I/wV3lbjha7ry02EBVkI1iRqm
	43ZqDL0BW7yn30d2v77n7MJZ4VTivuPTu1+F/E89w7Kk01kDg7/M5MbOCfYL86PXXXssqZxFvun
	5VPJXzrvhUbOBWisivbUTVZh6Jv4tV0ypIeR06x9X7ZYyMxTFE5XK8PYJhdP8/MsESiJ+wH0rVz
	CRQcdLst70YF0s6AhNQMyISMxmSdVwC+q2BDRyopLBeFOcN2qoRgUCuWdbitFNWpeK2CwhzH7CL
	g==
X-Received: by 2002:a05:6a00:3923:b0:82c:24d5:63e6 with SMTP id d2e1a72fcca58-843367fac80mr2183974b3a.15.1781168719266;
        Thu, 11 Jun 2026 02:05:19 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337b8f8f5sm1456306b3a.5.2026.06.11.02.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:05:18 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v7 0/2] Add Meta(Facebook) ventura2 BMC(AST2600)
Date: Thu, 11 Jun 2026 17:06:52 +0800
Message-Id: <20260611-ventura2_initial_dts-v7-0-a61d8902bc5f@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAKx6KmoC/4XO22rDMAyA4Vcpvl6GfJKTXe09xih2LLeGNhlOZ
 jZK3n1uYDRkmF3+An3SjU2UIk3s5XBjiXKc4jiUME8H1p/tcKIm+tJMgNBcCNFkGubPZMUxDnG
 O9nL089R00DkpjPGImpXVj0Qhfq3s23vpc5zmMX2vVzK/T/8BM2+g4QGQI/amtfL1dLXx8tyPV
 3YHs9giqoKIggTeSWe1V2D+IPIXQeBcVhBZEOFd8BatdsrsEfVAVPUTVZAW0AGQVZKrPaIfCEJ
 bQXRBpCHSrg+6dbhHcINwqCC4Itq31HlDLmyRZVl+AFvMVCwRAgAA
X-Change-ID: 20251222-ventura2_initial_dts-909b3277d665
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3863;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=BWMEDVmRB9JbQvI3sny8iiY3wE+9xE1sfKpPw+QYZ2g=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqKnqvh2zpBy6ioUsMjhQQ/gemnH1NixS0Vhlbn
 xtGQw885NaJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCaip6rwAKCRClg0K3CVbE
 gX52B/47PPYv7zShvvHHybO0MT9Nhdz+03SiBForwG1BKHKqGZBOn0tuWkAWgq69eTU4u34zFLo
 xFrbWNBLo03BtOi1GjhQUK6Lpe6uhoNww8ppssf9N3PGXck0PtkjDl/kg9bdmZENALVhp6eCVSX
 XzQr9E5YKmJIOwvEbvIz3nDn8HThBj5DIQ3UsDa8i7h+DeQ8nkqPgPwBXS5Wc5kYZrkdwxjGv/y
 pCF504ZBITKVvNjUo6sRb+Cn9HBO4OviJibv4yAGYEAV4QW/71Fy34yFx571sa4AWsfQRIzp7Nr
 qqHA/ZB7l8u57JjWy0HiIgMOORgDpPvMyXy99cbHHhfV1aJV
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Summary:
Add linux device tree entry related to Meta(Facebook) ventura2.
specific devices connected to BMC(AST2600) SoC.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Changes in v7:
- Updated the commit message to include a detailed description of the Ventura2 platform's purpose and its key hardware features.
- Fix comments from Andrew Jeffery:
  * Ensured consistent blank lines to separate child nodes from parent properties and from each other throughout the DTS.
  * Sorted fan nodes in ascending order.
  * Replaced '//' comments with '/* */' block comments.
- Fix feedback from Sashiko AI:
  * Added 'idle-state = <6>;' to the PCA9548 mux on i2c4. 
- Link to v6: https://lore.kernel.org/r/20260610-ventura2_initial_dts-v6-0-375d8e9d7ebf@gmail.com

Changes in v6:
- Addressed automated feedback from Sashiko bot:
  * Clarified comments that io_expander0 and io_expander8 physically share the same interrupt line (Wired-OR) by hardware design.
  * Removed leading zeros from unit addresses in DAC nodes (dac@c, dac@e, dac@f).
  * Removed unused properties from the adc@48 node.
- Link to v5: https://lore.kernel.org/r/20260608-ventura2_initial_dts-v5-0-37ee5bcf58b6@gmail.com

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
 .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 2897 ++++++++++++++++++++
 3 files changed, 2899 insertions(+)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251222-ventura2_initial_dts-909b3277d665

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>


