Return-Path: <linux-aspeed+bounces-2058-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4A2CA0FF9
	for <linux-aspeed@archiver.kernel.org>; Thu, 28 Aug 2025 07:50:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cCD8K5dfNz3brR;
	Thu, 28 Aug 2025 17:50:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756367409;
	cv=none; b=NXes1wxojfHNpsAYwIC05blDWhZscLFPEuQRZ+0LB0jlpCG6AIdxrpJXgaGbRelQ1+gU6YSGICJn7Z1tEGGndKXs7wWgAlqMDGjNtoRJk3zum6+18sG3I7ob6y0ApFo0g1wISW/P5q4r3sB0+5Gq//zAWT8/1zVxUteOPPpCSz1qBnw7ikwRG0/rTUqAedi86V9LtjguloBOBO2ZmfYeGLM8P3bt7HumDajPg8RQFDd61NWDIM1rwSgJOvh3d+2wN84Akp63l/PSJ7R/ShlDw5l3SGNCF6BFF/mleYVrHaUSkNVfw+AkG0RGm6udAVcZBx4AXEQXmhLrtqHKqt+ZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756367409; c=relaxed/relaxed;
	bh=OY4GJHvVYK+N5LUJGUaOnp3q0oNX2or2mbmIQLdKleU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEGnXFWAcIMvt1+GAp0lW1vYuyfxGo+MPSjnHbEV4kOO+IRN6lHYWJKy+rRi8X7MvwyIQE5/W7UUOcaz0RydkKv2WAvai62csFfHahbP0zuyqaWnCfKdSI1jeB3JEQ1sfy+CVTe77XJ+SjhIl5rdLI6A7LEmbMhYJ58y0j+N2H8I1FArwlXKF8X7NhSaf4m+mlvywfNucPpOb9pduHJ0aqzmwz7Qk9Iyl2WmD/vSxrdl0KXtc7ovuZGglSx2PelJWg3Xa3tJYxGnYcw5z8Ex9FOroYYh7DPZ9X7ey/F1B1eT+oYv9+f0Al1cLwmUxgD2YsABPjQBH3P1UNV0ZEOwGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lV260oH0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lV260oH0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cCD8K1P2gz3bpS
	for <linux-aspeed@lists.ozlabs.org>; Thu, 28 Aug 2025 17:50:09 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-324fb2bb058so627600a91.3
        for <linux-aspeed@lists.ozlabs.org>; Thu, 28 Aug 2025 00:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756367407; x=1756972207; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OY4GJHvVYK+N5LUJGUaOnp3q0oNX2or2mbmIQLdKleU=;
        b=lV260oH0fce39FB+w0/tOppuFZSupkTY+wVF8tkLcP5jiDt9KEORaXhGT9fqmHX8yT
         gkMWV6k8w1oMqvMCYFbRGJjsjKEItm213THk9bMyqp1eL4PyWrI9aQbbsSwz7PvNJ+Yk
         tAxtGLwsC2AqU4kzm09SO+X0zhkQ0LKMX7pxlx23rP6K1DapXLnAygnG1GioU6R5tL1g
         Oio8/16+1ZKAJLMFuRWVCb4xKNQmkJq+2cyS+21hJwtj0WvvyUIrU7fbSZoe+3KSD/RD
         pTnawFQ9n3fcg01Dyh04I6ZfUWrXyfE1IAkoooAPFW+VezqWAD+BiV0cg9PvsDkwTZmf
         zKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756367407; x=1756972207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OY4GJHvVYK+N5LUJGUaOnp3q0oNX2or2mbmIQLdKleU=;
        b=KmGP+LJgg9ruMGEM3lwcng9owbYg77OnX+L/HqN0qGa0Ok29zOjrTbu7jFH1OLd6B+
         RMoURpE44z5zxlnwdY5mGzYjZXUuzGWBhPE+YvNrvEzM0PXI8SvePtNnJownRISXFljV
         +7PFsoj2/I8OV1Qkrf9lezB5RPk73UWzsgStRc6nwsrffWACtgMcHmbgyv5PIFT8hBNG
         Zk4BoyinrbrRbPbLEFbtKOk25eC7rgacsSCRd4H+B5YP9mUE/47pVEQNYwtHo9KXU5tq
         sBj8eE+Q7NJC9p4lfEba69CvG1zuPo+zXqr8ifihJrG6mECEUz1ksGD51EaQMTQIoXo0
         /1yw==
X-Forwarded-Encrypted: i=1; AJvYcCV5eFrniybe2grSGJER/FqvGCdhfQkgDCj20m3ZiMlMFWtOR89CPC09w2thflihY6ON8xZe7w9U43cJ5wE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzOQbX7PZtBuDGf+oifufkigIHFB7WfaJ4JHb46krMIQU7+2fAi
	H5UtR+PdO9FXXK7LI0OqlYrVkiMs+SxQswrVdSuBquTNS05GZeJl3hhx
X-Gm-Gg: ASbGncsIyOesbN3COQo2JQuWqlSMwWEKfbqQkx1X67ywwpxshSaHRQTsFO+L46RwJTG
	82WXlQBrzqeQXq7ddM0VNFe0uA0J9B4cP9gBOEv0jQBnhwZqnO5J+786JKE8rMlcUL1s16+CcLX
	xHLGylckc1c8qmcrh2AQ04VcB7PEAQmQmYYl3VtWogfzmGCxDMYWuTvQuM2hWBtMaAZy8bSW+rS
	ZglMhkGKUs88dI5fcBWc9RjxWdRPczfpxa7kYoLntUIxYqOYNFQgVDiGS8uaX2zYu5to5cjDgL2
	bmqAg5lV3oB5j/QJWPQvLxnhiRZ6zdyszO+kVmGiN0xa5Zo12XIX5orbZX27fW4ep27ja6Umg/M
	4YHk8CiLqLf73tSYKyMHyRyQ4cv+kIELGVnxvpVkgyK/4g31Lcai4Ihy/JuST2W1UBhc3eGeBpu
	Hn6Kv/E0omgNzAZ/kp2QcPjpTyUe5oovSwdue8Lsg=
X-Google-Smtp-Source: AGHT+IFoFeIhs1JjbGLogAOPAL7+VePjRCrOyPg7wVzL3i/MGX6/KrwNh57ZD1SdoMCZnSYAqEG18w==
X-Received: by 2002:a17:90b:1d92:b0:31f:a4:8bfe with SMTP id 98e67ed59e1d1-32515e2b3d9mr28696892a91.7.1756367406727;
        Thu, 28 Aug 2025 00:50:06 -0700 (PDT)
Received: from peter-bmc.. (2001-b400-e35e-4238-7ad6-5c9d-99c8-92d0.emome-ip6.hinet.net. [2001:b400:e35e:4238:7ad6:5c9d:99c8:92d0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb9d226sm13272038a12.41.2025.08.28.00.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:50:06 -0700 (PDT)
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
Subject: [PATCH v3 2/3] ARM: dts: aspeed: harma: revise gpio name
Date: Thu, 28 Aug 2025 15:49:52 +0800
Message-ID: <20250828074955.542711-3-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828074955.542711-1-peteryin.openbmc@gmail.com>
References: <20250828074955.542711-1-peteryin.openbmc@gmail.com>
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
  - power-12v-memory-good

- Replace unnamed GPIOs with appropriate labels such as:
  - irq-pvddcore0-ocp-alert
  - irq-pvddcore1-ocp-alert

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 741d2d9b6d03..81278a7702de 100644
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
@@ -801,7 +801,7 @@ &sgpiom0 {
 	"asic0-card-type-detection2-n","",
 	"uart-switch-lsb","",
 	"uart-switch-msb","",
-	"","",
+	"power-12v-memory-good","",
 	/*M4-M7 line 200-207*/
 	"","","","","","","","",
 	/*N0-N3 line 208-215*/
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
2.43.0


