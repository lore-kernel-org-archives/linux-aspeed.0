Return-Path: <linux-aspeed+bounces-2968-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78C2CFA44F
	for <linux-aspeed@archiver.kernel.org>; Thu, 20 Nov 2025 22:55:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dCDGC6fskz2yx8;
	Fri, 21 Nov 2025 09:55:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1763616375;
	cv=none; b=o3i1WfZ2TnIqaTTCBLltGmEEsH2ZKINngg0OTp8BksrbS+zOUUzaRaqu0el8wBPXoOjZlp5ODJ7FWWnAyl4LejJhdXNvVWx+GwR6lmxV12qN3G6ADo2E60ymzId1WeAVpvo87E7v/UFLY+QSPNEc/fYhSv/u9tjRM8S4n0Wir/n+uHC0J9yFd4r2uhYF+1kVzyKLzAawpi3A0hwlKr1S5snAViweK9JnYgb8N3+pzTrXjFeHI41/OLIlI2/kIS/wls1C41DwHVFaJhSTRB22ZlJz64CNOJEE8g0/9AyrXmDQkxNsF/mU1dfkwNQCeLdwGZ/vXXeXARDf9FWsIpa2rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1763616375; c=relaxed/relaxed;
	bh=CHVbT19SoV5m4YcosKHhTcv+qnuVQe5xO2ZctZWhciE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=clhm2huD8OedcznW8hOZgVcj+v0Bw5uhWH0zbwxVouRKnkmho6V6R1PpzmVDzpgRw9JjouiNjrxQq77Xb2RJcFdgphZ7VlOKvEpJp0cso1x1twgzUzUYpL8Q5lgJRMaxv218lcnHdvU0xR5aE0DRIohcEAund0MAyUldoBs72An6vpSrux2x5mWUD5O6G9E4OrOuG/kA9PI+CZivNDWAXNy24vMxHBatNQy0MJQnCIoNjqKbnj4Bde5LqRcku40FjdESTkiBzumEnEHoMJ/rmzM9dSgSLtKblqwJJ5urAr+H3JTSLBSj1J2Mmd9C70WpbOiiX362yz/IuTpwWoY11g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RdzoD45c; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RdzoD45c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dBmzV6l2Nz2yG1
	for <linux-aspeed@lists.ozlabs.org>; Thu, 20 Nov 2025 16:26:14 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-343dd5aa6e7so478426a91.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 19 Nov 2025 21:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763616373; x=1764221173; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHVbT19SoV5m4YcosKHhTcv+qnuVQe5xO2ZctZWhciE=;
        b=RdzoD45cbDayB9WLmnxZaSY1sJwQk0jD+WF33gkLQngke3o3yp7NaUPubdc5+NFJbu
         fVgVFoP6V3+YOqfT3Y2VYq1AvcRuFCyUC0qQDTL/DRgOMdUx2shHomypCu+HXgVV0qND
         dSJ173TwOGZKdd+/nq9jM4tTt//gGERjbYlR0o9PBU2a0Bm+s73J2LIrmhjEhd4olYR+
         gzy2m7aB23Y9bkwaWE1wkzuG1OVfqMG7dhBYzPl+6xbEbDr5z66r/SKkKZIPhZDl1/j+
         sZaaCLvcnEjFRIXjfrW2GvhcatekNsehuQE8Jp0NOeLWAyP4eFuhM646Hh5528CHtGev
         yb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763616373; x=1764221173;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CHVbT19SoV5m4YcosKHhTcv+qnuVQe5xO2ZctZWhciE=;
        b=Mg3IBtxgbF9IruCLMAtpRpTbLP5JjKRYj5dMHeZwstWeFp7YIMHP7T9+09ZPDjg3yh
         +jFgr91fQKY5UA6ejOIoXsHwEjEyCmVEMMAgzFHTMxJwZFTdfx9owPNrdn45DoRYR4Ai
         Or/4YVpA1R760RMw+OcOfwQyFNNT8Tibjq1a0CEkm2gp6AatRRr3y7wVq9CLT4vqCPik
         eCh0I7EepB+Y8wS4hXHBWx3FRQOmFzZ72hc1S6JTwB5zrgibjAKe2KrMxFP4wbFp4uom
         GYUiBNuf9ymFAJ08RjZhFodmu+iS1oU143p3iysvH/ifZBSZg0owmmsl+BM3Kgdrp91Z
         Egtw==
X-Forwarded-Encrypted: i=1; AJvYcCVdyYU19uFd0AtIUeLQLsMfM5ZFcuugBzX96Yglwy+DAGMfaUpWdNJS8eylO822vDnrzoXILZFieqSs/ow=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwrowBkF9mfoeMzEBtI5NXc684tiiG25ru6XZhpUScKmg5kByvv
	rgZV7TXK5mitAtsE2G6Yo/B4SBgkrcLsUsnfmc8+ZQNMGtvoqO4liNLh
X-Gm-Gg: ASbGnctUKX+DJvnSjlmGTWS1pYH4yoqF5yXypFBEX0mUHZjxaReTZCPpuZTW5qou6Y4
	AWBehlrWDQKw4270BVXFxKQxzS3RhzliLt2crntTwVjA5ltCIf3TKnzwxuTgtClBjdwaqPxyLE/
	Yf7AsSo3b8fK6IFCVWV9949RHoSwD2AU1lQJIpX8MJoldbec8L5jd2aq4/L8BsU96szEDpiscTk
	ibzbYupYetN0rxq8BEC8kYXRrej53Sfw19piYkV7PlWtQpAAhzvvJsJ6cteDAcWA7EFpBA7QgKF
	VAgOxA4pUpzpsx0PAiSMmNkXuwg4qUdk1jkqquDReQKPZobHmu3CH156qQ8gJRs3eUZl2vCrNX2
	ZeflNOvU/Pkvtsh3484aRvVEbGf4NZ40mVpCRt+bSE/RnFdJGL8dhSWbmIKoedm/mZahyPLEsxd
	ESvln+pH52IB9uwAJGrAmU/Nlof7jlAi2KBOZo1il0xXhBM0K3oc4fBi/q1s82VJ9aphhu+2FFR
	PMheF1KyErZvp4xtSAy2tbHt2Svviq1Y6BDimugf2Jb9v7vT5lfM6x85yFlrfoo5kfYpIsySZD3
	4Sh+lq2KSsU=
X-Google-Smtp-Source: AGHT+IFTkKnaXX3mEE8uWZI9hhFIJprQn8F9I4uiRfBPyyrkdGyhKEiuIVDjxchbmW3f3duBD7XsUQ==
X-Received: by 2002:a17:90b:4f8a:b0:340:a1a8:eb87 with SMTP id 98e67ed59e1d1-3472854a5acmr2109339a91.35.1763616372885;
        Wed, 19 Nov 2025 21:26:12 -0800 (PST)
Received: from 2001-b400-e301-38bf-be0d-b72c-6bec-2812.emome-ip6.hinet.net (2001-b400-e301-38bf-be0d-b72c-6bec-2812.emome-ip6.hinet.net. [2001:b400:e301:38bf:be0d:b72c:6bec:2812])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3472692e5d3sm1221342a91.9.2025.11.19.21.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 21:26:12 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Date: Thu, 20 Nov 2025 13:26:00 +0800
Subject: [PATCH v2 3/4] ARM: dts: aspeed: yosemite5: Rename sgpio
 P0_I3C_APML_ALERT_L
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
Message-Id: <20251120-yv5_revise_dts-v2-3-4d7de701c5be@gmail.com>
References: <20251120-yv5_revise_dts-v2-0-4d7de701c5be@gmail.com>
In-Reply-To: <20251120-yv5_revise_dts-v2-0-4d7de701c5be@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763616361; l=877;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=OEoDPVAl+S0COKkIlbVNnqQ2XcG7pPYJZgZLJdWqaeM=;
 b=56mR5NirN88VhKgfYg3lzZkIzSyH9L9LfFR/zNUitmcf5rWmUKJgB1m3nxBAw5A7o2smU0F9m
 hrteVwE3trXDBrWcdgKSskOrCSevxTUYmFLubHkec6KGguhR9tf1gAj
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Rename P0_I3C_APML_ALERT_L to FM_APML_CPU_ALERT_N for clarity.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
index 45b8ac2e8c65a4f672e64571631b7f6944f26213..060757b7211a6da777c51d9f0c886796cf2450a4 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite5.dts
@@ -964,7 +964,7 @@ &sgpiom0 {
 	"FAULT_P3V3_NIC_N","",
 	"FAULT_P12V_NIC_N","",
 	"FAULT_P12V_SCM_N","",
-	"P0_I3C_APML_ALERT_L","",
+	"FM_APML_CPU_ALERT_N","",
 	"ALERT_INLET_TEMP_N","",
 	"FM_CPU_PROCHOT_R_N","",
 	"FM_CPU_THERMTRIP_N","",

-- 
2.51.2


