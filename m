Return-Path: <linux-aspeed+bounces-2091-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A71CA1005
	for <linux-aspeed@archiver.kernel.org>; Mon,  1 Sep 2025 03:13:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cFYqK4Cl8z2yvv;
	Mon,  1 Sep 2025 13:13:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756696413;
	cv=none; b=UhiaXHTWm1oMN0IkmOLiKNbflbrX/wr/HlnIIHa6lwCgkyJfQ1Qr/d+OMFBBvp/b0iwK1ZUeUmRYG+JyBcK6JMfcy5IxAg0aw8VmkPmecFePV6/7HkXjOGoLkQJRGkhR6+qDie+GJ6XAu81Nuxp4MSl1Ueu1+/nc8j5xcbrPEENVYHo1MRgVcePu4zWGIEi3Bx9rgglvayip2jig+3jNpFqEICdV6iaepGpiFZCoka4QXjcnqDY2NYZnzupl8ybOkK6LlqGgLioYJXrCBoImK621Kj16sz+EimyLBym/AanTaOZbQX821ihMDKDRWkbrG4ePQb5Li64S3QdIez73gA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756696413; c=relaxed/relaxed;
	bh=hPCl6SjrAVzAHktcZ70ahObZGpyN9X3TgGnu+O9tSgU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFDp/ShiJ9gdRbAF8Av6oXctJgB1U4VsEZqjBIkHgkUwoPYQV1h0OsGS8LuYYSrXsdLp9S9WGZjACjXmfcT2psN6VcFgKtG39Ue1tFdSStG0wytLj+4GJsVaFvBfdRPlWUeELM3NYu6FotIOolJIzGmeHQmoHIQlgb79MR6Typj9UAL6sSIXHYMqIgvVGTkZI3MZHpYX/ALN5hcFzQEWvfmMsF/Il+58h9HVpmOmK4ZyYX7mNqhrv72hfM6XzCxjtZ34cT5oWQ6XCHa/C/zJLN+iJdpJM0IWbwx91gCi8rJiAsCi7LGVu+Qr08chqiaWQ11EpVpkiD7qJlzflvbYOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeed.com; envelope-from=ryan_chen@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cFYqJ4gngz2yrp
	for <linux-aspeed@lists.ozlabs.org>; Mon,  1 Sep 2025 13:13:32 +1000 (AEST)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 1 Sep
 2025 11:13:11 +0800
Received: from twmbx02.aspeed.com (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 1 Sep 2025 11:13:11 +0800
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
Subject: [PATCH v5 4/5] arm64: dts: aspeed: Add AST2700 Evaluation Board
Date: Mon, 1 Sep 2025 11:13:10 +0800
Message-ID: <20250901031311.1247805-5-ryan_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901031311.1247805-1-ryan_chen@aspeedtech.com>
References: <20250901031311.1247805-1-ryan_chen@aspeedtech.com>
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
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts | 22 ++++++++++++++++++++++
 3 files changed, 27 insertions(+)
 create mode 100644 arch/arm64/boot/dts/aspeed/Makefile
 create mode 100644 arch/arm64/boot/dts/aspeed/ast2700-evb.dts

diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index b0844404eda1..3729e7d480db 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -38,3 +38,4 @@ subdir-y += tesla
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
index 000000000000..654b36ec24de
--- /dev/null
+++ b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/dts-v1/;
+#include "aspeed-g7.dtsi"
+
+/ {
+	model = "AST2700 EVB";
+	compatible = "aspeed,ast2700-evb", "aspeed,ast2700";
+
+	chosen {
+		stdout-path = "serial12:115200n8";
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


