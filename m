Return-Path: <linux-aspeed+bounces-4571-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382D8C531D0
	for <linux-aspeed@archiver.kernel.org>; Mon, 27 Jul 2026 04:30:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7ly76LlGz2xyl;
	Mon, 27 Jul 2026 14:30:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785126623;
	cv=none; b=X5JakI+1XXkBcaTrw3lj3UUbnJNTI1z4Q0+pWkl38oqeedm2Yik/5n2SQHttlma5oCwBTMfJ4Uqss3CBdRWwyWnEn2mKQ1r/rH0yIYFCxsGffOYOmp923fBUc/sd1khxlEaMSXtqkRx1Pk7nATfxoLObv0SLjJOa3XCoz/CLKIhk5CFSfWBma813WckQ6+Tr+8CZYXoPKMiTGg/nPrGM0/ix5vyKpiGSag0cZYTHPiPxXNIMpsvDxE3+SQn3n8WQ98uZNLU63NbugsbdSGqLAX7eOeHILEqgzLbnXr2W4ZyedjdwMbRaL/6k090i/4+b1OJMxtUudEQE1MHCcXdJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785126623; c=relaxed/relaxed;
	bh=hRs1ILFVuPcRsq3x/ZGBZ8F4Diw0x07EEaf1JzdhoDY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=X76bEGEXwfq88d5FheWBBEi2GjIjTm0X6gwkl/jnXeGoCn8u7RKyNSEi2Q6dk1gQWgfA/Td7u0orxNgmujkA0fby8LG8vi8OgWXX7uHkShvkNocSY+Y2gvQWEAneI52coDcf+Ea5d+J3OpFP21cDjG4I0LpD9SqyqMm1NXOJ778scGPKpV4TEEQKpDDCIlYnTs36orHfuAjCddQmbOHMmGi4PFWB9QWDp0W8zfbcPWIlRnTBAG1wb5dj9/vcl9kdKzMk04XNnICQMGLt1h9SUwWCSjkZcvs5x/n3jNu2s2TSlQ74S/owR4rNt4Eoak0KNB+OVjdNQdpTcgzwjm9zmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KJzBjOVp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KJzBjOVp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7ly62R02z2xwN
	for <linux-aspeed@lists.ozlabs.org>; Mon, 27 Jul 2026 14:30:21 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2cc97653887so25717035ad.1
        for <linux-aspeed@lists.ozlabs.org>; Sun, 26 Jul 2026 21:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785126619; x=1785731419; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hRs1ILFVuPcRsq3x/ZGBZ8F4Diw0x07EEaf1JzdhoDY=;
        b=KJzBjOVpi6A6MwtTMA6iNNw2McjkHUYFAO0Qh5iaX8BAad0W9k4aJGUL9wsQ/e/O0h
         OBkifJRaKZbvOq0V/6r8+m4Q8HhZYDq6B0K9107v8LgjtEOXXFTuvBPQeG4VWmKa0jfx
         H3h13HD+yiXoAQI3TexTq+JRCwuOBs9TAzjkma2DpWKk7klWj1MPJr7lUibyUROyxO39
         wfDt18ji/PPgVF5SLm0J9MIk7ZZisy5kFKc5NafJ4SQKpEZLgBa60bazjXiJyq5elh8b
         gq4ZTHZjXo6QgwlokUkmKU00G0fC8hYBtBGTkvUCBytS/dDBAj14LGfQFHvvB/QyAYpT
         AELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785126619; x=1785731419;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hRs1ILFVuPcRsq3x/ZGBZ8F4Diw0x07EEaf1JzdhoDY=;
        b=W6Gx4bd+aBbaPeygd42ljTUnvG1Dt7+8B3PtIDN+pcT8ejepW5NLIrKgMGr+jEmckp
         kSwbAkSqkU/iNg2T10QaF7t5JKkqsYcjKy+r/xGRkH1wvJFyxQPwnEHXFG6lhqwSzBtg
         7n9DkyRehUtrbko5VzWlyGkqLOemPmh52JnGCWo6nHpEsc8FF+C5KS6e0AbkdqpZk6We
         M7HTwbSNjRwd+WihPSE4Yg8yMxhMW/r1aYHQimS/azB5wLmBLCGO/3pZ7VDxpuVehv4t
         jRqb4hWXynDQhQ+2p3kLr6CA1xa6us5/Pz4gXsB4pL+JvrxNgiTq0tdCBnu14gvVWeln
         uiyQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqri7EVQje6B103EExBF/zGeg15hbA8LPYQjONu1XIjGAaJtgaVDDvyrDQA7uqwV+a3bMd3Mew3rqwbTkw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzW4976UasHe9q8ROIKGDYfMR3rqoVluehgp5YUpI1BBQYQIdVN
	0S8QhOuX9HnQoxntMHDznCAf+uU8ZqdzfnOe3CcvDrD45zcAIDH00qmk
X-Gm-Gg: AR+sD12ZdhSBkmetzXXymmk3+filGj8LxUpj7cWfVMkdMljiBOZ1RPkX0hiHgBkqRgS
	H8cOWpmHpIW/JshQeMwWU9ERTcDKbyYloHjoZhV4GGXC6xXAlfs5beYWEla439YQ02hyhwa/Bha
	X8m46YZdjYFbnhWme9eAER8tg8ZoeORt4gAheSWv68BjIwcvjc06fVIE56la2MMgvSCW5wvagmq
	eUcWM9LC82oOQLWYH2n43P22h0+oxHUcHlNVS3naVYrU2YecCjCfX0jOayGcJI0glyDHKD+pEiK
	XdHyn7EZ9I/UlDuu5TGZlm/KqnVmZRopdjeFU0ypK+jD3Nr2u2KBR7B2RyRzUxnpO32AD0SQM6/
	+q1UE+AmOzKokjPHO8VbwMG99NoqPkDAm8j7GRGVlccb3u5AdaeLoQiYQVIEWt8fLKYVdF63Uvv
	ead5sFA5+EiR77joq/anCxXgsbQmkIZN95L2Fvf5J8Ng==
X-Received: by 2002:a17:903:2385:b0:2be:3850:297e with SMTP id d9443c01a7336-2cfde866c11mr69743805ad.31.1785126618994;
        Sun, 26 Jul 2026 21:30:18 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde80f50asm27372145ad.77.2026.07.26.21.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 21:30:18 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: [PATCH v9 0/2] Add Meta(Facebook) ventura2 BMC(AST2600)
Date: Mon, 27 Jul 2026 12:32:08 +0800
Message-Id: <20260727-ventura2_initial_dts-v9-0-504c0ec68039@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAEjfZmoC/4XQ22rDMAwG4Fcpvl6G5INs72rvMUbxsTW06Uiys
 FH67nMLo1mK2eUv0PcLndmYhpJG9rI5syHNZSynvgb7tGFh7/pd6kqsmXHgCjnn3Zz66XNwfFv
 6MhV32MZp7CxYL7jWkUixuvoxpFy+buzbe837Mk6n4fvWMuN1+g84YwcdZiAkCto48bo7unJ4D
 qcju4IzXyKygfCKZLTCOxUl6AdE/CIEiKKBiIrw6HN05JSXeo3IOyKbl8iKGCAPkJwUKNeIuiM
 EpoGoigidkvIhK+NpjdACQWggdENUNMlGnXxeI3qJYAPRFXGE0VjgPqgHxCwR1UBMRYKx2fJgQ
 P597OVy+QFD1uYImwIAAA==
X-Change-ID: 20251222-ventura2_initial_dts-909b3277d665
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5157;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=ECDRQ+WrFbVZS+CZDLgpuXr0f49U0NwaVirTL3iNsYY=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBqZt9OCSm1dOCGzSJG+/XAVlSwITAZ8teBCVRjk
 RqnKU2yX3KJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCambfTgAKCRClg0K3CVbE
 gSq/CACmfWJchkK2REQmVizNMc/5PAD1prTQWJl+KEK5rofWdDRC6CenSzKodSHaOiosooNQ8xY
 wpZuiTO8SCqBKKhc+Yx4CB4iidhIXfQYG48xpoDZuctrCXJ5c0C7AJyOapK0elrUhZNtURKeF6H
 Tl5lVXp+0+ns8eiQDudLuxb7z1TOgdeNRgMh/xIu1AsxzPZAVRtZOQYmJKscDdUO5vo2kTgDgg0
 hk29/s56q/jfONI2zraEkDRZIwTdU50Z3KySYMDP0C6gsXuzjF6EISPnNACStGp61dGSsVb+XCV
 ymJHdtqSrlkeey2fQDFpVJy9s2rusAx8Gja2BEv+Lqjd6rgB
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Summary:
Add linux device tree entry related to Meta(Facebook) ventura2.
specific devices connected to BMC(AST2600) SoC.

Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
Changes in v9:
- Rebased onto the `aspeed/arm/dt` branch of `bmc/linux.git` to resolve merge conflicts.
- Resolved all formatting issues flagged by `dt-check-style --mode strict`, including:
  - Fixed 'mixed-indent-chars' and 'continuation-alignment' issues.
  - Sorted properties and nodes into canonical order.
  - Removed unused labels. 
- Resolved DT schema binding warnings reported by `make CHECK_DTBS=y`:
  - Removed invalid `channel@X` subnodes from the `maxim,max31790` fan controller.
  - Dropped the deprecated `aspeed,hw-timeout-ms` property from the I2C bus.
  - Removed the incomplete `ti,ads1015` ADC and generic `pmbus` power monitor nodes to comply with upstream schemas.
- Corrected the compatible string for the 40-bit I/O expanders from `nxp,pca9698` to `nxp,pca9505`.
- Link to v8: https://lore.kernel.org/r/20260615-ventura2_initial_dts-v8-0-c89f92c80447@gmail.com

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
 .../dts/aspeed/aspeed-bmc-facebook-ventura2.dts    | 3005 ++++++++++++++++++++
 3 files changed, 3007 insertions(+)
---
base-commit: 749c34389679f8d56cb200a69b62f9a64670034f
change-id: 20251222-ventura2_initial_dts-909b3277d665

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>


