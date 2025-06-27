Return-Path: <linux-aspeed+bounces-1593-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF1AC77B7F
	for <linux-aspeed@archiver.kernel.org>; Sat, 28 Jun 2025 01:45:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bTZxw2HS1z2yqn;
	Sat, 28 Jun 2025 11:45:40 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751009499;
	cv=none; b=R5rDAjZcsH9g+w7GlqidZRmcVS06CtHVqSJ9RJqM0yLGxYbEGq4IEGZJMydA1tw9x5xCo53dqupEffVRUWpwRpLMMZUyfuml8spOgXU3Efd9ulAkeIMD9YAluQ/EyNb+M7VoIlRZ+DGeU74wlFdeuKKJ/5K5yVD+zcazITrKGf/hvK0LXdq+rDURquvrnJ/mBpV1ncLwMfcmVLkiuB3YL+tIWi7ijLg+oxNIT1kjdsw9RETq8iT2zocaCkBniY2ZVw0exsW8r05avu3NAM1GRAdoW/FdbYC1303TwGU54sbf/KLgDWDj+ie8mbB1P+qDRI3ks8YywTeS/QLvOXvODg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751009499; c=relaxed/relaxed;
	bh=9Ulo2IqCqK6lmTR1n2ctrbmpkiinWsFuA6QDYyT+/w0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M4XQEYCC20YdB6OrA+954UmLYlC96XrDSAP2lB4e0nyBM9AumfneznmBByW67Gfv9Nmoaq9day9BHwk+iRu6jKEQzNgND9lEE/T9bb/4NTXU0UIrWf06tjPm7BgAtEPgGjTQ8qVzjKJugOKaecjNdJiYru0bFoHg28oDi1eA3j+0BHxodM2+CKW8YBSEgvtYBwKF787sj6Jk081L0n8L7y3Hlbizgw411HPp+K3JzUIwm+7xhxkwFV/a9QSGG1iCkfIn646/c10xeLQTDIydnL0/cEvfkZGCcrhcz9Pv/G0aYXjeTNBR8Y97Gtj65bJQMXX2na0GL9LPSlbzHs9y3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=A//sgkKH; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=A//sgkKH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=leo.jt.wang@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bT6gZ2xg0z2xsW
	for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Jun 2025 17:31:37 +1000 (AEST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-749248d06faso1781275b3a.2
        for <linux-aspeed@lists.ozlabs.org>; Fri, 27 Jun 2025 00:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751009495; x=1751614295; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ulo2IqCqK6lmTR1n2ctrbmpkiinWsFuA6QDYyT+/w0=;
        b=A//sgkKHxQdbKb44HHf5Tm0u+bb4kiwz1PqqJBYd3KYBsEJXXtUgxDM/wwm+xowLIR
         SRQ2Dxj2F8pz25Dz+HZ4c9P8J/7lHF+pNTFo2jcWv6uDR0f+CI20bbQ2XRkkf1GcHIFK
         94Sv1L+6IDd/LPqB8hqlEoZiq/fq505RhnC9q5u0njHPnBPyIYdtfDyrNReewkrjXNHU
         mYN/kPJcOqjASeXwSzmFlyXZ7LKM8ZX+n2mMdhk8FkjkMuTXKuAlHc9u5o8/44cl8ekK
         Uazn4byz4cKGKS74g842ap6znfjkU95w/eW4O8/jIKFI9Wy4Ki9fZG3ZrQynrdCnL3cR
         f1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751009495; x=1751614295;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Ulo2IqCqK6lmTR1n2ctrbmpkiinWsFuA6QDYyT+/w0=;
        b=CZh3AOaodQzuXivi6/n749h7Bz3hRJ1KIPnAikXBn7M6wVcOZWtQsSqnZldOJxREck
         bgCnwsozuePmfQyVG7cNM1Ep2bi3h2nIl+P0MuBjttM7FV6F0vhGUTitp6GXVdCsFste
         YI7IzneURrIPmb6rfsd3d922hSQFk0aZ0OIORILZulMUwkLdzwYsF+zOmRn9zhRuIkY9
         v6v8aMockgkIh6Dn9QxWEG99oc5yga3ic0UWrlfozXOdma5GvahHM1jVwlR+i1rlnNgL
         FrTz9FZXHYId+juLfpaPxNj2fqCFYeZtSdSh49JET1kC5PLsKx+ckYQGUnNC8NmJf2Vo
         kr2Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1HxYPPxJKA6FL+AGw2F0LGUSTnq5aiuCwQBSXNmstSCPRZOjphceDNM1Y/apXqxWbTIP4xUTSkxHcIQY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyfEBpbIpVlBAS1fjc0EOtd4VGParSRVUpD5ldoZ4GqI5nO46Wb
	JQ0wNNg01sq8TNKmCD6CjnPGLiNnNK2Vd2dcpfoG43Xa8IfAGo072JIH
X-Gm-Gg: ASbGnctnhiXXlnMBGsEGBCkWqt4MS3T8j7nheasIqmXxP7n5yzbSGzIU6/zsbE+Zy90
	ccxDWV0HEIJ22rXnZIyvZeUlMtliBhAiwlJ9IyXJb2/3m6euJI5lKae5VkRNhH3TOWNsulGvD8m
	Xg3rm+uFKerDNETfHh6a86nlCzJokIfYy37VOE0bC/ICcH8HE6cqv8mi0iQIlvkA8Iw8WohjFZd
	JPSRK8ejjnuQWz+FkUzQLhL0sPPlsfffpopUM9DaeGsjlyF85Ln9I1VF5+4lr8+HMorwh7GJE5T
	zdZwsgcQEfIrnpUYSNbckp2cFgkEivHrPn1Rb+jh/ZFEhKp27r112HmvobAqc6AVcwLA3m1BlHH
	RTCjahy1d0eJOAlyHWtF9Via9/M4Ec/8=
X-Google-Smtp-Source: AGHT+IHWPxrtW7uCSMjhE308lVU3QsfpWpHidLpZ/iou98J5zU0NWKBg4cfBpKfITecjKJM3Ydlp0Q==
X-Received: by 2002:a05:6a00:18a7:b0:736:4644:86ee with SMTP id d2e1a72fcca58-74af6f4078bmr2943654b3a.14.1751009494749;
        Fri, 27 Jun 2025 00:31:34 -0700 (PDT)
Received: from [172.17.0.2] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af540a8f6sm1628646b3a.12.2025.06.27.00.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 00:31:34 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
X-Google-Original-From: Leo Wang <leo.jt.wang@fii-foxconn.com>
Subject: [PATCH v5 0/2] ARM: dts: Add support for Meta Clemente BMC
Date: Fri, 27 Jun 2025 15:31:20 +0800
Message-Id: <20250627-add-support-for-meta-clemente-bmc-v5-0-038ed6f1cb9f@fii-foxconn.com>
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
X-B4-Tracking: v=1; b=H4sIAMhIXmgC/5XNTWrDMBCG4asErauif1dd9R4lC3k80whqyUiuS
 Qi+e+WsDM3CXX7D8Lx3VrFErOz9dGcFl1hjTm3YlxODS0hfyOPQNlNCWeHkGw/DwOvPNOUyc8q
 FjzgHDt84YpqR9yNwb2QwzvdglWbNmQpSvD4an+e2L7HOudweyUVu1//oi+SCo4XgnEc0Xf9BM
 bbfK+SUXiGPbGssaucqecRVzXVgkYT10nh47uq9q4+4urmglCYCMg7ouWv2bnfENZuLHZHSxgk
 wf911XX8B8kX8AOABAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751009491; l=1868;
 i=leo.jt.wang@fii-foxconn.com; s=20250618; h=from:subject:message-id;
 bh=9fRWkgV+8VP7UmRHkuiRfuz5hfvvERiwtk8L614dD50=;
 b=0XsbKwFEd4w+7PzCss2Nmt2rO/8TFCmbSJs+qdTQwzawMciw4D7RjYyp2vdqVWZKISYobWBP4
 UD6tzE6U0MHCxtObyeLMadTp/GYPRXTWeuWWAPR/jwtI7cNH8Isi1zI
X-Developer-Key: i=leo.jt.wang@fii-foxconn.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

This series adds initial support for the Meta Clemente BMC based on the ASPEED AST2600 SoC.

Patch 1 documents the compatible string.
Patch 2 adds the device tree for the board.

Signed-off-by: Leo Wang <leo.jt.wang@fii-foxconn.com>
---
Changes in v5:
- Remove accidently pasted texts.
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
Leo Wang (2):
      dt-bindings: arm: aspeed: add Meta Clemente board
      ARM: dts: aspeed: clemente: add Meta Clemente BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-clemente.dts    | 1291 ++++++++++++++++++++
 arch/arm/boot/dts/aspeed/aspeed-g6-pinctrl.dtsi    |   11 +
 4 files changed, 1304 insertions(+)
---
base-commit: 52da431bf03b5506203bca27fe14a97895c80faf
change-id: 20250618-add-support-for-meta-clemente-bmc-941a469bc523

Best regards,
-- 
Leo Wang <leo.jt.wang@fii-foxconn.com>


