Return-Path: <linux-aspeed+bounces-1389-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959DFC71135
	for <linux-aspeed@archiver.kernel.org>; Thu, 12 Jun 2025 00:01:57 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bHjNv0PWsz30QJ;
	Thu, 12 Jun 2025 10:01:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1749641342;
	cv=none; b=bbv4LQEK33gO410dIOsfV0x26K1MwDEPwHAyt9W0woDwZotJz6vVYLxSQcnTPdQOKVkoQYjSl1uIsQ+FXtY5Oe+RNmZpm6Zmp6CgrBEXO4IDatNCYbE2za93XGdCX/9s7pZJjgCrVRQnUYi7uUtIbvzN+8sF07UgUWxKqvTh5DgpSy1dC5p61MZiK5nCWPf7SLfrtndb+VjPCIZ5nuHMfnHEpkN7rTgxPhSx279wTU0y0LLSeVCNWWWK9Sws5oOWf5rsl4N1Dj0szHfJh6PAt6NkJMAlTxHl9ILME2rV1Rm5g+pfniagQugs8VngM6DVUR98GLVH/lHpsx7zMwcNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1749641342; c=relaxed/relaxed;
	bh=w5kLuTPe1ZjtYfZALE1yPZ1I7y31mtKy+cX6Moc8i2s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YIir4xzJcx0j4V/au7PAGdNYCsKTNvfZc5OfAd5NdFXJxC0RCQyujGmI1WuIGwjvoiuGfKHxDgkJ/814uvQdu99/jCFHYXkDxAZtNtCM9ACbW97p4/Mg3ySCqXbYMA6GEySUTLTxugVSff0o5GEyI13g5pilkSJMJ1c7bT/nRs/3DTDnF3fvOcV/9K0lslXLQEg124u5d1JdgJahHFFwG2lqix8emP2Xu2YM808Su1HvtiFFT6aRBVlFRJuKMAsewkg3Id65F9KIbdW9WnWRNXvajpHFOLumdmIPvCQRDJvu9s7LomN/vIvqK0+h1k0i07QqYte7gRQ7fWIAwsjthw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lNNbDqQc; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=jasonhell19@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lNNbDqQc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=jasonhell19@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bHNhs2BCjz30CB
	for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 21:29:00 +1000 (AEST)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-b2f0faeb994so6300052a12.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 11 Jun 2025 04:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749641338; x=1750246138; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w5kLuTPe1ZjtYfZALE1yPZ1I7y31mtKy+cX6Moc8i2s=;
        b=lNNbDqQcc/0tJWuDRoomiz3asBCntlIQDGmvZ+xHvAfdmRv3BqJ4tyFQGGw42n0JsP
         oznM0UFB7Ipzy/v/pkQlGKy/eXLBC7DRnmA7b/QNvPo6XzcKepeTCmWT3grxfO/ya3YS
         vga8yvHbeji2pclewJNJYiPiLuHah9+eDVMCPEIMv1w4WMrrHlIxp6Cbig7chC9jgGKN
         81BDtdPZdD/87TDyL99YXdF8l67Gakj7BE6z7ExsJJJi9AfCCcSNaM9goFTzT/tVepQ6
         Y5TDC+jcDvmIv3DuLP4APO1dDmvXzppVPD9yitAONko5fo7fDqiJ/parXh55BlTZjCDP
         QNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749641338; x=1750246138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w5kLuTPe1ZjtYfZALE1yPZ1I7y31mtKy+cX6Moc8i2s=;
        b=LlVPK642yInTC/5qyrkybxp3oYlWhF42jweeH4IdC3BM3NWVKMhv0I7+N4o4a4iWA5
         MLNlH1qTQGhz9KpOWeWBs9V6QwhDSeL9PoY65ScVOJN+HcFj7eGCwD5rhOBvqpIdaRk8
         iHvbPdZcK/1F/QFjp0OK6WwKtjik6oLKOM+hT/nkn6xD56zO/1ngR/3k5t+ZeKsEiBw2
         aZVRBp8dV4XQys+Ao4Lg4E2LYprfmji19snDyNV2giHU6aT0FFc4O399tBfibxwH+gfR
         6m0gtTPG+9DEmXxhyk3wFOq4RT8rams6EOTXLrL2Cold3c9zZKzRWT0yPxwF+EC/cH9+
         Cv+g==
X-Forwarded-Encrypted: i=1; AJvYcCWqlfrlLQJQwKHJb/FMErwuXI17dLuVT9SQRU0zktPVRlLA6jom7zocfEvAJveUmI2YhdDEgTIX8ieD4+A=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxvqXGnA2aXe9CvZtaIiL6a4XErkQOqgnVi06K+cp5bx6hpH385
	05gEzJh/e2qxLA1dg8aHfN/uodQM5FNe0fAb06dLLGV7PQ8bx6/vaJKn
X-Gm-Gg: ASbGncvg46qU6/NFQdZpb0vifmw2YG2VwUs/ptTjJE/OoFf2vzMPWyHx6PUk7lLhzmh
	tNVT+VSVgjFm96L1QnI6FkahDTX9Ge+Dth/o7FMg8thxbWabJ9AKoQkRZxWTsFnRTIE+1ouJ/m9
	0CmJxltSVHm3ftwI7SCJhUH2Zg7qgKG98w2t1/gSMtpg91Zf0ch+z+U4ren+U4fU4HgIhEppW1F
	MRLAhjIsoYPJA4T8U0X3f710rR5sFgO1R5lXZwcW02FaQqf8HY/den0SkNwH3CbP+OiKY0bYfMd
	1h+HXaB7wFZxDYj8OtcoQB9D+QYuvgbTgv0n5RJD2BVjF+h8mLc14wwAu2VfPIvrc2hcojKo9Ct
	9n1M0KaBgx/MJy5vC7oYkY7yXDsoXHDwnRA/9EY7ciQqCXtYJSBwDZIoSPSlJuSvG4f3A+80n4I
	w=
X-Google-Smtp-Source: AGHT+IGWw068vvXp3+yEPF8FPf8vG5yufFWpaOywJh8DgaLYGGbghT8z+gqFAOziW+6BeSzW7/P0rw==
X-Received: by 2002:a17:90b:584d:b0:311:c939:c859 with SMTP id 98e67ed59e1d1-313af28d147mr4395082a91.30.1749641337938;
        Wed, 11 Jun 2025 04:28:57 -0700 (PDT)
Received: from jason-System-Product-Name.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313b1fee63asm1082246a91.3.2025.06.11.04.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 04:28:57 -0700 (PDT)
From: Jason Hsu <jasonhell19@gmail.com>
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
	Jason Hsu <jasonhell19@gmail.com>
Subject: [PATCH v8 0/2] Add Meta(Facebook) Ventura BMC(AST2600)
Date: Wed, 11 Jun 2025 19:26:48 +0800
Message-Id: <20250611112650.595554-1-jasonhell19@gmail.com>
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
Precedence: list
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
Signed-off-by: Jason Hsu <jasonhell19@gmail.com>

Jason Hsu (2):
  dt-bindings: arm: aspeed: add Meta Ventura board
  ARM: dts: aspeed: ventura: add Meta Ventura BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1481 +++++++++++++++++
 3 files changed, 1483 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

--
2.34.1


