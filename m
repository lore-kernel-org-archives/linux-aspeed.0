Return-Path: <linux-aspeed+bounces-2836-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DF3CCFA0D
	for <linux-aspeed@archiver.kernel.org>; Sat,  8 Nov 2025 04:41:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d3NYJ43v0z2yqh;
	Sat,  8 Nov 2025 15:41:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762503754;
	cv=none; b=NKyJKnLfon4mCYfmrAIV44FPiu48zjEjDlDz6IHPS5hj0uVrYK3Q3qYGhUze8u5EH8E5GQL1k7vRC4KKtDIY5RK4iURrN+6lXVo6zxyKv+7FidbhpZLE2cRAwNzx4mLIGD8OhVEs5d6pcHHC0/6K0vLiAGusCvS+SpzjSZi0r0Yp+ZNcHHtuc/hLS2xcEfy6ktFyjvpEbv2WMUh8VadGfB8m6M/4FkH3uK8bpqtXScPKVwIBSb24ZxrvNbm73AKl/0nsm41HMB4RA1AC/q9jWRyG544QD4NDobfpad53YZ5Azz6GCR0xaWbaK+y+Dd41MI8F23v87LJ1uzu47efS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762503754; c=relaxed/relaxed;
	bh=OMpWtxvVnB3sDu3M9k8udEVrpO3wTQipx27cDHb5FFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=M4SybYvggRWJflFZcT51SsNEbP+MQj7YQ5O09lp4CAK0Y/cs+dPfo928+y0eNpOD0igrCvQxQiXZBfOR+Li4hW064tZofji4Yabhz5dZQBI1akupBnuJd5/t7HvbSaW4Q1T3KZb2/rivS3Pkd8J+Ima1LTDZLKoYh45W9aG6Hie/UZ2USgHX2qEvMbe8dIM6DEo2w0uTQs59/rSCIn+0mNAqz74fEIErSv10MWgaKtakL4WinHgp7BDYElkhlg+XpHOypgbbFGzYwdBFeGhHCuZMlJ/GgJBpQblwrsqCkS/9wMFhmu5d13BXUcfgUOQ46FGPoyR0k/6DKb6gYQSL/g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dk1e8Huy; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dk1e8Huy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52a; helo=mail-pg1-x52a.google.com; envelope-from=sjg168@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d2sVx3NP0z2xPx
	for <linux-aspeed@lists.ozlabs.org>; Fri,  7 Nov 2025 19:22:32 +1100 (AEDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so299154a12.1
        for <linux-aspeed@lists.ozlabs.org>; Fri, 07 Nov 2025 00:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762503750; x=1763108550; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OMpWtxvVnB3sDu3M9k8udEVrpO3wTQipx27cDHb5FFw=;
        b=dk1e8HuyZREnX5AZN/6pPcFr2lAkLlrzmEMIIHxBEDCTTZYeZ50lQNf0UHZ/NNw+FS
         Ef8AT3cVHEHyu36sZrnP2ygwW9gbEAGdDCzLPucPnPoR+P3L0yvSWgmmVhzPdQxabNyU
         69ZiAdKMEuQg32F2d1cY5qfUThO8YB+upfxrtFfwylZ/t8biCETWLsQtdfnzRsnqbgqd
         8x5mDQqfue2FxqRJVKpRprrt45XMeAKOBLf+mcJwzvutNwsgmQ82g0TxdNBeIya1rQZV
         I+449Vjx60pHF+i9ybwIMrnXALGhJT3SQ1SJ4BHcCL7BP0XkSmsnNtkCLlgLA9b6Ix4J
         3l/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762503750; x=1763108550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OMpWtxvVnB3sDu3M9k8udEVrpO3wTQipx27cDHb5FFw=;
        b=oVIZFF4cB0MpzrjFul7po7lBgIjkgjBLQkihfKLHJPR5R/Ge9IIo/dewgdGCAEmiX2
         KfwaX1tz/h/blpe5rkSIyePwwEDQ0tGoezEXrd2tO48w+hl2DKnKMNVuEA4h+JFcxtUu
         ggQ6oRZzFGHQ+N/gpXPL+Ox3sssksEv6RHTb+fYOWMr39aFGbgQnJdqlzfegx7snOXd9
         4Dz+3rmruOc+dw/cZeUMjMJRl+o111j7YbUVVetdl4zAqDlmnru5Yow/V+wdSOwNiJ7p
         KgiquhDThqQvxObraGFCu94oB+DAaSXbOP/W4XOtt/5AK0mL5+XcUOxeTZSVzgzjdoAz
         MqTg==
X-Forwarded-Encrypted: i=1; AJvYcCWltFk1NaKcYUwVWflcK3ZtZoUlnEo3aRon+6ENQ3eXzS7YlVo90o5ayyvmNaI1eKHgxshyu6A9wpZgRt0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywqiy8GcnLalW7QaJCB+OJ7SEgUyUm95969/ymG8OtNJ90Hb3tA
	pcp8N0xcq1GJhj77SZlipe4aNo6skNoTqbLTmhyzsYOIAYBuog0G8OBU
X-Gm-Gg: ASbGnctrsJ20CkXw1siCH/LR196wjGhdwSmqm+ZEzpA1+IHcVpaqSMt9gQqj6ZoYJ6J
	2KZ80GqSYZmGXtPXswek/mcEPR73sNvrkKJO8QkcZuf8h1K1LigoHRy/UkO4u014hrGNHG7KWpQ
	DBu91kYGYkf1DwC2cd9BCQM45evyFryuVQMdUpEfWpK+AvgHiFW1BqkvreyEMlbCEUrQpYJWtWv
	fGOAKKW8dLUWhsrPHlVUBdy8HtYAxRcga2MpANQPng7IDyUoN0nXyUKu9EciT8sfEVc1YGaD0R+
	QxveJFsqEhtb5r7MNnOJRWTg0V/r6rg+Ux21mxg4djH0nD+z4nzw5n5bLkgRhDKhAoqJbhrQOtk
	qupjWWjgtiyP7dSlru1V0VxL36EP/AewuFf7gtcdkVe34BFmKirpbejBWLn/NWFck1hk=
X-Google-Smtp-Source: AGHT+IEjlE5AsnLv0b9J+7cxEwQxpex1D5LYp+e+gM7rZYr6pY5wGjltZgYlA4C4hvMPP7ucQVOe4g==
X-Received: by 2002:a17:903:a90:b0:269:8ace:cd63 with SMTP id d9443c01a7336-297c95bb193mr13342035ad.30.1762503750491;
        Fri, 07 Nov 2025 00:22:30 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5ce87sm51494325ad.29.2025.11.07.00.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:22:29 -0800 (PST)
From: Peter Shen <sjg168@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Peter Shen <sjg168@gmail.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	peter.shen@amd.com
Subject: [PATCH v5 0/2] ARM: dts: aspeed: Add Device Tree for Facebook Anacapa BMC
Date: Fri,  7 Nov 2025 16:22:23 +0800
Message-Id: <20251107-anacapa-v5-0-peter-shen@sjg168>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251104-mellow-denim-dogfish-4affdb@kuoka>
References: <20251104-mellow-denim-dogfish-4affdb@kuoka>
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
Changes in v5:
- Fixed the final DCO mismatch (Broken DCO/email chain). The email sender address (From:) is now corrected to fully match the Signed-off-by: and Author: address (sjg168@gmail.com) to comply with DCO rules.

- (V4 Changelog) Corrected all previous style issues: fixed block comment styles, line length issues, and removed un-documented/unused device tree nodes (amd,helios_cpld and eeprom@53).

