Return-Path: <linux-aspeed+bounces-2381-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBBDFCAC5BB
	for <linux-aspeed@archiver.kernel.org>; Wed,  1 Oct 2025 22:38:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ccVFQ3mFQz303X;
	Thu,  2 Oct 2025 08:38:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1759308486;
	cv=none; b=cQPYoyDEk11YalCrOkIPxJFZ+yBLMtz0Vr/L/qcdGpKmpdTIarpWJ9BnqeUS/kBQTdxBUKmi1WwHkBuRMDym3f0nD/9OTcqXxTGUuPOexlhFNz4ccU9tj9dfzOB+ZfQ6PhPPI1DF/N0HV75JaK78+0iM8P21WhrKxGr9XOVw05nB/hudQX5Z+nTh8PjlkTaGEtcOpSe75Z9pneqhCb8xS1Qf+LRDygAMvod4Co1WOt8MGs6AdsAVS49pddWL0oliG/Q+e1FIg0bvt8yqjT96wu5W64TpY73xI/kVhVbMPb5ZO2qRdbf9xb4LCZwZF/EY5b7sSFLos8asuJIrbQAOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1759308486; c=relaxed/relaxed;
	bh=XMfpQioL9qF93r02i/m3R/Lc2dj1xsmt2jY1yN46fE8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mCmnmxhX9RZdEc4qOhrBOFV5CsCxUiVMm7VJf+ZjnoFpWjhpXAth5Ex/svnICs/etzO0CadibsiQx2b0b15XyQAELqk7ldiWT55Nr2ixdlrJFHiGREFM/a+HVo1UYrFK0S3iuzV2n7tqAjMkWj5LvW+2I+43iD6llx6ljmB0YRPodT9hvJx+ArYpQHMyS/ZBz7fEAtRm5ctVK5QDbIBqo9N4IN5arP5XxCR/JdZ7b26qqjzwfkFCWw60a+4EIJcQblVTWJZQCPXLIt9M4bnhSljh6g1IGXCoGFHsf45LBd2TRfmdR3cJl4yyvlbitwfxVSEGEKhk29JGuNr5lGZgcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cgWsoGAt; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=cgWsoGAt;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cc7qT5hLhz3cdG
	for <linux-aspeed@lists.ozlabs.org>; Wed,  1 Oct 2025 18:48:05 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso7530832a91.0
        for <linux-aspeed@lists.ozlabs.org>; Wed, 01 Oct 2025 01:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759308483; x=1759913283; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XMfpQioL9qF93r02i/m3R/Lc2dj1xsmt2jY1yN46fE8=;
        b=cgWsoGAtdbXz3HFv2fwssKRQ7JwDHyvrEWBf1++OnR69IfLl9tqtRf5NiuHRRepJ76
         fwWohJXZ2pPSYMGeqwUqbajVNRIiafeF8FCZSM7bw9iyV169o5OoJfjeJAa0OWty8ojG
         7hWz1On2ZBnTYzVNmUHNMTZILet74EUKhUHZBJzL2jEmJovs2q/7LLq9FF0Sd98iRVo+
         lbxiKtntPSI33HHQJR4P9os6qWXBk7F1VNJWIKbxdfXF8+lj4ejzTomqPNPm5CMzovPt
         l747q9dVGCKVVVYHhQrbtnio9J3wOWSoaqteLNyWsBUpGPXy/nZy/nNtgo8TurFnNf+b
         arbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759308483; x=1759913283;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMfpQioL9qF93r02i/m3R/Lc2dj1xsmt2jY1yN46fE8=;
        b=hNzkxCLnvY7mWUZxE73UxsvJvaDagelmiWJNG6MPnIB/7+h9XVHOcYTzmVXxgT2qCt
         WZEZc3phQ6f5A62MNC4x5b2NUIGjtYjHDoMJzYfUvBOWgvu+vi24i5Lp1ahZS/gDSvhe
         Ju/0EnYfUUuoIyICgGdpGIQP8RNngzjRZBfMzt+phowBIjmQPaiMxqb7XIlFxX1CjBVu
         Fn8eU+i0m+VLJWTXPouTstBpTp8PnkePzoeDBv5KaOR2DoyfprRSztE7soKRzPJwZ7mE
         QwbMrf0J79YJ1ZPILWY66B7NOXWgVnEhQs4FZxy2oDu+tC3oRA9oJQrxULpzx6fCmm4x
         b3sg==
X-Forwarded-Encrypted: i=1; AJvYcCURYfe/zeoErVz4bdaTw2wtzEn2XxpBP867tvfdZh7fjbDYYl/V9rJhY8cUMmd72iMXPyHxf3yzxmviPYk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YynG0EQH11oOZISG4wk+m9XL1/b5eLIuieIvDgRT/n7cCezRvAq
	BSY8iNNatwFRE2luUvT75KUjqGlda9JjGpg+sRX0ep5xfRD1RnpMsk6K
X-Gm-Gg: ASbGncsRELds1qt/Uusc1RilSJOmuJr+wCj9/kd+lk4rvadzOsD9FkkUbj6rdXW9TMn
	nRtITeLIQ9rP5OBMSDrJsNWGRetIT248cDysE9uoLgAjE+gaJ30919QigT/Qvp2iCcU6T5XvUq4
	s3A58N3pQQ+fjyBeWc+t5/hatqaLz5fyz3KgjDd+LW08CeVWILMLbpnWpzsKVdH+XoOrCXc0b5/
	a0qQXZUnWFnCK/lfqI46Szmzb1nUq9GTtrDJMrs729cUwY8ENgQGWwqfdYOL5TKUDNO8GdB2cfQ
	A/nLsXqXr1balxNoO1SVuonER/+YlCsolh1CaRLWyB7Tt+5HlJ6Rz7LwiC3IBW/P+XwZgtPxZEF
	sXbqhqB4kIJ1NNoRAOscn+tdjP6SFhIbJ5IHAgcGE2ASwPC4INrEb02gdSPgXv4cCnkZx5Dubiv
	URrRIUdbIK/Z1DDfX75zi1qJ/xmYllxOHPy9KZi94y6+Woyq83RlMVlR/9biz8ZP257I7gKHfGB
	11i2AJdaX/9MEUFHPCxKR1JPVKcogKGzQgRTd85L7MHPO8=
X-Google-Smtp-Source: AGHT+IFnWYeRu9k4Oaa4bTAUDYxWIdWeHxGT4Bg1jpuCkukhqqyjsyyOYdJn3LPL9nXEE8BZUqnazw==
X-Received: by 2002:a17:90b:1e10:b0:32e:59ef:f403 with SMTP id 98e67ed59e1d1-339a6f2e80fmr3239453a91.17.1759308482433;
        Wed, 01 Oct 2025 01:48:02 -0700 (PDT)
Received: from 2001-b400-e387-f8be-46e6-cc88-b318-45e6.emome-ip6.hinet.net (2001-b400-e387-f8be-46e6-cc88-b318-45e6.emome-ip6.hinet.net. [2001:b400:e387:f8be:46e6:cc88:b318:45e6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6e9d22bsm1789250a91.3.2025.10.01.01.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 01:48:02 -0700 (PDT)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Subject: [PATCH v3 0/2] Add Meta (Facebook) Yosemite5 BMC (AST2600)
Date: Wed, 01 Oct 2025 16:47:49 +0800
Message-Id: <20251001-yv5_add_dts-v3-0-54190fbc0785@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIALXq3GgC/23MQQqDMBCF4avIrJuSTqKYrnqPIhKSUQeqlkRCR
 XL3pq67/B+874BIgSnCvTogUOLI61JCXSpwk11GEuxLA0qspUEt9lT31vveb1EYbFrrbtoPTkJ
 5vAMN/Dm1Z1d64ritYT/xhL/1v5NQSKGM1bYl5Qw1j3G2/Lq6dYYu5/wFm+YtzKYAAAA=
X-Change-ID: 20250924-yv5_add_dts-9268ac14dfc0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Amithash Prasasd <amithash@meta.com>, 
 Kevin Tung <Kevin.Tung@quantatw.com>, Ken Chen <Ken.Chen@quantatw.com>, 
 Leo Yang <Leo-Yang@quantatw.com>, Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759308478; l=1447;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=QvD/ud6DrodRNKqUA2m4nL+/50pX/gxXw21okP8DcUg=;
 b=csBBxtxldogEQ8rY3FiSkJeHOhzuac4zcoGG5wphIcMFi6EvJcjhMsjESJ6SxzR6pTZfm9a2t
 NfCmbeaOchxD43dDjoBaxFLMKIIuBCb4bv9jKCT5u50KF6oapTWBuXE
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Summary:
Add device tree for the Meta (Facebook) Yosemite5 compute node,
based on the AST2600 BMC.

The Yosemite5 platform provides monitoring of voltages, power,
temperatures, and other critical parameters across the motherboard,
CXL board, E1.S expansion board, and NIC components. The BMC also
logs relevant events and performs appropriate system actions in
response to abnormal conditions.

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
Changes in v3:
- add missing dtb target in arch/arm/boot/dts/aspeed/Makefile
- remove unevaluated property `ncsi-package`
- Link to v2: https://lore.kernel.org/r/20250924-yv5_add_dts-v2-0-39a4a8e3c9e6@gmail.com

Changes in v2:
- send v2 of the series so that it's properly threaded.
- add idle disconnect to i2c mux.
- Link to v1: https://lore.kernel.org/all/20250917074812.4042797-1-kevin.tung.openbmc@gmail.com

---
Kevin Tung (2):
      dt-bindings: arm: aspeed: add Meta Yosemite5 board
      ARM: dts: aspeed: yosemite5: Add Meta Yosemite5 BMC

 .../devicetree/bindings/arm/aspeed/aspeed.yaml     |    1 +
 arch/arm/boot/dts/aspeed/Makefile                  |    1 +
 .../dts/aspeed/aspeed-bmc-facebook-yosemite5.dts   | 1067 ++++++++++++++++++++
 3 files changed, 1069 insertions(+)
---
base-commit: 30d4efb2f5a515a60fe6b0ca85362cbebea21e2f
change-id: 20250924-yv5_add_dts-9268ac14dfc0

Best regards,
-- 
Kevin Tung <kevin.tung.openbmc@gmail.com>


