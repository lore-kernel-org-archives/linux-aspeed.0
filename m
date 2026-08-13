Return-Path: <linux-aspeed+bounces-4716-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E0BC5DF66
	for <linux-aspeed@archiver.kernel.org>; Fri, 14 Aug 2026 00:46:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hLk7G6Qmzz2yrd;
	Fri, 14 Aug 2026 10:46:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786622409;
	cv=none; b=HaQZbS+4jyup9h8Zhou4IkXL6d+8hD4PgrSEBF+eP/zNBMAK42qCf4rPCg2Tbv6+G1fRMP2HLlhHGLJlUKVpkzc7phHXQEwPOSApozij55gtOur0UlwblrFvkjtFo5tsAAMgtR4iFlt7fDBtm8kbHERDeyzPYteeh6M5o64dbN35vYKaf5f0SeEh2fgncvZIa+kFdpqCfVNMf1nrjOep16dKPfEUIy743a+WkedI/eFCVTdjjsIw3u377msLEHC0/C2iRig37575+mAhNd/YlkZ4p/v50/bVUnU+LgDh9WoDy2JrOg3qNaoco4eRjtevHyS+r4Pk+bxCDPcf1RDUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786622409; c=relaxed/relaxed;
	bh=gl7pzEDzH9tjdIyxD95ZeyTVYyxrwo2K+cstBIKfrsw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajXRB0ib4BBGS9uZCBiS2lRz3tfCgsxTRPqIhBI8MQWJ3ajVfTf7NkBMKPv1KPVnLrMkWjtnu2JvFMmyH7px+kQb/UyEgEvU//3WPtblmtZejrKZwVoEKu3CFORq2ytoW4+Ycwgx01kMgFK5g6nZf4+It83zRVu5J8alnzdpKPHY9cuj9dC8QLoeghAf0PvUcNwc9lzbue2rPGCW8nny8cg6GMv5Yc+DmUUBGrebT4u/F+WCrnf1DiV5S0HTHV+bKVZFbIYPfsmVeZzixej7SVD8fu7BwCHsS+qwrpT3I+olCVi5Oi/iWRQrDSE3kmGoYzhmQCKJkh40D5iQRoBM1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YxGcxvfC; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YxGcxvfC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=devnull+u8813345.gmail.com@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hLP7B35Zrz2ypm
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Aug 2026 22:00:06 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 10768440B2;
	Thu, 13 Aug 2026 12:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70437C19425;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786622400;
	bh=295IKqaeCumSuUEaZhnHHBluCh18/amZPEFle+tiP3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YxGcxvfC2rGJ4++Ys4Sll/sqCSngCdT90KsuytGLQZ9Wd7sb2cORCGbenG497jNwa
	 YsMg3AuIVKsoeTjjTG8AamXwlgz0YQ+Y1PdYodVNSWBD3sNkNjUiiQRqhcWjnSUa6a
	 B8SPMnPIsNKsctGVWFt+AymfeIvgpjRQ+xSfKkwbhXbIyeGW3rndKEwsKaCSnK16D9
	 lfDb1uUYYyOWQKC/T0Aq3SElvy+lWtOPGApr14Bu0OSr343H72q24XFjKVnlhL3ZKD
	 707ZW9xUVIYqDxgXs6lnnqQQX8+0mIgiWzhooVeTUr9v/v78FV885D2eO09c1DE2Sz
	 IPmPN5JPEemoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0FFC5DF6B;
	Thu, 13 Aug 2026 12:00:00 +0000 (UTC)
From: Colin Huang via B4 Relay <devnull+u8813345.gmail.com@kernel.org>
Date: Thu, 13 Aug 2026 19:59:42 +0800
Subject: [PATCH v5 12/15] ARM: dts: aspeed: anacapa: Add SPI flash VCC
 supply
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
Message-Id: <20260813-anacapa-devlop-phase-devicetree-v5-12-c7058f63dc67@gmail.com>
References: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
In-Reply-To: <20260813-anacapa-devlop-phase-devicetree-v5-0-c7058f63dc67@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>, 
 Rex Fu <rex.fu.amd@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622378; l=941;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=f6LU0FAv4z223NfwbW5+xtWf2s69Q4QEuw+6jPL4YpI=;
 b=hxmqSUUNDPFUSi5olnMyqpzfvJ1Z1bOj6dU+/km8oNPb+g1XvRmOkm/uKa1kUDaYRoIa0YqE9
 2aaFkPODsyODkknuDeC+bw75S52+eNE2N5JNs+wP2WhQZQqClhSoVSv
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=
X-Endpoint-Received: by B4 Relay for u8813345@gmail.com/20260202 with
 auth_id=761
X-Original-From: Colin Huang <u8813345@gmail.com>
Reply-To: u8813345@gmail.com

From: Rex Fu <rex.fu.amd@gmail.com>

Specify the 3.3 V auxiliary rail as the SPI flash VCC supply to
avoid using the dummy regulator during device initialization.

Signed-off-by: Rex Fu <rex.fu.amd@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
index f913fa3f622d..cb4b815f1803 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa-evt2.dts
@@ -27,6 +27,22 @@ / {
 	i2c51 = &i2c10mux0ch0;
 };
 
+&fmc {
+	flash@0 {
+		vcc-supply = <&p3v3_bmc_aux>;
+	};
+	flash@1 {
+		vcc-supply = <&p3v3_bmc_aux>;
+	};
+};
+
+// BIOS Flash
+&spi2 {
+	flash@0 {
+		vcc-supply = <&p3v3_bmc_aux>;
+	};
+};
+
 // MB - PDB
 &i2c8 {
 	i2c-mux@72 {

-- 
2.34.1



