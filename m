Return-Path: <linux-aspeed+bounces-2987-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCBACFD360
	for <linux-aspeed@archiver.kernel.org>; Mon, 24 Nov 2025 22:41:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dFglp4rx5z2yvB;
	Tue, 25 Nov 2025 09:41:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764019280;
	cv=none; b=aNdd+dGnINX9vUTzbZuknITsrJyv8HhDf7PH+LHy4PJSc/lRg5XstB7Jc1Mp27PByWPZPiNgpvF+JInX+4cke905506q6Lm2uyX63I8mtqxJU+UzDRi9BcrjwZpnJ/g1wGJg8fw57mYd4Fvtnr6cX2ENIKP1uVl1kxS3t0vH9mgrnLGnSaMcFmR2c41Hz5PUXNtmGYWBLcbzLR1Kylwb2jdVh8TDTiP84TIWUaSMdtzfCRf73C5h2A/Wc9kvOqjSN4iLyeuubvA5yZwb/UDmGA3mjEZKU5ddH3odsNpYIREXcFpjEt+OIbHT62d+L8mkq2YkAq0X1NnmLkdRX3q/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764019280; c=relaxed/relaxed;
	bh=+5Inq94WidM1IzPMPQL+vlU5Af/EQE0R1rM2YRtli+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KIlWoYMpg8sd9PuL5lglEHCHWX+B2y3EEn7f3Ak16pmJMYxrBGE56y1yz/S1nXQTQtFxM+LtRDGzY00myZ4I9z7UUR3YS/RX0uDoapAZdYJejZS2Nw78EG92DRr60edjNoS8t+E7HeJmzyPA25Cm0+zE4QhB9I4Tgf2XtWt5+7PpuYRLcMyIMtQCMF4ugEWcz2beEXTfuRHJfCdQwN4W471o8ciPE2ACLg2zI0/zOdZeMQkOSNDZuo//zO7Bl2wvvUDmTz80jsp0f6h0hkPYwmSXtIVLILQYKHDodeJoaGdPS2wdCcTGfNu6LXLRBhoLUzgm8l98FySbwdkvnUJFhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Q8lvocQs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Q8lvocQs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dFdzg5CMtz2xQs
	for <linux-aspeed@lists.ozlabs.org>; Tue, 25 Nov 2025 08:21:19 +1100 (AEDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-b9f1d0126e6so1936868a12.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 24 Nov 2025 13:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764019277; x=1764624077; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5Inq94WidM1IzPMPQL+vlU5Af/EQE0R1rM2YRtli+8=;
        b=Q8lvocQs9zadTROfJeCxXleQz2G+O6yEa0/1VFcRqzPOmwi8+xlZFrMpNp08G63lhQ
         Gu18fM2ROP+VEI/mMWOHAs7FbqpBr9IjTk9AOx2TEDE6q5AuoTokRyYm0mZop7fYhrUA
         gqPpbFUxxu9TwvVAFCD4CKMsInaQkBzPhhjBSG96IjnTAEuOtJuEJ8Er0v1jS39My6gv
         w+PDr9nQegc50H6H0affu2yyE/4JUsC6CJFwuQus31yKxYQhajSf3n4BxFJm0+ZOJ3uO
         qp1RnqxaKUzzxdMEp4Oea9LklIdIVkits5Pp+4nMw9bjrAOyW8Lj8v881exTr3nZnw2Z
         eprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764019277; x=1764624077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+5Inq94WidM1IzPMPQL+vlU5Af/EQE0R1rM2YRtli+8=;
        b=clC0NCTLhhqL7GebInrOYKVvnTaTKuW/QEg6FKcWnGLfEi3KvzgepScYJL98WHKEP8
         yiILp/m7SXyL51rhgDimC8JV4iT+O4RDsm8IAADFFR8MC1PTyLYE5uWL76iBtEzHOqY2
         zBjfB9Ku3GlE2Y0mSimoJbD1bVIwpY+j3guKVeUvxvwm5tX7xwGBk91jJT1BwR3evSA3
         qzttNc7i1O7zDgswXtov8I3QxpK3dLBO8bQTRbCWrNAQFc/aiavuYet9tzCwtUvMpnmA
         okw094HjyJIvmkyjqX47GMBB88UeSQfGTSQfN3X8H5jsam2B1b+9QA2DW+Wneju5wgDj
         HbFA==
X-Forwarded-Encrypted: i=1; AJvYcCWe1yAIXyxk2yOlyph1XSBG3kgqFsXNPjBWvrLQxtRL9Q555OXJaKs+4FKbPSfzfLoxk+Cd5Ne/cgX0Bkc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyL0ZwGWYvP/haebZ+d3ZukADeRA96HN/08c7AFI02+/ohZGJ9j
	Uq3p7K6S9LYXO1hnnyeRjxao0KzBcccsEITZdwQOGar0RR94ujaN/ThD
X-Gm-Gg: ASbGncst8KWDGctlBInxtwxjXJO7K18fEo9k2bksgRhWGfHdOzbrKal3rEhkLfYCde1
	vvK6koEdLjKcU6GUzLteo7ttB/lTnFt+awc3H4ZRItsmX1M87t5Kq4wTKFdt6Y4IQ9AcS50WjkG
	a00IosLZdPGeGcSr/BFd00RBx16ZpjW49h+fmGhJoyX4WFYtQNWL/uGVRg4ZWVBugc2KjrHqemx
	UuPbnj2oZB9XfgQCD9Z3VPBAZxgEa7BX9cU5qQnwiUNlSOu42W8WHvUM/0wsyd9+ILbmhUozGF0
	vzp1+GTLEToW73XkVPQOAJ2ST2/G4aKXTsqZ5eQcnXV7zhb+Z0PXe42QzY5TqEpBxxx29GgiTMk
	Npzio3o7ARZXA9XPAoaFTq7qKwf+DoHw4ucZS08q3EgWvquxCon5SGffg5agI/Hde8cT7LmOqIQ
	OXIg==
X-Google-Smtp-Source: AGHT+IGt9JaxSdMIg/K82kDNkha5T5JfwKM7sCcz1zE6ZPRoDIHpa7dMxg/PxPkD6VTRBOZIK9jBFA==
X-Received: by 2002:a17:90b:1d47:b0:314:2cd2:595d with SMTP id 98e67ed59e1d1-347331cb3e2mr11359605a91.8.1764019277550;
        Mon, 24 Nov 2025 13:21:17 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed076eb3sm15702319b3a.1.2025.11.24.13.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 13:21:17 -0800 (PST)
From: Peter Shen <sjg168@gmail.com>
To: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	peter.shen@amd.com,
	colin.huang2@amd.com,
	Peter Shen <sjg168@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/2] dt-bindings: arm: aspeed: Add compatible for Facebook Anacapa BMC
Date: Tue, 25 Nov 2025 05:21:05 +0800
Message-Id: <20251124212106.2068069-2-sjg168@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251124212106.2068069-1-sjg168@gmail.com>
References: <20251124212106.2068069-1-sjg168@gmail.com>
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

This patch adds the compatible string for the Facebook Anacapa BMC
which uses an Aspeed AST2600 SoC. This is required before adding
the board's device tree source file.

Signed-off-by: Peter Shen <sjg168@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index aedefca7cf4a..bcb874ebd9d2 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -80,6 +80,7 @@ properties:
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
               - asus,x4tf-bmc
+              - facebook,anacapa-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,clemente-bmc
-- 
2.34.1


