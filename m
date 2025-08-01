Return-Path: <linux-aspeed+bounces-1882-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48733C87FCB
	for <linux-aspeed@archiver.kernel.org>; Sat,  2 Aug 2025 03:14:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bv7GN6X9mz2y2B;
	Sat,  2 Aug 2025 13:14:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754057501;
	cv=none; b=B7ECjBk0goxSU8nUElXYfz2ZBp3QpMYoxp6UBSHutjsnnaFGKPvfZR3nEcpCly7bp780iM+DgpPe14dXEtYOzDVjOJvx2o0HdZNmhWX+T3t90UqTqrmFjJ5CrMo3lnyAjR/hy6xR/ULMP29iXERW4VcWsMDRQlzzbDlKNnXDDyv577WpbCcAcvLLV2rprT/v3ODsnf4GbjvbOr4+Vv/Zeff1IoLT8LzXl8wOygz77yVIRDzN5yXBN7hoqVRgnaipV3rbh1ce3ARzb2nz87N3B/KkvOoEIcGWV8m/qY1LNvHSRmwMEudlAj+AQ+6NLPCGi3TtrYOX97ivlpflBP68Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754057501; c=relaxed/relaxed;
	bh=QDlYysWEDC9bsdNUriekyMCwXLSh3PKSI3dkxy/uoG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eLhSyc672gbiT+xEyFk6tjzz1vGTZjKd1AwMUvgDqAmFofUK+18iLaBnEr8Oy2GJLscVTMZDhbQxOCXWIoBEDjESTJKV2kFDoPtzkW7xV6EQoj8FsFl0hYY6I/4sYDPM+a8ea8fnR4+InelWuYbb9fFBemfIzq7xb9N75so7i1SIZUpB3Hr+MJ/HIyQSPJim3+74J8eqmQgkfetdSOBEqIpc9naZrOg1FvfyCXOTYR/Af4OV+YFwTXkjoap9iI8LIrOhJAly4DqTwcfAIbBVTg3kjXPLqPra6I8hcp/9XDRAVrjIG7Jhlrfg3bCJWWJ6pHKqxU0nqtOJ4npmo2OjHA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YzA7tCJa; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=YzA7tCJa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42b; helo=mail-pf1-x42b.google.com; envelope-from=pkleequanta@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4btnv03M2hz2xHY
	for <linux-aspeed@lists.ozlabs.org>; Sat,  2 Aug 2025 00:11:39 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-76bd7676e60so752314b3a.0
        for <linux-aspeed@lists.ozlabs.org>; Fri, 01 Aug 2025 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754057496; x=1754662296; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QDlYysWEDC9bsdNUriekyMCwXLSh3PKSI3dkxy/uoG0=;
        b=YzA7tCJau4zNzkqJr04K0unn2Re40AQtJZ+GmqxgAwT4K7sD4Rvxm87HVhT5pNHSE7
         DDYUS6mvXYtL9NMWbxXvH/BzWnKqV7aLzZcNHQPnByiD0iocBzJsjB5aRp6r9o/g5viP
         3cSSDQOWGL+lUQVV8nZOrWPGopZFT+a42FTWN/WKK/5xdNTIRzenNFJ9O9vvRt89G8Ve
         u8ybaCZ/FlI2BJ+TmyB1PekaM0PLTuQRKKWUZl2DJ9qV3oC6FecMzj6UEprNdOKEmbC5
         cJArU4kzVuYr/pB+mPJjdvQ/3P0JZrdUnjfPd69p8WM63SMF2+idZVybUJG7q2PrHkTh
         TG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754057496; x=1754662296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QDlYysWEDC9bsdNUriekyMCwXLSh3PKSI3dkxy/uoG0=;
        b=NIgGcTMkzi4nA5hEHkUjbM0kzf24THmcaaOuoicqgCJTls+AQOUYw5MAquLEO+I+Fi
         goWjej6HNGr9SP3mtzaYUDPUijRS+6J2CVKmx4osuNyFAlfqPaDnsHTcx2yCV4zsGDXT
         ZVA+nTmanZ+zui6TUJbbEefk1dApLb0gTF9pu1bB5TlKejehjbf4JZ6CY5n69YCsAX3g
         XmVUAPFCnv7UGnKNVrbH8XECj0WRcbJWjbMtYWJ1J57k4ZAHeiNf4vKSbDj9wsBsj+2t
         HcmaDzo01MdLcDgox9IeC22w1Adf5uE7lvRzM12DrHXaLL5DVWMHfD4U35p0O7rU5mYl
         8NiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRhWLmCVFaAW8yJGQVUJLMTejbEatmVM6OU6i95etZB87tfsHxPL6a4QKJgoihrwusyqrCymTsV1Wx4rg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyYJsp7HCnx8NN274Rwly+TpbYc2l+J5VIenPz4j/FXNNV/JcP1
	XkLfQV2B7LK87TPsbJEvX3Ft5Fsw5QEdhAzaJba1Vxwcaj2qyo7D+env
X-Gm-Gg: ASbGncuDmiJ3AVskAu+XnSDJkRngTgxADrvgO/6p7G+9KQ80ZhBS+squhI2gx5eFHLg
	OvHw9SotRUtOICn5opqv0CzND3gy3c8dfouu5PRRgG5jkm0AjoSDx9BHX0JzYSXNAAQ00RTCpkL
	re4iKKSDvwef9oeS6RDrwCxcp5CbqgraVJDtUTQrCsT+zZyeJcJjSzMPGk33tDeAApfu/KrP8pC
	TZpHl7Wi+ebUzuZxg1dbp5XioX8uT9S/pl36x70/qRJy53jiBPxlzl4F2ytE5ag7HpKlr/ORRfT
	RLjdrnBV00zsMW6jCSf1jq8V0WCy7diWYAcBS6dh8g6D4bLkw0Ro0b7E1pC0+ERqiponQvVH1MS
	3xvjjdaYZKNPgHvaSpBZa4FEWsi73aXMh/wGXTHSwY5zDTw2Ecr7rI0gA2RIjCnaLvvefc/yUEw
	SDdOM3mh9R
X-Google-Smtp-Source: AGHT+IGgtdwqNeqGthVbBLzr/jwmqUMgf3GK98QWSEdaavZ7/9GNEF8oAglRAXDDwnehneDYPluCUA==
X-Received: by 2002:a05:6a20:6a1b:b0:232:1668:848d with SMTP id adf61e73a8af0-23dc0e445aemr19952336637.27.1754057495754;
        Fri, 01 Aug 2025 07:11:35 -0700 (PDT)
Received: from pk-pc.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422bb0db0fsm3849984a12.61.2025.08.01.07.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 07:11:35 -0700 (PDT)
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
Subject: [PATCH v10 0/2] Add Meta (Facebook) Ventura BMC (AST2600)
Date: Fri,  1 Aug 2025 22:11:29 +0800
Message-ID: <20250801141131.2238599-1-pkleequanta@gmail.com>
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
P.K. Lee (2):
  dt-bindings: arm:aspeed add Meta Ventura board
  ARM: dts: aspeed: ventura: add Meta Ventura BMC

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../aspeed/aspeed-bmc-facebook-ventura.dts    | 1578 +++++++++++++++++
 3 files changed, 1580 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-ventura.dts

-- 
2.43.0


