Return-Path: <linux-aspeed+bounces-1647-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF197C83F03
	for <linux-aspeed@archiver.kernel.org>; Sun,  6 Jul 2025 04:24:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZZ5K238bz30V7;
	Sun,  6 Jul 2025 14:24:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751775861;
	cv=none; b=hoXSe9RY7Q/4xRpjLUog3i8w13ETp64GOVG7rXTm2cFdzPgrhLyxM9IFEWOsTkgfcwbsNfWjCrJN3/fkd/9VhVYWSjtCSAi8IGpVosYTJfwK8C1It+lcRyXQ1IK1uQS0SmWxBixkmAdat+vzRPqCjtIIRDUmVxLQVukYAkxaWN0OIZ/upuLfPzeJqq4hmF/JSjQLKFAhxmbk1x6V+1CjZdTN5ZX3WusFHC9b10E2kRCc/meJd+P9drrVxU6An4vIbt5fr2syiaFr9VZ0pY65K9W0nud5j/44zC4r1aUqBcBNgU4yg08nGze1c4m1/UTAGf+o38jrbM3+8lTVkxHgXw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751775861; c=relaxed/relaxed;
	bh=d4zGUQOdnJ69KAUBlNTKEGfxN8OGbSwbnbCSpcFHfJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9qNV2+TWeYXehJejyMj8Ycz5wJoGgfHr3YMDf/umr8hu1v9UAWF8WTw9+6MdeR8ZZuYH2/MFWWD0As2fLGH4//1gaD0EMG7b+iXf6CKcNkJRbnEGehKkGGpoEqPCSKiZDNCiiCZnprAIry8b0QRKJxYMKMHnictaezdOHk9bJXEwlj1I4ukLaz/wwxLpVDNUepvoqTguNjl6GU9rnU6dkU/eNNWyDPrbzk4nrcpPkeZUSTLA1u6EtI3EKDw77FzGXRclYmxAO7gYFQlDY7GTaXiV/xmt7BA0xYfUvjNJATteWEpgpWQ9lUo0fSkPXUvXQ+WrlOe/mlAxq0/8XhCNw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=esLBXfaY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=esLBXfaY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZZ5J5P16z2xHp
	for <linux-aspeed@lists.ozlabs.org>; Sun,  6 Jul 2025 14:24:20 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-7490702fc7cso1210043b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 05 Jul 2025 21:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751775859; x=1752380659; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4zGUQOdnJ69KAUBlNTKEGfxN8OGbSwbnbCSpcFHfJs=;
        b=esLBXfaYBfahj9jEWkZ03TIrx/eNdn3v3u3J1CAYJIUxI9WjeMj1nKQR3QTLs371Q5
         Z7iJTX0U95w9dOkzMNf3t3Eod47vHdK0iqpapyPxU/YoVqctEljIN2/HazIzkHrZNwRU
         ihF+XaxKHy8ElVWkQTNKimhl76kMeB0hike+g675eUi9iwqlEMHP85nAae688B9Wk/Kk
         tAFd12+uj0ICZgy+wscHExegkPfapJg6mGL0pOGHbEuQaYBtir5oJpwNfthj3NrrHpHV
         wCGNxNOs+3Qj07TINSXVUWbHGXfwTzMvjjpYnaTKa4P7OrYdJ+kOSi61VlGi1fxY+o6I
         6c0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751775859; x=1752380659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4zGUQOdnJ69KAUBlNTKEGfxN8OGbSwbnbCSpcFHfJs=;
        b=Li5cd3+DA/Ic+pZrm5VgAdbfUz9PUTK5jXnt+l8GIxVRwUylvBhXXQoOs6UahO3ORc
         wI09QezKjws9MPNSfq0ODV5i0W9Udc/YszB05jAqSMQjIzC2/ssDejStbmFuQ/O6kZ9t
         ymPUiAaSNNbu94UBfrVMRbSCr1waKQmgbFdOCq2Qm5/EG5o8Ys01AGUG9PqTOt715gDq
         Kl9mXNIYfgAQ0R3+hdEO1hBs0BM4YW0ov9EKsAmVCPP0RIIJesToykyUlAeBYJ1uerFf
         qzQvqp4RYpyWjHk2SHzQQWU4BbdN3KGYEE7XkjGJa0oaGCNd+dtE8OANM/jFyArp1PGh
         Cq3w==
X-Forwarded-Encrypted: i=1; AJvYcCWy+tTzysFuIhzokRZggPMapYsSPqE6vya9r2ETNIIaaxfYxdcTasAOO/HTxH1T57fAFwgAsaAdrlXzyRc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy5/5fqDSsklU5Ct2X9QEl+rLdGzHZyZ7in3sB7FALXrvs8jXnS
	16FTxIki2snt2W4bFka/14eevc7z9WbydVgiBeLoewe6s6PKclug6Dmo
X-Gm-Gg: ASbGncs9mCPq2SsA47j8YrDz4gifd9fq9TdYiJzuk5QkWH2ojTsWLSd+83ovEWe4OWO
	lUiLHmzIaSXsXsdU7c4MoVTSrx2YZf0JblorOoi2B2rMfgaFYlkme6SkultaSfLNlTJQrJ/sT/D
	JYz6B8wwuw9+tfe/nX+qYkjg+ZKqtfV78KX5jcggq6gD9De5pFgXABxeyq2dkYQEgQUEHRMDZby
	YXCwTlKiR2FnPyMz6FPWQ4F2GJ02lW9C9M6GJFbvXM2+E7TdKFVvq1tPeajQk1Nt7KPuaurZzRt
	gUsi+6r3q0bJzaYVqh6ITKSFrvEqdyUS5RPXICI1GXlIfLiHcv2CS5zdlgUmgpyih2YFsjbJBdP
	4dssa6z38EvUmL9BofINcFZjSk0o8Z3L5eehDPVg=
X-Google-Smtp-Source: AGHT+IHRyoxO9wJjn3WxYHJI0BaRuQ8jiymleujUzsWOOYUm3nMO8dl2iwjV6yLqVVunAz/SEaHFiw==
X-Received: by 2002:a05:6a00:23c6:b0:748:fd94:e62a with SMTP id d2e1a72fcca58-74cf6f17155mr6130664b3a.1.1751775858985;
        Sat, 05 Jul 2025 21:24:18 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417f206sm5287067b3a.76.2025.07.05.21.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:24:18 -0700 (PDT)
From: rentao.bupt@gmail.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Tao Ren <taoren@meta.com>
Cc: Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 6/9] ARM: dts: aspeed: Move flash layout out of Facebook netbmc-common.dtsi
Date: Sat,  5 Jul 2025 21:23:56 -0700
Message-ID: <20250706042404.138128-7-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250706042404.138128-1-rentao.bupt@gmail.com>
References: <20250706042404.138128-1-rentao.bupt@gmail.com>
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

From: Tao Ren <rentao.bupt@gmail.com>

Move BMC flash layout from ast2600-facebook-netbmc-common.dtsi to each
BMC platform so it's easier to apply different layout settings.

The fuji data0 partition was already extended to 64MB in Meta
environment. Elbert flash layout is not changed.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
Changes in v2:
  - None (the patch is introduced in v2).

 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts     | 6 ++++++
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts       | 6 ++++++
 .../arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi | 2 --
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
index 74f3c67e0eff..673cabbec92e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-elbert.dts
@@ -50,6 +50,12 @@ spi_gpio: spi {
 	};
 };
 
+&fmc {
+	flash@0 {
+#include "facebook-bmc-flash-layout-128.dtsi"
+	};
+};
+
 &lpc_ctrl {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
index 840d19d6b1d4..71f58ad1ff06 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-fuji.dts
@@ -223,6 +223,12 @@ eeprom@2 {
 	};
 };
 
+&fmc {
+	flash@0 {
+#include "facebook-bmc-flash-layout-128-data64.dtsi"
+	};
+};
+
 &i2c0 {
 	multi-master;
 	bus-frequency = <1000000>;
diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
index 208cf6567ed4..4f819bf8c909 100644
--- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
+++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
@@ -54,8 +54,6 @@ flash@0 {
 		status = "okay";
 		m25p,fast-read;
 		label = "spi0.0";
-
-#include "facebook-bmc-flash-layout-128.dtsi"
 	};
 
 	flash@1 {
-- 
2.47.1


