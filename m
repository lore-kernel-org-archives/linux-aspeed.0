Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F42606A31A
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 23:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IYAHHgzr
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jG0R96Jz4z308H;
	Fri, 30 Oct 2026 10:13:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793315637;
	cv=none; b=lzQbvaQsyuCGa3dO3kvbzh5p17ucsU5BYkZmn3vZ4opO841/vqLHvrZJZKLG+BCvXQEF0sDKbXQNAUpJyIU1XXNTqLuL41Ir331YwFh/qTiw0pEISmMrxzDtELIbCC65pD69GwzOONE/W5LIDSQX6xo+qv86yNYtMbm4kLKEGnvfpRrNpkxgaLcbZ2lDIAxro4LqxZXIjccXEmccq7eqagXurMEF1AQ6QOYJk8QkJCX2J4SZbc+QhdgWpDN44Q5DfuE0Q12U02SYKfvn94HrgzvHfzLkbU+pre23HU8piOperbLrwmBVRk2/vbkOr0vXbDPDb8zXngayx3uZ30KfWg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793315637; c=relaxed/relaxed;
	bh=Td9/mME215/4xVyAcQCSwVGtdaBr9meLthZDhvRiipQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VQWOSGd8Qzdq05gyl0ncj9XPQMiAA7Pvr+EYWbODit0a9mGexWKKx+CUDncIpsmbduVRrd11kT+IUSyigOPy0KOKOcBGsx7WaR7xmpNmZZqDnDZ/q+hSir4LNxYrHBrJFhsBQy8lAVzk/3kp32GrscJ8ggy3uFkvaPOXis0F5N7ZqA/aNyupa8/gUUB7OxtyYBpNkOyE0Ukd7MMlO8TeUZdaemQRs+Aqf3+sJidOTpQ/DK/Mv7CG0ne4PH+ThBd9zOO44HejIfk+IGfFL2Z9FaznzGJ3JLLeUqy8Q4HY49aQxL3SrhjCC5JBOZlF38g+B7uS38gqwiQZNUyVvHjShQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IYAHHgzr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IYAHHgzr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=prasanth.padarthi10@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com [IPv6:2607:f8b0:4864:20::132d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jG0R74mS2z3048
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Oct 2026 10:13:55 +1100 (AEDT)
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-3514b90bb89so324703eec.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 29 Oct 2026 16:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793315632; x=1793920432; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Td9/mME215/4xVyAcQCSwVGtdaBr9meLthZDhvRiipQ=;
        b=IYAHHgzrURa0agHQAUib8vB0OBiLA4kFRy3N+KdVyDXkfrRBjmjxFmBOlNYnqhte9P
         0N4Y10ARNWXySaYWF3E26iDjxK7bUsXOt2WeRsmM5rYHeeDRosF7TguEbp7NcgukUZbp
         lgdtipUOGrJUZAUa7rZUs3EtjAgCicUnb2+fYBy3YSPt+GWYRx24vFWvCMAnhobEKwJ1
         qXsB8NXWsAxXcbB+ua0tH6VrRu83EspkmwXiKhxRVI/SOGmzuu5QDmWY2iRQ/eQDK5iP
         UMdg4nXv00ImIkJB6kl3IdmUiYawTSQghXZwofTGJodEgmwOKefpkYu2Prml/KOls0nY
         NaHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793315632; x=1793920432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Td9/mME215/4xVyAcQCSwVGtdaBr9meLthZDhvRiipQ=;
        b=KNVIi0hS8J4aGt2LAW4q/JLN+5TXPepXefc79rBiXd6I3XqeBvczGedgbo1YtiwPWP
         7tkG+z4b+/kGwuXg5czU0kbGisUAsxjLV7pc4zfgo7wJLuganHUN3l/+AWbRwGyjLdgi
         zs5Vlg9UTcDRI1qIFj4W3LxXBUqUAhfgLlBdAIU3WHelP7jCfDwU9GdjOloHTu7B1dy0
         4z9/nhFqNDo2p849PfOZAzvF+N+CHPyPS3ehP6vukTezDJ19Pbbd4A/4DzZCPOgGI1p6
         NaTG1OaxEOkiyt532ey1dWIW3Iy4X+nQhkEQIDRZo4yVE1NcpTfunBW8H8Bgi5gRr6wK
         UQrw==
X-Forwarded-Encrypted: i=1; AKwUvBxUKXndR7I6wFQaP1yo2gar8ffD4oSo7XJcwR7BTquoaUQwUbkoThuwaicq3PpcO77T+YQnMu8XyCOXIeM=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYKDqlFeBYACqvo0kkXM4+SmUjKjQ4EOLHs7icxMaCSZiXHn9u/O
	1nvDPRgPZprR7k4WUnv4/PXRPIFmwMlrXxHe/wX+XnMkEjuBMXf5P5xe
X-Gm-Gg: AYBFou2aDn5MCJjAre7SRxIXs9KEowQ61Q/jmmJlbnUZXOAlw1FGRXR/zq7ANh2demo
	4vrUMZQbQ/gUiX0rxRTz7Rs7wuSCei+zvHRNS8W2h0JuXayTSzj2d1A2hMClwQvY+74wN3YoV1N
	l6ptQ3xrc1LUh5HuBWRrm4+nGHaHvcw734BaNQQQScT9+cMTradWzAUolcXNPJQo9hffeZDad1L
	1cJXsaXs6Z9gAozp+0Lr8jbHvF+DdchDDjudsoxgE1l4IGr1/4oGHrZ0QrUavDoNwAuBmuJFs8v
	SpDeOuF7+2qoww5Y5uHF3in8u5mRYVoMUcmEcHKtM30NmfB3noQQXlZgT45XBcNpbHrSe0As6rJ
	78t64V+LDLLc2dPLyJEGUHekARfqq9Cyeobg18doNT5fe/4LvybcWyvW7kTDlaigPW58KdnvqHt
	0WLSP2ig/FG2+7dmWgA66TOBzO4V+9j6s95j9JjOUYtkHFUcYPTr2Dijd4EcKlVN9j1JDJ3dWcr
	IYh3m/9+Jhy1X1fgW4XkJsSwfY618Bu0WxClTcK/XOLnl/ROhKsZ20mQZE/QgeUod84bcdNKi4g
	pPxhzitidYCAR3aVkWBJfhKDGm7apfKols+FyaUKAjGS
X-Received: by 2002:a05:693c:6087:b0:369:f420:8679 with SMTP id 5a478bee46e88-36a42440304mr1174873eec.38.1793315631951;
        Thu, 29 Oct 2026 16:13:51 -0700 (PDT)
Received: from debian.prasanth ([103.177.82.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af1dfsm1662742eec.7.2026.10.29.16.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 16:13:51 -0700 (PDT)
From: Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	tan.siewert@9elements.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org,
	andrew@lunn.ch,
	Prasanth Kumar Padarthi <prasanth.padarthi10@gmail.com>
Subject: [PATCH v10 0/2] ARM: dts: aspeed: Add ASRock Rack B650D4U BMC
Date: Fri, 30 Oct 2026 04:43:37 +0530
Message-ID: <20261029231339.9497-1-prasanth.padarthi10@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the board compatible and device tree for the ASRock Rack B650D4U
AST2600 BMC. The DTS describes memory, SPI NOR, UART5, GFX memory,
GPIO names, the I2C7 EEPROM/NVMEM MAC provider, MAC0/MDIO, and both
ADC engines with an ordered IIO-to-hwmon bridge.

This revision corrects regressions in v9's compatible ordering and
binding acknowledgement, restores the revision history, and addresses
the UART alias and DTS-style feedback. No new hardware is added.

Changes in v10:
- Restore the binding Acked-by from Krzysztof's earlier review [R1].
- Place asrock,b650d4u-bmc after the aspeed entries, as in v7/v8.
- Drop the serial0 override and use the inherited serial4/UART5 alias
  for stdout. Bootloader console arguments and getty must use ttyS4.
- Consolidate the root node and order peripheral references and ADC
  properties according to the strict DTS-style check.
- Restore the earlier history and discussion links below.

Changes in v9 [9]:
- Enable ADC0 and ADC1 with 2.5-V internal references and pin groups.
- Add the sixteen-channel IIO-to-hwmon bridge.
- Rebase onto the Aspeed ARM DT maintainer branch and normalize GPIO
  comma spacing. This revision inadvertently lost the binding Acked-by
  and regressed compatible ordering; both are corrected in v10.

Changes in v8 [8]:
- Correct the validation report to multi_v7_defconfig with ARCH_ASPEED
  and MACH_ASPEED_G6 enabled; retain the DTS and scoped review trailer.

Changes in v7 [7]:
- Correct GPIOP reset/power/NMI button/control names and remove the
  obsolete F5 reset name; leave the binding unchanged.
- Subsequent review requested the validation correction and carrying
  Andrew's review tag forward [R4].

v6:
- Prepared locally only; no public submission. The sent version number
  moved from v5 to v7.

Changes in v5 [5]:
- Add I2C7 EEPROM/NVMEM for MAC0 and select rgmii-id.
- Use the standard OpenBMC 64-MiB flash layout.
- Add initial GPIO names and the reusable 16-MiB graphics pool.
- Drop the previous RX-delay-only justification.
- Follow-up review requested GPIO mapping/style and threading fixes
  [R2, R3]. Andrew's Reviewed-by applies only to MAC0/MDIO.

Changes in v4 [4]:
- Correct memory size to 512 MiB and add explicit flash partitions.
- Report RGMII traffic tests and select rgmii-rxid; that delay rationale
  was challenged and superseded by the rgmii-id selection in v5.
- Order peripheral nodes alphabetically by label.

Earlier public submissions:
- v3 [3]: board-compatible/DTS series. Krzysztof supplied the binding
  Acked-by and requested preservation of review tags [R1].
- v2 [2]: early board DTS, including UART5 via serial4. Its complete
  per-version changelog was not recovered; the archived patch is linked
  rather than inferring an unsupported change list.
- Initial submission [1]: board binding/DTS, with QEMU console and
  board-identification testing reported in the cover.

Review tags:
The binding carries Krzysztof's original Acked-by address. Andrew's
Reviewed-by remains explicitly restricted to MAC0 and MDIO nodes;
no complete-board review is claimed.

Validation:
- Compiled and schema-checked the v10 board DTB with multi_v7_defconfig,
  CONFIG_ARCH_ASPEED=y and CONFIG_MACH_ASPEED_G6=y, using
  arm-linux-gnueabi-gcc and dtschema 2026.9.
- dt_binding_check for arm/aspeed/aspeed.yaml completed without
  diagnostics in the reported output.
- CHECK_DTBS=y reported no board-specific errors. Two unmatched-schema
  diagnostics remain for inherited aspeed,ast2600-lhc and
  aspeed,ast2600-i3c-global nodes.
- Strict dt-check-style and whitespace checks passed. Checkpatch reports
  no errors and one MAINTAINERS reminder for the new board file, covered
  by the existing Aspeed directory entry.

These are DTB/binding checks, not a complete kernel build or boot test.

Both ADC engines, twelve configured voltage rails and recovery after BMC
restart were tested in a custom Linux 6.18.24 OpenBMC image with the same
ADC settings. That image has separate power-control changes, a different
flash layout and ttyS0 console configuration. The complete upstream DTS,
including v10's ttyS4 console selection, has not been boot-tested.
Voltage scaling is userspace configuration outside this series.

Base: 8db593481c8669eddb8b4e21ea44f3fa11d9f030, aspeed/arm/dt
https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git

Previous submissions and review discussions:
[1] https://lore.kernel.org/all/20260512175019.47548-1-prasanth.padarthi10@gmail.com/
[2] https://lists.infradead.org/pipermail/linux-arm-kernel/2026-May/1129461.html
[3] https://lore.kernel.org/all/20260518033440.17569-1-prasanth.padarthi10@gmail.com/
[4] https://lore.kernel.org/all/20260830182036.284736-1-prasanth.padarthi10@gmail.com/
[5] https://lore.kernel.org/all/20260915013110.4780-1-prasanth.padarthi10@gmail.com/
[7] https://lore.kernel.org/all/cover.1790079398.git.prasanth.padarthi10@gmail.com/
[8] https://lore.kernel.org/all/20261002062933.26497-1-prasanth.padarthi10@gmail.com/
[9] https://lore.kernel.org/all/20261027034911.99482-1-prasanth.padarthi10@gmail.com/
[R1] https://lore.kernel.org/all/20260518-rustling-watchful-viper-b9c4b4@quoll/
[R2] https://lkml.iu.edu/2609.2/00630.html
[R3] https://lkml.iu.edu/2609.2/00642.html
[R4] https://lists.openwall.net/linux-kernel/2026/09/22/1982

Prasanth Kumar Padarthi (2):
  dt-bindings: arm: aspeed: Add ASRock Rack B650D4U
  ARM: dts: aspeed: Add ASRock Rack B650D4U BMC

 .../bindings/arm/aspeed/aspeed.yaml           |   1 +
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../dts/aspeed/aspeed-bmc-asrock-b650d4u.dts  | 169 ++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asrock-b650d4u.dts


base-commit: 8db593481c8669eddb8b4e21ea44f3fa11d9f030
-- 
2.47.3


