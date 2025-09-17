Return-Path: <linux-aspeed+bounces-2249-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFA4CAC599
	for <linux-aspeed@archiver.kernel.org>; Wed, 17 Sep 2025 10:18:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cRZVY0lz5z3cZ0;
	Wed, 17 Sep 2025 20:18:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758104325;
	cv=none; b=MGXIQNkgBFlZ22yp4i/NU4J3pbD/Xbo2jj8NclAnz3yyuo1y+aGU/qyGfqJfamJamnmh9SP1iW+ZymL/puPbFLBse7IZJrGBw7ZhCILLldxePN1n+T10w9Hh9noECcQ5KeoDlBZddmaL1tu9096I5l7u8hgCLSMHjS5nRhjfB7MyEUdMHWnzat0GUF4Ytq56ZZUVB8rryirjcsWghq1FmxZ/DFGS7ephwD2lXBBKBzi2sPwe7k/dh9EkLUmyQrfy/7VNYKc+NL/bWK0HJlMbu2T9KSx/kKuAhhMqfsv63pnS+fK8C/1C9fgwwvasG90G+Uyl8wvZGmSCdyfUSfnB4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758104325; c=relaxed/relaxed;
	bh=5zZ72N87Qaim5aMPVYiT+iILb4wfsMlQ62gUTdmY8nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TD3Er/lH1NC8W6edB8/OsQGpHNsz5cxJywUvI3UKo/D6u4qw1YcGCy0d6iOa+OCGMDSJmXGN8E7PTqJsruMK/sCk8GNLhn22mPfDJo12xrDzun8DEJSGWvVqunXKwFuA1gmLMNrf2zP31zpLSYPbyo32ZMzajimEZSLLvqKtvEHnQxT+vrdpMizIc4+Yjbbtzz9+N7v00mlNCPDKrPm0eH41mwh73LY2IP/Tf0cfPYA/Z/tzuFYobDEFxa+oBRxakHnZy+cCpQ/vidAjm8eYovCtfDk0axLgBGNLUrg3Qa1lFtl3VaUNmYkFZxUgbWNccQjg79GN/mL5SzZ+5B85Gg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cB0ELPZq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cB0ELPZq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=peteryin.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cRZVX36Vxz3bjb
	for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 20:18:44 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-b54c707374fso2368352a12.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 17 Sep 2025 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758104323; x=1758709123; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zZ72N87Qaim5aMPVYiT+iILb4wfsMlQ62gUTdmY8nk=;
        b=cB0ELPZqP+Ti5Gmo0TMtYTKMiS4/64V6nPlwRPyvlBBnlElH5SyZ55l61rR8FyApqa
         or/NCnJTu1ZI/xB+SsPOCwl93R+HBvft9P8hpvhnywbAdSA4AmrUkm3uM7UnfOCOxJHi
         gQUnhuhoNyFeFdvVFuOwJPu+wAukFeKxCNsgeGtnmgM2edraTlpZ6quPQ4VvMpMv9njB
         f650m4fJcRxWFHPAUfU1UNLu8x9CEEdZFTsupE0s/iJLvmYN1IOM+rrfctoDI/3Ios/l
         q+hn99Mi8LCyZ7kZGKd5aUe8Wt+wtC7/KBdlvmFnc/8A1yBOoY80DDRJsJ5/fjvCd8tl
         mFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758104323; x=1758709123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zZ72N87Qaim5aMPVYiT+iILb4wfsMlQ62gUTdmY8nk=;
        b=dIC3j9O79gpRPyt7WqDk2kxD4PoLVrz8vZzjVbm2nLNVQl4VaObjcDuxXjFL+J5HPV
         Kbm09XZ2Q0kwk5Q+g+3/2T4avUk2qG8OdFR58hQdVYjcK3H6mSt2otjTzsSZyTxEkAte
         bmuK+DNV5o2pdZ/n324NFM/Nde5a+msYrBMeWn1cpt2v7xlbHk/x4MgJJRoZHypVgdqe
         W+g7IHp5E8z23XcKoITtUQ7BnfKb5JWjrJjk0Vfo9BATnCrZKeAWEJ6BnVi25Ng+Cxkg
         GHJCNm7IVdFuEOK4/Wbddcx8KksFdexzDSkPdsAukmLhuoTRk0x7MIGQlJYmarDcaijZ
         0rVA==
X-Forwarded-Encrypted: i=1; AJvYcCWuJOJhdn7LsFCJlZtT8nW/9mD9yttvF99O2QHGt38SF4zkZkiXxGnjKjoXN7KykGMf5EwefXzOYPvtcvo=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw4br9DkyLaRncO5S89LYsft0/ZqkYdECwI+/6wwo9vQx9R0Jsa
	/NiH2yTodfCnU0yfkFnkTZ2bNo1PhCgbcr45E0IiW7JVnaLdfe10jQgr
X-Gm-Gg: ASbGncsT51Ovgt/RL13J2zEcRjWQrCQ8PRUTQoMqk35fkYc9BkOI3pFTCR37S3DhyjY
	9OE72db9GyxS0pyQ76ixMdIjq6LIVFYXEUgDeb83cVxTgW3C3nKGfpL2jBpA0xPlI6Adh1EvwJn
	7A3D7CsM4/+8dZ2SCcNrkWs23cwzoIv2Zw2k0I5NykImyxghX1KnnuvEUz7GYWpfsmk08by7uWo
	xdi3FzpsZYbO3EILMTLPGxzWpMe7Dp1Z3yoXFX4152siKOwUomzUzjtcHtbcFeF0cfETg3VIFSE
	0+fG1a/+lZyKdLWQzoA3aws/fz2X3Rl9XQEcFt+MgVuu/XiMBhv6VZA0BWGiNdz+DcjOAt9LI9T
	WL6di4c8LFa9xA7SuzzbRn593BDBGwBuB8XrjyR2RWKUZ5sG+AoYdrrqH7eqzTVnN2qdtaZgOAa
	52zswhYSTmWirljMjNW6Nq6e+3KA==
X-Google-Smtp-Source: AGHT+IGJbBv49X8Fm3/hWIcTvxvlFS2nF6Nm7mbCdXfD2nMXpiK58GybyZRf/sFMYFcCCU2A4mYHkw==
X-Received: by 2002:a17:903:11cc:b0:262:661d:eb1d with SMTP id d9443c01a7336-268118b9516mr20803485ad.1.1758104322723;
        Wed, 17 Sep 2025 03:18:42 -0700 (PDT)
Received: from eric-eric0420.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267f4d286aesm28588755ad.63.2025.09.17.03.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:18:42 -0700 (PDT)
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
Cc: peteryin.openbmc@gmail.com
Subject: [PATCH v1 4/4] ARM: dts: aspeed: harma: add retimer sgpio
Date: Wed, 17 Sep 2025 18:18:25 +0800
Message-ID: <20250917101828.2589069-5-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
References: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
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

Add irq-retimer0-0v9-alert and irq-retimer1-0v9-alert
for power fail monitor.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index fe72d47a7632..37b5e2614a9a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -828,9 +828,10 @@ &sgpiom0 {
 	"","",
 	"irq-pvddcore0-ocp-alert","",
 	"irq-pvddcore1-ocp-alert","",
-	"","",
+	"irq-retimer0-0v9-alert","",
 	/*O4-O7 line 232-239*/
-	"","","","","","","","",
+	"irq-retimer1-0v9-alert","",
+	"","","","","","",
 	/*P0-P3 line 240-247*/
 	"","","","","","","","",
 	/*P4-P7 line 248-255*/
-- 
2.43.0


