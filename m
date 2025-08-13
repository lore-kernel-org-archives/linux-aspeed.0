Return-Path: <linux-aspeed+bounces-1952-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9E4C87FCF
	for <linux-aspeed@archiver.kernel.org>; Wed, 13 Aug 2025 23:53:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c2QBL3W4Jz3cPG;
	Thu, 14 Aug 2025 09:51:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755079481;
	cv=none; b=iDiJC9S0G7Ix5+cjzBBBLBAXSZrwbb59m2FDtO5YavHZKUFEHOduE2LCVdDzZ2FWSoWOliHM7ah8K06V3LR/Ak7zNQvRAjBpAy0Q0G3FjlCWD3fMGOwB28Lyyn1t3aRVZlQp905xvPQ91WsEW/BU8NWNI0+8p6yYsVgI3SRFy9L4V2x5Uste/EKlqWpy7HrFyXcQkypxmgSZpvmgmF1Z3xwEwTVf4+v/Pk1GTXNSJpyoXmAxEc/LOW8T1EiPiZhvLeZdla1oY4UXLyVJu4zZP578lxEpv4W7J6NxVHkbl4EAm/JWeyx9dMTs4ndgx/hcphRFYYItstR09KnE9ofBtw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755079481; c=relaxed/relaxed;
	bh=QrW+x1kwa+TliZEBde/ju7PT5X6BHW9feGK4JCdzymE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JXJAxaiaVyN7FfF9EvAYbrWhc2lDV3VmLv98X6W5RuzkPzC7lUn4x5+FZ4vxoT+IQzZQAnO8cuMYppO78MK1StcPa2nN7wO6C/qggjMvGOqyHdp79sHXcv1xZWCKIe57VH3zatZWb9CSwZACcLWCNsSP/rCZYcEmdw7FYzaa2ZjSOKHnPhgWfTt9tRzcAkBxh18bbh76M3jz1058Ew1oNZueny+Lf9qlDTr98DHPoU+RGtYvsW/42vF9PR3h27xcoZjKMtbUWUlfB8led/TeSh00TlsnXXCK76Nmn0ezDDb73k4A14kOj5FwGeYwik71gqoxlBEliywiwG8uxy76KQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AVMiMzPw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=AVMiMzPw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c23rS4WMqz30T8
	for <linux-aspeed@lists.ozlabs.org>; Wed, 13 Aug 2025 20:04:40 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2400f746440so52533805ad.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 13 Aug 2025 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755079478; x=1755684278; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrW+x1kwa+TliZEBde/ju7PT5X6BHW9feGK4JCdzymE=;
        b=AVMiMzPwg6M8wfEh5lNwKN+G27Uf9WDCj9j+Weib/W3eLxLx1yyA2IpHdRhgWh538K
         Kl/SpJSYVDw6/4B0Mbtd5yn+zTHAXYTzBovtTA5AeO24BqPZTI+IBdWBDH+akgKeNXuq
         8x3JD5k0X/eoYREdH8jf9MEj1STzWzxAyVzc6GcKZDf99QacVmKCDL9RDwuRbeB+sNLf
         RvJi7b+I/EQX5sudFZCl5XNc2FAkVp9IwDTzvKgvSgbkx632Z1EK4QanF6DYWgcUmFye
         mwwNnv1T2fTJu9kbpXjmTZhA3S8xAgc+zhZ2eo94R6lQFtF2pYOKYJdMdeKHYiLlqONy
         0kvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755079478; x=1755684278;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QrW+x1kwa+TliZEBde/ju7PT5X6BHW9feGK4JCdzymE=;
        b=ZHO7pSS2i6U74G8+9q+EUFROPBfXFq+BX+xwrxch7keQjIyFZiVFnb0BVK7iewWi0M
         J6yR3ABqVDZv0lqVLBXRH4f2dehNKEPfxuA/R9EdSIWrbaM9eXAp0RrBJ8YBCpHs9BbH
         +Qnq8Bk53g8V94WF39zrGi4Rep8tsmQeX9CdyApMyrD2YLuNrHsAhalrSOA0yv4PrgBd
         YT0ZGmqu5cnILKnjH1zQaY0TMvL82xZze9I72PhSBbfz1f+xrmtHinDgjqisiWqtOOPl
         XtN0Y11d5yWu9aB4WzxPEqwE/PSwvmA+KqGvczlgJBtRXStnMB4ZuWJeUwslCJK2sHvQ
         HOvw==
X-Forwarded-Encrypted: i=1; AJvYcCUczhgl3E2RfnEyCBI9IG//IYcEFYoYzImRQBeCjnIG53Hi5rAn7eNpziumurjv9j465/DCBKqCDi5Wkd8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwRYYm6a3iNTBQ4x2+PVXiSx2ewTWE0qd0EQtkEOLN0i/llAGxj
	7KVqj5zqMrjsyNtFIgfxmcYPHDAnn2+HV1jDs+u+iC1FgxRGt1o6ZAiN
X-Gm-Gg: ASbGncuSUrhMBBQM8+XWmcmBc1BrzZrSO0ToNCl0qZhv3TKnLIPPCuM2TH3g47fneFu
	lJxuIvHOB9RNTcd+IiBfPV7U2m/JoKI/pQCa9a+gBFjG+u5OCB+xh1QYIfo/dZedeig5AidLGMR
	Z3YVrobKjcVGzysNBznYJzVTA5sVWO76U6zDyVeOjC420Y5g4DBZumaNt5jDOdeb1HHFhvoRrMt
	0D1KpdwEZwUZiTQFkT0Y+6UApw5yM/VPhlC8FXR/9lVIRm6cNKYY9atMItp9umQ/PrGCN6/oIg1
	A+Qs1zR378fH7S4YXMDpyMq2Svjg1Ril0VWJk8sPWVS48bQYSLglLqNUjCcsAUDqJHPF63PSrck
	QVQ0dScTiyfwEmg4tzQqkaYRMkLokY7p4hKrfcWS7HyiwJX+WVh4gvOFstR8UyIJP8yM=
X-Google-Smtp-Source: AGHT+IGelUIMCLH/6tAhQk/cnhctQEprBN0ypo3UWDci9hqE88+bnh6T+CG+4JKD4zlV0xkaaGYPMg==
X-Received: by 2002:a17:903:11c6:b0:240:48f4:40d5 with SMTP id d9443c01a7336-2430d1f5b1dmr36623355ad.39.1755079478041;
        Wed, 13 Aug 2025 03:04:38 -0700 (PDT)
Received: from [172.17.0.3] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aabdedsm321545335ad.167.2025.08.13.03.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 03:04:37 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Date: Wed, 13 Aug 2025 18:04:14 +0800
Subject: [PATCH v11 2/3] ARM: dts: aspeed: clemente: add NCSI3 and NCSI4
 pinctrl nodes
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
Message-Id: <20250813-add-support-for-meta-clemente-bmc-v11-2-8970d41f88b0@fii-foxconn.com>
References: <20250813-add-support-for-meta-clemente-bmc-v11-0-8970d41f88b0@fii-foxconn.com>
In-Reply-To: <20250813-add-support-for-meta-clemente-bmc-v11-0-8970d41f88b0@fii-foxconn.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 leo.jt.wang@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 bruce.jy.hung@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755079466; l=992;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=0XkYbizVBKY9WI9Q/nF7gZY7Z8IkaJEB3NQ1RTG/C8M=;
 b=8NFtXkhvEhwb3LTNeWPtrGrZ06tX2HEIza1oBDSY7eNjoQ2OsAiRGn59mEA1hRRXYdfeWDWQA
 ZbyFDG6X6W5B39BS9ytnr++zFZ1s+ftnxvGHxAqw2LcuGQB7yM2bFgn
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

From: Leo Wang <leo.jt.wang@gmail.com>

Add pinctrl nodes for NCSI3 and NCSI4 to the AST2600 pinctrl
description, enabling support for RMII3 and RMII4 interfaces.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
index 289668f051eb4271ac48ae3ce9b82587911548ee..e87c4b58994add33938792f732420ade7ea5c23f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi
@@ -412,6 +412,16 @@ pinctrl_mdio4_default: mdio4_default {
 		groups = "MDIO4";
 	};
 
+	pinctrl_ncsi3_default: ncsi3_default {
+		function = "RMII3";
+		groups = "NCSI3";
+	};
+
+	pinctrl_ncsi4_default: ncsi4_default {
+		function = "RMII4";
+		groups = "NCSI4";
+	};
+
 	pinctrl_ncts1_default: ncts1_default {
 		function = "NCTS1";
 		groups = "NCTS1";

-- 
2.43.0


