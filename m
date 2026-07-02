Return-Path: <linux-aspeed+bounces-4334-linux-aspeed=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AAEC43458
	for <linux-aspeed@archiver.kernel.org>; Thu,  2 Jul 2026 23:38:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grtc60vPmz2ySS;
	Fri, 03 Jul 2026 09:38:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783013762;
	cv=none; b=JTrJJNkIvj9g95Rn/KnXYsHueziXgvadnAkZAApMEbs7BoK7VVZz1gZ+vvMYQDPfbOwl0qEjc+aPkc9OXcnFQ0M6NsSguRIHb870TSBKGwSX/PHUuhkB67owwoAy/KX96JueOvpMwCX37x4UNNGg2jQQvExuPBl1Er89um0weR2JG7zlmD24YiwtTF7Dkz7aU7yN0YbHg4JLnP1ueiVbj4RBcCFyG928DJ85jxC1ACoEzelB1DyKGXZ4G8FbNZdRZi8j60PQU9ZnoTvcVdH/Ps6mUuhbIbSu91Q5mosyXL92/12kDJSqVaq5YMeVhAd3EQXZUyDr4JlxfytC7f+Peg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783013762; c=relaxed/relaxed;
	bh=I1eeHpCHy2amylD5gAFQ/G5VWDnH0phiGEsKBXqG2BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jDQGVDPGYdYOZPZ8KjRLTvVdlRGTiPSnFDqwRgIa7L0xpZGNFxrE/8PAPfrh+9rIwN445mizi5gH5WBc9zEaG+Q+VlWqwnLrb09BSAPs0xYibUpbHE2R/PWBtXLA/WnSrpda2NYCKJ+z+9cX6OJrFPG/ueZub6MwP3OpqmnmMfW78/PJG6RAIlEbeztWe9YpUxVuPKaoytbm/0XTSuQdAXdjQDMJ3vUgNjZ7VzUY8pb9rS7qMRxzeSUQ6f9SZzIH5t7yTynhEGwD8bxQf6nTot0r6vsh6IqFcRaUBifypFI02tzFXC1Nl2mMi8Gzp8C4pu9XMCh+Y9GFrWfeQFbrXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qMWILLko; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qMWILLko;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=karthiproffesional@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grkZ92WHfz2xYg
	for <linux-aspeed@lists.ozlabs.org>; Fri, 03 Jul 2026 03:36:00 +1000 (AEST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-381065a7a03so519397a91.0
        for <linux-aspeed@lists.ozlabs.org>; Thu, 02 Jul 2026 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783013759; x=1783618559; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1eeHpCHy2amylD5gAFQ/G5VWDnH0phiGEsKBXqG2BM=;
        b=qMWILLkosqsWIk3f22idUEOZEFiP8v4JEnPh+7CVwD1zwxHn4fYpJtRhjPJWXnmuHp
         EcekmTpBL02W7DeEoh/CvBrkTu19pRsM7JxYQTE5nknKnShY3XK/gDi7TNYV5fij2fON
         bM4EYCuR5y36HbMYpRZYJQhdcGL6GQmLHioOxIUBmMYhkvfbgNXhDh3doQ5exfPLsjP+
         wdNNErD8w1biRmQr5W+S+Wm3ftD6C07jtN8CGGkYFBVt85uDTCjde8au2hxLgzISh1iY
         +N+e8tDkQYrJeNcQ4F02IV+ceOhvhBVm5uprBgcxQLhg7VCbzNHNN0jnSR2YPHPProhy
         6Qjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783013759; x=1783618559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I1eeHpCHy2amylD5gAFQ/G5VWDnH0phiGEsKBXqG2BM=;
        b=MpNF4WCddrar/m+GFFm3gmkpyC/KZp8e4xEhHBuMbQLt2O3kR3uafYoKZEQ++f53kY
         l7HC/o8/FTktdWsYkVbenlRrAX1Vq+L3reOAb6TKgOFlLBdX1ZqK6JfUZK7Vp0PP2M6I
         SETdex0kV7UHSP3UA/S/6CHc6QnzXOOh4ueWp8Pw+wWYZTODCyBafI8+h07x3Hu3oaI6
         18JYH4xvVdLCkQ2z8MnDJhpnGfTKna0YZFe07LxesO0W5xvkTE50eTIvANL3adZQv+mb
         V55+MqAwJUdxvwHh7X/waCQjP3AOwgHgOwOtlSIBaZN3A2Zst3JdnYtS1Kh/gWn5O2jS
         lgJA==
X-Forwarded-Encrypted: i=1; AHgh+RpEBLQ50Jvo4tTJE64gDE/Ro5BIdptBquZxB8crntWsbxRGkE20szx85UQKMQJSBlvBjBNPLx5KCaWFMzg=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyyYSr21yV/hBNItHmCmQpybinuE2IK4Z7WUHKMh1iU4okDbXDJ
	dI+8TuXgxJJIX06gc+oLwkseeqhn3xWLAD+rjoSMw6Lr3g4pfujC8LYE
X-Gm-Gg: AfdE7ck+AI+B79IX0xecA2v4Ey3xamUf+JnE50Xlkvwzl3rTXe/y5hTZFuXRe5isy38
	0RgrtvH99mi3AiC/miqWNWrY4ODPCv+VxC4/IEujHSMo9FXpGQIONP1c2R0Lsoh8UNcvg62jGrR
	VXDWoMBvMbsT0kZSyWq3VRl0gEfuh7iQwvcbddJmLp/6FFqZK8M6+8uLLsazEyEm8VMz/w0Kfu1
	ClBsTzcIuuiirRICzYcWZETjqjlhFFBYAx4butr89fY1Yf2ITsMFcAQy8Bwt+L2R6PaUS4BfloU
	JRonImUq+iDwuo1OHKQof9QLfWadaP9qUBFY1cIMunq0EWW78pafGBxnyeD61DCv1z+mZ+J80Pw
	3kN4p38L4bCeZPojk7Dr+8mOYzWpGT6DKQ+L4cxkgVaUOh28aBTgCTiMB+8lU7w8EfRbvxg14Jj
	HcUnKM+KFPYF1C4SVlf1zJmkm7KyDUcCBUB2OkQz+wBp1DUECjfWnoObQ=
X-Received: by 2002:a17:90b:41:b0:372:b4a1:21d8 with SMTP id 98e67ed59e1d1-380aa0f43d6mr7412581a91.13.1783013758621;
        Thu, 02 Jul 2026 10:35:58 -0700 (PDT)
Received: from LAPTOP-97G9G880.domain.name ([106.222.201.11])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b813cd9sm10870313eec.8.2026.07.02.10.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 10:35:58 -0700 (PDT)
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
Date: Thu,  2 Jul 2026 17:35:50 +0000
Message-ID: <20260702173550.10779-1-karthiproffesional@gmail.com>
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

Hi Andrew,

Thanks for your consistent support and guidance.
I learned a lot from you.
Much Appreciated.

Thanks,
Karthikeyan

