Return-Path: <linux-aspeed+bounces-3449-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F53D172AA
	for <linux-aspeed@archiver.kernel.org>; Sun,  1 Feb 2026 22:41:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f44V471zdz309C;
	Mon, 02 Feb 2026 09:41:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769761227;
	cv=none; b=fsrLt6yDvwvoFvhEIkdHfbamLc8qlIPibUHzxVZ0DrkTiabxE88mRzCPkkDpyJq5soe1bUTbfNseSvQ1NpG9DWSQMIBF+m00iuCYckgol4L+WRTez4pde4goq1pOYV57E4pEg6RF6jNRttzv6eU4n63wMdk9XSqGcVLNJHuOIOL3W2hztQ/aaD1g8x7TXsOcLQnHOKMgUWMbhiBk5qUM19+QYJgmzGvgTHCOIbsAvzYmh/m7bf+FLF4Ap2IDRFLdk+WV8xBeZL4cd5awGKilFhCM1vjr/mr+KdteMq+HWjR2B+CJq0TBGLPVMcadxSjmbMuAFC4lsP4RwyuI4CR7bg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769761227; c=relaxed/relaxed;
	bh=qEEqxDFM2yhPiyFjlnl8LZDAP48x695zaYDrn7lQEUY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N04NTo9kKFd3BP8JGH79du3zAtC56Avg8tXOBuubT1lTUl2Y3XpgAl2noVdwzjjtCzWfYAF1Vcf4uJByI4pZn/TW1AzS/8VCrGPzhXCy0mp9k6k8z9H34m83Ow0LgWzRerSyAsVFHc1p0s6L/OtHKTehigc3sL+wWV0fvjdZ3jjd1sfDjCqYSqMuyRTR1Gc6dPoYgbDuRDT13hicF4+vqoCZqrAK71UCL1sZQ0tyAwLjhLtXFZAPJcxKifPzTaZMYdm5SglrCkGW7T/IVEbu1a4/16zyi+VR2WxQ0+t64+MMP3MOHnUs/XrGx8+wXfDuMaVM4Gp2ocax0LSjlH6wXA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aE2EzdZq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aE2EzdZq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f2TTk2T77z2xjP
	for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 19:20:26 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-81c72659e6bso1759816b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 30 Jan 2026 00:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769761224; x=1770366024; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEEqxDFM2yhPiyFjlnl8LZDAP48x695zaYDrn7lQEUY=;
        b=aE2EzdZqqBjpDjfQ6vp7In/X1kM5QzUNEQMosn4Wd8nEIczxKvU9rPe+oRE9suDE1m
         myA1fGHgHREV9Ww0g4PN0iuHnOOJSfHNd8+FaOXcPLvgCVDTGWeUKV3k+3aFrwaHgIcG
         CvEty5Cb44DzFkJHF3HRI2XOOZLLOfKpMIHbR8rbmvMpmQcivX2qgj8e7ny8qFVIGZFd
         eHR9y52SmWr9noyyomFT0TjAVOFHa9eUqgml5qVsIJ4bQXYrOpBnDwUpZg7X4XmMJ+RN
         bErkwxWcHdDxSDV92XdIh1AL5Jinyl3ScJcdzx57EVuYAtcqRAVdZVEc83hymmQWOWxz
         kx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769761224; x=1770366024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qEEqxDFM2yhPiyFjlnl8LZDAP48x695zaYDrn7lQEUY=;
        b=fEuYkFxdEjpsSsMQAe4ZVBvsnOYdVSuMjbQGkbwxbxIIJPl+t+uICpl8YeqiK2cmjj
         Sab001nbEBUHMhWxVqVMPIrucdTdEIUGFkuM9wxQfo5QPCKtzrO77s35g8D5ZNylRTBd
         Ge4WVvLt4wGuydFIkgzEh1dF2/eDnvGzD+aRlFD9eaW0tde0DzRWF7vm0A9+dhyomSYW
         k2rrEzipK7CRRn+UZc9/+2cz4DSjw2lP6LNTeH922cP06FiZ2BatCWwnuHqGRAWKrK5r
         4xjU/M1wQhKFOEvA6R8KEWSOEQj4ctAuYuxP4sICbCpE8gE2why4Hn/rTPu7F7CLSqpD
         vHMA==
X-Forwarded-Encrypted: i=1; AJvYcCV+qvAA8bZMAhWA8DyeasO2kyd0rWs6cXBemul52Zz/N8yfJ0tjDGpUzkK5gX6as/Nb6U6/2sRjgGh+xXA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyfucK95PWDGLQwzckBFQfvFlfLU4Fwf7bn03rBGRaeZRr4L0Y2
	ZfmuvqKM8zjiplXbbb6KKjXLOOKGYaNePlRy2O/9CALvd1TRFbUSFJ1+
X-Gm-Gg: AZuq6aLtaDhiF5eckgtp/gJmAjfCv/ZQh5kXoKZgerU0sTzS/yY+1clb54i8y83bMiW
	KPkwEmcyTOlvurGEUfjvjpRxiGDKY0JEwcX2BJx++JeIlR8Ujl1r6JgeF+BaLuImFV86f4vgFrD
	loqWT+thX8Pdq99uFzkb1YUs6bgxS+HlJk7r0Xdf43M7xXkGP2V63E6uZIKtj3niGZfyhdjjq61
	Cqpl3jG0GCajyrz//+8oA0fzrh2+d7F2/DAnQb0AsO8Ct1cIKUPX8QtpsPDxNY5IRweNXyYURbk
	+huhNu3GEoJ0kyNOPzoPcsuYhnFc+vqKgjyzMsVdndE1EJbqM51orRjR/KzfEkXdJAUKLDyD+Gc
	dCCHycs1cfAAzlaY+CSXbYSPmSEI2D07XNa/jIBwbu5NL8yfWuluD9BWIEK1p7QKf/V3EWHV69U
	y/p82re224zqaO5baRhaChMeThjcXoRFtfyGjlQFhI9XcP7OTohxlbGwnWtHcxPvCMx1Ryj1TOd
	t5hNjL73uIUJ+iE34UqFgy1D7NFvLfAql2g1kfZltyrua+GXZoBdD1bVBEvxa8pJ5SQ7tNQTvaz
	6pmHltm5g0aU
X-Received: by 2002:a05:6a00:244e:b0:81e:c91c:70c5 with SMTP id d2e1a72fcca58-823ab6929c5mr2034622b3a.29.1769761224334;
        Fri, 30 Jan 2026 00:20:24 -0800 (PST)
Received: from 2001-b400-e3e0-2a58-5bcf-a65d-c80e-2087.emome-ip6.hinet.net (2001-b400-e3e0-2a58-5bcf-a65d-c80e-2087.emome-ip6.hinet.net. [2001:b400:e3e0:2a58:5bcf:a65d:c80e:2087])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfc712sm7866018b3a.40.2026.01.30.00.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 00:20:24 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Fri, 30 Jan 2026 16:20:11 +0800
Subject: [PATCH v4 3/7] ARM: dts: aspeed: yosemite5: Add new SGPIO line
 names and rename signal
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
Message-Id: <20260130-yv5_revise_dts-v4-3-4d924455f3a7@gmail.com>
References: <20260130-yv5_revise_dts-v4-0-4d924455f3a7@gmail.com>
In-Reply-To: <20260130-yv5_revise_dts-v4-0-4d924455f3a7@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Jackson Liu <Jackson.Liu@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769761212; l=1856;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=bf8xEERmNoQu6JKiJbQyzBDcSJlpDrQjBle4TDLj5zE=;
 b=ogvwTjVkAt6GpHVedyu0m+EtSAcZEiuA+8epK66Orc2l/JiI6JrX75f3U4Gk1Bs6PA/DbtY/d
 MFEPSU07bcxAHHFj8lGNTSM/GW0QQbHAk5NRjPJDDv0eSMozkWHMWmc
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Add new SGPIO line names for user space monitoring and event logging.

Also rename PADDLE_BD_IOEXP_INT to ALERT_IRQ_PMBUS_PWR2_N to match
hardware naming. The original PADDLE_BD_IOEXP_INT is unused, so this
change does not affect current system functionality.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-yosemite5.dts   | 31 ++++++++++++++++++----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 45b8ac2e8c65a4f672e64571631b7f6944f26213..983aebc394d9159c7e3db2e7c39e963f7b64c855 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -978,7 +978,7 @@ &sgpiom0 {
 	"E1S_0_BD_IOEXP","",
 	"E1S_1_BD_IOEXP","",
 	/*bit88-bit95*/
-	"PADDLE_BD_IOEXP_INT","",
+	"ALERT_IRQ_PMBUS_PWR2_N","",
 	"FM_BOARD_REV_ID0","",
 	"FM_BOARD_REV_ID1","",
 	"FM_BOARD_REV_ID2","",
@@ -991,16 +991,37 @@ &sgpiom0 {
 	"PRSNT_BOOT_N_FF","",
 	"PRSNT_MCIO1A_N_FF","",
 	"NIC_PRSNT_N","",
-	"","",
+	"FM_CPU_BMC_RST_N","",
 	"","",
 	"","",
 	"","",
 	/*bit104-bit111*/
-	"","","","","","","","","","","","","","","","",
+	"MASTER_PWR_EN","",
+	"MASTER_PWR2_EN","",
+	"PRSNT_MCIO0A_E1S0_N","",
+	"","",
+	"PRSNT_MCIO0A_E1S1_N","",
+	"","",
+	"","",
+	"Fault","",
 	/*bit112-bit119*/
-	"","","","","","","","","","","","","","","","",
+	"FM_CPLD_RSVD_MCIO0A_SB1","",
+	"FM_CPLD_RSVD_MCIO0A_SB2","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","",
 	/*bit120-bit127*/
-	"","","","","","","","","","","","","","","","";
+	"","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","",
+	"","";
 	status = "okay";
 };
 

-- 
2.52.0


