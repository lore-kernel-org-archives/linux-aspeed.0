Return-Path: <linux-aspeed+bounces-1951-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7041CA0EE0
	for <linux-aspeed@archiver.kernel.org>; Wed, 13 Aug 2025 23:52:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4c2QBK0hJJz3cQx;
	Thu, 14 Aug 2025 09:51:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1755079477;
	cv=none; b=cpwykDlIq9MkHRwxQ9KlzrqfQqomUHG+E7NcxmLhutHqaL7ChzcVIPLCwkMlR2LpOR8+fJ6KJFbb5FwAAJfJvk9epQsPzAi9EGGPHebeenbj1Kyhs5brqD6VHLvqBbtu5x0j1xE2pqzwS0O4PJAFk5YmoINOc+vVU0Xs0EkWSbSvINBstJV1pBRnpgjiVf9Hv5Gy8kdTY3ZDmd53fJ3KEd0bjRDeh+VANM/AhpcdOLIBDBdQ6eldCWdfweZBNV/POoeNFvzs3ZcuQY0jNbVDtLHtL5PUWiFqB5UCgjHhg+lr1gBOLgK10zWdcyIGcajh8Vd2NslLzthrZvYn6xJB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1755079477; c=relaxed/relaxed;
	bh=pA6OisM0xiSXM2QYlyPmLpjSFc9U7oYBc1YKa/QuGPA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C/+j2gRivO1jXZM+gdNCu3eqGvB9cJYy6joz58tmTfn356E6Vm/3o7LoptgwHT9vcoytOfvNItZsftNE7NXvwWwTFbfO1rbV/o/DcOZZnpclXLX/veAdWDFHPnE+XzRev7rP+oUKgL+g0W6k91oJn95+0+ix8JS/DG+WUZFYbENXUiNziZV1bHOvo6LECgaiL6m+e0f7EYCh3gTwqaw8eiRhTHfdd1iddNsFYX9HACvVJJv25o6i4M3cu+yKnPpJY/27JzWIHroDBB4bZqDCtA3TFM/JSwPtdYpHE8NgonSwFNxbFUNiFyP22x+T7VN4bAZums+MO+Lj6Un/YVFEHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nE0mZduP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nE0mZduP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4c23rM4RCXz2yFK
	for <linux-aspeed@lists.ozlabs.org>; Wed, 13 Aug 2025 20:04:34 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-321265ae417so6961004a91.2
        for <linux-aspeed@lists.ozlabs.org>; Wed, 13 Aug 2025 03:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755079470; x=1755684270; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pA6OisM0xiSXM2QYlyPmLpjSFc9U7oYBc1YKa/QuGPA=;
        b=nE0mZduPB/a/bskpYksgWujkwQEyUZs3sawJfpduNFrlhTSsEcsAW7S+sk0euNrFiY
         l0z7w+CCns87q9K4MIJPXCBw/EjUzxaElaX12ejF97SRo0II9KxXogCtqiqphr/h4WuH
         m6E1U4NyWLiXkWgnkHezjinZJArGJiSiQnm68hX5qflMS36e6lTHFQDlB+kW57dgcvD7
         gaU8BOyXfIO6r69Wg0+Ta+M7m/fKjWAr2jx7h53o9ePaV5R8klD/3W6Iy7EnxiYJbvrL
         YvYB31yxozRQ1FRfgzjqU5gjxjAqek79XTYeLmBefVTOkTdWIUBrNyICjDJvaLUU+N4k
         Zo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755079470; x=1755684270;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pA6OisM0xiSXM2QYlyPmLpjSFc9U7oYBc1YKa/QuGPA=;
        b=SAJvhtekjlhzf1BH9XrNBetLQdccRu69MaHcP1Gx8V0T7H+UVO0Hhh6rKCufgEeNFv
         OGufJIUzjyrohQM0bK0K3nUGOEHK8E0KkjHHd59EcrnsWL3w/P7uagjAlEMz268BIUOy
         z5T0Ijly5Pt0KVT5CRXaotBH5sr+JBlHRp7JymH5WgczFHmSTITqUlWgZxk3DDkrF0DF
         rsdB9RsoB8VtWzpPhpptmodRlVfLJhfcAM+tZ95L5f3B7nG0FlFB/Wqy6QKivjsYZmvq
         ZR3kHVgU7e9bZe/rUrG1ARBHnMXspSrsyUDTiBpzKjAAkDE6uz2d1wQE1dhry43kwM5i
         l/CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYv3DVur5KIHeX/UXHccsrAc4kL3shpQT4bVX93lx6Cqv+UiGg/1d09kVFWgNFYfaibmHGQZQzh/z3I/w=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx0hnNcAREJRxTBwIcUEAuurxfydzBHfhomd8bw3hf0QqUUgovQ
	8U2HkJyksgOakPzmog1AXcFW+zFBGmR0drMtKq8ZB8bA8nKSOB2k/b0g
X-Gm-Gg: ASbGnctQF4HdkBLbeJXE/RcBWn3elwnTf8tekxr2fX2/lvcudEPNKNkjUrdUM+BHZmk
	ozDdVcZaJ9gciqUvvh951obGKhpjHh4UkQEIcjmF1ttl11H7p/e0BpUnmf0P555xYST/rnmGGsa
	EvdskJ+OvDQ8d3Fb4NpPSvmsX8zm5WR75sXVYlgQ/9FYyI5O/qPhpWDfuWEdnIUabu6m3Z1HHI0
	9BJRwmEY1Hd/S7/XETL8aEM7FeLtmAfjWd0/QHqpLeIU0fYMLx72XK3ciHSNuU4/F9PWyo3OuIn
	jkoJYyLe4SjFN9NwYJ+4+JTQft1RF5TSkdZVlq0YLkW7Wssw5LuJqhDKTmgVjCssYKOiFcnsvmt
	ry4jU9zfr5iZNX4fq6RPvXIXJJm7PWDgjky6osaK1yVrX30WH80lA1JpCUIRFyYFzNyCjwf3zFO
	IojQ==
X-Google-Smtp-Source: AGHT+IEGRUvzVmCw1gWq+fPL2z8gPf1Lc1jO0/qbCXCywxlp9sv7Gs9Tm2YFFW1IY+GR7t19aZAzjg==
X-Received: by 2002:a17:902:e889:b0:240:a889:554d with SMTP id d9443c01a7336-2430d21d1d9mr41164265ad.45.1755079470435;
        Wed, 13 Aug 2025 03:04:30 -0700 (PDT)
Received: from [172.17.0.3] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aabdedsm321545335ad.167.2025.08.13.03.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 03:04:29 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Subject: [PATCH v11 0/3] ARM: dts: Add support for Meta Clemente BMC
Date: Wed, 13 Aug 2025 18:04:12 +0800
Message-Id: <20250813-add-support-for-meta-clemente-bmc-v11-0-8970d41f88b0@fii-foxconn.com>
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
X-B4-Tracking: v=1; b=H4sIABxjnGgC/5XSzWrDMAwH8FcpOc/Dn3Lc095j7GDL8mpYkpJko
 aP03ef00sAycI8S5vcXlq7NRGOmqTkers1IS57y0JdCiJdDgyfffxLLsTQayaXhIFrmY2TT9/k
 8jDNLw8g6mj3DL+qon4mFDpnTwmtwAY1UTXHOI6V8uYe8f5T6lKd5GH/umYtYu8/oi2CckUEP4
 Ii0DW8p5/L2gkPfv+LQNWvGIjeuFDWuLC6gocSNE9rhvqu2rqpxVXFRSpUSJg2Y9l29dW2Nq1e
 XbEpSaeCo913ztGuKy1VLEZLA4P6ZFx6u5VV7g+LapMjYELlSsO/ajSugxrXFjSYEq41D4/2+2
 27dqn9oiytTAp+CgsBp33Ubt+4eXHGDBbKRdARs913BH3DLqw5Y8PUiBMqyEGlaFf/Kt9vtFwU
 gvy7zAwAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755079466; l=3316;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=CjipzCBLA0dk4QE580Prr8K+4dZdrKP11N9W5AAxlSw=;
 b=BJkjd0kiA5Y8obGHU+q6FUc8+QDJ1WXZD9uSxKU29Zky8R5vRxRpNK01HbH/Vk9qthXmKFUNj
 wq0ZQ7HThYLCdP4EjcBvWj1whob5NKgQ/OA7LXugQL6ituxA13vE96/
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

This series adds initial support for the Meta Clemente BMC based on the
ASPEED AST2600 SoC.

Patch 1 documents the compatible string.
Patch 2 Add pinctrl nodes for NCSI3 and NCSI4.
Patch 3 adds the device tree for the board.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
Changes in v11:
- Rebased on bmc/aspeed/dt as requested.
- Link to v10: https://lore.kernel.org/r/20250801-add-support-for-meta-clemente-bmc-v10-0-c1c27082583d@fii-foxconn.com

Changes in v10:
- Reordered NCSI pinctrl patch before board DTS.
- Dropped MAX1363 ADC nodes from the devicetree.
- Link to v9: https://lore.kernel.org/r/20250723-add-support-for-meta-clemente-bmc-v9-0-b76e7de4d6c8@fii-foxconn.com

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
      ARM: dts: aspeed: clemente: add NCSI3 and NCSI4 pinctrl nodes
      ARM: dts: aspeed: clemente: add Meta Clemente BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-clemente.dts    | 1250 ++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi    |   10 +
 4 files changed, 1262 insertions(+)
---
base-commit: b785b5d88cc27a521ea22b3afd85804c4c321d4a
change-id: 20250618-add-support-for-meta-clemente-bmc-941a469bc523

Best regards,
-- 
Leo Wang <leo.jt.wang@fii-foxconn.com>


