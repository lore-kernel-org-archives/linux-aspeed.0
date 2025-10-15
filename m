Return-Path: <linux-aspeed+bounces-2462-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D51CCD193
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Oct 2025 22:36:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cn5Xt46xyz304H;
	Thu, 16 Oct 2025 09:36:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::630"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760539180;
	cv=none; b=LqkULvYdj5IWp0aR7MR1Bvuxp3u5juw6+H4ID0oD2sTKzfWlamxa3WAtyY2i2dHDDUyqH75tCjwv01L/ksWzCxl2+iuzlp5a1tVy35DmqPhRB9+y68ekOWnITXcttsUWsoQ4r/XXVB2BIHwjoeUNcNpxvI/qEjqLZLCe8V+UOcz8I4EqfU0ttmFyox6ROYnPBSmF7tFGit2nrYqp7rNruCiZ6JHpBNiBcHcIRmwRRH+mQvD2giISKR0Tnj8FnjrbGqkLylvheHrSjyQ/Rz4j8HYOpT4baY2X0DIyCaCvMM9E1l3yzXdT11/aPkBFN/pDTVTydqBuVhaGyyIzEPb9rA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760539180; c=relaxed/relaxed;
	bh=ThMWJU9Zn2zc8Ri8nC2rLeAQ6V0FQ+wbPN7aWmFwPkY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOVlk4+PN4mGr7nskQlr3t6TSIUoGhMmnMKPlzsZqZ9TrflmbA+2HGEV9HpTmmdviv0Vr42AVeEYYYPhHTVd7nvef8AL7hSwQFfAyMbdm2/C+CB99HpkhQH/A289Ib8M0PDilPXDC0Zx7hYQIhqXPW+rrx2ZxUjjHTcPXeNOV3M+w/E6JEEiF04CpW5DuzXCAgEjDl4TrpB0/VQ/S+3jc8htkMbMuN4Nnn9vctzHhLRITgT9C3CykNkwruD2YnS6nV91BRkIDPJ260QfKRbLBBJUvMPlghBYOk4euKU3pWXCRe/Zxd3w4VI6Qn4JJ+P6epq5BXClp5O6qnhygxP8yQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iE96xC+O; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iE96xC+O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmtyg5W7zz3dHf
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 01:39:39 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-27ee41e0798so104481575ad.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 07:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539178; x=1761143978; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThMWJU9Zn2zc8Ri8nC2rLeAQ6V0FQ+wbPN7aWmFwPkY=;
        b=iE96xC+OzwnFe55aB5kZTHqz4bOURS85gymnDPcoLpYNUYXl/n3lkqKRJ3OZ5VaS9W
         7EjUM5mxtdk6SNKWE5JVuyp8QuegcH4yBatD9z5kBzSaK/130O7VmbrtbHTVYx7/JuJz
         6wYwxr5QStQTqCIrB6UKewql//f0H8uz6TAYgart6HqNyasAzS+OTZ3997TmLEnZExIT
         IYUgEUuT6sFsB1WbK7NdXhzNRIplg4hOaM/elCbScuG7+uDnfs+h4+BCWV7EpsdIguez
         Dz1AJMODtc/6DHYJU0bJ+w+RQ2Fjo12b2fAa1vZZ75Z+AchAFuYX9/xcNvqlOZlIKqeM
         Ga0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539178; x=1761143978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThMWJU9Zn2zc8Ri8nC2rLeAQ6V0FQ+wbPN7aWmFwPkY=;
        b=bB/yvbRlvl23DngpbxntFt/uNR1yEl1EwwS9vlZ3ybiXvfUbyd36YX5YgHOX8PrRq1
         ESuE6vQWMw5No9vLNtOgth4I8OBzSQtmllEilHhy2QW2371VXW1/VzYA4SH7gWMA737c
         xX21m3UOLoCqJHOH6VxpWbPLkQ7Cw+e57hvOuvwNhgUKj6DUfp/yDWTCNDVkQal/1Pbd
         RrivG7fnRTdbxBrmxWsptc0EoXLmAjWPaKl7jYhxgirtsHAZtqS4FccMho/fa1wqL8+C
         F0gGxFW8INm8tKPHW5nNVKsQofErwVqAO8MD0Vd/47Gho6ShT6LdpNz3lcNFBeaUmrNa
         yFPA==
X-Forwarded-Encrypted: i=1; AJvYcCW5cmYor1moHRWojPykLanl3U8UQr2YiRxK40MA+pxZig3RcRpZfgpVBWkXQiZgubTFqUVnHCEfRoWQlk8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YysPdICLgG/40yBP1J7cbUihOnFyjCqyHJ0ApyjBXlIP1v+wPr2
	FdMmI7zwDwSiKpLaXxKPIt4ZlNDHQmbmhCdvOW2wKExWKAKL1YoOHh4v
X-Gm-Gg: ASbGncuu5TLv1bo+nWdbKAGwRv5XQyclio5uafWgu3hAyAEfMhVNiX6Xig0J4OVPhDU
	MW+cbzC7yew1dWDGdPm9Ofi3Vhgn9hkVvcCcSIPO3K8LAwkHxOJJaYl1lSW/sPNja5ClSWBE/QT
	G585Af5QXg8V6p4M9v3eDeLMFwe7cAsbEssDAHAwUwSkMKCzKuOhKbhsWFm3NiWMpvl8mfuZP8L
	h/kTtZMsXOEZjsiw9ZKJIGfHwhWaG7ysMDd+clLIjXROzVJNJvT0q5ta6yuo3pKwg/ZkD4BK/Vf
	WDtM39admQojuPPa4BxNGXgmUdvQjzlZbjBxMubKYB7hD8hVAzuL6W6lC/DGFv+KNtDjL7N0RVT
	rE73D8Nhvdp3VZEuAcsI80SBuenopYYlfUqezn2J0tqByxKiGViSJoPEx8q/qORNGtCICWnlF+P
	/TxOTZSIhKR10RjxGzUwTVAUx47Sp8zCW3Ho+7W6BQ
X-Google-Smtp-Source: AGHT+IHXFYBxv1duy+NgjILQXBh6DIAOFdCHnmkFRStqTE9SSRyR15DtFXzEoOln24REjJhH1gcaGg==
X-Received: by 2002:a17:902:ecc9:b0:25b:a5fc:8664 with SMTP id d9443c01a7336-290273fff0dmr361423205ad.51.1760539178118;
        Wed, 15 Oct 2025 07:39:38 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36738sm199853455ad.87.2025.10.15.07.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:39:37 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/7] ARM: dts: aspeed: santabarbara: Add gpio line name
Date: Wed, 15 Oct 2025 22:39:01 +0800
Message-ID: <20251015143916.1850450-6-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
References: <20251015143916.1850450-1-fredchen.openbmc@gmail.com>
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

Add GPIO line name for userspace control or monitoring
- Add leak-related line names to report chassis leak event
- Add debug-card-mux to control debug card access
- Add FM_MAIN_PWREN_RMC_EN_ISO_R to receive RMC power control signal

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../aspeed-bmc-facebook-santabarbara.dts       | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index c0334abf9cda..3f36c8e03f48 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -208,7 +208,7 @@ &gpio0 {
 			"led-postcode-2","led-postcode-3",
 			"led-postcode-4","led-postcode-5",
 			"led-postcode-6","led-postcode-7",
-	/*O0-O7*/	"","","","","","","","",
+	/*O0-O7*/	"","","","","","","","debug-card-mux",
 	/*P0-P7*/	"power-button","","reset-button","",
 			"led-power","","","",
 	/*Q0-Q7*/	"","","","","","","","",
@@ -1744,7 +1744,9 @@ &sgpiom0 {
 	"FM_IOEXP_U541_INT_N","",
 	/*H4-H7 line 120-127*/
 	"FM_IOEXP_PDB2_U1003_INT_N","",
-	"","","","","","",
+	"","",
+	"","",
+	"FM_MAIN_PWREN_RMC_EN_ISO_R","",
 	/*I0-I3 line 128-135*/
 	"","","","",
 	"PDB_IRQ_PMBUS_ALERT_ISO_R_N","",
@@ -1804,11 +1806,17 @@ &sgpiom0 {
 	"PRSNT_LEAK_CABLE_1_R_N","",
 	"PRSNT_LEAK_CABLE_2_R_N","",
 	"PRSNT_HDT_N","",
-	"","",
+	"LEAK_SWB_COLDPLATE","",
 	/*P0-P3 line 240-247*/
-	"","","","","","","","",
+	"LEAK_R3_COLDPLATE","",
+	"LEAK_R2_COLDPLATE","",
+	"LEAK_R1_COLDPLATE","",
+	"LEAK_R0_COLDPLATE","",
 	/*P4-P7 line 248-255*/
-	"","","","","","","","";
+	"LEAK_MB_COLDPLATE","",
+	"LEAK_PDB1_RIGHT_MANIFOLD","",
+	"LEAK_PDB1_LEFT_MANIFOLD","",
+	"LEAK_MB_MANIFOLD","";
 	status = "okay";
 };
 
-- 
2.49.0


