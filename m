Return-Path: <linux-aspeed+bounces-4593-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97930C55165
	for <linux-aspeed@archiver.kernel.org>; Thu, 30 Jul 2026 13:14:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h9qRT13vtz2xnp;
	Thu, 30 Jul 2026 23:14:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785417269;
	cv=none; b=n+6v7T9uPGWsdt82hsoZw5gcrGYQbdBTiV95yvgsxJxcDBCRFGYdl7MmO9VSJSGQCHscKG3n7XOgFZa/YPyKsRcjcVm6hiUJmUbADbBCYC1xJ1yThnsRehBoyfvML+frWCvf/AXJcfVzdNHer8luboHHQ11EqAPRWJhMlr0wRYxZB8eHmvKCqmk1dyi8iCncMaRLIFmuUfAJ1Xn/GQ6s+O/1ogoMK7jkhROXQ24CdijmoSJPIQrBhRKEST21uFbOSocYoP+R9zBk/IJvgFEzdNBJXrgUaRSfKYCv/TMrYAM0tyJlSjOYvakBpqqOm1PMMjc5JbcJuULpU2yCgBNdIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785417269; c=relaxed/relaxed;
	bh=fIimPfmpV9l9JFDbTgwNS3L9wHvGdkzsHcN3zdJj86g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Kytftocwenz/cuABxWmod1KZlbsoUYcI/JFFKDSk6h8tTAGgoHogTMH+f0cYHcDLSjbMvWQtwMEedRFSZ0+ISVE5ASZ9otmJjkBuQWD+f2dDgoxcE8iiSM9wlgDYKd2m5fLS7S7oDKvWSvtnEs5dva86cRF9UYKdsR7BIeD//8SODueFky56nRdJ/pXHUgN2LixHmse4s211ycBRBnPNONFtnbyOMhk76XWYSCxdg49qL/uqKEwo/HtVA/kSat1e3PmKaha6U0qFAcU/ZzFjzFYgw65oGf9uyVHJdxFbUQy1zqydm1JequsrRzmjFdjaq8i3YdDbSE38yofvEWIuzQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XOEXiU/1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XOEXiU/1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=potin.lai.pt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h9qRR4fydz2xRs
	for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Jul 2026 23:14:26 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso1896413a91.1
        for <linux-aspeed@lists.ozlabs.org>; Thu, 30 Jul 2026 06:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785417264; x=1786022064; darn=lists.ozlabs.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fIimPfmpV9l9JFDbTgwNS3L9wHvGdkzsHcN3zdJj86g=;
        b=XOEXiU/1HFkTcb2ptjP8a8A9xrxxg+GNujukC8DX8kb53jAgp5vd9Z1bfYiaHkxqR2
         MteUyVkZiv6SkY9CZbufuCglt9Lf3wd1jm3K2fUqBlKIQ0zei8dS9PH0ZjsvK9Af3Qxk
         R8xwVPbf2aWdp/3BiwtpgbaHwAs0RTvMUAkuaXIsG2F8Q5ERudXf84eKbxWwWGyvoDFK
         XLA3ADf7gFLvddf9qY0ClaMcojj3GYopejE5+lTDD5v7JeaNIZorGYr+phCd7MyLFNmq
         yy30O7C+bmOR/9/mVIVPH3vwJzNKvyfXKZRjm0SEK/RqI16VAba+9mPGE1YmCgt06FAZ
         XyPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785417264; x=1786022064;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fIimPfmpV9l9JFDbTgwNS3L9wHvGdkzsHcN3zdJj86g=;
        b=g8IjMPOh6O6lDvMtWcburJwp+6PV60e1TOJEPxyJtAzzx9ah2xMfVBg86AVRJveYN6
         MY9mQMHlPpzpKG1AlZBWTc1BtY11+8xGHZXB/tgMQPeKXjJ4uiStAtjH/yFYbXLQy3OG
         oqvCmWWg+NqVFBcE1rmRD3xJlDhyGEKVTRWVkoM3fQ6GI/4n2ZzWFAXYmPMjEju6iDLB
         104+fr0LpwhvicEZKclgn4+ikX9zQLQCrziL+BNXXcm0WkYyVkiEvaKlqTL76ttgUy6l
         1UhhrWIWuyAWhjJIPtadVYXb7lg8qnQsMLnISbrNIRv0XIuwn5mEGr1whOj2ztjHwUTD
         +I8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rold0wdUfZb7k4DlYWyl7Z8K1+Mvzf0/UcXvi3dgAGA0MR2Cncut41MiAnX81HcaOUqxh4OdMmtiPsoyCY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyXzTbuHVBcVHP/A4d/kGqaaGPsyOIHZSReOAdvNDTGjbBVmVi2
	ZhwDS9vH6JgZaKcYUXXlTy8ssQK8gC9mJag8D2JINB++q17OCJiyaw6m
X-Gm-Gg: AR+sD12uLBbdPNm4tzkjXHAfkgzWuFoATqaEg3TLDELchR3wa9T8gAQfPuRZsJ02C8d
	Zm7oQeByZl/uffvkfEs8Lt1kPEyxFq1ZPnW2Nv7oL2gfE++EvszKqzBxKwpnw3Jf8m4cCNG7xfo
	7LFamv6Wu7VAl3ohlTd0V1vFsPjMFuEiaTTk+D0P/F+qLMG7j/A9NcYs++htAne1PuApqlD1vHw
	nr2YxkJnALgC8IgtjaDT45q+CChEklChu6L1MBOnX+aHyJllP/1qxeJqZ+BuO4gC8WI0APzWHzB
	W3jSzGr4Sw0k1Mj0jbYwZqzFQuXWzJAFIVXMWS0fr1A91GBBGfwXN+8QLMlixmicmxP0fp/Djlx
	iTNOLYkmJ6HxqF9pqkdZWU8cu+MRx1MUrFS8aG3QxapEbdGvNZIX5Imx+vMviZIFwieMJpU6bHU
	oyRAM8FdMHGbye5wuGf17l1RCvu6s45mZA0E2jCeRNcwybzFb0vimELuQy8pBmJ9rmYymVV+tfO
	cJwIHIxZY7lRY6aCBjhTWgfACEw5so=
X-Received: by 2002:a17:90b:4fc3:b0:38e:6bd7:fbbf with SMTP id 98e67ed59e1d1-38f9bed468amr2139138a91.20.1785417264204;
        Thu, 30 Jul 2026 06:14:24 -0700 (PDT)
Received: from [10.10.15.228] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9babf9f8sm1068756a91.15.2026.07.30.06.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:14:23 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Thu, 30 Jul 2026 21:11:59 +0800
Subject: [PATCH] ARM: dts: aspeed: sanmiguel: Remove HSC nodes
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
Message-Id: <20260730-upstream-sanmiguel-remove-hsc-nodes-v1-1-f0308eb8a00c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJ5Na2oC/yXNSwrCMBRG4a2UO/ZCbEGJWxEHefy2EZOU3KYUS
 vdu1OE3OWcnQQkQunU7FaxBQk4N51NHbjJpBAffTL3qL+o6KK6zLAUmspgUw1jx5oKYV/AkjlP
 2ELZaOz3AKa8ttdJc8Azb73J//C3VvuCWb5qO4wO3zpDPhwAAAA==
X-Change-ID: 20260730-upstream-sanmiguel-remove-hsc-nodes-b99c93ec0d9b
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Mike Hsieh <Mike_Hsieh@quantatw.com>, 
 Mik Lin <Mik.Lin@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785417260; l=2011;
 i=potin.lai.pt@gmail.com; s=20260522; h=from:subject:message-id;
 bh=ryzjF1cLKw/XipIXoQ7vZ1VOYZcEuP7I+1ETkK1xx0Y=;
 b=APDPwAeB2o0hAhzdf/pC6qqRxJFxUcbKKwxw7AgS883bDvOowl+qCAStY4zQ1rQ0mrvrD3bUT
 dEkQ4HcTDAmBgrywTkWcPnGQgmJ/ihcig0RjsvDsaFPCr86EPL1ApXt
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=j3/nMxzz1ZPpp1revghyZ8IqOnwi6RWfuxXN2XrNMRE=

Remove Hot-Swap Controller (HSC) power monitor nodes from the DTS.

Due to design requirements, the HSC driver probing is moved to userspace.
Removing these nodes from the device tree prevents kernel-level automatic
driver probing and allows userspace to handle HSC device instantiation.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts   | 44 ----------------------
 1 file changed, 44 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
index 3cc6e772cc8c..98f224d2c091 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-sanmiguel.dts
@@ -442,50 +442,6 @@ &i2c8 {
 &i2c9 {
 	status = "okay";
 
-	pdb_mps_hsc1: power-monitor@10 {
-		compatible = "mps,mp5926";
-		reg = <0x10>;
-	};
-
-	pdb_ti_hsc1: power-monitor@11 {
-		compatible = "ti,lm5066i";
-		reg = <0x11>;
-		shunt-resistor-micro-ohms = <1000>;
-	};
-
-	pdb_mps_hsc2: power-monitor@12 {
-		compatible = "mps,mp5926";
-		reg = <0x12>;
-	};
-
-	pdb_ti_hsc2: power-monitor@13 {
-		compatible = "ti,lm5066i";
-		reg = <0x13>;
-		shunt-resistor-micro-ohms = <321>;
-	};
-
-	pdb_mps_hsc3: power-monitor@14 {
-		compatible = "mps,mp5926";
-		reg = <0x14>;
-	};
-
-	pdb_ti_hsc3: power-monitor@15 {
-		compatible = "ti,lm5066i";
-		reg = <0x15>;
-		shunt-resistor-micro-ohms = <321>;
-	};
-
-	pdb_mps_hsc4: power-monitor@16 {
-		compatible = "mps,mp5926";
-		reg = <0x16>;
-	};
-
-	pdb_ti_hsc4: power-monitor@17 {
-		compatible = "ti,lm5066i";
-		reg = <0x17>;
-		shunt-resistor-micro-ohms = <500>;
-	};
-
 	pdb_ioexp_20: gpio@20 {
 		compatible = "nxp,pca9555";
 		reg = <0x20>;

---
base-commit: c2b9fc3f7091157518a3ac2282a0a8bc797c227a
change-id: 20260730-upstream-sanmiguel-remove-hsc-nodes-b99c93ec0d9b

Best regards,
--  
Potin Lai <potin.lai.pt@gmail.com>


