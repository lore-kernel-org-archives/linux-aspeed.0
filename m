Return-Path: <linux-aspeed+bounces-2820-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A4BCCFA1D
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Nov 2025 05:56:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d2pGp0mYZz3btL;
	Fri,  7 Nov 2025 16:56:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762495010;
	cv=none; b=NdtykAUW7aEa7HDwcksBpwuWVtfzECy6RH7yATTzwyHWP345X2QmIStSkRkCIcVkdCTfx6CVH028+bqIhwYzxS1aVWfOm5E2ZZugW4c/Lj+h6BwakVIplJQeIJ1CkRj4eeD71JKglDmQtu5bT1opj2oN5gPpktGKENsioqR7l3+RL0KS2PJVipT4a9CepmrmTfg25dz6PBaJviXMsVGovc3dMCqTFVZ77yYYOCdNqMQ/pw9JObBBqS0HE3yU9Dxq153gQdDgU9DEKLCb6+MaqslZPA+QLJHEbfs+XiuruoqUDJjZA9SVFNA4ALEp3tjkHoZ2Zn7E5j1yao83zKhCYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762495010; c=relaxed/relaxed;
	bh=SInxBy7YfPex4wAk/CgFr3JQv4r3OJTGZZt5a2PUqHM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fd49/hVXpSY6yV6BHm6bx6ZqXIMdMjpPTCTk4EmkmjD3xCrncdvcUouBOfovj+AS8T31w4f4IIA3ivqFcAVDlNszogL2SdL3L8CXE9LqrOi75CdemsdWi/nPtaFimX8ydNlMi32P9NJ5VdaRS0r5LzVabxVjwgSBTNeln1DDa45EWzp4DVsjuE5S0D0bki+HJ9gUtBJopkg/lZCtyeLrJ0Q5BEMpgJUBqWdJYcWsaT9X3RXHkVickIEHxuw7rB3D9wIEzfkSEAQOuJcCdw5E6DqrFq7s7VRTZfTDbQmdw9evWkQ+H5oiLdXWQPXFLkXYqGyVh+EupaU8HIdiFE7W9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2pGn4Q7Bz3bfN
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 16:56:49 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 7 Nov
 2025 13:56:30 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 7 Nov 2025 13:56:30 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, <bmc-sw@aspeedtech.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, <jk@codeconstruct.com.au>, Lee Jones
	<lee@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
	<will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
	<nfraprado@collabora.com>, Taniya Das <quic_tdas@quicinc.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 4/5] arm64: dts: aspeed: Add AST2700 Evaluation Board
Date: Fri, 7 Nov 2025 13:56:28 +0800
Message-ID: <20251107055629.4075519-5-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107055629.4075519-1-ryan_chen@aspeedtech.com>
References: <20251107055629.4075519-1-ryan_chen@aspeedtech.com>
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
Content-Type: text/plain

ASPEED AST2700 EVB is prototype development board based
on AST2700 SOC.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 arch/arm64/boot/dts/Makefile               |  1 +
 arch/arm64/boot/dts/aspeed/Makefile        |  4 ++++
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts | 26 ++++++++++++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
 create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index b0844404eda1..5b8fbf5b1061 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -9,6 +9,7 @@ subdir-y += amlogic
 subdir-y += apm
 subdir-y += apple
 subdir-y += arm
+subdir-y += aspeed
 subdir-y += axiado
 subdir-y += bitmain
 subdir-y += blaize
diff --git a/arch/arm64/boot/dts/aspeed/Makefile b/arch/arm64/boot/dts/aspeed/Makefile
new file mode 100644
index 000000000000..ffe7e15017cc
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+dtb-$(CONFIG_ARCH_ASPEED) += \
+	ast2700-evb.dtb
diff --git a/arch/arm64/boot/dts/aspeed/ast2700-evb.dts b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
new file mode 100644
index 000000000000..9a5dbb4d9002
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/dts-v1/;
+#include "aspeed-g7-a35.dtsi"
+
+/ {
+	model = "AST2700 EVB";
+	compatible = "aspeed,ast2700-evb", "aspeed,ast2700";
+
+	aliases {
+	    serial0 = &uart12;  /* console port */
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@400000000 {
+		device_type = "memory";
+		reg = <0x4 0x00000000 0x0 0x40000000>;
+	};
+};
+
+&uart12 {
+	status = "okay";
+};
-- 
2.34.1


