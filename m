Return-Path: <linux-aspeed+bounces-4984-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B4DC88E5C
	for <linux-aspeed@archiver.kernel.org>; Mon, 14 Sep 2026 00:16:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hjm0M39WVz2ygX;
	Mon, 14 Sep 2026 10:16:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:34::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789338951;
	cv=none; b=QXYXZECBLNeNAq9nCtDkkxcyhX+lI3xEUVrkID1nEjOYmh5nwXtyeu8ZZtMjPdk/iDCKA0iZfF9dz73y7zywJdPNKbWHPssulPZIKbWeyuSsarViaMcpkLWnL/f/AFWRF0pHXXDZ3Bn0GJ+JFZC+2GQO5vV2c83/xp+B5+9JkM1dfwA1tLKgtanS3smVPIiMo/gIzbGVFwe7jq6WQ3//6Dcnyc51RH59iXbr5ZmPAZSvMUsjFmEucGxafGcjHtQggtsLDnTaL6eCHyT5TOEe9fKFBIjbwfZd+LUHiHEX6MOrlpYTz5Ma/DNbiINLxVwzVOPaxd3BfDfuLp3Kb8LZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789338951; c=relaxed/relaxed;
	bh=6tmc56vt785H8n8sw3psZCoq4rEVXID3penocU2E4Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l4BRsYMdEIklorxPuA+jQfbRy2mydRp0EtkniDYyGuFrxEK9E0jgmlDVm8LDnQe88ZhZ2bRQeRX59VL+PBF03g3kg2FZ6KTyqzFRUSYiixZNIO0r0QPdx6Jjdgre9eN7UQoPtjbV2MeU/0en1mUg7FadUJ9UTNTq3jjIMufM5T9KgIriX9UoryE6jFpzkWwH1d0pT7jLuy1MAC24tnw6N4xn2FLIrt+I7WdtX1Nd6+utVZSqcghoC5xui56MT3LcelxVNxll3TAieA4nWsv74HkUIXvxKirJjncGTOEg1PUMLfozvqEVRc5dwvwhkVbPtAtHzX8ZijKoNkM8lW5gRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nBj7C3UX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:34::11; helo=mail-qk2-x11.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nBj7C3UX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:34::11; helo=mail-qk2-x11.google.com; envelope-from=mhun512@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-qk2-x11.google.com (mail-qk2-x11.google.com [IPv6:2607:f8b0:4864:34::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hjjmQ6dcgz2xkr
	for <linux-aspeed@lists.ozlabs.org>; Mon, 14 Sep 2026 08:35:50 +1000 (AEST)
Received: by mail-qk2-x11.google.com with SMTP id d75a77b69052e-52fb769ca02so25573021cf.0
        for <linux-aspeed@lists.ozlabs.org>; Sun, 13 Sep 2026 15:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789338947; x=1789943747; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6tmc56vt785H8n8sw3psZCoq4rEVXID3penocU2E4Lk=;
        b=nBj7C3UXWcJ6bwOY/GmgHGUGj25s5Bha7K3Tw0yf9KN8YgzUYTM+N/TvLBttSH+/Uk
         BnErS3/PUzUaJdtzKE1e10sjS2Q4sUteEca2yjVr6MM2nQL25yW2A/hL05FOQBtQRt7y
         j3pz2OGGwzRkr+JZtjciHEDqoIqcxi2h4r8W3go/vfgKWoe+aCY0mQt0TA3Ek2VcXpP4
         mMfnniYQtwck5+KBCT41kSJ+AvgAEp5PmznR+ODtCy3BQBkJm0XSTPMt5n1a/1tVfGQh
         RTCQOZza77itBixw4Aa+QHhu2GNN1kDPjU3wNlTbTkBNvzLmguMIf3fHB1QGhlrOHKB7
         ZI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789338947; x=1789943747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6tmc56vt785H8n8sw3psZCoq4rEVXID3penocU2E4Lk=;
        b=CRaaU3Ch7Z5Rf0VreWSlGqBHjGAo/ZCRxSUGuFgZtnsCnxcwqHqbsdsBEA6cuLrgVs
         7ZoZQGxx0junS1akj4yRm68RZMIW7bbHR4VgAgtXKCh9iGEVjNGqgttAGIBr0Lnk97Ir
         BTMtoG5tfjr1WeaDWSOdpX4WgM/Gllg82dhNAWD8T4HDi6W+9LYmYhNOBiM56TxTpOE2
         TYnsEhHL/szT2+CFHR2oJfBpO+JcDp5lhC6sbAEn1UScJV48Oxyj2FA6HdRhZiw+jql1
         AcMpXX9Ra5x08/9l2QmZSrcBPcfo8DDLuJUJRWKL8lfXpCFERcQXgpEHwjEBqyjryXO0
         XAwA==
X-Forwarded-Encrypted: i=1; AKwUvBx2qfshX5C9H6a1nrUMbJ/a9Xw0aanNhNr/tBMLRRIGdyVHh8OwtaE2CdTBvutAW7c26E5nvIKZCzLk+78=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mdk0KdsZkcDTN+fPPpOmotao09NE2DAVftx9uPNg2eZz4a8xgd
	++TCDI7MtbYTmxtK27j5EeFPh5CighXS5AhmZAJ1GgzBktQuAvuhYpw=
X-Gm-Gg: AYBFou0TCBHqSI5dsp61hU0k8CF3PlHgZIM2MQ98E6OM6sUOOIMje9D3/Yk5l5m+cwB
	fhJUyMfZxdQj7vmVz5BanhFkgk/+oTshbobFeJBtMLrlRzRn+U9R5pe53w0m5Okze0ZY1SXPExz
	8ZcYrbwBDHBkyozl0cNyQgm1JxUFJXGGIcg52csNnuo0LUk+CRD635nzft6GmmNM353zmyr3IE+
	a6AqCs13+MBG8sdJu18P47MKtyDBrcCMCFMXgpz97KDIE44Zue5jOPnzrJe4FuLPLoC7D2nggW0
	5iTIoJP/Wj7zwd/1J03nF/nyF2JZfompE7wiZtJrFuQmHAum4GA2GFKLTQTqFuI9o1JVcg4N0vl
	g/SsxxJ9+UfHOm/wh7VJVxuohDOEGsZ4NHQR2QoVvy0OU3ucrChCR6I3cYN3ODMbOrttWTL4of0
	7y6pURHmy8jcoIqA6pD8XxcWLc7r/e2iFDdnHPWE8Fk2h+tTk188XtbC/U6mLSEiro9ptf4WkON
	xNrjfZROn495AlIvJ3mfWyGtSbtPj9wUD1DsmM7yoW6SV2t01NgynFGZCBVGG4UKb9PhV3SYP13
	JFznMyWutiUI6XOgyMwoXlWwmHqsIulQUQ==
X-Received: by 2002:a05:622a:11c3:b0:530:eb9e:63d6 with SMTP id d75a77b69052e-5310d09817amr342871cf.49.1789338947507;
        Sun, 13 Sep 2026 15:35:47 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530d5e946a0sm71513481cf.25.2026.09.13.15.35.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 15:35:46 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Joel Stanley <joel@jms.id.au>,
	Ryan Chen <ryan_chen@aspeedtech.com>,
	Billy Tsai <billy_tsai@aspeedtech.com>,
	linux-aspeed@lists.ozlabs.org,
	openbmc@lists.ozlabs.org,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] mmc: sdhci-of-aspeed: Remove children before releasing SDC resources
Date: Sun, 13 Sep 2026 18:35:38 -0400
Message-ID: <20260913223538.91579-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
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

Probe failure and removal leave SDHCI child devices registered after the
parent clock and managed resources are released.

Unregister the OF children in reverse order before disabling the parent
clock on both paths. Use of_platform_device_destroy() because manual
child creation does not set the flag required by of_platform_depopulate().

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: bb7b8ec62dfb ("mmc: sdhci-of-aspeed: Add support for the ASPEED SD controller")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Assisted-by: OpenAI:GPT-5.6
---
Validated with an ARM64 W=1 object build and strict checkpatch.
No hardware runtime, probe-failure injection or unbind testing was done.

 drivers/mmc/host/sdhci-of-aspeed.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index f5d973783c..d317626feb 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -560,12 +560,14 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 		cpdev = of_platform_device_create(child, NULL, &pdev->dev);
 		if (!cpdev) {
 			ret = -ENODEV;
-			goto err_clk;
+			goto err_children;
 		}
 	}
 
 	return 0;
 
+err_children:
+	device_for_each_child_reverse(&pdev->dev, NULL, of_platform_device_destroy);
 err_clk:
 	clk_disable_unprepare(sdc->clk);
 	return ret;
@@ -575,6 +577,7 @@ static void aspeed_sdc_remove(struct platform_device *pdev)
 {
 	struct aspeed_sdc *sdc = dev_get_drvdata(&pdev->dev);
 
+	device_for_each_child_reverse(&pdev->dev, NULL, of_platform_device_destroy);
 	clk_disable_unprepare(sdc->clk);
 }
 
-- 
2.50.1

