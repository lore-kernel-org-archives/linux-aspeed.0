Return-Path: <linux-aspeed+bounces-5215-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B89CCA462
	for <linux-aspeed@archiver.kernel.org>; Fri, 16 Oct 2026 08:46:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5dpF4KX7z2y2B;
	Fri, 16 Oct 2026 19:46:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::435"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792140389;
	cv=none; b=UHX5HKM3TfzEDe7271Kvn6PLxXU9YbwN7VFbl7i/NoBjrK5AT1N6AqBFWELHPhXjtcPSWYvz3+iamz+0w+UL6K/ozKf33YA0KaQnoth7cttIGhpm78eZ5l1zq8xzV4km1AfWO/3/Fm7IwIV8oOp/jaU+0a217tOnWGfhMNufkcGpKgpY7hKHm8YIIEqTMfUR1YdQa8Q7iegdjy6qwxZWSiCyITKKslXqCLgNzJu9dcUHyyBqkE27C35bOFZ0CeI5CPSFrvgh9w0eAjtFW5cAf9paYGqbdc3GdGPPaNz2YKYNHxlky3CucoGG0DCKFDwq5yTj1EOgV+RBjxx2bMFMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792140389; c=relaxed/relaxed;
	bh=KFJNx9u+viXRs5tNEKp/mtIp21KgfUj1WmCFdRLL6fQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M2Dek/3YNVlL3LQRn/P/K9llPUkv5zVhxrc/8Q+Wtwe1OqIXoku8P1xgme4oWJQbqN4Qdu+kneB4jO1IprrYw0cII38HGVwoqloklKtkZetz5p4+7Eb6l+ZvSqNxN21e2PYg602jbu7NvYfZ4CKMvOCyz68LIrpgeyE8sILPS7ZiXNazgCUS0lDyVmNKAjLCU0sywc9OsfQp7JaXlQiYEkjHJS0rhKvnpatbfuY/I8eUR7+iVGnk68cF3frFTG9Z7//pMzdxTVqlaAEfe9r1xlGATusi8+FP5yU0asfEfPyD4VA/BQpzbRvQ5Lzx5rf8jYvepAQFGnP+1xBHJUTANQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dXM9k9Sb; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=dXM9k9Sb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::435; helo=mail-pf1-x435.google.com; envelope-from=kylehsieh1995@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5dpD5sMhz2yTQ
	for <linux-aspeed@lists.ozlabs.org>; Fri, 16 Oct 2026 19:46:28 +1100 (AEDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-8874539bccbso1594917b3a.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 16 Oct 2026 01:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792140386; x=1792745186; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KFJNx9u+viXRs5tNEKp/mtIp21KgfUj1WmCFdRLL6fQ=;
        b=dXM9k9SbXxnZJusyBnVtoD7q8rwGztd32Iic9dXfNHfbk6gSc4AdZ4b0iBNvPqkxAX
         Xgg21YvPsROe4UOUGt7Z8NqxlfDAJFMrIFGM96MjnkYw43v+1gLKBUkp4gdnU/BJ66WB
         EaIMV9SjD/jDK3pMZrIrDyW75oirL6YH1cPQ1jufvEwxOhSS3avVOu+EXv1zJuoe3NTj
         yKkTyEnuH6Al8QZmCDS15O5oK3Pqg8zLyrFyrEmHCFiY6CRKGeoYbGOpLsf8xg5kayX/
         P6OmbHXFeRs/fv+IYUscQQ5vwDqzR6JRfJScuy6jBS3Hhav5FkB8cssaLGyWVrZyPnTF
         3Dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792140386; x=1792745186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KFJNx9u+viXRs5tNEKp/mtIp21KgfUj1WmCFdRLL6fQ=;
        b=qY8nPXz0dEAvIp1mIqfpQi2826Os2/m+E1TFjsSzQhO5a9ocDyE6UfP8UA7hTEAZGq
         PlWD9zofE29LQmKDyiq2NODSG+71thXk7XdoTbRHjIQnYEFfi80Nu5ukCM/oqPFk/fFM
         ywCDdiOXWCxK0Vy4j1OUZa0rRRX39nEJJxoligHhe7jiPMnAW1javdzicC5/o11luUef
         NKd0q5XFGfryapQ2fsEoWJs1jlPP1bWx79rFyl6AxapLPyI8ZW9BzDtg2HOo1tGpsG9e
         sPFS8Az5qgiO2MLiqmT2QirqoHT7YtgEJicMMUJhL2IA0y2BD7aX2FriTCl0KYpfdphF
         49jQ==
X-Forwarded-Encrypted: i=1; AKwUvBxiAGTLe8WDsdPhnHW7Ks8b4+nUaqL8q9BGgyhbT3+icZt6J5a3NWXT36IwFrJX+e5HkHL0URs/A4imBG4=@lists.ozlabs.org
X-Gm-Message-State: AFq9FYLkc7TyVFbjEuy0XWEi42M+vPCAUdrTstIeJiWo0o3l7Gy6Ngtj
	4oMTDALuq2UUdrLr+TVmL1XjsFHtaw2CK4UP6inPbmIkt8eI+LXOM+1Q
X-Gm-Gg: AYBFou0PDmUnW/pRE8J46JU1oUCj5Vrh8upzKuBqEf7phHYYaZakSM3JR3k25O9k/1u
	/eXgNuVOB1qDcJ2SMWMDi3y+E9sSYEnX+A9h2VlO5lpbfz3yE8oeHy0UDJCTY+o9M9SMGa0apvs
	ACCOGtTNzUbIi0HLjMLm/f3jcYXTW5aKpSsm92nzNe6JjEUVl5ehN2D8yt1Pc0iY3hP4chMkNTp
	RQZy6vmN65o+uO9BmROwGvEeFNB6dAq8nsTSep7DPDi5mHCTpPkmXX/VcFUrGhhD9bnjoQKu3oK
	jYlKJuW6aAPteMXLEUGlkjyiLQ0W7B+EAYo7Bh5SvMbMC5hT2mByxVOF6X2eh8z0mEhyvM90Sda
	eTxuKE2NC8rUlLFTlOHEmpM2qXVw5Ljp2mtnoG9OsS3sGjGCqV4Ay0h9fOiyOWcTdcyVJC9f7HO
	xuXba9BGRU/CE5cW+2rVGKNvJEqTjZw03IxUkNmnh0rYGs13uWch7z9eaW4R1l9sz5VJHB6ZXDW
	4RPpC3tlOWUaJ7LFrjUon9Dpg9Cm7eZqMYuMc0n3E/B2769
X-Received: by 2002:a05:6a00:a01:b0:886:bb44:631f with SMTP id d2e1a72fcca58-897c6e1c80emr21774772b3a.10.1792140386374;
        Fri, 16 Oct 2026 01:46:26 -0700 (PDT)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57947b0esm756620b3a.39.2026.10.16.01.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:46:25 -0700 (PDT)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Fri, 16 Oct 2026 16:50:29 +0800
Subject: [PATCH v10 1/2] dt-bindings: arm: aspeed: add Meta ventura2 board
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
Message-Id: <20261016-ventura2_initial_dts-v10-1-a546659a084b@gmail.com>
References: <20261016-ventura2_initial_dts-v10-0-a546659a084b@gmail.com>
In-Reply-To: <20261016-ventura2_initial_dts-v10-0-a546659a084b@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Kyle Hsieh <kylehsieh1995@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=915;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=FazoqI/ILuJD9YIY7tvUgoQ9mGvSj/LgYKIkJKM/QVM=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBq0eVZOWBB+HJr13ff3KUg0fZrnwLad53T0UIon
 3VXJMNq1UuJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCatHlWQAKCRClg0K3CVbE
 gdBZCACjTlbWiWNV+3gKl99YFT3Gs9ahFspJGNkV/LAbx6kcKSGnzFdCsOiz+cbI0XLLlf2e/++
 hekAZIERIT+v+o+yNdb5flZFSrv9bDH1ykaIfXwKGt6z8HTkO7GquwCt+19wBUhxWtw1dYYx3jR
 2R8IMSGEtRuVkTQopF3hUSqV8AjE+CT1SzVN9Q27GKcaBp1rtBrkkJWgc07vbtwjjwfWBdLhpMX
 mAUpr6SupMVssUc6xR4vpcDVHo6S0dl6an2bSyweKYShZ5ixH8xQVLgZijsaJH0G+88ELxqlXT/
 wFmczlplAbMieIwx9+C66Fjktaio07vPPHX7U03TM4li/hIZ
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

Document the new compatibles used on Facebook ventura2.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index dd7996960de3..b7e70868ebd8 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -98,6 +98,7 @@ properties:
               - facebook,rainiera6-bmc
               - facebook,sanmiguel-bmc
               - facebook,santabarbara-bmc
+              - facebook,ventura2-rmc
               - facebook,yosemite4-bmc
               - facebook,yosemite5-bmc
               - ibm,balcones-bmc

-- 
2.34.1


