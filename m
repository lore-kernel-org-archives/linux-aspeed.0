Return-Path: <linux-aspeed+bounces-2720-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26830CCFA03
	for <linux-aspeed@archiver.kernel.org>; Mon,  3 Nov 2025 22:41:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0mlQ35YLz2xgp;
	Tue,  4 Nov 2025 09:41:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762162408;
	cv=none; b=Qu8vDYJOIAONgTkuY5a3I5ytehwdRIJmT1+i6X6/tuz8bd4xxpUOS4JlqhW1+nBQzPdIlArj/sw/ygK3i/F+yJ9zVpCjhI9KtMQVlldclmOnJeiJt/+Mu8grPtFOy8sCZl2XwxLwA/5VCTbECZywHggtQe9bm4nyX+pFTy9S3ZX0AFflzp2Vp47gpBqrMy2LVUfksXjd1SVTp6dVntvDkc0r8Su8m1aTrV5BCCx+YHLenuYkre2x8WNp/l09SPVquVkSt52qVj85s8dvGY5qgwskYuOTlDydUFONOaI3MXeQVLRQe3UkSPu1KvNOlGkJDfofIiZGFK5Py/fW8MsY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762162408; c=relaxed/relaxed;
	bh=fi7edW2fKbyqZ3kHK/AlGvcaMEfMr3O/Cmh61+xdw30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SimWTGgr8YQfLZYf4DsltiN2SYSJu39A/7sg/WZGmTheqanVSHvC1wi54k+Wj1g3vWupZ0wX13Bc10/GgYQgv/8CEYyaxDGV/KQSjmalKA/iduk7Hry6gsKw5A2sxrUXfmCxGqzWqvM0h6m0byJi//04BQWidqznBKvWd9tXM5xGcwGvudzrL35o+l4Mou9NMGuNg3NguQonbGOInGbZLeqBjbR9bUwaswwQiFRHZFfPSBt7oaAUsl3rU3kbL9sacLG0XiHmDsvFJfZxoaLhBEm+v+Hv1UhTmA4FSRv3rMEX7TlrXfaata5LpAAfwGdB5/OpsIYx5GM5VLKDTHJJQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZrxIKwic; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZrxIKwic;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0RGb0NG3z2yFV
	for <linux-aspeed@lists.ozlabs.org>; Mon,  3 Nov 2025 20:33:25 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-29599f08202so12399585ad.3
        for <linux-aspeed@lists.ozlabs.org>; Mon, 03 Nov 2025 01:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762162404; x=1762767204; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fi7edW2fKbyqZ3kHK/AlGvcaMEfMr3O/Cmh61+xdw30=;
        b=ZrxIKwicrUIuUr4uo1jEmTkC9STsOXWcX8mbWTqh4mrFtlEW23DLlM3z6uh7KFSDFm
         SGsgga1xkAWmPW8MTx/NHYvEtSBIvUgUzap1DonfEkcX0SmYtySPJqwPnWp/07ZVaE97
         VpvzUL8DoZX0gsmnfBHhNOW9Ci4kd1haEaRlSROqoQnvEJ/wwtrdN4YB9grBCoY91fio
         HBYOeYsfZA1VyoAAbIDkhfvaVNEHN0MQXbntR+6Jx6sYPfj02p7vcR2rjyEuhyoKYvnn
         dSUQ6kCUWwSGOqJUpY/cN+hnhjLqe1i61fjxmh9IW8q0CZRu/eW7+Ts/42zysJsoB7YG
         WqEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762162404; x=1762767204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fi7edW2fKbyqZ3kHK/AlGvcaMEfMr3O/Cmh61+xdw30=;
        b=bNFkAnvDb6sxPELdElWJ6wRILdyeLyGFgbCNmhT4YBAGMUeJwl7hdUukTx3La1CNdF
         1HimFqZKGcGmdvsLblV/6J9PTYE5TwFY04iw0sBXVWokIeKMMQ0kdaS4aODtmi3XKttU
         Sjm2tYCOuH3Arf9OLltX5hWgggUFbUWdhUXes0efdX11SdWn1LJbOQXCS1iwYMtAqN6S
         0/aytdWZsLPytjT4gwa0sSdavSvuWgphltqiAMzFtc/2AOelV8g2mjVzB5Wz3rTMXk/r
         YwfghjDlyfwvJGaPKzsW/V1ahRzuH7nNRVx5mvm37ur8ut6DQRToqOyFvgGNT5zr+ke8
         Ddlw==
X-Forwarded-Encrypted: i=1; AJvYcCWkdbI/qkx1uzpQGY95NkGgAeQqKzm0Lwg3YZe9A3z5tObGfIaMxA76pRmqQ9c9ls7Cno0neR6lFd7YvR0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz7P9w6KHoqPt08Xm3lwIDo989BjmGXrVyQ8y5nNcbwe55Gf7MQ
	J07ae0XLMTXYiOSoauZUCoxxyzJkL41mNRNKWZrVy4KmBIkeK77pP1Ia
X-Gm-Gg: ASbGncvp2L8s88r6RePOX77nHFj3358zphLfNSg9WiZQiV5V37x3YCPOt8fCrU7ykMo
	lWu6BUQNYU4Ejov0toJFLo67PPhjgxrqbrrYrKvgONK/dTRjv/ISdwAuqw17u8uHuPFkLxqBgUy
	8/2mp+qOS5bwn3W0vxdZs3ica0JTDrUW/DHZxwOTp/OWL4A5zIKy9oYBUE28hhC3ZE0skDJFvRL
	CZAOYsl5Sql4QH6B0AZy9CBfMjizAbZvO/3PMMVPX4RQoOKMY6zF5s5OZZrKr3QDLJvT66dDTjj
	ZdBFyTxViI5ZdGNuaC9+ANm4UNicSp0H7BL34eu4grUDrnEKBCpA6bNNyFCKiNrGR2uKfwh8WQT
	bVKpO+r0ISCnNCM6Nuluwrw6yB8QC0RK7q8bVgm6KkMe+3GvtXfYahxdbpgMKAdC9S+LbSg==
X-Google-Smtp-Source: AGHT+IEhVI8HLKKsPHJmLdcgQIX3NyE6Qj62NyZlp0rKKc1HR0bkXg6Og36M1Mf5WeEiO70N6uA3uA==
X-Received: by 2002:a17:903:11c3:b0:290:c5e5:4d90 with SMTP id d9443c01a7336-2951a524561mr137993865ad.42.1762162403672;
        Mon, 03 Nov 2025 01:33:23 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952696ea51sm112351435ad.57.2025.11.03.01.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 01:33:23 -0800 (PST)
From: Peter Shen <sjg168@gmail.com>
X-Google-Original-From: Peter Shen <peter.shen@amd.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: Joel Stanley <joel@jms.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	peter.shen@amd.com
Subject: [PATCH v3 0/2] ARM: dts: aspeed: Add Device Tree for Facebook Anacapa BMC
Date: Mon,  3 Nov 2025 17:33:18 +0800
Message-Id: <20251103093320.1392256-1-peter.shen@amd.com>
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

This series adds Device Tree support for the Facebook Anacapa BMC 
platform, which uses the Aspeed AST2600 SoC.

Patch 1/2: Adds the compatible string to the Device Tree bindings.
Patch 2/2: Adds the initial Device Tree source file.

The Anacapa BMC is based on the Aspeed AST2600 and includes the standard 
peripherals required for BMC operation.

---

Changes in v3:
- Rebased onto the latest upstream kernel tree (Linux 6.18-rc4).
- **Fixed all indentations from spaces to tabs to comply with the kernel coding style.**
- **Updated the Device Tree Source (DTS) content based on review feedback.**
- Resent as pure plain text using git send-email with --thread option to fix broken threading and corporate HTML issues from the previous submission.

Thanks,
Peter Shen

