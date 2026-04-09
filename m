Return-Path: <linux-aspeed+bounces-3893-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8095FF45A1B
	for <linux-aspeed@archiver.kernel.org>; Sat, 11 Apr 2026 02:51:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fsyq24hbTz2yjx;
	Sat, 11 Apr 2026 12:51:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775734840;
	cv=none; b=DBq8tPdRP83qTawy8gjxEDZOwUKgUgZOOnDEPra23qqrihnp6si1eVFwsVM54/Sz+qx5YcTGw4hlNbT5yKa93TqZTgm85jzdH4PRhqx47WX58tB0z6GTtzsVQXA6eYb0QyYaii8B5nEfaojz0w/1571rz5/TJ0esxNCvIKrl8whqfu24Ilu5rO24YI8enqSAVkHGr/ZHHrvQF/AemOTXWCgO6Lq/3ICmdJfdwz9Z9mKx+i7wKhKS2n3ep+kYVooG10tM4xZhRjn7rMCjl/C+aYnDQe1yqeJGrbuNWI1lrRKn2dz8pL7tQmYhrco5nKAkaksS5aITGa9Tm1RhEKWdbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775734840; c=relaxed/relaxed;
	bh=Zh5N/EtZAnkI3b3uPP4/1FdnrHwMSkE/EVd51eSrmB0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DTwsQWiGl2aUNguUuYpn7uUEOuK20q7AJa8ThYlMEQ1mklcFpxiZmjnAbHj4W32cSvxuwAp+gUTy8XvtTPr/f17kJ5bZ2NznzmrgXbLQvX4IC75ZA1CONOOl5a8foTvQtyPFYqZ7fco0mhfY61PbmvgP/5pfdsMQzJnAuoXLaa9M4J7Wyk/c08U86BfflHMHekb9+q6gO/ES17DLGzvXEAQHtAbocnfOuWBKXJOqnPhW+BlAjjpnSijMPiOQounhT7oNrCS3HeiWdwhaOkHkYoDs+tN5+N9FeORZHmhGukm2/3FdTkWmvdkRG7E2Glf5d+vZelTnno3/Msoxk16+kQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rSpMUi+8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rSpMUi+8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fryft3V5xz2xGF
	for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Apr 2026 21:40:37 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c76bc3e8de3so403164a12.2
        for <linux-aspeed@lists.ozlabs.org>; Thu, 09 Apr 2026 04:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775734836; x=1776339636; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zh5N/EtZAnkI3b3uPP4/1FdnrHwMSkE/EVd51eSrmB0=;
        b=rSpMUi+8+u4pZl6cdGBQTgRsPy8XlIn1ulGOcWOAbkdDgBqHLExkJabsXDSSFN4dzZ
         MY55UMnu+7aO4IpQDRiylmWR4gJst4J/NpR6FEZn2aGMDZUafTIwmrIuSDpvvxU5jaKE
         dcLD102pfog3HKSTVb2HbiNktLW1soqSeMwmZhvoSRdXB36Gp0ovGIftRo46VytyefYd
         tOm9nKWKmKJCwuZ2ZXQ+9CK2RsX6iK/XsZmMNyG26WHOaO5Z1qDLtsNESu2SSoQme5NP
         ptBsEBhCJ9c/7aF/hDSggVb+GG23FLL+YyFAkc9j3epd3d3nE/STh1x4jBruC3BcPDh2
         eIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775734836; x=1776339636;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh5N/EtZAnkI3b3uPP4/1FdnrHwMSkE/EVd51eSrmB0=;
        b=k1U6Ye2FjsTfPFka8jBDVGUzC4Z1v1upLW1Q5qXcDIPIuqaLzaeGgm/2/nhcMSx+OE
         epHv08EtiHTBmyzBGqtyaXtFNQYmNpLFiI/ea8bKacdLieGkf4CJTRJ3W4Z+TcImQ4t7
         meiYPxcEYBUBqMy1WmzrdHfXItD0JaoAuUifBPFAp7FrLx9mvuBTc+enF7xkmQsSgZPe
         m7/MkvPOxyKsmdOC0v2GLXsQqeZ3WPyjWjO5Al9s6B1AAzd09RpcaSA1Yu9pfeDcEnLF
         6Ro8L0uFApX29N6mEHPKQiQGLQ+BosUzvv/UclSGitzFe1pUXnMT5NXpsezT+JNMXcrq
         r08w==
X-Forwarded-Encrypted: i=1; AJvYcCVZHglEOBZJPO8YpTaUg2+rJnnnz7fEg/cnOsAdQvGP5glGQpAQdtGuFkN2lUdZlikUiEcWFD9brqIarqA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxSqmfWaBwBrKczFV9krY4zFJKTP8ViDU5dre5fE6MFFTapmCjT
	qF3D3PZFyXhsyUn5GgoqcQ+PD1ooLyB7F9iIKrcS57mRsXkAenuU4z56
X-Gm-Gg: AeBDievfQcjUM8QPlcpA7DBgtPFQfOu6wRS0Jy7NsX+H1Zt2DcNpQOvuFohuYpWptGb
	Ayv48zTEaIKOWecSkexZrJXMwEfuq9mEeSn1k6RNRmlZwbF1v007kFphGmBpdhsnoQMSIIfvPp/
	INTT+ZAc1abh/K0AnvGuA8T6n8NrklwPeVSMYiTVgtfXgr5PKITeuiAm2HrAZfhALbY8CSE3i3f
	9j+mzRa6YpYPKF5ZWOzxpbHFCtuY/lmY2HaPoFXsLPvuGpFp02Ak1CPN1aUY1qmnVD3RWga9K4l
	dRfgyjh3O4jXWciaG0Iw8uokSP7CPCiGkcuP6CsslgKuXmYhPFSHVVPlsSJmhjnMzPUbm6NeWGY
	7EXx/Tm4UPRNpsKOrgCrBV+IvHys6ccxFoeHZ3u2kZLu3FRRVWvFtjvNBduhcqLkgV70geNx/e6
	OSw5mEPoOAdgtUhTG40SkA5GjBJd+MYA==
X-Received: by 2002:a05:6a20:5493:b0:398:7b1d:87ce with SMTP id adf61e73a8af0-39f2eff45fbmr25361404637.20.1775734835570;
        Thu, 09 Apr 2026 04:40:35 -0700 (PDT)
Received: from [127.0.1.1] ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c659a218sm22438545a12.29.2026.04.09.04.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 04:40:35 -0700 (PDT)
From: Colin Huang <u8813345@gmail.com>
Subject: [PATCH v2 0/3] ARM: dts: aspeed: anacapa: restructure devicetree
 for development-phase
Date: Thu, 09 Apr 2026 19:40:25 +0800
Message-Id: <20260409-anacapa-devlop-phase-devicetree-v2-0-68f328671653@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIACmQ12kC/43NTQqDMBCG4atI1k3Jjyh21XsUF9PJqANqQiKhR
 bx7oyfo8vkW37uLRJEpiUe1i0iZE/u1wNwqgROsI0l2xcIo06hatRJWQAggHeXZBxkmSHSCkbZ
 IJGuttLOD1QaVKC8h0sCfq/DqiydOm4/fK5j1uf7/nbVUsmvfXWObFgHtc1yA5zv6RfTHcfwAy
 0ahMM4AAAA=
X-Change-ID: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 colin.huang2@amd.com, Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775734833; l=1564;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=Pg8rh/1N06LCkEAo+E/4op/VQofrZ3aTQo3V3dPJNZc=;
 b=IhfZ12vZLAF4bC9lCx0x1Ypn7QQfx+MuRC+ef3Vi5brqRtnqHUJXPpV1nC9g/X36yTWADDrqd
 DP1N+M7USURC/AICWLXes8L8FVHTvX4yVtfqSgm9OjpLf8eYCe5aE/L
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=

This series refactors the Anacapa BMC devicetree layout to better support
development-phase hardware revisions (EVT1/EVT2) while keeping a platform
entrypoint.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
Changes in v2:
- Fix dtbs_check fail.
  Validated by following command:
    make dt_binding_check DT_SCHEMA_FILES=arm/aspeed/aspeed.yaml
    make CHECK_DTBS=y DT_SCHEMA_FILES=arm/aspeed/aspeed.yaml aspeed/aspeed-bmc-facebook-anacapa.dtb
    make CHECK_DTBS=y DT_SCHEMA_FILES=arm/aspeed/aspeed.yaml aspeed/aspeed-bmc-facebook-anacapa-evt1.dtb
    make CHECK_DTBS=y DT_SCHEMA_FILES=arm/aspeed/aspeed.yaml aspeed/aspeed-bmc-facebook-anacapa-evt2.dtb
- Link to v1: https://lore.kernel.org/r/20260407-anacapa-devlop-phase-devicetree-v1-0-97b96367cac3@gmail.com

---
Colin Huang (3):
      dt-bindings: arm: aspeed: add Anacapa EVT1 EVT2 board
      ARM: dts: aspeed: anacapa: add EVT1 devicetree and point wrapper to it
      ARM: dts: aspeed: anacapa: add EVT2 devicetree and update wrapper

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    2 +
 .../aspeed/aspeed-bmc-facebook-anacapa-evt1.dts    | 1067 +++++++++++++++++++
 .../aspeed/aspeed-bmc-facebook-anacapa-evt2.dts    | 1123 ++++++++++++++++++++
 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     | 1064 +------------------
 4 files changed, 2193 insertions(+), 1063 deletions(-)
---
base-commit: cd44dc5ead3042f2873244b0598e39a16dc7b940
change-id: 20260407-anacapa-devlop-phase-devicetree-4101d3f312c0

Best regards,
-- 
Colin Huang <u8813345@gmail.com>


