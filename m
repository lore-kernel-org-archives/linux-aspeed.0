Return-Path: <linux-aspeed+bounces-4275-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E16CD4F26
	for <linux-aspeed@archiver.kernel.org>; Sun, 21 Jun 2026 00:46:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gjXh24rzwz2yY0;
	Sun, 21 Jun 2026 10:46:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781961124;
	cv=none; b=NBEJXfH3go/+Ww0cTLgusCXkV4vXx9rUNTLUZMXC6sIpYzqUM5VlPmWk/Z539kds1taN9F7p6tlm5cXGDdlZ72wghMgLnxTYCs9WZVL2xMSxgLrdaiQTVjYr65x5ARvnq/57F6ey+JBgWrOscc7ewgmzlU3HfaUiQASIl90K06GHdBzHLCbEvTjX7f4gqCF+6/jZEJVe4e7gl9EL2gCJ3RAcXkgKALdSnTN0LK9GOi4f8X49Ztz+BJL4QVfsTCUyJE3o/aQRxcReSOWREDdXI7S0xzW+C50dW3DkAbe2q3MB2bySezCqnPBT5K6n5jTFFQBY5XwtzPYXleFsmiLEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781961124; c=relaxed/relaxed;
	bh=f1gzIf8fgHb7Ze/dJb/40ZOzqNvNSD6l3yJqC/XWnEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UeI+3Q3oZ/B0GJ/rbj2kCa5CGSYc+001phSU5q2W7F1XyWaJom/cxSqHZJVjXqjFwZy96RieHu9WevMD2cFOPuTIHdUeI+TN4VL5ExLH417mbghuPDEcz5U6FHBCj8xPS/MKt1b0PCoatabSoNfsccVhf1BervVZqKhbDS6Z+QSLyFJwbMsE/3EQGzb+imOSdTiM/peQCHiGUam/Kd9E+VbeV4Zi3PD4UopMdOPQQGn49ZxlXXbuUUaeVjxs/zpmXobmJleGK3McJQVvJ+RBtR8JjIewQMR3VUFIqNCQyIvlz4NIUXSH4cCJQDenu+vwiz4e6GwuqyZTOfGztM5Bpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mkEUCC88; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mkEUCC88;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gjFH61B06z30FP
	for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Jun 2026 23:12:01 +1000 (AEST)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2c6fcfcdb2bso21288875ad.1
        for <linux-aspeed@lists.ozlabs.org>; Sat, 20 Jun 2026 06:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781961118; x=1782565918; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1gzIf8fgHb7Ze/dJb/40ZOzqNvNSD6l3yJqC/XWnEI=;
        b=mkEUCC88vWuyh57S0ekWtH1NkgBBmdB/hik9tl9zyoV9V2zKi+f3Yst2VPKJQ1lk3B
         Ek5n97dB/zjIqw56SqxNTGLPRb/R5Xf0+T7DNAeSPUKW6aIyiDX2x5floHTbKFAxV7A+
         Cl4S5nTSpSqnj4Ju6UtSi9Ylbd6IllMg6myE9iObWtJxNEmDsjEohgykMTdzUnxiyRzm
         cRed6mgDI1M9wwyKsHz8VhkH94WtpVQhLBKPQQ7Id0gKJaYd4AtE5Xb+UQb0jDgXWcoZ
         2ytsk6XdCNZb7VPO3aeN1ObC77gv5vvCqyaJKINm3n/6Pdm1TztnHZKDx3epDJJ7Rr0H
         EV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781961118; x=1782565918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f1gzIf8fgHb7Ze/dJb/40ZOzqNvNSD6l3yJqC/XWnEI=;
        b=sWDRWw7obYK2yC6l48SXRqmePgIlLR8RREFLambbufyDC5dZ/iWXubvE/Ffz1SfGaA
         57b9A3AzxRitw0RUZhfLtltpy9BWAoNa6r5Q3Gd/CojrQCJy9NULnZPHDJPNDGzH2tVu
         3asW8ThR+h4UOpaMNlS+KxBz6K1wHW2rAOE0PL9UD9Nu7KtgBnNZWkCviNik6rIgN0c2
         /e3ZBH6F/JkIvWzsuu2Ttpwz0FhkG+KZ3MD1V4AL8VwCu3OqbvExlpyxubu9mrFrol/S
         9XBjMJJ95gFY1oZl8tcWVYFzvKfxQaDVmkBi1Yraay0ZtyJb5cQ9+7TNsYYsDCX4Ve92
         i76g==
X-Forwarded-Encrypted: i=1; AFNElJ/Y3rq4LRdZ5cUGK2EV4O9ujmXq048lge9h8yAbsYEoUsIe8kJGMnyFcYPsNRsmKGWHq3m/SLHZ2iEJM/Y=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx00YVQcnDB9uFZ+NV/+I4sjlKVt/TBNx9Pq7zgOv4fDER8svuE
	vZ3+PBLl1QtJS3ZrEP2g5zBr4ye5qitzmrCaaC0sXPtZ2xILTnJg1meB
X-Gm-Gg: AfdE7cme3qqUfRBU2lKALB4QfbkurULPy3DZcGk1ILSX/ccAgyeeV5MYVc+rT1UgXjH
	q7xoQXiZMqDYgRkiMlL0lCV6EetDntqlx8FS8KxqK7AFoJwicdE0FrwbKn7/6/PEPHJaDUWFdvi
	LxM/1MiJq4kpBdOYdBd2XzPR9jPxonLTBcVu1hS5CKugR1Hq5D/X8yHjOELxJ2Usc218EeNd9fO
	a0Xkp0hsdrCTfU9I7b8SVwZN14516PmP4yd7mDqgRG+z/vlII6wSfPA78tL5PMG3iata6/RXdnq
	JmsQEKHjxxQM8zV+RNHlwN7v3daOD3C6CZfFRBk0rERMFf6UXxxxl8T1sOvQQxtwoDrWRijcNq8
	8++dyPMTv128A7cbUj4ncrzbQ3SiwECU8+B3OFiMAyHRFVuuJvgJIe/L7RLeoNzgJaN9w7MIExj
	oFxMDbJC4uD+Zqj1A1HT+Q3rYA5QpFjJUaZxT8x/bxm/xV7g==
X-Received: by 2002:a17:903:234c:b0:2bf:356f:4e0c with SMTP id d9443c01a7336-2c725ba685amr74009065ad.1.1781961118146;
        Sat, 20 Jun 2026 06:11:58 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.202.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c743bfea46sm23206645ad.69.2026.06.20.06.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 06:11:57 -0700 (PDT)
From: Karthikeyan KS <karthiproffesional@gmail.com>
To: andrew@codeconstruct.com.au
Cc: joel@jms.id.au,
	andrew@aj.id.au,
	Kees Cook <kees@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v6] soc: aspeed: lpc-snoop: Fix usercopy overflow in snoop_file_read
Date: Sat, 20 Jun 2026 13:11:50 +0000
Message-ID: <20260620131150.184838-1-karthiproffesional@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
References: <033f2657ae6a94ad13d22f717a2900afb75d892d.camel@codeconstruct.com.au>
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

On Wed, 2026-06-17 at 13:10 +0000, Andrew Jeffery wrote:
> Can you confirm you have tested on hardware a backport of this
> patch to your BSP kernel?

Not until yesterday, done now. Backported the fix to
the BSP kernel (5.4.x) on the AST2600 BMC where the original failure
was observed. Tested under continuous host reboot cycles with concurrent
userspace reads on /dev/aspeed-lpc-snoop0. no panic, no usercopy
splat. Same workload on the unpatched BSP reproduced reliably.

Thanks,
Karthikeyan

