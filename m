Return-Path: <linux-aspeed+bounces-3741-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D826EFC72C5
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Mar 2026 12:43:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffXsZ074kz2xLt;
	Mon, 23 Mar 2026 23:43:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774269825;
	cv=none; b=Fr+6M5G5BIC8bKeYWprfaP+u69WDED/LhJ7o21MLOh9gFjIENTTpN/Bpz8oRldp3QdekXaaLrxpsVJvvln7IVp20YillyMZoe/BCB+rjSU+FByjfPKQ9WUKcEdXCwYOcWHhbylk4l+2HhBAmtciklyLngFwB7jEmqu2Vu6GtsDvXpLzlMC6VcJsOxpZqFLDXdHmNWTsqx4vvOZMFfe4tdaIVVTpf+OaISv51Ta21CoWxQ331IMgTMK8uzc1ec2WKnlWNcBwio7rPHrL+QDsNW9GYmd6LGUnCwIjh+ELapkWXktNidf0X6KXA3Ni+zo+uUJPQr6qlRLAMvqCA5Ljphw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774269825; c=relaxed/relaxed;
	bh=59UatZnPQebxpPUbaoejPsCGSwwdZSX5Yt2Ab7MbFgE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=owmz6tVwYtg7sTuJ3s7spyksrlu2qsIw6rHV1ga0Yisy2eINfKO3JlHofSv+adPRa3LlIIgnMNik6PfEd8nwFr3TlX/dDP3iDxZBsscN7tZOuj676D+nGWf+3+wcdAsfATq5+pjYTUOUI6xCkkeXC9aXtZc0mseh4vji6l+Y5H5U3SkMGLhFYuIJloBwtooT44jD5+vs36PWuny13r+0rhiVnnVpwJdV6k52GqweYNHaaXJUZC7lSdi3xAZWZqeM69LSem8Z3U1FofyXRHsyj1QEBG/LTnm1gEVA+l9fge4CWpLO6hXVYZfkfxDKcJw65uHCVkvUmV3zDHxfp2Isfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TuSBt4qn; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TuSBt4qn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffXsX6xydz2xMQ
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Mar 2026 23:43:44 +1100 (AEDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-c742d4df00cso1635562a12.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Mar 2026 05:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774269817; x=1774874617; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=59UatZnPQebxpPUbaoejPsCGSwwdZSX5Yt2Ab7MbFgE=;
        b=TuSBt4qnlkK9SEaEUofLirmL0X9W9ttTyJ2bBD5+oA1DPGfoI+fuwgxmcnBUt3FSoA
         0Sb1v+GbWwy62mebZtDZ2ai4rNnVvkeQuW99X8vw/B11QhsaoL+k14Hy1vNer1xito8I
         QXpXAeMrgSCIf4+cXB52a51Dw7aBVm/P0dIw+xX8nMDfLGcpi8YdLimpvTqeruv8gf49
         80rh2XDYTKVfeKI/5Qf0QbpwODWq0PnkpCvTVoLHOM4xg/Be54wXzK+v2zYMhBSFos3C
         y0pvmgWcx2NpiC0yS/vQsI/90LEDUkK55wtUETehaVnja6lSilMtujxPr0fgfhOe3pcJ
         08FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774269817; x=1774874617;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59UatZnPQebxpPUbaoejPsCGSwwdZSX5Yt2Ab7MbFgE=;
        b=e4IavfG5AtDFCVM6nK+xxVT/aDQ7UKUVwG5g2ysWFt+OtqAO+JvhMARgbFr+9qspJu
         gUP0TWNWeAMqQ4/MxxgNi7wo3vW4keGPdL1TDe6xU/yjyBOleTUS/knsQEULG6m1haxq
         XONV+7dNhy/9MKPzdwwI5d9vMpqfa61VCCn7sPfSQXMOke1GZCteYhah8ZEiSlEENOJX
         hz/Knw+Mypm50ofro5Y5HbodcgbjBw82pIngn5PpaX7YaeLcwHmrPXy4qZW+KtikWPV8
         KOplVMYa79iE9g3cYBNjzSdePNlHu85674t3JM5spSPuJi86PD4RlbReC7/PoRoKeDak
         EDyg==
X-Forwarded-Encrypted: i=1; AJvYcCUFCs1VBCvgVoy4W/aiyjOiiQaQ+MhD4Hp71WbgJU5F62vCrnEsP2dMA1dr0TSbX+bkKwx0TP3fuSw+Ks8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx1e/cJZOps17nBOAmvZEjGr3hwjf7msnohsS2YGA0vqWyQ6myF
	6PrANJEVo/57Ufog/8JBRMwqzIV28IVjbBRBzJ/LLkJ3jLTan7NJ33Wb
X-Gm-Gg: ATEYQzzG9tC9WqBIO9CEPiZ1TvRI3M/e1UV4HyIYgNRrJMpZqWsseqCEisqRrCpjgFA
	Bb9E2Cu/u3qUN23z+4wN8pI2qZc6sRWLT2+T/9/iu9dl+4A4rk+TDQHrLBfLnpgRzJP/c4oXkFX
	epMWwKlMf3gjGexN1u++Xvn46FDQ9drrfkm+Rh/i2Thpb4EWDbMcg9thR+Yt5p7FfLoyCE47Jlb
	/iJh/bxjBWwz8nKms8KbKzYzbQXPsrjkpdYmrh4tA0AEo3F7w89cwNmwzuJTSp4YdEuDBl3E8lY
	8uZJFid+Xh0KbHTdTK/hU0BZxB1JKA5mUPP/7/X2DaVKDqdinvAWLVtVtRt8LOMfkaCl7xuQH4R
	UuE51HG0+AA87FoTTqTv9v7sEGF/GozScnQ2j1xW5gtPlv7Mj7CB0aJ9TQYcCT9OO7xXX7fvBsE
	PgCZPXHTix3eKZYL7IB9STXHsZEBYDb9aT8d52rzoyB4SsvCWN7Y6Zj2Y8gqK5VdBzzv41np8VC
	Wc=
X-Received: by 2002:a17:902:d2c9:b0:2b0:52dc:f1c1 with SMTP id d9443c01a7336-2b0827bd48fmr106900625ad.16.1774269817485;
        Mon, 23 Mar 2026 05:43:37 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516ae1sm103668865ad.13.2026.03.23.05.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:43:37 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v4 0/2] Add Meta (Facebook) SanMiguel BMC (AST2620)
Date: Mon, 23 Mar 2026 20:41:04 +0800
Message-Id: <20260323-sanmiguel_init_dts-v4-0-caaa48a7f7be@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAOA0wWkC/33NSwqDMBCA4atI1k1JMj5iV71HKZJXdaDGYqy0i
 HdvdFMp0s3APzDfTCS4Hl0gp2QivRsxYOdjpIeEmEb52lG0sYlgImdx0KB8i/XT3Sv0OFR2CLQ
 ojdUAJmM2I/Hw0bsbvlb0co3dYBi6/r3+GPmy/cuNnDJqGBOgXMplWZ7rVuH9aLqWLNwotgTsE
 iISucpyKQwIDfKXgC8BnO8SEAmhU8uVLpRUfEvM8/wB/+8a1joBAAA=
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774269813; l=2647;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=e+YdCl+fCYreU47gtwqy03Jl+PvxUX7nHi35h7gNzJc=;
 b=uHObNyONEAf4p/vGAYVGeay41iAESMvQI/0AI6Npa6OHdAZhzJWkQMMQke82nm6dZZJNgBsuq
 B9JfrHwOxFEDLzeDMzB3p1Tl/B4l8QHXe36n7cCPbi2Y4P6l2KtkU8c
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add Linux device tree entries for Meta (Facebook) SanMiguel specific
devices connected to the AST2620 BMC SoC.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
Changes in v4:
- Include openbmc-flash-layout-128-alt.dtsi in flash1.
- Rearrange the DTS nodes and properties alphabetically.
- Disable the internal pull-down resistors for below GPIO pins
  - GPIOM4, GPIOM5, GPIOV4, GPIOV7
- Adjust GPIO liname
  - Move `PCB_TEMP_ALERT-I` (GPIOV5 --> GPIOV4)
  - Add `HSC4_S5_OR_S0_N-O` (pdb_ioexp_20, p12)
- Link to v3: https://lore.kernel.org/r/20260311-sanmiguel_init_dts-v3-0-2b4d1ab7a8a1@gmail.com

Changes in v3:
- Update the model name to "Facebook SanMiguel BMC".
- Remove CP2112 and downstream IOEXP nodes as the upstream driver
  is not yet available.
- Remove the following EEPROM nodes until the bus numbers and
  addresses are confirmed:
  - 3-0051: HMC FRU EEPROM
  - 3-0052: HPM0 FRU EEPROM
  - 3-0053: HPM1 FRU EEPROM
- Change the compatible property of the following EEPROM nodes
  from 24c02 to 24c128:
  - 5-0050: SMM FRU EEPROM
  - 9-0050: PDB FRU EEPROM
  - 13-0055: SMM EXT FRU EEPROM
- Fix the smm_temp node address typo (0x4e -> 0x48).
- Remove nodes that no longer exist in the latest board design:
  - 19-006f: RTC (nct3018y)
  - 9-0075: IO expander (pca9555)
- Update linenames to match the reference design:
  - B0_M0_AIC_USB_EN-O -> B0_M0_CPU_L0_RST_IND_L-O
  - B0_M0_BRD_ID_2-I -> B0_M0_BMC_TO_GPU_MCU_I2C_EN-O
  - B1_M0_AIC_USB_EN-O -> B1_M0_CPU_L0_RST_IND_L-O
  - B1_M0_BRD_ID_2-I -> B1_M0_BMC_TO_GPU_MCU_I2C_EN-O
  - IOX_GPIO_P16_TP -> USB2_BMC_HUB2_RST_L-O
  - I2C_PDB_ALERT_L-I -> X86_TPM_RST_SEL_L-O
- Remove unexpected or unsupported properties from SSIF and IOEXP
  nodes.
- Change all status values from "ok" to "okay" for consistency.
- Link to v2: https://lore.kernel.org/r/20260203-sanmiguel_init_dts-v2-0-6a5682c32b38@gmail.com

Changes in v2:
- change mac0 phy-mode to rgmii-id
- remove max-speed attribute from mac0
- Link to v1: https://lore.kernel.org/r/20260202-sanmiguel_init_dts-v1-0-c0023ae41899@gmail.com

---
Potin Lai (2):
      dt-bindings: arm: aspeed: add Meta SanMiguel BMC
      ARM: dts: aspeed: Add Meta SanMiguel BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |   1 +
 arch/arm/boot/dts/aspeed/Makefile                  |   1 +
 .../dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts   | 668 +++++++++++++++++++++
 3 files changed, 670 insertions(+)
---
base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
change-id: 20260202-sanmiguel_init_dts-79cdb33c50d5

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


