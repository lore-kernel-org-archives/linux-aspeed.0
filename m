Return-Path: <linux-aspeed+bounces-3635-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6ECCFD88C9
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Mar 2026 23:01:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVqBb590kz3bkq;
	Wed, 11 Mar 2026 10:01:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773136197;
	cv=none; b=hLlqtHqT/NvQetu8zhH35/jOqeYuG3cf4yWu4uBxIxShWrzFILgRs9ehC93Q3O92OHqStAvFCEK508mdyyfOemNawixCw0vq+mxEaCF2iZLnQpUla8zYGVzHXiq83LMqAGCvDkClK/AfDICCZDC72W8elaenZ0HDXBmR9WH+zbl+YCuaNUIRxnHJa4OJkRAthmUnRJmf7zk61JfSAN5h07ttxV1bKiITsjJTlx+pwTOOxhWP2x9j216wr1smm5ec1BMzjux7/Z3BtyRVScdPjXWhIeFs90dMQCVdb05Ry6Im7khm5deffAZks4lwgp11hHH2607+nh3va+CQad+Fzg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773136197; c=relaxed/relaxed;
	bh=x1aDzJ0oh9aQEO800V2bAcY+ffAgEFL34SAN70Zrawo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dblMy1V2WvDCkZKO8KAJkD0ysIiT8ZBC1lT5oNoRiqWr5FWOL6sPVYbhu2QbxsXmq8/M1IytCI01WAf0mvWsd9uUW9uExXcNKra6ALv5+DyeJftYx5oUGqlq2k9jzC00MYzO+9h3MFdCb6tphE5hua6+KsfUCylaELZztCmR9rCo2ES0D0GEjTtstYp2XcL6iinNALxfOsoq2vsP8pTUDpiaS9lKq9GUMA4WstoJmsZmxUS7eRV3Fcu/YCCzykXVu0ZvRXOWIkQcArvHXKozgQa/oIFuO362LaKDdo+LOHanXrhI4fquSLqyhxyu/P2j2QYrFKF7yXFhd+tl2uSFhw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=V/byWDvX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=V/byWDvX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVTd106VLz3bjb
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Mar 2026 20:49:56 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2aea41d4fbcso2909295ad.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Mar 2026 02:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773136195; x=1773740995; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1aDzJ0oh9aQEO800V2bAcY+ffAgEFL34SAN70Zrawo=;
        b=V/byWDvX+r2V9kCIkzQDayGW+NaaOGwl2vpN9Li7lk2UBHNQtl7Z1lGnocOjDhqbZL
         c7Ye+bL1Bx24VtyaH+rJ/w7NDu3UKty43ooh+JDr21zWav09Dqg7gkY2mUYqsoGL/jS5
         gWVGvNJxpoZLF1bsy0QYA0pLwG/63oa4z/XsV5VEDU0lEjnyhK3xd1zfK1TpQuDJvNDZ
         Z5B9b35KWe0jpP08PbD2vGDPgDk9W+EXiCGujB2uueHfuvx+ZJSplBtlA6rcAbs1sXnJ
         xLcghgFRG02TeZaYQaBv/+uauDRBRxBK91TJ/41+aCRzYPFckNa9TPa1xoggf4U7SjWg
         RmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773136195; x=1773740995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=x1aDzJ0oh9aQEO800V2bAcY+ffAgEFL34SAN70Zrawo=;
        b=sT/DUm2oWSIAw/j9E4XOJWe7LmQXUjyTPLGNjEElgD+qAHV5fWMMDs6zjnNfHO9eHb
         +81FUVmySOnU2mSUui4x3FvBkBeAptyeB55qKlwiNeSs4z5T6QqcIIFlbBw6ieJX2Bdu
         W3Q6uVLy/khsb2DJ6+7NqDrdtvySvE/OvMKj7ftTkkVkE69Sre/7PV9F/U72NjiF1s6l
         n8SvvVuq3vpL1jnrzMQOmcoJm/jJrLI+yHwS7PpL2hxmiomM2sKyyPo6pWPcYbTR1Wbs
         VJIKIs/nYRGxeaPdT9eQLzRIPhrPr4GhaZktK+eI5rfaJn0UD0EyNKQBVI1S0sYGsiHP
         ZinA==
X-Forwarded-Encrypted: i=1; AJvYcCVLxJtiEbl6M2G0Vbv6+E77W24txNqnSkohyf2ItktT3oRsa39shuhZ3PqmeDtdcjhnKhR/RBzUx7JAQEI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy3eeGjYUUH3N5Dx0lzaY87yvFgammS6TfIyLoq+o3JQQ/tX024
	iA/bWs91f6nfKc5gz/nbIm1BDMARnPlZIRyMmzrUsQBWTE9TuwoYZTjB
X-Gm-Gg: ATEYQzx3nEVKW7whpdpWr9jCCmV20rLU0qk7bJZPRiZJ+fCTL+nvPNg/dHSBWtV8xzm
	sPAJmfuWk+5UQWcyZiS5OuQ3/zNO1wkokz9o/kc7vIx6RA6f+fHlgWJf0geTKetaEGfc1O9adSb
	s+k93Gj55jgDcvOZB/7gLuo44sdK8/k8y989Gl2tV56Uje+gZjIxqJ3U9qiTQWGxVA4c1OPrrpq
	mS4xpo1GlYyUrucw1JGlXYjZpxi1Aq8JeQfcHRW/lNi/0HhJwyNARGjvA1Z8byiviK8AqO98pSt
	qJ+qL35PUFE0Va1ucJGE1OusWXK3Nhqo7xqEq0xlUVRFrrkccriObfAU23AKR+zkyPeMKiv04Cv
	XtgC5pNuJxg477hEql7H4bS83qxpms3l8kOD+yAXO7OZsV6J8rN0hVnf3Pov41zOtiYUZYaJU2r
	kmTRpi/fp2EUvhBoBN1LQ=
X-Received: by 2002:a17:903:b4e:b0:2ae:7efa:af93 with SMTP id d9443c01a7336-2ae822640a6mr144995945ad.0.1773136195150;
        Tue, 10 Mar 2026 02:49:55 -0700 (PDT)
Received: from [127.0.1.1] ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f8a67esm199459775ad.61.2026.03.10.02.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:49:54 -0700 (PDT)
From: Colin Huang <u8813345@gmail.com>
Date: Tue, 10 Mar 2026 17:49:37 +0800
Subject: [PATCH v3 3/3] ARM: dts: aspeed: anacapa: add SGPIO interrupt to
 PCA9555
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
Message-Id: <20260310-anacapa-dts-sgpio-v3-3-12d9b7f1202e@gmail.com>
References: <20260310-anacapa-dts-sgpio-v3-0-12d9b7f1202e@gmail.com>
In-Reply-To: <20260310-anacapa-dts-sgpio-v3-0-12d9b7f1202e@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Colin.Huang2@amd.com, Carl.Lee@amd.com, Peter.Shen@amd.com, 
 Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773136185; l=1232;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=Mr3A2NRV9ww4HVUgXHL1FFtPeh7edkZ/s8D935nooUk=;
 b=YqK93JIpbhuvNaEFsUHhnrzvNaTcKHv35WX8dM1/furCKeZmzIncMXLjRrXqdce3sUiD9HJVZ
 4RhC2cb024VB3jSrsqvqsb3sdNsJ2txjXvbXc1TpHrK70iR31HeHvSw
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=

Wire PCA9555 gpio@24 nodes to the SGPIO interrupt controller by
adding sgpiom0 as the interrupt parent and specifying the shared
SGPIO interrupt line,PDB_ALERT_R_N.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
index 85b7e027daef..933885055636 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-anacapa.dts
@@ -500,6 +500,9 @@ gpio@24 {
 				gpio-controller;
 				#gpio-cells = <2>;
 
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+
 				gpio-line-names =
 					"RPDB_EAM2_PRSNT_MOS_N_R", "RPDB_EAM3_PRSNT_MOS_N_R",
 					"RPDB_PWRGD_P50V_HSC4_SYS_R",
@@ -546,6 +549,9 @@ gpio@24 {
 				gpio-controller;
 				#gpio-cells = <2>;
 
+				interrupt-parent = <&sgpiom0>;
+				interrupts = <174 IRQ_TYPE_LEVEL_LOW>;
+
 				gpio-line-names =
 					"LPDB_P50V_FAN1_R2_PG","LPDB_P50V_FAN2_R2_PG",
 					"LPDB_P50V_FAN3_R2_PG","LPDB_P50V_FAN4_R2_PG",

-- 
2.34.1


