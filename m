Return-Path: <linux-aspeed+bounces-3543-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3929EEC2AC
	for <linux-aspeed@archiver.kernel.org>; Mon, 23 Feb 2026 23:07:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fKc1M6vk9z3cC9;
	Tue, 24 Feb 2026 10:06:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771845464;
	cv=none; b=PDRuVyg/r0pT/KOqcOPghBcxxKltxIfumIcpmmKLm1f9HgXaCbUBbGhap661cRxUkELKCba529isji+D7HX79AyCQh61xXJDv3YfJhCRU9TfwMTX7z5repKXD7WRdWczVpeLheNuxnWpF880G1mR+TLTns7oO2TZqH5c46TUiT7VwPII079TcbOaj3tASJ29caqxdn7YnbtFu2S0+5QkuK+WWXVUEHFbRItOHQWfhh0S7mPVb88y3YmSmuXjQbDFyZwFST2l25QqwygtMdXC+D4hJlL2c914pxxB/VYhoq6/+FTlQY5uMwF8mHJ4Ua5W6Hp0xjPehjiM2mGuzZsEkg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771845464; c=relaxed/relaxed;
	bh=w2fDgtw5Km3aQZsh4vi4EMsTjWhe4lzXuaMoNrX1ecI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L7JO8lydL001n4qHJOJxPtvuPlSyfD9c9Ch6PDGgEqQp8ILQS5sDi77H3ztJz+hOGPrqs1oZAsiaLZKLpoyt5uOKXyG3XB3eVsRfeg79vYjMs2kO+pY4MKCLXeDWWIshbqXOMbIIGMuwMg9ZXVkgKBUoGlki9ft4v3M+orvzAfWCnPgtbYaSveVCuGBFjFtfoNAeXioyDBf/zG8S7YWEqZkzWEnJC6ixbH5n8ib4x5qp+4posOR0lvXQGS/tt6307vzeWAw6ZWXzvcVuQ2J8szhj7Wd71NcxHUBxhZLMaluJDAKOLBkaYR9urnQ0iB5ruBxHfrPFgcP6PrwxAyrioA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Tu7VUxr5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Tu7VUxr5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=kevin.tung.openbmc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fKJHB5kqZz2xN8
	for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 22:17:42 +1100 (AEDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-c6e191c4b8fso1485086a12.0
        for <linux-aspeed@lists.ozlabs.org>; Mon, 23 Feb 2026 03:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771845459; x=1772450259; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w2fDgtw5Km3aQZsh4vi4EMsTjWhe4lzXuaMoNrX1ecI=;
        b=Tu7VUxr5x/T6Ji7ZukbeGdhwxXVjDpb7GgEHEIUjA65hUp0ZhbYsdp1KCyhBiKwnFX
         m06Xdjylo8H5/UtKcX21+WQezHWLQOTZZaKPyQBnp1SMYHtdRF6dglNNk96gFGN4RCtD
         7jweMAooYuPQH1JbBSJtcBXmLrO0hLpPZTRudqhTqZyNNQikXt1tUF6TDkX830ltB/cb
         93Hfs84VD2jPlTPXSVkUo8Sn7NQuWvhreWPh8n5dPdpoarJtSF6dsq7gIlvGSXttiUK5
         fiWFwz956u6xPJ/0P3w1xli7za+unQIODknIVPbM1shqE6jA0ev66ImLfwEC6H54nDA/
         2fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771845459; x=1772450259;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w2fDgtw5Km3aQZsh4vi4EMsTjWhe4lzXuaMoNrX1ecI=;
        b=K7T9VjGRcdUCTqP6ifXWCQEgDu3GAWkPB6eB/aAApao+HnWGPO3tI9ZxkJSExiUGxp
         DVZg37tPedyL/YczlfTH5zQ7rPtiRA9CpwT2ZJ34lyEL9QWOmNBPLElpk0666VIJua7Q
         Ayl8NzIfnqmZhbQZL7NMzL/YUwA1wTOIaS3c+oqEttr1jPtcBZqFKKJjVPaphkZtFz5V
         PksmnSOxlKF6xwR0CX/vvoDOfBjv2789SSk6dQFXg1x7IL2mK3h3nIOmSXIFc1khrzV2
         KdybjDSKHL2J/201cI5c2Q3dr2gRFkZeJ2RtcIEZO+hoCmAOcm+ElAS5IQXMo55/89JD
         ic+g==
X-Forwarded-Encrypted: i=1; AJvYcCV3I6cAemnrpDqvwa8CeGtrfRYN7iv7o0bh80NfZeFSR8Vf4x0G7c4pO/T4uRe1ii0e1UYBZtnA4O9aXb8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxMraujl8SsZGJ2TfqG2S2o6RxedSxJgjiTadmC+GaUc8zJjIPj
	G+xsyia6y/kl7FhoqOEWTbNjD+VZaBpy2FT0b7A9+kD58zajDtK+uSrT
X-Gm-Gg: ATEYQzzlnql+KkTuAKv+1kA9aMCHswULZdAeR3wfT1v1tc/1AeuXkJcOjKXG7CwXqSy
	spUFyNVPUY4NUt+Ea9WKa1BC3ERFzNy9k2S1Sdt9pY+1v+f8YhUaFBKr4mT0ofld1g7a1JzlrMo
	zgVc9n1/fGt60Uy1bSCuMzeuxQ/LAaRD9PAYPHW6uEaJEDzBGvvZ+sYhadECexJ547syaQWLKrk
	fHLpwVt8JWRr7YqGCgDAvBCGXC6N9Cw4WyFkCBq5ZXuvMsrB3z9FRmhdoE3L7iDp47UgVvYOyeS
	zZtfp/F0wWqs9BnxjRwCqaH4FrfN1gyN7tWO4/DKmEgt+o8O9oeLrkNbBEPWqN2sRHn3r7ziq6O
	qzTB4VG8NR2m6y75PCbuu9fia4CaI8SwpQYUz+Dz8UUd47rHpiP6OTRw3audCgUlz1yejEVET5+
	v0VFDJuj/3ebqrutzMp/LEMrxVIz8OnbGxuf5l26khtJ/WCoxsLVk+tScPzN3qM4NFm+PaH6R7m
	9Aex969uepE6/B0FGm1RyHgXIaPYrzHjIo2CT6TPhGtRDfO58oFiVP/54PzpZFQCZPhflwPQStk
	ewe75u6BV+va1WbZFYOk
X-Received: by 2002:a17:902:da87:b0:2a7:b039:4b52 with SMTP id d9443c01a7336-2ad744556admr77368315ad.1.1771845459054;
        Mon, 23 Feb 2026 03:17:39 -0800 (PST)
Received: from 2001-b400-e3a6-b683-040b-c296-04cb-fbc3.emome-ip6.hinet.net (2001-b400-e3a6-b683-040b-c296-04cb-fbc3.emome-ip6.hinet.net. [2001:b400:e3a6:b683:40b:c296:4cb:fbc3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74d36911sm71799335ad.0.2026.02.23.03.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 03:17:38 -0800 (PST)
From: Kevin Tung <kevin.tung.openbmc@gmail.com>
Subject: [PATCH v5 0/8] Revise Meta Yosemite5 devicetree
Date: Mon, 23 Feb 2026 19:17:32 +0800
Message-Id: <20260223-yv5_revise_dts-v5-0-fc913e902488@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAEw3nGkC/3XOTQrCMBAF4KtI1kYyk6S1rryHiMTMVANqpZFgK
 b27sSD+FCGbl8n3Jr2I3AaOYjXrRcspxNBccrDzmfBHdzmwDJSzQIUWAJayS3Y3PuQd3aIEZFB
 MVFkqREbXlutwHws325yPId6athv7Ezxv/1YlkErWnoq9MflU5fpwduG08M1ZPKsSfnBUE46ZG
 yqJSwXe7vmX6zdHqCZcZ+4dkHV6iQr0LzcvXuThdLsZt1dojLW1dl+fH4bhAQq6EKZpAQAA
X-Change-ID: 20251118-yv5_revise_dts-12e10edd95d6
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Amithash Prasasd <amithash@meta.com>, Kevin Tung <Kevin.Tung@quantatw.com>, 
 Ken Chen <Ken.Chen@quantatw.com>, Leo Yang <Leo-Yang@quantatw.com>, 
 Jackson Liu <Jackson.Liu@quantatw.com>, 
 Daniel Hsu <Daniel-Hsu@quantatw.com>, 
 Kevin Tung <kevin.tung.openbmc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771845456; l=2248;
 i=kevin.tung.openbmc@gmail.com; s=20250924; h=from:subject:message-id;
 bh=sn95Kmv45LT872ri2FvDg858dufHQIsNYNwjQItqP04=;
 b=v9ocOnlabQ3l+MXROW2xlibhQ+Stuu0mjZuPPNQc9/VkoFtSyBlue6Pb43vEUHQ+dYfMB/lq1
 Z6Ft01u9RMmAL4e3UaGUEgyI6T1earuY4MuQ3GCfeuhDnkhYI3JT6xr
X-Developer-Key: i=kevin.tung.openbmc@gmail.com; a=ed25519;
 pk=PjAss0agA0hiuLfIBlA9j/qBmJaPCDP+jmQIUB6SE7g=

Summary:
Revise linux device tree entry related to Meta (Facebook) Yosemite5.

Changes in v5:
- Fix host0-ready and add POST end GPIO
- Expand PDB and HSC abbreviations in commit messages
- Use IPMB consistently in subject and description
- Rewrite "Correct power monitor shunt resistor commit" in imperative mood
- Link to v4: https://lore.kernel.org/r/20260130-yv5_revise_dts-v4-0-4d924455f3a7@gmail.com

Changes in v4:
- Add PDB IO expander device node
- Add GPIO to bypass OCP debug card commands
- Expand commit message explaining the shunt resistor correction
- Link to v3: https://lore.kernel.org/r/20251219-yv5_revise_dts-v3-0-ca1d5a382013@gmail.com

Changes in v3:
- Correct power monitor shunt resistor
- Revert the previous SGPIO P0_I3C_APML_ALERT_L renaming change
- Add new SGPIO line names and rename signal
- Retitle Update sensor configuration for more clarity
- Link to v2: https://lore.kernel.org/r/20251120-yv5_revise_dts-v2-0-4d7de701c5be@gmail.com

Changes in v2:
- Add ipmb node for OCP debug card
- Link to v1: https://lore.kernel.org/r/20251118-yv5_revise_dts-v1-0-fcd6b44b4497@gmail.com

Changes in v1:
- Increase i2c4/i2c12 bus speed to 400 kHz
- Update sensor configuration
- Rename sgpio P0_I3C_APML_ALERT_L

Signed-off-by: Kevin Tung <kevin.tung.openbmc@gmail.com>
---
Kevin Tung (8):
      ARM: dts: aspeed: yosemite5: Increase i2c4/i2c12 bus speed to 400 kHz
      ARM: dts: aspeed: yosemite5: Remove ambiguous power monitor DTS nodes
      ARM: dts: aspeed: yosemite5: Add new SGPIO line names and rename signal
      ARM: dts: aspeed: yosemite5: Add IPMB node for OCP debug card
      ARM: dts: aspeed: yosemite5: Correct power monitor shunt resistor
      ARM: dts: aspeed: yosemite5: Add power distribution board IO expanders
      ARM: dts: aspeed: yosemite5: Add debug card bypass GPIO
      ARM: dts: aspeed: yosemite5: Fix host0-ready and add POST end GPIO

 .../dts/aspeed/aspeed-bmc-facebook-yosemite5.dts   | 117 +++++++++++++++------
 1 file changed, 87 insertions(+), 30 deletions(-)
---
base-commit: 5d1d2ebbfe226540c630e9998374e16dad2779e4
change-id: 20251118-yv5_revise_dts-12e10edd95d6

Best regards,
-- 
Kevin Tung <kevin.tung.openbmc@gmail.com>


