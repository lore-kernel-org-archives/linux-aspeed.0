Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B06606A31C
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 07:52:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFbzm1RQlz30FB;
	Thu, 29 Oct 2026 18:52:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793260340;
	cv=none; b=FaX8NAtJ1MRwFE9Feq9gx4tQFzlUJEWCb742VhxrxgpFdHPFQVhvhyVU3iwu3Ftgx3mZmC6WzQAhiO3Jr1ktlwoFiRPodIE7fjGWYbJgcx3rk+O7LxPEsS27fHxyVwzN7FakoF/Qtu6JmevXbjKmpH3u+szj02lOjx+kHP9fHMTbcOIByLQlQApTXl7TRKHMeAzsnNMsig5p5JbrWCNzb7qIy/TabOUCMk7gbqZhneLkP/JF4EN1RF75ZMx491UcHYtoaWyMP8hJaKOgTXds8KzkQxdZp6lIwvp41PDmJhVgO376+o6bwDMloDfGpxG69vSlkZ7FZZ+Wiu8i2SOpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793260340; c=relaxed/relaxed;
	bh=sqagyVcKqIAinu4JxuHIZSAS6rRzPNadzZhNbuXuo+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=mXKW1Yw43RP8ob11XsXjDvVbQAy95QItgmglUKYhIixxLlMci1dLwOUFVZGH5xgigqT0qvh7kc94AKbRvCRnmitB0hR/tlYcLJcydkChMEMhpB6uSA4jxH0FMUpZ8seXhsBXwkWRZDxBKUJHEdZvKtSbAcpgBJFlGKjGgljayRFnpZvlMZvrn4hAGmQ9xmx2atuMniLoryvxUU1tbzvhXyFPOkWyBffUwEZS1wsAM43BoMrgH+vgysQuaxsBvOXpYskpsDeSDgsSI5j6pyvdRyZq2UTlh1e38W9Xjjo7HdRpOvhhu+SpJlaUl/9hPIvmZkwRrgiDH/wgnp2xlZZcVw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=billy_tsai@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFbzk6pgnz3048
	for <linux-aspeed@lists.ozlabs.org>; Thu, 29 Oct 2026 18:52:18 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 29 Oct
 2026 15:52:03 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 29 Oct 2026 15:52:03 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
Date: Thu, 29 Oct 2026 15:51:54 +0800
Subject: [PATCH] arm64: dts: aspeed: ast2700-evb: Reserve coprocessor, IPC
 and VBIOS memory
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261029-ast2700-evb-reserved-memory-v1-1-ca1360d585d9@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIABr74moC/x3MQQqDMBBG4avIrB1IImjaqxQX0fzaWahlUoIi3
 t3g8lu8d1KCChK9q5MUWZJsa4GtKxq/YZ3BEovJGdda4zyH9HedMYw8sKLUGZEXLJsejMYPU4i
 +ta9A5fBTTLI/909/XTeUBCUAbQAAAA==
X-Change-ID: 20261028-ast2700-evb-reserved-memory-e38bfad8619a
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Arnd Bergmann <arnd@arndb.de>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, Billy Tsai
	<billy_tsai@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793260323; l=2191;
 i=billy_tsai@aspeedtech.com; s=20251118; h=from:subject:message-id;
 bh=XeDRHsPi2k+CJeY1+La1RVHwRDnYoS77GIz9W0YvdBE=;
 b=A0sObIioWr33st/x7XXxLcltHvLkUZzDkbvHk3dGjV8HJbQuNdyuI1n81g6fNqzcC8W15IXAZ
 GpOGCylX8nDCD/IE+z2YAh4Dl5Wy2FoUN1ZNH6GP4CPCIwjwocgp9wv
X-Developer-Key: i=billy_tsai@aspeedtech.com; a=ed25519;
 pk=/A8qvgZ6CPfnwKgT6/+k+nvXOkN477MshEGJvVdzeeQ=
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On the AST2700 EVB, the boot firmware places the SSP and TSP
coprocessor firmware in 0x42c000000-0x42fffffff, the IPC shared memory
in 0x431080000-0x431b2ffff and two VBIOS regions in
0x431bb0000-0x431bcffff, and locks these ranges so that accesses from
the Cortex-A35 are blocked. U-Boot does not add reserved-memory nodes
for these ranges to the DT it passes to Linux, and they are inside the
memory node, so the kernel uses them as ordinary RAM and the EVB fails
to boot once it touches them.

Reserve the regions with no-map so the kernel neither allocates them
nor keeps them in the linear map.

Fixes: e77bb5dc5759 ("arm64: dts: aspeed: Add initial AST27xx SoC device tree")
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
Assisted-by: LLM
---
 arch/arm64/boot/dts/aspeed/ast2700-evb.dts | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/aspeed/ast2700-evb.dts b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
index fe8f0b80fb2c..795284253ea5 100644
--- a/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
+++ b/arch/arm64/boot/dts/aspeed/ast2700-evb.dts
@@ -24,6 +24,42 @@ memory@400000000 {
 		device_type = "memory";
 		reg = <0x4 0x00000000 0x0 0x40000000>;
 	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ssp_memory: ssp-memory@42c000000 {
+			reg = <0x4 0x2c000000 0x0 0x2000000>;
+			no-map;
+		};
+
+		tsp_memory: tsp-memory@42e000000 {
+			reg = <0x4 0x2e000000 0x0 0x2000000>;
+			no-map;
+		};
+
+		ipc_ssp_share: ipc-ssp-share@431080000 {
+			reg = <0x4 0x31080000 0x0 0x800000>;
+			no-map;
+		};
+
+		ipc_bootmcu_share: ipc-bootmcu-share@431880000 {
+			reg = <0x4 0x31880000 0x0 0x2b0000>;
+			no-map;
+		};
+
+		vbios_base0: vbios-base0@431bb0000 {
+			reg = <0x4 0x31bb0000 0x0 0x10000>;
+			no-map;
+		};
+
+		vbios_base1: vbios-base1@431bc0000 {
+			reg = <0x4 0x31bc0000 0x0 0x10000>;
+			no-map;
+		};
+	};
 };
 
 &fmc {

---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
change-id: 20261028-ast2700-evb-reserved-memory-e38bfad8619a

Best regards,
-- 
Billy Tsai <billy_tsai@aspeedtech.com>


