Return-Path: <linux-aspeed+bounces-1543-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496A7C7115B
	for <linux-aspeed@archiver.kernel.org>; Tue, 24 Jun 2025 01:01:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bR68Z47swz2xHT;
	Tue, 24 Jun 2025 11:01:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750674580;
	cv=none; b=kQDI9ppjEi6fpYpbzDrlWzabJw1RD3qwOByf9HkCBk1ptLYN9bNqZoZP4F3kQfYuitHgz2/0yXhmxYCsv8sdtlUVJ9sQfTkxe7MzlLuuOiFTBFuCFnqBhpXnRxr3MVGJon8B9Qc1WegMpEcbUDBu3a3cadCOUvnc1JaoWdTCNgs0KXOXFoiYlfUfHYgjl2AjPxq+vckeOG5g/JTGHE+LuFO+cNY/h39UYRwgRDnbvq6VvuqAjlNkKgJWBmy6I8nuPntYZH+ALhCIJsbgbt+c053VvTzBY7qu3RQgTSN6/3QZAsvPaVFIwZ/5ESDbeDXSoIk8f2WKZwL1DBPsq9GPNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750674580; c=relaxed/relaxed;
	bh=LNA9piZjlRKT0wGiiHkHTEOKa/CNGuXgOq/W48NNgPc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LGy59CPN7xKP/B4lkAe8tvki5ewwnym6IRgGTPLRZeLw6CeyiGO3ezIOUglYje4hVamMutYbdXIiqJWb+CSJTy7bjmU7nXr7EZAxNAQCasgjOjVSJxELJDAiAL+XkLQ/EwSiJAxGQMCV0TMKCeMEtU70mRiRtLBzGsN4sw2nw+Z5/aCdllK8IQVD579ia7h+rXFC6Rrb0HUscC/bl0Gkk6eaSHlfxXT/Y6aw+LXDnF9UhIDIcz05kRDFrlln0nz0/LNIQvngEHiGXxYsbw0uSslnIwryvb8Um8DkrU1KSiwZer6Ssm6S0tzqkTD35pBDzuEIApEIHWMVNeyHIwJNJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=d4OsJTOK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=d4OsJTOK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bQkpq1nYGz2xRq
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Jun 2025 20:29:37 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-234b9dfb842so34377005ad.1
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Jun 2025 03:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750674575; x=1751279375; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LNA9piZjlRKT0wGiiHkHTEOKa/CNGuXgOq/W48NNgPc=;
        b=d4OsJTOKhxyNDNGBhqe2eFZx+DWE97EtqVnHcAGKf0iNyqJNQqo1eEJddcwYazYjBM
         copdhfMV8OYSwio3Jn7Lo40xFQ/PHoyMJkhrorDRZ7PRonHgVCJzGLk1ns281LYA1Vep
         dLD4m/7z8xtEccPIilHRZhU8ga6E7QNU3rMRmZ5pPVsfTLhVRdIl6iQjeAXxGAzntTrQ
         +csww9P7sOJYzB803MyCLDdD1iENlDwqb5es0SvN6dk4oIdDv7S4cYOXKpNZhwlFL+YN
         PGaI3y6ZjiHfV/bPRHVAwDpgV2tZEmFzWFiC7YK3+yY+kOTE8pLF3s3uEDFuSbQFzCC/
         GBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750674575; x=1751279375;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LNA9piZjlRKT0wGiiHkHTEOKa/CNGuXgOq/W48NNgPc=;
        b=eCYLd8XVbNTd1+ie2hPGldMexzKDye+nRR62WSSUX4QTT+FT9IzqW9v8gZn9Ismwmm
         /UMUgenn7saCxuNen+adfhg5oOGNFsgbPMb1m2DTfZWnhMRyZeEKLGMPYy4ZUARvUYtL
         TwnNMQGrxsOUUhBRvT5L4aj86gL7u8XDVqNBV7iNrxI3EvNDRHKwTDCg5c1ZVb62K4L7
         FMlVk4CuAZOqKn7lHSxYUm/Ks5vmHvuY95s8z1AFmIDv/txIOYM3cYpRlNf6L0W3qWO5
         WvlKm7d5tqsaVP8C9q9RvXmrbltOBc71cB7dC1W3mGFKAW4xD6Oh4mJM/rpQICI4t8bx
         L5Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUkOrJCwaoRUcf7C8ORYEVsSRajoSSAt8kK0/Uzr7X0WjVUIQRmX3s2DdaK1d3Li+4dvpzU6MefkFeIRtI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzabKdX4hUQpJvbi11X/UCi9YxJm0HZ3zxpB6EU4GLZ8QaFj4Le
	a80SLKtxFu78N9/97MX/I6mAHpp3vClWHjLq5ZL2e7xvtTwJ45FKFb70
X-Gm-Gg: ASbGncv3dJGUKtZjjwqUXCy26IbCvDe2mo6A4vje3BkBiio9JJdEvKyVcIRdXyduHV9
	EI5pIHhAzDEBXdJ03buVRQ3DzhZrqyvO7ZL59pYQKxA7imEn92CTAQNFYT3eUyCPCmbRzieOaxb
	rgEBHYwJb9bY67UIf9SduJu8bxlh+XfHKleL7RF39+k+DpAZ9liN4X+z9/JuPsM3tAypR8QD0d3
	Wqz8UpAxps0aA2iYmdxMRNt7nAJl0ro/WaKCvQQRix1UUaHLEvlageJxqXr6zS+0Ria7pTuCnNj
	6WRgXDGFgDOpet0jPdWUp5Q2uqUkSFx3hmIgRLKJ5GKQaSJ9dt6v9jDMrCVmkolqCQYWfpIk6se
	5DI7UmzuaBgLCIBKKhy2RLpMyfBjI0ss=
X-Google-Smtp-Source: AGHT+IGu/olQd3gCQ9n8b1T0IY/BOseKz/yROaIShRCjegUE1QktPgjGuNH4gxysfO4C6lOdqqk82A==
X-Received: by 2002:a17:902:f642:b0:234:c549:d9f1 with SMTP id d9443c01a7336-237d9bac013mr160443415ad.47.1750674575287;
        Mon, 23 Jun 2025 03:29:35 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237eec29a77sm39901125ad.165.2025.06.23.03.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 03:29:34 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Subject: [PATCH v3 0/2] ARM: dts: Add support for Meta Clemente BMC
Date: Mon, 23 Jun 2025 18:29:00 +0800
Message-Id: <20250623-add-support-for-meta-clemente-bmc-v3-0-c223ffcf46cf@fii-foxconn.com>
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
X-B4-Tracking: v=1; b=H4sIAGwsWWgC/5XNQQ6CMBCF4auYrh1DC63WlfcwLsowSBNpSVsJh
 nB3CysTN7p8k8n3zyxSsBTZeTezQKON1rs8yv2OYWfcncA2eTNRCFkofgLTNBCfw+BDgtYH6Ck
 ZwAf15BJB3SPoiptK6RqlKFl2hkCtnbbG9ZZ3Z2Py4bUlR75e/9FHDgWQRKOUJqqO9aW1Nv9O6
 J07oO/Z2hjFhyv4L67IrkJJbSE1rzR+u8uyvAG3SOkwMAEAAA==
X-Change-ID: 20250618-add-support-for-meta-clemente-bmc-941a469bc523
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
 bruce.jy.hung@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 Leo Wang <leo.jt.wang@fii-foxconn.com>, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750674571; l=1272;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=+GW4fgeA+xKGchuTpQBu6jwVxlJTWxJyFy/i+RiAaek=;
 b=btkegG8seakota/9EBKZL2P1m9hbYQ7NcEdNGd+Iz8G8tbLqCymMYqAzZy0D7nJsbPbeG6fVy
 yF1S00pOaEBAlGU31LLYn+ehfvKPiteZ5u+ZO0/xuwC9i50JSo2Nnnf
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

This series adds initial support for the Meta Clemente BMC based on the ASPEED AST2600 SoC.

Patch 1 documents the compatible string.
Patch 2 adds the device tree for the board.

Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
---
Changes in v3:
- Modify leakage sensor to reflect current design.
- Link to v2: https://lore.kernel.org/r/20250621-add-support-for-meta-clemente-bmc-v2-0-6c5ef059149c@fii-foxconn.com

Changes in v2:
- Fix patch 1/2 subject line to match dt-bindings convention.
- Reorder device tree nodes in patch 2/2 to follow upstream DTS style.
- Link to v1: https://lore.kernel.org/r/20250618-add-support-for-meta-clemente-bmc-v1-0-e5ca669ee47b@fii-foxconn.com

---
Leo Wang (2):
      dt-bindings: arm: aspeed: add Meta Clemente board
      ARM: dts: aspeed: clemente: add Meta Clemente BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-clemente.dts    | 1254 ++++++++++++++++++++
 3 files changed, 1256 insertions(+)
---
base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
change-id: 20250618-add-support-for-meta-clemente-bmc-941a469bc523

Best regards,
-- 
Leo Wang <leo.jt.wang@fii-foxconn.com>


