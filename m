Return-Path: <linux-aspeed+bounces-1731-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98849C83F22
	for <linux-aspeed@archiver.kernel.org>; Thu, 17 Jul 2025 00:40:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjDcS2Y4Kz3bTf;
	Thu, 17 Jul 2025 10:40:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752659020;
	cv=none; b=iKjvEoD90ORrT4/XO+dl2xub+oELQuU6ZHh4YDV2NyQxKWraihxPvHdpFTcwIAHAh8Rd8sRRCJJnmMLRFLJ55lGDO/Wk5Z6G6QiV9d8IyNj+FtYFmc/L+t5oTykmbHOLD/4zEgSQCGKgrL2duEYoxWESMEDxqcgFcqgLMe71Ezx11pSINph2JbQenGJCuJ3ZO6v1ZUwFZKKCl6EhsQ19MNsQdcgDfm1tUyTgu//g9hQMazWT5UqMj9mvC7x5zAzlcpKjLhTpwWEMZsPcH7M7d53vfGKOfOWRo964htCToxQsp9Nyzi2fO0tmUcFnYErHkTmqfVAvnsjT1vuTN8kuzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752659020; c=relaxed/relaxed;
	bh=59/cGrD3cECKnmhhvyten3EjV5sJFXNCMmz8J9SY3Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kraVLxyjPrO3B8qqbOWPeSWI/Oo8J1SagkcsjOlOs9AvQUqiffyaCnBCK6u+kKuUqLvXc9C0IpFvJD2qB7pbBtzckKAbd/n3a9QwcstKih+3e0fr4/2HD5n9QPVtyiz2zed7H6S2MwEAdLuXakJLBExv3hhyrAJeXohLpZs17QR+gi5Y372pGMpkwx8/0ZwgbjYiZmQ3xunEGnhJPuCoo5bDhDShDI4Ne7fptkIFkkJYto6YuuB0CgP7U4QM+Xy5UN2RIMXtcV/9xazaIkc6y16ggWbAPRzbv9KNxKkOUoWdk035bFi9zVFkbc7zrWovgmyp7ik9gnu7tf6LcCT3qA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=X5Ta/98F; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=X5Ta/98F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhrj64ZSfz30VV
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Jul 2025 19:43:38 +1000 (AEST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-23602481460so60860495ad.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Jul 2025 02:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752659016; x=1753263816; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59/cGrD3cECKnmhhvyten3EjV5sJFXNCMmz8J9SY3Wg=;
        b=X5Ta/98FVfab+7iFcVK/SmUIPUWKwGAVKBXVHYoZv97gm9nkSwnFFpLXuOwxL5iLno
         xTj+IDiXNNVARC9pgdb+8PnezaQ/pv8K7hjrdQkyHdyYUJT2XjnzvemXTK3KM9PZ1DOM
         PkLZAf2ti/JCShWdE7FeWc4TLfYyAhmqDhKqyezaNwNxhwUf1L4JDYxXu6QZ/w2Ms9Xx
         FbfydJ3KrTlL/eMfQjnirjYsqdG3/snABj7jlKKuhyH9OwqoF2RQtwi7RdmQXAr3Kcsq
         LkHBznuZWSI05Okw47ren1avTqeWzQwx+n8mzN6fKWvxJTWHO9FKgL2eleTYWYNpPBlT
         3xCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752659016; x=1753263816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=59/cGrD3cECKnmhhvyten3EjV5sJFXNCMmz8J9SY3Wg=;
        b=AnTx4hztScbxDPw03gzio7wADsmY9oyHvQkaAB0FsTx4br3ZAbEm9XjOZDQJDEG5LM
         ZkC+O/qR8sIXu/iXscMYN60Xmr6/3o8e+ttpFVjOT9OFyZSzhMO8fkPHNTUiO8I6Ycaa
         LI0mK0R1uHSXVQyy+ag02cAbVGwfwtz+BnOUDJNd7kBkWCGQyV24MXcw4SCGFxANldZJ
         QIoxBfrfGmQNx8h7yVfm+w9vkLSJJSsQ9P0i44ojCnP6dXhJPAI+PqapKqJ6czH33U88
         Vzr2w5+dOiHpBAGNEQ1BLYQpmYr5uFtKUTqzxAJ3qTIWnYKhSzDYfkUkfqrrke02AiPL
         zuwA==
X-Forwarded-Encrypted: i=1; AJvYcCUur0i4xJDI9oydf0Cqfs5HypDrycHp2TM6S90IGyW3yfhOZKwV+lhBcs90SL/YHpsjTAixzhP8DKgC4I8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwhNF+/4XwLeFPtLlJdY5sRc8DPIW3XFTXnE0qL1dg3VNFYCsR2
	4PcRWNNOXMxGUXEBr9spVcb+IUOLGGiei5LoN1kvzsWFK7C5JI8tiOcm
X-Gm-Gg: ASbGncvEQVvVeteOrbY/jeEDRvE5klYwfNmDX0Kbl4NvNSjK5HLKXqMXBblqLVyphXm
	yyu6ypO/ncKT5ZXrwbdO0CDvkUDNnvpwpr7ZLfl6nYvvQX1zvzCufI2L2PGCXxCT1PNOFA8q4nL
	kBgvrXvtNo2z+e9klStHQwxV94ZA/CJHZLkCo5PcE+W5Nd5e81c6xLyZ9jx8Wp3Qlpj/qw+Absm
	JuxAbcpO5w5pgV81vj3t/ku44KuICszvmKBxFvwfsePYYvjpLYkOdmCdgAiyS5PHIGfHJeKAdxD
	3bj0WNwM/jP4IXIJX9dZMxoDcKmIvqneb1UotkZC0SOFttEyoRbxWf/0pWls/KvqJgpXwuVH/iy
	+23/zcbfEsTr/iUelLkIe2F7xeYuMsUsWJqJFibGf449FQr0VRwffMDQhaHZDKQp8K5H2fos8fD
	Lk551YyRbi
X-Google-Smtp-Source: AGHT+IEjRWwLIhiIoP0DIOS1wG+5KB2COrui2fTYZZ19Fi0hrVi8hf0inWpz3h0vQDLXUd7CjVKp7w==
X-Received: by 2002:a17:903:19f0:b0:224:910:23f6 with SMTP id d9443c01a7336-23e24ff339bmr32733445ad.45.1752659016492;
        Wed, 16 Jul 2025 02:43:36 -0700 (PDT)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f2350acsm1039503a91.45.2025.07.16.02.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:43:36 -0700 (PDT)
From: "P.K. Lee" <pkleequanta@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	patrick@stwcx.xyz
Cc: Jerry.Lin@quantatw.com,
	Jason-Hsu@quantatw.com,
	yang.chen@quantatw.com,
	p.k.lee@quantatw.com
Subject: [PATCH v9 1/2] dt-bindings: arm: aspeed: add Meta Ventura board
Date: Wed, 16 Jul 2025 17:43:28 +0800
Message-ID: <20250716094329.1069203-2-pkleequanta@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250716094329.1069203-1-pkleequanta@gmail.com>
References: <20250716094329.1069203-1-pkleequanta@gmail.com>
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

Document the new compatibles used on Meta Ventura.

Signed-off-by: P.K. Lee <pkleequanta@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 2f92b8ab08fa..98ea2b3e0eb1 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -86,6 +86,7 @@ properties:
               - facebook,greatlakes-bmc
               - facebook,harma-bmc
               - facebook,minerva-cmc
+              - facebook,ventura-rmc
               - facebook,yosemite4-bmc
               - ibm,blueridge-bmc
               - ibm,everest-bmc
-- 
2.43.0


