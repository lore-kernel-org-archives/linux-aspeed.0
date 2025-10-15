Return-Path: <linux-aspeed+bounces-2460-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B73CCD185
	for <linux-aspeed@archiver.kernel.org>; Wed, 15 Oct 2025 22:36:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cn5Xg2gmgz305M;
	Thu, 16 Oct 2025 09:36:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760539183;
	cv=none; b=h5TPv3xG3+s7ZSPZHVLN0S3kF0KYZApOz1oR4ea/RkqUzD3NNRywWJYkIqxBEc9g7KioQvosVGoFmGn79gzdjRuM/Y0tCD53m1AlKvltjOXyIak96PTQvqhNLuSYKX5dP0VdUxw6olpe42RhOzXREDohOyRm9o8mVwpd7QQEDeR2oNPJWkiqP5Ne007tPZTnzIOL+8EDwm7nGXMxnQGzovcHf3YP8kSqNiMf+6WiJ1E9z4+RjbxerolMxOdgGQWaTzBzX63JMNRr+JQPOe5d7OPekS6E9qeohBESFSf3in8c9YNvOn+oSbAeNRaOTZNNVJ7/iOSCvAwLyXYKN43d/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760539183; c=relaxed/relaxed;
	bh=Kzk/r6qDbrjCsGLz+9BLRYG0Pw9EztKEkl/jY+qfPQI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2d/lfHUELFCzdhtTAPk1cvpIDVTcxqxG/f13Om3bLuOd91LBfAMRrUjczabPKet5I3utHOH3L9npUSeiPllUCVesC5unK0VMIe6eTqIiYs1B9p6/W9Te9hQ0GcUeTbSsYTwIrSPyzbS+F5XnK1SWcpdG2QbLSHSq4EwjrPbcN/FXZX/2nuNYtcG+z8/xd8GoR/aiqkexRvgwRW5pvp26T5JwjH72JYuqnevrBm7Py6ZEwP7FKuPtA27S/zzNmlSXhuDLUJgCdgf8+DFNIxO3UfpJuJByVKDjzZrNkx4FcnP7COXEGzc8XwHWRFmUP4MelVbvhn2pBAdNt3fIwJZvw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hCOvZASM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=hCOvZASM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cmtyl0S3Nz3dHf
	for <linux-aspeed@lists.ozlabs.org>; Thu, 16 Oct 2025 01:39:43 +1100 (AEDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-b633b54d05dso4332528a12.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 15 Oct 2025 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539181; x=1761143981; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kzk/r6qDbrjCsGLz+9BLRYG0Pw9EztKEkl/jY+qfPQI=;
        b=hCOvZASMweOeuEojsiL7U6NNp0OIKZiIWFzedQ3NCKZgcVu9BhF8Fz1HRcW+s1X8eq
         SN/+3IfcxXqujCG9qULeuoGN09yk3hFzNCCv9hWbnf7cXV5Mdf2VqBQm2N5fewmDYpNB
         OJm3SgAlSu4Xqon7POpQkfJIfpddwA7dYYSX6RwBH+fV8l2CKxcz81YmS2JRzveEOVQo
         kV5DFIikKmfS1DZfOMYfm6DYhFWKGHPkG+Ei4w4tikkicJFwcCVKxC2L4HjPldlzQZR4
         en0+Pd5STYD82VPJQOGgD5aHR8zEHCx6RhHql2iWHEmiWHDuKbUCYSe7IvJqp4Rs3peW
         cJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539181; x=1761143981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kzk/r6qDbrjCsGLz+9BLRYG0Pw9EztKEkl/jY+qfPQI=;
        b=PxL0l1cnULu/UF8oxvP+Pr13qIFSQDqYWze+0kEdfn5BLL+OsRD/BsRa1k2VOnB9SG
         XMGNoZiGJHJXnZFkfpVd+G3hRKudWiOtI/5g0R6RvheFYqiOtJm0QssWA9WLK9k97Iy/
         FjqihULC1WAd1WwXkEEkFfeMgJnGW56cnSaC/pjMzynuzLcGSKNEvBqP0KdqtMc+LR4m
         coqNGMPUUwJZm074dlM/mHsr7CVZ4ig7fHjfBpWUZ0fXSQfk4a7QBYK2fxP62LCyPEc1
         kOYDN9QlzgpX5c4s88c3s5iYqZMQMBl0Q6MfOmmg8DTD1j4n5nuwAtpWB+blhD5gjaJZ
         l6mg==
X-Forwarded-Encrypted: i=1; AJvYcCW23p+wE24GEY3wEBwVB0Ik44iN1d9uPlDL7Pxn3fnNI46TACM6rrAAVaQOgX3n986gBCsVWPbtGZUTqtk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwKWddubphQgOrcEJHhJOyGIBRiv+7YlHj+I5onTTCr1qWJrebH
	n8bb6d8zjIqRjqN0dWurQRxrlsPQMFQP5GdRzg6vJ3VyAGQGmz24pOmN
X-Gm-Gg: ASbGncupgbIkvKwq+5nLPDZwCz36YgzPiEGBIqr/tgbal5eOoXWYPZlK6ESYzW2D86q
	oYyirRdkDUNRofsI6w/xpQf4346RXyIFoWEoi3R7gNP50tuiF4xDp1tHxC5U/XupehDOmFxYb0M
	EaDXIGUGKC+H5e+N5PTV9NBwx+J6shVv2yFaqy6A+eMcfker2V6FtjhhwUQMoyICHk69zK5tcEd
	fLAXpWx9qWavBKMExtlhyemPKgBOOpxdRWhYRFvg/eBR/W0Kayag/CnzwZK/qqiBROOWDAedNE9
	CsnnlGuI6dwgm2aBc5P/kEZ8zHZvFLxAIY8byImmruF4fJbyZZqkk/leMaKWICS+g5vaM8fOz7m
	yhC6TNbNlEmNP4/TLHZXPgBoUhrIG3jmL02nrKk8yjNjNzbbGSHl0q8eb2GaQQgbeNJ7ywPGXJ3
	us2PQENt98yyQJsT9AqCheDEzexILaGivXHeOnWLi/
X-Google-Smtp-Source: AGHT+IEgWdXuvMnKWxO634nbjJzRkHVq3PW7xVSf2LL3eQamnskf+/AR2cdTFIKYZHqt7ErlAtLOOA==
X-Received: by 2002:a17:902:ef11:b0:251:5900:9803 with SMTP id d9443c01a7336-2902723b876mr366239335ad.21.1760539181325;
        Wed, 15 Oct 2025 07:39:41 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36738sm199853455ad.87.2025.10.15.07.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 07:39:41 -0700 (PDT)
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
Subject: [PATCH v4 6/7] ARM: dts: aspeed: santabarbara: Add AMD APML interface support
Date: Wed, 15 Oct 2025 22:39:02 +0800
Message-ID: <20251015143916.1850450-7-fredchen.openbmc@gmail.com>
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

Enable AMD APML related features
 - add amd sbrmi node for SoC power reading
 - add amd sbtsi node for SoC temperature reading
 - rename the P0_I3C_APML_ALERT_L GPIO to align with the naming
   convention expected by the AMD APML tool

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../aspeed/aspeed-bmc-facebook-santabarbara.dts  | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 3f36c8e03f48..3ca5109af19b 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -329,6 +329,20 @@ gpio@26 {
 	};
 };
 
+&i2c3 {
+	status = "okay";
+
+	sbrmi@3c {
+		compatible = "amd,sbrmi";
+		reg = <0x3c>;
+	};
+
+	sbtsi@4c {
+		compatible = "amd,sbtsi";
+		reg = <0x4c>;
+	};
+};
+
 &i2c4 {
 	status = "okay";
 
@@ -1755,7 +1769,7 @@ &sgpiom0 {
 	"P12V_SCM_ADC_ALERT","",
 	"CPU0_REGS_I2C_ALERT_N","",
 	"FM_RTC_ALERT_N","",
-	"APML_CPU0_ALERT_R_N","",
+	"P0_I3C_APML_ALERT_L","",
 	/*J0-J3 line 144-151*/
 	"SMB_RJ45_FIO_TMP_ALERT","",
 	"FM_SMB_ALERT_MCIO_0A_N","",
-- 
2.49.0


