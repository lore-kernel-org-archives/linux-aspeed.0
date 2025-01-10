Return-Path: <linux-aspeed+bounces-387-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17646E77188
	for <linux-aspeed@archiver.kernel.org>; Fri, 10 Jan 2025 11:48:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YV0K446Z3z3c9w;
	Fri, 10 Jan 2025 22:48:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736509688;
	cv=none; b=i1ZJfFiB67IuKjYX05adOqOlAUr9aYoiDvRbwdjyP9kJRlagouICENDnASXVdtvYJCTr7aanchk1RmZtYbfZjNAN0Gc0lZfsXqYMCWqVD1hrR84n2phrneTPSn6gUtdyjMwZZi1Vc5DIxmJtmATOXUg7U+nAwtN0kVgJE7f814llM4K5P+lUGUkLHRk5cKLsBMm79DUpR8o5elrhDEQOc6PX4TDRaIiS5Q5FJmBExZvrbw5Vc5empDDxCSu+Oi229HxJA8DN6gDHhC1IIWsOKD+srpf4XRNXApU/0oGhs/5rxO8B05gV5DI3MYXREo/GYLbdojbswBziDK8nJuefkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736509688; c=relaxed/relaxed;
	bh=tFRw/+58ITVuLNvlLKTfpJf5G1Rh4TJJMDSpDyZ7jpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I8Q67USuscw1snqv6i+9tYJn1AOG0lTrGNJ57duok3p9f9urwKz34TRWgIrf1bcf9tqL2D4Z2wrR9UWN0jdd4PLULXB/08FMx7IR11FGYhQ/34j9+Sdlo+OAGMNcsbOwy2W9bv5xvBfe3nodjTUK04GKHeKBart/CauIJTXgJ+3yNjPDwdtvNVk1k2hAkm8cztdAEghk9mJqghdF9D5Zx93Ncfj5aQIIb65dEEjJDMJJzwfTwAGdQXoujFMZmfmD1r2AcN+ery0nMZjRfWBxcm+6ETtA5YlES+jm0b0pN45WKVVkgPzwM2HWoS53wY6LauLIF2eyBcyT7kA7naA/UQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=G2QTRWRP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=joel.stan@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=G2QTRWRP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=joel.stan@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YV0K24hscz3bWP
	for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Jan 2025 22:48:06 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-216401de828so30906525ad.3
        for <linux-aspeed@lists.ozlabs.org>; Fri, 10 Jan 2025 03:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736509683; x=1737114483; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tFRw/+58ITVuLNvlLKTfpJf5G1Rh4TJJMDSpDyZ7jpE=;
        b=G2QTRWRPiMN+ky3scoePCj+7nfnsJSHoU4RAk47iDxU0+Jph9cdHcAyo9uApQ3uxfX
         zi4Edbv+1fY7+PmZBFPptOioUY3WFi2emdbgdomtXLoFi4pUePTWMSv5FoAzRKRuoMpj
         KcMLPr+AX+0EikcHKALCCFOnr4qk/Z3WHselmMQtR2oRERAyF25QDJe6535dsrmCr4YC
         O1F/8FpGOi1VTDTqEgo2foyF/NdCtUTKT1Ltt+Rn4BDDqTgbwAQ4J/NiUJl4BxtaJvRY
         kpL1ENarYlagvZeZWHD9yNnxRqPJ3XTPt4QbeCEt/9ww0Jaru7lVu+JdkNYpalLEj47s
         OAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736509683; x=1737114483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFRw/+58ITVuLNvlLKTfpJf5G1Rh4TJJMDSpDyZ7jpE=;
        b=hhSNkZPdx71hCRZ5r0YSh+0ys9pE4rqe7GnG5jzkb7hBI3A6AzMEmIsoB3/T3b4E5W
         H4GErhX0mNGXHvItBDEP7ztlWnhc14ObP7tvFlqmcyVBOEjYRckRpt64cr90j6wZ16g4
         Mn7IV+CpXQVUFBuPkRFOghGCls2lhATDqkDdyFKQp1A4HIPVSlFz5qt2O9enr9sFqlwU
         mT2k4mxUhAvp4suhVSKxQjPb/mTg2AGtJgKeTC7G2MUavMHhrwlY59kEIH7RFyluwFId
         uiyfsBr0THA866FElHfdwoDL7LK8VLjlhSFiF+QxmJ4jVYbwyVTrWMKLLVk+Sgc/mx/W
         iQ7A==
X-Forwarded-Encrypted: i=1; AJvYcCXhSvhXpnF9K1Z5Bstg9d/If8wpbz5jdGXHQxPKit+wEfJa2Pxh+wQTwLFKbkhrgQWDfXPDRUWyObxdWCc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwOE2lUalyPsnsuOvcpHJytnkzaFJYpKKUwJXFXHZ88k3W0UYlK
	dcPxG8ih3zqoh/XBBhRbXtfAVy7z0zIu2eQXlGdgsIqWl3clxruH
X-Gm-Gg: ASbGnctdpZh3M2fBQ5h/Jkd5Mq9DsiY26o5lO9cg7+CkBr6mOa/JRV1tzRexbZMgZiR
	AR2wzRC2A8ZiCFyTongtgJONeFeFEiO9KPy+0TM8ZFFepDT7JQJDsfAL9/eGi8wHHUrC46SXJbn
	uh1gsxQGLBTv3UoWPTC9tioPOJWd1DPIoxMALOzUaOM6oA+0oT7VDrjdh8RTv+lwUkeAt1qN2Rs
	UsiKcLxAL3ETFFIv9lBfIIy3AZZVySD4gUZdNXf8Wtyaf6NrfbS
X-Google-Smtp-Source: AGHT+IEoGoXXspj4Ewi9299VG6sDT8BkazCSMsMCMlPvlD0nOLBSE1QJDy/r2MIF9gM2MkgFwMybmA==
X-Received: by 2002:a17:902:da87:b0:215:a96d:ec17 with SMTP id d9443c01a7336-21a83f4d80dmr162248825ad.14.1736509683327;
        Fri, 10 Jan 2025 03:48:03 -0800 (PST)
Received: from prometheus.lan ([45.124.203.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219324sm12560905ad.127.2025.01.10.03.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 03:48:02 -0800 (PST)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Billy Tsai <billy_tsai@aspeedtech.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org
Subject: [PATCH] hwmon: Fix help text for aspeed-g6-pwm-tach
Date: Fri, 10 Jan 2025 22:17:36 +1030
Message-ID: <20250110114737.64035-1-joel@jms.id.au>
X-Mailer: git-send-email 2.45.2
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
Content-Transfer-Encoding: 8bit

The help text has the wrong module name mentioned, and the capitalisation
of the title is inconsistent.

Fixes: 7e1449cd15d1 ("hwmon: (aspeed-g6-pwm-tacho): Support for ASPEED g6 PWM/Fan tach")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
The naming for this driver unusual; other aspeed devices are named for
the soc name (ast2400, ast2500, etc) that introduced them, not the
generation.

Additionally this driver uses the abbreviation "tach", while the other
uses "tacho".

 drivers/hwmon/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index dd376602f3f1..9afa70f877cc 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -413,7 +413,7 @@ config SENSORS_ASPEED
 	  will be called aspeed_pwm_tacho.
 
 config SENSORS_ASPEED_G6
-	tristate "ASPEED g6 PWM and Fan tach driver"
+	tristate "ASPEED G6 PWM and Fan tach driver"
 	depends on ARCH_ASPEED || COMPILE_TEST
 	depends on PWM
 	help
@@ -421,7 +421,7 @@ config SENSORS_ASPEED_G6
 	  controllers.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called aspeed_pwm_tacho.
+	  will be called aspeed_g6_pwm_tach.
 
 config SENSORS_ATXP1
 	tristate "Attansic ATXP1 VID controller"
-- 
2.45.2


