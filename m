Return-Path: <linux-aspeed+bounces-4649-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97A3C5AC9E
	for <linux-aspeed@archiver.kernel.org>; Fri,  7 Aug 2026 08:32:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hGcp03YsBz3c1B;
	Fri, 07 Aug 2026 18:32:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1786091528;
	cv=none; b=av6Q5NrzkaGaKtj6lru3t5M4uXanY/2vYAHIB/KEa9SsCryvRBGhH+I44xsst6vYBytwvkDSq/NISM0p1X7vUCztF1A8Tqk+iMKKarPNIImgznRxE3uuFUUArC4pp5IXGbkOkktp/0Yv018z47s2PzhG7GBv3piTVkr7m+ya25CpMGt8QLdfV8T0y4EtI2XI/zFFfN2n5/9PHiGqK8xq6MT920lLxoI8NIdQb+Bqc/7j48QRCapQZb+fwvPTI4vZbFE8h31MGtIRuoTt0UHjNY8teE6H7/WuvOPvtzgCL56WL6Db91OWRFkWwa0BkzjgT8UAGJH0fON0Ci3NdDux7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1786091528; c=relaxed/relaxed;
	bh=ixpqFwpYyvhO6JYNSRkqWZf82rMGmiosNWxtjl84Sb8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnMpoYQewX3XP2r39CW6NKT+adyzcq4sAMv0pWrBXzhTtSmDwl2H0Y95cFtupMRYRyfp/6xKI8nw5+jb3z9Z1N2RMGI7g3k6a43GNbxuVXOdaNyp59p5g8dOx5fwiHU97k2++49K9l6L+9RftMiyn4agB83FnFdFJtLGnFnSOjjNsVtOo3A0KdjNYswr5OmzFSD+s1A/4FrJHt+IT9JOLQierazfCMw5wh6pTpXrpldP2kqmA280JDdzqonJj9mIAbDjq3kOWIVmu1zTfdo3l/BWn/AtJ+Uyd3kyd9yEhyJEPA8PboHfIPyDcpPFMOBQZ/5GANylmyutOOfNkzitQg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RSyXRyJU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RSyXRyJU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=fredchen.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hGcnz61VCz3c01
	for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 18:32:07 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-8453427d3f4so3651056b3a.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Aug 2026 01:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786091526; x=1786696326; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ixpqFwpYyvhO6JYNSRkqWZf82rMGmiosNWxtjl84Sb8=;
        b=RSyXRyJUZYvCNSfzBnSOXErsrLV/8edU8oG0z1Z/f/RxMZG1uKQRW1w+cQpkio3T4d
         sff9o2lmR5LgdxGeiRrcROQaUuHcLgj8AZVdz0mMmZEc12W+bkPaeI34gDViALt4orCL
         o09XaOe1l0uRvb+ZbjTXbs89ZphKBpp3m1pbsVVgpDih+g1FcB3YqCCDZqJ+oMUV/qkZ
         j8sWlk6fI584o0FRkdccV/RpFpzgwWrOUlhcYnBvXhvDG88aBvQEmLEVjXemKKsC85+5
         5AWtC3uA5RBBN3QaM/IBddtJHuC+kZcDl2k/ate7yWwAwBbxPxGEjnezr/hMSg9hmfXx
         bn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091526; x=1786696326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ixpqFwpYyvhO6JYNSRkqWZf82rMGmiosNWxtjl84Sb8=;
        b=D76uuBA9wJ82cVCUmS94fcPOkcEgCwOf61gfXVuCrlImkjDjZuVk1DOLuN/ishRPsM
         mz8p5SQ9wS55m4ljkOJWsIUue7zaOLwt9YFAhJVrYY8k12l2dBxwzgu2oainCqlpCao3
         IVn/PnMJUR/fK5ayCFt2+QRG8Xvd6kgQTMnoree/9gmSXY4mhUTQJugPt812MJS/Oi5I
         nQKsrRmJ4B4rc+m2CzsPSGNPoOrOcymun0sQotfBQ6+0y/tKhHclYyml1QTGJVTUZJA8
         pboe1nWSbwF0aIYUAcjIpBWMwKKco0m2hiYadPf8qxrmPnybw78IChS6RI1f4UTy1l8u
         GOdQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNuWmERw4/YERE/69GYrwg2J38e2+WuoPfOPVnC6C3kX5/w+oT48X6Mqa5OHLMCHLecPbvwSp6wfh8fR4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx2LFOhqgb57ThcX26Tkr3HInYXmHwY0V4GhUP6+ltx7Z1K/+/K
	8najLkiycprNHYG1Bias3L1rbyvfs7mURNO8S4KdOqPBy3KL9umHsTci
X-Gm-Gg: AR+sD110sAnAPRS1oFrwgSNWHKAIS5+Uoi3Hpdsu+P/1D0bE1L5UZ5F6CMk2v/tqxCU
	kjvZmbZCHlZwB5l+9bmMCt//CzQa/7Ns8EacKrn7WdHxqRwJmjAPyfnuKNPdqXBOR4spZjzieqJ
	uS3iqTVMZD/4N2Fr6YPcYsRQuuPxzzsG+Pb11aNf8IjJtwca3rFSPrBKCoZ8unwyS8eHBxp45FH
	iCXi3mO3JNIob5rhwM95G+cstAKgDLHlxsEl9MLkTaI6pnhLXUUOSWKYx3rsab37yCV21AN07Y3
	1IpFNDxJBskuLuCf1TWJPj3o2OHw7PHcpFnacQGcumc1bOCk1IRNEBHQWPEC3t9PueddwEVTMqV
	PNdvpY2XWAxMLBPdEyP4TW+Cb1NmJvsKu652mF9ZHju4auhccnn2OlYTGnqmn5IUT3/7VVMx6Ni
	oKuz6MzsEk8KPSXTHy7LVgjE4z+j2bWBB/Xf9iXT2wJ3YnesKSwLhefJwmb8aPiRBHTBUg98vL3
	BXm8FtcLfRp7tA4ZKiUYsSeAoHsexpu3JeDN8bLQMkLBH9r1Q==
X-Received: by 2002:a05:6a00:c93:b0:84a:29a7:f650 with SMTP id d2e1a72fcca58-84f2de6ab12mr22053575b3a.0.1786091525621;
        Fri, 07 Aug 2026 01:32:05 -0700 (PDT)
Received: from fred-System-Product-Name (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a553071sm627409b3a.43.2026.08.07.01.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:32:05 -0700 (PDT)
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
Subject: [PATCH v3 4/5] ARM: dts: aspeed: santabarbara: Add SGPIO line names
Date: Fri,  7 Aug 2026 16:34:07 +0800
Message-ID: <20260807083415.672008-5-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260807083415.672008-1-fredchen.openbmc@gmail.com>
References: <20260807083415.672008-1-fredchen.openbmc@gmail.com>
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

Label two groups of SGPIO lines.

- FM_MCIO_[1-4]_THERMTRIP_N: thermal trip signals carried over the
  MCIO cables, indicating overheat on each of the four asic modules.
- UFM_READ_CMPLT: asserted by the BMC after it finishes reading UFM
  data, to notify the CPLD that the data can be cleared.

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts   | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index 9d334a01d407..3d35a5a74104 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1907,7 +1907,7 @@ &sgpiom0 {
 	"MB_SKU_ID_3","",
 	"SYS_PWR_FAULT_ALERT","BIOS_DEBUG_MODE",
 	/*H0-H3 line 112-119*/
-	"FM_IOEXP_U538_INT_N","",
+	"FM_IOEXP_U538_INT_N","UFM_READ_CMPLT",
 	"FM_IOEXP_U539_INT_N","FM_MODULE_PWR_EN_N_1B",
 	"FM_IOEXP_U540_INT_N","FM_MODULE_PWR_EN_N_2B",
 	"FM_IOEXP_U541_INT_N","FM_MODULE_PWR_EN_N_3B",
@@ -1941,7 +1941,10 @@ &sgpiom0 {
 	"I3C_MCIO_4B_ALERT_ISO_R_N","",
 	"","",
 	/*K4-K7 line 168-175*/
-	"","","","","","","","",
+	"FM_MCIO_1_THERMTRIP_N","",
+	"FM_MCIO_2_THERMTRIP_N","",
+	"FM_MCIO_3_THERMTRIP_N","",
+	"FM_MCIO_4_THERMTRIP_N","",
 	/*L0-L3 line 176-183*/
 	"FM_CPU0_THERMTRIP_N","",
 	"FM_CPU0_PROCHOT_N","",
-- 
2.52.0


