Return-Path: <linux-aspeed+bounces-1814-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11938C83F1A
	for <linux-aspeed@archiver.kernel.org>; Wed, 23 Jul 2025 23:47:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bnW5P5WqRz30WY;
	Thu, 24 Jul 2025 09:47:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753242180;
	cv=none; b=P0jnzCgy+uOE0JiGgvgpeqo94pJnaE3of/K+UtTQ1dKrOPRrF5IZRH+BSZ43gsl6Z8Qozz8Z1J/2U3byVFCaQfbtSCGo2pQ/XcHtMNZyl4TdVGfux97POt3gGjWMoYNL5kTBKjVg1oqmf/PYQTlspcmB+3OHHEnavi5L9YlQB2yUrRqmLsp72xbwddaMRCSNyJAn21reWJGWQsNWbLWaDTkxsHoX0/LXywEbSfPQ1GXJNOUEwsF4V4VXbyXUoG890jGuO9Y+/CssoNKqcMTCBgd3Yqzt2HVxlU9H+ItH2lSrJr+nK//zVHdQ0bgi98j60UJ0keRhHX+mTudhBCcGXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753242180; c=relaxed/relaxed;
	bh=zYRwMvyfo/b0Z0fdscYgn1jvIel8XvwropGmloEytZI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iPlrt44SsXe8/LdajCxoe1DVTeuNzgVIeP/W9xugPaKQXPBTd+jgMdQ3GdOowjRrkyFg39OW0DxYAKWORSnmP9MvG0rSH5xMcYy1v9dE91+aCZf5MrenBUS1EDvPzLgL02m+SFnjZuSAtuZ513UJrqgZiF8+82ekFWiePXzhg6enc+fBQziGhMH5jVzixqd7EcEor0Bt/UBuPqghug5r87oGWJrDc/YDzVR7p/OSG6B4Gj+gTqe22q3/LFL21GEZ8ZWhe94wtgtVIZzIFxDFP3CbkwScgAIUOKjysXeay7S/2VzaDZ2/PNWl33k/d9BSYODmcios0dy+UOoUBcuq8A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Xkj2+u1u; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Xkj2+u1u;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bn0Ml4bR8z2yF0
	for <linux-aspeed@lists.ozlabs.org>; Wed, 23 Jul 2025 13:42:58 +1000 (AEST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-23c8f179e1bso63015355ad.1
        for <linux-aspeed@lists.ozlabs.org>; Tue, 22 Jul 2025 20:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753242176; x=1753846976; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zYRwMvyfo/b0Z0fdscYgn1jvIel8XvwropGmloEytZI=;
        b=Xkj2+u1u3q6AfgM8Yg9bajDnf41cYal+ul+AnbSVWiY0woJxEcvVzQP0h5Pcye6/mc
         w2LyG1Pnef217+eOafH0WdQgdLW6tQzE2ZXntz0938IP9JtwXraXIO2Y19YvCeTPsmHr
         L3wp/pYwOxFLx3fTU8Mt9wsnUn68nNAplyt5lEm2+fKwGE3al7xPOLU6WnZO1XGzs3uS
         Gd7l33SJhbi4ewSiMvycm7R3wHiMUDGPU8ZIqSxHoT+MhNEVnL9PNiD4HI3mYedSEoRw
         Tr9TlTN4Fcze93SxL/jMX4RrHEYgDUI+ZB4LQZILaz8TKJ5VsUWKuZslBhE2HZJAjdlO
         2lqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753242176; x=1753846976;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zYRwMvyfo/b0Z0fdscYgn1jvIel8XvwropGmloEytZI=;
        b=OEXCl7/cOMXpZkHOiaESNbezgDwbgRYwCHhrlRB7p+r6AlraMlldA9VCxS0P/b87Pz
         NMZeDR73jnh6savBIwJSi5+KcWWhjTSdDiaG93wrXE9GFO5+tBrCBRWhiTwaDkxWXRSx
         wrIBggF2TPlzPLbABxxN9tItcp+gCLztFdsBtxrFkcnGUJ0i11YTCUgSOq9f3lkgrYd2
         8GbONwCfPJzKA7nSfuhHP7OfqFYkCF5DlPeOB6Eg14b5nU9BJMpSgYWuNO8/fE1gzVnc
         WmtX9t0A3V3HFpLS9OI65mtRbp4YHe8WMQQZzfnryKDyq9GCnNAeQ9p8+UsnXoUfD0xO
         J3qQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3XlIHh/PraUJqzQbT7CvdDwX8knBdlhWsnWewBjOFK2YSb26emWo9mxEaNPFzqbxyPVVwidv2dJo9nzY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw0Sfnx4USV0KthomhJJpL+TOMzKz4/8YNKwqNPY74wX/FCzhoo
	8ThDob4Z/sunWNnR67LGQ5Tr02fU1bAz+xviuhNzIiCn0A1mIIe/7r1w
X-Gm-Gg: ASbGnctbClqJ0UgXsi+BrHuvEbuXze/JrxRW/NoGEN9JDuO+JbS97pwAgoSKfeeouDk
	ODcPPjp5cQsSIixVAyuyJWcsUPC+h1b1b+vyTJkdjq2kGmLkSB8nRZi/NSKrM/oqrAi0nf14OfU
	cSxLCelG/C4lL+ZMYct7UJqYbDyEQZgbyaePmFs1XMfCEb5J/qoN3lK7K2vqw88ZBY65mwIAUXp
	lRseApDDcJXTUPNm/eFvupSyPILHfeIFr/GSu0JzHsifFAARPYyYApzHI3vPgFbtGVERk46uoje
	v3bAItR6CAEOCiAREBD//oN9ufZV2MkVf3yOCp1bEwUkyFn85UxT3thi4Z2g6ZD8a7JlTT1lFQh
	Egn5OjjaJcQVpbxGrKZizafyuP84THVKz5GIYSIA6vB1fBCHFe6uRFmdth3522FZ2QzE=
X-Google-Smtp-Source: AGHT+IHgMmQu7p8TJdr89s8prYT42MP3mN0kb1mkNyslHGE6mS1Jt2errHLIA3LNcROo3VW3v/R5OQ==
X-Received: by 2002:a17:902:d50d:b0:236:94ac:cc1a with SMTP id d9443c01a7336-23f98193560mr20187515ad.27.1753242175660;
        Tue, 22 Jul 2025 20:42:55 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6b4d47sm86197605ad.99.2025.07.22.20.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 20:42:55 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Subject: [PATCH v9 0/3] ARM: dts: Add support for Meta Clemente BMC
Date: Wed, 23 Jul 2025 11:42:39 +0800
Message-Id: <20250723-add-support-for-meta-clemente-bmc-v9-0-b76e7de4d6c8@fii-foxconn.com>
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
X-B4-Tracking: v=1; b=H4sIAC9agGgC/5XRTWrDMBAF4KsEraui35HVVe9RupDGM42gtoPtm
 pSQu1fJpoa64CzfIL43aC5iorHQJF4OFzHSUqYy9DXEp4PAY+o/SJa2ZmGU8Qp0I1PbyunrdBr
 GWfIwyo7mJPGTOupnkrlDGZ1ODmJGb6yozmkkLud7x9t7zccyzcP4fa9c9G36iL5oqSR5TACRy
 IX8yqXUt2cc+v4Zh07cOhazco3e45rqAnpi5aN2Ebddu3btHtdWF42xzMgOkLddt3bDHtfdXAr
 MxjpQ6LZd/7Drq6tsQy2wxhz/2Rd+3aB23Q2qG9iSD7lV1sK2G1auhj1uqG7rcw7OR/QpbbvN2
 t31D011DTMkzhayor/u9Xr9AaF65QhAAwAA
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
 leo.jt.wang@fii-foxconn.com, george.kw.lee@fii-foxconn.com, 
 bruce.jy.hung@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753242171; l=2850;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=AuSAmkqHcM4OHqTPBGVEv3kpwNw3rYsqqDHlncqpHCc=;
 b=jkX0xnPl1Vav8XFrtAj/GFS9wUTsOPnX24pKpHMomGWsUEABEEgRbz2vJNi0ABEwzZN+MnGG8
 G/9njjuRVmeD5DHubis+ZuzI6RhPD/s3XRDqu3Gr8e0JUMY3jRefu32
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

This series adds initial support for the Meta Clemente BMC based on the
ASPEED AST2600 SoC.

Patch 1 documents the compatible string.
Patch 2 adds the device tree for the board.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
Changes in v9:
- Fix comment alignment for // PDB TEMP SENSOR.
- Drop non-standard aspeed,enable-byte property from i2c11 node.
- Move NCSI3 and NCSI4 pinctrl nodes into a separate patch as requested.
- Link to v8: https://lore.kernel.org/r/20250717-add-support-for-meta-clemente-bmc-v8-0-2ff6afb36b0e@fii-foxconn.com

Changes in v8:
- Relocate IOBx_NICx_TEMP TMP421 sensors
- Enable byte mode for i2c11
- Link to v7: https://lore.kernel.org/r/20250716-add-support-for-meta-clemente-bmc-v7-0-d5bb7459c5aa@fii-foxconn.com

Changes in v7:
- Relocate CBC FRU EEPROMs from i2c13 to i2c12.
- Link to v6: https://lore.kernel.org/r/20250708-add-support-for-meta-clemente-bmc-v6-0-7f3e57bd0336@fii-foxconn.com

Changes in v6:
- Correct Author email to match Signed-off-by email address.
- Link to v5: https://lore.kernel.org/r/20250627-add-support-for-meta-clemente-bmc-v5-0-038ed6f1cb9f@fii-foxconn.com

Changes in v5:
- Remove accidentally pasted texts.
- Link to v4: https://lore.kernel.org/r/20250627-add-support-for-meta-clemente-bmc-v4-0-ce7ff23460c4@fii-foxconn.com

Changes in v4:
- Move properties of nodes defined in the same file from label ref back to where they belong.
- Move pinctrl default configs for ncsi3 and ncsi4 to aspeed-g6-pinctrl.dtsi.
- Add properties to i2c10 and i2c15 to enable MCTP.
- Link to v3: https://lore.kernel.org/r/20250623-add-support-for-meta-clemente-bmc-v3-0-c223ffcf46cf@fii-foxconn.com

Changes in v3:
- Modify leakage sensor to reflect current design.
- Link to v2: https://lore.kernel.org/r/20250621-add-support-for-meta-clemente-bmc-v2-0-6c5ef059149c@fii-foxconn.com

Changes in v2:
- Fix patch 1/2 subject line to match dt-bindings convention.
- Reorder device tree nodes in patch 2/2 to follow upstream DTS style.
- Link to v1: https://lore.kernel.org/r/20250618-add-support-for-meta-clemente-bmc-v1-0-e5ca669ee47b@fii-foxconn.com

---
Leo Wang (3):
      dt-bindings: arm: aspeed: add Meta Clemente board
      ARM: dts: aspeed: clemente: add Meta Clemente BMC
      ARM: dts: aspeed: clemente: add NCSI3 and NCSI4 pinctrl nodes

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-clemente.dts    | 1294 ++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi    |   10 +
 4 files changed, 1306 insertions(+)
---
base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
change-id: 20250618-add-support-for-meta-clemente-bmc-941a469bc523

Best regards,
-- 
Leo Wang <leo.jt.wang@fii-foxconn.com>


