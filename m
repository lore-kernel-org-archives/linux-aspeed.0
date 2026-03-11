Return-Path: <linux-aspeed+bounces-3640-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20DC8FCC9DA
	for <linux-aspeed@archiver.kernel.org>; Wed, 11 Mar 2026 06:21:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fW0yS2wxtz3c97;
	Wed, 11 Mar 2026 17:21:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773210112;
	cv=none; b=IPkS6BTjfbvdZd+tmhHql54CYNyJhyVQDHpg5cyVs/3RoGRZZb9GLAUyPV3Jf1giENlrI2fjxsO3mdHjDs9IKDjgGtPqFZW4gZX6BGay+2tUQuQuW27+qg7/Gsg3ynfBhV1cngAPDhMzIqCinlU+haDCCI5nNMZH+YsiQ7o5P2SOYc2Y60iEj/KFMzP+pufGv+uLG8+M25PQXLqH6xpc59/stNX2z3D3HRfT11neUIyxwT0P3Ynn8U/zsuedJ1SOUv1IHirFk7Jc4cqCsIh1xTDxFKxiQgCF1p2gRmFmfMs9Ehh5FLDEd9xgjRaYprwHOZWu1QDosuwGxcvpwi1n3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773210112; c=relaxed/relaxed;
	bh=aPRAl8XBEAVPedtuLZozkH/4zHuUY/9G55Jcjy2Q4hs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MV8twRm2EINAo6O5y3o0hmT0K2REy6uMyPv+GPtFZcb7l5b6cr2KylFq2hU8Mi7fYVTeTglpK48GDi0UiLzo0Ka712+M7u92mVzeCyFXhVDndKwuck/sT1xqvWPc55pEz2ANvMjPkU0V58xB6rEAbEd5uvDUEzNt+VhBmN/7Ad3B5v4bKvt6bopfapd5DNZ9o0ea5zEsB/+ObmPo/rJehdi2Q7afYfu0r9DzieSBrYMxXUVaBB4uTXrsuBqgOIXAP6iRyv1uy3/u8E/V4lx0WT3aw9poEF+6Mnaahd8SX9v5TcUQCExyNrAloW+7QMsiUDgTpdi1kBRAGdJ5gU52lA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gamQdT1E; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=gamQdT1E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fW0yR24pKz2xTh
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Mar 2026 17:21:50 +1100 (AEDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c73bd024a0dso1055778a12.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Mar 2026 23:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773210108; x=1773814908; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aPRAl8XBEAVPedtuLZozkH/4zHuUY/9G55Jcjy2Q4hs=;
        b=gamQdT1EBKWx9H+aQq+YRaOZ/wijutAQrdIpp7pGqoR2lMimfLtPQDEU2791Nxw8mG
         VHpgiAc44jmBDcO2KslrB349KLcfNG+Gk596SUz2PLgSbizhUmmgXCXUd52mzLakBwcA
         wqeaxFKLHGUfrXydJ9RD+duOHDZoYeCM0kaPO2fkG/hjC4ZJ0w/5TWNT8iV8ZsB82soU
         G93oQ0dlsbinXUfYSvykqAmOXzjHtjgkW+JxA7z8IieIfwDA+u77pZBK5C09qVS/s/SC
         VrOW/JHZ4kRpeHOxY2Nh10oDHYN8N+S3ZlWrof6BN7x5W3xDxc5O3hzmHt9OzzfXXTGp
         K/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773210108; x=1773814908;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPRAl8XBEAVPedtuLZozkH/4zHuUY/9G55Jcjy2Q4hs=;
        b=L0ePCxDxptO5rSL7XV56RTQhQOqtE4qy1W6FlR5vIdyko03YYBHjnHUqhrNfO88CXq
         X0RCpI7bBV1iwBHjFbnbEaKMjG/NROjw9VjEEmZb+lbPUBLtoYc+sjY3ScrWe2V+K/WG
         3DF6V3w9GKcvbOCd7s5Y+6/Qt/UHJkEqGqxkmAM0Gx0DH+uQ4PxDuPQHtb/I4OsGkdoF
         awD5op52pHccuY8VOuZSpn+nVGQBhShKwoeGdJ7dNyp+n79eysC1HTnYX3ulfOiN0wii
         8T9uSSXJ2yW4swtzdTOsbIuTq/v5Ccpaq9wId+Gc8uMvqdMFPXakmOcjvVr1mwsG+p2e
         MZrA==
X-Forwarded-Encrypted: i=1; AJvYcCXPLPw+R3Rsq4DgeGI0ZNbj9IJo9QleRg2TRoSPu2/y0cZhE6Zw4otikRpx36AnPTlaYlUuIkFZpq69+I4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyHbitX6Vz96H2SdRvIobl5epCWwwdHNdsHJXJ/Ywg+XCSwJ1B7
	dQoaDEGyQUbq1HajvyldEp1nqPFs93zmP6TZ4qHM6WQCMw6Dh2uHMGnw
X-Gm-Gg: ATEYQzxN7OB4aSbmuTmjgEK+dGuE8FB0CjaeJz7go4kKDiEuJe9ZMXYEqU54dLfx4g+
	DqQp+kzVwV54mGeCGIDxJlwcwfOkpd/p89S5DRtlxWs6MDk9R0V+zmwy591O3PvtPFEEuWvsZ83
	88MMh4dpjuLkRnrNflNP80PH8AZ+CztQlyMxteC94AIsstCNYZ/enUeZokIGsR7pb1vd0wDpzJ4
	kwKemfZdWbF8KyZO07ZpW+8z43g0B/mGH/ae6HVJNTx19DIIPCpZKJxttKgZ/YMZTloWdAz3mg7
	hPCMmW2fQ7zz6VZoPBT2QH+3vzRCNElrQC//z34btd5sFhEYvlxef5tdJ6VQxoDJPmarkR3pK80
	3FdtFXY9TgADaS/feWwZvBTbfgOc4oYv3dIcOrD+KfuNwMbVa8iW5d1h9Byycut/3+O0XJnfNRk
	LcSGRG3s0buFJwZ3GVYtOccXiHEax6DFaKqihK7mhiQ36r4t1+qPU73iZqHldvqDNLOBlK1Tx1U
	2I=
X-Received: by 2002:a05:6a21:b90:b0:398:870f:d7b2 with SMTP id adf61e73a8af0-398c60e5943mr1266713637.33.1773210107749;
        Tue, 10 Mar 2026 23:21:47 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73cdfa9acbsm1008019a12.32.2026.03.10.23.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 23:21:47 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH v3 0/2] Add Meta (Facebook) SanMiguel BMC (AST2620)
Date: Wed, 11 Mar 2026 14:19:27 +0800
Message-Id: <20260311-sanmiguel_init_dts-v3-0-2b4d1ab7a8a1@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAHAJsWkC/33NwQ6CMAyA4VchOzszWkHw5HsYQ8Y2oQlsZsNFQ
 3h3BycOxkuTv0m/ziwYTyawSzYzbyIFcjYFHjKmemk7w0mnZiCgFGnwIO1I3csMDVmaGj0Ffq6
 VbhFVIXTB0uHTmwe9N/R2T91TmJz/bD9ivm7/cjHngishAKU55VVdX7tR0nBUbmQrF2FP4E8CE
 lHKoqxAIbRY7YllWb5b1+Ru9wAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773210105; l=2198;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=Axc+CcnQnnfpiP5A9auA1FuvVMCpTICZ4JkiYPK7KGI=;
 b=AeS7rOHZELrxiBxvNyIsIKUOn+ZlPw6IOgK9gSv2u6Yil5P3iZUUoLV/vi4Yt/hjpiAducidT
 Ng5ObpGxUZwCQnBvBtvuUNWczv30czDnT5UwPYM3E3D8BuXjFkklacB
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add Linux device tree entries for Meta (Facebook) SanMiguel specific
devices connected to the AST2620 BMC SoC.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
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
 .../dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts   | 634 +++++++++++++++++++++
 3 files changed, 636 insertions(+)
---
base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
change-id: 20260202-sanmiguel_init_dts-79cdb33c50d5

Best regards,
-- 
Potin Lai <potin.lai.pt@gmail.com>


