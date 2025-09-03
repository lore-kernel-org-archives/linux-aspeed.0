Return-Path: <linux-aspeed+bounces-2139-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2072CA1010
	for <linux-aspeed@archiver.kernel.org>; Wed,  3 Sep 2025 23:42:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cHK0G2Xl0z2yrP;
	Thu,  4 Sep 2025 09:42:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::535"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1756901172;
	cv=none; b=guOHFm9eb/hA+lvbLs9N7URPQXhmgr2DVDX9QXCNvrWtu7PUC7c3K7onbXvnvQwQgIY496nOb8rUghtdUziTQ71BTfXEmKfLBAfrdUttcIsfCydeSHfXUPlX8KIDLesQYcyEF80/InlSLhwQDfEXg2AISUt0U8dZrUzP9T6h4FhV2UpZJHXhI5h3NW53l/Qw9KYkEpwJty2Lr/JuNQW1Z9oUxSg7qHtfvUOazbLXWgInyj1TqQ4EBnIgev96HB0ghXDAMT6uEzzuG2/QjHtmfftojUyINAtSGECBUbboHT+yxvW6VjKw16KJ4zfe7rKboW4HqN1rEeDAeeVDFwupSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1756901172; c=relaxed/relaxed;
	bh=j5iEAlc4MoMtFJUAvR6dtjmQqf3jvqvKGSuRvb2CExE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e7txoh2sEtIiqVBuxFViLq5cNjR/4Kgwl2T5SVkFOrtm6WRJOaYxSUKIW8Cr1fqH765n3k+pcZiLZbcYP1AYUJSNw7a4fZFl5LELZ42ZDnnCaqTLwb80WTpIJVJ8DIhWKDcaJF3dP2Y5MC2qNm23FKGkb5CeIprbMjS4hKUNXOSFzlu9W+JVL5VGVUh/BjYDRRnTZi8qM2v+onzi5+oza6IzKIjzXvVy3g/V9kYhFp9w8SDlIQb+Tgp8l+vz+HdTo/gineAxod4+O9tOlaRh3x2pYfU7q6umkk0BwaSAp3gYHS7JRnS4NQeMbteDajCmtSUiqxypcMPgokoqfHKPag==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aSpVGqEB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=aSpVGqEB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cH1Xx1Bylz2xrL
	for <linux-aspeed@lists.ozlabs.org>; Wed,  3 Sep 2025 22:06:08 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-b4c72885c8bso4696679a12.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 03 Sep 2025 05:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756901165; x=1757505965; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j5iEAlc4MoMtFJUAvR6dtjmQqf3jvqvKGSuRvb2CExE=;
        b=aSpVGqEBRFFNkiBcYTJYLgqYE0Qwo8ImPGiNNR6tbrw7xTwbl6J4/lUpT6duapssid
         3N2Kagq2lHLTlmYZFSrmlMGOAAqxpOxVP3OIHg7AcvDaIodF+ZK2QzdxTu5Ds3RP+ao9
         w6BT7bW4Kpm/bm7jCs5qo4tqqoDV2ZfyDR7FIZ07fc7aDhzm/0KQwM/7AGR91LxqoaXA
         V6GBMSNFZ2f9NHUsTf0Ib6+skJFHu7SqV0kDjO4z9PWTxlWyAy0pZwrIgzdIsooU09VQ
         8QWxxZr/ICo7s8ROLRmDVHDpHBtwBVbg+6NNLgZvi1vv44r0rvZDNDtW+5tVDyp9E4SB
         P7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756901165; x=1757505965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5iEAlc4MoMtFJUAvR6dtjmQqf3jvqvKGSuRvb2CExE=;
        b=PIXqZ56D9QQddW4SO51Jr8IjEJlo5wlhd+Opzc0SuZ018axWNGlLWqiGFI4XvzyGE6
         NeNPodViiy1qkNG8DTUbWpTN5Fs1Tya6T5h6solI6yMNaz7LOgTp8xR3SPweNUfoJjX5
         hWjGHQ0DOxKiOM9tyZ52ChuNZzshhG80KhXeihxU/OqK3i/tE2pBwnTC+oIyZMFI7xZV
         LusvMtNB836rXMGZYS/d+EdHCHVF8kaWz1n8BLxuUWtxVCA/mn9cO0drgbxJrEtlwKzt
         ycZ9LrQuvHFO+2V8G7bfxBoH4O08rsbdU+Wa7PQ9GSiukeAdu/tsPL4Rmk+66Ojfui0Y
         FBpA==
X-Forwarded-Encrypted: i=1; AJvYcCWv45z9Fr7g1VBqdQxmmohijrw0D+gmXtDDabQ2W2c3rNTT7XfYKGLlmgh/U2DPqQivkwJm21tKm+Vwv2w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YynM+jyD7+YhqQ2ZJyHQ7jbu55xJm1PhWHLN86GV1CuUfOA18Xt
	H2BcHn8308Y2a1whlArsbe3C3a9MaUbfm03E+UpmKDLbuxgWGi76eYZ6
X-Gm-Gg: ASbGncvLQECYu+EeppzTRgrDvA24oi018k/8vLJNBcASSI1r4U2acqIsx0xdvbMme3G
	nj/8lh68cpHRnLPlGGc/5AnKQEC1H5zrRuwfnhgvDGRnEELSZjlkJGSTYM0DNl80EmFAoOrzg26
	MszXAZeJIk0c1eRxfVMWo9br9tTJNyLEJAVRyrW6NQ7kttCoBxGUbHJARhVNv7AsOYZjjWzBK4R
	qeMYYcvdCAICh2ZQiKSbvZ306FhzYWKfePMuk0BHEm4sDw0+nVpoiHyvZuUWDEU9zjBMaw6F0v4
	0ERTxvRUVIXQ4H9Bvhf1FLttj213HYPwpSWHuWh+hQuMUGbDkhPlf1UU7zH9PImL2GwTKayseKk
	gYty91DCP/TdcplriAg1UKm9zhglIrZDSGhvhexKld/jYEm5YNcz45Dyfx8tvQWS7nIS8z2h71V
	DAIlTH/Q+/PU+INp54CTeRlJxti6Anaw==
X-Google-Smtp-Source: AGHT+IGmOK+zU4uhlF8L1/G5THkM81+gGkxdGDOsluSdhqpOhIUayM/TmHmVlI5g8VrEuAb6A/4e9g==
X-Received: by 2002:a17:903:2383:b0:246:570:2d9a with SMTP id d9443c01a7336-24944b1fc6emr204959945ad.59.1756901165063;
        Wed, 03 Sep 2025 05:06:05 -0700 (PDT)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490648c89bsm160905185ad.109.2025.09.03.05.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 05:06:04 -0700 (PDT)
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
Subject: [PATCH v11 0/2] Add Meta (Facebook) Ventura BMC (AST2600)
Date: Wed,  3 Sep 2025 20:05:58 +0800
Message-ID: <20250903120600.632041-1-pkleequanta@gmail.com>
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
v10:
    1. Added IRQ support in GPIO expanders under i2c10 to handle edge-triggered
       events.
    2. Reordered the nodes.
---
v11:
    1. Modified the position for i2c3mux0ch6 and i2c3mux0ch7.

P.K. Lee (2):
  dt-bindings: arm:aspeed add Meta Ventura board
  ARM: dts: aspeed: ventura: add Meta Ventura BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1578 +++++++++++++++++
 3 files changed, 1580 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

base-commit: 533cec246f7f0ccadd7d9fb4e664d38418633c6 
branch: dev-6.6
-- 
2.43.0


