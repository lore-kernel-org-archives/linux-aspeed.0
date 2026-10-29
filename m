Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DC0606A33F
	for <linux-aspeed@archiver.kernel.org>; Thu, 29 Oct 2026 07:26:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jFbPX3Wcvz30Ng;
	Thu, 29 Oct 2026 18:26:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=211.20.114.72
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793258768;
	cv=none; b=QchFszbMmSGkDEpgqdM5GLRuZkMoC7udKpDhd901Wyn/a8EXR+rMKKuwwavxtHN4jaQbJlQLrnfisOazn8lpjRFNa7yiA4ikVganC67BF/jd2JX1B4n4B6Xz56zxAAgZMp9tKyh/ByIQgZInZqn7zm5DWtxl8JZo84dWxxUX0Ti9GWktTV8rsAYxIN33EJfpwYPcU45rCAKv7BVliO5R2rBhM83d7Dh+R4U/lbiEEOC6R1xYzb312O/Ne7kHVKaCqQzukNyH+GcBMy0hjmsVwtG7WzkbhDVj8aDJnWEHwlxrOEludq2JY+DT0Gjjl0Pg3gM2USeEbgOI/dwdAE2Skg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793258768; c=relaxed/relaxed;
	bh=NcAKdYZtTddQxjzrFXtQFy0f32SfgKRx0yegr2UvgLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=EmV3VSV+rGeL80AfhNV8bPyPIXk5GVhsadItiHkpxRB0kHd3WFX4t0GTsc3iJV+Vbltb9iTvfq1CAPCmC25yvd4/xtKD/qMg9n3gHOv4hG+GVgqG5eLnmJsMPOBHWo2dyBWl6RIpPvv2X3eccnwGzx3xodcxoOojJCtDqB0GSpzkmAL8jLYTz5a/m4QANy/ZIu8ziRq0Hf7+d3hmWGvgGszJe9zAjwJxQfDGfpz+RZIDeBSNJH5Su8V7pqZXdjIGIAON/61tYDqVonk6OcJR4blXnRoRE+ID3QJaAmM/tcYSmnzZ8cdOPREQG7KMoaOR4SXlivnNeBnee2QyPGWjZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=cooper_huang@aspeedtech.com; receiver=lists.ozlabs.org) smtp.mailfrom=aspeedtech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=aspeedtech.com (client-ip=211.20.114.72; helo=twmbx01.aspeedtech.com; envelope-from=cooper_huang@aspeedtech.com; receiver=lists.ozlabs.org)
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jFbPW2fWxz30MZ
	for <linux-aspeed@lists.ozlabs.org>; Thu, 29 Oct 2026 18:26:07 +1100 (AEDT)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Thu, 29 Oct
 2026 15:25:50 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Thu, 29 Oct 2026 15:25:50 +0800
From: Cooper Huang <cooper_huang@aspeedtech.com>
Date: Thu, 29 Oct 2026 15:25:48 +0800
Subject: [PATCH] arm64: dts: aspeed: Enlarge AST2700 EVB kernel partition
 to 12 MiB
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
Message-ID: <20261029-ast2700-evb-kernel-part-v1-1-e6f52742c575@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIAPv04moC/x3MQQqDMBBG4avIrDsQI6TGq5Quov2rg5LKJIggu
 buhy2/x3kUJKkg0NBcpDknyixXto6FpCXEGy6earLGuNdZzSNk+jWEcI6/QiI33oJldN3aT9z2
 CA9V6V3zl/J9f71JuW81P7WkAAAA=
X-Change-ID: 20261029-ast2700-evb-kernel-part-63b3c998ea6e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, "Andrew
 Jeffery" <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>, "Chin-Ting
 Kuo" <chin-ting_kuo@aspeedtech.com>, Cooper Huang
	<cooper_huang@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>

The 128 MiB flash layout of the AST2700 EVB reserves 9 MiB for the
kernel FIT image. A FIT image containing an LZMA-compressed kernel,
the DTB and an initramfs is already close to that size, leaving little
room for the kernel to grow.

Grow the kernel partition to 12 MiB and take the 3 MiB from rofs,
which now starts at 0x1020000 and shrinks from 82.875 MiB to
79.875 MiB. rofs still ends at 0x6000000, so the u-boot, u-boot-env
and rwfs partitions are unchanged.

This is the same layout used by the OpenBMC images ASPEED provides
for the EVB [1], so the rofs partition described by the device tree
also matches where those images place the filesystem.

Link: https://github.com/AspeedTech-BMC/openbmc/blob/438e761ed38644b77ba704c984cb607649bf2724/meta-aspeed-sdk/meta-ast2700-sdk/conf/machine/ast2700-default.conf [1]
Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Signed-off-by: Cooper Huang <cooper_huang@aspeedtech.com>
---
Notes:
- "Already close to that size": with mainline at c339f4010dea
  (v7.3-17997), ASPEED's aspeed_g7_defconfig [2] and GCC 13.2, a FIT
  image with the LZMA-compressed kernel, ast2700-evb.dtb and the
  OpenBMC phosphor initramfs is about 8.99 MiB, less than 20 KiB
  below 9 MiB (the exact size varies by a few KiB between builds).
- Upstream OpenBMC's AST2700 machines use the static-norootfs layout
  (no rofs) and are unaffected; the rwfs offset does not change.

[2] https://github.com/AspeedTech-BMC/linux/blob/76457d3afe2bd4022ca82dd9eb8fc48b84f0e9ab/arch/arm64/configs/aspeed_g7_defconfig
---
 arch/arm64/boot/dts/aspeed/aspeed-evb-flash-layout-128.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/aspeed/aspeed-evb-flash-layout-128.dtsi b/arch/arm64/boot/dts/aspeed/aspeed-evb-flash-layout-128.dtsi
index b54915f06efd..f54d53077538 100644
--- a/arch/arm64/boot/dts/aspeed/aspeed-evb-flash-layout-128.dtsi
+++ b/arch/arm64/boot/dts/aspeed/aspeed-evb-flash-layout-128.dtsi
@@ -16,12 +16,12 @@ u-boot-env@400000 {
 	};
 
 	kernel@420000 {
-		reg = <0x420000 0x900000>; // 9MB
+		reg = <0x420000 0xc00000>; // 12MB
 		label = "kernel";
 	};
 
-	rofs@d20000 {
-		reg = <0xd20000 0x52E0000>; // 82.875MB
+	rofs@1020000 {
+		reg = <0x1020000 0x4fe0000>; // 79.875MB
 		label = "rofs";
 	};
 

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20261029-ast2700-evb-kernel-part-63b3c998ea6e

Best regards,
-- 
Cooper Huang <cooper_huang@aspeedtech.com>


