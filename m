Return-Path: <linux-aspeed+bounces-1401-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C85CC7114A
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Jun 2025 10:09:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHyv90R6cz2y82;
	Thu, 12 Jun 2025 20:09:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749722997;
	cv=none; b=dER1CFqWdgsFe67DwXg4J14+upYkGYAVbtv0qi6wSwrn40WvDY3g1obQYnoRKafXj6JbcdCee73dDoa1znIEJuktKHtXlRqugRx8bT/LxTbN1Wrvy7Ibjd+wGG0Tlt3lN2WQ3SimqfzDq6/iA6z2hyXibahO/PA8HNIAgd++drzWwHFg85R/Ln36zTuH1WJHY1XdWGEMXRLJjiA7UXEFu9frSzunXxBH6AOICOkpPI2r/4Gjb1X67pVj/BW/REPM/k4IeRjQXpzwzvKGkmOKDIvMS+CdUK8XrCRLdiWKRcJ0Ve3HSuTRkD6Enar8VTkyjxw/j150x0uAsx/EgvAmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749722997; c=relaxed/relaxed;
	bh=2N+mZR2W2/KMVPzDT+8WKucF4rOv4Bmrt5+nAt6ZNvo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xddu2LOjBL7XRfdQ6ztxP2Wz5Xw+GqXPjU1DP8+tsu6Z46tU3yz3iB84wNZ0T4vpo/vs3DwoFLzBhAhl2ieAaQaLOtLGciV59viade6lyYMFJ8MF37auUkgRvTBm502cx1WeUveHkmL0porUAeoVWjCpJ7o2fTyJFUClGGTlNvJMP32rJCL++BoesjOQMLH5L/G0Y1jJ4VyJ0fIe1lQnNBWBlcSbbdBj1wTbuIMUCkOkfkBcHbXrRkmwQjKnTXJUan50X+5pfz7j+Q6nhG7DDGBj1L6zFjaY2RLadiFTQO6eRN2D1ZfP4VH7ZPJqzDYFaIWxn9dyYEiXEhLVRgRBlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHyv83sTHz2xPL
	for <linux-aspeed@lists.ozlabs.org>; Thu, 12 Jun 2025 20:09:56 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 12 Jun
 2025 18:09:34 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 12 Jun 2025 18:09:34 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: ryan_chen <ryan_chen@aspeedtech.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
	<bjorn.andersson@oss.qualcomm.com>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Nishanth Menon <nm@ti.com>,
	<nfraprado@collabora.com>, Taniya Das <quic_tdas@quicinc.com>, Lad Prabhakar
	<prabhakar.mahadev-lad.rj@bp.renesas.com>, Kuninori Morimoto
	<kuninori.morimoto.gx@renesas.com>, Eric Biggers <ebiggers@google.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<soc@lists.linux.dev>, Mo Elbadry <elbadrym@google.com>, Rom Lemarchand
	<romlem@google.com>, William Kennington <wak@google.com>, Yuxiao Zhang
	<yuxiaozhang@google.com>, <wthai@nvidia.com>, <leohu@nvidia.com>,
	<dkodihalli@nvidia.com>, <spuranik@nvidia.com>
Subject: [PATCH v0 4/5] arm64: dts: aspeed: Add AST2700 EVB device tree
Date: Thu, 12 Jun 2025 18:09:32 +0800
Message-ID: <20250612100933.3007673-5-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
References: <20250612100933.3007673-1-ryan_chen@aspeedtech.com>
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

- Add ast2700-evb.dts for the ASPEED AST2700 Evaluation Board.
- Set board model and compatible strings: "aspeed,ast2700-evb",
"aspeed,ast2700".
- Reference the common AST2700 SoC device tree aspeed-g7.dtsi.
- Define memory layout and reserved-memory regions for
MCU firmware, ATF, and OP-TEE.
- Add OP-TEE firmware node with SMC method.
- Set up serial12 as the default console.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 arch/arm64/boot/dts/Makefile               |  1 +
 arch/arm64/boot/dts/aspeed/Makefile        |  4 ++
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts | 54 ++++++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
 create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index 79b73a21ddc2..d9c3e58b9ca5 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -35,3 +35,4 @@ subdir-y += tesla
 subdir-y += ti
 subdir-y += toshiba
 subdir-y += xilinx
+subdir-y += aspeed
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
index 000000000000..ecd4b55931e7
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/dts-v1/;
+#include "aspeed-g7.dtsi"
+
+/ {
+	model = "ASPEED ast2700 Development Board";
+	compatible = "aspeed,ast2700-evb", "aspeed,ast2700";
+
+	aliases {
+		serial12 = &serial12;
+	};
+
+	chosen {
+		stdout-path = &serial12;
+	};
+
+	firmware {
+		optee: optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
+	memory@400000000 {
+		device_type = "memory";
+		reg = <0x4 0x00000000 0x40000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+
+		mcu_fw: mcu-firmware@42fe00000 {
+			reg = <0x4 0x2fe00000 0x200000>;
+			no-map;
+		};
+
+		atf: trusted-firmware-a@430000000 {
+			reg = <0x4 0x30000000 0x80000>;
+			no-map;
+		};
+
+		optee_core: optee-core@430080000 {
+			reg = <0x4 0x30080000 0x1000000>;
+			no-map;
+		};
+	};
+};
+
+&serial12 {
+	status = "okay";
+};
-- 
2.34.1


