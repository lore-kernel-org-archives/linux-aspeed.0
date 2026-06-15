Return-Path: <linux-aspeed+bounces-4254-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F573CD98C5
	for <linux-aspeed@archiver.kernel.org>; Mon, 15 Jun 2026 02:44:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gdvbH1vCXz3bqD;
	Mon, 15 Jun 2026 12:44:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781491467;
	cv=none; b=FueeI3VFsZp1Q4rRlNXTvZTYNCNNoykA1QUxtaqy5LoenriK0MVeUf8paWUyXZ7ChFL/ynZs5/Y9vYD0buEzXF/jrnf5RpprtldoaEvfQTpg8MeMpqWUSNtRqzdtnsziLQJX5q6fe2LohMCmQ215rU8mD2/BKr+xDCfZc1bQwYCWu+UKj0rfUKxVR7pUTK02u5AOg13xLpg3FtfjlErRsRlkWKei2oZ6z6WKnU6A6Ne7HFfUiJFbex3Np7+Vx/mFWH0leDiEdnKlSgVFVUyTyjcLT4B7DEuDpLLgQLxYUvHalpDe2wlNpDvDoQ9IivvOXnGNQGjuixJVSDkEfthmIA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781491467; c=relaxed/relaxed;
	bh=fQuGdM2CJQXaRNDTIGDSfZydcbPeUd8rTAur9l3mo3A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B+iC/+IfratNMIy+XWWgakFQici2JlHwfpEfoM09KS+ybxJOzlbXBHCoRYEcpkmAefcLWKVXNx8mj5LQBRAC0f09X6CSlHTjzd2rjkGAu6UVWz+igVX6y9W32rkeshBGlUHqEZcf6Q36tN3Efc0v/XnJYGDp/u4SpAHE3ZHcdewYY9Vcrd4MYnoWtEs0bPACbb3q6IVn1lvKYJNlEcFEgxOIT2/korM5mORAuAwQKelKZdZLoK+YTV+byrePnrZPXsorH13TguUw/+jbbiH/RIeqpBzxnO3VyJJ0wsXfRFkm+uwtcAH85+LQxd27YSwIYCIbIkwEkgyBDONZLkqSCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e8698OSa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=e8698OSa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gdvbG17kyz2yT0
	for <linux-aspeed@lists.ozlabs.org>; Mon, 15 Jun 2026 12:44:25 +1000 (AEST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2c31212104cso10942425ad.2
        for <linux-aspeed@lists.ozlabs.org>; Sun, 14 Jun 2026 19:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781491463; x=1782096263; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fQuGdM2CJQXaRNDTIGDSfZydcbPeUd8rTAur9l3mo3A=;
        b=e8698OSavR5MKE8lVnCb4GtXN0g6Bd4yIs/lNyc/zw+X/NA85MuitQ80XKmYPqS1G8
         n9zX9jcMTwiGwmJV3/MMglxyuXtZX7eWqRJAtJKdgFqdXy8Ulq+VHkl4n/wWXK7BdWT0
         hcaQuClUXaOBqGMwG6JMD68W/IDG+z/Q4EA4kkyH4JgxUxlH/2qrvwFBfDTOfSthfhOP
         xPvlb4TUQLACc5JN8QkyCacqiRHujaUD0OIRtZOnGr69NwT+5hId6INR2/QeLOE4DiZC
         uKpWr6z6OeFp0SmfHoG/5UIfQHwRAfd8sCPH0BeuGFU3YjavSUuYY61aXPkhC8eSBitJ
         mrmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781491463; x=1782096263;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQuGdM2CJQXaRNDTIGDSfZydcbPeUd8rTAur9l3mo3A=;
        b=GU5qL8bpiYAOLBvofguh2G0mLxiq9jfLaSkA6FXsI8WnNPYfjA/nt3BFZIYSG4EIu4
         BBFqKb18AiH/HtBc/Jl/BT/CZsACbB7ESfPA1HsJN1xk3OOl/mn4p6/GJmPHLeAJpZ7f
         p2rtiH4sfaPwDTPUk1r/k36xUTLojRqgeV5kJ5zl/vcz8ABgvMsiFQkKC/VcSgxP6m+6
         47uOoiiqvZfJkoiEo51zSvkFjRQ3ZtBuRR0H/Z3VcvM/Qe2NvYv52lT+M/rQTQBFl0+X
         dA8Le1sM4gEwY5gBPYM+M7kMgmSTGnds3TiyXDCDzW2kXhKrcJZBKHnyTtevll74hdaX
         +jfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/grCcIp+MA46NqJjzaIjl3iR4RmpJbLLsbqJLaPi1CFiJ8YHbuVQCsdqI1NpngEj03hkvhKU4Q4i6DKJQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy/rhnlRrzM5OxCri2AEN/VwJQ6Qrft1Ms8Xr8piDj3gXkKeCb/
	NDvsL51YvEftmMHOx4IvZG8oePoQ4WZhfhCbKVHFlY1xqPf6o9LBjKZT
X-Gm-Gg: Acq92OEZ+3dTjOVIpG899GjXj+ImleLHEFXzeY3Tbeaw0lSC98qtH2/wGfkgY5K2hA4
	l+t5+oKGTjtxeaZw9CiAD4KgGeA8EKkxycI8XgUQWJHXc+oW5fuVj9G3kQBEd3BBRs9nDJ2ytxs
	u019uGsmSvwl0Z8DkbUbE1oXaHeLlJ0gPGVnez44jbIQ0JXc/+tUHvN9Hi9UNf9hoP9ox+59aM4
	Xdqy1oYgKywa+weUvK7i4UZvmAfhaHR5HPROEjSQEkQ17d/n4I/ZKvyzLojY7StxaeUUlhktO0X
	4U9YdT7i8F+d87TAF/T7cD896khygsQLrMoY38KA3SnH08BQ2kT1GjYwBzOfkC/Rjq+nM2bcfMs
	mu0sO6hYWLRuc5Cqkjww0E6LjaXM9BiTFmBKgic4/R72FqVSiY04j5Julu1tGwX/LOZiwufybLf
	rlMTOAexJUX3t1QX34nhSAfw+3F3XYSp+JKNh/T6+246HXdk16Sd+Yo9aKZ/TXFIA=
X-Received: by 2002:a17:903:98d:b0:2bd:2de3:5181 with SMTP id d9443c01a7336-2c6641ef6a8mr105720065ad.9.1781491463515;
        Sun, 14 Jun 2026 19:44:23 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c866325d1d3sm7138676a12.11.2026.06.14.19.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 19:44:23 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v8 0/2] Add Meta(Facebook) ventura2 BMC(AST2600)
Date: Mon, 15 Jun 2026 10:46:01 +0800
Message-Id: <20260615-ventura2_initial_dts-v8-0-c89f92c80447@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAGlnL2oC/4XO22rDMAyA4Vcpvl6G5IPs9GrvMUqxY7s1tMlIs
 tBR8u5zA6NZhtnlL9An3dkQ+hQGtt/dWR+mNKSuzWFedqw52/YUquRzMw5cIee8mkI7fvaWH1O
 bxmQvRz8OVQ21E1xrT6RYXv3oQ0y3hX0/5D6nYez6r+XKhI/pP+CEFVQYgZCo0caKt9PVpstr0
 13ZA5z4GpEFhGckYi2cVV6C/oOIH4QAURQQkRHuXfSWrHJSbxH5RGTxE5kRA+QAgpUC5RZRT4T
 AFBCVEaFDUK6JyjjaIrRCEAoILYjyJtReBxe3iF4jWEB0RiyhNzVw16hfyDzP34jjJyNWAgAA
X-Change-ID: 20251222-ventura2_initial_dts-909b3277d665
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4257;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=3h3qFVrVCHwqA/9jJB20RsTtPzwqAaPlxKs6hDrBMFE=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqL2drhFWW9Ip8dlj2f14cILevLO2MTyU/2m3Ei
 PIkuV427ZyJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCai9nawAKCRClg0K3CVbE
 gTMUB/9x5bCCP2AyO20NPdO+gjy6d7sGgdpp5kUBZUx308VpT6TYKOLoou1dllpA+RlDeokdUau
 XP0gXKvPjTBdA5aSgBc8SZOhIaDlL+s2LS+iTf05I/445Y5v1qF5jhRBt9Sk+bGO9bWiwlZn2we
 Ucge/Q6UdVqwYQlLI061q6artDZhH+u2Vt+AJKBCqqQpU9eY7zM3bK2gb5V2CG6bQXATIRFN29A
 fUxmaK6R/7Ze9qpq3kUcvzkxiWFHOoS/zF1aWYf0u7IsQ8Un/CqUY0ZD+6OP1wQ7fKBJryWPXHh
 FjvV3AydxMHniehH2Wdu7Nj3BigOeiR/z8QXaZn7HNv0vjgf
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Summary:
Add linux device tree entry related to Meta(Facebook) ventura2.
specific devices connected to BMC(AST2600) SoC.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Changes in v8:
- Addressed review comments from Andrew Lunn:
  * Added a detailed comment to the Marvell 88E6393X EEPROM node to clarify its hardware I2C multiplexer isolation and out-of-band firmware update mechanism, explaining why there is no concurrent access or multi-master scenario.
- Link to v7: https://lore.kernel.org/r/20260611-ventura2_initial_dts-v7-0-a61d8902bc5f@gmail.com

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
 .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 2903 ++++++++++++++++++++
 3 files changed, 2905 insertions(+)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251222-ventura2_initial_dts-909b3277d665

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>


