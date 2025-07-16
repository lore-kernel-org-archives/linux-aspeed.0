Return-Path: <linux-aspeed+bounces-1732-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8335C83F1B
	for <linux-aspeed@archiver.kernel.org>; Thu, 17 Jul 2025 00:41:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bjDcY4440z3bb2;
	Thu, 17 Jul 2025 10:41:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752659019;
	cv=none; b=b5IE+b7nELun9Orr9GbKgy5f4+z/eAyISd+WwVOPFvTGM5xiqJvOu1U6blA0u05/w4q9A05CtR+BCCwXwmWUvDus8kZvElXf/7db6DgyEkGSp4CuBQ5nEgoMGg71VkPyi2TG6Rf3qCrCpJ+v4L/bg/4lG6opmmSTzP8sNRkzevdiRtYiByH5CGhO0af2m1qekfd42Sp4fZDcXw/lN22EzwJd513dzFdF2biJXUHnx4ro6mGTG3t9G7TogPsmNuIMokUmN/3AaYgVEB9qF4gMb4DGIfnnmz4+OU6++OhETVYXAzAYcIncFUE/3ym7QqfAXmvVn7WU2Ikt1hxZ0C6H6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752659019; c=relaxed/relaxed;
	bh=D5vVXw+LoXYmvFQxN+y9Jtu16e9jAjGmsO29XS/9U5o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EVvNbEJk0JCpVLVW+pA5noJno2n+islXBuk6PO/X+am5oloyuYbNHLsxopXT2U53H21FCGWqHcjssM9as2uyMu7J+GAn8rtMkw0H8wAiet+AT6+D/qE0z6t+Qgjc2O9eIJJFrRR8UNAi1HozhojjqUiano1Hf6dkSNkcQrhCLaO70zJdlCESaW7vYmOO5nvkIyKRA92BwZnn07nFGQG2ue5RpIMblCsi7iFfUmTbsDJ/TyNkG4xuWvmd05r/UEmE5E48vt468maIarvsDq1mIHz1eC5/Y4TNgbNama63iwg7dY/MA0jT/jMiznFPfQf3vj4bcMzfwcg2XEWm0dBiLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=F68EJAUd; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=F68EJAUd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhrj60mRVz2xlM
	for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Jul 2025 19:43:36 +1000 (AEST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-b31f0ef5f7aso3392869a12.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 16 Jul 2025 02:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752659014; x=1753263814; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D5vVXw+LoXYmvFQxN+y9Jtu16e9jAjGmsO29XS/9U5o=;
        b=F68EJAUdRYb6VlWeyODNgYYcS+b1zy0GbII8ltwqEyZgAr/xFGwLBvi5+zvt1ly3TK
         i15oZbHAE2cAzWapQfp5xynQotY78ye8URb75EwKQis9q1BaZUdwmKIqbtSc9a1zqNYp
         dX+0tZG9r5fde45frfCMqnn1km6yq0ahrzIKaA+7ZbHr3cZu73ZWYOFkoVSpwxSym1NG
         nlCjOFDsCynjpgH7kPho24tv96Vn/zdvlI2mQK6PQD3IzXO19Ynh/jrsrW2MMImv5qaC
         8zAHiM5/1EINQg9ymZ+TSDb5VRqN9XqIOIbMsyv9CjivJxmtGMbue1sqinoiY31D4Nyf
         Pj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752659014; x=1753263814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5vVXw+LoXYmvFQxN+y9Jtu16e9jAjGmsO29XS/9U5o=;
        b=nn5dDSMbO0pnyNcqu737ir9UFXtlhk60k3wm9ejs3F2NKeXU5v4U875SRnCsXykiR+
         +p7CjE3c0F5Ucse8+jLtuZuA2mEugayAVMnWOqQp7vgu2IuaxWmHBXCSwnAJPRogm8O+
         pt/ooFIS9MPAxd+sbXaUrE5X2EQ1i8VBdoPSiyYzdkmT8+eVrjp7yQ87hTrjZowxRP3m
         97bt9zohqPzswQZis2Km21PZwdL2LfFCsSZsayTH7TuAAe1X1aJKATen/2V2TKwSfULJ
         L6G7k4TCssO2WKwpfsH74tEGT0CwvAooDPvBmrmFSwmsJe9+Ww7gPDUZqXgIUMUCj6Wl
         uuhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7sdvFVD0h7NvT+09sbiS8QcsKTHFGcLAFkZIKlHmd2VtwLEO/YHFNhrUY0D/5nI4B6HxlLA5XPh7GEoM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxIK/fJSkavoN4ICoiCL2jhKOK6tO1P7B6alWTXtHCZkOHC9DwL
	uGZY4AGfx4YhJOUCSen43GyKaATxpYinVJQqfvBSGJnqRcDWn0R9o/Z8
X-Gm-Gg: ASbGncvJ7BP8Q4v0XxnbJ/n+t5T6I0v8QyWizlfd1JPu+ZaBZaRnHtxggS+bEW94z1b
	zne17JJYsA/v4D4Yb8l1h0NC0su2652m8pWbC+VgBWfiwms92+kmA8UXUDwXd+umZJHset8xsH9
	bDkNt8xpbGUFmwkDMwTMu8y3a0uL7j8INEpRjQHRI7u5zGeLADu9e1p85m2BFU2yGZ9isGBhzuO
	s8po3icsmWbtpjQOddr82dgi+stSls102J+YeixG4LsSGx9tdzwPtVJMIcNmKSuJf66tNDiZvrC
	SByCy6k/0si6/btZ71bnahZp/F9n1LuOMeTHCeiH+hN2o6n2kurVBAuCm8tZJekgbwrB7fsjPz1
	QJPbZir7LVKLh8wu8aZchQNbeaxoWpU2M3b/baBzxbWHiqMuU6o5zKbykLjZ+Nh0OsEQm+6OpEE
	QCQdb3YNUv
X-Google-Smtp-Source: AGHT+IEQ8TA8a/Tp8JVUJ4l4ZbjYlDYN0wAMilYaPQ7xEw3y9Z5/A8bzzrn/UjeSnv2yhj0GESvLrA==
X-Received: by 2002:a17:902:d547:b0:23d:f499:79fd with SMTP id d9443c01a7336-23e257647e5mr37218635ad.40.1752659013872;
        Wed, 16 Jul 2025 02:43:33 -0700 (PDT)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f2350acsm1039503a91.45.2025.07.16.02.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:43:33 -0700 (PDT)
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
Subject: [PATCH v9 0/2] Add Meta (Facebook) Ventura BMC (AST2600)
Date: Wed, 16 Jul 2025 17:43:27 +0800
Message-ID: <20250716094329.1069203-1-pkleequanta@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Add Linux device tree entry related to Meta (Facebook) Ventura specific
devices connected to the BMC (AST2600) SoC. The purpose of Ventura is to
detect liquid leakage from all compute trays, switch trays and rack
sensors within the rack, log the events, and take necessary actions
accordingly.

---
v1:
    1. Create ventura dts file.
    2. Add commit msg.
    3. Use format-patch to generate patch.
    4. Add subject prefixes matching the subsystem.
---
v2:
    1. Modify email content.
---
v3:
    1. Add mail list.
---
v4:
    1. Apply git send-email --thread option.
    2. Sort nodes in the dts alphanumerically.
---
v5:
    1. Run scripts/checkpatch.pl and fix reported warnings.
    2. Remove unnecessary 88E6393X CONFIG FRU.
---
v6:
    1. Add a new stage for the DTS change.
    2. Run scripts/checkpatch.pl and fix reported error.
    3. Fix the issue in a separate patch.
---
v7:
    1. Fix broken indentation in the device tree file.
    2. Sort nodes alphabetically, then by address if equal.
    3. Rename fan sensor nodes from 'hwmon' to 'fan-controller'.
---
v8:
    1. This patch series has significant changes compared to
       previous versions, and quite some time has passed since the last
       submission.Therefore, previously received Acked-by/Reviewed-by/Tested-by
       tags are not included in this version.
       If needed, tags can be added again after review of thisnew version.
---
v9:
    1. Reordered the node sequence under i2c5.
    2. Added a description of the platform's intended use to the commit
       messages.
    3. Added 3 GPIO expanders to i2c10 and defined the necessary GPIO
       line names.
---
P.K. Lee (2):
  dt-bindings: arm: aspeed: add Meta Ventura board
  ARM: dts: aspeed: ventura: add Meta Ventura BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1553 +++++++++++++++++
 3 files changed, 1555 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

-- 
2.43.0


