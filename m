Return-Path: <linux-aspeed+bounces-3639-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CA4FD88CD
	for <linux-aspeed@archiver.kernel.org>; Tue, 10 Mar 2026 23:11:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVqPZ6PB6z3bmR;
	Wed, 11 Mar 2026 10:11:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::631"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773136191;
	cv=none; b=c9NS2sjruLYe0Do3Sy2ESgycZsqEqIbD7DuED/i+IIjPU18LXFAZGsJjwD9UszCBpP+thXliPbbukMBNZ5hZyyoNEamJPfhHx2XWyfK/M32TZY4riw1ja61Z4vDhGJxMBshHq3n5aX8KRugzHadyMigwetDognfSeTOkF7gpME4fwTkKe2G3PjfXlXHUpXycAXUxJgqIFyqsbXegwxEMnU5zf0LIQvnL66e9d1qaTZFZ0aBPpq46tMMGbFNNt7vFqaJ9fX1AvUM8YDEJnNjBIQquwrJFuBXr1NG6+zfdJ6PRd+tFoay7deqYeaeIoKykiGJ513r8SIeKM4RLYuk8hw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773136191; c=relaxed/relaxed;
	bh=zu+81jDXj9d0HvQyIrVJEIl9QbnoaIQZGWZhl1u/pfQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RaUPf6yzVgssiwxlanAE+kzKeFHCpIK+qFBXhpDKC5YEKOEwnBh/y1xREwa6YORdMY55kyLAwHvoJqmA51gP4C1A0f7nzFhm4mIsR3O2b9m740SZ1sxWnGPmwXIaN0NQ7tuTs1CCGZGxcLfS3KYgsNj4tUeknBRzyf3plLgp6Z9f0PLG1NOs1OSPAAP+JfNG54qnmqzWYTA1mP5XuqVbAUY74zkKqT9TEWAoWLmt4VA/jo2/TE5Ru1TjMn9LsEYn+po4T2dS6Z54h2aTMZHLk0HgPurx6vvjR7M9y8ghQfK9PKNlFvKa4EeO6Rg/3Hnsk7XH+zYkIUK8LVZ0xceQUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lGGT070c; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=lGGT070c;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::631; helo=mail-pl1-x631.google.com; envelope-from=u8813345@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVTct6VPlz3bjb
	for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Mar 2026 20:49:49 +1100 (AEDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2a8fba3f769so55365585ad.2
        for <linux-aspeed@lists.ozlabs.org>; Tue, 10 Mar 2026 02:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773136188; x=1773740988; darn=lists.ozlabs.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zu+81jDXj9d0HvQyIrVJEIl9QbnoaIQZGWZhl1u/pfQ=;
        b=lGGT070c/CduY/xPBXw/uiuSHr/KVqPBjq/nvBDX9M+sj+HhsGSKFTdLonMha/3QaZ
         Q/TKCg2AkIBUP/ywH1i9jKgvX4XmplZ0bSfyWDZz+r9rMM2s7+dkAt7QTmTtFglh+eEb
         2V0DzosiD1hHufCIAw3hGequbein6FRegkhXxCXav1w0jiMNX1AfYa7grwqcj655TIbj
         2AsYUrbJhEMtiW5vmulocF/CwWDT2XPLmnEKqyxVNHvC6ex+E1nGc5JIQVoh4xWzGJRE
         l/ZfSy/eDGfBKaP24x5JcdnE6FE0GJhVQgXTT5mbnhqjzfTZQ8wqd+7yayHZpcv+LRgt
         Re/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773136188; x=1773740988;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zu+81jDXj9d0HvQyIrVJEIl9QbnoaIQZGWZhl1u/pfQ=;
        b=M8t2aUHjRfJHugnastfbghScNEIaP1Avl+PtJMyRUbx+uHlC1OjUpQ43TnqDwXRhx+
         OYs/ft6GYBADl9yUr1AVYXB6j+d/M6WrV3PRnTIgDtVyC4Mh39qdPJK4UPWdNxi/3mUm
         ZXyAup8z1/jN7IgpojB5q3VY0hIEQ4gt1dBJUVC5eagSPpH+KTrSnBV1KmqNMI9Lb0EV
         4BI4+3cmMLlYtKzA4xEY6HwvE+NHVd3DWF44ZnpqiroYB6Q18PKU3i1v9eAOebASus/o
         kK9gBq1ixExXhtxOWdRjPiZNu0t3TM1pOpzfXDYiSzMphgEOL1hLKHdR+o89Jle+ErJB
         7fpQ==
X-Forwarded-Encrypted: i=1; AJvYcCV44FIQyF1Cg9BbVJtKQtv9bwRVn5DcaQKtCo4uOyX4z+UOVUvE4mLhqpl0dccKYd5YxMXR52Is/AchV58=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywm1uV4Iu6KW7PsRXDU4MbNn3IESZC9UWJAQxDInsunsj0eAUoT
	DB3aKXLh4+bKulVxyruepaVMzSvd0W/PzDREKmjDFAcHczAcYC++nidu
X-Gm-Gg: ATEYQzwIYAoUGHWsY2HDI422xjLYTr6LAU5kS+E9FxsF34/eBE6lOqwFMWLLPrzrOZd
	2Gp7gynC4C2HhBJ5a5JdZwvo/vC5nlexHagS8/uSFfeWQ8QrcUitnvG5L5CdX/qHHGFyynKUnd+
	Zf9de04jpbL/c9FE5YJY5QIHCVFSCOOe0Q1WSoZQ9lqs9kBtqlr+WXp/tOuyE0Kif0NM9I6338i
	OiAZ1nHlqISiIhi6IfTrZll9NImfa7BCnDMfzQxdettPDwnSDRaAiLCv2zsdht9+gqcJ8yrHSaN
	zxCJvhXN0/Lwg0JgOrB+aCcpPW6LJFTmMMXALJmJ7LEsu2biFh/HW1LP8xm71ii9JGzIKrDdkFH
	YpBDDZlw1a/0cezXju77gLNO8GwGITilsS1ar6eWt+pltz8TVH0iz5G2ScLLSYeE6GSJaYSADLG
	HVxh8D5X9jrM+nPhFZWE0=
X-Received: by 2002:a17:903:ac4:b0:2ad:c66d:ad06 with SMTP id d9443c01a7336-2ae8249420dmr139061195ad.47.1773136187586;
        Tue, 10 Mar 2026 02:49:47 -0700 (PDT)
Received: from [127.0.1.1] ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f8a67esm199459775ad.61.2026.03.10.02.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 02:49:47 -0700 (PDT)
From: Colin Huang <u8813345@gmail.com>
Subject: [PATCH v3 0/3] ARM: dts: aspeed: anacapa: SGPIO updates and
 interrupt wiring
Date: Tue, 10 Mar 2026 17:49:34 +0800
Message-Id: <20260310-anacapa-dts-sgpio-v3-0-12d9b7f1202e@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAC7pr2kC/33NwQqDMAyA4VcZPa+jrbOWnfYeY4e0jRqYVlopG
 +K7r3ryMHYJ/IF8WVjCSJjY7bSwiJkShbFEdT4x18PYISdfmimhtCiDwwgOJuB+Tjx1EwWOVxQ
 Waqecr1m5myK29N7Nx7N0T2kO8bO/yHLb/tOy5JJDBY0VVpimFfduAHpdXBjYpmV1EJT+Jagit
 L7RRhkttTVHYV3XL7rXCx/0AAAA
X-Change-ID: 20260202-anacapa-dts-sgpio-e4e0ba5c2cd5
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Colin.Huang2@amd.com, Carl.Lee@amd.com, Peter.Shen@amd.com, 
 Colin Huang <u8813345@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773136185; l=2227;
 i=u8813345@gmail.com; s=20260202; h=from:subject:message-id;
 bh=lwETLfhCTVcdz3eoaOCi8pmBQa817MjhbI42mJmTS9Q=;
 b=LwoyJoDM1URyDCkYkC0JUVd7eMBMGf8tVEmyKmbEUcD16BHR0o1X7SOg7DN8/xLhhWQiT3Ltf
 us/voIpeqrgAPzOsY0DDAabHvVGhmc7iovEZ4O09xR7b5la/jWLu3Yo
X-Developer-Key: i=u8813345@gmail.com; a=ed25519;
 pk=Zlg0WqpCw4qbswOqamTBTXIchwR/3SnYZpy7rjaGMdQ=

This series updates the SGPIO-related device tree definitions for the
Facebook Anacapa BMC platform.

The original change was submitted as a single patch. Based on reviewer
feedback, the update has been split into three logical patches to
separate concerns and improve reviewability:

1. Fix SGPIOM0 GPIO line naming for the RMC leak detect signal.
   This patch corrects the placement of LEAK_DETECT_RMC_N without
   changing functionality.

2. Update SGPIO GPIO line names and mappings.
   This patch reworks SGPIOM0 GPIO line names and signal assignments to
   match the current hardware wiring, improving correctness and clarity.

3. Add SGPIO interrupt wiring for PCA9555 GPIO expanders.
   This patch connects the PCA9555 gpio@24 nodes to the SGPIO interrupt
   controller to enable proper interrupt handling.

Signed-off-by: Colin Huang <u8813345@gmail.com>
---
Changes in v3:
- Split the original patch into three smaller patches based on reviewer feedback.
- Remove references to external documents from commit messages. 
- Link to v2: https://lore.kernel.org/r/20260226-anacapa-dts-sgpio-v2-1-fd76828616b8@gmail.com

Changes in v2:
- Add interrupt-parent and interrupts properties to PCA9555 nodes to
  enable proper interrupt handling required by phosphor-gpio-monitor.
- Clarify DFT motivation in the commit message and mention the source
  mapping (Helios_SGPIO_BIT_MAP.xlsx rev: 2026-02-16).
- Minor wording cleanups in the commit message (line names vs. mappings).
- Rebase onto the latest tree to account for intervening commits.
- Link to v1: https://lore.kernel.org/r/20260202-anacapa-dts-sgpio-v1-1-a3a7b0b087f0@gmail.com

---
Colin Huang (3):
      ARM: dts: aspeed: anacapa: fix SGPIOM0 GPIO line naming for RMC leak detect
      ARM: dts: aspeed: anacapa: update SGPIO mappings for DFT integration
      ARM: dts: aspeed: anacapa: add SGPIO interrupt to PCA9555

 .../dts/aspeed/aspeed-bmc-facebook-anacapa.dts     | 149 ++++++++++++---------
 1 file changed, 89 insertions(+), 60 deletions(-)
---
base-commit: 710dbb13377c80a6e39ef049a517665841e3221e
change-id: 20260202-anacapa-dts-sgpio-e4e0ba5c2cd5

Best regards,
-- 
Colin Huang <u8813345@gmail.com>


