Return-Path: <linux-aspeed+bounces-3128-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A89ED6406C
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Dec 2025 02:43:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dWJ5B46KJz2ySB;
	Wed, 17 Dec 2025 13:43:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1765939406;
	cv=none; b=kGZcU9Y6gxhzw2g8Or91VX3Wp4jN1LaN3hG3p2tZ9+0+Y21nEJnxZCP56Rejptse87tSEeN1Xvxul5Ya/H6RcNU/3tqNwnoXKSzakvD8+hhAoc9OFYs96xP1IcXrjaXlnyY2T12GBwWjWjPV+ERsMQPJRdIxld6NO6drqSYvKGB/L7lDdXrNBP9bCsuRcALS5Cwi9AWz7XNntTqstCc8lUH/z2AJFFqLa22OCy1nq9IGT++Dr1XQpGiVb01SEOM3er8ZQ1NjDQ3MMVfArsKPeuUUxBW2/MCRnL4Ck/ZmSQ/q28+RJxvS+ocpcvZMnOH6+TGykpWhG3r5vl6ZnQWitg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1765939406; c=relaxed/relaxed;
	bh=RAvaRpzOSVNKUVUd3z7yZ4rULdWPUD/lWxZmIty2N/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E6I+U3UYPQzwCFfDKbdOCfZ5/d4T54SQ+fgddbkgbtgwU5OXZcOJ7SnyVn/jEVHhABdIFyVM84p84LYFyxT/3G02jzECBA+61x1DPWo2pwfiaTGRLGonZwd0nPhGfp9RGbAVIGhj035o4TtxZWmtYkvD9j4BUNKAYhMoYlwyJSVIZB7iXr1cY9a5dUoN6KCvJ0Fcn4Op/hzN6Xx5vXEV0WrNLa30uTFuQNizDAqrbD30eBV14WH3j52d2vAErVoVJg6aSK5qjd/esxlcYuobEDg1XtjQv/Uu83/8hvdFXWi373PaOr4A6zt5BmjhFvW0Gp/ea+c+ulf5qMA18/nKNQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cI8iUTp9; dkim-atps=neutral; spf=pass (client-ip=209.85.210.170; helo=mail-pf1-f170.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cI8iUTp9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.210.170; helo=mail-pf1-f170.google.com; envelope-from=chou.cosmo@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dWJ596gkXz2yGq
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Dec 2025 13:43:25 +1100 (AEDT)
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo6150223b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 16 Dec 2025 18:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765939344; x=1766544144; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAvaRpzOSVNKUVUd3z7yZ4rULdWPUD/lWxZmIty2N/Y=;
        b=cI8iUTp9ktNydbRQb9HKZed3xvU7+Pchd7bZa8MygT5WdjUfRYLA8UNLm8nJDVX0UD
         En5WvOUCJFR9wwkOhpl0S+W5ivSI9G6hw0sWCQizXF+5Nyavljch8hgaAcM7tiD8Kyqk
         UN8YToRad0S9UL2fkKY6xhA7hGrLAdmqutgg+1g6zc37ajQJDDugkiJNJgOHUrWQkVIR
         3rXjBCo9AWZDchyhVdYpA14e7Km0s8fL9xO57mURWVOQGdESBmFrmZFe5XkJ3nXU1RYm
         mJ/txcg7w+IDMCZkrMj5vfbsnmqGlBfO1BmIUnz11wm7Ui+5djuIvZ/V3wF7lrB0hp56
         UZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765939344; x=1766544144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RAvaRpzOSVNKUVUd3z7yZ4rULdWPUD/lWxZmIty2N/Y=;
        b=iXGQTO4Rx3eW37aOz72VjTTcRRnUFOhFb7uxw498s5oJ0EyMYFRJ3Ez8WL2KzYYeKU
         z87Th7SkdgKalKiWgSTkOijXc6GlbNxmAnQtCJRwFFyUQ/Ey4D87TuulxmvZRRF92oOt
         4guIc9ANnqRccFZ3ExA3kG/pYB2OXnxmY61HJ4Rqq/7rihsoaPm+0jZ9Co6qvYArTgiF
         ZFhMRLuf63u09eeSAjuUE4CpgDLHbrUEC7Y1GNKiqUU8uONT/FPQJjJEAAOV5VWO1Pjl
         Igwi7Gzlz0mr79bbz7f8fLYaj/s42zsxHYR8v6dFk154SkIVLhbMZR4UJ4VNj8uBREVp
         XZJA==
X-Forwarded-Encrypted: i=1; AJvYcCU9bh74AmEJjENC/1RuP3g7aupq8oIxW5oLSwe4bGwPBBOcrlt/2Ew5iMpr6DzeM1Uw5zm8B5m9ScLzj0A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxyrgRgKZ6PAMWvbhLRFZmYW7/LxDfM1fYQsEGql+28++pdYQnM
	nVBKJ8t4jdKUZKWA6jGVMnc2ImLnZ7duUt2f7kiX45Red5zml0cfXPfZ
X-Gm-Gg: AY/fxX7sQHOqs2VHxaai0JOwBSFbtF4Xp4rm4GmEt7fKb5aELkoYBEm7pI6MmUr6ER2
	nACAv8WUhPfhKo8zH9cFmOT93Ck0DcYDXlXm7CJzykbt6tJSXmuaiJwdiTIlkHdjmw/+O71E7pP
	jvyQdpdd74/6Yz9KlYe3MC8dJD3waXPD67gBnl5RNMMwUphwN3syGxBUaTOhXmSBBEJXCUC2CQ7
	HgmvlWelXmcgP8Oxtj9cScrDlTpJF2wc551ib2sZhDQ5DG7Rwk8a7sBbu24YG+OJQ5EBxxNJqGx
	N6MLcvzMWbDKTaoEhTPX0LBoKICPk2tz8X/fd79Kp55Mc0BCBVs58TE/hyrTn9kYSCIM/CX8yQB
	ze4UImX0mQeKGt9YYt2ccsdoEIQX4nCVLA+0XF9M3wh5146/+GDlc+vLI54J95v3kVwvCDKRhYI
	Q0GyfWeeDhMD0Aqnh49fwQw1CuV8s72x8TTlVo2FijK6VKkLHbA0EiFhxnHc8rOTR3oJa2TPWfC
	5CHyIbr2MM/e4w=
X-Google-Smtp-Source: AGHT+IEdo+oIswqNvPYTC0alUaHeiWR1/K/Mfky4uyf2799xeagzkReyHg/WBV9BGT3F3fHpH3VwIQ==
X-Received: by 2002:a05:6a00:a118:b0:7ef:3f4e:9182 with SMTP id d2e1a72fcca58-7f669a8b0c3mr14790222b3a.47.1765939344119;
        Tue, 16 Dec 2025 18:42:24 -0800 (PST)
Received: from cosmo-ubuntu-2404.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7fcb8c29738sm941342b3a.17.2025.12.16.18.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 18:42:23 -0800 (PST)
From: Cosmo Chou <chou.cosmo@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	cosmo.chou@quantatw.com,
	Cosmo Chou <chou.cosmo@gmail.com>
Subject: [PATCH v2 3/5] ARM: dts: aspeed: bletchley: Remove unused pca9539 properties
Date: Wed, 17 Dec 2025 10:39:36 +0800
Message-ID: <20251217023938.445721-4-chou.cosmo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217023938.445721-1-chou.cosmo@gmail.com>
References: <20251217023938.445721-1-chou.cosmo@gmail.com>
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

Remove unused #address-cells and #size-cells properties from
pca9539 nodes to fix dt-schema warnings.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-bletchley.dts     | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
index 5919a5046078..8df145d2bcfd 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
@@ -373,8 +373,6 @@ sled1_ioexp41: pca9536@41 {
 	sled1_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -462,8 +460,6 @@ sled2_ioexp41: pca9536@41 {
 	sled2_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -551,8 +547,6 @@ sled3_ioexp41: pca9536@41 {
 	sled3_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -640,8 +634,6 @@ sled4_ioexp41: pca9536@41 {
 	sled4_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -729,8 +721,6 @@ sled5_ioexp41: pca9536@41 {
 	sled5_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 
@@ -818,8 +808,6 @@ sled6_ioexp41: pca9536@41 {
 	sled6_ioexp: pca9539@76 {
 		compatible = "nxp,pca9539";
 		reg = <0x76>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 		gpio-controller;
 		#gpio-cells = <2>;
 
-- 
2.43.0


