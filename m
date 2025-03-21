Return-Path: <linux-aspeed+bounces-1120-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A321FC3600B
	for <linux-aspeed@archiver.kernel.org>; Sun, 23 Mar 2025 22:46:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZLWWR09M3z2ySm;
	Mon, 24 Mar 2025 09:46:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742560785;
	cv=none; b=mz12oViuqIunJ1WHGYZpUy5MBF+z1yHL4/lB/t10VgXQM1TM+yhiZlR/tn1zpyhgjRWRoAXGAp+rfnSKgRavEkMBu9yY6X1/DXHQ+7j+/wfbftffztQzIz+F/1bUywrmM0DsMv9h9RCswLmQ3masbWd6c9vPJ7+iAm44IAjyyuuIquGSIUIwZLaDhiHkrVanDaX1xYfRz3Z1QtwqdV79L70KWyx3y6oU6Aww2KpQ4t9k/H/BtTHgzY1Z54X7Wvmz1KgITnX76z9XTYee3QH1c0ViCwDsNo/7Jqjj4kGiCjtlX27gcmhBLbvR7b41iq1IjIMwPKhx9sWdNFJ7UsacwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742560785; c=relaxed/relaxed;
	bh=lX+j7ZByvLSkPBbGZ8e37EOuRyaPsfVXExUNogWzc3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EvtEup7SwZc0Ubeer2Fvv9H6GMiP6sc1kT43yrpSN41llJ4HMM34F28ygB+ZRD2LOey/lteFeh2y3z5Ik89i3JACMrExfieDuAvuFehx8B637cNkhvKzOJ4TUJwPYvdL0SQUtdsDSyFMTdGKEJXPTPJ+y3T2iq/wK93oa+AGUOkRCCF8OnhzIkvSAyS00GwaSRQHMWTpdxuYcYNrhNafulY5nLDZSqyCfoymuP3UMY7AHzRx9gDnecywKnH/3WmNByxmy1wfazGr5kz3YHmPaB2buK3K1CAE/vI9ybKYWETeP3gNu2nSrS/epf+fGzLEVjpGbTxW2QxrYChPBJX31w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JwNoWupV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=jasonhell19@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=JwNoWupV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62a; helo=mail-pl1-x62a.google.com; envelope-from=jasonhell19@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZK28H6XXbz2xd2
	for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 23:39:42 +1100 (AEDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-224019ad9edso45758855ad.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 21 Mar 2025 05:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742560781; x=1743165581; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lX+j7ZByvLSkPBbGZ8e37EOuRyaPsfVXExUNogWzc3E=;
        b=JwNoWupVo22XvHH4SOlkkXo+AoNYlY/Zvq7iwcBxW4UtPreLwxIMyeeAhkyi1A/S6x
         8MvfGGTZNeSxeC1Mw8Lhj1ugntyaKWR/W+hW8iPOhjMJ/76pz3tI0Y+m9chRMjia98Y1
         9SeCxI2Sc3CCQEfjlrKbqjhYEMiVuTJbACvcHZI2PG1c3lZu3+nFRa5o08CU3axFkQ8b
         6C6Ge30sjZiC+XbHFJlKqHuR97NurjIwxCMEHa9KQr939mzfnLxOBImI4tOjL+8jJ6mD
         3zZnjEm6sglzZpkLv92xTMpqZWJPT4AIOGIP2ci4oSb0coRSbBdwjVhtZpxMGyETepde
         PmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560781; x=1743165581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lX+j7ZByvLSkPBbGZ8e37EOuRyaPsfVXExUNogWzc3E=;
        b=SfxZi+1frfSGoBJk2KE0/BiO+AN5gQwR1fI6SEqYZaLcYXTLFfnvyJE2LI4PaJ1fxo
         8cF3+1j9bSBM8ggpi0zyUBElsSbXhrcIEpPcEvI4xOwH9SkypAHBAMSpxgzYfuFBFeHt
         crfY937t9FvW0QwREmcUkdfy65xniaa+VNp3iZSOLTcMM+QvlCRdVfwuT+m/Z9TvUSx2
         o9esXr0i1PXqbWfAUnMsjZCP6eUrZfYvHXnLAMbtN1bVWslaXiB+Z4XfaNq5eQiQhv37
         IoS5CSwjgEk2sXBuEvS6FTdpmW7v807O77AM+aOGtqsW28fRFjA7QXNVJ5wkDGeJrlMC
         KKOw==
X-Forwarded-Encrypted: i=1; AJvYcCVZTdqiws86EandBaie5rAr376G0y44dxB8joiTUhvqfne/c3n4XrpNlUjgZpDELLTGjvnoLG72AcOGg0Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzJ8j+LrV8UAVNgc64P9/GvqEa+LRb46PSpllVRGmfYFymBUVZf
	YgH7D0uHhRBQZvX+jUIWFrA8wZThxODCup3mdyqq3tc2gXlGlsl9
X-Gm-Gg: ASbGncv8ZVo73WsQNsojuhhuVk+F1tHdZAWfdQu0Eg0C1roHapWr5ntRHz73IwAtg/a
	SENve29aGVl8DGZK9mOVdq5ySbcSDnsGMfXXUyshbmGpkwiSTTgDvaPbh6RRbGDkKxCskTT6eZh
	EKE97OMZi3Vk39Rh7NSKGqlEi5PB/IWgPqVvT1DaBsxSMMinBtSX8wnCJJk0vpubrZHbDX4d1U3
	X1dYxWR3JOezc7CUuNt93ZHqnRsi/JL5+zfjWLSscdKT8b6F1L5dhOI1sh9lfpZs4RPzaAO/Ha8
	jgQQCjllmrjCaCD/VOOZwC20myT9DhVLdp4viyl0ReJjT+LNGznrt4qetCKo1Zbz4LpCCO6DVkf
	TkAjdWFEXgxVIx5mOGTuq1XAP5Q/aaH6hmQ5YH38ba6kJmMGuRQDUCLubOSM=
X-Google-Smtp-Source: AGHT+IHId0CD+P7qvQUeVHlIxcs9d9bWCjTq4tyT+oN5nat9T4lYmUbkwkbTDc4O4exXD2ol31Q6kw==
X-Received: by 2002:a05:6a21:6e03:b0:1f5:a577:dd10 with SMTP id adf61e73a8af0-1fe43437119mr6748664637.36.1742560780747;
        Fri, 21 Mar 2025 05:39:40 -0700 (PDT)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd5c90sm1815432b3a.51.2025.03.21.05.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:39:40 -0700 (PDT)
From: Jason Hsu <jasonhell19@gmail.com>
X-Google-Original-From: Jason Hsu <jason-hsu@quantatw.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	patrick@stwcx.xyz,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: yang.chen@quantatw.com,
	jerry.lin@quantatw.com,
	Jason Hsu <jason-hsu@quantatw.com>,
	Jason-Hsu <jasonhell19@gmail.com>
Subject: [PATCH v5 0/2] Add Meta(Facebook) Ventura BMC(AST2600)
Date: Fri, 21 Mar 2025 20:37:29 +0800
Message-Id: <20250321123731.1373596-1-jason-hsu@quantatw.com>
X-Mailer: git-send-email 2.34.1
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

Add Linux device tree entry related to Meta(Facebook) Ventura specific
devices connected to BMC(AST2600) SoC.

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
Signed-off-by: Jason-Hsu <jasonhell19@gmail.com>

Jason Hsu (2):
  dt-bindings: arm: aspeed: add Meta Ventura board
  ARM: dts: aspeed: ventura: add Meta Ventura BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1399 +++++++++++++++++
 3 files changed, 1401 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts


base-commit: b3ee1e4609512dfff642a96b34d7e5dfcdc92d05
-- 
2.34.1


