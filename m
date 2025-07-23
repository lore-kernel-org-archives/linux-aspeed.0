Return-Path: <linux-aspeed+bounces-1808-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C67C83F1A
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:30:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnVkB2pPnz3bmS;
	Thu, 24 Jul 2025 09:30:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753313442;
	cv=none; b=Xf0Q66Jird8WKGrbmgaAfHaWS8mKgfbOqZR0rx1yXQmF4G5LTMnftWZTcpGyRne0ZCTHadBck0V26wBiSlITt3xG9DO0MY7yobIhw0Gtmkc+BhrxtI/PyBahow3XIlcYa78+uBzQpFxn1jv//dDsI3muhHtY04kd0Iay/awt58mqUbqKhDuHVLcKJFnVs9vcAQlA+aQ8Tre1eHhA3Kug7MBR6PoAw0jhwWRU2Nu9XHLZEkJrpyH//JIGVWin+7EY+ESXbhPzp0/7nOzn5DVNmU23gWFAALKVvvD6nvW5uXyEiyV8MsWCmtOfg+bDzrnjMvZlZbQsbEhSA1tH7jQC/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753313442; c=relaxed/relaxed;
	bh=5K02vRBKVj8wq0NKRnvdxQguSOVUkuGvT7a/bET5K5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0+3s2WSnXwkoJDJo9l8aBpje1iHqRBiReadymxQYBv2iYpmfSsPOkeS9mMhGbHD81gaPbvIWVzCId8eLJ4NDJqKy2/hDQR+TtAZc7Y/gr+6+Fm3L1yC6nrpaTbEd8Dxr4g9xyFSVmnlu/lw0cTI0mubanHN7Spe+IslgFfFW+ONLiKfmKGHGE3DcOLQsxRH9+Bj/yzvAHkXA56g/SVt5nr3XVr3dJo/2W9vCSxjSGqW1w/d0ISg59OYT8BVlFescWfshVT61SO9bh6wB7Z6ijV7mjheA2AjA6TvwNGmsmFroBR9MIOR9fFq7wfvQzmOIKUa/kZ4bSQQUVDJ5xj8og==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=J0BNX/58; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=J0BNX/58;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=rentao.bupt@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bnVk956FTz2xWc
	for <linux-aspeed@lists.ozlabs.org>; Thu, 24 Jul 2025 09:30:41 +1000 (AEST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-b390d09e957so553056a12.1
        for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 16:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753313440; x=1753918240; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5K02vRBKVj8wq0NKRnvdxQguSOVUkuGvT7a/bET5K5M=;
        b=J0BNX/58xVe+HH2hxPTn7qXur3s7N1pgHnNaCjWWDhTbwClZXmOpm/0tKt0KWsjShw
         9EaW8ZbuJxPW8opW+wGoGtmpdVbZnmg7PpMRT+WB4/m4xC34o3XBKdzfcMhrKMjoM7VD
         7695gxgzHeR6q5XagkbmLWWhYhWXezDKBdH0T3OwkEo1QAIyp+ydlZu2fApdYpGzrmLg
         8KpfYmYF1WrE84ovuJIwh1Fji6ny27Ed/6mpbeiqNokntOgOnGvqOg2zYyYxtrwyZzt5
         /u6Q50kFRDfxs2M6/6fgWHYpO7Xl0AjF0Il1Uk9eBSpAH5Lxa/JsRHVnHJkcKmOXBsNe
         THeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753313440; x=1753918240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5K02vRBKVj8wq0NKRnvdxQguSOVUkuGvT7a/bET5K5M=;
        b=iadHi4xRw5tjrlOt4VeDq80hUg26AMhbpz1RZTJUqflg8XmVFRyDHj605IU/Mzh89I
         y3OrSlYWPRhd3B8W2Cj8kYNK8/Ce8xH6tZVictJzBZE5jtb/ASZ8QdLkIR7i8OlFqdwi
         dQv4S7ArTD2rES8/bdOaCt5xdRoVLKgStygqn6lAjmYem1jkaJiqDS2Z+40ihOGxXXhA
         8JNA6z3PabJ/XDx6ajMTtxXva7nz3Z3ori8gI/N3bMbuk5IYKWhx69JGXLJEJfHzfykR
         VDu9zWX9l22XVcVt9eDZKO7Hvy3DRIFqX1elckHHwkn7D7g9HwUjWjqI+U2V/V3b2kvY
         8NpA==
X-Forwarded-Encrypted: i=1; AJvYcCWJk/djWQWcKP61AvcceFFZm0Mi8oR36TK5iQqoMmb/1ADzCmLAk9xZ/WtHMcM/vW+rA06Dt2bODxxx7cc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yya6kdFKvBbCI0VMNZ/zxO6bZ7YcUTER3lDKjCIGsi9CO6+gaHo
	k+NPBiXMQq7FLjdpSHm9ZuC6Wu5s9wwUIb/V9CebhbIeEw6DNSvB/cvB
X-Gm-Gg: ASbGncshRUQwD1mCxUMw+0sEdDTqzELMsLpOBG/R9RKZul2yGzvtYxB0ehjTImgyyH2
	AHzlaO5mJL2xXLb65XlWbpRGRTFhU60Wd28qFNcvu5qB4IAVkF+irGNb5cvmB7cw6PkKox0DhtX
	/xwnO80W4+srCMp/ruQzNlkazdNPTeMMqyr7ZFmUEjBwlVgBJFeOF20f9LD06ka64QOHV/ghUBv
	6YWE9G/4EHNafF6lUcvcrMEU75O+2LGHalUJyGvSPz0X2x+3Aat7+vyk9BffS1bZQ06spAfy4+q
	5cY44OgxU68nAHUZmhpYZt32O3/OIN79R7dJSGDqsa1rqio1tEo6MHthoXdlJUbohmEGuSK3BFF
	j2PMX+CI8xcx87hgJ+sNt7gVRQ79Jsd1VO5okz0qX8RkC6iAFDlfzw6vV3SN5b4H7+B7yRdtZWj
	c=
X-Google-Smtp-Source: AGHT+IEfXmpoT/g11peUW8tGwEpWWd7xfm3Gjm7afI5NZ6J1PV8ldBFo8A9SNCO/4qqrkdgMsklxew==
X-Received: by 2002:a17:903:198c:b0:234:d292:be83 with SMTP id d9443c01a7336-23f9812b3ddmr68866145ad.10.1753313439872;
        Wed, 23 Jul 2025 16:30:39 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48bc6fbsm1260765ad.120.2025.07.23.16.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 16:30:39 -0700 (PDT)
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
Cc: Tao Ren <rentao.bupt@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 12/13] dt-bindings: arm: aspeed: add Facebook Darwin board
Date: Wed, 23 Jul 2025 16:30:08 -0700
Message-ID: <20250723233013.142337-13-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250723233013.142337-1-rentao.bupt@gmail.com>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
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

Document the new compatibles used on Meta/Facebook Darwin board.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v3:
  - None.
Changes in v2:
  - None (the patch is introduced in v2).

 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 3cc6e62ae5f3..2887565d4170 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -83,6 +83,7 @@ properties:
               - facebook,bletchley-bmc
               - facebook,catalina-bmc
               - facebook,cloudripper-bmc
+              - facebook,darwin-bmc
               - facebook,elbert-bmc
               - facebook,fuji-bmc
               - facebook,fuji-data64-bmc
-- 
2.47.3


