Return-Path: <linux-aspeed+bounces-940-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A80CC282DC
	for <linux-aspeed@archiver.kernel.org>; Tue,  4 Mar 2025 23:36:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z6sWh0m6pz3btj;
	Wed,  5 Mar 2025 10:36:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741107940;
	cv=none; b=SKiLD5R87B9SXBc/30xqiT4/d/kGhU+WJqb+AAKbIpDBCT4B4qL6Av0yVyQieA7zKmT85f6VqXiCLLK2Pw217yDQI0o0/UbCampi0BOtUmdhBIalEEDS+hKzk0GajlC/kHQUb1zTw4jOOsnuXF5rk3PugNDj0RkbdCPKGY68eaQ1IMuB3GyT3/kSZrRJKENakqjca7nZenT38C+n/mUG2sQSAVoackRP2hiApwNJQ1gP/7gJan7MnXsGuyAvAlw1iSeY4omVo9wYWbUzvXjiuZAsRr31PF++jKQ7iCGIkHdI6tquXAbkdgdegzeB0oHMinN/nHrm49aedGqgnrS7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741107940; c=relaxed/relaxed;
	bh=MzZ6ILzSkM4BJ8jDBuhIko6B+Jnu0p3f7pMZfR82Jo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IUPrPFyJfHthR0BHkIjNLBY6i84mP9M9/DFxFuhRIJi+PwOJLgdRZaaEGa/RIxDSVIP5B5alfb90k63Ly6kVbS3l9oc2JWWIBSwscY8VZ4tdVy0RXZGQC+q3c4c0pjXJKyaTRMewM88jrLzATLvc8HBmYWzLq+vSsicAnjRyfmisrAOoWzsTzF3aTSmXYg/QUvoOMM1+QIa0eIg8jvDrr6hPI28pi0BjpT+FxIhQKECCXsY38uZzfedIyDQvE4FEk2tHX1HfqBy0VnqSewR8+eJJMFW1OPrsS7FUHJM4Ri83kh0ZUomy8G2pXDrkekoWAV/1iO84yelC85rNHBMAtw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org; dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gIfR3iB3; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org) smtp.mailfrom=linaro.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=gIfR3iB3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linaro.org (client-ip=2a00:1450:4864:20::52f; helo=mail-ed1-x52f.google.com; envelope-from=andre.draszik@linaro.org; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z6hry2S43z3bpx
	for <linux-aspeed@lists.ozlabs.org>; Wed,  5 Mar 2025 04:05:37 +1100 (AEDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso9637344a12.3
        for <linux-aspeed@lists.ozlabs.org>; Tue, 04 Mar 2025 09:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741107935; x=1741712735; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzZ6ILzSkM4BJ8jDBuhIko6B+Jnu0p3f7pMZfR82Jo4=;
        b=gIfR3iB3aAmn7Dxi36u6AhPwpAWAXKTNQIrbL4jKnmeonFZdVrCmcnG9pRUlwshkhO
         CjsykWbhz6gV1SZwq9lJmvmEvvQFmGMJfctTQI7izlIAa0dc/QBopS63xywkIePfb8mT
         /16LeAySoPkYTMv5S3gw5hjgX8vzfAOA1L6L6/HRTAu0/EGfB8KogwXe2QeihZ0jZhH3
         5gGvga+NT3WCES8gn6E3QOAMCfD5eT1XlhK3sH3S9A6ccs6ssN3z3xnGwfryKlsoF6IJ
         R+1OW1wZEQdlkeYQaZWtetMWtHLaCd60yaZAWSwin0GtneIwU6Aq4DxJi5ObgzJ/pYXK
         LKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741107935; x=1741712735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzZ6ILzSkM4BJ8jDBuhIko6B+Jnu0p3f7pMZfR82Jo4=;
        b=U+DLy55yjf1D8tlf5tvsLbIiokQYeRPZ8mkovIR1SoL0FbGITX/f70Nl4Thgr1YA+3
         VfQ2MlufsRLVHY8aYQotgyAHnLwzRiVn4lCRCGg7MOqPC7rYnUIKFT8otpjbG5dVD8ie
         PsEiOeJADiFPri0RoXctW7caXJXRdJmFfPalF7/AesyKhVs7x3U9XzDf6iMwCINro5kx
         3TUpKIOXD3JLiq4dAJDVq5ucAfN400e7icaQdM32j4kpmkYvEJgoP/S4DjA9GOruUy9N
         90RllPgoi9eUpUYenICNnK17CQB8EwNhD+iSSR1DuJ5jn6ELkKTrFT9x9Xg2X7RZUc1D
         oSQA==
X-Forwarded-Encrypted: i=1; AJvYcCX8c8sAi7+Bv82rQYU4EDxeGOdifR2Wsh7IiDjerI6glOC351XS/7PCcjaj1mU2//DoR1EZ/6a4IYvvBAA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyArmE642JHN75+hwTnVqV2BDGWWbov9dHgU9tQps9Zr7Ryu7eB
	ejgMEw9ncieey6MrlV6XEBWIrvrG+/X6NNF/YGB5S8vySwYkG+AHRmF1B1VLOr0=
X-Gm-Gg: ASbGnctCrMfZUCHjMj3mgJXUnlG36zwDNP/etAKyqWGyBH7b9YWT3tcofX9nek3WOZO
	/DjU43aLRS3xG4vqDB4tDkYLZYeUG/GlCLAjsUdzduBJDTpXhSVHp0zAHWoMVQf0H4d5BZTHAJz
	EaeL2C4bhGqNG0hWlfyOo6sIHwKI9uY2/kr6+bAf54co5YLryFL/KIZuGupHlbLbZnV6eEpkKNI
	St9xvfx7C0mlppbRrLvF3Yxrp3ytx1N6b+GgOr5aBl/oCDR86dB458PWM7vF0yDudxhms0JtYbP
	YBBG3/Pw5Xe5KWYWt467KtyA8IwH94RBX3beK7K30PudbiH1cpEVE8YQTcBDVw11L+ILft4CL/X
	GxvA1rQ+2iX9eOmC1W2NhVDJY1E3C
X-Google-Smtp-Source: AGHT+IFwDsDh5i25qijWXwIP4x1jml1OHqbOIRoS6nzVQBGxqFZ6SJJ2B5idZS+kqD7e/PzkpEaGBA==
X-Received: by 2002:a17:907:9490:b0:ac1:cceb:d9b0 with SMTP id a640c23a62f3a-ac20d8bcf0bmr3896666b.16.1741107933256;
        Tue, 04 Mar 2025 09:05:33 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf795ba15esm367589066b.131.2025.03.04.09.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 09:05:32 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 04 Mar 2025 17:05:31 +0000
Subject: [PATCH v2 03/16] rtc: aspeed: drop needless struct
 aspeed_rtc::rtc_dev member
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250304-rtc-cleanups-v2-3-d4689a71668c@linaro.org>
References: <20250304-rtc-cleanups-v2-0-d4689a71668c@linaro.org>
In-Reply-To: <20250304-rtc-cleanups-v2-0-d4689a71668c@linaro.org>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 =?utf-8?q?T=C3=B3th_J=C3=A1nos?= <gomba007@gmail.com>, 
 Dianlong Li <long17.cool@163.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-amlogic@lists.infradead.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The memory pointed to by the ::rtc_dev member is managed via devres,
and no code in this driver uses it past _probe().

We can drop it from the structure and just use a local temporary
variable, reducing runtime memory consumption by a few bytes.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/rtc/rtc-aspeed.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-aspeed.c b/drivers/rtc/rtc-aspeed.c
index 880b015eebaf796f68ed82c29998f345e1fd418b..0d0053b52f9b90a61725bf29435bfc8071977f9e 100644
--- a/drivers/rtc/rtc-aspeed.c
+++ b/drivers/rtc/rtc-aspeed.c
@@ -8,7 +8,6 @@
 #include <linux/io.h>
 
 struct aspeed_rtc {
-	struct rtc_device *rtc_dev;
 	void __iomem *base;
 };
 
@@ -85,6 +84,7 @@ static const struct rtc_class_ops aspeed_rtc_ops = {
 static int aspeed_rtc_probe(struct platform_device *pdev)
 {
 	struct aspeed_rtc *rtc;
+	struct rtc_device *rtc_dev;
 
 	rtc = devm_kzalloc(&pdev->dev, sizeof(*rtc), GFP_KERNEL);
 	if (!rtc)
@@ -94,17 +94,17 @@ static int aspeed_rtc_probe(struct platform_device *pdev)
 	if (IS_ERR(rtc->base))
 		return PTR_ERR(rtc->base);
 
-	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
-	if (IS_ERR(rtc->rtc_dev))
-		return PTR_ERR(rtc->rtc_dev);
+	rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc_dev))
+		return PTR_ERR(rtc_dev);
 
 	platform_set_drvdata(pdev, rtc);
 
-	rtc->rtc_dev->ops = &aspeed_rtc_ops;
-	rtc->rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_1900;
-	rtc->rtc_dev->range_max = 38814989399LL; /* 3199-12-31 23:59:59 */
+	rtc_dev->ops = &aspeed_rtc_ops;
+	rtc_dev->range_min = RTC_TIMESTAMP_BEGIN_1900;
+	rtc_dev->range_max = 38814989399LL; /* 3199-12-31 23:59:59 */
 
-	return devm_rtc_register_device(rtc->rtc_dev);
+	return devm_rtc_register_device(rtc_dev);
 }
 
 static const struct of_device_id aspeed_rtc_match[] = {

-- 
2.48.1.711.g2feabab25a-goog


