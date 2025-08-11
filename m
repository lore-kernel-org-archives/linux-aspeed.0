Return-Path: <linux-aspeed+bounces-1941-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5550FCA0EC0
	for <linux-aspeed@archiver.kernel.org>; Mon, 11 Aug 2025 07:32:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c0mYc0bpYz2xlQ;
	Mon, 11 Aug 2025 17:32:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754897540;
	cv=none; b=NYFeIrnjJ6xHZQVcug718Enur5Pw3MavQCQdPhSR8qa8p5Lbd0SPK8PDZo7r686jG7qCHw/P5WAab/rj9A5t2qhY8z9wx2yt4XaOard7Z3bZMm8EW8SutFwNizpFvGrvwlR4mtw0LhV+xodTOBrCbMzdcXzD/O6+OdnSyL/nx3SYu6ilasvhc7Zm0g/Sz1ZVhn6GR4UCvDU6ruRdLZpMpIb8M+TGhVdeMe5QbknMM0gS0M1LISfaC/7ZanXQUccGdRx8msJmwu4uT3BfGw2AIppNUnsMpuyLYVDAl4Ht+QcDv3IA9YIJkSb81fpGWT7Lk3Cw+0gmKRsi4zap7S9n4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754897540; c=relaxed/relaxed;
	bh=Bx0HUPagVnZ+U8BFdJ9INMhdQD62bMvRUffwK7m8W24=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gn7zRY/cUbmEunsCtXmrwMKbe2snwKfVmp+UQ1ZTdIzgc1+svOG+50qTGHlFucw49IcsbXBO/oSqBmobgLdKkLwC0CQe+fKRPILvegm3srOGNFw2uxHvATdfqoUid7BA6NkpLrJuLQ/s9vFeeLEWplZllTLEQvuZspn04yow/qcZ0BX/AsVW8dflWl3S4o5Zz6mQ4lp6LzYULyzER28za/5RMZNVEHvOSdWAG+7bDlMi1C+aaMNU9vw76XQ1wmkJR7PdbPqAuy1AgnsJi9Es6uchB4CIB6V+jFpnzXItJZaaDTM4WfjXowQNrxAxIwgBpjBpelMtVJ3TnK63x5uFiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TmA+WfXM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=TmA+WfXM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c0mYb46HPz2xPv
	for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Aug 2025 17:32:19 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-24049d16515so32866655ad.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 11 Aug 2025 00:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754897538; x=1755502338; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bx0HUPagVnZ+U8BFdJ9INMhdQD62bMvRUffwK7m8W24=;
        b=TmA+WfXMqI7hi/u1uWEQqNyH6vc78tkV0bC6ciuU9l924Q1w1BOaTC3crIwsR+cAwv
         q+az2i7YiP3tSYSLe1oECbg11lk9CR3xPnBJuFvIjR1WYPDqVDCD+tRPxg0v+MTIq7/q
         y1RcBmkKtobiTMyhiqCp8ESSFreVf5JC8G7MNdJENNwvgi+/yENwI7abrLY+zyWg6FhL
         IrLRBQ1NoE5Alscgqnr2e0HamZd267CkvtjCbi8Bw7jCPHw1XyOe6VNwYpoTIjkSZKKc
         gpH2v9QPlv6+voJ7P/qnwKkQtkkoVMztigr8yo9mm4nCRUwe/kq9kgjp7jU30G+q6sET
         CDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754897538; x=1755502338;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bx0HUPagVnZ+U8BFdJ9INMhdQD62bMvRUffwK7m8W24=;
        b=d1UcrzmiS9b4TM+XhERt1225R0ccT27sn6X51FwbcmuZBx8Qq2Afy77VIorzAEvBMV
         bsX/2qMk/BZvPBTbGuw/zFv0X8y/nzVo5r8M0ihWAFSCvDdIIpNSjdBi+1gbx3NQC075
         azesQEi80SJ4XkD1WXFSbiBOsqwvWv9ExpZPxH8dnjwVVsqm7lsGSuJOSqKDLGVAvnRz
         ZtAFCmNULKqXEFvbDGnZGpv4uO4TQpfTEl9OeBZr0l847jszTjaml7BrUIvYM43CEpQZ
         lDsp7dR43Zny2MQwhjurwR7HzfqfcKeznbu1brXRA1nq8Hz1HNEefO+rfruAnmzYtJ6y
         RyeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHIgNgn2kzp8p8fu8pjQnj9EIiYDFGlYQAXxCqL3GuPr6oF9oxhdoHnBAxDGw2u94REB6vqtqJOjZTDq8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxSSzgpjkItfiSMGGl39q12/2asCFU1IOrBs3dTaNW0u28Zn9w5
	w7l5UFbY4judv9TAWCVE96V4gJ33rkxdCCSxPMaMEci9ruLwX2dYqYwh
X-Gm-Gg: ASbGncvkBTRfEgMtKW6u/qEfAw2eqaDBhF77TXXKTFqtBvosJSkolUUwEckJtBLGrzx
	3VOVqFBSuPz0td9wDi1LQPXDK3Km4Y86sX173FFbPt+g0jwvC6sixEnkDVfTefHjseIkw80edLC
	OZEZh9Y+KBXnOUraL67k+ViU+aGumP6Qg4npVSuqAUPaP/5a00nMlmORrLj7JBzwAvX/lfjK6tu
	OYq2tzJDMDGkiymose/JaLIFYxnB3XezpxHdxC2UspqepVta2hrTc87b5Fojxt8rueQZVfay6ft
	eLswqFGiID8UXbs6NooBEYVT40wow6gsfC9cRjZpIhQ9LSi6xJ/XC4k11An71tqHP2cW2trpEGR
	SboT2/ZxBXrXEDxqicu7o2PsBfDffWgxrR+3sTdTbA07/v31jaeEnK2GalZg3LgxmD5VUOOOwtV
	lq+/BBk0chUtMTGVtvWZjl3PFiGpea
X-Google-Smtp-Source: AGHT+IHw5o+Jkau6vl+zzP8wniWy1wnCha+yKhslleKKvxim75ReWEWO0PXV/5b8z7D2bbPKCN7MKw==
X-Received: by 2002:a17:902:ebc6:b0:242:9bbc:3644 with SMTP id d9443c01a7336-242c225a177mr160057395ad.54.1754897537580;
        Mon, 11 Aug 2025 00:32:17 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e388-d3b1-e90a-ba63-d547-4584.emome-ip6.hinet.net. [2001:b400:e388:d3b1:e90a:ba63:d547:4584])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef59b2sm267624575ad.7.2025.08.11.00.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 00:32:17 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ARM: dts: aspeed: harma: revise gpio name
Date: Mon, 11 Aug 2025 15:32:07 +0800
Message-ID: <20250811073208.787063-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811073208.787063-1-peteryin.openbmc@gmail.com>
References: <20250811073208.787063-1-peteryin.openbmc@gmail.com>
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

Update GPIO label definitions in the device tree to reflect the correct
power and control signal names. This includes:

- Rename "fcb0-activate" to "fcb1-activate" and "fcb2-activate"
- Add labels for:
  - power-p3v3-standby
  - power-p1v8-good
  - power-pvdd33-s5
  - power-pvdd18-s5
  - power-asic-good
- Replace unnamed GPIOs with appropriate labels such as:
  - irq-pvddcore0-ocp-alert
  - irq-pvddcore1-ocp-alert
  - smi-control-n, nmi-control-n, etc.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 741d2d9b6d03..2622954d0ce3 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -234,7 +234,7 @@ gpio@12 {
 		"","",
 		"","",
 		"","",
-		"","fcb1-activate",
+		"","fcb2-activate",
 		"","";
 	};
 };
@@ -308,7 +308,7 @@ gpio@12 {
 		"","",
 		"","",
 		"","",
-		"","fcb0-activate",
+		"","fcb1-activate",
 		"","";
 	};
 };
@@ -698,14 +698,14 @@ &sgpiom0 {
 	"","",
 	/*A4-A7 line 8-15*/
 	"","power-config-asic-module-enable",
-	"","power-config-asic-power-good",
-	"","power-config-pdb-power-good",
+	"power-p3v3-standby","power-config-asic-power-good",
+	"power-p1v8-good","power-config-pdb-power-good",
 	"presence-cpu","smi-control-n",
 	/*B0-B3 line 16-23*/
 	"","nmi-control-n",
-	"","nmi-control-sync-flood-n",
-	"","",
+	"power-pvdd33-s5","nmi-control-sync-flood-n",
 	"","",
+	"power-pvdd18-s5","",
 	/*B4-B7 line 24-31*/
 	"","FM_CPU_SP5R1",
 	"reset-cause-rsmrst","FM_CPU_SP5R2",
@@ -749,7 +749,7 @@ &sgpiom0 {
 	/*F4-F7 line 88-95*/
 	"presence-asic-modules-0","rt-cpu0-p1-force-enable",
 	"presence-asic-modules-1","bios-debug-msg-disable",
-	"","uart-control-buffer-select",
+	"power-asic-good","uart-control-buffer-select",
 	"presence-cmm","ac-control-n",
 	/*G0-G3 line 96-103*/
 	"FM_CPU_CORETYPE2","",
@@ -809,7 +809,10 @@ &sgpiom0 {
 	/*N4-N7 line 216-223*/
 	"","","","","","","","",
 	/*O0-O3 line 224-231*/
-	"","","","","","","","",
+	"","",
+	"irq-pvddcore0-ocp-alert","",
+	"irq-pvddcore1-ocp-alert","",
+	"","",
 	/*O4-O7 line 232-239*/
 	"","","","","","","","",
 	/*P0-P3 line 240-247*/
-- 
2.25.1


