Return-Path: <linux-aspeed+bounces-4273-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD391CD98ED
	for <linux-aspeed@archiver.kernel.org>; Thu, 18 Jun 2026 23:28:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ghH3N1bnbz2ytj;
	Fri, 19 Jun 2026 09:28:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781768453;
	cv=none; b=hiGHlp+iALeVLTyYfMZmIqPM4xDsI3I7bj+foTIU4HXllzN6FCO8NVwRqSg7CToWCOVA2PBUtTuaqm5tnIlgqgscso4Bbckz/84g24niwf8jiRltW0dvNUINblI4laX2J7Et2R1gKN1mtbgcPpxwK8YHM90bql2jyHb20KVyRfL8XHQvr6DE1uc99AkLDVmHh3t1fKEhP3RwdZpxu8/DkLjWekdZeJNi2nqBnDnUB2Zj/S9+jKCfaQpOTD4dtlyuvVRIShkFDZNWq5fFnXXD8W/N33P0UWH2bmE237zvAox4AAb7q1PwXklBIeGLIX8xJjBwb9Xb0cI2NVcJdCJqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781768453; c=relaxed/relaxed;
	bh=p2/FZLzoVxADBjl0oAzsk6lNUq7prryi/YMGy+b9ziM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lHMP8KvdbZ+xQusXujkNyLL5+Zf7k+vyl5TIo/fLUcghSTppF9pDrf0D5JDwHL3ki9LdvmrOxKrwCKr1Tlywus6LoIBs7fnSfJxwfTFtGao4/lnIbB3yilnXImlWWhnqULjvWDCNYSwFVoWaRThSnhwYtXYoYZ9nN5KQEAChhDh3D91RklhAhhcrG4+dcB23Q2QxHyfAmFA0vxBqzszT3uA7B93bAR1rFqm83GXc3KYoQSUL0eqSPUh1ITOMOnavhBp2gXBw7kg50LM52eMN4cq/kn7+XoXdCwHAznxyVGL1v/v+YnCHZNX4g3ANwXJ0LQd/2jC80bsU4Gj9Now/Pg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b/s6RN+l; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=mike.quanta.115@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=b/s6RN+l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=mike.quanta.115@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggt1w4R3yz2xC3
	for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Jun 2026 17:40:52 +1000 (AEST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2c6be9cd89bso2730715ad.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 18 Jun 2026 00:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781768451; x=1782373251; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2/FZLzoVxADBjl0oAzsk6lNUq7prryi/YMGy+b9ziM=;
        b=b/s6RN+lnh/p5OCJgxq/hVh3dSIgr4oL64zxQ62MgzUbS96EXwW0Tyjx8ZEn19B8yH
         M+jtLG+6n8nSW7OIB5GFp/xsXVZDlpWZgC91Q2xEK+11yPeMPipiGOu+EXFpdYkXfgi9
         4e88VvES3ekz4w1X7d+zr7fy7HQeyzD0N3GsA8sxUp0R83KxWUuiWtzJ1i/vUdWmjikr
         LnLsJIxuv+8eIyHgyD6/61D5F08qza762lMkO64f6wDneCQXoV0nZlDF7mN54xlA72sn
         gVpEsOVlHR2t8MJ/ioMY3YMh7+i3yf8RRokxlCH2K2Kx5bGaw2272IX3DOQfYipqBuas
         dopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781768451; x=1782373251;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p2/FZLzoVxADBjl0oAzsk6lNUq7prryi/YMGy+b9ziM=;
        b=AnhpnuBq8PaU9wVWJcghDamZzmTKITX8R2FziifhD3Nd0+KD+UlbXr83+4MHcNlTbM
         2ig8KhjFBJYNs7o366mGT3/HJgwnMnAHmTkpZDoezWowa8oQBanRcsOh9Jm2Y8OylocQ
         cP/6Fr0CVkTgSZ0LkQUV3xzGvk0GRsCKxTYeL8aKIxgynEZCTed0Va4CaWgrkuZcbdXd
         qgdUKWJpDc34U5CtOu6YFFwOIxo0U9AZmL1SULUAfygzargMCF9Jq7RFAxcl/Usn3C/v
         eZFlyGTKXe67HbHnVYu4D/YYEbBUdxTBa6TH4y7pzM1jFaKsZj0YXMle7ftCOlNOkPhk
         eL9g==
X-Forwarded-Encrypted: i=1; AFNElJ9b3zEJqqfBVHOjKSfVCYqJMWOPDiRrhWXu2CqUFcZ/9rO+WyOJ3OSXBZh7kZzTjtwJg4y4bdUUE0ansAA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx2rF3Tif3CEf/X3EumFwQBMtRJZ8/y2i663+ffkgcbXDuiLxbJ
	eTQ11htIuEr8MpNfulfMOoT5bQNJMlNwklAbwGMwKtRe6BzNyzAO1pyqolhnAg==
X-Gm-Gg: AfdE7ckuMx4/IeO9dk8nkNTg7oyOBdp2nxVl4t+dSzNamIjSyU3/wVL/QVCnZjsOJ2m
	AXAr1wMESwgLzBOQu/GtMjbOGzqUKphAt0358WJfZgBSKpTjLW9ud2kZz/7Xnzt3Yx9IF6hyEyB
	U5lLgjx2EzmCfT1EhxCz71AiUGmg+K7AbBIp6gkGscYZGmm0OMGFZ73DRd6+Z8AlKphdm7X/xxS
	qaSV2JNBI4qqMLKeKSoFW88gL0r8wDB5R0srowYoNcXlcjSSsJ86x7MGpzL0xXeEWNsiLte6eIS
	G9ooPTg/lIFAaZi2V03C0SWGGXje0CiUTtTwHoEqZ5ZgTTS4QdXkxNo5iFPdu2bidwP0PGej722
	5B3bcY3KA3kTgl4HAlAk/WwgmPq2PB9CWc6/GQnmJW8qUslDTssYCGRfmSpPNcaF6YGzY4BXbRU
	ReTjrgRcynsV2SyL9JrVJnjNnFFLlEKanhkG4zZRxsj+F5ettB6cK8A5td
X-Received: by 2002:a17:903:2990:b0:2c0:b9a1:6493 with SMTP id d9443c01a7336-2c6bc0b5814mr75341575ad.10.1781768450629;
        Thu, 18 Jun 2026 00:40:50 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac80asm170465445ad.39.2026.06.18.00.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 00:40:50 -0700 (PDT)
From: Mike Hsieh <mike.quanta.115@gmail.com>
Date: Thu, 18 Jun 2026 15:41:44 +0800
Subject: [PATCH 1/2] ARM: dts: aspeed: sanmiguel: fix PDB HSC shunt
 resistor
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
Message-Id: <20260618-sanmiguel-dts-config-hsc-lm5066i-v1-1-cccf959c9b78@gmail.com>
References: <20260618-sanmiguel-dts-config-hsc-lm5066i-v1-0-cccf959c9b78@gmail.com>
In-Reply-To: <20260618-sanmiguel-dts-config-hsc-lm5066i-v1-0-cccf959c9b78@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Mik Lin <mik.lin@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Mike Hsieh <mike.quanta.115@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781768507; l=1735;
 i=mike.quanta.115@gmail.com; s=20260522; h=from:subject:message-id;
 bh=IGy8dSwMRvN0RUNzS4yQN9vBjblujibQ6wVZmTxzM6A=;
 b=cbfHOcPtJb1bDBHBy3LMkGMxGonf7vsB8e3wJhKElSpx0qCCCNUODeAjxlx7HFfDxdrU3ZWvf
 Iz8Tq3lbjvMCBCJfUp0WenMWljz5JEkNQpngeuvlpn5ytFygSFQaUon
X-Developer-Key: i=mike.quanta.115@gmail.com; a=ed25519;
 pk=DRIErV0xX0KMBlR/irAsbuN4L3egitHbC8FHruUH4HE=

Correct the shunt-resistor-micro-ohms values for the four TI LM5066i
hot-swap controllers on the PDB. This ensures accurate current and
power sensor readings from the hardware monitors.

Signed-off-by: Mike Hsieh <mike.quanta.115@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
index d7ed497d7227..3faac0925a79 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
@@ -450,7 +450,7 @@ pdb_mps_hsc1: power-monitor@10 {
 	pdb_ti_hsc1: power-monitor@11 {
 		compatible = "ti,lm5066i";
 		reg = <0x11>;
-		shunt-resistor-micro-ohms = <763>;
+		shunt-resistor-micro-ohms = <1000>;
 	};
 
 	pdb_mps_hsc2: power-monitor@12 {
@@ -461,7 +461,7 @@ pdb_mps_hsc2: power-monitor@12 {
 	pdb_ti_hsc2: power-monitor@13 {
 		compatible = "ti,lm5066i";
 		reg = <0x13>;
-		shunt-resistor-micro-ohms = <294>;
+		shunt-resistor-micro-ohms = <321>;
 	};
 
 	pdb_mps_hsc3: power-monitor@14 {
@@ -472,7 +472,7 @@ pdb_mps_hsc3: power-monitor@14 {
 	pdb_ti_hsc3: power-monitor@15 {
 		compatible = "ti,lm5066i";
 		reg = <0x15>;
-		shunt-resistor-micro-ohms = <294>;
+		shunt-resistor-micro-ohms = <321>;
 	};
 
 	pdb_mps_hsc4: power-monitor@16 {
@@ -483,7 +483,7 @@ pdb_mps_hsc4: power-monitor@16 {
 	pdb_ti_hsc4: power-monitor@17 {
 		compatible = "ti,lm5066i";
 		reg = <0x17>;
-		shunt-resistor-micro-ohms = <381>;
+		shunt-resistor-micro-ohms = <500>;
 	};
 
 	pdb_ioexp_20: gpio@20 {

-- 
2.53.0


