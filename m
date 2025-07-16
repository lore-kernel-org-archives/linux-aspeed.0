Return-Path: <linux-aspeed+bounces-1734-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678B8C83F1B
	for <linux-aspeed@archiver.kernel.org>; Thu, 17 Jul 2025 00:41:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjDcm0b1Cz3bTf;
	Thu, 17 Jul 2025 10:41:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752647075;
	cv=none; b=F9CEBoTxqHtoXJ/piC8XcDSko1qEjM/pA+7tKqEbQHa2uEubrRTDddbnN1V+iywFNyEO61I85jcbQnB8P6lApVHfewACEDqCWw3JdxOhVy1TQqT4bDuFZKjBYaPKnA0gWfba2ank+oMHwRsr4doHBuPgTICor2+2ZaIQk2rhg+sGiVR0r8jnh4nucep7nfa5U7dCyU93F2FY/At4UhMa6c2lEpkTA+p2CQ3Wtc+DnnvRuXcobfcVksRElP4XfLe970ozn7oqzF4zLMw94gVCvYIR+pzYT0TGfsz9Es7iTHz/WDWjw+kG6k5AMxSxgCIReFDvDPnGbO7nGVrDteI6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752647075; c=relaxed/relaxed;
	bh=KxTTJcqEHv+qBmIyyfl+JxjRyKaE0U2wO1Y0rWsQE80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UCXmhPDJ0BuTye26hro7c+lp6YUp3FxFVrmaAtyPqodkavp7qxld2jZeycDYymmoTSSMbOq5M000lrK3M49i9S4Grbxgj9naALp3EhLLjHeP0euT8TiMt1z+GMVMh06jiECc36k6mCZzry3TyjkXcBmb+oxuW0jaXaQk13wm9CeKi5ydVjZC2hjNstrtyrSlb2j6+tkS3UJWSVKx1oiLdOZLiNFc1nMUstmPaU8bncMfEPMzsW0ePy3JIEqiv5MS/l2221JreaM3CXOGk7XjFMFemtsVC8zD+z9P7qmLZZpK/ahwrnW+BkV2u2UHl07xXCXZtsx44rvK9fbZ7bbs/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=boKdGCZl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=boKdGCZl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhmHR0Fwhz2yN1
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Jul 2025 16:24:34 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-23dea2e01e4so70748435ad.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 15 Jul 2025 23:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752647073; x=1753251873; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxTTJcqEHv+qBmIyyfl+JxjRyKaE0U2wO1Y0rWsQE80=;
        b=boKdGCZlQICARE8iRRAkW7yQNy+sgSp3nbHg8ZSZjMyNNRJJhVrbPl4hCbBiO57fO+
         wKWa0q+4LmPGkE67PYUYNsm32owlph5RqAFs4yCTurGYO/qwgnU5Do2uEFSLkGGCfnDJ
         UKJbMKcFsfvrFbPi+1vsANwBh/BGbFe42TJeXpBSH80xV+Jqcd68fGKbiKfd8I5u2qu4
         045QL6qTEP5E0vuE2g5ynoLiFDmJEq5hB5hVuyXsSgDBwuBSinRvnbM2+YX2bH9iikYk
         780pAtiyGyXHusln7bzZ5d1K+YMG4lz46XKWpL3nhbZYFXOZRQTz86o+Gn0lFpUTXgh5
         KSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752647073; x=1753251873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxTTJcqEHv+qBmIyyfl+JxjRyKaE0U2wO1Y0rWsQE80=;
        b=I4DnxKNLzwqZRzXBJOvH0NZ8vnTusNvD5dfWoIhDIPvcXU8/qpaVXskum14256XD7+
         iPhqgUyLuWBE+y0kv43iMYZqG/I3pPBSFO1Oj5N1f0fMe0VSMsRAO6UkTqP7pZN6hI3Q
         BGW7/Ki7+b0jUrB9yChjJT5lzHlEdwaWvM93Hwwp87GHz8smbf3ZwRspYItMhoeQXuwF
         N3iz67wY6kumA8//IAdCaUKNanKAwml9yIAazewXoln0r38l+3URWcgNriHh2nlOZjgt
         jX+9N7GHfE6tKqGjLTLfH9lmxGi7q9Al7dd9smfCaA57/qtVz6iH1LeJ80EybuCn73QY
         JDdA==
X-Forwarded-Encrypted: i=1; AJvYcCUm3FoNR2w/R9bEX7Btr0vOfHlMkPSKsbfn/82N+g02xlB/KgqeA3ldEfPtd9xCtYMOtyDASAbqw5hV6jw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzMDqFU2IZHLkLZmgrmxAATw/15bgGFEHQ2sveH2JpLiyqUZ19+
	bVzWS+ZjN1JA5LmeRtG2PriGOsCu36Ic//IxeoQ91H48QQSVMSLYpbMx
X-Gm-Gg: ASbGncsYTIvqfK4lBbPgGMB9ENS0mvl1tZGx6D2mPr0WaI5r9xEtRY8aVQVpHFJLTbx
	9SdtyOaKyqydVFuLLypK0dVSeemRpTrZldcW+AthnFPSPjdgp7v8Idbs06nemUnsrzbHpiM5zFS
	a3u7DG2+N38i3qi8lQMGdXrwETL78/gPSqesK2tiQdxjLKgFHHeJ9eACoQmuflTD9dVSjNgAfso
	3jsZ1JHY5+a33r1SHDaPldrbzlqJbLs0PnGF0AY5gc/qFnbS/CM0s36jnFoyB4dTLwlWc95nla2
	kgDQvCVYb0E05r8gXpFN7AxPvVnIxfgrgEOYaywQkVmm981/dF19W3knNoBvHyLJJ1iYGe0q61/
	tissAclhPLTWqjCiW5Cpq+7nYTWZv6mf4wf4T420bi1VznwEnfRT4YV8aBhxolui1NUw=
X-Google-Smtp-Source: AGHT+IHc5NRKT72vFJzQaq8CRt6yzwQTtLIRVCztcB9Pta9EPy2rcxZm3nlBUajC1g6t9FPJlhNKzg==
X-Received: by 2002:a17:902:da91:b0:235:eefe:68f4 with SMTP id d9443c01a7336-23e2572b0cbmr22515885ad.29.1752647073057;
        Tue, 15 Jul 2025 23:24:33 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4286081sm119060955ad.1.2025.07.15.23.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 23:24:32 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Date: Wed, 16 Jul 2025 14:24:14 +0800
Subject: [PATCH v7 1/2] dt-bindings: arm: aspeed: add Meta Clemente board
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
Message-Id: <20250716-add-support-for-meta-clemente-bmc-v7-1-d5bb7459c5aa@fii-foxconn.com>
References: <20250716-add-support-for-meta-clemente-bmc-v7-0-d5bb7459c5aa@fii-foxconn.com>
In-Reply-To: <20250716-add-support-for-meta-clemente-bmc-v7-0-d5bb7459c5aa@fii-foxconn.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 leo.jt.wang@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 bruce.jy.hung@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752647065; l=933;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=UnfBA/U+nB3GVshcJhQl74M74uA3eyzQykqLq1TeLXk=;
 b=uAGS6CnELOpU6XAlzzaTHDoipk4QLYLE9trQrVHONlb/CLuMwRHB4D/O1SVydCks4Rl2mJXTd
 /g/SJfibj10D0/IMv3qVW0N1R6r8ze/SrE7p++wIzy+wGWphNbb2J3j
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

From: Leo Wang <leo.jt.wang@gmail.com>

Document the new compatibles used on Meta Clemente.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 01333ac111fbb076582a6c0e801903c3500b459f..ff3fea63cecd99ec2dc56d3cf71403f897681a98 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -81,6 +81,7 @@ properties:
               - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
+              - facebook,clemente-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc

-- 
2.43.0


