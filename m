Return-Path: <linux-aspeed+bounces-2881-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D342CD4857
	for <linux-aspeed@archiver.kernel.org>; Wed, 12 Nov 2025 22:51:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d6JXw2vVTz2yvL;
	Thu, 13 Nov 2025 09:51:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::632"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762981977;
	cv=none; b=Tdpr8gI6E5Soa5fQRJCspQOgUbiYosUrAlCByCYG430gw49fc1f3IfTfwX+wei33nLq2pjYiujtuznK2b6+OaxB1C1iFKES8QTQIgmh6/ve+tX/bU8xK/BZ4bqFmmFtloDqK9fAroSHD5QBxrGO309y4NyWaGoR8062noF535gu912Jbvzzo72XfuLQO83Yitm77J2KC6IrQ5nlFN5iZlT8pY1jJa4b+j1dYVNVl7af5pKJgtTq/n8UAh2R4C+dDJ1XGd92lWQ4/LgH+61u7ViHtN2fHdM+8QH4sE/BtTN06rYrOohwRq9MSW6L3Ii4mUF6HDye4+FRlc91IU29UEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762981977; c=relaxed/relaxed;
	bh=RZJdhn1bhOKDxWDWTYIA7jJWtzp2FszzhJrftJY1t94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bE2dYWeIbjL3X40hy+SnJoAv2SZIEZ7gyCQcbCd9EGBQKEvuL+jMALqeYVNNR1TK5zHoza4r7BbDHHG3Cq/HJYaP3nN1N3BVHCwoxc3xWpfRJ/Cr4tF/ROXHGG7c/wLEYqZyF/Q3iZbzXPvFFqa/bm1d29rd3FJEiIp/UxfmHDvcz8osBadqtIILXH+yhNBzbacRBhDn04JyZ+uvlb30DbRYhT1GYzuh3qaffzSXAqgXrnhNF1x7j0uvt5BqmQ0xevVq5L1Ep0/0jNrXD9Ld6AjSwNJlrsPvEOnjWyZpBfzTqdfV5dNScGLXFGE6sRnxZvlhCCT9IOdoJyevrsCqVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UQ2l1nhj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UQ2l1nhj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::632; helo=mail-pl1-x632.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d6GMX4cVsz2xFT
	for <linux-aspeed@lists.ozlabs.org>; Thu, 13 Nov 2025 08:12:55 +1100 (AEDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-29806bd47b5so516275ad.3
        for <linux-aspeed@lists.ozlabs.org>; Wed, 12 Nov 2025 13:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762981973; x=1763586773; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZJdhn1bhOKDxWDWTYIA7jJWtzp2FszzhJrftJY1t94=;
        b=UQ2l1nhjpO7UeXHyUDPULrHnkHT8huYWtSUqj22wYiTt7BqpfpvX+X5SDYzrK5ZFsI
         LSvvvt0K3cIwcEoG+UFAeDFM9XVs2KAHZtEn1eL+91rnvcxXFcimkrVe3j9EuxAtSl55
         qwiUxbc2gQWxTEqj3gyCKlWaOR1Z8JoMrI36ex/CJAWdataTZqxQN/ZMEcWeAozvjNcC
         q/DSiYmKk7n+blMAWFC73zZ6IrxJkjlzzfLrtPZyJG420g9fCGgVE1rY6LXA3nYU+Hz1
         n2AJzWEFJsLhuhoBTvcgvsU661Z0jEGVvMLhlyzlLVkoEiG81HUfz7iaN6CZYFnlQ2iE
         L5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981973; x=1763586773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZJdhn1bhOKDxWDWTYIA7jJWtzp2FszzhJrftJY1t94=;
        b=X6Y8u7uEPxbzHxFPU8/GZdF2btm/337JyyCnpDpiGQ3CIFivehiYCZ8qo/bBBOWUZT
         wy0SvFWqwjztqWXks9q8l3qD70VKtZTWEgnAtV0QNxz9rGqcTsmjeHPwL5RTcZ5JPQ9Y
         D2UIt+d7YhIkUGpbIxd+lJsUNvHS93foQ1KXQxJmXhFHod/caTJ6bMKqRahFaQzuPm+g
         owLya6owyZRrJqeEezIVNjT8W5+EcYBKIzqzT+W8lQOy1jLHv9C9eq0AUzKei+WBtaiW
         qCo48q2rDUTKDpp+h6nS4QjzQyxgUeGtV58k0Lwunume/Fnic6+cBrjXKcVWms0L4Zr/
         U39A==
X-Forwarded-Encrypted: i=1; AJvYcCVwMs8b3NB91Vv3Gl3lTGuU9AUUlEdIiCNU163W2jY4PQzOZxA3jwB79vKNut7bu5zLvMznahc/kvt990o=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzwFuLWNewXei8rTC8f32pzDaYxZ/8QaHOyPrw8ZtsBhR+xiVQh
	vHnQ6NCk/gB6tWRfsym/8VoJdwswnHss/Jc60I70Kj7dm+HuVSobGNSv
X-Gm-Gg: ASbGnctU3izaSemppAf35D4+f9OGqC0nxkpkSSx4Jb1rirY2BNJ3ZDDZ2bgKzUn7Mhu
	jpdpZj6DLkpbhYvhtsmMR/Iecs+nLjDD7LP6Ov8zfynNZ0cmiRg6uF6Zdj9BeFrm6MRmVHq418o
	CHmhdAO9lEp05tmMCWkMgoIzFZu7OFEfvAczJqpS12Et9tlXdRNd5P8PaJ05B1fV46nMPELD1qe
	Uga5s7or7ePdh58+8WAiunwO0raTD65E9BMxToparewp6QqwD+9P+BrnCh6cOS1bVKPt/15SgJB
	zOHnttZV870CA2SPalNpHr/N16Xh8Waajd9x5Bfq7kTuELbxwQ/IdoxLW8KBbiPXrNHm0Do9lhf
	I5dvWKDzW1oSAks85g25GAN7Pje49kMitnEmgu8F4+VV8mradb5s5MNXZu6hTNkFcdRk=
X-Google-Smtp-Source: AGHT+IFeIihBkU77ETtw+XHaa6KFXIJgpjHeG0dAkdR6b1vkSG3JvHMNOQ74vp6k+nYvvBf1xBPKlg==
X-Received: by 2002:a17:903:2f88:b0:295:557e:746a with SMTP id d9443c01a7336-2984ed34126mr48888625ad.13.1762981972686;
        Wed, 12 Nov 2025 13:12:52 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245ecdsm1011525ad.32.2025.11.12.13.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:12:51 -0800 (PST)
From: Peter Shen <sjg168@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	peter.shen@amd.com
Subject: [PATCH v6 0/2] ARM: dts: aspeed: Add Device Tree for Facebook Anacapa BMC
Date: Thu, 13 Nov 2025 05:12:46 +0800
Message-Id: <20251112211248.3711889-1-sjg168@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This patch series adds the device tree binding and the initial device tree
source file for the Facebook Anacapa BMC, which utilizes the Aspeed AST2600
SoC.

The patches configure the necessary platform peripherals and aliases for
OpenBMC usage.

---
Changes in v6:
- Rebased onto the latest upstream kernel (v6.18-rc5+) to minimize potential merge conflicts.
- Restarted the patch series submission as a **NEW THREAD** to fix the incorrect threading/In-Reply-To usage in v5, as advised by the maintainer.
- The email sender address (From:) is now corrected to fully match the Signed-off-by: and Author: address (sjg168@gmail.com), fixing the DCO mismatch issue reported against v3/v4.
- Corrected all previous style issues: fixed block comment styles, line length issues, and removed un-documented/unused device tree nodes (amd,helios_cpld and eeprom@53).

